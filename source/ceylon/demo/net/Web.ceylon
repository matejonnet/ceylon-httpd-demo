import ceylon.net.httpd { WebEndpoint, HttpResponse, HttpRequest, WebEndpointConfig }
shared class Web() satisfies WebEndpoint {
	
	shared actual void init(WebEndpointConfig endpointConfig) {}
	
	shared actual void service(HttpRequest request, HttpResponse response) {
		value url = request.uri();
		response.addHeader("content-type", "text/html");
		response.writeString("Hello from ceylon web app. <br />\nRequested url: " url "<br />\n");
		response.writeString("TS: " process.milliseconds "");
		
	}

	
	
}