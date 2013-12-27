
--set destinationFolder to POSIX path of "Users:dhammy0110:GDrive:receipts_biz"
set destinationFolder to "/Users/dhammy0110/GDrive/receipts_biz/"
set frontApp to "Doxie"
set exitloop to 0

activate application frontApp

tell application "System Events"
	--	set frontApp to name of first application process whose frontmost is true
	log "frontApp = " & (frontApp)
	
	-- pause to let program start up
	delay 5
	try
		tell process frontApp
			-- pause to let importing finish
			set exitcount to 0
			repeat while (exists sheet "Doxie Import" of window frontApp) & (exitloop ≤ 1500)
				delay 0.2
				set exitloop to exitloop + 1
				log "import timer exitloop = " & (exitloop)
			end repeat
			
			-- Press ⌘a
			delay 1
			keystroke "a" using {command down}
			
			repeat until exists window frontApp
				delay 0.2
			end repeat
			
			-- Press ⌥⌘s
			keystroke "s" using {option down, command down}
			
			set exitloop to 0
			repeat until exists sheet 1 of window frontApp
				delay 0.2
				set exitloop to exitloop + 1
				log "save not available exitloop = " & (exitloop)
				if exitloop ≥ 50 then
					return
					log "save function not available timeout"
				end if
			end repeat
			
			-- Press ⌘⇧g to open open the finder folder selector
			tell window frontApp
				keystroke "g" using {command down, shift down}
				
				-- wait for the finder folder sheet to open
				set exitloop to 0
				repeat until exists sheet 1
					delay 0.2
					set exitloop to exitloop + 1
					log "open finder folder exitloop = " & (exitloop)
					if exitloop ≥ 50 then
						return
						log "open finder folder timeout"
					end if
				end repeat
				
				--get entire contents of front window
				--get every UI element
				
				-- set the file path and press 'go'
				tell sheet 1
					set value of text field of sheet 1 to destinationFolder
					click button "Go" of sheet 1
					
					-- wait for the sheet to close
					set exitcount to 0
					repeat while exists sheet 1
						delay 0.2
						set exitloop to exitloop + 1
						if exitloop ≥ 50 then
							return
							log "close finder folder timeout"
						end if
					end repeat
				end tell
				
				-- save the sheet using whichever button is present at the time (for some reason it varies)
				if exists (button "Choose" of sheet 1) then
					click button "Choose" of sheet 1
				else
					click button "Save" of sheet 1
				end if
				set exitcount to 0
				repeat while exists sheet 1
					delay 0.2
					set exitloop to exitloop + 1
					if exitloop ≥ 1500 then
						return
						log "save function timeout"
					end if
				end repeat
				
				-- close doxie
				keystroke "q" using {command down}
				
				-- wait for quit dialog to appear, let system handle timeout
				repeat until exists sheet 1
					delay 0.2
				end repeat
				
				-- answer question to delete all saved files
				click button "Delete" of sheet 1
				
				-- wait for the sheet to close, let system handle timeout
				repeat while exists sheet 1
					delay 0.2
				end repeat
				
			end tell
		end tell
	end try
end tell
