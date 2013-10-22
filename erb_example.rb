require 'erb'

x = 42
pets = { cat: "fierce", dog: "loyal" }
furniture = ["windows", "curtain", "sofa"]

template = ERB.new "The value of x is: <%= x %>"
template_2 = ERB.new "Lots of pets here: <%= pets %>"
template_3 = ERB.new("
Lots of furniture:
<% furniture.each do |item| %>
  <%= item %>
<% end %>
")

puts template.result(binding)
puts template_2.result(binding)
puts template_3.result(binding)