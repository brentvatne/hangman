class Hash

  def escape_html
    dup.escape_html!
  end

  def escape_html!
    each do |k,v|
      self[k].is_a?(String) ? self[k] = v.gsub(/[<]/,"&lt;").gsub(/[>]/,"&gt;") : self[k] 
    end
  end

end
