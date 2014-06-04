require 'rubygems'
require 'torquebox-messaging'

queue = TorqueBox::Messaging::Queue.new('/queues/orders',
                                        :host => '127.0.0.1',
                                        :port => 5445)

order = {}
order[:ticker_symbol] = "AAPL"
order[:order] = "market"
order[:price] = "63045"
queue.publish order