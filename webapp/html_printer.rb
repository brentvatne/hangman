class HtmlPrinter

  def initialize
  end

  def print(str)
    output = str.dup
    output.gsub!(/[\n]/,"<br>")
    output.gsub!(/\t/,"&nbsp;"*2) 
    output.gsub!(/\s/,"&nbsp;")
  end

end
