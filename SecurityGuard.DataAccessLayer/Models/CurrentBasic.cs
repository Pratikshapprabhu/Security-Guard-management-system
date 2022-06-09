using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class CurrentBasic
    {
        public CurrentBasic()
        {
            Salary = new HashSet<Salary>();
        }

        public long? Scale { get; set; }
        public long? Basic { get; set; }
        public string SiId { get; set; }
        public DateTime? DateOfIncrement { get; set; }
        public string Status { get; set; }
        public string EmpId { get; set; }

        public virtual Employee Emp { get; set; }
        public virtual ICollection<Salary> Salary { get; set; }
    }
}
