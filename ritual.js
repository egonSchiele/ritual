function postToUrl(url, data) {
  var http = null;
  http = new XMLHttpRequest();
  http.open("POST", url, false);
  http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  http.setRequestHeader("Content-length", data.length);
  http.setRequestHeader("Connection", "close");
  http.send(data);
  return http.responseText;
}

chrome.runtime.sendMessage ( {command: "getGeolocation"}, function (position) {
    var url = "http://localhost:4567/add";
    var data = "url="        + encodeURIComponent(document.URL) +
               "&contents="  + encodeURIComponent(document.getElementsByTagName("html")[0].innerHTML) +
               "&latitude="  + encodeURIComponent(position.coords.latitude) +
               "&longitude=" + encodeURIComponent(position.coords.longitude);
    postToUrl(url, data);
  });
