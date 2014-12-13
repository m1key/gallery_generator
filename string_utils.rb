def tabs(how_many_tabs)
  tabs = ""
  how_many_tabs.times do
    tabs += "\t"
  end
  return tabs
end

def add_tabs_before_every_line(multi_line_string, how_many_tabs)
  result = ""
  multi_line_string.each_line do |line|
    result += tabs(how_many_tabs) + line
  end
  return result
end

