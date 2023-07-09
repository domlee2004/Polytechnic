using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    class Order
    {
        public int OrderNo { get; set; }
        public DateTime OrderDateTime { get; set; }
        public double Amount { get; set; }
        public string Status { get; set; }
        public List<Ticket> TicketList { get; set; } = new List<Ticket>();

        public Order() { }
        public Order(int on, DateTime odt)
        {
            double sum = 0;
            OrderNo = on;
            OrderDateTime = odt;
            foreach (Ticket t in TicketList)
            {
                sum += t.CalculatePrice();
            }
            Amount = sum;
            Status = "Unpaid";
        }
        public void AddTicket(Ticket t)
        {
            TicketList.Add(t);
        }
        public override string ToString()
        {
            return base.ToString();
        }
    }
}
