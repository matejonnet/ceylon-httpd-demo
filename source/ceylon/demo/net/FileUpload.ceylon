
import ceylon.net.http.server {
    createServer,
    Endpoint,
    startsWith,
    Response,
    Request, UploadedFile
}
import ceylon.file { Path, parsePath }
import ceylon.io { newOpenFile }
import ceylon.io.buffer { ByteBuffer }


shared void fileUploadDemo() {
    print("Running the server");
    createServer { 
        Endpoint { 
            path=startsWith("/"); 
            void service(Request request, Response response) {
                print("Handling response...");
                value file = request.parameter { name = "myfile"; };
                if (is UploadedFile file) {
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
                } else {
                    response.writeString("Not a file.");
                }
                print("Response done.");
            }
        }
    }.start();
}
