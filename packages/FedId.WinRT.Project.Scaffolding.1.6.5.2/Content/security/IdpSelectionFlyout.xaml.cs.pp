using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Callisto.Controls;
using Microsoft.IT.Core.Security;
using Windows.Foundation;
using Windows.Foundation.Collections;
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
    public sealed partial class IdpSelectionFlyout : UserControl
    {
        public IdpSelectionFlyout()
        {
            this.InitializeComponent();
            this.Loaded += IdpSelectionFlyout_Loaded;
        }

		/// <summary>
        /// Assigns list of identity providers to list box 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void IdpSelectionFlyout_Loaded(object sender, RoutedEventArgs e)
        {            
            if (FedId.Instance != null && FedId.Instance.SignInSettings != null)
            {
                this.IdentityProviders.ItemsSource = FedId.Instance.SignInSettings.AcsNamespaceIdps;
            }
        }

		/// <summary>
        /// Updates fedid signin settings values on selection of identity provider
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private async void IdentityProviders_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                if (e != null)
                {
                    if (e.AddedItems.Count() > 0)
                    {
						this.HideErrorMessage();
                        this.ShowProgressBar();

                        SignInWsFedAcsIdp signInWsACSidp = e.AddedItems[0] as SignInWsFedAcsIdp;
                        FedId.Instance.SignInSettings.AcsIdentityProviderUrl = signInWsACSidp.LoginUrl;
                        FedId.Instance.SignInSettings.AcsIdentityProviderSignOutUrl = signInWsACSidp.LogoutUrl;
                        var result = await FedId.Instance.SignInAsync(FedId.Instance.SignInSettings.Url);

                        if (result == true)
                        {
                            // TODO: any callbacks you need to make to now initialize main view
#if DEBUG
    var rawToken = FedId.Instance.SecurityToken.RawToken;  // if this was not for an orgId or orgId/adfs secured service or service bus endpoint
    var sessionCookieHeader = FedId.Instance.SecurityToken.SessionCookieHeader;  // if this was for an orgId or orgId/adfs secured service
    var claims = FedId.Instance.SecurityToken.Claims;   // if this was not for an orgId or orgId/adfs secured service or service bus endpoint
#endif
                        }

                        // programmatically dismiss xaml callisto settings flyout when done
                        if (this.Parent != null) (this.Parent as SettingsFlyout).IsOpen = false;  // vs SettingsFlyoutDiv.winControl.hide();
                    }
                }
            }
            catch (Exception exception)
            {
                this.HideProgressBar();
                this.ShowErrorMessage("An error happened during identity providers request processing, please check network connection, and then try again.");              
            }
        }

		/// <summary>
        /// Shows progress bar
        /// </summary>
        private void ShowProgressBar()
        {
            if (this.LoadingProgressBar != null)
            {
                this.LoadingProgressBar.IsIndeterminate = true;
                this.LoadingProgressBar.Opacity = 1;
            }
        }

        /// <summary>
        /// Hides loading progress bar
        /// </summary>
        private void HideProgressBar()
        {
            if (this.LoadingProgressBar != null)
            {
                this.LoadingProgressBar.IsIndeterminate = false;
                this.LoadingProgressBar.Opacity = 0;
            }
        }

        /// <summary>
        /// Shows error message
        /// </summary>
        /// <param name="errorMessage"></param>
        private void ShowErrorMessage(string errorMessage)
        {
            if (this.TxtErrorMessage != null)
            {
                this.TxtErrorMessage.Visibility = Visibility.Visible;
                this.TxtErrorMessage.Text = errorMessage;
            }
        }

        /// <summary>
        /// Hides error message
        /// </summary>
        /// <param name="errorMessage"></param>
        private void HideErrorMessage()
        {
            if (this.TxtErrorMessage != null)
            {
                this.TxtErrorMessage.Visibility = Visibility.Collapsed;
                this.TxtErrorMessage.Text = string.Empty;
            }
        }
    }
}
