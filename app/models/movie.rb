class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.similar(field,value)
    return all(:conditions=>{field=>value})
  end
end
