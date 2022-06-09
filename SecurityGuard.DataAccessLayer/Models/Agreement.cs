using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Agreement
    {
        public string AgreementId { get; set; }
        public DateTime DateOfAgreement { get; set; }
        public DateTime ValidUpTo { get; set; }
        public string Status { get; set; }
        public byte[] Document { get; set; }
        public string CompanyId { get; set; }
        public string ClientId { get; set; }

        public virtual Client Client { get; set; }
        public virtual Company Company { get; set; }
    }
}
