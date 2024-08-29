module Books::ReviewsHelper
  def rating_field(f)
    content_tag :div, class: "flex flex-row-reverse justify-end items-center" do
      (1..5).reverse_each.map do |rating|
        f.radio_button(:rating, rating, class: "peer -ms-5 size-5 bg-transparent border-0 text-transparent cursor-pointer appearance-none checked:bg-none focus:bg-none focus:ring-0 focus:ring-offset-0") +
        f.label("rating_#{rating}", class: "peer-checked:text-yellow-400 text-gray-300 pointer-events-none") do
          inline_svg_tag("star.svg", class: "size-6 shrink-0")
        end
      end.join.html_safe
    end
  end

  def user_is_creator?(review)
    review.user_id == current_user&.id
  end
end
