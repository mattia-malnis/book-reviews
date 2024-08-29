class StyledFormBuilder < ActionView::Helpers::FormBuilder
  INPUT_TYPES = [ :text_field, :email_field, :password_field, :number_field, :date_field, :text_area ]

  INPUT_TYPES.each do |input_type|
    define_method(input_type) do |method, options = {}|
      element_with_default_class(method, options) { super(method, options) }
    end
  end

  def check_box(method, options = {})
    default_class = "rounded border-gray-300 text-indigo-600 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 mr-2"
    element_with_default_class(method, options, default_class) { super(method, options) }
  end

  def label(method, options = {})
    default_class = "block text-sm font-medium text-gray-700 mb-1"
    element_with_default_class(method, options, default_class) { super(method, options) }
  end

  def submit(value = nil, options = {})
    default_class = "w-full py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    element_with_default_class(value, options, default_class) { super(value, options) }
  end

  private

  def element_with_default_class(method, options, default_class = "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50")
    options[:class] = options[:class] || default_class
    yield
  end
end
