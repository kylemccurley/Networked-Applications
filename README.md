<h1>Networked Applications Course</h1>
<ul>
  <li> Sinatra is a small web framework.</li>
  <li> HTTP requests are handled in Sinatra by creating routes for a path or set of paths.</li>
  <li> Routes are created using methods named after the HTTP method to be handled. So, a GET request is handled by a route defined using the get Sinatra method. </li>
  <li>View templates can be written in many templating languages, such as ERB. They provide a place to define the HTML display of a response outside of the route handling it. Templating languages are usually better suited to describing HTML than plain Ruby.</li>
  <li>A layout is a view template that surrounds a specific response's template. They are used to provide shared HTML that is used by all views, and often include links to stylesheets and JavaScript files.</li>
  <li>Routes can specify parameters by using colon followed by the parameter name: /chapters/:number. In this case, the value would be accessible within the route using params[:number].</li>
  <li>Code placed in a before block is executed before the matching route for every request.</li>
  <li>View helpers are Ruby methods that are used to minimize the amount of Ruby code included in a view template. These methods are defined within a helpers block in Sinatra.</li>
  <li>A user can be sent to a new location in response to a request with redirection. This is done in Sinatra using the redirect method.</li>
  <li>The redirection is accomplished by setting the Location header in the response. The client looks at the URL in the location header and sends out a new HTTP GET request for the associated resource, which in turn navigates the client to that new location.</li>
  <li>The files in a project can be identified as either server-side or client-side code based on where they will be evaluated.</li>
</ul>

<h2>Notes</h2>
<ul>
  <li>View Helpers are called when the page is rendered, not when user actions are performed on page elements.</li>
  <li>The `redirect` method, when called from a routing-block, tells Sinatra to stop processing, and issues a GET request.</li>
</ul>
