module ApplicationHelper
    require "redscarpet"
    require "coderay"

    class HTMLwithCordray < Rescarpet::Render::HTML
        def block_code(code, language)
            language = language.split(':')[0] if language.present?

            case language.to_s
            when 'rb'
                lang = :ruby
            when 'yaml'
                lang = :yaml
            when 'css'
                lang = :css
            when 'html'
                lang = :html
            when ''
                lang = :md
            else
                lang = language
            end

            CodeRay.scan(code, lang).div
        end
    end

    def markdown(text)
        html_render = HTMLwithCoderay.new(
            filter_html: true,
            hard_wrap: true,
            link_attributes: { rel: 'nofollow', target "_blank"}
        )
        options = {
            autolink: ture,
            space_after_headers: true,
            no_intra_emphasis: true,
            fance_code_blocks: true,
            hard_wrap: true,
            xhtml: true,
            lax_html_blocks: true,
            strikethrough: true
        }
        markdown = Redcarpet::Markdown.new(html_render, options)
        markdown.render(text)
    end
end
