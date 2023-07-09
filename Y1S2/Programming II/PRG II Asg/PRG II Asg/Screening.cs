using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    class Screening
    {
        public int ScreeningNo { get; set; }
        public DateTime ScreeningDateTime { get; set; }
        public string ScreeningType { get; set; }
        public int SeatsRemaining { get; set; }
        public Cinema Cinema { get; set; }
        public Movie Movie { get; set; }
        public Screening() { }
        public Screening(int sn, DateTime sdt, string st, Cinema c, Movie m)
        {
            ScreeningNo = sn;
            ScreeningDateTime = sdt;
            ScreeningType = st;
            Cinema = c;
            Movie = m;
            SeatsRemaining = Cinema.Capacity;
        }

        /* public int CalculateTicketsLeft(List<Order> orderList)
        {
        need
        } */

        public override string ToString()
        {
            return "ScreeningNo: " + ScreeningNo + "\tScreeningDateTime: " + ScreeningDateTime +
                "\tScreeningType: " + ScreeningType + "\tSeatsRemaining: " + SeatsRemaining;
        }//Movie and cinema in to string
    }
}
