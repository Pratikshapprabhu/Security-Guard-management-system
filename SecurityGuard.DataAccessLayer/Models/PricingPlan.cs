using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class PricingPlan
    {
        public string PricingPlanId { get; set; }
        public double? Amount { get; set; }
        public int? Unit { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public byte[] AgreementDoc { get; set; }
        public string Status { get; set; }
        public string ClientId { get; set; }
        public string LocationId { get; set; }
        public string BranchId { get; set; }

        public virtual CompanyBranch Branch { get; set; }
        public virtual Client Client { get; set; }
        public virtual ClientLocation Location { get; set; }
    }
}
