module Jekyll
  class DirectiveTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @directive = text
    end

    def render(context)
      "<a href='/directives/#{@directive}.html'><code>#{@directive}</code></a>"
    end
  end
end

Liquid::Template.register_tag('directive', Jekyll::DirectiveTag)
