chrome.runtime.onMessage.addListener (
  function (request, sender, sendResponse) {
    if (request.command == "getGeolocation") {

      navigator.geolocation.getCurrentPosition (function (position) {
          sendResponse (position);
        } );
      return true; // Needed because the response is asynchronous
    }
  }
);

