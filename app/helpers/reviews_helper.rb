module ReviewsHelper
  def render_stars(rating, class_name = "size-4", max_stars = 5)
    full_stars = [ inline_svg_tag("star.svg", class: class_name) * rating ]
    empty_stars = [ inline_svg_tag("star-outline.svg", class: class_name) * (max_stars - rating) ]

    content_tag :span, class: "flex" do
      safe_join(full_stars + empty_stars)
    end
  end
end
