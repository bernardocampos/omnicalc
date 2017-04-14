class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    downcase_text = @text.downcase
    downcase_text_without_punctuation = downcase_text.gsub(/[^a-z0-9\s]/i, '')
    downcase_text_split_into_array = downcase_text.split
    downcase_text_without_punctuation_split_into_array = downcase_text_without_punctuation.split

    @word_count = downcase_text_split_into_array.size

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = @text.size-@text.count(" ")

    @occurrences = downcase_text_without_punctuation_split_into_array.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    monthly_apr = @apr/12
    monthly_periods = @years*12

    @monthly_payment = (@principal*monthly_apr/100)/(1-(1+monthly_apr/100)**-monthly_periods)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    array = @numbers
    def median(array)
      sorted = array.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    @median = median(array)

    @sum = @numbers.sum

    @mean = @numbers.sum/@numbers.length

    squared_numbers = []
    @numbers.each do |num|
      square = num * num
      squared_numbers.push(square)
    end

    @variance = (squared_numbers.sum/@numbers.length - @mean**2)

    @standard_deviation = @variance**0.5

    # calculating mode
    unique_numbers = @numbers.uniq
    unique_numbers_occurrence = []
    unique_numbers.each do |num|
      unique_numbers_occurrence.push(@numbers.count(num))
    end
    most_occurrences = unique_numbers_occurrence.max
    mode = []
    unique_numbers.each do |num|
      if @numbers.count(num) == most_occurrences
        then mode.push(num)
      else
      end
    end
    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
