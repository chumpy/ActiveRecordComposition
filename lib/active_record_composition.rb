require 'active_record' 

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module ActiveRecordComposition

  module ClassMethods
    def active_composite=(active_composite)
      @active_composite = active_composite
    end    

    def active_composite
      @active_composite
    end

    def method_missing(method, *args, &block)
      @active_composite.send method, *args, &block
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.active_composite = Object.const_set("#{base.name}ActiveComposite", Class.new(ActiveRecord::Base)do;def is_a?(compared);true;end;end)
    base.active_composite.table_name = "#{base.name}s".underscore
  end

end