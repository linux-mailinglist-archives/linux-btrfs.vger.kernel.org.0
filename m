Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F546BDB6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhLGOc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:32:59 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19470 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbhLGOcP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638887325; x=1670423325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Np7bLlm8RRwPb5YKg+QHqcfnrkgErjrFD9/+I5aeMU=;
  b=K0BxGr/Be/V48+WhAw0cqSDOOENJNDyFBX3sV8QgDTVOjcxM33kh3JsP
   udxP9+JhrN+o5JOb75umMKReLvKV2V4u3zCxsU40f/K7CC1kKDutDQs9n
   1SrYvzZpxiLK6eLEFrY6yyRw+p1CtgG4VmTv2RFSf7Ev8eSXvaqLIvD2Y
   gES9nfdDJOypjZosLOaQlfZtye9lrXNJ/Me9DAg7Tnjvovp3KlQgeBBNw
   hX/FB3ioQkzBT4RrbSRyCI+Y9kdy0qp1y9kRFQj+oiIpJFinPZjOaeqId
   J1OphbOO5yOPieo2JHgFGmuKGpcnBjTkLhy45acfqLmS7xn2jK7JUg/2p
   w==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="299501479"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 22:28:45 +0800
IronPort-SDR: UVmNWxxblP2b9ZmKccEZRPQIJGcbnyBWzxLfw8ChvlPfwFdOSRWGrl3rC4fiu+ZVaHT1+cEp3Q
 tBYv3ys7fEzBV/bAU+DhpcxH96aTgdkdjU+tJsnNRUxronkqvoA7rlBDgOd3mKtLalxP9Sz3uv
 jVV0ZGtVQGzOflhz/rJuzQfg488ivyqJf+EhcPU8rnUEJfMELATtzUtwNDz1yiBsI5SwW+ff19
 dNYBhWCaKfpbAx1OuerYFzNEHXQ1EP7yq1lrOJPHyuljcTwR/kyH8H3/Fi4GOkk0skghgaHehY
 KLGUYC2cODLp90HiJmRMcfnk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:01:50 -0800
IronPort-SDR: ymMUtiDw3BWBZbshrt17S4POGYNpNFawk3r32JxV54TiMvGkGO2iN/wohfEKAKWffv5EQyMQH2
 D0Y/ihVL+rgs0D+v9WeF9pPuI6xSJ8nh7a00oNacENQQ3KMu4dE/P2LpTJcJA53I8N8/nIoryX
 sIkR4jhNDCnRnTGhtlOYTeNA/rXg/GWCxQlAOIZoDsPJQjfJH5Yy2OTj07if63Ovm1fqwgyxHX
 k0CQJbLuOmeqcXeu/L/CFE73MTToJZ2Rw555DUj0Ktq0x7jsivQJEOsgFXgHgqEYxl6IZshfRT
 fJ4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 06:28:45 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 3/4] btrfs: zoned: sink zone check into btrfs_repair_one_zone
Date:   Tue,  7 Dec 2021 06:28:36 -0800
Message-Id: <aaf1d6f8dddf6d9bbdc3a6a7a6b55cfd74cea6a1.1638886948.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638886948.git.johannes.thumshirn@wdc.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sink zone check into btrfs_repair_one_zone() so we don't need to do it in
all callers.

Also as btrfs_repair_one_zone() doesn't return a sensible error, make it a
boolean function and return false in case it got called on a non-zoned
filesystem and true on a zoned filesystem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  4 ++--
 fs/btrfs/scrub.c     |  4 ++--
 fs/btrfs/volumes.c   | 13 ++++++++-----
 fs/btrfs/volumes.h   |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cc27e6e6d6ce..5a7350145cc3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2314,8 +2314,8 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
-	if (btrfs_is_zoned(fs_info))
-		return btrfs_repair_one_zone(fs_info, logical);
+	if (btrfs_repair_one_zone(fs_info, logical))
+		return 0;
 
 	bio = btrfs_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 15a123e67108..a4369ded86eb 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -852,8 +852,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	have_csum = sblock_to_check->pagev[0]->have_csum;
 	dev = sblock_to_check->pagev[0]->dev;
 
-	if (btrfs_is_zoned(fs_info) && !sctx->is_dev_replace)
-		return btrfs_repair_one_zone(fs_info, logical);
+	if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logical))
+		return 0;
 
 	/*
 	 * We must use GFP_NOFS because the scrub task might be waiting for a
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f38c230111be..a7071f34fe64 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8339,23 +8339,26 @@ static int relocating_repair_kthread(void *data)
 	return ret;
 }
 
-int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
+bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 {
 	struct btrfs_block_group *cache;
 
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
 	/* Do not attempt to repair in degraded state */
 	if (btrfs_test_opt(fs_info, DEGRADED))
-		return 0;
+		return true;
 
 	cache = btrfs_lookup_block_group(fs_info, logical);
 	if (!cache)
-		return 0;
+		return true;
 
 	spin_lock(&cache->lock);
 	if (cache->relocating_repair) {
 		spin_unlock(&cache->lock);
 		btrfs_put_block_group(cache);
-		return 0;
+		return true;
 	}
 	cache->relocating_repair = 1;
 	spin_unlock(&cache->lock);
@@ -8363,5 +8366,5 @@ int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 	kthread_run(relocating_repair_kthread, cache,
 		    "btrfs-relocating-repair");
 
-	return 0;
+	return true;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b8130680749..9cf1d93a3d66 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -637,6 +637,6 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
-int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.31.1

