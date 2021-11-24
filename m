Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89A345B772
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhKXJeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746258; x=1669282258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAF8tCKrfsF1dlOZtQHqLv9haS/aSIkxMYONzDacDjc=;
  b=IwTebhQb/xcSQv1xcTUEPvzpxa/UCHVmCXx7tnHB/M2BGfVl9RgiktOc
   6TIwi/LvIC4PHv/Dasi2rCxnP1I3yZXlWHX+e++0WDCyaltgy63E3QjQK
   TCwZLZaripnzN0GozaUKHJMpU6PST1f5nb6XChfzxj7IHTmnaHFGWRR1I
   bITOHYIt5dFXo3IslmKPugzSkEXhjxJ9Oz/FV2TTFCMXuxGyfgtt6Sves
   70y4qg3LQlIq3REVwEqt0OIZX0A727zFJOp15TrW5yr0wV5cKUUjc0UD6
   he+KJM2cUmDYnn7GKEyS/8xCz0Fgve3KfQPollyb5K7PUZhm5zg1jTHlq
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499358"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:30:58 +0800
IronPort-SDR: Kh/ngzCpIo856t3PNg7nYO3stiG4aoRqiLjlQpiHnbIpD4uGeEslAXXpUmNvTbUd+jdfnGwpCL
 yWpFMhKmlsuvlR12JjiL3OiROuMaagdeVni1swQkSlOTpWIaIEDs069SwLmEJUzIvhECqO4LYR
 xFfENTnpsS33lZcxhMX9xHjLZSTvHId9pA3V6g2GFtySxQuc8NbKyUn+2x53bJNCV4F2Yf3MlL
 O8xuJ4Q5j7JR+Jc93e6PcMdmcU7r5KON/poBDvVl/Lj8KHma2foGhbYNZ3Hb6Tb0QKTbh+0F2K
 hFKYBF+8aOy5oHpPGN/2jaBJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:51 -0800
IronPort-SDR: 9MdZC8rD0A0mBW943ngvwNij7PPjn2lzpa52K7uV2QN0tjokX4KHFK0R28sOzW8LrMG4TtJCcj
 8Rf2QqGWTQYBPvuryX+M7ia8ZCOmFYy5DTfjt4wwpsy2BbKhyN6qVN22kSZzZ3Wppv1rOS51VE
 PPd/33DZqUYZQSGNxeWH1q+zbXsXwPKVrOFr52NW9apLh4DDctkRohuoJeYgjJwF6lpMpqFrpx
 mTOxJEhJ1r14EjQoqXiyyP4vwDFlbB4+HOJJUEhhfFogR/8yxyhx12K3Fr99+0j2Xzj45VM//3
 zL8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:30:58 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 03/21] btrfs: zoned: sink zone check into btrfs_repair_one_zone
Date:   Wed, 24 Nov 2021 01:30:29 -0800
Message-Id: <8c38c2f9d1bee46ded4ec491e16398f2f5764200.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sink zone check into btrfs_repair_one_zone() so we don't need to do it in
all callers.

Also as btrfs_repair_one_zone() doesn't return a sensible error, just
make it a void function.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c |  3 +--
 fs/btrfs/scrub.c     |  4 ++--
 fs/btrfs/volumes.c   | 13 ++++++++-----
 fs/btrfs/volumes.h   |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1654c611d2002..96c2e40887772 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2314,8 +2314,7 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
-	if (btrfs_is_zoned(fs_info))
-		return btrfs_repair_one_zone(fs_info, logical);
+	btrfs_repair_one_zone(fs_info, logical);
 
 	bio = btrfs_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d175c5ab11349..30bb304bb5e9a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -852,8 +852,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	have_csum = sblock_to_check->pagev[0]->have_csum;
 	dev = sblock_to_check->pagev[0]->dev;
 
-	if (btrfs_is_zoned(fs_info) && !sctx->is_dev_replace)
-		return btrfs_repair_one_zone(fs_info, logical);
+	if (!sctx->is_dev_replace)
+		btrfs_repair_one_zone(fs_info, logical);
 
 	/*
 	 * We must use GFP_NOFS because the scrub task might be waiting for a
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae1a4f2a8af64..d0615256dacc3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8329,23 +8329,26 @@ static int relocating_repair_kthread(void *data)
 	return ret;
 }
 
-int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
+void btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 {
 	struct btrfs_block_group *cache;
 
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
 	/* Do not attempt to repair in degraded state */
 	if (btrfs_test_opt(fs_info, DEGRADED))
-		return 0;
+		return;
 
 	cache = btrfs_lookup_block_group(fs_info, logical);
 	if (!cache)
-		return 0;
+		return;
 
 	spin_lock(&cache->lock);
 	if (cache->relocating_repair) {
 		spin_unlock(&cache->lock);
 		btrfs_put_block_group(cache);
-		return 0;
+		return;
 	}
 	cache->relocating_repair = 1;
 	spin_unlock(&cache->lock);
@@ -8353,5 +8356,5 @@ int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 	kthread_run(relocating_repair_kthread, cache,
 		    "btrfs-relocating-repair");
 
-	return 0;
+	return;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b81306807493..ab30cf4236fa3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -637,6 +637,6 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
-int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+void btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.31.1

