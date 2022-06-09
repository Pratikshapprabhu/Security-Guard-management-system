using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Bank
    {
        public Bank()
        {
            EmpBankAccount = new HashSet<EmpBankAccount>();
        }

        public string BankId { get; set; }
        public string BankName { get; set; }
        public string BranchName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Ifsc { get; set; }

        public virtual ICollection<EmpBankAccount> EmpBankAccount { get; set; }
    }
}
