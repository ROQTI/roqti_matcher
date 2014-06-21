require 'rubygems'
require 'torquebox-messaging'

queue = TorqueBox::Messaging::Queue.new('/queues/orders',
                                        #:host => 'leibowitz.textsystems.net',
                                        :host => '127.0.0.1',
                                        :port => 5445)

order = {}
order[:ticker_symbol] = "3COM"
order[:order] = "market"
order[:price] = "864"
order[:direction] = "sell"
order[:num_shares] = 15
queue.publish order

