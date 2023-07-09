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

            // 7. Order movie ticket/s
            List<Order> orderList = new List<Order>();
            Console.WriteLine("\r\nTESTING FOR QUESTION 7");
            OrderMovieTickets(movieList, orderList); // adds in orderList to this function for CancelTicketOrder

            // 8. Cancel order of ticket
            Console.WriteLine("\r\nTESTING FOR QUESTION 8");
            CancelTicketOrder(orderList);
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
        static Movie ListMovieScreenings(List<Movie> movieList) // warning: void changed to returnable values
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

            // warning: void changed to returnable values
            return selectedMovieObject;
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

        // --- Function(s) for Question 7 --- UNTESTED, NO INPUT VALIDATION

        // Function that orders movie tickets
       static void OrderMovieTickets(List<Movie> movieList, List<Order> orderList)
       {
            // 1. to 3. 
            // 1. list all movies
            // 2.prompt user to select a movie
            // 3.list all movie screenings of the selected movie
            Movie selectedMovieObject = ListMovieScreenings(movieList);

            // 4. prompt user to select movie screening
            Console.Write("Select a movie screening e.g. 1001");
            int selectedScreening = Convert.ToInt32(Console.ReadLine());

            // 5. retrieve the selected movie screening
            Screening selectedScreeningObject = null;
            foreach (Screening s in selectedMovieObject.ScreeningList)
            {
                if (s.ScreeningNo == selectedScreening)
                {
                    selectedScreeningObject = s;
                }
            }

            // 6. prompt user to enter the total number of tickets to order (check if figure
            // entered is more than the available seats for the screening)

            // a loop is used here.
            // loop break when user enters permissible number of tickets to be ordered

            int totalTicketsOrdered = 0;

            int infiniteCounter0 = 0;
            while (infiniteCounter0 == 0)
            {
                Console.WriteLine("Enter total number of tickets to order");
                totalTicketsOrdered = Convert.ToInt32(Console.ReadLine());
                if (totalTicketsOrdered > selectedScreeningObject.SeatsRemaining)
                {
                    Console.WriteLine("Number of tickets cannot be more than seats remaining");
                    continue;
                }
                else
                {
                    infiniteCounter0++; // breaks out of loop
                }
            }

            // 7. prompt user if all ticket holders meet the movie classification requirements
            // (except movies classified as G)

            if (selectedMovieObject.Classification != "G")
            {
                Console.WriteLine("This movie's classification is " + selectedMovieObject.Classification + ".");
                Console.WriteLine("Do all of your audiences meet the classification requirement? [Y/N]");
                string allAudienceMeetClassificationRequirement = Console.ReadLine();
                if (allAudienceMeetClassificationRequirement == "N")
                {
                    Console.WriteLine("Tickets for this movie cannot be ordered due to classification requirements."); // make the whole function an infinite loop for input validation?
                    return; // quits the method 
                }
            }
            else
            {
                Console.WriteLine("All of your audiences meet the movie's G classification.");
            }

            // 8. create an Order object with the status “Unpaid”

            Order ticketOrder = new Order();
            ticketOrder.Status = "Unpaid"; // Alr initialized in class

            // 9. for each ticket,
            // a. prompt user for a response depending on the type of ticket ordered:
            // b. create a Ticket object (Student, SeniorCitizen or Adult) with the information given
            // c. add the ticket object to the ticket list of the order
            // d. update seats remaining for the movie screening

            double totalTicketCost = 0;
            for (int i = 0; i < totalTicketsOrdered; i++)    
            {
                // prompts for the type of ticket 
                Console.WriteLine("What type of ticket is it? [Student/Senior Citizen/Adult]"); // add loop for input validation 
                string ticketType = Console.ReadLine();

                if (ticketType == "Student")
                {
                    // create new ticket object for ticket order type
                    Console.WriteLine("What is your level of study? [Primary/Secondary/Tertiary]");

                    Student newStudent = new Student(selectedScreeningObject, Console.ReadLine().ToUpper());
                    ticketOrder.AddTicket(newStudent);

                    totalTicketCost += newStudent.CalculatePrice();
                }
                else if (ticketType == "Senior Citizen")
                {
                    Console.WriteLine("What is your year of birth? e.g. 1945");
                    //newSeniorCitizen.YearOfBirth = Convert.ToInt32(Console.ReadLine());
                    //newSeniorCitizen.Screening = selectedScreeningObject;

                    SeniorCitizen newSeniorCitizen = new SeniorCitizen(selectedScreeningObject, Convert.ToInt32(Console.ReadLine()));
                    ticketOrder.AddTicket(newSeniorCitizen);

                    totalTicketCost += newSeniorCitizen.CalculatePrice();
                }
                else if (ticketType == "Adult")
                {
                    Console.WriteLine("Would you like to have popcorn for $3? [Y/N]");
                    string popcornOrNot = Console.ReadLine();
                    bool popcornBoolean = false;

                    if (popcornOrNot == "Y")
                    {
                        popcornBoolean = true;
                    }
                    else if (popcornOrNot == "N")
                    {
                        popcornBoolean = false;
                    }

                    Adult newAdult = new Adult(selectedScreeningObject, popcornBoolean);
                    ticketOrder.AddTicket(newAdult);

                    totalTicketCost += newAdult.CalculatePrice();
                }
                selectedScreeningObject.SeatsRemaining -= 1; // update seats remaining
            }

            // 10.list amount payable. calculate method 
            Console.WriteLine("The total amount payable is $" + totalTicketCost);

            // 11. prompt user to press any key to make payment
            Console.WriteLine("Press any key to make payment for the tickets.");
            Console.ReadKey();

            // 12. fill in the necessary details to the new order (e.g amount)
            // already filled in under earlier steps // fill in unfilled attributes

            // 13. change order status to “Paid”
            ticketOrder.Status = "Paid";
            ticketOrder.Amount = totalTicketCost;
            ticketOrder.OrderDateTime = DateTime.Now;
            ticketOrder.OrderNo = 0; // temp, do with checking index of ticketList - do not touch

            // add this movie order to orderList 
            orderList.Add(ticketOrder);
       }

        // --- Function(s) for Question 8 --- UNTESTED, NO INPUT VALIDATION
        static void CancelTicketOrder(List<Order> orderList)
        {
            // 1. prompt user for order number
            Console.WriteLine("Enter order number to cancel ticket order:");
            int selectedOrderNumber = Convert.ToInt32(Console.ReadLine());

            // 2. retrieve the selected order
            Order selectedOrder = null;
            foreach (Order order in orderList)
            {
                if (order.OrderNo == selectedOrderNumber)
                {
                    selectedOrder = order;
                }
            }

            // 3. check if the screening in the selected order is screened
            if (selectedOrder.OrderDateTime <= DateTime.Now)
            {
                Console.WriteLine("Unable to cancel selected order as show has been screened");
                Console.WriteLine("Cancellation status: unsuccessful");
                return; // quits the method 
            }

            // 4. update seat remaining for the movie screening based on the selected order 
            int numberOfSeatsToAdd = 0;
            foreach (Ticket ticket in selectedOrder.TicketList)
            {
                numberOfSeatsToAdd++;
            }

            Screening update_screening = selectedOrder.TicketList[0].Screening;
            update_screening.SeatsRemaining += numberOfSeatsToAdd;
            
            // 5. change order status to cancelled
            // do "if hasscreened is false" after previous process
            selectedOrder.Status = "Cancelled";

            // 6. display a message indicating that the amount is refunded "part of previous else if 
            Console.WriteLine("Amount has been refunded successfully.");

            // 7. display the status of the cancelation (i.e. successful or unsuccessful) 
            Console.WriteLine("Cancellation status: successful");  
        }
        
        // Advanced features
        // 3.1 recommend movie based on sale of tickets sold
        static void RecommendMovie(List<Movie> movieList)
        {
            // creates a list with the number of tickets sold for each movie
            // indexing referring to each movie follows movieList
            List<Movie> ticketsSoldPerMovie = new List<Movie>();

            for(int i = 0; i < movieList.Count; i++)
            {
                foreach(Screening screening in movieList[i].ScreeningList)
                {

                }
            }
        }
    }
}
