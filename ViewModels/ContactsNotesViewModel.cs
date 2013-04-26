using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using CrmFedId.CrmContext;
using System.Net;
using Microsoft.IT.Core.Security;
using System.Data.Services.Client;

namespace CrmFedId.ViewModels
{
    public delegate void TokenReceivedEventHandler();
    public delegate void LoadedEventHandler();

    public class ContactsNotesViewModel
    {
        //private fields
        private ObservableCollection<Contact> _contacts = new ObservableCollection<Contact>();
        private List<string> _accounts = new List<string>();
        private bool _isDataLoaded = false;
        private psecdemoContext _ctx;

        public ObservableCollection<Contact> Contacts
        {
            get { return _contacts; }
            set { _contacts = value; }
        }

        public List<string> Accounts
        {
            get { return _accounts; }
            set { _accounts = value; }
        }
  
        public bool IsDataLoaded
        {
            get { return _isDataLoaded; }
            set { _isDataLoaded = value; }
        }

        //events
        public event TokenReceivedEventHandler TokenReceived;
        public event LoadedEventHandler Loaded;

        //methods
        public void HaveToken()
        {
            TokenReceived();
        }

        public async void LoadContactsAsync()
        {
            if (FedId.Instance.IsSecurityTokenValid() == false)
            {
                throw new InvalidOperationException(@"ContactsNotexViewModel.LoadContactsAsync cannot retrieve 
                    contacts when the FedIde.Instance.IsSecurityTokenValid property is false. This property is set = true when the 
                    security token is correctly received from the FedId.Instance.SignInAsync method call."); 
            }

            _ctx = new psecdemoContext(new Uri("https://psecdemo.crm.dynamics.com/XRMServices/2011/OrganizationData.svc/"));

            var query = from c in _ctx.ContactSet
                        select c;

            _ctx.SendingRequest += (sender, args) => args.RequestHeaders[HttpRequestHeader.Cookie] = FedId.Instance.SecurityToken.SessionCookieHeader;

            var results = await ((DataServiceQuery<Contact>)query).ExecuteAsync();

            foreach (Contact c in results)
            {
                Contacts.Add(c);
            }
                        
            this.IsDataLoaded = true;
            Loaded();
        }

        public Contact GetContactById(Guid Id)
        {
            foreach(Contact c in Contacts)
            {
                if (c.ContactId == Id)
                    return c;
            }

            throw new KeyNotFoundException("The contact requested does not exist in the current context.");
        }

        public void RequestSingleContact(string username, string password, string orgName, string id)
        {
            
        }

        public async void PostNote(Contact contact, string noteText)
        {
            var note = new Annotation();
            note.NoteText = noteText;
            note.ObjectId = new EntityReference();
            note.ObjectId.LogicalName = "contact";
            note.ObjectId.Id = contact.ContactId;
            _ctx.AddToAnnotationSet(note);
            _ctx.BeginSaveChanges(EndSave, note); 
        }

        // TODO: refactor
        public void EndSave(IAsyncResult result)
        {
            _ctx.EndSaveChanges(result);
            var createdNote = result.AsyncState as Annotation; 
        }

        public async void UpdateContact(Contact contact)
        {
            
        }
    }
}
