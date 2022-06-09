using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Company
    {
        public Company()
        {
            Agreement = new HashSet<Agreement>();
            CompanyBranch = new HashSet<CompanyBranch>();
        }

        public string CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public int? PinCode { get; set; }
        public string Gst { get; set; }
        public string Tin { get; set; }

        public virtual ICollection<Agreement> Agreement { get; set; }
        public virtual ICollection<CompanyBranch> CompanyBranch { get; set; }
    }
}
