Return-Path: <linux-btrfs+bounces-13262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006BFA97CF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F47A708A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9661265604;
	Wed, 23 Apr 2025 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kj4ssm6m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D886264A67
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376268; cv=none; b=NvZy81cJ3k7aQh6vxxorBSn5kOXXY9YQRogRTSW6ET7e+MwccmTQR+kADqQONh16GR9yl9RxcnPU1cfPn2nGwiRUj/2M+MklDsVBywwIrqXxbx+nVXPd9+yzmx3Z4NdnPyUDmTgoITR7Et/+vBdILrjfvXcI+FKa67ic6nazJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376268; c=relaxed/simple;
	bh=sKAx3vr5SHEXfLi/V8knKcBxF8RK35YLpc7hJMj1gec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWpvLtdI8z7sd7hkuhTZacnjM4/AeR547/gEUeRsWoy4uNL7VLC++wMiZDri9L0X5gBSjTMIJeW5Mu3sdFxWVDNMyCC9nWgtmSSBH2ETA6RmiSsDeiXS7SbOWMrbk+/YL7RL+cQ8xXSHkHDTxJoJQuI1cTTWy69/5ROd758WIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kj4ssm6m; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376266; x=1776912266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKAx3vr5SHEXfLi/V8knKcBxF8RK35YLpc7hJMj1gec=;
  b=Kj4ssm6m8BzD9vbYA5tuSpiPg7oKZYiVbeyTDAz5elGYlCPwXcBwiML7
   uumq7kP5Vzdj+wVFFRHMgp9l1dwgRLD2A1p/ZK7IE0sblRQlU5eVNI3ot
   pcQOzaGlIY3ZwwsAtmwtTRY2pOqYYf1ZBlNDpfJgZav4tXZ6LKk/WyabN
   GunLNOMHWt128Z+dUXrnftc8HiFDotPugGWWCNsoNIDIPZi7/1bPOj6RA
   Z32WmCP4YP3p8zh4+kRrhaqz7kOm1Cq/R7qewsC1E6xiU0SapRheVv81c
   0HCpcwXmvG/G3Ydkr0KleoCjU/WcPe6ZyLNAlYUpKrN9Pb/mxYsv5xros
   Q==;
X-CSE-ConnectionGUID: hj1nlKleRIaoexdKS8vytA==
X-CSE-MsgGUID: efztz31EQAyLMsFcJERbsQ==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011841"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:20 +0800
IronPort-SDR: 680845ec_3dYeNwF88ZX00HErOCYEOABNBdtR5B1TDCwNNsgl4hGaNRN
 KS2ZmBp7K5BNsDL93UwS6CMpSyHdOsDYYBTqPug==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:12 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:20 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 06/13] btrfs: introduce space_info argument to btrfs_chunk_alloc
Date: Wed, 23 Apr 2025 11:43:46 +0900
Message-ID: <a6e3b0afc7e73edbfd14406498d2ddf93e93a924.1745375070.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745375070.git.naohiro.aota@wdc.com>
References: <cover.1745375070.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take a btrfs_space_info argument in btrfs_chunk_alloc(). New block group
will belong to that space_info.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 27 +++++++++++++++++----------
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c |  6 ++++--
 fs/btrfs/space-info.c  |  2 +-
 fs/btrfs/transaction.c |  5 +++--
 5 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b700d80089d3..ab5fc5b40f04 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2966,6 +2966,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_space_info *space_info = cache->space_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	u64 alloc_flags;
@@ -3018,7 +3019,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 */
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
-			ret = btrfs_chunk_alloc(trans, alloc_flags,
+			ret = btrfs_chunk_alloc(trans, space_info, alloc_flags,
 						CHUNK_ALLOC_FORCE);
 			/*
 			 * ENOSPC is allowed here, we may have enough space
@@ -3046,15 +3047,15 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	    (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM))
 		goto unlock_out;
 
-	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, space_info->flags);
+	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
 	/*
 	 * We have allocated a new chunk. We also need to activate that chunk to
 	 * grant metadata tickets for zoned filesystem.
 	 */
-	ret = btrfs_zoned_activate_one_bg(fs_info, cache->space_info, true);
+	ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
 	if (ret < 0)
 		goto out;
 
@@ -3898,8 +3899,15 @@ static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
+	struct btrfs_space_info *space_info;
+
+	space_info = btrfs_find_space_info(trans->fs_info, type);
+	if (!space_info) {
+		ASSERT(0);
+		return -EINVAL;
+	}
 
-	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	return btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
 static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
@@ -4095,6 +4103,8 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
  *
  * This function, btrfs_chunk_alloc(), belongs to phase 1.
  *
+ * @space_info specify which space_info the new chunk should belong to.
+ *
  * If @force is CHUNK_ALLOC_FORCE:
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
@@ -4103,11 +4113,11 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
  */
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
+		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_space_info *space_info;
 	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
@@ -4146,9 +4156,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -ENOSPC;
 
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
-
 	do {
 		spin_lock(&space_info->lock);
 		if (force < space_info->force_alloc)
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 36937eeab9b8..c01f3af726a1 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -342,7 +342,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 			       u64 num_bytes, int delalloc);
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
+		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a7564b39eb5c..1762918dd9a1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4105,6 +4105,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
+					struct btrfs_space_info *space_info,
 					bool full_search)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -4159,7 +4160,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+			ret = btrfs_chunk_alloc(trans, space_info, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
@@ -4572,7 +4573,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, full_search);
+	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
+					   full_search);
 	if (ret > 0)
 		goto search;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d6d33ab754ba..2489c2a16123 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -817,7 +817,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(trans);
 			break;
 		}
-		ret = btrfs_chunk_alloc(trans,
+		ret = btrfs_chunk_alloc(trans, space_info,
 				btrfs_get_alloc_profile(fs_info, space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 39e48bf610a1..3f429f0cef6f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -761,9 +761,10 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * value here.
 	 */
 	if (do_chunk_alloc && num_bytes) {
-		u64 flags = h->block_rsv->space_info->flags;
+		struct btrfs_space_info *space_info = h->block_rsv->space_info;
+		u64 flags = space_info->flags;
 
-		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
+		btrfs_chunk_alloc(h, space_info, btrfs_get_alloc_profile(fs_info, flags),
 				  CHUNK_ALLOC_NO_FORCE);
 	}
 
-- 
2.49.0


