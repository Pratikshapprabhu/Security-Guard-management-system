using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class ShiftsLocation
    {
        public int ShiftsLocationId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public string Status { get; set; }
        public string WeekDay { get; set; }
        public string LocationId { get; set; }
        public string ShiftId { get; set; }

        public virtual ClientLocation Location { get; set; }
        public virtual DutyShift Shift { get; set; }
    }
}
