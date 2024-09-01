module ReviewsHelper
  def render_stars(rating, max_stars = 5)
    full_stars = [ inline_svg_tag("star.svg", class: "size-4") * rating ]
    empty_stars = [ inline_svg_tag("star-outline.svg", class: "size-4") * (max_stars - rating) ]

    content_tag :span, class: "flex" do
      safe_join(full_stars + empty_stars)
    end
  end
end
