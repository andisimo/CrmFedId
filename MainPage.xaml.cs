using Callisto.Controls;
using CrmFedId.CrmContext;
using CrmFedId.Security;
using Microsoft.IT.Core.Diagnostics;
using Microsoft.IT.Core.Security;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Services.Client;
using System.IO;
using System.Linq;
using System.Net;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI;
using Windows.UI.Core;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Imaging;
using Windows.UI.Xaml.Navigation;

// The Basic Page item template is documented at http://go.microsoft.com/fwlink/?LinkId=234237

namespace CrmFedId
{
    /// <summary>
    /// A basic page that provides characteristics common to most applications.
    /// </summary>
    public sealed partial class MainPage : CrmFedId.Common.LayoutAwarePage
    {
        public MainPage()
        {
            this.InitializeComponent();
        }

        /// <summary>
        /// Populates the page with content passed during navigation.  Any saved state is also
        /// provided when recreating a page from a prior session.
        /// </summary>
        /// <param name="navigationParameter">The parameter value passed to
        /// <see cref="Frame.Navigate(Type, Object)"/> when this page was initially requested.
        /// </param>
        /// <param name="pageState">A dictionary of state preserved by this page during an earlier
        /// session.  This will be null the first time a page is visited.</param>
        protected async override void LoadState(Object navigationParameter, Dictionary<String, Object> pageState)
        {
            FedId.Instance.ShowSettingsFlyout += (sender1, e1) =>
            {
                if (e1.FlyoutAction == FlyoutAction.GetIdpCredentials)
                {
                    SettingsFlyout settings = new SettingsFlyout(); settings.FlyoutWidth = Callisto.Controls.SettingsFlyout.SettingsFlyoutWidth.Wide;
                    settings.HeaderBrush = new SolidColorBrush(Colors.Blue); settings.HeaderText = "idp credentials flyout";
                    settings.SmallLogoImageSource = new BitmapImage(new Uri("ms-appx:///Assets/SmallLogo.png"));
                    settings.Content = new IdpCredentialsFlyout(); settings.IsOpen = true;
                    Log.Instance.TraceInformation("idp credentials flyout being displayed");
                }
                else if (e1.FlyoutAction == FlyoutAction.GetIdpSelection)
                {
                    SettingsFlyout settings = new SettingsFlyout(); settings.FlyoutWidth = Callisto.Controls.SettingsFlyout.SettingsFlyoutWidth.Wide;
                    settings.HeaderBrush = new SolidColorBrush(Colors.Blue); settings.HeaderText = "idp selection flyout";
                    settings.SmallLogoImageSource = new BitmapImage(new Uri("ms-appx:///Assets/SmallLogo.png"));
                    settings.Content = new IdpSelectionFlyout(); settings.IsOpen = true;
                    Log.Instance.TraceInformation("idp selection flyout being displayed");
                }
            };
            // TODO: Refactor this

            App.ContactsNotesVM.TokenReceived += async () =>
                {
                    App.ContactsNotesVM.LoadContactsAsync();
                };

            App.ContactsNotesVM.Loaded += async () =>
            {
                await Dispatcher.RunAsync(CoreDispatcherPriority.Normal, () =>
                {
                    this.Frame.Navigate(typeof(BasicPage1));
                });
            };

            if (!FedId.Instance.IsSecurityTokenValid())
            {
                var result = await FedId.Instance.SignInAsync("https://myxrm.crm.dynamics.com/");
            }
            else
            {
                App.ContactsNotesVM.LoadContactsAsync();
            }
        }

        /// <summary>
        /// Preserves state associated with this page in case the application is suspended or the
        /// page is discarded from the navigation cache.  Values must conform to the serialization
        /// requirements of <see cref="SuspensionManager.SessionState"/>.
        /// </summary>
        /// <param name="pageState">An empty dictionary to be populated with serializable state.</param>
        protected override void SaveState(Dictionary<String, Object> pageState)
        {
        }

        private void Item_Click(object sender, ItemClickEventArgs e)
        {

        }
    }
}
