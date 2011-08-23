libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

%w(hangman/hangman_logic hangman/hangman_puzzle hangman/hangman_parser).each { |f| require f }

