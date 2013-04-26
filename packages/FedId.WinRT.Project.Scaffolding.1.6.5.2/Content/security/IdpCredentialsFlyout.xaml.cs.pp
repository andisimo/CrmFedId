using Callisto.Controls;
using Microsoft.IT.Core.Security;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// The User Control item template is documented at http://go.microsoft.com/fwlink/?LinkId=234236

namespace $rootnamespace$.Security
{
     public sealed partial class IdpCredentialsFlyout : UserControl
    {
        public IdpCredentialsFlyout()
        {
            this.InitializeComponent();

            this.SignInUrl.Text = FedId.Instance.SignInSettings.Url;
            if (!string.IsNullOrEmpty(FedId.Instance.SignInSettings.WsTrustUsername))
            {
                UsernameInput.Text = FedId.Instance.SignInSettings.WsTrustUsername;
            }
            else
            {
                // Sets default text and foreground color to gray
                UsernameInput.Text = "username@domain.com";
                UsernameInput.Foreground = new SolidColorBrush(Colors.Gray);
            }
            //if (!string.IsNullOrEmpty(FedId.Instance.SignInSettings.WsTrustPassword)) PasswordInput.Password = FedId.Instance.SignInSettings.WsTrustPassword;  // not exposed
            //KmsiInput.IsChecked = FedId.Instance.SignInSettings.WsTrustKmsi;  // not exposed
        }

        private async void SignIn(object sender, RoutedEventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(UsernameInput.Text) || string.IsNullOrEmpty(PasswordInput.Password))
                {
                    this.ShowErrorMessage("Please enter your identity provider credentials.");
                    return;
                }

                var username = UsernameInput.Text;
                var password = PasswordInput.Password;
                var kmsi = (bool)KmsiInput.IsChecked;

                this.HideErrorMessage();
                this.ShowProgressBar();

                FedId.Instance.SetWsTrustCredentials(username, password, kmsi);

                // reissue signin call now that credentials have been collected
                //var pmd = new Windows.UI.Popups.MessageDialog("Signing you in using provided credentials this can take 5 - 10 seconds to complete.");  /* await */ pmd.ShowAsync();
                var result = await FedId.Instance.SignInAsync(FedId.Instance.SignInSettings.Url);

                if (result == true)
                {
// issue callback to main app view telling it that its okay to now initialize and retrieve/show data requiring security token to access
                    //App.ViewModel.InitCurrentView = true;
// NOTE: the above call is only needed for o365 tenant services signin cases, in which case see sample solution download xaml/cs App4 for 
// simple /ViewModels/MainPageViewModel.cs implementation and /App.xaml.cs usage example or more extensive nuget.org "mvvm light" package.
// For other user stories, i.e. azure web role and service bus relay signins, you can just comment line above out to get things to compile.

#if DEBUG
    var rawToken = FedId.Instance.SecurityToken.RawToken;  // if this was not for an orgId or orgId/adfs secured service or service bus endpoint
    var sessionCookieHeader = FedId.Instance.SecurityToken.SessionCookieHeader;  // if this was for an orgId or orgId/adfs secured service
    var claims = FedId.Instance.SecurityToken.Claims;   // if this was not for an orgId or orgId/adfs secured service or service bus endpoint
#endif
                }

                // programmatically dismiss xaml callisto settings flyout when done
                if (this.Parent != null) (this.Parent as SettingsFlyout).IsOpen = false;  // vs SettingsFlyoutDiv.winControl.hide();
                //var parent = VisualTreeHelper.GetParent(this); if (parent != null) (parent as SettingsFlyout).IsOpen = false;
// using linq to visual tree [ http://www.codeproject.com/Articles/63157/Linq-to-Visual-Tree ] open source work
                //using LinqToVisualTree;
                //var parent = VisualTreeHelper.GetParent(this); if (parent != null) (parent as SettingsFlyout).IsOpen = false;
                //(this.Ancestors<SettingsFlyout>().FirstOrDefault() as SettingsFlyout).IsOpen = false;
                //if (this.Parent != null) (this.Parent.Ancestors<SettingsFlyout>().FirstOrDefault() as SettingsFlyout).IsOpen = false;
            }
            catch (Exception exception)
            {
                //TODO: Need to catch every exception and show corresponding message
                //for now i am going to keep general message whenever any exception occurs
                string message = exception.Message;
                FedId.Instance.SetWsTrustCredentials(FedId.Instance.SignInSettings.WsTrustUsername, null, false);
                this.HideProgressBar();
                this.ShowErrorMessage("Please enter your valid identity provider credentials and try again.");
            }
        }

        /// <summary>
        /// Shows progress bar
        /// </summary>
        private void ShowProgressBar()
        {
            this.LoadingProgressBar.IsIndeterminate = true;
            this.LoadingProgressBar.Opacity = 1;
        }

        /// <summary>
        /// Hides loading progress bar
        /// </summary>
        private void HideProgressBar()
        {
            this.LoadingProgressBar.IsIndeterminate = false;
            this.LoadingProgressBar.Opacity = 0;
        }

        /// <summary>
        /// Shows error message
        /// </summary>
        /// <param name="errorMessage"></param>
        private void ShowErrorMessage(string errorMessage)
        {
            this.TxtErrorMessage.Visibility = Visibility.Visible;
            this.TxtErrorMessage.Text = errorMessage;
        }

        /// <summary>
        /// Hides error message
        /// </summary>
        /// <param name="errorMessage"></param>
        private void HideErrorMessage()
        {
            this.TxtErrorMessage.Visibility = Visibility.Collapsed;
            this.TxtErrorMessage.Text = string.Empty;
        }

        /// <summary>
        /// Shows credential flyout when user press enter 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void UserControl_KeyDown(object sender, KeyRoutedEventArgs e)
        {
            if (e != null)
            {
                if (e.Key.Equals(Windows.System.VirtualKey.Enter))
                {
                    // Had to keep this condition because this event handler hits twice when you press enter. 
                    // Please refer this link (http://social.msdn.microsoft.com/Forums/en-US/winappswithcsharp/thread/734d6c7a-8da2-48c6-9b3d-fa868b4dfb1d) for more information on above issue
                    if (e.KeyStatus.RepeatCount == 1)
                    {
                        SignIn(this, null);
                    }
                }
            }
        }

        /// <summary>
        /// Clears default username input text and sets foreground color to black 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void UsernameInput_GotFocus(object sender, RoutedEventArgs e)
        {
            if (this.UsernameInput.Text.Equals("username@domain.com"))
            {
                this.UsernameInput.Text = string.Empty;
                this.UsernameInput.Foreground = new SolidColorBrush(Colors.Black);
            }
        }
    }
}
