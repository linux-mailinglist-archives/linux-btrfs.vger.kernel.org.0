Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0D7CBC28
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJQHXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjJQHXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 03:23:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D9B6
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697527420; x=1729063420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZWI9xHUjCRPlbHpcV6Q/2v6CdgxkXxO0BUrS4FcKgKw=;
  b=VfFylbbepVkzY3P0FDHig101rJnswQR260hpC/ZIZyuxM+uOKCcVFY3R
   ReQKcjC8aiOrKxY5X1dVBjlHj4h67/QmWnoX54J9NnUmqighfWTA4ooIH
   xN54lkcAxd6og1M9edcKT0UFTOqzomkkM1vuSGIX6q/4xopTpUljL0RYX
   eyOwrFmu00/EqCcV+KXix1UaOeMUfAvTc7FOi0FVDOPw/qQ6LfqgEX6UO
   PLjZO3PFRA85TfcJ2i9lPVFdyX8oZjwhPQxZEtEqtLtbv9Unq7PowNMhI
   bQCVz+GEFrGCY4dkdjunYEEvp6d0W3OF2U39FayRCQq6y5BbYadGBlCkS
   Q==;
X-CSE-ConnectionGUID: e02rhxIER4yL+sDNj1MgBw==
X-CSE-MsgGUID: hM7YFB4iTtu3W3bQZyQ8aQ==
X-IronPort-AV: E=Sophos;i="6.03,231,1694707200"; 
   d="scan'208";a="352079775"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2023 15:23:36 +0800
IronPort-SDR: BHIs6XmWYbW6a5IoJnIQXE0uLcU3oubmX8q+G/V/fFY8WBT6HUNQGGxd3cQEPPzSHcwHwNbNpR
 WICXDUPYPNjIlB4yCaEZaPny4YWUp/UwWFqHDlHvZkcDrdqk5HzxCjpmKsyhNzWm5cRi/b6p2W
 TiH/NImalcrqyhXjjKVg7YvvapkvaWPe56+75tWus0oOsl+xqhtUHB+I8QkHZy3tnyOsjI06LE
 hJacouvDY/rn/MatZBIlL9A1FPzNTYUxhtZDPVPVa9kB/Yq2xdoXCGwY+xeux35Sk/H4o53/cd
 aCM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2023 23:29:58 -0700
IronPort-SDR: P7+Habe//dLXtZyM0a2uFAK+sJHgbs658ecPiBOkyEcQ+0I+ykqDxCqvvvRO+zpCX4yujhsUaR
 7P0abvVcYvF275/sc6PqszPZjzoPzzmx8QDBe3LfmQdTbneQqdZ0a23eyE0KtSrgm1ztJIZcec
 7ti80/ekp3Q0PTXbWxUHqbSYIHe1QQBe5sCgiwXCsgHC+vtVO9aaGRvfT9iqnnh6OcAYjx0Gnt
 GwVlbq1qopYhGlGxGcvQjKcxaTzk0AscRba7OMQ2deKNuJl9u4BZQsrQWIICKI3D0kRJimNj7d
 pN0=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.39])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Oct 2023 00:23:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: drop no longer valid write pointer check
Date:   Tue, 17 Oct 2023 16:23:22 +0900
Message-ID: <c3b77b1b1b0c33ad8e51d055b97dde3d1874669e.1697527349.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a check of the write pointer vs the zone size to reject an invalid
write pointer. However, as of now, we have RAID0/RAID10 on the zoned
mode, we can have a block group whose size is larger than the zone size.

As an equivalent check against the block group's zone_capacity is already
there, we can just drop this invalid check.

Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3504ade30cb0..188378ca19c7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1661,13 +1661,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
-	if (cache->alloc_offset > fs_info->zone_size) {
-		btrfs_err(fs_info,
-			"zoned: invalid write pointer %llu in block group %llu",
-			cache->alloc_offset, cache->start);
-		ret = -EIO;
-	}
-
 	if (cache->alloc_offset > cache->zone_capacity) {
 		btrfs_err(fs_info,
 "zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
-- 
2.42.0

