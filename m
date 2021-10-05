Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431C7421ECE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJEGZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61147 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEGZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415008; x=1664951008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkOZzVuaaa34XAOELRY3PAn+4zw/JTz3Eo2eWbT34NE=;
  b=UdXD1OkkaAD5azTD43KJR9aVmBZEhFrVtICWZrBx42Jw6GcgPk9+RnJ/
   rUDHQjvQ9hgCpHYURJhB2HQpVQq/nGwUMja11F/q//bRBAwyM132yrJgh
   jhgFZbmhkgh/C+69cItrHV3gk5ro5q2HsUH9WXPa/nYoFZmVZSh3munxf
   Rtk/ut7lvirulx84arzFwwsRcmL5x/8VWFpRFNmjJme/UezT1r1QaAcnf
   fyDxD4eW4BPKUigC4Q/giz6MbTbX+zQQ7cHAL1BKPhZB5CF5I6M07MEqS
   ldFhme2tHl0/1rLeIsXACzHovIv/tZjQf2wR2tQH2o6+b3c1wIN2AuR0I
   A==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648910"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:28 +0800
IronPort-SDR: B1GJAYAK6W5vvjuOnKiq9U90+7awDecDwlxpuAiShKu2c+LlxMYGiAMWSZa5Rbi3CVngoMgjoh
 EcAQcGk+hG/8lxpFykeMbQZ3aJ1VAGjpsyIm9tPTbHav2VF6F4HK1KYY49f02oYn84KGay+UlG
 XZ7Oe9LvhTGfpJqo92xqoW25yvpF2+2coTiprXunTj6VKfhqXidIgimVsDodqNRwPoCTYrsFZa
 I8LKzL0IJipDjW484HN8zwQXLkQQddYbUKT1TT5/mpPjHl7MaoEHduvvm05E1VVzPegxTZAtOx
 VPn/auSebuaXCyxluE3MFDd6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:52 -0700
IronPort-SDR: Y1W2rjn35dCkGFkR5YA8teOlIpRWgEguIRgj7WYfZRGgr1BquifFPHyyINIHbXJw1Ldn6UbgVs
 9w/GbkyQYmXblckSHvHe1NhW98bjjc76dd/MzmiasZty9qvOSpr6D9CuJ7O/kUZ1PLpaxyrzmh
 WSxjW38iV5TR3sbhHgfgdmTDDE2v/gfoj0okinct39y05zkjTu/Bg1v0jC8Zk67QcJ1v8TQeno
 dRTSjYz0dHldf7NzAQKsG8T/DSQtGc4p2evdSt4rM/tm31JWju9ucasEf8VnKObolgSDFabqRS
 1D8=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/7] btrfs-progs: mkfs: do not set zone size on non-zoned mode
Date:   Tue,  5 Oct 2021 15:22:59 +0900
Message-Id: <20211005062305.549871-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since zone_size() returns an emulated zone size even for non-zoned device,
we cannot use cfg.zone_size to determine the device is zoned or not. Set
zone_size = 0 on non-zoned mode.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 mkfs/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 8a4c9523d601..314d608a5cc5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1357,7 +1357,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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

