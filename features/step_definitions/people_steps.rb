Given /^the following "([^\"]*)" exist$/ do |model, table|
  table.hashes.each  do |hash|
    model.classify.constantize.create(hash)
  end
end

Then /^I should have ([0-9]+) person\/people$/ do |count|
  Person.count.should == count.to_i
end