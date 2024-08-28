Return-Path: <linux-btrfs+bounces-7625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09777962C9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71872B2588F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F21A38E8;
	Wed, 28 Aug 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BvQUF6og";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BvQUF6og"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845F1A2C24
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859691; cv=none; b=rNIz7AfoWF8nHXrSmEVrjUC1ISLavl6L2r/9IkngH7oL2iG9JE6PK7vuJ4cpgiDj8jbtnB5gzZY8tyf5p4pKR+D4NGCbutyyS5pMTbvVpgGLbgEZkvSNn3XokcR7ZoCbvHa56yBqy8eHkoUFKIgAamiqQ2G1+SALnPu86+Dt6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859691; c=relaxed/simple;
	bh=5LKp8DBbU++ZWlKIJCGpJJM59wAulTtz4BgcHH9xlrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/Lew1Ry5CduaMXq6p+XFYpWklxknCaHBSFIUBF91OOFQI72DruxCFYNoENBVfGB/4sOJMovB+DlVykERp+QxL471lmMXzEXqH6JEfxDKjX+Vnz1Dtwb/ClrIwOJsCYJcxklk7ruZfNL9KVpXdHKmoepNBGZLkAeaB2KmxONDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BvQUF6og; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BvQUF6og; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE0591FC85;
	Wed, 28 Aug 2024 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724859686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOeTtwJN+bSiMjhLfRtieBoCCHs3GVX+tgkBnFfWFuI=;
	b=BvQUF6ogmYj9FgHZKEBcb3RR/TPDJVpo+mlB6NFWJqe8acfo5InLGMMBt1v2uigpFTRW/4
	m5/yxJSDR4O/ajMkpEmBswoyTARjkumzrepbnJ8l9IMvNI7TuTYbFWCy+m9472nESQ9UT6
	FlDs/X9UdpAtOT8AhuP7Q028L2Yrl5Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724859686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOeTtwJN+bSiMjhLfRtieBoCCHs3GVX+tgkBnFfWFuI=;
	b=BvQUF6ogmYj9FgHZKEBcb3RR/TPDJVpo+mlB6NFWJqe8acfo5InLGMMBt1v2uigpFTRW/4
	m5/yxJSDR4O/ajMkpEmBswoyTARjkumzrepbnJ8l9IMvNI7TuTYbFWCy+m9472nESQ9UT6
	FlDs/X9UdpAtOT8AhuP7Q028L2Yrl5Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7898138D2;
	Wed, 28 Aug 2024 15:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TV/PLCZFz2YDVQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 28 Aug 2024 15:41:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: constify more pointer parameters
Date: Wed, 28 Aug 2024 17:41:26 +0200
Message-ID: <e163012ed80a4f55ce17641586681c6ac4ff9018.1724859620.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724859619.git.dsterba@suse.com>
References: <cover.1724859619.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Continue adding const to parameters.  This is for clarity and minor
addition to safety. There are some minor effects, in the assembly code
and .ko measured on release config.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c           |  6 +++---
 fs/btrfs/block-group.c       | 34 +++++++++++++++++-----------------
 fs/btrfs/block-group.h       | 11 +++++------
 fs/btrfs/block-rsv.c         |  2 +-
 fs/btrfs/block-rsv.h         |  2 +-
 fs/btrfs/ctree.c             | 18 +++++++++---------
 fs/btrfs/ctree.h             |  6 +++---
 fs/btrfs/discard.c           |  4 ++--
 fs/btrfs/file-item.c         |  4 ++--
 fs/btrfs/file-item.h         |  2 +-
 fs/btrfs/inode-item.c        | 10 +++++-----
 fs/btrfs/inode-item.h        |  4 ++--
 fs/btrfs/space-info.c        | 25 ++++++++++++-------------
 fs/btrfs/space-info.h        | 10 +++++-----
 fs/btrfs/tree-mod-log.c      | 14 +++++++-------
 fs/btrfs/tree-mod-log.h      |  6 +++---
 fs/btrfs/zoned.c             |  2 +-
 fs/btrfs/zoned.h             |  2 +-
 include/trace/events/btrfs.h |  6 +++---
 19 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a2de5c05f97c..e2f478ecd7fd 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -219,8 +219,8 @@ static void free_pref(struct prelim_ref *ref)
  * A -1 return indicates ref1 is a 'lower' block than ref2, while 1
  * indicates a 'higher' block.
  */
-static int prelim_ref_compare(struct prelim_ref *ref1,
-			      struct prelim_ref *ref2)
+static int prelim_ref_compare(const struct prelim_ref *ref1,
+			      const struct prelim_ref *ref2)
 {
 	if (ref1->level < ref2->level)
 		return -1;
@@ -251,7 +251,7 @@ static int prelim_ref_compare(struct prelim_ref *ref1,
 }
 
 static void update_share_count(struct share_check *sc, int oldcount,
-			       int newcount, struct prelim_ref *newref)
+			       int newcount, const struct prelim_ref *newref)
 {
 	if ((!sc) || (oldcount == 0 && newcount < 1))
 		return;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2e49d978f504..7980b2e33a92 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -23,7 +23,7 @@
 #include "extent-tree.h"
 
 #ifdef CONFIG_BTRFS_DEBUG
-int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
+int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 
@@ -40,9 +40,9 @@ int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
  *
  * Should be called with balance_lock held
  */
-static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+static u64 get_restripe_target(const struct btrfs_fs_info *fs_info, u64 flags)
 {
-	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
+	const struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	u64 target = 0;
 
 	if (!bctl)
@@ -1415,9 +1415,9 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 }
 
 static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
-				 struct btrfs_block_group *bg)
+				 const struct btrfs_block_group *bg)
 {
-	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_transaction *prev_trans = NULL;
 	const u64 start = bg->start;
 	const u64 end = start + bg->length - 1;
@@ -1756,14 +1756,14 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 	return bg1->used > bg2->used;
 }
 
-static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
+static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_zoned_should_reclaim(fs_info);
 	return true;
 }
 
-static bool should_reclaim_block_group(struct btrfs_block_group *bg, u64 bytes_freed)
+static bool should_reclaim_block_group(const struct btrfs_block_group *bg, u64 bytes_freed)
 {
 	const int thresh_pct = btrfs_calc_reclaim_threshold(bg->space_info);
 	u64 thresh_bytes = mult_perc(bg->length, thresh_pct);
@@ -2006,8 +2006,8 @@ void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
-static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
-			   struct btrfs_path *path)
+static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key *key,
+			   const struct btrfs_path *path)
 {
 	struct btrfs_chunk_map *map;
 	struct btrfs_block_group_item bg;
@@ -2055,7 +2055,7 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 
 static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_path *path,
-				  struct btrfs_key *key)
+				  const struct btrfs_key *key)
 {
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	int ret;
@@ -2640,8 +2640,8 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 }
 
 static int insert_dev_extent(struct btrfs_trans_handle *trans,
-			    struct btrfs_device *device, u64 chunk_offset,
-			    u64 start, u64 num_bytes)
+			     const struct btrfs_device *device, u64 chunk_offset,
+			     u64 start, u64 num_bytes)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
@@ -2817,7 +2817,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
  * For extent tree v2 we use the block_group_item->chunk_offset to point at our
  * global root id.  For v1 it's always set to BTRFS_FIRST_CHUNK_TREE_OBJECTID.
  */
-static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
+static u64 calculate_global_root_id(const struct btrfs_fs_info *fs_info, u64 offset)
 {
 	u64 div = SZ_1G;
 	u64 index;
@@ -3842,8 +3842,8 @@ static void force_metadata_allocation(struct btrfs_fs_info *info)
 	}
 }
 
-static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
-			      struct btrfs_space_info *sinfo, int force)
+static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
+			      const struct btrfs_space_info *sinfo, int force)
 {
 	u64 bytes_used = btrfs_space_info_used(sinfo, false);
 	u64 thresh;
@@ -4218,7 +4218,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
+static u64 get_profile_num_devs(const struct btrfs_fs_info *fs_info, u64 type)
 {
 	u64 num_dev;
 
@@ -4622,7 +4622,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 	return 0;
 }
 
-bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg)
+bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
 {
 	if (btrfs_is_zoned(bg->fs_info))
 		return false;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 915111338fc0..36937eeab9b8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -266,7 +266,7 @@ struct btrfs_block_group {
 	u64 reclaim_mark;
 };
 
-static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
+static inline u64 btrfs_block_group_end(const struct btrfs_block_group *block_group)
 {
 	return (block_group->start + block_group->length);
 }
@@ -278,8 +278,7 @@ static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
 	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
 }
 
-static inline bool btrfs_is_block_group_data_only(
-					struct btrfs_block_group *block_group)
+static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group *block_group)
 {
 	/*
 	 * In mixed mode the fragmentation is expected to be high, lowering the
@@ -290,7 +289,7 @@ static inline bool btrfs_is_block_group_data_only(
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group);
+int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group);
 #endif
 
 struct btrfs_block_group *btrfs_lookup_first_block_group(
@@ -370,7 +369,7 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
+static inline int btrfs_block_group_done(const struct btrfs_block_group *cache)
 {
 	smp_mb();
 	return cache->cached == BTRFS_CACHE_FINISHED ||
@@ -387,6 +386,6 @@ enum btrfs_block_group_size_class btrfs_calc_block_group_size_class(u64 size);
 int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class);
-bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg);
+bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index b299b82d676e..a07b9594dc70 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -553,7 +553,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 	return ERR_PTR(ret);
 }
 
-int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
+int btrfs_check_trunc_cache_free_space(const struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv)
 {
 	u64 needed_bytes;
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 1f53b967d069..d12b1fac5c74 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -89,7 +89,7 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info);
 struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 					    struct btrfs_root *root,
 					    u32 blocksize);
-int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
+int btrfs_check_trunc_cache_free_space(const struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv);
 static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 					 struct btrfs_block_rsv *block_rsv,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 451203055bbf..0cc919d15b14 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2564,8 +2564,8 @@ int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
  *
  */
 static void fixup_low_keys(struct btrfs_trans_handle *trans,
-			   struct btrfs_path *path,
-			   struct btrfs_disk_key *key, int level)
+			   const struct btrfs_path *path,
+			   const struct btrfs_disk_key *key, int level)
 {
 	int i;
 	struct extent_buffer *t;
@@ -2594,7 +2594,7 @@ static void fixup_low_keys(struct btrfs_trans_handle *trans,
  * that the new key won't break the order
  */
 void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
-			     struct btrfs_path *path,
+			     const struct btrfs_path *path,
 			     const struct btrfs_key *new_key)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2660,8 +2660,8 @@ void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
  * is correct, we only need to bother the last key of @left and the first
  * key of @right.
  */
-static bool check_sibling_keys(struct extent_buffer *left,
-			       struct extent_buffer *right)
+static bool check_sibling_keys(const struct extent_buffer *left,
+			       const struct extent_buffer *right)
 {
 	struct btrfs_key left_last;
 	struct btrfs_key right_first;
@@ -2928,8 +2928,8 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
  * blocknr is the block the key points to.
  */
 static int insert_ptr(struct btrfs_trans_handle *trans,
-		      struct btrfs_path *path,
-		      struct btrfs_disk_key *key, u64 bytenr,
+		      const struct btrfs_path *path,
+		      const struct btrfs_disk_key *key, u64 bytenr,
 		      int slot, int level)
 {
 	struct extent_buffer *lower;
@@ -4019,7 +4019,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
  * the front.
  */
 void btrfs_truncate_item(struct btrfs_trans_handle *trans,
-			 struct btrfs_path *path, u32 new_size, int from_end)
+			 const struct btrfs_path *path, u32 new_size, int from_end)
 {
 	int slot;
 	struct extent_buffer *leaf;
@@ -4111,7 +4111,7 @@ void btrfs_truncate_item(struct btrfs_trans_handle *trans,
  * make the item pointed to by the path bigger, data_size is the added size.
  */
 void btrfs_extend_item(struct btrfs_trans_handle *trans,
-		       struct btrfs_path *path, u32 data_size)
+		       const struct btrfs_path *path, u32 data_size)
 {
 	int slot;
 	struct extent_buffer *leaf;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 75fa563e4cac..5483c498bf4c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -539,7 +539,7 @@ int btrfs_previous_item(struct btrfs_root *root,
 int btrfs_previous_extent_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid);
 void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
-			     struct btrfs_path *path,
+			     const struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
 struct extent_buffer *btrfs_root_node(struct btrfs_root *root);
 int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
@@ -573,9 +573,9 @@ bool btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
 void btrfs_extend_item(struct btrfs_trans_handle *trans,
-		       struct btrfs_path *path, u32 data_size);
+		       const struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_trans_handle *trans,
-			 struct btrfs_path *path, u32 new_size, int from_end);
+			 const struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 944a7340f6a4..e815d165cccc 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -68,7 +68,7 @@ static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {
 };
 
 static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
-					  struct btrfs_block_group *block_group)
+					  const struct btrfs_block_group *block_group)
 {
 	return &discard_ctl->discard_list[block_group->discard_index];
 }
@@ -80,7 +80,7 @@ static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
  *
  * Check if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
  */
-static bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
+static bool btrfs_run_discard_work(const struct btrfs_discard_ctl *discard_ctl)
 {
 	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
 						     struct btrfs_fs_info,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5c342fe1af61..886749b39672 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -151,7 +151,7 @@ static inline u32 max_ordered_sum_bytes(const struct btrfs_fs_info *fs_info)
  * Calculate the total size needed to allocate for an ordered sum structure
  * spanning @bytes in the file.
  */
-static int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info, unsigned long bytes)
+static int btrfs_ordered_sum_size(const struct btrfs_fs_info *fs_info, unsigned long bytes)
 {
 	return sizeof(struct btrfs_ordered_sum) + bytes_to_csum_size(fs_info, bytes);
 }
@@ -1272,7 +1272,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
-				     struct btrfs_file_extent_item *fi,
+				     const struct btrfs_file_extent_item *fi,
 				     struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 557dc43d7142..0e13661a71f3 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -74,7 +74,7 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 			      unsigned long *csum_bitmap);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
-				     struct btrfs_file_extent_item *fi,
+				     const struct btrfs_file_extent_item *fi,
 				     struct extent_map *em);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 316756ff08ac..29572dfaf878 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -14,7 +14,7 @@
 #include "extent-tree.h"
 #include "file-item.h"
 
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+struct btrfs_inode_ref *btrfs_find_name_in_backref(const struct extent_buffer *leaf,
 						   int slot,
 						   const struct fscrypt_str *name)
 {
@@ -42,7 +42,7 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 }
 
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
-		struct extent_buffer *leaf, int slot, u64 ref_objectid,
+		const struct extent_buffer *leaf, int slot, u64 ref_objectid,
 		const struct fscrypt_str *name)
 {
 	struct btrfs_inode_extref *extref;
@@ -423,9 +423,9 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
 	return ret;
 }
 
-static inline void btrfs_trace_truncate(struct btrfs_inode *inode,
-					struct extent_buffer *leaf,
-					struct btrfs_file_extent_item *fi,
+static inline void btrfs_trace_truncate(const struct btrfs_inode *inode,
+					const struct extent_buffer *leaf,
+					const struct btrfs_file_extent_item *fi,
 					u64 offset, int extent_type, int slot)
 {
 	if (!inode)
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index c4aded82709b..c11b97fdccc4 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -109,11 +109,11 @@ struct btrfs_inode_extref *btrfs_lookup_inode_extref(
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow);
 
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+struct btrfs_inode_ref *btrfs_find_name_in_backref(const struct extent_buffer *leaf,
 						   int slot,
 						   const struct fscrypt_str *name);
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
-		struct extent_buffer *leaf, int slot, u64 ref_objectid,
+		const struct extent_buffer *leaf, int slot, u64 ref_objectid,
 		const struct fscrypt_str *name);
 
 #endif
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c691784b4660..d5a9cd8a4fd8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -163,7 +163,7 @@
  *   thing with or without extra unallocated space.
  */
 
-u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
+u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 			  bool may_use_included)
 {
 	ASSERT(s_info);
@@ -368,7 +368,7 @@ static u64 calc_effective_data_chunk_size(struct btrfs_fs_info *fs_info)
 }
 
 static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
-			  struct btrfs_space_info *space_info,
+			  const struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
 {
 	u64 profile;
@@ -437,7 +437,7 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
+			 const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush)
 {
 	u64 avail;
@@ -542,8 +542,8 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
 }
 
-static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *info)
+static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
+				    const struct btrfs_space_info *info)
 {
 	const char *flag_str = space_info_flag_to_str(info);
 	lockdep_assert_held(&info->lock);
@@ -844,9 +844,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	return;
 }
 
-static inline u64
-btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info)
+static u64 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
+					    const struct btrfs_space_info *space_info)
 {
 	u64 used;
 	u64 avail;
@@ -871,7 +870,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 }
 
 static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info)
+				    const struct btrfs_space_info *space_info)
 {
 	const u64 global_rsv_size = btrfs_block_rsv_reserved(&fs_info->global_block_rsv);
 	u64 ordered, delalloc;
@@ -1943,7 +1942,7 @@ static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
  * Typically with 10 block groups as the target, the discrete values this comes
  * out to are 0, 10, 20, ... , 80, 90, and 99.
  */
-static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
+static int calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_info)
 {
 	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 unalloc = atomic64_read(&fs_info->free_chunk_space);
@@ -1962,7 +1961,7 @@ static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
 	return calc_pct_ratio(want, target);
 }
 
-int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
+int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info)
 {
 	lockdep_assert_held(&space_info->lock);
 
@@ -1985,7 +1984,7 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
 	return unalloc < data_chunk_size;
 }
 
-static void do_reclaim_sweep(struct btrfs_fs_info *fs_info,
+static void do_reclaim_sweep(const struct btrfs_fs_info *fs_info,
 			     struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
@@ -2073,7 +2072,7 @@ bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
 	return ret;
 }
 
-void btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
+void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 {
 	int raid;
 	struct btrfs_space_info *space_info;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 5602026c5e14..efbecc0c5258 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -217,7 +217,7 @@ struct reserve_ticket {
 	wait_queue_head_t wait;
 };
 
-static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
+static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
 {
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
@@ -258,7 +258,7 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
-u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
+u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
@@ -271,7 +271,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info);
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
+			 const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush);
 
 static inline void btrfs_space_info_free_bytes_may_use(
@@ -293,7 +293,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
 void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
 bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
-int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
-void btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
+int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
+void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index fa45b5fb9683..b382a4c443d4 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -170,7 +170,7 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
  * this until all tree mod log insertions are recorded in the rb tree and then
  * write unlock fs_info::tree_mod_log_lock.
  */
-static bool tree_mod_dont_log(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
+static bool tree_mod_dont_log(struct btrfs_fs_info *fs_info, const struct extent_buffer *eb)
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return true;
@@ -188,7 +188,7 @@ static bool tree_mod_dont_log(struct btrfs_fs_info *fs_info, struct extent_buffe
 
 /* Similar to tree_mod_dont_log, but doesn't acquire any locks. */
 static bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb)
+			      const struct extent_buffer *eb)
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return false;
@@ -198,7 +198,7 @@ static bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
 	return true;
 }
 
-static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
+static struct tree_mod_elem *alloc_tree_mod_elem(const struct extent_buffer *eb,
 						 int slot,
 						 enum btrfs_mod_log_op op)
 {
@@ -221,7 +221,7 @@ static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
 	return tm;
 }
 
-int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op)
 {
 	struct tree_mod_elem *tm;
@@ -258,7 +258,7 @@ int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
 	return ret;
 }
 
-static struct tree_mod_elem *tree_mod_log_alloc_move(struct extent_buffer *eb,
+static struct tree_mod_elem *tree_mod_log_alloc_move(const struct extent_buffer *eb,
 						     int dst_slot, int src_slot,
 						     int nr_items)
 {
@@ -278,7 +278,7 @@ static struct tree_mod_elem *tree_mod_log_alloc_move(struct extent_buffer *eb,
 	return tm;
 }
 
-int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+int btrfs_tree_mod_log_insert_move(const struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items)
 {
@@ -535,7 +535,7 @@ static struct tree_mod_elem *tree_mod_log_search(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
-			       struct extent_buffer *src,
+			       const struct extent_buffer *src,
 			       unsigned long dst_offset,
 			       unsigned long src_offset,
 			       int nr_items)
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
index ff00c8e8a393..6308c577a4a4 100644
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -37,7 +37,7 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
 int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 				   struct extent_buffer *new_root,
 				   bool log_removal);
-int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op);
 int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb);
 struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
@@ -47,11 +47,11 @@ struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq);
 int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq);
 int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
-			       struct extent_buffer *src,
+			       const struct extent_buffer *src,
 			       unsigned long dst_offset,
 			       unsigned long src_offset,
 			       int nr_items);
-int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+int btrfs_tree_mod_log_insert_move(const struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items);
 u64 btrfs_tree_mod_log_lowest_seq(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 66f63e82af79..c62627ecc7f4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2439,7 +2439,7 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
 
-bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 30b2e48a1cec..2a26da42f820 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -89,7 +89,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
-bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
+bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index e4add61e00f1..bf60ad50011e 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1825,7 +1825,7 @@ TRACE_EVENT(qgroup_update_counters,
 
 TRACE_EVENT(qgroup_update_reserve,
 
-	TP_PROTO(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct btrfs_qgroup *qgroup,
 		 s64 diff, int type),
 
 	TP_ARGS(fs_info, qgroup, diff, type),
@@ -1851,7 +1851,7 @@ TRACE_EVENT(qgroup_update_reserve,
 
 TRACE_EVENT(qgroup_meta_reserve,
 
-	TP_PROTO(struct btrfs_root *root, s64 diff, int type),
+	TP_PROTO(const struct btrfs_root *root, s64 diff, int type),
 
 	TP_ARGS(root, diff, type),
 
@@ -1874,7 +1874,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 
 TRACE_EVENT(qgroup_meta_convert,
 
-	TP_PROTO(struct btrfs_root *root, s64 diff),
+	TP_PROTO(const struct btrfs_root *root, s64 diff),
 
 	TP_ARGS(root, diff),
 
-- 
2.45.0


