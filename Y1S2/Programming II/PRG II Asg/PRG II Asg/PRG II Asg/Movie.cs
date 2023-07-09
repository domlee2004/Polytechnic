using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace PRG_II_Asg
{
    class Movie
    {
        public string Title { get; set; }
        public int Duration { get; set; }
        public string Classification { get; set; }
        public DateTime OpeningDate { get; set; }
        public List<string> GenreList { get; set; }
        public List<Screening> ScreeningList { get; set; } = new List<Screening>();
        public Movie() { }
        public Movie(string t, int d, string c, DateTime oD, List<string> gL)
        {
            Title = t;
            Duration = d;
            Classification = c;
            OpeningDate = oD;
            GenreList = gL;
        }
        public void AddGenre(string s)
        {
            GenreList.Add(s);
        }
        public void AddScreening(Screening sc)
        {
            ScreeningList.Add(sc);
        }
        public override string ToString()
        {
            return "Title: " + Title + "\tDuration: " + Duration + "\tClassification: "
                + Classification + "\tOpeningDate: " + OpeningDate;
        }
    }
}
