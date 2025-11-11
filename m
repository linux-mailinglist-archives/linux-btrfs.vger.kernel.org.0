Return-Path: <linux-btrfs+bounces-18866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF6C4E862
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 15:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5626E3A5AC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04225F975;
	Tue, 11 Nov 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PRfBEgwR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PRfBEgwR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA21548C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871523; cv=none; b=fn+YOkh7smYZ3WL1rEy6Uv9M8WdFD1w0latyPRiQF/YpQQ1sR/r53oDYjNTXLO8mIHjo41HdE3yoh/gj4KmvWBrSlOUxAum5HhxtO/XpmSK1iAIfDS0QLFTrIEA8LCyGauTyvjZHuBT81TwIYVAN/qztPshHiFax1fehxOj2E8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871523; c=relaxed/simple;
	bh=s4nIiqRzg1yc0MqgV6PEW1545fJGiNDZcmFvPJMx0Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBLr+BNRwOjcD+KRGtSI6QH6wbuO6BIOvsv2cKdBfudEr9IjebFaVhJiE5pLnimPfLk+dNfncEXwHrHxIES8hPs4ld6aroXXK6w99mzlIoAgx9VGdTahErXU4XUUbX0Rxcq71i3HYtxtybbCVXjJTli5/Eu2VUAmvK2Mhc5pKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PRfBEgwR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PRfBEgwR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C202021A98;
	Tue, 11 Nov 2025 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762871518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=67w3YSAM9qMZzBkoli4jpFyFY9eEeqDK32wfrAYfn+M=;
	b=PRfBEgwR/w6I/Ojp2EmBTCgZbTRuBko1WqZsOpkj87Zq0OxipaNE8X9IP46HVBEV9TOzYY
	dZdAmoDcMHJ1H6vU3oBAJPSu3VpEAYtYJXMfOXglyD8wtXLJFcw93i+7wRd0oZgL/CI75f
	nHiidxj2c489KqctA4N18v0CK5RNXYQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762871518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=67w3YSAM9qMZzBkoli4jpFyFY9eEeqDK32wfrAYfn+M=;
	b=PRfBEgwR/w6I/Ojp2EmBTCgZbTRuBko1WqZsOpkj87Zq0OxipaNE8X9IP46HVBEV9TOzYY
	dZdAmoDcMHJ1H6vU3oBAJPSu3VpEAYtYJXMfOXglyD8wtXLJFcw93i+7wRd0oZgL/CI75f
	nHiidxj2c489KqctA4N18v0CK5RNXYQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BACFF149DB;
	Tue, 11 Nov 2025 14:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3j+WLd5IE2nqIAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 11 Nov 2025 14:31:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: make a few more ASSERTs verbose
Date: Tue, 11 Nov 2025 15:31:52 +0100
Message-ID: <20251111143152.2095695-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

We have support for optional string to be printed in ASSERT() (added in
19468a623a9109 ("btrfs: enhance ASSERT() to take optional format
string")), it's not yet everywhere it could be so add a few more files.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c        | 17 ++++++++-------
 fs/btrfs/space-info.c   | 30 ++++++++++++++++-----------
 fs/btrfs/subpage.c      | 10 ++++++---
 fs/btrfs/transaction.c  | 41 +++++++++++++++++++++++++-----------
 fs/btrfs/tree-checker.c |  2 +-
 fs/btrfs/tree-log.c     | 46 +++++++++++++++++++++++++++--------------
 fs/btrfs/zoned.c        | 37 ++++++++++++++++++++-------------
 7 files changed, 119 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b6278406a1030d..439d6d36ed8e2b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -964,8 +964,9 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 	const unsigned long old_error_bitmap = scrub_bitmap_read_error(stripe);
 	int i;
 
-	ASSERT(stripe->mirror_num >= 1);
-	ASSERT(atomic_read(&stripe->pending_io) == 0);
+	ASSERT(stripe->mirror_num >= 1, "stripe->mirror_num=%d", stripe->mirror_num);
+	ASSERT(atomic_read(&stripe->pending_io) == 0,
+	       "atomic_read(&stripe->pending_io)=%d", atomic_read(&stripe->pending_io));
 
 	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
 		/* The current sector cannot be merged, submit the bio. */
@@ -1028,7 +1029,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		int ret;
 
 		/* For scrub, our mirror_num should always start at 1. */
-		ASSERT(stripe->mirror_num >= 1);
+		ASSERT(stripe->mirror_num >= 1, "stripe->mirror_num=%d", stripe->mirror_num);
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
 				      stripe->logical, &mapped_len, &bioc,
 				      NULL, NULL);
@@ -1168,7 +1169,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	int mirror;
 	int i;
 
-	ASSERT(stripe->mirror_num > 0);
+	ASSERT(stripe->mirror_num >= 1, "stripe->mirror_num=%d", stripe->mirror_num);
 
 	wait_scrub_stripe_io(stripe);
 	scrub_verify_one_stripe(stripe, scrub_bitmap_read_has_extent(stripe));
@@ -1484,7 +1485,7 @@ static int compare_extent_item_range(struct btrfs_path *path,
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	ASSERT(key.type == BTRFS_EXTENT_ITEM_KEY ||
-	       key.type == BTRFS_METADATA_ITEM_KEY);
+	       key.type == BTRFS_METADATA_ITEM_KEY, "key.type=%u", key.type);
 	if (key.type == BTRFS_METADATA_ITEM_KEY)
 		len = fs_info->nodesize;
 	else
@@ -1589,7 +1590,7 @@ static void get_extent_info(struct btrfs_path *path, u64 *extent_start_ret,
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	ASSERT(key.type == BTRFS_METADATA_ITEM_KEY ||
-	       key.type == BTRFS_EXTENT_ITEM_KEY);
+	       key.type == BTRFS_EXTENT_ITEM_KEY, "key.type=%u", key.type);
 	*extent_start_ret = key.objectid;
 	if (key.type == BTRFS_METADATA_ITEM_KEY)
 		*size_ret = path->nodes[0]->fs_info->nodesize;
@@ -1687,7 +1688,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	scrub_stripe_reset_bitmaps(stripe);
 
 	/* The range must be inside the bg. */
-	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
+	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length,
+	       "bg->start=%llu logical_start=%llu logical_end=%llu end=%llu",
+	       bg->start, logical_start, logical_end, bg->start + bg->length);
 
 	ret = find_first_extent_item(extent_root, extent_path, logical_start,
 				     logical_len);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4ae6928fdca42f..9edec55d3fa22d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -202,7 +202,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
 	if (btrfs_is_zoned(fs_info))
 		return fs_info->zone_size;
 
-	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
+	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK, "flags=%llu", flags);
 
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
 		return BTRFS_MAX_DATA_CHUNK_SIZE;
@@ -253,8 +253,9 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	struct btrfs_space_info *sub_group;
 	int ret;
 
-	ASSERT(parent->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
-	ASSERT(id != BTRFS_SUB_GROUP_PRIMARY);
+	ASSERT(parent->subgroup_id == BTRFS_SUB_GROUP_PRIMARY,
+	       "parent->subgroup_id=%d", parent->subgroup_id);
+	ASSERT(id != BTRFS_SUB_GROUP_PRIMARY, "id=%d", id);
 
 	sub_group = kzalloc(sizeof(*sub_group), GFP_NOFS);
 	if (!sub_group)
@@ -522,7 +523,9 @@ static void remove_ticket(struct btrfs_space_info *space_info,
 
 	if (!list_empty(&ticket->list)) {
 		list_del_init(&ticket->list);
-		ASSERT(space_info->reclaim_size >= ticket->bytes);
+		ASSERT(space_info->reclaim_size >= ticket->bytes,
+		       "space_info->reclaim_size=%llu ticket->bytes=%llu",
+		       space_info->reclaim_size, ticket->bytes);
 		space_info->reclaim_size -= ticket->bytes;
 	}
 
@@ -1662,7 +1665,7 @@ static int handle_reserve_ticket(struct btrfs_space_info *space_info,
 		priority_reclaim_data_space(space_info, ticket);
 		break;
 	default:
-		ASSERT(0);
+		ASSERT(0, "flush=%d", flush);
 		break;
 	}
 
@@ -1674,7 +1677,8 @@ static int handle_reserve_ticket(struct btrfs_space_info *space_info,
 	 * releasing reserved space (if an error happens the expectation is that
 	 * space wasn't reserved at all).
 	 */
-	ASSERT(!(ticket->bytes == 0 && ticket->error));
+	ASSERT(!(ticket->bytes == 0 && ticket->error),
+	       "ticket->bytes=%llu ticket->error=%d", ticket->bytes, ticket->error);
 	trace_btrfs_reserve_ticket(space_info->fs_info, space_info->flags,
 				   orig_bytes, start_ns, flush, ticket->error);
 	return ret;
@@ -1749,7 +1753,7 @@ static int reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 	int ret = -ENOSPC;
 	bool pending_tickets;
 
-	ASSERT(orig_bytes);
+	ASSERT(orig_bytes, "orig_bytes=%llu", orig_bytes);
 	/*
 	 * If have a transaction handle (current->journal_info != NULL), then
 	 * the flush method can not be neither BTRFS_RESERVE_FLUSH_ALL* nor
@@ -1758,9 +1762,9 @@ static int reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 	 */
 	if (current->journal_info) {
 		/* One assert per line for easier debugging. */
-		ASSERT(flush != BTRFS_RESERVE_FLUSH_ALL);
-		ASSERT(flush != BTRFS_RESERVE_FLUSH_ALL_STEAL);
-		ASSERT(flush != BTRFS_RESERVE_FLUSH_EVICT);
+		ASSERT(flush != BTRFS_RESERVE_FLUSH_ALL, "flush=%d", flush);
+		ASSERT(flush != BTRFS_RESERVE_FLUSH_ALL_STEAL, "flush=%d", flush);
+		ASSERT(flush != BTRFS_RESERVE_FLUSH_EVICT, "flush=%d", flush);
 	}
 
 	if (flush == BTRFS_RESERVE_FLUSH_DATA)
@@ -1921,8 +1925,10 @@ int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 
 	ASSERT(flush == BTRFS_RESERVE_FLUSH_DATA ||
 	       flush == BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE ||
-	       flush == BTRFS_RESERVE_NO_FLUSH);
-	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
+	       flush == BTRFS_RESERVE_NO_FLUSH, "flush=%d", flush);
+	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA,
+	       "current->journal_info=0x%lx flush=%d",
+	       (unsigned long)current->journal_info, flush);
 
 	ret = reserve_bytes(space_info, bytes, flush);
 	if (ret == -ENOSPC) {
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 80cd27d3267f57..60f23de779f9a6 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -180,7 +180,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	/* Basic checks */
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(len, fs_info->sectorsize));
+	       IS_ALIGNED(len, fs_info->sectorsize), "start=%llu len=%u", start, len);
 	/*
 	 * The range check only works for mapped page, we can still have
 	 * unmapped page like dummy extent buffer pages.
@@ -249,7 +249,9 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 		clear_bit(bit, bfs->bitmaps);
 		cleared++;
 	}
-	ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
+	ASSERT(atomic_read(&bfs->nr_locked) >= cleared,
+	       "atomic_read(&bfs->nr_locked)=%d cleared=%d",
+	       atomic_read(&bfs->nr_locked), cleared);
 	last = atomic_sub_and_test(cleared, &bfs->nr_locked);
 	spin_unlock_irqrestore(&bfs->lock, flags);
 	return last;
@@ -328,7 +330,9 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		if (test_and_clear_bit(bit + start_bit, bfs->bitmaps))
 			cleared++;
 	}
-	ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
+	ASSERT(atomic_read(&bfs->nr_locked) >= cleared,
+	       "atomic_read(&bfs->nr_locked)=%d cleared=%d",
+	       atomic_read(&bfs->nr_locked), cleared);
 	last = atomic_sub_and_test(cleared, &bfs->nr_locked);
 	spin_unlock_irqrestore(&bfs->lock, flags);
 	if (last)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 03c62fd1a091d8..05ee4391c83a39 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -186,7 +186,8 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 	 * At this point no one can be using this transaction to modify any tree
 	 * and no one can start another transaction to modify any tree either.
 	 */
-	ASSERT(cur_trans->state == TRANS_STATE_COMMIT_DOING);
+	ASSERT(cur_trans->state == TRANS_STATE_COMMIT_DOING,
+	       "cur_trans->state=%d", cur_trans->state);
 
 	down_write(&fs_info->commit_root_sem);
 
@@ -1025,13 +1026,18 @@ static void btrfs_trans_release_metadata(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	if (!trans->block_rsv) {
-		ASSERT(!trans->bytes_reserved);
-		ASSERT(!trans->delayed_refs_bytes_reserved);
+		ASSERT(trans->bytes_reserved == 0,
+		       "trans->bytes_reserved=%llu", trans->bytes_reserved);
+		ASSERT(trans->delayed_refs_bytes_reserved == 0,
+		       "trans->delayed_refs_bytes_reserved=%llu",
+		       trans->delayed_refs_bytes_reserved);
 		return;
 	}
 
 	if (!trans->bytes_reserved) {
-		ASSERT(!trans->delayed_refs_bytes_reserved);
+		ASSERT(trans->delayed_refs_bytes_reserved == 0,
+		       "trans->delayed_refs_bytes_reserved=%llu",
+		       trans->delayed_refs_bytes_reserved);
 		return;
 	}
 
@@ -1230,7 +1236,8 @@ int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
 	bool errors = false;
 	int ret;
 
-	ASSERT(btrfs_root_id(log_root) == BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(btrfs_root_id(log_root) == BTRFS_TREE_LOG_OBJECTID,
+	       "root_id(log_root)=%llu", btrfs_root_id(log_root));
 
 	ret = __btrfs_wait_marked_extents(fs_info, dirty_pages);
 	if ((mark & EXTENT_DIRTY_LOG1) &&
@@ -1335,7 +1342,8 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	 * At this point no one can be using this transaction to modify any tree
 	 * and no one can start another transaction to modify any tree either.
 	 */
-	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
+	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING,
+	       "trans->transaction->state=%d", trans->transaction->state);
 
 	eb = btrfs_lock_root_node(fs_info->tree_root);
 	ret = btrfs_cow_block(trans, fs_info->tree_root, eb, NULL,
@@ -1469,7 +1477,8 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	 * At this point no one can be using this transaction to modify any tree
 	 * and no one can start another transaction to modify any tree either.
 	 */
-	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
+	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING,
+	       "trans->transaction->state=%d", trans->transaction->state);
 
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	while (1) {
@@ -1487,9 +1496,15 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			 * At this point we can neither have tasks logging inodes
 			 * from a root nor trying to commit a log tree.
 			 */
-			ASSERT(atomic_read(&root->log_writers) == 0);
-			ASSERT(atomic_read(&root->log_commit[0]) == 0);
-			ASSERT(atomic_read(&root->log_commit[1]) == 0);
+			ASSERT(atomic_read(&root->log_writers) == 0,
+			       "atomic_read(&root->log_writers)=%d",
+			       atomic_read(&root->log_writers));
+			ASSERT(atomic_read(&root->log_commit[0]) == 0,
+			       "atomic_read(&root->log_commit[0])=%d",
+			       atomic_read(&root->log_commit[0]));
+			ASSERT(atomic_read(&root->log_commit[1]) == 0,
+			       "atomic_read(&root->log_commit[1])=%d",
+			       atomic_read(&root->log_commit[1]));
 
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)btrfs_root_id(root),
@@ -2158,7 +2173,8 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
 		return;
 
 	lockdep_assert_held(&trans->fs_info->trans_lock);
-	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_PREP);
+	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_PREP,
+	       "cur_trans->state=%d", cur_trans->state);
 
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
 }
@@ -2185,7 +2201,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *prev_trans = NULL;
 	int ret;
 
-	ASSERT(refcount_read(&trans->use_count) == 1);
+	ASSERT(refcount_read(&trans->use_count) == 1,
+	       "refcount_read(&trans->use_count)=%d", refcount_read(&trans->use_count));
 	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
 	clear_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 5684750ca7a64a..c21c21adf61ed1 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -186,7 +186,7 @@ static bool check_prev_ino(struct extent_buffer *leaf,
 	       key->type == BTRFS_INODE_EXTREF_KEY ||
 	       key->type == BTRFS_DIR_INDEX_KEY ||
 	       key->type == BTRFS_DIR_ITEM_KEY ||
-	       key->type == BTRFS_EXTENT_DATA_KEY);
+	       key->type == BTRFS_EXTENT_DATA_KEY, "key->type=%u", key->type);
 
 	/*
 	 * Only subvolume trees along with their reloc trees need this check.
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8e41fb906c6e35..e40e1d746381df 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -263,7 +263,7 @@ static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *r
 	struct btrfs_inode *inode;
 
 	/* Only meant to be called for subvolume roots and not for log roots. */
-	ASSERT(btrfs_is_fstree(btrfs_root_id(root)));
+	ASSERT(btrfs_is_fstree(btrfs_root_id(root)), "root_id=%llu", btrfs_root_id(root));
 
 	/*
 	 * We're holding a transaction handle whether we are logging or
@@ -502,7 +502,7 @@ static int overwrite_item(struct walk_control *wc)
 	 * the leaf before writing into the log tree. See the comments at
 	 * copy_items() for more details.
 	 */
-	ASSERT(btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID, "root_id=%llu", btrfs_root_id(root));
 
 	item_size = btrfs_item_size(wc->log_leaf, wc->log_slot);
 	src_ptr = btrfs_item_ptr_offset(wc->log_leaf, wc->log_slot);
@@ -2282,7 +2282,8 @@ static noinline int replay_one_dir_item(struct walk_control *wc)
 	struct btrfs_dir_item *di;
 
 	/* We only log dir index keys, which only contain a single dir item. */
-	ASSERT(wc->log_key.type == BTRFS_DIR_INDEX_KEY);
+	ASSERT(wc->log_key.type == BTRFS_DIR_INDEX_KEY,
+	       "wc->log_key.type=%u", wc->log_key.type);
 
 	di = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_dir_item);
 	ret = replay_one_name(wc, di);
@@ -2434,7 +2435,7 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	 * we need to do is process the dir index keys, we (and our caller) can
 	 * safely ignore dir item keys (key type BTRFS_DIR_ITEM_KEY).
 	 */
-	ASSERT(dir_key->type == BTRFS_DIR_INDEX_KEY);
+	ASSERT(dir_key->type == BTRFS_DIR_INDEX_KEY, "dir_key->type=%u", dir_key->type);
 
 	eb = wc->subvol_path->nodes[0];
 	slot = wc->subvol_path->slots[0];
@@ -3339,7 +3340,8 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		mutex_unlock(&root->log_mutex);
 		return ctx->log_ret;
 	}
-	ASSERT(log_transid == root->log_transid);
+	ASSERT(log_transid == root->log_transid,
+	       "log_transid=%d root->log_transid=%d", log_transid, root->log_transid);
 	atomic_set(&root->log_commit[index1], 1);
 
 	/* wait for previous tree log sync to complete */
@@ -3479,7 +3481,9 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 			ret = root_log_ctx.log_ret;
 		goto out;
 	}
-	ASSERT(root_log_ctx.log_transid == log_root_tree->log_transid);
+	ASSERT(root_log_ctx.log_transid == log_root_tree->log_transid,
+	       "root_log_ctx.log_transid=%d log_root_tree->log_transid=%d",
+		root_log_ctx.log_transid, log_root_tree->log_transid);
 	atomic_set(&log_root_tree->log_commit[index2], 1);
 
 	if (atomic_read(&log_root_tree->log_commit[(index2 + 1) % 2])) {
@@ -3583,7 +3587,9 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 * someone else already started it. We use <= and not < because the
 	 * first log transaction has an ID of 0.
 	 */
-	ASSERT(btrfs_get_root_last_log_commit(root) <= log_transid);
+	ASSERT(btrfs_get_root_last_log_commit(root) <= log_transid,
+	       "last_log_commit(root)=%d log_transid=%d",
+	       btrfs_get_root_last_log_commit(root), log_transid);
 	btrfs_set_root_last_log_commit(root, log_transid);
 
 out_wake_log_root:
@@ -4027,7 +4033,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 	int ret;
 	int i;
 
-	ASSERT(count > 0);
+	ASSERT(count > 0, "count=%d", count);
 	batch.nr = count;
 
 	if (count == 1) {
@@ -4080,7 +4086,9 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 	btrfs_release_path(dst_path);
 
 	last_index = batch.keys[count - 1].offset;
-	ASSERT(last_index > inode->last_dir_index_offset);
+	ASSERT(last_index > inode->last_dir_index_offset,
+	       "last_index=%llu inode->last_dir_index_offset=%llu",
+	       last_index, inode->last_dir_index_offset);
 
 	/*
 	 * If for some unexpected reason the last item's index is not greater
@@ -4404,7 +4412,9 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		 * change in the current transaction), then we don't need to log
 		 * a range, last_old_dentry_offset is == to last_offset.
 		 */
-		ASSERT(last_old_dentry_offset <= last_offset);
+		ASSERT(last_old_dentry_offset <= last_offset,
+		       "last_old_dentry_offset=%llu last_offset=%llu",
+		       last_old_dentry_offset, last_offset);
 		if (last_old_dentry_offset < last_offset)
 			ret = insert_dir_log_key(trans, log, path, ino,
 						 last_old_dentry_offset + 1,
@@ -6528,7 +6538,7 @@ static int log_delayed_insertion_items(struct btrfs_trans_handle *trans,
 		curr = list_next_entry(curr, log_list);
 	}
 
-	ASSERT(batch.nr >= 1);
+	ASSERT(batch.nr >= 1, "batch.nr=%d", batch.nr);
 	ret = insert_delayed_items_batch(trans, log, path, &batch, first);
 
 	curr = list_last_entry(delayed_ins_list, struct btrfs_delayed_item,
@@ -6572,7 +6582,9 @@ static int log_delayed_deletions_full(struct btrfs_trans_handle *trans,
 		}
 
 		last_dir_index = curr->index;
-		ASSERT(last_dir_index >= first_dir_index);
+		ASSERT(last_dir_index >= first_dir_index,
+		       "last_dir_index=%llu first_dir_index=%llu",
+		       last_dir_index, first_dir_index);
 
 		ret = insert_dir_log_key(trans, inode->root->log_root, path,
 					 ino, first_dir_index, last_dir_index);
@@ -6666,7 +6678,9 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 			goto next_batch;
 
 		last_dir_index = last->index;
-		ASSERT(last_dir_index >= first_dir_index);
+		ASSERT(last_dir_index >= first_dir_index,
+		       "last_dir_index=%llu first_dir_index=%llu",
+		       last_dir_index, first_dir_index);
 		/*
 		 * If this range starts right after where the previous one ends,
 		 * then we want to reuse the previous range item and change its
@@ -6733,7 +6747,8 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 	 */
 	lockdep_assert_not_held(&inode->log_mutex);
 
-	ASSERT(!ctx->logging_new_delayed_dentries);
+	ASSERT(!ctx->logging_new_delayed_dentries,
+	       "ctx->logging_new_delayed_dentries=%d", ctx->logging_new_delayed_dentries);
 	ctx->logging_new_delayed_dentries = true;
 
 	list_for_each_entry(item, delayed_ins_list, log_list) {
@@ -7950,7 +7965,8 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		struct btrfs_path *path;
 		struct fscrypt_name fname;
 
-		ASSERT(old_dir_index >= BTRFS_DIR_START_INDEX);
+		ASSERT(old_dir_index >= BTRFS_DIR_START_INDEX,
+		       "old_dir_index=%llu", old_dir_index);
 
 		ret = fscrypt_setup_filename(&old_dir->vfs_inode,
 					     &old_dentry->d_name, 0, &fname);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 41a4a7d50bd3d8..0df78e825ca4e1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -93,7 +93,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 	sector_t sector;
 
 	for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
-		ASSERT(zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL);
+		ASSERT(zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL,
+		       "zones[%d].type=%d", i, zones[i].type);
 		empty[i] = (zones[i].cond == BLK_ZONE_COND_EMPTY);
 		full[i] = sb_zone_is_full(&zones[i]);
 	}
@@ -166,14 +167,14 @@ static inline u32 sb_zone_number(int shift, int mirror)
 {
 	u64 zone = U64_MAX;
 
-	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX, "mirror=%d", mirror);
 	switch (mirror) {
 	case 0: zone = 0; break;
 	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
 	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
 	}
 
-	ASSERT(zone <= U32_MAX);
+	ASSERT(zone <= U32_MAX, "zone=%llu", zone);
 
 	return (u32)zone;
 }
@@ -240,7 +241,8 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 		unsigned int i;
 		u32 zno;
 
-		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+		ASSERT(IS_ALIGNED(pos, zinfo->zone_size),
+		       "pos=%llu zinfo->zone_size=%llu", pos, zinfo->zone_size);
 		zno = pos >> zinfo->zone_size_shift;
 		/*
 		 * We cannot report zones beyond the zone end. So, it is OK to
@@ -1055,8 +1057,10 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 	bool have_sb;
 	int i;
 
-	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
-	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size),
+	       "hole_start=%llu zinfo->zone_size=%llu", hole_start, zinfo->zone_size);
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size),
+	       "num_bytes=%llu zinfo->zone_size=%llu", num_bytes, zinfo->zone_size);
 
 	while (pos < hole_end) {
 		begin = pos >> shift;
@@ -1172,8 +1176,10 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	u64 pos;
 	int ret;
 
-	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
-	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(start, zinfo->zone_size),
+	       "start=%llu, zinfo->zone_size=%llu", start, zinfo->zone_size);
+	ASSERT(IS_ALIGNED(size, zinfo->zone_size),
+	       "size=%llu, zinfo->zone_size=%llu", size, zinfo->zone_size);
 
 	if (begin + nbits > zinfo->nr_zones)
 		return -ERANGE;
@@ -1866,7 +1872,7 @@ static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
 	em = btrfs_search_extent_mapping(em_tree, ordered->file_offset,
 					 ordered->num_bytes);
 	/* The em should be a new COW extent, thus it should not have an offset. */
-	ASSERT(em->offset == 0);
+	ASSERT(em->offset == 0, "em->offset=%llu", em->offset);
 	em->disk_bytenr = logical;
 	btrfs_free_extent_map(em);
 	write_unlock(&em_tree->lock);
@@ -2577,7 +2583,8 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 			struct btrfs_space_info *reloc_sinfo = data_sinfo->sub_group[0];
 			int factor;
 
-			ASSERT(reloc_sinfo->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+			ASSERT(reloc_sinfo->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC,
+			       "reloc_sinfo->subgroup_id=%d", reloc_sinfo->subgroup_id);
 			factor = btrfs_bg_type_to_factor(bg->flags);
 
 			down_write(&space_info->groups_sem);
@@ -2591,9 +2598,9 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 			space_info->disk_total -= bg->length * factor;
 			space_info->disk_total -= bg->zone_unusable;
 			/* There is no allocation ever happened. */
-			ASSERT(bg->used == 0);
+			ASSERT(bg->used == 0, "bg->used=%llu", bg->used);
 			/* No super block in a block group on the zoned setup. */
-			ASSERT(bg->bytes_super == 0);
+			ASSERT(bg->bytes_super == 0, "bg->bytes_super=%llu", bg->bytes_super);
 			spin_unlock(&space_info->lock);
 
 			bg->space_info = reloc_sinfo;
@@ -2619,7 +2626,8 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 
 	/* Allocate new BG in the data relocation space_info. */
 	space_info = data_sinfo->sub_group[0];
-	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC,
+	       "space_info->subgroup_id=%d", space_info->subgroup_id);
 	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 	btrfs_end_transaction(trans);
 	if (ret == 1) {
@@ -2960,7 +2968,8 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 		 * This holds because we currently reset fully used then freed
 		 * block group.
 		 */
-		ASSERT(reclaimed == bg->zone_capacity);
+		ASSERT(reclaimed == bg->zone_capacity,
+		       "reclaimed=%llu bg->zone_capacity=%llu", reclaimed, bg->zone_capacity);
 		bg->free_space_ctl->free_space += reclaimed;
 		space_info->bytes_zone_unusable -= reclaimed;
 		spin_unlock(&bg->lock);
-- 
2.51.1


