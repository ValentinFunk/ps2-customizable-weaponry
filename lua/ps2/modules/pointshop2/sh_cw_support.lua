-- Generate Pointshop 2 Item Classes for each attachment
function generateCwClasses( )
    for cwAttachmentName, cwAttachmentTable in pairs(CustomizableWeaponry.registeredAttachmentsSKey) do
        -- Generate the class
        local className = 'cw_' .. cwAttachmentName
        local ps2Item = Pointshop2.GenerateItemClass( className, 'base_cw_attachment', 'CW 2.0 Support' )
        -- Set the variables
        ps2Item.PrintName = cwAttachmentTable.displayName
        ps2Item.cwAttachmentName = cwAttachmentName
        ps2Item.texture = cwAttachmentTable.displayIcon
        -- Put the stats description into a single string
        local description = LibK._(cwAttachmentTable.description or {}):chain():pluck("t"):join('\n'):value()
        description = description .. '\n\nYou don\'t need to equip this item. Once bought use the CW menu to attach it to your weapon.'
        ps2Item.Description = description
    
        KInventory.Items[className] = ps2Item
        KLogf(4, "Generated item KInventory.Items.%s for CW2.0 Attachment %s", className, cwAttachmentName )
    end
end

if SERVER then
    Pointshop2.ModuleItemsLoadedPromise:Then( generateCwClasses )
else
    hook.Add( "PS2_ModulesLoaded", "generateClasses", generateCwClasses )
end

hook.Add("CW20HasAttachment", "PS2_HasCwAttachment", function( ply, attachmentName )
    -- Make CW recognize attachments in the inventory
    -- Return if the player's inventory is not yet loaded
    if not ply.PS2_Inventory then return end
    
    -- Go over the player's entire inv
    local baseCwAttachment = Pointshop2.GetItemClassByName( 'base_cw_attachment' )
    for k, item in pairs( ply.PS2_Inventory:getItems( ) ) do
        -- Check if the current item uses the base_cw_attachment base
        if instanceOf( baseCwAttachment, item ) then
            -- Then check if this is the attachment we're looking for
            if item.class.cwAttachmentName == attachmentName then
                return true
            end
        end
    end

    -- Player doesn't have it, return nothing instead of
    -- false to allow other hooks to run as well
    return
end )
