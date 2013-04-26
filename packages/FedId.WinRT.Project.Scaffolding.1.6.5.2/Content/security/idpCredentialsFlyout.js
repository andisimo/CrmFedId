//// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
//// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
//// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
//// PARTICULAR PURPOSE.
////
//// Copyright (c) Microsoft Corporation. All rights reserved

(function () {
    "use strict";
    var page = WinJS.UI.Pages.define("/security/idpCredentialsFlyout.html", {

        ready: function (element, options) {
            WinJS.log & WinJS.log("idp credentials flyout ready event", "myapp", "info");

            // Register the handlers for dismissal
            document.getElementById("settingsFlyoutDiv").addEventListener("keydown", handleAltLeftAndEnter);
            document.getElementById("settingsFlyoutDiv").addEventListener("keypress", handleBackspace);
            //document.getElementById("signInButton").addEventListener("click", signIn);
            document.getElementById("signInInput").addEventListener("click", signIn);
            document.getElementById("usernameInput").addEventListener("focus", clearUsernameInputDefaultText);

            var FedId = Microsoft.IT.Core.Security.FedId.instance;
            document.getElementById("signInUrl").textContent = FedId.signInSettings.url;
            if (FedId.signInSettings.wsTrustUsername) {
                document.getElementById("usernameInput").value = FedId.signInSettings.wsTrustUsername;
            } else {
                // Sets default text and apply gray color in foreground when flyout is shown to user 
                document.getElementById("usernameInput").value = "username@domain.com";
                document.getElementById("usernameInput").style.color = "gray";
            }
            //document.getElementById("passwordInput").value = FedId.signInSettings.wsTrustPassword;  // not exposed
            //document.getElementById("kmsiInput").checked = FedId.signInSettings.wsTrustKmsi;  // not exposed
        },

        unload: function () {
            WinJS.log & WinJS.log("idp credentials flyout unload event", "myapp", "info");

            // Remove the handlers for dismissal
            document.getElementById("settingsFlyoutDiv").removeEventListener("keydown", handleAltLeft);
            document.getElementById("settingsFlyoutDiv").removeEventListener("keypress", handleBackspace);

            // TODO: if we arrived hear because of light dismiss throw up popup message dialog letting user know that credentials are required
            // in order for app to proceed and then reissue FedId.SignIn() call
            var FedId = Microsoft.IT.Core.Security.FedId.instance;
            FedId.signIn(FedId.signInSettings.url);
        },
    });

    function handleAltLeftAndEnter(evt) {
        // Handles Alt+Left in the control and dismisses it 
        if (evt.altKey && evt.key === 'Left') {
            WinJS.UI.SettingsFlyout.show();
        }

        // Handles enter key and execute sign-in method
        if (evt.key === 'Enter') {
            signIn();
        }
    };

    function handleBackspace(evt) {  // Handles the backspace key or alt left arrow in the control and dismisses it
        if (evt.key === 'Backspace') {
            WinJS.UI.SettingsFlyout.show();
        }
    };

    function clearUsernameInputDefaultText() { // Clears default text in username input text box and sets foreground color to black
        if (document.getElementById("usernameInput").value == "username@domain.com") {
            document.getElementById("usernameInput").value = "";
            document.getElementById("usernameInput").style.color = "black";
        }
    };

    function signIn() {

        var username = document.getElementById("usernameInput").value;
        var password = document.getElementById("passwordInput").value;
        var kmsi = document.getElementById("kmsiInput").checked;
        
        if (username || password) {
            HideErrorMessage();
            ShowProgressBar();

            var FedId = Microsoft.IT.Core.Security.FedId.instance;
            FedId.setWsTrustCredentials(username, password, kmsi);

            // reissue signin call now that credentials have been collected
            //var pmd = new Windows.UI.Popups.MessageDialog("Signing you in using provided credentials this can take 5 - 10 seconds to complete."); pmd.showAsync();
            FedId.signInAsync(FedId.signInSettings.url).then(
                function (result) {
                    HideProgressBar();
                    if (result == true) {  /* signin succeeded */
                        settingsFlyoutDiv.winControl.hide();
                        viewModel.initCurrentView();
                    } else {  /* signin was cancelled by user or failed */
                        ShowErrorMessage();
                    }
                },
                function (error) {
                    if (error != null) {
                        var message = error.message;
                        HideProgressBar();
                        ShowErrorMessage();
                    }
                });
        } else {
            ShowErrorMessage();
        }

        //WinJS.UI.SettingsFlyout.show();  // this dismisses custom settings flyout but brings up win+i settings flyout pane
        //document.getElementById("settingsFlyoutDiv").winControl.hide();

    }

    // Hide progress bar
    function HideProgressBar() {
        document.getElementById("LoadingProgressBar").setAttribute("style", "display:none");
    }

    // Show progress bar
    function ShowProgressBar() {
        document.getElementById("LoadingProgressBar").setAttribute("style", "display:block");
    }

    // Show error message 
    function ShowErrorMessage() {
        document.getElementById("LblErrorMessage").setAttribute("style", "display:block");
    }

    // Hide error message
    function HideErrorMessage() {
        document.getElementById("LblErrorMessage").setAttribute("style", "display:none");
    }
})();

