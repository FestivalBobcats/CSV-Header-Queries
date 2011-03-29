A CSV patch designed to allow scanning for headers and returning a hash of results.
-------------------------------------

Just drop it in your rails lib folder or require it in your project.

Usage
-----

    require 'csv'
    require 'csv_header_query'

    # Example:
    # a csv with headers 10 lines down
    # you need to build an array of IDs and quantities,
    # but you're unsure of whether ID will be called UPC or EAN
    # however you know one column will be ATS
    
    # just pass :headers => {} in with normal CSV options
    # you can also pass regex characters into your queries
    # * is the || operator that queries are split on
    
    # returns an array #=> [:upc,:qty]
    CSV.sweep(f,:headers => {:upc => 'UPC*EAN',:ats => '^qty*^aTs'})
   
