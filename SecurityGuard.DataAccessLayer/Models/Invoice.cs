using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Invoice
    {
        public Invoice()
        {
            PaymentDetails = new HashSet<PaymentDetails>();
        }

        public long InvoiceNumber { get; set; }
        public DateTime? InvoiceDate { get; set; }
        public string GlshiftIdId { get; set; }
        public string HolidayId { get; set; }

        public virtual ShiftSchedule GlshiftId { get; set; }
        public virtual HolidaysList Holiday { get; set; }
        public virtual ICollection<PaymentDetails> PaymentDetails { get; set; }
    }
}
