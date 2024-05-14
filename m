Return-Path: <linux-btrfs+bounces-4969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C498C5855
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB231C222AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B3617BB3E;
	Tue, 14 May 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sh9GDXiX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sh9GDXiX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C41E487
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698544; cv=none; b=AmA1wZdA0LPzz4oJG4/vcWf1tdtixUBWbmV84Ozq5bDBfNnKjZPZqzPXO0ANQNy0KqmJcty3V8QT+5NHbjGpPKvYaXYh0lSQzzU3OeZxUMKnqL02TorAsAoHdLTbsjD2AdJDCkREl6OJhZ1nmU31e2X+i9qzIE2MAQ31h1gxwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698544; c=relaxed/simple;
	bh=mQtaWY1MlhpMYtK87YbsbIbhP0eHQb3zX64EmqkU1RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ke9+UOy8yuQl85v+QiflpSJ0zMZxm9bh4yqBKGmmb2KCF9d1xDNKIaVWMvvX7Ngp7UOEoWa6XSUU6/t1mF2fYP5vSVMeawgziIavwLalfUNrRBvfULppi7kACgPo0ftWHhTVctBY643ovgfBF81YYp40R6R7/kCwNyEbBeEnNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sh9GDXiX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sh9GDXiX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CE8B60D32;
	Tue, 14 May 2024 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715698539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HTIVRV/WABxZq/pInZbeMTcxJM0AFjsiYsu67Li3EUI=;
	b=sh9GDXiX6virE00XZTzWS76ah1e7ef6bTerLsum2FGCMbUECGeGddQ/lusAcnakkegntRP
	kiT7SiTQmGZ85Ij/UibANZpjpi2MEhXuxW9D6XnhbGUxx8rCarpag9lpn+3AT5lJDCh+HO
	8FFJQa451iy5b9sq9Ohs06E8/aihHoM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715698539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HTIVRV/WABxZq/pInZbeMTcxJM0AFjsiYsu67Li3EUI=;
	b=sh9GDXiX6virE00XZTzWS76ah1e7ef6bTerLsum2FGCMbUECGeGddQ/lusAcnakkegntRP
	kiT7SiTQmGZ85Ij/UibANZpjpi2MEhXuxW9D6XnhbGUxx8rCarpag9lpn+3AT5lJDCh+HO
	8FFJQa451iy5b9sq9Ohs06E8/aihHoM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36EF51372E;
	Tue, 14 May 2024 14:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JLhkDWt7Q2ZhRAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 14 May 2024 14:55:39 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: simplify range parameters of btrfs_wait_ordered_roots()
Date: Tue, 14 May 2024 16:48:12 +0200
Message-ID: <20240514144812.20513-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

The range is specified only in two ways, we can simplify the case for
the whole filesystem range as a NULL block group parameter.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c  |  4 ++--
 fs/btrfs/disk-io.c      |  2 +-
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/ordered-data.c | 28 +++++++++++++++++++++-------
 fs/btrfs/ordered-data.h |  4 ++--
 fs/btrfs/qgroup.c       |  4 ++--
 fs/btrfs/relocation.c   |  4 +---
 fs/btrfs/scrub.c        |  5 ++---
 fs/btrfs/send.c         |  4 ++--
 fs/btrfs/space-info.c   |  2 +-
 fs/btrfs/super.c        |  2 +-
 fs/btrfs/transaction.c  |  2 +-
 fs/btrfs/zoned.c        |  3 +--
 13 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7696beec4c21..5329eded6dd7 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -684,7 +684,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	if (ret)
 		btrfs_err(fs_info, "kobj add dev failed %d", ret);
 
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 
 	/*
 	 * Commit dev_replace state and reserve 1 item for it.
@@ -880,7 +880,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 		return ret;
 	}
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 
 	/*
 	 * We have to use this loop approach because at this point src_device
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..ca0edac6ec64 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4531,7 +4531,7 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	 * extents that haven't had their dirty pages IO start writeout yet
 	 * actually get run and error out properly.
 	 */
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 }
 
 static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 28df28e50ad9..4495492f0fcf 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1070,7 +1070,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	atomic_inc(&root->snapshot_force_cow);
 	snapshot_force_cow = true;
 
-	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 
 	ret = btrfs_mksubvol(parent, idmap, name, namelen,
 			     root, readonly, inherit);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c5bdd674f55c..87faf8d691dd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -19,6 +19,7 @@
 #include "qgroup.h"
 #include "subpage.h"
 #include "file.h"
+#include "block-group.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
@@ -681,11 +682,11 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
 }
 
 /*
- * wait for all the ordered extents in a root.  This is done when balancing
- * space between drives.
+ * Wait for all the ordered extents in a root. Use @bg as range or do whole
+ * range if it's NULL.
  */
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
-			       const u64 range_start, const u64 range_len)
+			       const struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	LIST_HEAD(splice);
@@ -693,7 +694,17 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 	LIST_HEAD(works);
 	struct btrfs_ordered_extent *ordered, *next;
 	u64 count = 0;
-	const u64 range_end = range_start + range_len;
+	u64 range_start, range_len;
+	u64 range_end;
+
+	if (bg) {
+		range_start = bg->start;
+		range_len = bg->length;
+	} else {
+		range_start = 0;
+		range_len = U64_MAX;
+	}
+	range_end = range_start + range_len;
 
 	mutex_lock(&root->ordered_extent_mutex);
 	spin_lock(&root->ordered_extent_lock);
@@ -740,8 +751,12 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 	return count;
 }
 
+/*
+ * Wait for @nr ordered extents that intersect the @bg, or the whole range of
+ * the filesystem if @bg is NULL.
+ */
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
-			     const u64 range_start, const u64 range_len)
+			      const struct btrfs_block_group *bg)
 {
 	struct btrfs_root *root;
 	LIST_HEAD(splice);
@@ -759,8 +774,7 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			       &fs_info->ordered_roots);
 		spin_unlock(&fs_info->ordered_root_lock);
 
-		done = btrfs_wait_ordered_extents(root, nr,
-						  range_start, range_len);
+		done = btrfs_wait_ordered_extents(root, nr, bg);
 		btrfs_put_root(root);
 
 		spin_lock(&fs_info->ordered_root_lock);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b6f6c6b91732..4f0d0d41728c 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -193,9 +193,9 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 					   struct list_head *list);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
-			       const u64 range_start, const u64 range_len);
+			       const struct btrfs_block_group *bg);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
-			      const u64 range_start, const u64 range_len);
+			      const struct btrfs_block_group *bg);
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index fc2a7ea26354..7677fea81124 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1340,7 +1340,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 	ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
 	if (ret)
 		return ret;
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 	trans = btrfs_join_transaction(fs_info->tree_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -4095,7 +4095,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 	ret = btrfs_start_delalloc_snapshot(root, true);
 	if (ret < 0)
 		goto out;
-	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..c4bf81a3e7e9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4122,9 +4122,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 
 	btrfs_wait_block_group_reservations(rc->block_group);
 	btrfs_wait_nocow_writers(rc->block_group);
-	btrfs_wait_ordered_roots(fs_info, U64_MAX,
-				 rc->block_group->start,
-				 rc->block_group->length);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, rc->block_group);
 
 	ret = btrfs_zone_finish(rc->block_group);
 	WARN_ON(ret && ret != -EAGAIN);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index afd6932f5e89..376c5c2e9aed 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2444,7 +2444,7 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
 
 	btrfs_wait_block_group_reservations(cache);
 	btrfs_wait_nocow_writers(cache);
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache);
 
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans))
@@ -2680,8 +2680,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 */
 		if (sctx->is_dev_replace) {
 			btrfs_wait_nocow_writers(cache);
-			btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start,
-					cache->length);
+			btrfs_wait_ordered_roots(fs_info, U64_MAX, cache);
 		}
 
 		scrub_pause_off(fs_info);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3dd4a48479a9..c69743233be5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8046,7 +8046,7 @@ static int flush_delalloc_roots(struct send_ctx *sctx)
 		ret = btrfs_start_delalloc_snapshot(root, false);
 		if (ret)
 			return ret;
-		btrfs_wait_ordered_extents(root, U64_MAX, 0, U64_MAX);
+		btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 	}
 
 	for (i = 0; i < sctx->clone_roots_cnt; i++) {
@@ -8054,7 +8054,7 @@ static int flush_delalloc_roots(struct send_ctx *sctx)
 		ret = btrfs_start_delalloc_snapshot(root, false);
 		if (ret)
 			return ret;
-		btrfs_wait_ordered_extents(root, U64_MAX, 0, U64_MAX);
+		btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 	}
 
 	return 0;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d620323d08ea..edf4728e34ad 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -688,7 +688,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 skip_async:
 		loops++;
 		if (wait_ordered && !trans) {
-			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
+			btrfs_wait_ordered_roots(fs_info, items, NULL);
 		} else {
 			time_left = schedule_timeout_killable(1);
 			if (time_left)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2dbc930a20f7..a63c3400bdaa 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -975,7 +975,7 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 		return 0;
 	}
 
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3388c836b9a5..639755f025b4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2110,7 +2110,7 @@ static inline int btrfs_start_delalloc_flush(struct btrfs_fs_info *fs_info)
 static inline void btrfs_wait_delalloc_flush(struct btrfs_fs_info *fs_info)
 {
 	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT))
-		btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
+		btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 }
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dde4a0a34037..c3b2abf95e79 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2214,8 +2214,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		/* Ensure all writes in this block group finish */
 		btrfs_wait_block_group_reservations(block_group);
 		/* No need to wait for NOCOW writers. Zoned mode does not allow that */
-		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
-					 block_group->length);
+		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group);
 		/* Wait for extent buffers to be written. */
 		if (is_metadata)
 			wait_eb_writebacks(block_group);
-- 
2.44.0


