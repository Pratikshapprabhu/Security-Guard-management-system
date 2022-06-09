using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class CompanyBranch
    {
        public CompanyBranch()
        {
            CompanyBranchClient = new HashSet<CompanyBranchClient>();
            PricingPlan = new HashSet<PricingPlan>();
        }

        public string BranchId { get; set; }
        public string BranchName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public int PinCode { get; set; }
        public string CompanyId { get; set; }

        public virtual Company Company { get; set; }
        public virtual ICollection<CompanyBranchClient> CompanyBranchClient { get; set; }
        public virtual ICollection<PricingPlan> PricingPlan { get; set; }
    }
}
