import ceylon.net.http.server {
    newServer, AsynchronousEndpoint, endsWith
}
import ceylon.net.http.server.endpoints { serveStaticFile }

shared void fileDownload() {
    print("File server");
    newServer { 
        AsynchronousEndpoint {
            service => serveStaticFile("/home/matej/temp/1__ulpload-test/");
            path = endsWith(".jpg");
        }
    }.start();
}
