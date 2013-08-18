function httpGet(url)
{
  var xmlHttp = null;
  xmlHttp = new XMLHttpRequest();
  xmlHttp.open("GET", url, false);
  xmlHttp.send(null);
  return xmlHttp.responseText;
}

var url = "http://www.adit.io:4567/add?url=" + encodeURIComponent(document.URL);
httpGet(url);
