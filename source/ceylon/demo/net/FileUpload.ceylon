import ceylon.net.http.server {
    Endpoint,
    startsWith,
    Response,
    Request, UploadedFile, newServer
}
import ceylon.file { Path, parsePath }
import ceylon.io { newOpenFile }
import ceylon.io.buffer { ByteBuffer }

shared void fileUploadDemo() {
    print("Running the server");
    newServer { 
        Endpoint { 
            path=startsWith("/"); 
            void service(Request request, Response response) {
                print("Handling request ...");
                UploadedFile? file = request.file { name = "myfile"; };
                if (exists file) {
                    Path sourcePath = file.file;
                    Path destinationPath = parsePath("/tmp/ceylon-upload-``system.milliseconds``-``file.fileName``");

                    value source = newOpenFile(sourcePath.resource);
                    value destination = newOpenFile(destinationPath.resource);
                    
                    
                    source.readFully { void consume(ByteBuffer buffer) {
                        destination.write(buffer);
                    } };
                    
                    source.close();
                    destination.close();
                    
                    response.writeString("File uploaded!");
                    response.writeString(destinationPath.string);
                } else {
                    response.writeString("Not a file.");
                }
                print("Response done.");
            }
        }
    }.start();
}
