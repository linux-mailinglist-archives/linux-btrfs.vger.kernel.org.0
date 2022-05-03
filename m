Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD03518FD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiECVOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiECVOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 17:14:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4213D28
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651612262; x=1683148262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uOceQkNPy1RdH9dUTmsDhluJKfKYPUYBlMuvWAsPeGw=;
  b=MTYPL7Ifq4Z+zdJBx0nCS/Mpl1ZLgJ0892lkxmsAab/UczjhBXTMkOx/
   C8RuNCoSK0rFmfIwk9JMG5C7SoM0vtRLdIDuok0IciuA+xlw6NXWLmxB8
   1YVjC37XYmXOTb0FDe0vKGvMZ82fS9qhgYAjGW72w3lOGWc80wE4HWBKa
   zEl6Jd7KFaTtGpzUbcmOdCFBxauC07uvutflWaLryipnDSdg5J9V83QTu
   LuRRc3hjxwM2IFC/LDWXNfVJjXNltQ98lNJOG9ixcEfxwK3TXedPkrufk
   uLFborwGACfafFWwTkkTFu03nzs9vwhvoN/qkA6KSb2sCH5FJ6c+Ed3Cj
   g==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="199451685"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 05:11:02 +0800
IronPort-SDR: mhA5OhC2C36fRbNvZRraG3+euBXkqzULnVfwGYN+m+xmA+xm4desgiv5zBMvn/Nhq6BY6xIZSL
 l5sstHmNxbLEBdYDLQiYnI2XvUjdLsMbCr7noYD4UT7aI+FzTyEnMQ1lTk7gw1zw8CB0p7aRWW
 AdHO6TZRF3h/0lr5Wn0y2NWsqwxsBRqGrlmAul64QvBErgdb6z12ezEYXWHo6OixOHHJqNFgNW
 e42HM8Tkd86u8Of04cCNgAHyYvVrrgzQ7i0g67Ba4YjruKARHYnJYMjWNH4xJJrKeSt2YZcyzC
 nlsJvbOsIWZ3ZbcPu4C32Axb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 13:41:05 -0700
IronPort-SDR: yQl4jtgf51HXmZcBIeM3ldUDake7P5M4Y1hdqTUmOEpmoqbumBCh7oLMF2crHpmaJ6r6D9Eas8
 IoWHcgofzCBHjlvKgUyo7fttHhYlAIAjvpH9lTQbtk56FVrZnpt9fI2EUarXKhPwe2PMBuqdLt
 TONzZgBZJsqm8e7CB1fuWqKH6FgUOOnWbKte9BoSUZIl8n2A+gz7B7O7ylu3giPoFPJi4NlCBo
 XqoYqtDgBK5ABNDDX9pQf36qsn/F4TL0aPimokkpjbdXA0NZ6yMGRmOWTwzpt55TzUdLETeV5T
 5yM=
WDCIronportException: Internal
Received: from jpf008298.ad.shared (HELO naota-x1.wdc.com) ([10.225.48.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 May 2022 14:11:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: move non-changing condition check out of the loop
Date:   Tue,  3 May 2022 14:10:04 -0700
Message-Id: <c9416da0f7bdd4cd3d35a83ab340a29b95985c5a.1651611385.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651611385.git.naohiro.aota@wdc.com>
References: <cover.1651611385.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_zone_activate() checks if block_group->alloc_offset ==
block_group->zone_capacity every time it iterates the loop. But, it is not
depending on the index. Move out the check and do it only once.

Fixes: f9a912a3c45f ("btrfs: zoned: make zone activation multi stripe capable")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 997a96d7a3d5..80a86f26ab7b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1835,6 +1835,12 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		goto out_unlock;
 	}
 
+	/* No space left */
+	if (block_group->alloc_offset == block_group->zone_capacity) {
+		ret = false;
+		goto out_unlock;
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -1842,12 +1848,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
-		/* No space left */
-		if (block_group->alloc_offset == block_group->zone_capacity) {
-			ret = false;
-			goto out_unlock;
-		}
-
 		if (!btrfs_dev_set_active_zone(device, physical)) {
 			/* Cannot activate the zone */
 			ret = false;
-- 
2.35.1

