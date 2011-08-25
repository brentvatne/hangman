require 'sanitize'
class Hash

  def sanitize
    dup.sanitize!
  end

  def sanitize!
    each do |k,v|
      self[k] = Sanitize.clean(v).strip
    end
    self
  end

end

#   a = %w[foo bar]
#    a = Hash
#    #  Hash.[]
#    a[1]  # => a.send(:[], 1) 
