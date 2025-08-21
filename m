Return-Path: <linux-btrfs+bounces-16263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D71B309B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 00:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACEF1CE6241
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDAD2E88AE;
	Thu, 21 Aug 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ooL5jYMS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ooL5jYMS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B728E0F
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817069; cv=none; b=BU7VHT1yAiKf+jOJ6F1fd0ue9yWxP+BI8lIbCRdEWsVnSQ3i/X9hiFp+Ldiu8cKcQm0CAw7BY6BtAcBSuRQl3w290c232RGTr68xebqHkAbAK6stCFI/Kojdr1F01p/7/URi515NlPv66HMzXxHbKGjuT7qVWwNPbbcIbICIbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817069; c=relaxed/simple;
	bh=bS4PWIjVydpWDopCtsfNmDfil6B3Y91g7MoIWf80nnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYHaRr3+ZKySBB2PcF7g0bsfYplMr1AQYq4acAtBW6Ryv0OPqhy+2vpy0RrZxwNqcqUplTNO1Z5g5tIOZWRZn+iCHaNct2thWLEZCVQWjxpAMGOBbk+Ap6tCMLTZcWOQ8C9H7GHazrssqgzmMzH2sEOlukdZYpBPok+R8I8gmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ooL5jYMS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ooL5jYMS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B00C41F385;
	Thu, 21 Aug 2025 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755817063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wqmsUIPP47ZSVg0M606NaGE8Y15lgjcu6Gn2NybLogs=;
	b=ooL5jYMSZ1p5jmlI0xZ8/h0iYXaAty2B3DETOSMtgKLVqB/577vBWcY92LD9Tmgfs0u2iI
	eapYxZ2ZdQoRoo5U7gg7VdIjfeUstuJatdBBtSVyi4G864z1oGwl5PnZbzpIUcwk2hcnWq
	UixlqpnSvH4K49IQltCJSbXAu2vB0hc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ooL5jYMS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755817063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wqmsUIPP47ZSVg0M606NaGE8Y15lgjcu6Gn2NybLogs=;
	b=ooL5jYMSZ1p5jmlI0xZ8/h0iYXaAty2B3DETOSMtgKLVqB/577vBWcY92LD9Tmgfs0u2iI
	eapYxZ2ZdQoRoo5U7gg7VdIjfeUstuJatdBBtSVyi4G864z1oGwl5PnZbzpIUcwk2hcnWq
	UixlqpnSvH4K49IQltCJSbXAu2vB0hc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A81B613867;
	Thu, 21 Aug 2025 22:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5L0GKWekp2hOCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 21 Aug 2025 22:57:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: fix typos in comments and strings
Date: Fri, 22 Aug 2025 00:57:42 +0200
Message-ID: <20250821225742.1151914-1-dsterba@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B00C41F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Annual typo fixing pass. Strangely codespell found only about 30% of
what is in this patch, the rest was done manually using text
spellchecker with a custom dictionary of acceptable terms.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c                |  2 +-
 fs/btrfs/backref.c                  |  2 +-
 fs/btrfs/backref.h                  |  4 ++--
 fs/btrfs/block-group.c              |  4 ++--
 fs/btrfs/block-group.h              |  2 +-
 fs/btrfs/compression.c              |  2 +-
 fs/btrfs/defrag.c                   |  2 +-
 fs/btrfs/delayed-ref.c              |  2 +-
 fs/btrfs/dev-replace.c              |  2 +-
 fs/btrfs/disk-io.c                  |  2 +-
 fs/btrfs/extent-io-tree.c           |  2 +-
 fs/btrfs/extent-tree.c              |  8 ++++----
 fs/btrfs/extent_io.c                | 10 +++++-----
 fs/btrfs/fiemap.c                   |  2 +-
 fs/btrfs/file.c                     |  4 ++--
 fs/btrfs/free-space-cache.c         |  4 ++--
 fs/btrfs/fs.c                       |  2 +-
 fs/btrfs/fs.h                       |  2 +-
 fs/btrfs/inode.c                    | 10 +++++-----
 fs/btrfs/ioctl.c                    |  2 +-
 fs/btrfs/locking.c                  |  2 +-
 fs/btrfs/locking.h                  |  2 +-
 fs/btrfs/scrub.c                    |  2 +-
 fs/btrfs/send.c                     |  6 +++---
 fs/btrfs/space-info.c               |  4 ++--
 fs/btrfs/subpage.c                  |  2 +-
 fs/btrfs/subpage.h                  |  2 +-
 fs/btrfs/super.c                    |  2 +-
 fs/btrfs/tests/delayed-refs-tests.c |  4 ++--
 fs/btrfs/tests/extent-map-tests.c   |  2 +-
 fs/btrfs/transaction.c              |  2 +-
 fs/btrfs/tree-checker.c             |  2 +-
 fs/btrfs/tree-log.c                 |  4 ++--
 fs/btrfs/volumes.c                  | 10 ++++------
 fs/btrfs/volumes.h                  |  4 ++--
 35 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 861c7d92c437aa..1248aa2535d306 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -44,7 +44,7 @@ static __always_inline void memcpy_split_src(char *dest, const char *src1,
  * gives us all the type checking.
  *
  * The extent buffer pages stored in the array folios may not form a contiguous
- * phyusical range, but the API functions assume the linear offset to the range
+ * physical range, but the API functions assume the linear offset to the range
  * from 0 to metadata node size.
  */
 
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6a450be293b1cd..c6573e845e43f6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1690,7 +1690,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
  * @ctx->bytenr and @ctx->extent_item_pos. The bytenr of the found leaves are
  * added to the ulist at @ctx->refs, and that ulist is allocated by this
  * function. The caller should free the ulist with free_leaf_list() if
- * @ctx->ignore_extent_item_pos is false, otherwise a fimple ulist_free() is
+ * @ctx->ignore_extent_item_pos is false, otherwise a simple ulist_free() is
  * enough.
  *
  * Returns 0 on success and < 0 on error. On error @ctx->refs is not allocated.
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 34b0193a181c88..25d51c2460703b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -190,7 +190,7 @@ struct btrfs_backref_share_check_ctx {
 	 * It's very common to have several file extent items that point to the
 	 * same extent (bytenr) but with different offsets and lengths. This
 	 * typically happens for COW writes, partial writes into prealloc
-	 * extents, NOCOW writes after snapshoting a root, hole punching or
+	 * extents, NOCOW writes after snapshotting a root, hole punching or
 	 * reflinking within the same file (less common perhaps).
 	 * So keep a small cache with the lookup results for the extent pointed
 	 * by the last few file extent items. This cache is checked, with a
@@ -414,7 +414,7 @@ struct btrfs_backref_cache {
 	/*
 	 * Whether this cache is for relocation
 	 *
-	 * Reloction backref cache require more info for reloc root compared
+	 * Relocation backref cache require more info for reloc root compared
 	 * to generic backref cache.
 	 */
 	bool is_reloc;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 27b8b9de130c11..239cbb01f83fa7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1964,7 +1964,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		 * called, which is where we will transfer a reserved extent's
 		 * size from the "reserved" counter to the "used" counter - this
 		 * happens when running delayed references. When we relocate the
-		 * chunk below, relocation first flushes dellaloc, waits for
+		 * chunk below, relocation first flushes delalloc, waits for
 		 * ordered extent completion (which is where we create delayed
 		 * references for data extents) and commits the current
 		 * transaction (which runs delayed references), and only after
@@ -2832,7 +2832,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		 * space or none at all (due to no need to COW, extent buffers
 		 * were already COWed in the current transaction and still
 		 * unwritten, tree heights lower than the maximum possible
-		 * height, etc). For data we generally reserve the axact amount
+		 * height, etc). For data we generally reserve the exact amount
 		 * of space we are going to allocate later, the exception is
 		 * when using compression, as we must reserve space based on the
 		 * uncompressed data size, because the compression is only done
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a8bb8429c96635..9172104a5889ec 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -63,7 +63,7 @@ enum btrfs_discard_state {
  * CHUNK_ALLOC_FORCE means it must try to allocate one
  *
  * CHUNK_ALLOC_FORCE_FOR_EXTENT like CHUNK_ALLOC_FORCE but called from
- * find_free_extent() that also activaes the zone
+ * find_free_extent() that also activates the zone
  */
 enum btrfs_chunk_alloc_enum {
 	CHUNK_ALLOC_NO_FORCE,
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3291d1ff2722af..068339e8612302 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1290,7 +1290,7 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 #define ENTROPY_LVL_HIGH		(80)
 
 /*
- * For increasead precision in shannon_entropy calculation,
+ * For increased precision in shannon_entropy calculation,
  * let's do pow(n, M) to save more digits after comma:
  *
  * - maximum int bit length is 64
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 738179a5e17060..84ba9906f0d818 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -153,7 +153,7 @@ void btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh)
 }
 
 /*
- * Pick the defragable inode that we want, if it doesn't exist, we will get the
+ * Pick the defraggable inode that we want, if it doesn't exist, we will get the
  * next one.
  */
 static struct inode_defrag *btrfs_pick_defrag_inode(
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 7b357a4b3ce3dd..f91062fc1b0b31 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -895,7 +895,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 }
 
 /*
- * Initialize the structure which represents a modification to a an extent.
+ * Initialize the structure which represents a modification to an extent.
  *
  * @fs_info:    Internal to the mounted filesystem mount structure.
  *
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 4675bcd5f92efb..ed3b07fdaab87b 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -637,7 +637,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
-		DEBUG_WARN("unexpected STARTED ot SUSPENDED dev-replace state");
+		DEBUG_WARN("unexpected STARTED or SUSPENDED dev-replace state");
 		ret = BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
 		up_write(&dev_replace->rwsem);
 		goto leave;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eb55ecf4bf2582..7b06bbc4089878 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3245,7 +3245,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	/*
 	 * Subpage runtime limitation on v1 cache.
 	 *
-	 * V1 space cache still has some hard codeed PAGE_SIZE usage, while
+	 * V1 space cache still has some hard coded PAGE_SIZE usage, while
 	 * we're already defaulting to v2 cache, no need to bother v1 as it's
 	 * going to be deprecated anyway.
 	 */
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 0c58342c6125e1..bb2ca1c9c7b026 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1237,7 +1237,7 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		state = next_search_state(inserted_state, end);
 		/*
 		 * If there's a next state, whether contiguous or not, we don't
-		 * need to unlock and start search agian. If it's not contiguous
+		 * need to unlock and start search again. If it's not contiguous
 		 * we will end up here and try to allocate a prealloc state and insert.
 		 */
 		if (state)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e117b5cbefae73..a4416c451b250b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -325,7 +325,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 /*
  * is_data == BTRFS_REF_TYPE_BLOCK, tree block type is required,
- * is_data == BTRFS_REF_TYPE_DATA, data type is requiried,
+ * is_data == BTRFS_REF_TYPE_DATA, data type is required,
  * is_data == BTRFS_REF_TYPE_ANY, either type is OK.
  */
 int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
@@ -4316,7 +4316,7 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 		spin_lock(&fs_info->zone_active_bgs_lock);
 		list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
 			/*
-			 * No lock is OK here because avail is monotinically
+			 * No lock is OK here because avail is monotonically
 			 * decreasing, and this is just a hint.
 			 */
 			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
@@ -5613,7 +5613,7 @@ static int check_next_block_uptodate(struct btrfs_trans_handle *trans,
  * If we are UPDATE_BACKREF then we will not, we need to update our backrefs.
  *
  * If we are DROP_REFERENCE this will figure out if we need to drop our current
- * reference, skipping it if we dropped it from a previous incompleted drop, or
+ * reference, skipping it if we dropped it from a previous uncompleted drop, or
  * dropping it if we still have a reference to it.
  */
 static int maybe_drop_reference(struct btrfs_trans_handle *trans, struct btrfs_root *root,
@@ -5760,7 +5760,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	/*
 	 * We have to walk down into this node, and if we're currently at the
-	 * DROP_REFERNCE stage and this block is shared then we need to switch
+	 * DROP_REFERENCE stage and this block is shared then we need to switch
 	 * to the UPDATE_BACKREF stage in order to convert to FULL_BACKREF.
 	 */
 	if (wc->stage == DROP_REFERENCE && wc->refs[level - 1] > 1) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c12fd64a1f34d..426a6791a0b221 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -400,7 +400,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	if (delalloc_end + 1 - delalloc_start > max_bytes)
 		delalloc_end = delalloc_start + max_bytes - 1;
 
-	/* step two, lock all the folioss after the folios that has start */
+	/* step two, lock all the folios after the folios that has start */
 	ret = lock_delalloc_folios(inode, locked_folio, delalloc_start,
 				   delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
@@ -754,7 +754,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  *
  * The will either add the page into the existing @bio_ctrl->bbio, or allocate a
  * new one in @bio_ctrl->bbio.
- * The mirror number for this IO should already be initizlied in
+ * The mirror number for this IO should already be initialized in
  * @bio_ctrl->mirror_num.
  */
 static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
@@ -2205,7 +2205,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  * @fs_info:	The fs_info for this file system.
  * @start:	The offset of the range to start waiting on writeback.
  * @end:	The end of the range, inclusive. This is meant to be used in
- *		conjuction with wait_marked_extents, so this will usually be
+ *		conjunction with wait_marked_extents, so this will usually be
  *		the_next_eb->start - 1.
  */
 void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
@@ -2475,7 +2475,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * In above case, [32K, 96K) is asynchronously submitted
 			 * for compression, and [124K, 128K) needs to be written back.
 			 *
-			 * If we didn't wait wrtiteback for page 64K, [128K, 128K)
+			 * If we didn't wait writeback for page 64K, [128K, 128K)
 			 * won't be submitted as the page still has writeback flag
 			 * and will be skipped in the next check.
 			 *
@@ -2959,7 +2959,7 @@ static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
 {
 	const int num_folios = num_extent_folios(eb);
 
-	/* We canont use num_extent_folios() as loop bound as eb->folios changes. */
+	/* We cannot use num_extent_folios() as loop bound as eb->folios changes. */
 	for (int i = 0; i < num_folios; i++) {
 		ASSERT(eb->folios[i]);
 		detach_extent_buffer_folio(eb, eb->folios[i]);
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index 7935586a9dbd0f..f2eaaef8422bf3 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -153,7 +153,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	if (cache_end > offset) {
 		if (offset == cache->offset) {
 			/*
-			 * We cached a dealloc range (found in the io tree) for
+			 * We cached a delalloc range (found in the io tree) for
 			 * a hole or prealloc extent and we have now found a
 			 * file extent item for the same offset. What we have
 			 * now is more recent and up to date, so discard what
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 204674934795cb..4daec404fec621 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -970,7 +970,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
  * Return:
  * > 0          If we can nocow, and updates @write_bytes.
  *  0           If we can't do a nocow write.
- * -EAGAIN      If we can't do a nocow write because snapshoting of the inode's
+ * -EAGAIN      If we can't do a nocow write because snapshotting of the inode's
  *              root is in progress or because we are in a non-blocking IO
  *              context and need to block (@nowait is true).
  * < 0          If an error happened.
@@ -3345,7 +3345,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	 * We could also use the extent map tree to find such delalloc that is
 	 * being flushed, but using the ordered extents tree is more efficient
 	 * because it's usually much smaller as ordered extents are removed from
-	 * the tree once they complete. With the extent maps, we mau have them
+	 * the tree once they complete. With the extent maps, we may have them
 	 * in the extent map tree for a very long time, and they were either
 	 * created by previous writes or loaded by read operations.
 	 */
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5d8d1570a5c948..c2730740d92821 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2282,7 +2282,7 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		 * If this block group has some small extents we don't want to
 		 * use up all of our free slots in the cache with them, we want
 		 * to reserve them to larger extents, however if we have plenty
-		 * of cache left then go ahead an dadd them, no sense in adding
+		 * of cache left then go ahead and add them, no sense in adding
 		 * the overhead of a bitmap if we don't have to.
 		 */
 		if (info->bytes <= fs_info->sectorsize * 8) {
@@ -3829,7 +3829,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 
 /*
  * If we break out of trimming a bitmap prematurely, we should reset the
- * trimming bit.  In a rather contrieved case, it's possible to race here so
+ * trimming bit.  In a rather contrived case, it's possible to race here so
  * reset the state to BTRFS_TRIM_STATE_UNTRIMMED.
  *
  * start = start of bitmap
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 8b118c03cdb881..335209fe37347f 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -58,7 +58,7 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
  * We support the following block sizes for all systems:
  *
  * - 4K
- *   This is the most common block size. For PAGE SIZE > 4K cases the subage
+ *   This is the most common block size. For PAGE SIZE > 4K cases the subpage
  *   mode is used.
  *
  * - PAGE_SIZE
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 2ccba95af06076..5f0b185a7f21ab 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -283,7 +283,7 @@ enum {
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/*
-	 * Features under developmen like Extent tree v2 support is enabled
+	 * Features under development like Extent tree v2 support is enabled
 	 * only under CONFIG_BTRFS_EXPERIMENTAL
 	 */
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fbf968fb16f525..f91c6214698218 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -370,7 +370,7 @@ int btrfs_inode_lock(struct btrfs_inode *inode, unsigned int ilock_flags)
 }
 
 /*
- * Unock inode i_rwsem.
+ * Unlock inode i_rwsem.
  *
  * ilock_flags should contain the same bits set as passed to btrfs_inode_lock()
  * to decide whether the lock acquired is shared or exclusive.
@@ -1990,7 +1990,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 }
 
 /*
- * when nowcow writeback call back.  This checks for snapshots or COW copies
+ * When nocow writeback calls back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
  *
  * If no cow copies or snapshots exist, we write directly to the existing
@@ -2233,7 +2233,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 *    |   OE cleanup  |   Skip     | Untouched |
 		 *
 		 * nocow_one_range() failed, the range [cur_offset, nocow_end] is
-		 * alread cleaned up.
+		 * already cleaned up.
 		 */
 		oe_cleanup_start = start;
 		oe_cleanup_len = cur_offset - start;
@@ -2986,7 +2986,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * If we dropped an inline extent here, we know the range where it is
 	 * was not marked with the EXTENT_DELALLOC_NEW bit, so we update the
 	 * number of bytes only for that range containing the inline extent.
-	 * The remaining of the range will be processed when clearning the
+	 * The remaining of the range will be processed when clearing the
 	 * EXTENT_DELALLOC_BIT bit through the ordered extent completion.
 	 */
 	if (file_pos == 0 && !IS_ALIGNED(drop_args.bytes_found, sectorsize)) {
@@ -4906,7 +4906,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 		goto out;
 
 	/*
-	 * Skip the truncatioin if the range in the target block is already aligned.
+	 * Skip the truncation if the range in the target block is already aligned.
 	 * The seemingly complex check will also handle the same block case.
 	 */
 	if (in_head_block && !IS_ALIGNED(start, blocksize))
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e10daf6631afd6..063291519b363b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -957,7 +957,7 @@ static noinline int btrfs_mksnapshot(struct dentry *parent,
 
 	/*
 	 * Force new buffered writes to reserve space even when NOCOW is
-	 * possible. This is to avoid later writeback (running dealloc) to
+	 * possible. This is to avoid later writeback (running delalloc) to
 	 * fallback to COW mode and unexpectedly fail with ENOSPC.
 	 */
 	btrfs_drew_read_lock(&root->snapshot_lock);
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index a3e6d9616e60bf..0035851d72b00f 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -361,7 +361,7 @@ void btrfs_drew_read_lock(struct btrfs_drew_lock *lock)
 	atomic_inc(&lock->readers);
 
 	/*
-	 * Ensure the pending reader count is perceieved BEFORE this reader
+	 * Ensure the pending reader count is perceived BEFORE this reader
 	 * goes to sleep in case of active writers. This guarantees new writers
 	 * won't be allowed and that the current reader will be woken up when
 	 * the last active writer finishes its jobs.
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index af29df98ac1454..a4673e7d95d705 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -74,7 +74,7 @@ enum btrfs_lock_nesting {
 	BTRFS_NESTING_NEW_ROOT,
 
 	/*
-	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
+	 * We are limited to MAX_LOCKDEP_SUBCLASSES number of subclasses, so
 	 * add this in here and add a static_assert to keep us from going over
 	 * the limit.  As of this writing we're limited to 8, and we're
 	 * definitely using 8, hence this check to keep us from messing up in
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ce5f6732bfb585..d86020ace69c6d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -113,7 +113,7 @@ enum {
 	/* Which blocks are covered by extent items. */
 	scrub_bitmap_nr_has_extent = 0,
 
-	/* Which blocks are meteadata. */
+	/* Which blocks are metadata. */
 	scrub_bitmap_nr_is_metadata,
 
 	/*
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index faa3710fa074fe..c5771df3a2c7c0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1738,7 +1738,7 @@ static int read_symlink(struct btrfs_root *root,
 		 * An empty symlink inode. Can happen in rare error paths when
 		 * creating a symlink (transaction committed before the inode
 		 * eviction handler removed the symlink inode items and a crash
-		 * happened in between or the subvol was snapshoted in between).
+		 * happened in between or the subvol was snapshotted in between).
 		 * Print an informative message to dmesg/syslog so that the user
 		 * can delete the symlink.
 		 */
@@ -2768,7 +2768,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
  * processing an inode that is a directory and it just got renamed, and existing
  * entries in the cache may refer to inodes that have the directory in their
  * full path - in which case we would generate outdated paths (pre-rename)
- * for the inodes that the cache entries point to. Instead of prunning the
+ * for the inodes that the cache entries point to. Instead of pruning the
  * cache when inserting, do it after we finish processing each inode at
  * finish_inode_if_needed().
  */
@@ -7984,7 +7984,7 @@ static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 }
 
 /*
- * Make sure any existing dellaloc is flushed for any root used by a send
+ * Make sure any existing delalloc is flushed for any root used by a send
  * operation so that we do not miss any data and we do not race with writeback
  * finishing and changing a tree while send is using the tree. This could
  * happen if a subvolume is in RW mode, has delalloc, is turned to RO mode and
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0481c693ac2eaf..0e5c0c80e0fe6a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -479,7 +479,7 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 
 	/*
 	 * On the zoned mode, we always allocate one zone as one chunk.
-	 * Returning non-zone size alingned bytes here will result in
+	 * Returning non-zone size aligned bytes here will result in
 	 * less pressure for the async metadata reclaim process, and it
 	 * will over-commit too much leading to ENOSPC. Align down to the
 	 * zone size to avoid that.
@@ -1528,7 +1528,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	 * turned into error mode due to a transaction abort when flushing space
 	 * above, in that case fail with the abort error instead of returning
 	 * success to the caller if we can steal from the global rsv - this is
-	 * just to have caller fail immeditelly instead of later when trying to
+	 * just to have caller fail immediately instead of later when trying to
 	 * modify the fs, making it easier to debug -ENOSPC problems.
 	 */
 	if (BTRFS_FS_ERROR(fs_info)) {
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index cb4f97833dc34a..5ca8d4db67220c 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -690,7 +690,7 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 									\
 	GET_SUBPAGE_BITMAP(fs_info, folio, name, &bitmap);		\
 	btrfs_warn(fs_info,						\
-	"dumpping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
+	"dumping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
 		   start, len, folio_pos(folio),			\
 		   blocks_per_folio, &bitmap);				\
 }
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index ee0710eb13fd0a..ad0552db7c7dcb 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -13,7 +13,7 @@ struct address_space;
 struct folio;
 
 /*
- * Extra info for subpapge bitmap.
+ * Extra info for subpage bitmap.
  *
  * For subpage we pack all uptodate/dirty/writeback/ordered bitmaps into
  * one larger bitmap.
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index dd3dda8dacc12e..6cd9ea81361610 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1269,7 +1269,7 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
 
 	/*
-	 * We need to cleanup all defragable inodes if the autodefragment is
+	 * We need to cleanup all defraggable inodes if the autodefragment is
 	 * close or the filesystem is read only.
 	 */
 	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
index 265370e79a546d..e2248acb906b74 100644
--- a/fs/btrfs/tests/delayed-refs-tests.c
+++ b/fs/btrfs/tests/delayed-refs-tests.c
@@ -997,12 +997,12 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
 
 	ret = simple_tests(&trans);
 	if (!ret) {
-		test_msg("running delayed refs merg tests on metadata refs");
+		test_msg("running delayed refs merge tests on metadata refs");
 		ret = merge_tests(&trans, BTRFS_REF_METADATA);
 	}
 
 	if (!ret) {
-		test_msg("running delayed refs merg tests on data refs");
+		test_msg("running delayed refs merge tests on data refs");
 		ret = merge_tests(&trans, BTRFS_REF_DATA);
 	}
 
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 3a86534c116f2f..42af6c737c6e6f 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -1095,7 +1095,7 @@ int btrfs_test_extent_map(void)
 			/*
 			 * Test a chunk with 2 data stripes one of which
 			 * intersects the physical address of the super block
-			 * is correctly recognised.
+			 * is correctly recognized.
 			 */
 			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
 			.physical_start = SZ_64M - SZ_4M,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 25ee0183e17812..2b1c18f83234cb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2423,7 +2423,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * them.
 	 *
 	 * We needn't worry that this operation will corrupt the snapshots,
-	 * because all the tree which are snapshoted will be forced to COW
+	 * because all the tree which are snapshotted will be forced to COW
 	 * the nodes and leaves.
 	 */
 	ret = btrfs_run_delayed_items(trans);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 0f556f4de3f924..0b3d9d11f0984d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1209,7 +1209,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	/*
 	 * For legacy root item, the members starting at generation_v2 will be
 	 * all filled with 0.
-	 * And since we allow geneartion_v2 as 0, it will still pass the check.
+	 * And since we allow generation_v2 as 0, it will still pass the check.
 	 */
 	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
 			   btrfs_item_size(leaf, slot));
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ea8fdf99752802..b91cc7ac28d8e1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1816,7 +1816,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 
 		/*
 		 * fixup on a directory may create new entries,
-		 * make sure we always look for the highset possible
+		 * make sure we always look for the highest possible
 		 * offset
 		 */
 		key.offset = (u64)-1;
@@ -3619,7 +3619,7 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 
 	/*
 	 * The inode was previously logged and then evicted, set logged_trans to
-	 * the current transacion's ID, to avoid future tree searches as long as
+	 * the current transaction's ID, to avoid future tree searches as long as
 	 * the inode is not evicted again.
 	 */
 	spin_lock(&inode->lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db26934da9f6e3..a031aafe253ff7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1377,8 +1377,8 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 	}
 
 	/*
-	 * Make sure the last byte of label is properly NUL termiated.  We use
-	 * '%s' to print the label, if not properly NUL termiated we can access
+	 * Make sure the last byte of label is properly NUL terminated.  We use
+	 * '%s' to print the label, if not properly NUL terminated we can access
 	 * beyond the label.
 	 */
 	if (super->label[0] && super->label[BTRFS_LABEL_SIZE - 1])
@@ -4458,7 +4458,7 @@ static void describe_balance_start_or_resume(struct btrfs_fs_info *fs_info)
 }
 
 /*
- * Should be called with balance mutexe held
+ * Should be called with balance mutex held
  */
 int btrfs_balance(struct btrfs_fs_info *fs_info,
 		  struct btrfs_balance_control *bctl,
@@ -7481,7 +7481,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	/*
 	 * Lockdep complains about possible circular locking dependency between
 	 * a disk's open_mutex (struct gendisk.open_mutex), the rw semaphores
-	 * used for freeze procection of a fs (struct super_block.s_writers),
+	 * used for freeze protection of a fs (struct super_block.s_writers),
 	 * which we take when starting a transaction, and extent buffers of the
 	 * chunk tree if we call read_one_dev() while holding a lock on an
 	 * extent buffer of the chunk tree. Since we are mounting the filesystem
@@ -7914,8 +7914,6 @@ int btrfs_bg_type_to_factor(u64 flags)
 	return btrfs_raid_array[index].ncopies;
 }
 
-
-
 static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 				 u64 chunk_offset, u64 devid,
 				 u64 physical_offset, u64 physical_len)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a56e873a30295e..2cbf8080eade06 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -34,7 +34,7 @@ struct btrfs_zoned_device_info;
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
 /*
- * Arbitratry maximum size of one discard request to limit potentially long time
+ * Arbitrary maximum size of one discard request to limit potentially long time
  * spent in blkdev_issue_discard().
  */
 #define BTRFS_MAX_DISCARD_CHUNK_SIZE	(SZ_1G)
@@ -495,7 +495,7 @@ struct btrfs_discard_stripe {
 };
 
 /*
- * Context for IO subsmission for device stripe.
+ * Context for IO submission for device stripe.
  *
  * - Track the unfinished mirrors for mirror based profiles
  *   Mirror based profiles are SINGLE/DUP/RAID1/RAID10.
-- 
2.50.1


