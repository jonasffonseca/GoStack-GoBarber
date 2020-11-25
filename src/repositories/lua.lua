M={}

function M.outbound_INVITE(msg)
    --[[
          This function does all required Webex Express translations
          This will change outgoing INVITE RequestURI and To header.
          RequestURI will be changed to have
              1. Webex Express DNS SRV for a Webex region
              2. x-cisco-site-uuid parameter
          To header will be changed to have
              1. Access number
          Warning: Any manual changes to this script will lead failures in
                   connecting to Webex Express
	  Note: Below are the recommended "Memory Threshold" and "Lua Instruction Threshold" values
                in Cisco Unified CM "Normalization Script Configuration"
              1. Memory Threshold          : 200 kilobytes
              2. LUA Instruction Threshold : 3000 instructions

    --]]

    -- Phone number to access number mapping
    -- key = dialed number, value = access number
    -- Mapping for Webex Numbers
    dialinNumberToAccessNumberTable = {}
    dialinNumberToAccessNumberTable["16044493026"] = "6886044493026"
    dialinNumberToAccessNumberTable["81345105877"] = "68881345105877"
    dialinNumberToAccessNumberTable["995706770640"] = "688995706770640"
    dialinNumberToAccessNumberTable["552120181635"] = "688552120181635"
    dialinNumberToAccessNumberTable["914226480337"] = "688914226480337"
    dialinNumberToAccessNumberTable["27110308394"] = "68827110308394"
    dialinNumberToAccessNumberTable["61385939163"] = "68861385939163"
    dialinNumberToAccessNumberTable["911416480337"] = "688911416480337"
    dialinNumberToAccessNumberTable["97237370084"] = "68897237370084"
    dialinNumberToAccessNumberTable["31207219836"] = "68831207219836"
    dialinNumberToAccessNumberTable["4535158857"] = "6884535158857"
    dialinNumberToAccessNumberTable["5117063270"] = "6885117063270"
    dialinNumberToAccessNumberTable["541152468603"] = "688541152468603"
    dialinNumberToAccessNumberTable["35227300071"] = "68835227300071"
    dialinNumberToAccessNumberTable["81645604684"] = "68881645604684"
    dialinNumberToAccessNumberTable["4532725996"] = "6884532725996"
    dialinNumberToAccessNumberTable["911726480337"] = "688911726480337"
    dialinNumberToAccessNumberTable["6492805246"] = "6886492805246"
    dialinNumberToAccessNumberTable["302119902392"] = "688302119902392"
    dialinNumberToAccessNumberTable["908503902281"] = "688908503902281"
    dialinNumberToAccessNumberTable["46851992509"] = "68846851992509"
    dialinNumberToAccessNumberTable["56442081207"] = "68856442081207"
    dialinNumberToAccessNumberTable["16026660783"] = "6886026660783"
    dialinNumberToAccessNumberTable["38513309390"] = "68838513309390"
    dialinNumberToAccessNumberTable["4721933787"] = "6884721933787"
    dialinNumberToAccessNumberTable["914064802006"] = "688914064802006"
    dialinNumberToAccessNumberTable["38518848050"] = "68838518848050"
    dialinNumberToAccessNumberTable["34912158235"] = "68834912158235"
    dialinNumberToAccessNumberTable["498995460918"] = "688498995460918"
    dialinNumberToAccessNumberTable["13062711492"] = "68813062711492"
    dialinNumberToAccessNumberTable["12404540887"] = "6882404540887"
    dialinNumberToAccessNumberTable["911164802006"] = "688911164802006"
    dialinNumberToAccessNumberTable["437203800460"] = "688437203800460"
    dialinNumberToAccessNumberTable["5078347223"] = "6885078347223"
    dialinNumberToAccessNumberTable["3226200866"] = "6883226200866"
    dialinNumberToAccessNumberTable["35315268384"] = "68835315268384"
    dialinNumberToAccessNumberTable["18299531734"] = "68818299531734"
    dialinNumberToAccessNumberTable["40215891419"] = "68840215891419"
    dialinNumberToAccessNumberTable["15064064641"] = "6885064064641"
    dialinNumberToAccessNumberTable["34935452897"] = "68834935452897"
    dialinNumberToAccessNumberTable["40311305283"] = "68840311305283"
    dialinNumberToAccessNumberTable["37052141637"] = "68837052141637"
    dialinNumberToAccessNumberTable["19049002303"] = "6889049002303"
    dialinNumberToAccessNumberTable["380893239708"] = "688380893239708"
    dialinNumberToAccessNumberTable["5117070358"] = "6885117070358"
    dialinNumberToAccessNumberTable["61892100016"] = "68861892100016"
    dialinNumberToAccessNumberTable["12045151147"] = "68812045151147"
    dialinNumberToAccessNumberTable["60392125516"] = "68860392125516"
    dialinNumberToAccessNumberTable["827074885000"] = "688827074885000"
    dialinNumberToAccessNumberTable["525588808000"] = "688525588808000"
    dialinNumberToAccessNumberTable["358981710278"] = "688358981710278"
    dialinNumberToAccessNumberTable["43720815317"] = "68843720815317"
    dialinNumberToAccessNumberTable["50321368237"] = "68850321368237"
    dialinNumberToAccessNumberTable["41225675770"] = "68841225675770"
    dialinNumberToAccessNumberTable["3619993984"] = "6883619993984"
    dialinNumberToAccessNumberTable["12028602110"] = "6882028602110"
    dialinNumberToAccessNumberTable["442031988143"] = "688442031988143"
    dialinNumberToAccessNumberTable["37052047000"] = "68837052047000"
    dialinNumberToAccessNumberTable["12062071700"] = "6882062071700"
    dialinNumberToAccessNumberTable["46850535291"] = "68846850535291"
    dialinNumberToAccessNumberTable["61293382212"] = "68861293382212"
    dialinNumberToAccessNumberTable["3728801809"] = "6883728801809"
    dialinNumberToAccessNumberTable["19027067113"] = "6889027067113"
    dialinNumberToAccessNumberTable["61283175553"] = "68861283175553"
    dialinNumberToAccessNumberTable["358985677820"] = "688358985677820"
    dialinNumberToAccessNumberTable["38618282130"] = "68838618282130"
    dialinNumberToAccessNumberTable["420225296037"] = "688420225296037"
    dialinNumberToAccessNumberTable["4723503756"] = "6884723503756"
    dialinNumberToAccessNumberTable["15874043573"] = "6885874043573"
    dialinNumberToAccessNumberTable["12268289662"] = "68812268289662"
    dialinNumberToAccessNumberTable["35724022512"] = "68835724022512"
    dialinNumberToAccessNumberTable["31207989146"] = "68831207989146"
    dialinNumberToAccessNumberTable["3614292374"] = "6883614292374"
    dialinNumberToAccessNumberTable["50321367244"] = "68850321367244"
    dialinNumberToAccessNumberTable["33173443278"] = "68833173443278"
    dialinNumberToAccessNumberTable["85230705008"] = "68885230705008"
    dialinNumberToAccessNumberTable["61390706485"] = "68861390706485"
    dialinNumberToAccessNumberTable["12133063065"] = "6882133063065"
    dialinNumberToAccessNumberTable["14156550001"] = "6884156550001"
    dialinNumberToAccessNumberTable["16137149906"] = "68816137149906"
    dialinNumberToAccessNumberTable["902129003455"] = "688902129003455"
    dialinNumberToAccessNumberTable["27216722338"] = "68827216722338"
    dialinNumberToAccessNumberTable["16469922010"] = "6886469922010"
    dialinNumberToAccessNumberTable["5078387654"] = "6885078387654"
    dialinNumberToAccessNumberTable["14387974001"] = "6884387974001"
    dialinNumberToAccessNumberTable["5713289113"] = "6885713289113"
    dialinNumberToAccessNumberTable["914846480337"] = "688914846480337"
    dialinNumberToAccessNumberTable["17206507664"] = "6887206507664"
    dialinNumberToAccessNumberTable["74951080249"] = "68874951080249"
    dialinNumberToAccessNumberTable["74952284391"] = "68874952284391"
    dialinNumberToAccessNumberTable["50640027561"] = "68850640027561"
    dialinNumberToAccessNumberTable["6567036942"] = "6886567036942"
    dialinNumberToAccessNumberTable["35227870190"] = "68835227870190"
    dialinNumberToAccessNumberTable["541159842766"] = "688541159842766"
    dialinNumberToAccessNumberTable["85230081541"] = "68885230081541"
    dialinNumberToAccessNumberTable["914716480337"] = "688914716480337"
    dialinNumberToAccessNumberTable["48222953887"] = "68848222953887"
    dialinNumberToAccessNumberTable["390230578297"] = "688390230578297"
    dialinNumberToAccessNumberTable["4961967819734"] = "6884961967819734"
    dialinNumberToAccessNumberTable["35929358687"] = "68835929358687"
    dialinNumberToAccessNumberTable["13068082023"] = "68813068082023"
    dialinNumberToAccessNumberTable["61863889975"] = "68861863889975"
    dialinNumberToAccessNumberTable["13652042000"] = "68813652042000"
    dialinNumberToAccessNumberTable["914464803377"] = "688914464803377"
    dialinNumberToAccessNumberTable["17874995216"] = "68817874995216"
    dialinNumberToAccessNumberTable["13125358110"] = "6883125358110"
    dialinNumberToAccessNumberTable["38618888979"] = "68838618888979"
    dialinNumberToAccessNumberTable["918064802006"] = "688918064802006"
    dialinNumberToAccessNumberTable["97233762897"] = "68897233762897"
    dialinNumberToAccessNumberTable["61884614712"] = "68861884614712"
    dialinNumberToAccessNumberTable["917126480337"] = "688917126480337"
    dialinNumberToAccessNumberTable["420296180454"] = "688420296180454"
    dialinNumberToAccessNumberTable["913364803377"] = "688913364803377"
    dialinNumberToAccessNumberTable["918246480337"] = "688918246480337"
    dialinNumberToAccessNumberTable["12509004337"] = "6882509004337"
    dialinNumberToAccessNumberTable["912264802006"] = "688912264802006"
    dialinNumberToAccessNumberTable["917316480337"] = "688917316480337"
    dialinNumberToAccessNumberTable["16173150704"] = "6886173150704"
    dialinNumberToAccessNumberTable["61870790395"] = "68861870790395"
    dialinNumberToAccessNumberTable["37166091167"] = "68837166091167"
    dialinNumberToAccessNumberTable["551138788450"] = "688551138788450"
    dialinNumberToAccessNumberTable["41445750284"] = "68841445750284"
    dialinNumberToAccessNumberTable["16474841598"] = "68816474841598"
    dialinNumberToAccessNumberTable["15813197414"] = "68815813197414"
    dialinNumberToAccessNumberTable["3228953996"] = "6883228953996"
    dialinNumberToAccessNumberTable["6531573057"] = "6886531573057"
    dialinNumberToAccessNumberTable["912064803377"] = "688912064803377"
    dialinNumberToAccessNumberTable["37164881865"] = "68837164881865"
    dialinNumberToAccessNumberTable["15033889555"] = "6885033889555"
    dialinNumberToAccessNumberTable["390699748086"] = "688390699748086"
    dialinNumberToAccessNumberTable["995706771022"] = "688995706771022"
    dialinNumberToAccessNumberTable["421233329280"] = "688421233329280"
    dialinNumberToAccessNumberTable["551131818559"] = "688551131818559"
    dialinNumberToAccessNumberTable["302111981021"] = "688302111981021"
    dialinNumberToAccessNumberTable["35627782847"] = "68835627782847"
    dialinNumberToAccessNumberTable["3726715925"] = "6883726715925"
    dialinNumberToAccessNumberTable["35924903058"] = "68835924903058"
    dialinNumberToAccessNumberTable["48225364066"] = "68848225364066"
    dialinNumberToAccessNumberTable["61730674845"] = "68861730674845"
    dialinNumberToAccessNumberTable["918216480337"] = "688918216480337"
    dialinNumberToAccessNumberTable["61732437915"] = "68861732437915"
    dialinNumberToAccessNumberTable["14692107159"] = "6884692107159"
    dialinNumberToAccessNumberTable["6493390171"] = "6886493390171"
    -- Mapping for Customized Numbers (This section is populated only if there are Custom Phone Numbers)
    -- Fetch the Phone number from Request Line
    local method, requestURI, ver = msg:getRequestLine()
    local getPhoneNumber = string.gmatch(requestURI, "%d+")
    local phoneNumber = getPhoneNumber()

    -- Add access number to To Header
   if dialinNumberToAccessNumberTable[phoneNumber] ~= nil then
    local oldTo = msg:getHeader("To")
    local newTo = string.gsub(oldTo, "<sip:.+@", "<sip:" .. dialinNumberToAccessNumberTable[phoneNumber] .. "@" )
    msg:modifyHeader("To", newTo)
   end

    -- Update Request URI with Webex Express URL and site uuid
    local newRequestURI = string.gsub(requestURI, "sip:(.+)@(.*)", "sip:%1@ecccx.amer.pub.webex.com;x-cisco-site-uuid=b10465a9e1ae7073e053ad06fc0ac25c")
    msg:setRequestUri(newRequestURI)

   -- Update To header with CCAX URL
    local oldTo1 = msg:getHeader("To")
    local newTo1 = string.gsub(oldTo1, "<sip:(.+)@(.*)>", "<sip:%1@ecccx.amer.pub.webex.com>")
    msg:modifyHeader("To", newTo1)
end

return M
