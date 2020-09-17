module Pageable
  extend ActiveSupport::Concern
  DEFAULT_PER_PAGE = 10

  module ClassMethods
    # parameter로 받는 limit 요청에 대해 (조작 가능)
    # per_page 값으로 제한
    def page(offset, limit, fields,
              order_field, order_method, per_page=DEFAULT_PER_PAGE)
      offset ||= 0
      limit ||= 10

      offset = offset.to_i
      limit = limit.to_i

      limit = per_page if limit > per_page

      items = order(order_field => order_method)
                .limit(limit)
                .offset(offset)
                .select(fields)      
    end
  end 
end