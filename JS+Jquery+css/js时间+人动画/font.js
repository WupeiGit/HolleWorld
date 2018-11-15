var _agent = navigator.userAgent.toLowerCase();

var _win = (_agent.indexOf('win') != -1);
var _mac = (_agent.indexOf('mac') != -1);

if(_win){
 document.write('<link rel="stylesheet" href="css/win.css" type="text/css">');
}
else if(_mac){
 document.write('<link rel="stylesheet" href="css/mac.css" type="text/css">');
}