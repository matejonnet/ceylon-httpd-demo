import ceylon.net.httpd { Server, newInstance, WebEndpointAsync, WebEndpoint, HttpRequest, HttpResponse, CompletionHandler}
import ceylon.net.httpd.endpoints { StaticFileEndpoint }

doc "Run the module `ceylon.demo.net`."
by "Matej Lazar"

String prop_httpd_bind_port = "httpd.bind.port";
String prop_httpd_bind_host = "httpd.bind.host";

shared void run() {
    
    print("Vm version: " + process.vmVersion);
    
    Server server = newInstance();
    
    StaticFileEndpoint staticFileEndpoint = StaticFileEndpoint();
    staticFileEndpoint.externalPath = "/home/matej/temp/1__ulpload-test/";
    server.addWebEndpoint(WebEndpointAsync {
        service => staticFileEndpoint.service;
        path = "/file";
    });
    
    server.addWebEndpoint(WebEndpoint {
        service => Web().service;
        path = "/post";
    });
    
    void asyncInvocation(HttpRequest request, HttpResponse response, CompletionHandler completionHandler) {
        Web().service(request, response);
        completionHandler.handleComplete();
    }
             
    server.addWebEndpoint(WebEndpointAsync {
            path = "/async";
            service => asyncInvocation;
        }
    );

    variable Integer port = 8080;
    if (exists portStr = process.propertyValue(prop_httpd_bind_port)) {
        if (exists p = parseInteger(portStr)) {
            port = p;
        }
    }

    variable String host = "127.0.0.1";
    if (exists h = process.propertyValue(prop_httpd_bind_host)) {
        host = h;
    }
    
    server.start(port, host);
}

