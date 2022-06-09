using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class EmpUserRole
    {
        public int EURId { get; set; }
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public string EmpId { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public string Status { get; set; }

        public virtual Employee Emp { get; set; }
        public virtual Roles Role { get; set; }
        public virtual Users User { get; set; }
    }
}
