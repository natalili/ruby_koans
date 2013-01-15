class Module
  def attribute (symbol, &block_default_val)

    symbol_name = symbol.to_s
    var = '@'+ symbol_name

    if symbol.class == Hash

      val = (symbol.values)[0]
      symbol_name = (symbol.keys)[0]
      var = '@'+ symbol_name
      define_method (symbol_name) { instance_variable_set(var, val) unless instance_variables.include?(var.to_sym); 
                                    instance_variable_get(var) }

    elsif block_given?

      define_method (symbol_name) { instance_variable_set(var, instance_eval(&block_default_val)) unless instance_variables.include?(var.to_sym); 
                                    instance_variable_get(var) }

    else

      define_method (symbol_name) { instance_variable_get(var) }

    end

    define_method (symbol_name.to_s + "?") { instance_variable_defined?(var) }
    define_method (symbol_name.to_s + "=") { |val| instance_variable_set(var, val); 
                                             remove_instance_variable(var) if val == nil }
  
  end
end