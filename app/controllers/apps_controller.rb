class AppsController < ApplicationController
  def index
    html = <<-HTML
      <html>
        <body>
          <button id="github_button">Log In with GitHub</button>
          <script>
            document.getElementById('github_button').addEventListener('click', function(){
              var githubUri = "https://github.com/login/oauth/authorize" +
            '?client_id=#{Glazier::ApiCredentials::GITHUB_CLIENT_ID}&scope=gist'
              window.open(githubUri, "authwindow", "menubar=0,resizable=1,width=960,height=410");
              return false;
            });
            window.addEventListener("message", function(event) {
              // TODO: hostname should be environment-specific
              if (event.origin == "http://localhost:3040") {
                var authCode = event.data;
                console.log("we got a code" + authCode);
                var accessToken = null;

                function reqListener() {
                  if (oReq.readyState == 4) {
                    accessToken = oReq.responseText;
                    console.log("My access token is ", accessToken);
                  }
                };

                var oReq = new XMLHttpRequest();
                oReq.onload = reqListener;
                // TODO: hostname should be environment-specific
                oReq.open("post", "http://localhost:3040/oauth/github/exchange?code=" + authCode, true);
                oReq.send();
              } else {
                console.log("got unknown message", event);
              }
            });
          </script>
        </body>
      </html>
    HTML
    render text: html, content_type: 'text/html'
  end
end
