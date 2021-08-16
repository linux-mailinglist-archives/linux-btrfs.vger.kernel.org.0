Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23753ED321
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhHPLfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 07:35:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26133 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhHPLfs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 07:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629113716; x=1660649716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlRcQlBRkQWQdWDEtM/I9pi7lCNrocCw88DX9CYSz1g=;
  b=PUZqCMFDfoUBB44trsp9QuuF4756+tUCsg3tcdHqcqQvPRZHqs4aKJnE
   8u/AVEZdVLHonEVFc569TpgvsToLTWWB4ATiGGIhOl7taEz9j8sjH2bb7
   M54wzpzUE6/AmN+4OMQu+yEWgcizh3IdR60sDKjV3+paQUMu5V/tUKY0t
   TkxlNUYtslC0jEs+X4iMyFcRZdGi15DSybPzdbISPxlFsoT5F0E7uMm5V
   IZI+YrynSh1S2NIu8cVKJ45oEmyvcOHMygR8vDj1oGpz8KoZbhiLHYOMW
   1naZSQu3Ag7VjCO2k22t9h8LrOqVLiEjklzOZwCdpOpE/HrrbH5KIBzGQ
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="182172005"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 19:35:14 +0800
IronPort-SDR: 46BlYXP++dpxD2Tr0QzEob9phX0FmGMpbeYW/h4dXEr1zAo+C35B1Adxn8ZiwypBbo32rQk2Db
 NFlctx0CmW9onEMykRs00xYxJjvQRf+Uyh1dCg2OhVXFKofpIuI7+c4jHx6E0L/mZpK86XiJus
 vrkfXx0izgXVIHRcE6tn+dkdDdZZmDMRQnSX3ZTm72nBTpSRap2je41GALYHoMuoj7JYV9NkyD
 ucI30vxhhUd2aYJOZXzaFeOhb/vBuAaT1R5k0Z+S8OnuE0/5Dd9NRmUeVf9G4UiCv8iINOUo1O
 DSFJ92mON2MVj9Lkty5s78O1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 04:10:40 -0700
IronPort-SDR: cbBEukHUbKGdXGfuQUUkiDl2YJF1MocgzYJ3xsir3k5rRK63iEaEzHKRlo1bCYKhjzZQGOzqqT
 ojJyC1nQNiJehqH4bFoflGuSnI72gmh5K+GPJO4LNAdebG9HnwQYDozHrmS/+7i+ennpGdmE24
 xXnOOBF8nLvZu22qqObza3p52JslZgaK2JjA35DJFRl1NE7taWelLxffUZ9QfI3tPXfbVokmrN
 nWjognobWqdrXiTRFiJQa7w7Hv6edAOW/JQkiTst5K5Q31zXF690bayPKVlO4VJ6F4pOeNMAHM
 fbg=
WDCIronportException: Internal
Received: from ind008647.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Aug 2021 04:35:15 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/3] common: add zoned block device checks
Date:   Mon, 16 Aug 2021 20:35:08 +0900
Message-Id: <20210816113510.911606-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816113510.911606-1-naohiro.aota@wdc.com>
References: <20210816113510.911606-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dm-error and dm-snapshot does not have DM_TARGET_ZONED_HM nor
DM_TARGET_MIXED_ZONED_MODEL feature and does not implement
.report_zones(). So, it cannot pass the zone information from the down
layer (zoned device) to the upper layer.

Loop device also cannot pass the zone information.

This patch requires non-zoned block device for the tests using these
ones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/rc b/common/rc
index 84757fc1755e..e0b6d50854c6 100644
--- a/common/rc
+++ b/common/rc
@@ -1837,6 +1837,9 @@ _require_loop()
     else
 	_notrun "This test requires loopback device support"
     fi
+
+    # loop device does not handle zone information
+    _require_non_zoned_device ${TEST_DEV}
 }
 
 # this test requires kernel support for a secondary filesystem
@@ -1966,6 +1969,16 @@ _require_dm_target()
 	if [ $? -ne 0 ]; then
 		_notrun "This test requires dm $target support"
 	fi
+
+	# dm-error cannot handle the zone information
+	#
+	# dm-snapshot and dm-thin-pool cannot ensure sequential writes on
+	# the backing device
+	case $target in
+	error|snapshot|thin-pool)
+		_require_non_zoned_device ${SCRATCH_DEV}
+		;;
+	esac
 }
 
 _zone_type()
-- 
2.32.0

