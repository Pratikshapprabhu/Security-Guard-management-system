using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class DutyShift
    {
        public DutyShift()
        {
            ShiftSchedule = new HashSet<ShiftSchedule>();
            ShiftsLocation = new HashSet<ShiftsLocation>();
        }

        public string ShiftId { get; set; }
        public string ShiftName { get; set; }
        public TimeSpan? FromTime { get; set; }
        public TimeSpan? ToTime { get; set; }
        public string ShiftCode { get; set; }

        public virtual ICollection<ShiftSchedule> ShiftSchedule { get; set; }
        public virtual ICollection<ShiftsLocation> ShiftsLocation { get; set; }
    }
}
