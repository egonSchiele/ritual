function postToUrl(url)
{
  var xmlHttp = null;
  xmlHttp = new XMLHttpRequest();
  xmlHttp.open("POST", url, false);
  xmlHttp.send(null);
  return xmlHttp.responseText;
}

var url = "http://www.adit.io:4567/add?url=" + encodeURIComponent(document.URL) + "&contents=" + document.getElementsByTagName("html")[0].innerHTML;
postToUrl(url);
