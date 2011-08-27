require 'sanitize'
class Hash

  def sanitize_html
    dup.sanitize_html!
  end

  def sanitize_html!
    each do |k,v|
      self[k] = Sanitize.clean(v).strip
    end
    self
  end

end
