# CollegeMapAPI
Version: 0.1 Beta (That means it's not production ready).

This API allows for directions between buildings on the RIT Campus. It also has the built in functionality of finding the building closest to a coordinate. All requests are to be made to http://ritmap.jspann.me .
### iOS Example
**NOTE** POST requests are (for some reason) returning 500 Server Error every other request. It might be on Google's end but I am actively looking into it

Look in the "Examples" folder.

### Web Example
Coming Soon!

### cURL Example
#### Get closest building from coordinates:
	curl -H "Content-Type: application/json" -X POST -d '{"type":"getclosestnode","lat":43.084827,"lon":-77.667900}' http://ritmap.jspann.me

#### Basic Directions:
	curl -H "Content-Type: application/json" -X POST -d '{"type":"getdirections","from":"NRH","to":"KGH"}' http://ritmap.jspann.me


#### Basic Hello:
	curl -H "Content-Type: application/json" -X POST -d '{"type":"hello"}' http://ritmap.jspann.me
	
