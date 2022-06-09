using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class CompanyBranchClient
    {
        public int CBCId { get; set; }
        public string ClientId { get; set; }
        public string BranchId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public string Status { get; set; }

        public virtual CompanyBranch Branch { get; set; }
        public virtual Client Client { get; set; }
    }
}
