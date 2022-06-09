using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Client
    {
        public Client()
        {
            Agreement = new HashSet<Agreement>();
            ClientLocation = new HashSet<ClientLocation>();
            CompanyBranchClient = new HashSet<CompanyBranchClient>();
            PricingPlan = new HashSet<PricingPlan>();
        }

        public string ClientId { get; set; }
        public string ClientName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Email { get; set; }
        public int? PinCode { get; set; }
        public string Gst { get; set; }
        public string Pan { get; set; }

        public virtual ICollection<Agreement> Agreement { get; set; }
        public virtual ICollection<ClientLocation> ClientLocation { get; set; }
        public virtual ICollection<CompanyBranchClient> CompanyBranchClient { get; set; }
        public virtual ICollection<PricingPlan> PricingPlan { get; set; }
    }
}
