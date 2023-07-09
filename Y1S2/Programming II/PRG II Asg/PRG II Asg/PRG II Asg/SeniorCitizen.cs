using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    class SeniorCitizen:Ticket
    {
        public int YearOfBirth { get; set; }
        public SeniorCitizen() { }
        public SeniorCitizen(Screening s, int yob)
        {
            Screening = s;
            YearOfBirth = yob;
        }
        public override double CalculatePrice()
        {
            double price;
            if (Screening.ScreeningDateTime.Subtract(Screening.Movie.OpeningDate).Days <= 7)
            {
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
            }
            else
            {
                if (Screening.ScreeningType == "2D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
                {
                    price = 12.50;
                }
                else
                {
                    price = 5;
                }
                if (Screening.ScreeningType == "3D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
                {
                    price = 14;
                }
                else
                {
                    price = 6;
                }
            }
            return price;
        }
        public override string ToString()
        {
            return base.ToString() + "\tYearOfBirth: " + YearOfBirth;
        }
    }
}
