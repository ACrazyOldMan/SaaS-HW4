# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  # each returned element will be a hash whose key is the table header.
  # you should arrange to add that movie to the database here.
  # debugger
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#  ensure that that e1 occurs before e2.
#  page.content  is the entire content of the page as a string.
  regex=Regex.new(/#{e1}.*#{e2}/)
  found=page.body=~regex
  # debugger
  assert found
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check: (.*)/ do |uncheck, rating_list|
# HINT: use String#split to split up the rating_list, then
#   iterate over the ratings and reuse the "When I check..." or
#   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  boxes=rating_list.split(',')
  # debugger
  if uncheck==nil
    boxes.each{|b| check("ratings_#{b}")}
  else
    boxes.each{|b| uncheck("ratings_#{b}")}
  end
end

When /I sort by (\w+)/ do |by|
  click_link("#{by}_header")
end

Then /I should find (\w+)/ do |amount|
  debugger
  assert false
end

Then /I should(not)? find "(.*)"/ do |no,text|
  assert (no==nil and page.body=~text)
end

When /([\w\s]+) page for "([\w\s]+)"/ do |page,movie|
# debugger
  @movie=Movie.find(:first,:conditions => {:title => movie})

  if @movie!=nil
    case page
    when /edit/
      visit edit_movie_path(@movie)
    when /details/
      visit movie_path(@movie)
    end
  else
    visit movies_path
  end
end

Then /([\w]+) of "([\s\w]+)" should be "([\s\w]+)"/ do |field,movie,value|
  @movie=Movie.find(:first,:conditions => {:title => movie})
  debugger
  if @movie==nil
    assert false
  else
    assert @movie["#{field}"]==value
  end
end
