ITEM.baseClass    = "base_pointshop_item"
ITEM.texture = 0
ITEM.cwAttachmentId = "not set"

-- Returns a Derma Control Name used to create the shop icon in normal mode
function ITEM.static:GetPointshopIconControl( )
    return "DPointshopTextureIcon"
end

-- Returns a Derma Control Name used to create the shop icon in lowend mode
function ITEM.static:GetPointshopLowendIconControl( )
    return "DPointshopTextureIcon"
end

-- Returns a derma icon that used in the inventory
function ITEM:getIcon( )
    self.icon = vgui.Create( "DPointshopTextureInvIcon" )
    self.icon:SetItem( self )
    return self.icon
end

-- Returns a 4x4 dimensioned icon
function ITEM.static.GetPointshopIconDimensions( )
    return Pointshop2.GenerateIconSize( 4, 4 )
end
