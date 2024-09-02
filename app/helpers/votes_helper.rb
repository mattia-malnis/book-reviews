module VotesHelper
  def vote_button(type, review)
    if current_user.present? && current_user.can_vote_review?(review)
      vote = current_user.get_vote_for_review(review)

      if vote.present? && vote.vote_type == type
        button_wrapper(type, vote_classes(type), review) do
          vote_button_content(type, review)
        end
      elsif vote.present?
        static_wrapper("text-gray-500") do
          vote_button_content(type, review)
        end
      else
        button_wrapper(type, hover_classes(type), review) do
          vote_button_content(type, review)
        end
      end
    else
      static_wrapper("text-gray-500") do
        vote_button_content(type, review)
      end
    end
  end

  private

  def vote_button_content(type, review)
    concat inline_svg_tag(vote_icon(type), class: "size-5")
    concat content_tag :span, review.send("#{type}_count"), class: "ml-1 text-sm"
  end

  def button_wrapper(type, class_name, review, &block)
    button_to send("toggle_#{type}_review_path", review), class: [ class_name, "flex items-center transition duration-150" ] do
      capture(&block)
    end
  end

  def static_wrapper(class_name, &block)
    content_tag :div, class: [ class_name, "flex items-center transition duration-150" ] do
      capture(&block)
    end
  end

  def vote_icon(type)
    type == "like" ? "hand-thumb-up.svg" : "hand-thumb-down.svg"
  end

  def vote_classes(type)
    type == "like" ? "text-green-500" : "text-red-500"
  end

  def hover_classes(type)
    type == "like" ? "text-gray-500 hover:text-green-500" : "text-gray-500 hover:text-red-500"
  end
end
