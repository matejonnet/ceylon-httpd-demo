import ceylon.net.http.server.endpoints { serveStaticFile }
import ceylon.net.http.server { Server, createServer, AsynchronousEndpoint, startsWith, Request, Response, Endpoint, endsWith }
//import org.jboss.logging { Logger {logger = getLogger}}
//import org.jboss.logmanager { LogManager = Logger {manager = getLogger}, Level { trace = TRACE, debug = DEBUG }}
//import org.jboss.logmanager.handlers { ConsoleHandler }
//import java.util.logging { SimpleFormatter }



"Run the module `ceylon.demo.net`."
by("Matej Lazar")

String prop_httpd_bind_port = "httpd.bind.port";
String prop_httpd_bind_host = "httpd.bind.host";

shared void run() {
    
       //-Djava.util.logging.manager=org.jboss.logmanager.LogManager
       //export JAVA_OPTS="-Djava.util.logging.manager=org.jboss.logmanager.LogManager"

//    LogManager logManager = manager("org.xnio.nio");
//    print(logManager.level);
//
//    logManager.setLevelName("DEBUG");
//    logManager.level = debug;
//    
//    ConsoleHandler ch = ConsoleHandler();
//    ch.formatter = SimpleFormatter();
//    
//    logManager.addHandler(ch);
//    
//    print(logManager.level);
//    
//    LogManager utManager = manager("io.undertow");
//    utManager.setLevelName("DEBUG");
//    utManager.level = debug;
//    utManager.addHandler(ch);
//    
//    print(logManager.level);
//    
//
//    Logger log = logger("org.xnio.nio");
//    log.debug("Debug mesage");
//    log.info("Info mesage");
    
    
    Server server = createServer {};
    
    server.addEndpoint(AsynchronousEndpoint {
        service => serveStaticFile("/home/matej/temp/1__ulpload-test/");
        path = endsWith(".html") 
               or endsWith(".txt")
               or endsWith(".txt")
               or endsWith(".tiff")
               or endsWith(".jpg");
    });
    
    server.addEndpoint(Endpoint {
        service => Web().service;
        path = startsWith("/post");
    });
    
    void asyncInvocation(Request request, Response response, Callable<Anything, []> complete) {
        Web().service(request, response);
        complete();
    }
             
    server.addEndpoint(AsynchronousEndpoint {
            path = startsWith("/async");
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

