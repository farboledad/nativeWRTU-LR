include $(TOPDIR)/rules.mk

PKG_NAME:=Bipom_root_enabler
PKG_VERSION:=1.0

include $(INCLUDE_DIR)/package.mk

define Package/Bipom_root_enabler
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=Bipom's Root enabler
  DEPENDS:=+libcg
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) -l src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CC="$(TARGET_CC)" LD="$(TARGET_LD)" CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)" LDFLAGS="$(TARGET_LDFLAGS) -lcg -lpthread"
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) $(PKG_BUILD_DIR)/bipom_root_enabler $(1)/bin/
endef

define Package/Bipom_root_enabler/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) $(PKG_BUILD_DIR)/bipom_root_enabler $(1)/bin/
	$(CP) ./files/Bipom_root_enabler.run.sh $(1)
	$(CP) ./files/dropbear.init $(1)/etc/init.d/dropbear
endef

$(eval $(call BuildPackage,Bipom_root_enabler))
