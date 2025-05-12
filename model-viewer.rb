module Jekyll
    class ModelViewerTag < Liquid::Tag
  
      def initialize(tag_name, markup, tokens)
        super
        @attributes = {}
  
        # Parse attributes like src="..." width="..." etc.
        markup.scan(/(\w+)="(.*?)"/) do |key, value|
          @attributes[key.downcase] = value
        end
  
        # Handle empty flags like disable-zoom
        markup.scan(/(\w+)(?=\s|$)/) do |key|
          @attributes[key[0].downcase] ||= true unless @attributes.key?(key[0].downcase)
        end
      end
  
      def render(context)
        content = ""
      
        # Per-page model viewer script injection
        unless context['model_viewer_loaded']
          content << '<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>'
          context['model_viewer_loaded'] = true
        end
      
        src = @attributes["src"]
        alt = @attributes["alt"] || "Model Viewer"
      
        style = ""
        style << "width:#{@attributes['width']};" if @attributes['width']
        style << "height:#{@attributes['height']};" if @attributes['height']
        style << "aspect-ratio:#{@attributes['aspect_ratio']};" if @attributes['aspect_ratio']
        style << "border:#{@attributes['border']};" if @attributes['border']
      
        model_viewer_attrs = []
        model_viewer_attrs << "src=\"#{src}\""
        model_viewer_attrs << "alt=\"#{alt}\""
        model_viewer_attrs << "ar ar-modes=\"webxr scene-viewer quick-look\""
        model_viewer_attrs << "environment-image=\"neutral\""
        model_viewer_attrs << "auto-rotate camera-controls"
        model_viewer_attrs << "disable-zoom" if @attributes["disable-zoom"]
        model_viewer_attrs << "exposure=\"#{@attributes['exposure']}\"" if @attributes['exposure']
        model_viewer_attrs << "shadow-intensity=\"#{@attributes['shadow_intensity']}\"" if @attributes['shadow_intensity']
        model_viewer_attrs << 'style="width:100%;height:100%;"'
      
        html = ""
        html << "<div style=\"#{style}\">"
        html << "<model-viewer #{model_viewer_attrs.join(" ")}></model-viewer>"
        html << "</div>"
      
        # Add blank lines before and after to prevent Markdown escaping
        "\n\n#{content}#{html}\n\n"
      end      
    end
  end
  
  Liquid::Template.register_tag('modelviewer', Jekyll::ModelViewerTag)
  
