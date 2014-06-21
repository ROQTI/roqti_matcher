class OrderBook < ActiveRecord::Base

  def self.process_order(order)
    # the purpose is to process orders
    # if stocks are available remove them from the book, else post this order to the book
    # remember this is currently for specififed order prices, market orders come later


    matched_orders = check_order_book(order)


    if matched_orders.size == 0
      post_to_order_book(order)

      return nil
    end

    # we have sufficient shares to fulfill the order, so process it
    fulfilling_order = matched_orders[0]

    order.order_executed = 1
    order.executed_share_price = fulfilling_order.offer_price
    order.save

    fulfilling_order.delete



  end

  def self.check_order_book(order)

    transaction_direction = ""
    if order[:direction] == "buy"
      transaction_direction = "sell"
      order_matches = self.where(["ticker_symbol = ? and direction = ? and offer_price <= ?", order["ticker_symbol"], transaction_direction, order["offer_price"]]).order("offer_price").all()

    else
      transaction_direction = "buy"
      order_matches = self.where(["ticker_symbol = ? and direction = ? and offer_price >= ?", order["ticker_symbol"], transaction_direction, order["offer_price"]]).order("offer_price").all()

    end


    return order_matches

  end


  def self.post_to_order_book(order)

    new_posting = self.new()
    new_posting.ticker_symbol = order["ticker_symbol"]
    new_posting.direction = order["direction"]
    new_posting.offer_price = order["offer_price"]
    new_posting.num_shares = order["num_shares"]
    new_posting.order = order["order"]
    new_posting.save


  end


end
