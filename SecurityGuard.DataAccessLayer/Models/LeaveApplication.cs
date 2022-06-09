using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class LeaveApplication
    {
        public string LeaveApplicationId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public int? NoOfDays { get; set; }
        public string Reason { get; set; }
        public DateTime? LeaveApplicationDate { get; set; }
        public string ApprovedStatus { get; set; }
        public string EmpId { get; set; }
        public string SubstituteEmployeeId { get; set; }
        public string ApprovedBy { get; set; }
        public string LtId { get; set; }

        public virtual Employee Emp { get; set; }
        public virtual LeaveType Lt { get; set; }
    }
}
