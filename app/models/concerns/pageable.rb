module Pageable
  extend ActiveSupport::Concern
  DEFAULT_PER_PAGE = 10

  module ClassMethods
    # parameter로 받는 limit 요청에 대해 (조작 가능)
    # per_page 값으로 제한
    def page(args)
      page         = args.fetch(:page, 1).to_i
      fields       = args.fetch(:fields, "id")
      order_field  = args.fetch(:order_field, "id")
      order_method = args.fetch(:order_method, "desc")
      per_page     = args.fetch(:per_age, DEFAULT_PER_PAGE).to_i

      page_info = page_calculate(page, per_page)
      _items = items(page_info[:self], per_page, fields, order_field, order_method)

      {
        length: _items.length,
        items: _items,
        total: page_info[:total],
        self: page_info[:self],
        first: page_info[:first],
        prev: page_info[:prev],
        next: page_info[:next],
        last: page_info[:last]
      }
    end
    private

    def items(page, per_page, fields, order_field, order_method)
      offset = (page * per_page) - per_page

      order(order_field => order_method)
        .limit(per_page)
        .offset(offset)
        .select(fields)
    end

    def page_calculate(page, per_page)
      total = all.length
      last = (total/per_page.to_f).ceil

      page = page.positive? ? page : 1
      page = page > last ? last : page
      _prev = page > 1 ? page - 1 : 1
      _next = page >= last ? last : page + 1
      _last = last
      
      {
        total: total,
        first: 1,
        self: page,
        prev: _prev,
        next: _next,
        last: last
      }
    end
  end 
end