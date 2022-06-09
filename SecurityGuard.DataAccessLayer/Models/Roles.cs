using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Roles
    {
        public Roles()
        {
            EmpUserRole = new HashSet<EmpUserRole>();
            Employee = new HashSet<Employee>();
        }

        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public string RoleCode { get; set; }
        public string RoleDescription { get; set; }

        public virtual ICollection<EmpUserRole> EmpUserRole { get; set; }
        public virtual ICollection<Employee> Employee { get; set; }
    }
}
