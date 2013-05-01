using CrmFedId.CrmContext;
using Microsoft.IT.Core.Security;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Services.Client;
using System.Linq;
using System.Net;

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

        //properties
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

        public psecdemoContext Ctx
        {
            get { return _ctx; }
            set { _ctx = value; }
        }

        //events
        public event TokenReceivedEventHandler TokenReceived;
        public event LoadedEventHandler Loaded;

        //methods
        public void HaveToken()
        {
            Ctx = new psecdemoContext(new Uri("https://psecdemo.crm.dynamics.com/XRMServices/2011/OrganizationData.svc/"));
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
            
            var query = from c in Ctx.ContactSet
                select c;

            Ctx.SendingRequest += (sender, args) => args.RequestHeaders[HttpRequestHeader.Cookie] = FedId.Instance.SecurityToken.SessionCookieHeader;

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

        public void PostNote(Contact contact, string noteText)
        {
            var note = new Annotation();
            note.NoteText = noteText;
            note.ObjectId = new EntityReference();
            note.ObjectId.LogicalName = "contact";
            note.ObjectId.Id = contact.ContactId;
            Ctx.AddToAnnotationSet(note);
            Ctx.BeginSaveChanges(EndSave, note);
        }

        public void EndSave(IAsyncResult result)
        {
            _ctx.EndSaveChanges(result);
            var createdNote = result.AsyncState as Annotation; 
        }
    }
}
