using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class EmpBankAccount
    {
        public string AccountId { get; set; }
        public long AccountNumber { get; set; }
        public string AccountType { get; set; }
        public string IFSC { get; set; }
        public string BankId { get; set; }
        public string EmpId { get; set; }

        public virtual Bank Bank { get; set; }
        public virtual Employee Emp { get; set; }
    }
}
