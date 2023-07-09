// Student Number : S10222894G, S10222998D
// Student Name : Dominic, Xihe
// Module Group : T08

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    class Adult:Ticket
    {
        public bool PopcornOffer { get; set; }
        public Adult() { }
        public Adult(Screening s, bool po)
        {
            Screening = s;
            PopcornOffer = po;
        }
        public override double CalculatePrice()
        {
            double price = 0;
            if (Screening.ScreeningType == "2D" && (Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 5 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 6 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 0))
            {
                price = 12.50;
            }
            if (Screening.ScreeningType == "2D" && (Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 1 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 2 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 3 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 4))
            {
                price = 8.50;
            }
            if (Screening.ScreeningType == "3D" && (Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 5 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 6 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 0))
            {
                price = 14;
            }
            if (Screening.ScreeningType == "3D" && (Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 1 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 2 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 3 || Convert.ToInt32(Screening.ScreeningDateTime.DayOfWeek) == 4))
            {
                price = 11;
            }
            return price;
        }
        public override string ToString()
        {
            return base.ToString() + "\tPopcornOffer: " + PopcornOffer;
        }
    }
}
