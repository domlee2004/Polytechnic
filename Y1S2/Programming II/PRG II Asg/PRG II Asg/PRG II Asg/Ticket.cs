using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    abstract class Ticket
    {
        public Screening Screening { get; set; }
        public Ticket() { }
        public Ticket(Screening s)
        {
            Screening = s;
        }
        public abstract double CalculatePrice();
        public override string ToString()
        {
            return "Screening: " + Screening;
        }
    }
}
