class Student

  MIN_AVERAGE_GRADE = 85
  MAX_POOR_LIMIT = 15_000

  attr_reader :name, :id, :anual_income

  def initialize(name:, id:, anual_income:)
    @name = name
    @id = id
    @anual_income = anual_income
    @grades = []
  end

  def add_grade(grade)
    @grades << grade
    self
  end

  def display_personal_info_and_disclaimer
    display_personal_information
    display_disclaimer
  end

  def scholarship_worthy?
    raise 'This student has currently no grades.' if @grades.empty?

    good_grades = average >= MIN_AVERAGE_GRADE
    is_poor = @anual_income < MAX_POOR_LIMIT
    good_grades and is_poor
  end

  private

  def display_personal_information
    puts "Name: #{ @name } ID: #{ @id }"
    puts "Anual income: #{ @anual_income }"
    puts "Grade average: #{ average }"
  end

  def display_disclaimer
    puts 'The contents of this class must not be considered an offer,'
    puts 'proposal, understanding or agreement unless it is confirmed'
    puts 'in a document signed by at least five blood-sucking lawyers.'
  end

  def average
    @grades.sum / @grades.size.to_f
  end

end
