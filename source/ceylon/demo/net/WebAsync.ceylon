import ceylon.net.httpd { HttpResponse, HttpRequest, WebEndpointAsync, WebEndpointConfig, HttpCompletionHandler }

shared class WebAsync() satisfies WebEndpointAsync {

	shared actual void init(WebEndpointConfig endpointConfig) {}
	
	shared actual void service(HttpRequest request, HttpResponse response, HttpCompletionHandler completionHandler) {
		value url = request.uri();
		response.addHeader("content-type", "text/html");
		response.writeString("Hello from ASYNC ceylon web app. <br />\nRequested url: " url "<br />\n");
		response.writeString("TS: " process.milliseconds "");
		
		completionHandler.handleComplete();
	}
	
}