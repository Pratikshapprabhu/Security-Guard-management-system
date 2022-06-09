using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class ClientLocation
    {
        public ClientLocation()
        {
            PricingPlan = new HashSet<PricingPlan>();
            ShiftSchedule = new HashSet<ShiftSchedule>();
            ShiftsLocation = new HashSet<ShiftsLocation>();
        }

        public string LocationId { get; set; }
        public string LocationName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Gps { get; set; }
        public string Gpsrange { get; set; }
        public int? GuardsPerShift { get; set; }
        public string ClientId { get; set; }

        public virtual Client Client { get; set; }
        public virtual ICollection<PricingPlan> PricingPlan { get; set; }
        public virtual ICollection<ShiftSchedule> ShiftSchedule { get; set; }
        public virtual ICollection<ShiftsLocation> ShiftsLocation { get; set; }
    }
}
