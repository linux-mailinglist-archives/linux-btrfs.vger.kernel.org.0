Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6525910A20A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfKZQ0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:26:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41664 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKZQ0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:26:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id 59so16507942qtg.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8v3+6KOgjzXY+h4gMAjdnZf9bBbC3WEueqXUA31UTVQ=;
        b=gKdA8RYpNcZVilg4ENxMlt3uLOti6gIjtnpbfBF1kQPZshD+k6KevmYZOeIyGzXl70
         d0fVSvws1XMnsJUVycPB5w7BHkTLWFe/mhXXedGc+TOSJ3eTVP2BvmWq0a9dj+LPIifu
         2K4bRnGeYGIsSpiVGBsLR2C+e+TT+lzAdoK6Wp5dUkgPxHLaqTR44n14yuo71SP3FR9Y
         CaO9e1jPlgaoxuDbgbGCkxlPOqoeSUdz8ZZsVdUiwaMS/s/4WZZW6rpRjSK36+4YUta1
         uv/V9iaLVCbavxnzstDSJ8eVXJQhtF+1TyeaxdLeo95FUEL092RZzkZJXznb4Fe2aHDf
         oMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8v3+6KOgjzXY+h4gMAjdnZf9bBbC3WEueqXUA31UTVQ=;
        b=Lgi7p73TssMaclrznd970IZJdjMqSQU3i/M0birm6fkIIVKXQdN8bBn6+xUA5Tunrb
         Yty0ASKa/2suYNsx6Eq3UaYaV6ViHUadSvlr5ZzZKENC98OPZVU33LPE9RmTN8VvA2dX
         eFVj2RjryD6euSdojczYL/kwgkmPaeXr3jVHm4iA4b5OSUADpB7vxSIYAhBxe/rU0RdC
         wzvVyIumUZSVrwgTfMmnPZHwJrWlYPBoyNRDRV54mIpRYuXFQe5n6OO/9LNnsiVo9DHF
         rripifHAvoiei/vMYyrA3qtOTTj56gKjgu41hoLpohdwZIL1A4/9jwnHWhuEDDxaix/q
         kmvA==
X-Gm-Message-State: APjAAAXXyqICKa1TlNfUYwDfbpn6ZZXxClFzKmlLz8p5ToK39vqZn4bE
        ERnakGuKcnUo3ZvhH40PJ6h3lTxNizpWIw==
X-Google-Smtp-Source: APXvYqzpR62su+IwDXJU44x0+M2MM8xgypkEWbPlRkPFOVDy20P92OGLOv3Ape66qBkwi9B6Dyza2Q==
X-Received: by 2002:ac8:1b41:: with SMTP id p1mr27545975qtk.353.1574785567460;
        Tue, 26 Nov 2019 08:26:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s189sm590969qke.41.2019.11.26.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:26:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 4/4] btrfs: use btrfs_can_overcommit in inc_block_group_ro
Date:   Tue, 26 Nov 2019 11:25:56 -0500
Message-Id: <20191126162556.150483-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126162556.150483-1-josef@toxicpanda.com>
References: <20191126162556.150483-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

inc_block_group_ro does a calculation to see if we have enough room left
over if we mark this block group as read only in order to see if it's ok
to mark the block group as read only.

The problem is this calculation _only_ works for data, where our used is
always less than our total.  For metadata we will overcommit, so this
will almost always fail for metadata.

Fix this by exporting btrfs_can_overcommit, and then see if we have
enough space to remove the remaining free space in the block group we
are trying to mark read only.  If we do then we can mark this block
group as read only.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 35 ++++++++++++++++++++++++-----------
 fs/btrfs/space-info.c  | 19 ++++++++++---------
 fs/btrfs/space-info.h  |  3 +++
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5961411500ed..ca55eb6758d1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1184,7 +1184,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
-	u64 sinfo_used;
 	int ret = -ENOSPC;
 
 	spin_lock(&sinfo->lock);
@@ -1205,19 +1204,36 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
 		    cache->bytes_super - cache->used;
-	sinfo_used = btrfs_space_info_used(sinfo, true);
 
 	/*
-	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
-	 *
-	 * Here we make sure if we mark this bg RO, we still have enough
-	 * free space as buffer.
+	 * Data never overcommits, even in mixed mode, so do just the straight
+	 * check of left over space in how much we have allocated.
 	 */
-	if (sinfo_used + num_bytes <= sinfo->total_bytes) {
+	if (sinfo->flags & BTRFS_BLOCK_GROUP_DATA) {
+		u64 sinfo_used = btrfs_space_info_used(sinfo, true);
+
+		/*
+		 * Here we make sure if we mark this bg RO, we still have enough
+		 * free space as buffer.
+		 */
+		if (sinfo_used + num_bytes <= sinfo->total_bytes)
+			ret = 0;
+	} else {
+		/*
+		 * We overcommit metadata, so we need to do the
+		 * btrfs_can_overcommit check here, and we need to pass in
+		 * BTRFS_RESERVE_NO_FLUSH to give ourselves the most amount of
+		 * leeway to allow us to mark this block group as read only.
+		 */
+		if (btrfs_can_overcommit(cache->fs_info, sinfo, num_bytes,
+					 BTRFS_RESERVE_NO_FLUSH))
+			ret = 0;
+	}
+
+	if (!ret) {
 		sinfo->bytes_readonly += num_bytes;
 		cache->ro++;
 		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
-		ret = 0;
 	}
 out:
 	spin_unlock(&cache->lock);
@@ -1225,9 +1241,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(cache->fs_info,
 			"unable to make block group %llu ro", cache->start);
-		btrfs_info(cache->fs_info,
-			"sinfo_used=%llu bg_num_bytes=%llu",
-			sinfo_used, num_bytes);
 		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
 	}
 	return ret;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index df5fb68df798..01297c5b2666 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -159,9 +159,9 @@ static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
 	return (global->size << 1);
 }
 
-static int can_overcommit(struct btrfs_fs_info *fs_info,
-			  struct btrfs_space_info *space_info, u64 bytes,
-			  enum btrfs_reserve_flush_enum flush)
+int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
+			 struct btrfs_space_info *space_info, u64 bytes,
+			 enum btrfs_reserve_flush_enum flush)
 {
 	u64 profile;
 	u64 avail;
@@ -226,7 +226,8 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 
 		/* Check and see if our ticket can be satisified now. */
 		if ((used + ticket->bytes <= space_info->total_bytes) ||
-		    can_overcommit(fs_info, space_info, ticket->bytes, flush)) {
+		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
+					 flush)) {
 			btrfs_space_info_update_bytes_may_use(fs_info,
 							      space_info,
 							      ticket->bytes);
@@ -639,14 +640,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 		return to_reclaim;
 
 	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (can_overcommit(fs_info, space_info, to_reclaim,
-			   BTRFS_RESERVE_FLUSH_ALL))
+	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
+				 BTRFS_RESERVE_FLUSH_ALL))
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
 
-	if (can_overcommit(fs_info, space_info, SZ_1M,
-			   BTRFS_RESERVE_FLUSH_ALL))
+	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
+				 BTRFS_RESERVE_FLUSH_ALL))
 		expected = div_factor_fine(space_info->total_bytes, 95);
 	else
 		expected = div_factor_fine(space_info->total_bytes, 90);
@@ -1005,7 +1006,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 */
 	if (!pending_tickets &&
 	    ((used + orig_bytes <= space_info->total_bytes) ||
-	     can_overcommit(fs_info, space_info, orig_bytes, flush))) {
+	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
 		ret = 0;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 1a349e3f9cc1..24514cd2c6c1 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -127,6 +127,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 				 enum btrfs_reserve_flush_enum flush);
 void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info);
+int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
+			 struct btrfs_space_info *space_info, u64 bytes,
+			 enum btrfs_reserve_flush_enum flush);
 
 static inline void btrfs_space_info_free_bytes_may_use(
 				struct btrfs_fs_info *fs_info,
-- 
2.23.0

