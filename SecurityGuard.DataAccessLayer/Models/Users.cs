using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Users
    {
        public Users()
        {
            EmpUserRole = new HashSet<EmpUserRole>();
            Employee = new HashSet<Employee>();
        }

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public string Email { get; set; }
        public long PhoneNumber { get; set; }

        public virtual ICollection<EmpUserRole> EmpUserRole { get; set; }
        public virtual ICollection<Employee> Employee { get; set; }
    }
}
