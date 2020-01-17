Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4105140C14
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAQOHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:07:49 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45475 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:07:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id w30so21781758qtd.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlUpg2cEFzYg41WFbKBdA6FrmmT2W60E9jWCjGksHmY=;
        b=WloI92ryMS7gcTDCXSeZMABhPFlXU2b1S4ylKl3toWUEEpXOFs21GXCw4Ljpsv7DQ2
         II45HhIZJ+vIVtQUm2dHdZoSxJCYHozxb9A5CVKAhifXhBdd9nNYbthTrRt4AxoXbNcx
         o3QkaZKya6qvxFjTw/Xx4UWpcTmonvhzWNgO3zOfabFqAWgVcFugwCVSvarnkvIbk8J9
         g2e79gF+hH0zLCvvEP5WcJGg3mo8zAxug+DXaI+E0rij3BtZF+vMU31h/dbMMFu4TA/m
         DwP4DCnmd4Sp7P1j0jnPzl2a2SrOiRAHvItVWpDOs2wwaIxMLgJVR50GbpzcisudVCvw
         xGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlUpg2cEFzYg41WFbKBdA6FrmmT2W60E9jWCjGksHmY=;
        b=HLhX3wWWSWzC5f89USpNMWDYmR4CJd4VZDfQzmbuaMvz2zypi3VxRV5Qy9AgIAeHl0
         POrfQ2Ir9EmoM51w2yng/2pyDnzkgIyoREBFRxhqNukg2pAVs5KZNA/yobX1Zcn22y5Q
         rA5LoRtMiHVOl7fGQQHDSmO9CU5/zqGSdCMj1SagjvFoAKmMqRcN7y/wloxw/dRLMGdH
         OyAzryTQWxJRtpJW2vTzNsj77HkOKhFirHRMJN1ozs7+1DknNk44oN7OM4ebQn0ks6TJ
         Y8YWvrYWaCh7MkVu9bnZRVUn6m0fNVjkHBT+Xmfai47Fda+MXPt0+M2cLBsfKZGxJt3u
         91Sg==
X-Gm-Message-State: APjAAAV6SAoKIdijdlxqDQsq2iRDUiCRLL0JB+JRJ77cNbMAK9lUpguu
        EIj+CjtQrORIJcER/7eHx/wYGQaZbVB6Hg==
X-Google-Smtp-Source: APXvYqwW2yNwEPj39Ec5DbPohkZ2SuARXXEnvAg0lQtOeuFRlwXJOPgKvf/b0uAMM9V7aoUJVQw9OA==
X-Received: by 2002:ac8:4504:: with SMTP id q4mr7745726qtn.319.1579270067812;
        Fri, 17 Jan 2020 06:07:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w29sm13343807qtc.72.2020.01.17.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:07:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 3/3] btrfs: use btrfs_can_overcommit in inc_block_group_ro
Date:   Fri, 17 Jan 2020 09:07:39 -0500
Message-Id: <20200117140739.42560-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140739.42560-1-josef@toxicpanda.com>
References: <20200117140739.42560-1-josef@toxicpanda.com>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 37 ++++++++++++++++++++++++++-----------
 fs/btrfs/space-info.c  | 18 ++++++++++--------
 fs/btrfs/space-info.h  |  3 +++
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 71770d04b7a3..7e71ec9682d0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1191,7 +1191,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
-	u64 sinfo_used;
 	int ret = -ENOSPC;
 
 	spin_lock(&sinfo->lock);
@@ -1205,19 +1204,38 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 
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
-	if (force || (sinfo_used + num_bytes <= sinfo->total_bytes)) {
+	if (force) {
+		ret = 0;
+	} else if (sinfo->flags & BTRFS_BLOCK_GROUP_DATA) {
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
@@ -1225,9 +1243,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
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
index 537bc310a673..01297c5b2666 100644
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
@@ -639,13 +640,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 		return to_reclaim;
 
 	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (can_overcommit(fs_info, space_info, to_reclaim,
-			   BTRFS_RESERVE_FLUSH_ALL))
+	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
+				 BTRFS_RESERVE_FLUSH_ALL))
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
 
-	if (can_overcommit(fs_info, space_info, SZ_1M, BTRFS_RESERVE_FLUSH_ALL))
+	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
+				 BTRFS_RESERVE_FLUSH_ALL))
 		expected = div_factor_fine(space_info->total_bytes, 95);
 	else
 		expected = div_factor_fine(space_info->total_bytes, 90);
@@ -1004,7 +1006,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
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
2.24.1

