Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A243418E19
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 06:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhI0ERn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 00:17:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhI0ERn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 00:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632716165; x=1664252165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/l4cq9TGo0kQv2G0Ba0Hgy0tDfVjlT9cii1DaH4ioOs=;
  b=UkuYMWBWNVM8DKF+xkqW03N+N5933MyTD/9iUiRG9Bolr198/uqOuWe9
   XSA7MO2ZLc9iYmdt7eOohrpFEmfArL9CjnE1/j0aIBPoFPON8qOp6Nb9a
   HNvj1g5mtm2/9B4Z+KklnsG0jK4iBamwZCqrihVqbSs+xOBvrkZqTppcB
   0WXgg97aUidtyTUjQMNjgTHG2+zIRu4ElfseqDIeXD0DJD7yPNU1WEqVw
   9djoBLrQAHdeF4NSLI08JggE49uzvr6zajQQsq2zELMQa3ey7XHzk7pTZ
   QVoFBg7u9WdSgWVpCXUqZki6LcDz/ZJO7yCExeQJQ/juIGdpi557ZdIyP
   A==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180095510"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 12:16:05 +0800
IronPort-SDR: jPghYG4XRX1eqDvm8UcfOxUZ58/6UlQWXGxLaPyUbfQ/8wJMsuOlBkYTVWscdeLHCjxMkysMXZ
 rqctKyxTDWlqknINAvvfQ+2iYdM/rMu76MuWHdn3l0wcFcLv4VpxO747c17pjQv2uHco6tjmmS
 7gUmqzaF/GwAoeBXrNrWFdnp9JhUGrT0NXs18bY61f78BRbY9R6+hLwMKnW9OjFife1rpyoVI1
 2TxYvQbUCLLE3pbavCToK6jgziRvo8jBd1vTN3gCDQS7+YDSKpdYTsyaBLh0OuF/6KA2dTt3+w
 N530bQdGAGTsn1GVG8eqkDsH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:50:39 -0700
IronPort-SDR: UR6L+3f6OhoRjEgrqvAjl/5iiHH0J4D8LybwQ3G2pVMb03ugFmzf5I4V3+VX64FsyVXR1DQ28y
 W6FidthbIBoYZcYGPDg8G00I40GosxmtSlQQJwJxzrqzrTh8Fqx49ZNSv+EWtLHq3rj1uEKP0D
 5Yj00ZGOVYM2T4kybooLamO+mzMWlfS5MimZAlb4UhEktabf1ekv4ocEhor+mb0q/wOaYIQ4gS
 u3r3AWVlKxTM2OU4anKOpswmXMGe9HPexmBasiWo+LLd19uXJ7AUrv60jewko1VLpAZ6+3qkEt
 9RA=
WDCIronportException: Internal
Received: from 1r3v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2021 21:16:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/5] btrfs-progs: mkfs: do not set zone size on non-zoned mode
Date:   Mon, 27 Sep 2021 13:15:50 +0900
Message-Id: <20210927041554.325884-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927041554.325884-1-naohiro.aota@wdc.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since zone_size() returns an emulated zone size even for non-zoned device,
we cannot use cfg.zone_size to determine the device is zoned or not. Set
zone_size = 0 on non-zoned mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 6f3d6ce42c5d..b925c572b2b3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1355,7 +1355,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.features = features;
 	mkfs_cfg.runtime_features = runtime_features;
 	mkfs_cfg.csum_type = csum_type;
-	mkfs_cfg.zone_size = zone_size(file);
+	if (zoned)
+		mkfs_cfg.zone_size = zone_size(file);
+	else
+		mkfs_cfg.zone_size = 0;
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
-- 
2.33.0

