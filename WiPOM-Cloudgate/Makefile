include $(TOPDIR)/rules.mk

PKG_NAME:=WiPOM-Cloudgate
PKG_VERSION:=1.0

include $(INCLUDE_DIR)/package.mk

define Package/WiPOM-Cloudgate
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=WiPOM-Cloudgate
  DEPENDS:=+libcg
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Compile
endef

define Build/InstallDev
endef

define Package/WiPOM-Cloudgate/install
	# Create target directory for "bin"
	$(INSTALL_DIR) $(1)/bin

	#Copy WRTU Server application to "bin" directory of image
	$(CP) ./files/bin/wipom-srv $(1)/bin/

	# Create target directory for "web"
	$(INSTALL_DIR) $(1)/web

	#Copy web files to "web" directory of image
	$(CP) ./files/web/* $(1)/web/

	$(CP) ./files/WiPOM-Cloudgate.init.sh $(1)/
	$(CP) ./files/WiPOM-Cloudgate.run.sh $(1)/
	$(CP) ./files/time-sync.run.sh $(1)/
	
endef

$(eval $(call BuildPackage,WiPOM-Cloudgate))
