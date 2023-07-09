using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    class Student:Ticket
    {
        public string LevelOfStudy { get; set; }
        public Student() { }
        public Student(Screening s, string los)
        {
            Screening = s;
            LevelOfStudy = los;
        }
        public override double CalculatePrice()
        {
            double price;
            if ((Screening.ScreeningDateTime - Screening.Movie.OpeningDate).TotalDays <= 7)
            {
                if (Screening.ScreeningType == "2D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
                {
                    price = 12.50;
                } else
                {
                    price = 8.50;
                } 
                if (Screening.ScreeningType == "3D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
                {
                    price = 14;
                } else
                {
                    price = 11;
                }
            } else
            {
                if (Screening.ScreeningType == "2D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
                {
                    price = 12.50;
                }
                else
                {
                    price = 7;
                }
                if (Screening.ScreeningType == "3D" && (Screening.ScreeningDateTime.Day == 5 || Screening.ScreeningDateTime.Day == 6 || Screening.ScreeningDateTime.Day == 0))
                {
                    price = 14;
                } else
                {
                    price = 8;
                }
            }
            return price;
        }

        public override string ToString()
        {
            return base.ToString() + "\tLevelOfStudy: " + LevelOfStudy;
        }
    }
}
