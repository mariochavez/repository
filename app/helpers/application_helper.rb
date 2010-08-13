module ApplicationHelper

    def new_child_fields_template(form_builder, association, options = {})
      options[:object]              ||= form_builder.object.class.reflect_on_association(association).klass.new
      options[:partial]             ||= association.to_s.singularize
      options[:form_builder_local]  ||= :f
      content_for :multi_upload do
        content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
          form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|        
            render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })        
          end
        end
      end
    end

    def add_child_link(name, association)
      # As per stan class was set to newattach, it should be set to something else like "new-#{association}" though
      link_to(name, "#", :class => "add_child newattach", :"data-association" => association)
    end
    
    def remove_child_link(name, f)
      f.hidden_field(:_destroy) + link_to(name, "#", :class => "remove_child")
    end
  
end
