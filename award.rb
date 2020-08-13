BLUE_FIRST = 'Blue First'
BLUE_COMPARE = 'Blue Compare'
BLUE_DESTINATION_PLUS = 'Blue Distinction Plus'

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def expired?
    @expires_in < 0
  end

  def non_blue_award?
    !@name.start_with?('Blue')
  end

  def blue_first_or_blue_compare?
    @name == BLUE_FIRST || name == BLUE_FIRST
  end

  def positive_quality?
    @quality > 0
  end

  def blue_distinction_plus?
    @name == BLUE_DESTINATION_PLUS
  end

  def blue_compare?
    @name == BLUE_COMPARE
  end

  def blue_star?
    @name == 'Blue Star'
  end

  def blue_first?
    @name == BLUE_FIRST
  end

  def decrease_expiration
    @expires_in -= 1
  end

  def handle_blue_first_or_blue_compare
    increase_quality if @quality < 50
    increase_quality if blue_compare? && @expires_in < 11
    increase_quality if blue_compare? && @expires_in < 6
  end

  def blue_first_or_blue_compare?
    @name == BLUE_COMPARE || name == BLUE_FIRST
  end

  def decrease_quality
      @quality -= 1 if (@quality > 0)
  end

  def increase_quality
    @quality += 1 if (@quality < 50)
  end

  def handle_expired_award
    decrease_quality if non_blue_award?
    @quality = 0 if @name == BLUE_COMPARE
    increase_quality if @name == BLUE_FIRST
  end

  def handle_blue_star
    2.times do
      decrease_quality if @quality > 0
    end
    if expired?
      2.times do
        decrease_quality if @quality > 0
      end
    end
  end

end
