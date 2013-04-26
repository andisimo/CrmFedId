//// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
//// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
//// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
//// PARTICULAR PURPOSE.
////
//// Copyright (c) Microsoft Corporation. All rights reserved

(function () {
    "use strict";

    var FedId = Microsoft.IT.Core.Security.FedId.instance;
    // we cannot bind list directly to winrt returned objects, for more info see 
    // http://social.msdn.microsoft.com/forums/en-us/winappswithhtml5/thread/38387326-8d81-48d1-8f85-023b9ebf2382
    var identityProvidersArray = [];
    var numberOfIdentityProviders = FedId.signInSettings.acsNamespaceIdps.length;
    for (var idp = 0; idp < numberOfIdentityProviders; idp++) {
        var identityProvider = {
            name: FedId.signInSettings.acsNamespaceIdps[idp].name,
            loginUrl: FedId.signInSettings.acsNamespaceIdps[idp].loginUrl,
            logoutUrl: FedId.signInSettings.acsNamespaceIdps[idp].logoutUrl
        };
        identityProvidersArray.push(identityProvider);
    }

    var identityProviderList = new WinJS.Binding.List(identityProvidersArray);

    var selectedIdentityProviders = { itemList: identityProviderList };

    WinJS.Namespace.define("ACSIdentityProviders", selectedIdentityProviders);

    var page = WinJS.UI.Pages.define("/security/idpSelectionFlyout.html", {

        ready: function (element, options) {
            // Register the handlers for dismissal
            document.getElementById("settingsFlyoutDiv").addEventListener("keydown", handleAltLeft);
            document.getElementById("settingsFlyoutDiv").addEventListener("keypress", handleBackspace);

            // gather user identity provider selection input, apply to FedId.signInSettings.acsIdentityProviderUrl + .acsIdentityProviderSignOutUrl,
            // reissue call to to FedId.SignInAsync(), and close flyout
            var listView = element.querySelector('#IdentityProvidersListView').winControl;
            listView.forceLayout();

            function itemInvokedHandler(eventObject) {
                ShowProgressBar();
                HideErrorMessage();
                eventObject.detail.itemPromise.done(function (invokedItem) {
                    FedId.signInSettings.acsIdentityProviderUrl = invokedItem.data.loginUrl;
                    FedId.signInSettings.acsIdentityProviderSignOutUrl = invokedItem.data.logoutUrl;
                    FedId.signInAsync(FedId.signInSettings.url).then(
                    function (result) {
                        if (result == true) {  /* signin succeeded */
                            //settingsFlyoutDiv.winControl.hide();
                            viewModel.initCurrentView();
                        } else {  /* signin was cancelled by user or failed */
                            HideProgressBar();
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

                    // Access item data from the itemPromise
                    WinJS.log && WinJS.log("The name of ACS identity provider:" + invokedItem.data.name + " and login url:"
                        + invokedItem.data.loginUrl + " and logout url: "
                        + invokedItem.data.logoutUrl);
                });
            }
            listView.addEventListener("iteminvoked", itemInvokedHandler, false);

            WinJS.log & WinJS.log("idp selection flyout ready event", "myapp", "info");
        },

        unload: function () {
            WinJS.log & WinJS.log("idp selection flyout unload event", "myapp", "info");

            // Remove the handlers for dismissal
            document.getElementById("settingsFlyoutDiv").removeEventListener("keydown", handleAltLeft);
            document.getElementById("settingsFlyoutDiv").removeEventListener("keypress", handleBackspace);

            // TODO: if we arrived hear because of light dismiss throw up popup message dialog letting user know that idp selection is required
            // in order for app to proceed and then reissue FedId.SignIn() call
            var FedId = Microsoft.IT.Core.Security.FedId.instance;
            FedId.signIn(FedId.signInSettings.url);
        },
    });

    function handleAltLeft(evt) {  // Handles Alt+Left in the control and dismisses it
        if (evt.altKey && evt.key === 'Left') {
            WinJS.UI.SettingsFlyout.show();
        }
    };

    function handleBackspace(evt) {  // Handles the backspace key or alt left arrow in the control and dismisses it
        if (evt.key === 'Backspace') {
            WinJS.UI.SettingsFlyout.show();
        }
    };

    // Hides progress bar
    function HideProgressBar() {
        var loadingProgressBar = document.getElementById("LoadingProgressBar");
        if (loadingProgressBar) {
            loadingProgressBar.setAttribute("style", "visibility:hidden");
        }
    }

    // Shows progress bar
    function ShowProgressBar() {
        var loadingProgressBar = document.getElementById("LoadingProgressBar");
        if (loadingProgressBar) {
            loadingProgressBar.setAttribute("style", "visibility:visible");
            loadingProgressBar.setAttribute("style", "width: 500px");
        }
    }

    // Shows error message 
    function ShowErrorMessage() {
        var errorMessageLable = document.getElementById("LblErrorMessage");
        if (errorMessageLable) {
            LblErrorMessage.setAttribute("style", "display:block");
        }
    }

    // Hides error message
    function HideErrorMessage() {
        var errorMessageLable = document.getElementById("LblErrorMessage");
        if (errorMessageLable) {
            LblErrorMessage.setAttribute("style", "display:none");
        }
    }

})();

