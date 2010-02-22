Given /^the following people exist$/ do |table|
  table.hashes.each  do |hash|
    Person.create(hash)
  end
end

Then /^I should have ([0-9]+) person\/people$/ do |count|
  Person.count.should == count.to_i
end