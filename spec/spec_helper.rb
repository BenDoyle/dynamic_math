require 'treetop'
load "lib/parser/basic_types_logic.rb"
load 'lib/parser/expression_logic.rb'
load 'lib/parser/unary_function_logic.rb'
load 'lib/parser/binary_function_logic.rb'
load 'lib/parser/binary_infix_logic.rb'
load 'lib/parser/trinary_function_logic.rb'
Treetop.load "lib/parser/basic_types"
Treetop.load "lib/parser/expression"
include Math

