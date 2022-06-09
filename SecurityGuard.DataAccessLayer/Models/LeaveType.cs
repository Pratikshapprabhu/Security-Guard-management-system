using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class LeaveType
    {
        public LeaveType()
        {
            LeaveApplication = new HashSet<LeaveApplication>();
        }

        public string LtId { get; set; }
        public string LeaveTypeName { get; set; }
        public int? LeavePerYear { get; set; }

        public virtual ICollection<LeaveApplication> LeaveApplication { get; set; }
    }
}
