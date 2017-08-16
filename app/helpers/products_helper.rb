module ProductsHelper
  def render_special_filter_class(product)
    if product.category.name == '各种肉'
      'meat'
    elsif product.category.name == '粗粮'
      'grain'
    elsif product.category.name == '地方特色'
      'someregion'
    end
  end
end
