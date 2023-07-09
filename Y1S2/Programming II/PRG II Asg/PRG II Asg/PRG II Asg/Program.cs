using System;
using System.IO;
using System.Collections.Generic;

namespace PRG_II_Asg
{
    class Program
    {
        static int screeningCounter = 1001;
        static void Main(string[] args)
        {
            // 1. Load Movie and Cinema Data
            List<Movie> movieList = new List<Movie>();
            List<Cinema> cinemaList = new List<Cinema>();
            LoadMovie(movieList);
            LoadCinema(cinemaList);
            // 2. Load Screening Data 
            List<Screening> screeningList = new List<Screening>();
            LoadScreeningData(screeningList, movieList, cinemaList);

            // 3. List All Movies
            ListAllMovies(movieList);

            // 3.5 Adding Screening Objs into Movie Screening List
            AddingScreeningIntoMovieScreeningList(movieList, screeningList);

            // 4. List Movie Screenings
            ListMovieScreenings(movieList);

            // 5. Add a movie screening session
            AddMovieScreening(movieList, screeningList, cinemaList);
            
        }
        static void LoadMovie(List<Movie> movieList)
        {
            string[] lines = File.ReadAllLines("Movie.csv");
            for (int i = 1; i < lines.Length; i++)
            {
                string[] objParts = lines[i].Split(",");
                List<string> genreList = new List<string>();
                string[] add = objParts[2].Split("/");
                foreach (string s in add)
                {
                    genreList.Add(s);
                }
                movieList.Add(new Movie(objParts[0], Convert.ToInt32(objParts[1]), objParts[3], Convert.ToDateTime(objParts[4]), genreList));
            }
        }
        static void LoadCinema(List<Cinema> cinemaList)
        {
            string[] lines = File.ReadAllLines("Cinema.csv");
            for (int i = 1; i < lines.Length; i++)
            {
                string[] objParts = lines[i].Split(",");
                cinemaList.Add(new Cinema(objParts[0], Convert.ToInt32(objParts[1]), Convert.ToInt32(objParts[2])));
            }
        }

        static void LoadScreeningData(List<Screening> screeningList, List<Movie> movieList, List<Cinema> cinemaList)
        {
            Movie wantedMovie = null;
            Cinema wantedCinema = null;
            string[] lines = File.ReadAllLines("Screenings.csv");
            for (int i = 1; i < lines.Length; i++)
            {
                string[] objParts = lines[i].Split(",");
                foreach (Movie m in movieList)
                {
                    if (m.Title == objParts[4])
                    {
                        wantedMovie = m;
                    }
                }
                foreach (Cinema c in cinemaList)
                {
                    if (c.Name == objParts[2] && c.HallNo == Convert.ToInt32(objParts[3]))
                    {
                        wantedCinema = c;
                    }
                }
                screeningList.Add(new Screening(screeningCounter, Convert.ToDateTime(objParts[0]), objParts[1], wantedCinema, wantedMovie));
                screeningCounter++;
            }
        }
        static void ListAllMovies(List<Movie> movieList)
        {
            foreach (Movie m in movieList)
            {
                Console.WriteLine(m);
            }
        }
        static void AddingScreeningIntoMovieScreeningList(List<Movie> movieList, List<Screening> screeningList)
        {
            foreach (Movie m in movieList)
            {
                foreach (Screening s in screeningList)
                {
                    if (s.Movie.Title == m.Title)
                    {
                        m.ScreeningList.Add(s);
                    }
                }
            }
        }
        static void ListMovieScreenings(List<Movie> movieList)
        {
            ListAllMovies(movieList);
            Console.WriteLine("Please select a movie: ");
            string selectedMovie = Console.ReadLine().ToUpper();
            Movie selectedMovieObject = null;
            foreach (Movie m in movieList)
            {
                if (m.Title.ToUpper() == selectedMovie)
                {
                    selectedMovieObject = m;
                    break;
                }
            }
            if (selectedMovieObject is null)
            {
                Console.WriteLine("Please enter a valid movie name");
            }
            else
            {
                if (selectedMovieObject.ScreeningList.Count == 0)
                {
                    Console.WriteLine("No screenings available");
                }
                else
                {
                    foreach (Screening s in selectedMovieObject.ScreeningList)
                    {
                        Console.WriteLine(s);
                    }
                }
            }

        }
        // Test tmr for errors (ure drunk now)
        static void AddMovieScreening(List<Movie> movieList, List<Screening> screeningList, List<Cinema> cinemaList)
        {
            bool creationStatus = true;
            Movie movieCheck = null;
            Cinema cinemaCheck = null;
            ListAllMovies(movieList);
            Console.WriteLine("Please select a movie");
            string selectedMovie = Console.ReadLine().ToUpper();
            Console.WriteLine("Please enter a screening type [2D/3D]");
            string screenType = Console.ReadLine().ToUpper();
            if (screenType != "2D" && screenType != "3D")
            {
                creationStatus = false;
            }
            Console.WriteLine("Please enter a screening date and time: ");
            // Put exception if format is wrong and causes error
            DateTime dateTime = Convert.ToDateTime(Console.ReadLine());
            foreach (Cinema c in cinemaList)
            {
                Console.WriteLine(c);
            }
            Console.WriteLine("Please pick a cinema location e.g Singa South: ");
            string cinemaLoc = Console.ReadLine().ToUpper();
            Console.WriteLine("Please pick a cinema hall: ");
            string cinemaHall = Console.ReadLine();
            foreach (Screening s in screeningList)
            {
                if (Convert.ToString(s.Cinema.HallNo).ToUpper() == cinemaHall && s.Cinema.Name.ToUpper() == cinemaLoc)
                {
                    cinemaCheck = s.Cinema;
                    movieCheck = s.Movie;
                    break;
                }
            }
            if (movieCheck is null)
            {
                creationStatus = false;
                Console.WriteLine("Please enter valid inputs");
            }
            else
            {
                foreach (Screening s in movieCheck.ScreeningList)
                {
                    if (s.ScreeningDateTime > dateTime)
                    {
                        if (s.ScreeningDateTime.AddMinutes(-(s.Movie.Duration + 30)) < dateTime)
                        {
                            creationStatus = false;
                        }
                    }
                    else
                    {
                        if (s.ScreeningDateTime.AddMinutes(s.Movie.Duration + 30) > dateTime)
                        {
                            creationStatus = false;
                        }
                    }
                }
            }
            if (creationStatus)
            {
                screeningCounter++;
                movieCheck.ScreeningList.Add(new Screening(screeningCounter, dateTime, screenType, cinemaCheck, movieCheck));
                foreach (Screening s in movieCheck.ScreeningList)
                {
                    Console.WriteLine(s);
                }
                Console.WriteLine("Creation successful");
            }
            else
            {
                Console.WriteLine("Creation failed");
            }
        }

    }
}
