using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Employee
    {
        public Employee()
        {
            CurrentBasic = new HashSet<CurrentBasic>();
            EmpBankAccount = new HashSet<EmpBankAccount>();
            EmpUserRole = new HashSet<EmpUserRole>();
            LeaveApplication = new HashSet<LeaveApplication>();
        }

        public string EmpId { get; set; }
        public string EmpName { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public int PinCode { get; set; }
        public string Pan { get; set; }
        public long AdharNumber { get; set; }
        public string Photo { get; set; }
        public int RoleId { get; set; }
        public int UserId { get; set; }

        public virtual Roles Role { get; set; }
        public virtual Users User { get; set; }
        public virtual ICollection<CurrentBasic> CurrentBasic { get; set; }
        public virtual ICollection<EmpBankAccount> EmpBankAccount { get; set; }
        public virtual ICollection<EmpUserRole> EmpUserRole { get; set; }
        public virtual ICollection<LeaveApplication> LeaveApplication { get; set; }
    }
}
