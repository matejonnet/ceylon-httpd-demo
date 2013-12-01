import ceylon.net.http.server {
    newServer, AsynchronousEndpoint, endsWith, Request
}
import ceylon.net.http.server.endpoints { serveStaticFile, Options }

shared void fileDownload() {
    print("File server");
    newServer { 
        AsynchronousEndpoint {
            //service => serveStaticFile (
            //    "/home/matej/temp/1__ulpload-test/",
            //    (Request request) {return request.path;},
            //    EndpointOptions { outputBufferSize = 1; }
            //);
            service => serveStaticFile (
                "/home/matej/temp/1__ulpload-test/"
            );
            path = endsWith(".jpg") or endsWith(".txt");
        }
    }.start();
}
