module ApplicationHelper
  include Pagy::Frontend

  def alert_error(messages, title = "")
    return if messages.blank?

    messages = messages.join("<br>") if messages.is_a? Array

    content_tag :div, class: "bg-red-100 border-l-4 border-red-500 text-red-700 p-4", role: "alert", data: { turbo_cache: false } do
      concat content_tag :p, title, class: "font-bold" if title.present?
      concat content_tag :p, messages.html_safe
    end
  end

  ##
  # Helper to open a centered and overlayed modal with custom contents
  #
  # @example Basic usage
  #   <%= modal classes: "custom-class" do %>
  #     <div>Content here</div>
  #   <% end %>
  #
  def modal(options = {}, &block)
    content = capture(&block)
    render partial: "shared/modal", locals: { content:, classes: options[:classes], title: options[:title] }
  end

  def modal_form_for(record, options = {}, &block)
    options[:builder] = StyledFormBuilder
    options[:html] ||= {}
    options[:html][:class] = [ "min-w-[350px] space-y-6", options[:html][:class] ]
    options[:data] ||= {}
    options[:data][:action] = "turbo:submit-end->modal#closeOnSuccess" unless options[:data].key? :action
    form_for(record, options, &block)
  end
end
