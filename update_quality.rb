require 'award'
require 'pry'


def update_quality(awards)
awards.each do |award|
  return if award.blue_distinction_plus?

  award.decrease_quality if award.non_blue_award?

  award.handle_blue_first_or_blue_compare if award.blue_first_or_blue_compare?

  award.decrease_expiration

  award.decrease_expiration if award.blue_distinction_plus?

  award.handle_expired_award if award.expired?
end



def legacy_update_quality(awards)
  awards.each do |award|
    puts "award: #{award.inspect}"

    if award.blue_compare? && award.expires_in == 11
      binding.pry
    end
    # decrement non blue award
    if !award.blue_first_or_blue_compare?
      if award.quality > 0
        if award.positive_quality? && !award.blue_distinction_plus?
          puts "decrement"
          award.quality -= 1
        end
      end
    else
      # handle blue first or blue compare
      if award.quality < 50
        award.quality += 1
        puts "increment"
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
                puts "increment"
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
                puts "increment"
            end
          end
        end
      end
    end
    # handle non blue distinction plus
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    # handle expired
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1
                puts "decrement"
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
            puts "increment"
        end
      end
    end
    puts "end: award: #{award.inspect}"
  end
end

end
