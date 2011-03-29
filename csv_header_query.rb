class CSV
  
  def self.sweep(file,options)
    ary = []
    if options[:headers]
      header_hash = options[:headers]
      query = header_hash.values
      query.map! {|x| Array(x.split('*'))}
      options[:headers] = nil
    else
      raise "Pass your headers in."
    end
    
    header_line = 0
    foreach(file,options) do |row|
      headers = query.map {|qu| qu.map {|q| row.find_index {|x| x =~ /#{q}/i}}.compact[0]}.compact
      if headers.size == query.size
        headers.each_with_index {|h,i| row[h] = header_hash.keys[i]}
        options[:headers] = row
        break
      end
      header_line += 1
    end
    
    if options[:headers]
      line_no = 0
      foreach(file,options) do |row|
        if line_no <= header_line
          line_no += 1
        else
          ary << (block_given? ? yield(row) : row.to_hash)
        end
      end
    else
      raise "Couldn't find header row."
    end
    ary
  end
  
end