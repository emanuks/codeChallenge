#!/usr/bin/ruby
class ShoppingBasket
  def run
    products = []
    totalTax = 0
    total = 0
    while true do
      import_tax = 0
      basic_tax = 0

      puts "Please enter the product name and price:"
      product = gets.chop

      original_value = product.split(" ").last
      product.sub! " at #{original_value}", ""
      quantity = product.split(" ").first.to_i

      product_value = original_value.to_f.round(2)

      is_imported = product.upcase.include?("IMPORTED")

      if is_imported
        import_tax = ((original_value.to_f * 0.05 * 20).round) / 20.0
        product_value = (original_value.to_f + import_tax).round(2)
        totalTax += (import_tax * quantity).round(2)
      end

      is_exempt = product.upcase.include?("BOOK") || product.upcase.include?("CHOCOLATE") || product.upcase.include?("PILLS")

      unless is_exempt
        basic_tax = ((original_value.to_f * 0.1 * 20).round) / 20.0
        product_value = (product_value + basic_tax).round(2)
        totalTax += (basic_tax * quantity).round(2)
      end

      product_value = (product_value * quantity).to_f.round(2)
      total += product_value
      products.push({:name => product, :value => product_value})

      puts "Do you want to add another product? [Y/N]"
      break if gets.chop.upcase == "N" 
    end

    products.each do |product|
      puts "#{product[:name]}: #{product[:value]}"
    end
    puts "Sales Taxes: #{totalTax}"
    puts "Total: #{total.round(2)}"
  end
end