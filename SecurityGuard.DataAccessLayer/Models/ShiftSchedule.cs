using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class ShiftSchedule
    {
        public ShiftSchedule()
        {
            Invoice = new HashSet<Invoice>();
        }

        public string GlshiftId { get; set; }
        public DateTime? ScheduledDate { get; set; }
        public string AttendanceStatus { get; set; }
        public TimeSpan? DutyReportingTime { get; set; }
        public TimeSpan? DutyRelievingTime { get; set; }
        public string LocationId { get; set; }
        public string ShiftId { get; set; }

        public virtual ClientLocation Location { get; set; }
        public virtual DutyShift Shift { get; set; }
        public virtual ICollection<Invoice> Invoice { get; set; }
    }
}
