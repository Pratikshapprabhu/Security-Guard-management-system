using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class HolidaysList
    {
        public HolidaysList()
        {
            Invoice = new HashSet<Invoice>();
        }

        public string HolidayId { get; set; }
        public DateTime? HolidayDate { get; set; }
        public string HolidayType { get; set; }
        public string HolidayName { get; set; }

        public virtual ICollection<Invoice> Invoice { get; set; }
    }
}
