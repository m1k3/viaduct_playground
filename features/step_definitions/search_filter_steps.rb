Given /^the following search_filter.features:$/ do |search_filter.features|
  SearchFilter.feature.create!(search_filter.features.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) search_filter.feature$/ do |pos|
  visit search_filter.features_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following search_filter.features:$/ do |expected_search_filter.features_table|
  expected_search_filter.features_table.diff!(tableish('table tr', 'td,th'))
end
