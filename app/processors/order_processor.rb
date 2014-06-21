class OrderProcessor < TorqueBox::Messaging::MessageProcessor

  def on_message(message)
    puts "pop a message"
    puts message.to_s
    order = Order.new()
    order.ticker_symbol = message[:ticker_symbol]
    order.order = message[:order]
    order.offer_price = message[:price]
    order.direction = message[:direction]
    order.num_shares = message[:num_shares]
    order.save

    OrderBook.process_order(order)

  end

end