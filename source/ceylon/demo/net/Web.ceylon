import ceylon.net.httpd { WebEndpoint, HttpResponse, HttpRequest, WebEndpointConfig}
shared class Web() extends WebBase() satisfies WebEndpoint {

	shared actual void init(WebEndpointConfig endpointConfig) {}
	
	shared actual void service(HttpRequest request, HttpResponse response) {
		testOperations(request, response);
	}

	
	
}