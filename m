Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C465A2220
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiHZHmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Aug 2022 03:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245373AbiHZHmS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Aug 2022 03:42:18 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00579AC250
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Aug 2022 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661499738; x=1693035738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UXSES7MiNYy5EH1ZhRjGfRrxa7MNehxDDyRbkTW7VRM=;
  b=i196fJsNG1gYjWg72D/xO09sJJnHd47ntQiFuHlHHcD3KyXBmPMk1EFo
   M6r5OIwa/JPcSfP6aUyvDKtaOY5To3/jbUHAWfgYXJd7hsqMYe91NK9cy
   ZnYPwmek2Pt+oybgktM3QNvecT9ws6RpoCicjVln7ItkrVtKjf7sE+/uZ
   AgFpg4R6RWreDtgxYS5bl3BXnwF64y20JSIkyojjR1oDcDOuZ/AyWezrE
   MFZzcupmbBwFyce2s/7WQZtNOAxyFXi/6EwoQ+mFANuwx6r3TSbye+Ar6
   7S0Cq90VzicDzIR7WABsQyn6IaJ0/z4XJZG+hVsCyxL+kMJxn0ICFrZRb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="210224174"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 15:42:17 +0800
IronPort-SDR: Yqwu+NbM/EjUJcj9k3eI361vESVkMn4U2OTelINfH0PDMzQ3BCsWGqSDASvZR5/HVQKHz4bnCP
 4fISWI0nK+27dYC/c9zvwVvEF77NSa5yv3sSqhvwy+a7tPuPgAUjTFILewLnFyX+Gz8yhLD4LY
 WGXok8k1zjqZP7jzbaxj4yEjATyVtnGBDhxQYM1U6+ztTq8riYIn9QRB6oUOwog2C9J6Rd0aVr
 CqeQvKSAYbB722iwtVXA1F6bJVn1eBPhunp7WUg6+04teeT8jupvXtCXA/Z+LskSegzk23aKt4
 tHbCQZ1YHMAcmDi3AYgW3Alc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2022 00:02:53 -0700
IronPort-SDR: mL2RuY3Dbdo2fTXm6BvE9GDjkKSPAvAHix48YsYRsrOlFn3KTVP2roZiClz8XL9WMCkqk1DiA4
 HtqG7uT4IohlVQ4AMlL2fFO+2HYsHc0Bht+DzOuFik6TkeBCJeobkPoPCCL6e9P4Bvo9vZcndH
 ksTT+6HTsryb7ZA08jJihekmJsFzB+kgaqDAMvbDZk50eUjT4AiNv+6vjJjwEYq55JhKNw0Nr2
 qHIPsA84q/pieG0GbKlbieN48ZECiR7rZrdq51ERjmthUkePro5nzTpYKPBxJDDb3KPPsmj7/G
 BVY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Aug 2022 00:42:16 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] btrfs: zoned: set pseudo max append zone limit in zone emulation mode
Date:   Fri, 26 Aug 2022 16:42:15 +0900
Message-Id: <20220826074215.159686-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
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

The commit 7d7672bc5d10 ("btrfs: convert count_max_extents() to use
fs_info->max_extent_size") introduced a division by
fs_info->max_extent_size. This max_extent_size is initialized with max
zone append limit size of the device btrfs runs on. However, in zone
emulation mode, the device is not zoned then its zone append limit is
zero. This resulted in zero value of fs_info->max_extent_size and caused
zero division error.

Fix the error by setting non-zero pseudo value to max append zone limit
in zone emulation mode. Set the pseudo value based on max_segments as
suggested in the commit c2ae7b772ef4 ("btrfs: zoned: revive
max_zone_append_bytes").

Fixes: 7d7672bc5d10 ("btrfs: convert count_max_extents() to use fs_info->max_extent_size")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Improved comment description as suggested
* Added missing type cast to u64

 fs/btrfs/zoned.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b150b07ba1a7..9a920dfa7b83 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -421,10 +421,19 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
 	 * increase the metadata reservation even if it increases the number of
 	 * extents, it is safe to stick with the limit.
+	 *
+	 * With the zoned emulation, we can have non-zoned device on the zoned
+	 * mode. In this case, we don't have a valid max zone append size. So,
+	 * use max_segments * PAGE_SIZE as the pseudo max_zone_append_size.
 	 */
-	zone_info->max_zone_append_size =
-		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
-		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
+	if (bdev_is_zoned(bdev)) {
+		zone_info->max_zone_append_size = min_t(u64,
+			(u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
+			(u64)bdev_max_segments(bdev) << PAGE_SHIFT);
+	} else {
+		zone_info->max_zone_append_size =
+			(u64)bdev_max_segments(bdev) << PAGE_SHIFT;
+	}
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
-- 
2.37.1

