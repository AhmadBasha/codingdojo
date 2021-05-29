# Here we import the random to choose a random number for adult , senior citizen and children.
# we make a week_days that will store the weekdays names and the revenue for each day
# also, will store the number of adult , senior citizen and children for each week
import random
from .week_days import week_days


class Movies:
    def __init__(self, screens, seats, ticket_adult, ticket_senior, ticket_children, discount):

        self.screens = screens
        self.seats = seats
        self.ticket_adult = ticket_adult
        self.ticket_senior = ticket_senior
        self.ticket_children = ticket_children
        self.discount = discount

        self.max_day = 0
        self.max_day_name = ""
        self.total_revenue = 0
        self.simulate = 1

        self.week_days = week_days

        self.movies = {}

    def tickets_revenue(self, simulate):
        """
        This method will take the number of the simulation as an input and it will process and loop through the
        week days and the number of the screen . In the end, it will store the revenue for each day on the week 
        and the number of adults , children and senior_citizens.
        """

        # iterate by the number of the simulation
        for _ in range(simulate):
            self.simulate = simulate
            # iterate by each day in the week days
            for day in self.week_days:
                # iterate by the number of the screens
                for screen in range(self.screens):

                    # take a random movie from movies dictionary
                    movie_key = random.choice(list(self.movies.keys()))

                    # Here all of them are local variables to take a random number adults,children and senior_citizens
                    adults = random.randint(0, self.seats)
                    # to check the value of the movie to check if it above 18 or not
                    if self.movies[movie_key]:
                        children = 0
                    else:
                        children = random.randint(0, abs(adults - self.seats))

                    senior_citizens = random.randint(0, abs((children + adults) - self.seats))
                    # this condition for Friday to get the discount for senior citizen
                    if day == "Friday":

                        # make a local variable ticket_senior_discount which calculate the ticket price
                        # ticket - ((ticket/100) * percentage)
                        ticket_senior_discount = self.ticket_senior - ((self.ticket_senior / 100) * self.discount)
                        # calculate the revenue for each day
                        revenue = adults * self.ticket_adult + children * self.ticket_children + senior_citizens * ticket_senior_discount
                    else:
                        # calculate the revenue for each day
                        revenue = adults * self.ticket_adult + children * self.ticket_children + senior_citizens * self.ticket_senior
                    # total revenue to calculate the whole revenue
                    self.total_revenue += revenue
                    # to store them in week_days variable
                    self.week_days[day]["adults"] += adults
                    self.week_days[day]["children"] += children
                    self.week_days[day]["senior_citizens"] += senior_citizens
                    self.week_days[day]["revenue"] += revenue
                    # take the max revenue
                    if self.max_day < self.week_days[day]["revenue"]:
                        self.max_day = self.week_days[day]["revenue"]
                        self.max_day_name = day

    def print_max(self):
        """
        This method has two prints. The first one will print the revenue for each day on the week. The number of
        the adults , children and senior_citizens will be printed as well. The second one , it is printing the max
        day name and value.
        """

        # iterate through the days to print
        for day in self.week_days:
            print(
                f"{day} with revenue {self.week_days[day]['revenue']} , with number of adults "
                f"{self.week_days[day]['adults']}, number of child {self.week_days[day]['children']} "
                f"and number of senior citizens {self.week_days[day]['senior_citizens']} \n")
        print("------------------------------")
        print("The max revenue is ", self.max_day, " on", self.max_day_name, "\n")

    def movies_list(self, movies_list, above18):
        """
        This method will take two lists. The first list is about movie list with thier names. The second list is
        boolean values . the method will check the length of each list to confirm they are equals.
        """
        if len(movies_list) == len(above18):
            count = 0
            for movie in movies_list:
                self.movies[movie] = above18[count]
                count += 1
            # print(self.movies)
        else:
            print("Error , The length of the moviesList and above18List are different !!!")

    def total(self):
        """
        This method will print the total revenue for all weeks.
        """
        print(
            f"The total revenue of the whole weeks for simulate {self.simulate} is  {self.total_revenue}")

