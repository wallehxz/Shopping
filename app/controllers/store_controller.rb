require 'will_paginate'
class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.paginate :page=>params[:page],
                                 :order=>'created_at desc' ,
                                 :per_page => 2
    @cart = current_cart
  end
end
