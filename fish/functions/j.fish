function j
	switch $argv[1]
        	case code
        		cd ~/Code
        	case dot
        		cd ~/.config
		case home
			cd ~
        	case '*'
        		echo "❌ Unknown shortcut '$argv[1]'"
        		echo "Available options: code, dot"
    	end
end
