module Jekyll
  class DirectiveTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @directive = text
      @directive.strip!
    end

    def render(context)
      "<a href='/directives/#{@directive}.html'><code>#{@directive}</code></a>"
    end
  end
  class MarkdownDirectiveTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @directive = text
      @directive.strip!
    end

    def render(context)
      "[#{@directive}](/directives/#{@directive}.html)"
    end
  end
end

Liquid::Template.register_tag('directive', Jekyll::DirectiveTag)
Liquid::Template.register_tag('mkddirective', Jekyll::MarkdownDirectiveTag)
