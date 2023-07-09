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
            double price;
            if (Screening.ScreeningType == "2D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
            {
                price = 12.50;
            }
            else
            {
                price = 8.50;
            }
            if (Screening.ScreeningType == "3D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
            {
                price = 14;
            }
            else
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
