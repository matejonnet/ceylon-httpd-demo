import ceylon.html {
    Html,
    html5,
    Head,
    Body,
    Div, Doctype
}
import ceylon.html.serializer {
    NodeSerializer
}
import ceylon.net.http.server {
    Endpoint,
    startsWith,
    Response,
    Request, newServer
}
import ceylon.time {
    Date,
    today
}

Date date = today();

Html html = Html { 
    html5;
    Head("Hello");
    Body {
        Div("Hello world!"),
        Div("Today is ``date.dayOfWeek``.")
    };
};

shared void runGavinsDemo() {
    print("Running the server");
    newServer { 
        Endpoint { 
            path=startsWith("/"); 
            void service(Request request, Response response) {
                NodeSerializer(response.writeString).serialize(html);
                //response.writeString(html.string);
            }
        }
    }.start();
}
