import ceylon.net.httpd { Httpd, WebEndpointConfig, newHttpdInstance = newInstance }

doc "Run the module `ceylon.demo.net`."
shared void run() {
	Httpd httpd = newHttpdInstance();
	httpd.addWebEndpointConfig(WebEndpointConfig("/path", "ceylon.demo.net", "ceylon.demo.net.Web", "0.3.3"));
	httpd.addWebEndpointConfig(WebEndpointConfig("/async", "ceylon.demo.net", "ceylon.demo.net.WebAsync", "0.3.3"));
	
	value filesConfig = WebEndpointConfig("/file", "ceylon.net", "ceylon.net.httpd.endpoints.StaticFileEndpoint", "0.3.3");	
	filesConfig.addParameter("filesDir", "/home/matej/temp/1__ulpload-test/");
	httpd.addWebEndpointConfig(filesConfig);
	
	httpd.start();

}