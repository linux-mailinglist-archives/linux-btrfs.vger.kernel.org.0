Return-Path: <linux-btrfs+bounces-13519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C58AA1032
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 17:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969BF17EAD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592521D5A1;
	Tue, 29 Apr 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPxrWtpq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPxrWtpq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE61DAC81
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939896; cv=none; b=F/CG7mwweqvKqFngt37PcDnUNDAStFMfp6GVyuIexDXNfTd73Twp/OWBQgDXT91JjLAKBnb4HgnegoTdNKtexNo/dMuKcEw1XLDt8Fr1XBvXyYOK8/RPaw/XBCfWOElCYdTMnEXJ/xoT8afKCyhmPac/HhOwY/08XhhyPBd9qy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939896; c=relaxed/simple;
	bh=ezaNv9hIoUDtqqCym3YVSmzlawe2U8oF3w6ngsru3I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQvITmk7g+6onDpFUsoA1Dd3x4rxx+tWc6/V7ITKCB71Jy3xyHGOU06LnU0XjAy34pnAK/jxGGR4Vut9BoANX5Jeq8MPLJlvTRBap8KZGAcPVMtmc0V9Lr650NKgOGbqX01eFl2RquXIbKdpHI5jkmUoR3NDj0yQL05eLgUriIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KPxrWtpq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KPxrWtpq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6C121F895;
	Tue, 29 Apr 2025 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745939891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sCgFkAYFmrM9QA75PsFCX6E6U5VRPrXMVkvvggB1VQ8=;
	b=KPxrWtpqUn1s+1P+GQLgT8QmNy78ePciQ9yZpglsc7MEAyavH3iPZYRg/MqObKBneccwm8
	AuoOStEPPOxwxK77znNRP6FkWOxSQEbk8GigGxhYC9aPgE/1d55KCL3fZMC36TxMhs0QLI
	eVPjzlRZkt0Euw6MeEylZYEWN05hv7w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745939891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sCgFkAYFmrM9QA75PsFCX6E6U5VRPrXMVkvvggB1VQ8=;
	b=KPxrWtpqUn1s+1P+GQLgT8QmNy78ePciQ9yZpglsc7MEAyavH3iPZYRg/MqObKBneccwm8
	AuoOStEPPOxwxK77znNRP6FkWOxSQEbk8GigGxhYC9aPgE/1d55KCL3fZMC36TxMhs0QLI
	eVPjzlRZkt0Euw6MeEylZYEWN05hv7w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9FF1340C;
	Tue, 29 Apr 2025 15:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SZCUKbPtEGiDDgAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 29 Apr 2025 15:18:11 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove extent buffer's redundant `len` member field
Date: Tue, 29 Apr 2025 17:17:57 +0200
Message-ID: <20250429151800.649010-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
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
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Even super block nowadays uses nodesize for eb->len. This is since commits

551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")

With these the eb->len is not really useful anymore. Let's use the nodesize
directly where applicable.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
[RFC]
 * Shall the eb_len() helper better be called eb_nodesize()? Or even rather
   opencoded and not used at all?

 fs/btrfs/accessors.c             |  4 +--
 fs/btrfs/disk-io.c               | 11 ++++---
 fs/btrfs/extent-tree.c           | 28 +++++++++--------
 fs/btrfs/extent_io.c             | 54 ++++++++++++++------------------
 fs/btrfs/extent_io.h             | 11 +++++--
 fs/btrfs/ioctl.c                 |  2 +-
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/subpage.c               |  8 ++---
 fs/btrfs/tests/extent-io-tests.c | 12 +++----
 fs/btrfs/zoned.c                 |  2 +-
 10 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index e3716516ca387..a2bdbc7990906 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -14,10 +14,10 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 {
 	const unsigned long member_offset = (unsigned long)ptr + off;
 
-	if (unlikely(member_offset + size > eb->len)) {
+	if (unlikely(member_offset + size > eb_len(eb))) {
 		btrfs_warn(eb->fs_info,
 		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
-			(member_offset > eb->len ? "start" : "end"),
+			(member_offset > eb_len(eb) ? "start" : "end"),
 			(unsigned long)ptr, eb->start, member_offset, size);
 		return false;
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3592300ae3e2e..31eb7419fe11f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -190,7 +190,7 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 start = max_t(u64, eb->start, folio_pos(folio));
-		u64 end = min_t(u64, eb->start + eb->len,
+		u64 end = min_t(u64, eb->start + fs_info->nodesize,
 				folio_pos(folio) + eb->folio_size);
 		u32 len = end - start;
 		phys_addr_t paddr = PFN_PHYS(folio_pfn(folio)) +
@@ -230,7 +230,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 			break;
 
 		num_copies = btrfs_num_copies(fs_info,
-					      eb->start, eb->len);
+					      eb->start, fs_info->nodesize);
 		if (num_copies == 1)
 			break;
 
@@ -260,6 +260,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u32 nodesize = fs_info->nodesize;
 	u64 found_start = btrfs_header_bytenr(eb);
 	u64 last_trans;
 	u8 result[BTRFS_CSUM_SIZE];
@@ -268,7 +269,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	/* Btree blocks are always contiguous on disk. */
 	if (WARN_ON_ONCE(bbio->file_offset != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
+	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != nodesize))
 		return BLK_STS_IOERR;
 
 	/*
@@ -277,7 +278,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	 * ordering of I/O without unnecessarily writing out data.
 	 */
 	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
-		memzero_extent_buffer(eb, 0, eb->len);
+		memzero_extent_buffer(eb, 0, nodesize);
 		return BLK_STS_OK;
 	}
 
@@ -883,7 +884,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_root_generation(&root->root_item, trans->transid);
 	btrfs_set_root_level(&root->root_item, 0);
 	btrfs_set_root_refs(&root->root_item, 1);
-	btrfs_set_root_used(&root->root_item, leaf->len);
+	btrfs_set_root_used(&root->root_item, fs_info->nodesize);
 	btrfs_set_root_last_snapshot(&root->root_item, 0);
 	btrfs_set_root_dirid(&root->root_item, 0);
 	if (is_fstree(objectid))
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e0811a86d0cbd..25560a162d93e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2211,7 +2211,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	extent_op->update_flags = true;
 	extent_op->update_key = false;
 
-	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len,
+	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb_len(eb),
 					  btrfs_header_level(eb), extent_op);
 	if (ret)
 		btrfs_free_delayed_extent_op(extent_op);
@@ -2660,10 +2660,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	pin_down_extent(trans, cache, eb->start, eb->len, 0);
+	pin_down_extent(trans, cache, eb->start, eb_len(eb), 0);
 
 	/* remove us from the free space cache (if we're there at all) */
-	ret = btrfs_remove_free_space(cache, eb->start, eb->len);
+	ret = btrfs_remove_free_space(cache, eb->start, eb_len(eb));
 out:
 	btrfs_put_block_group(cache);
 	return ret;
@@ -3436,13 +3436,14 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *bg;
+	u32 nodesize = fs_info->nodesize;
 	int ret;
 
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		struct btrfs_ref generic_ref = {
 			.action = BTRFS_DROP_DELAYED_REF,
 			.bytenr = buf->start,
-			.num_bytes = buf->len,
+			.num_bytes = nodesize,
 			.parent = parent,
 			.owning_root = btrfs_header_owner(buf),
 			.ref_root = root_id,
@@ -3478,7 +3479,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	bg = btrfs_lookup_block_group(fs_info, buf->start);
 
 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-		pin_down_extent(trans, bg, buf->start, buf->len, 1);
+		pin_down_extent(trans, bg, buf->start, nodesize, 1);
 		btrfs_put_block_group(bg);
 		goto out;
 	}
@@ -3502,17 +3503,17 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 	if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
 		     || btrfs_is_zoned(fs_info)) {
-		pin_down_extent(trans, bg, buf->start, buf->len, 1);
+		pin_down_extent(trans, bg, buf->start, nodesize, 1);
 		btrfs_put_block_group(bg);
 		goto out;
 	}
 
 	WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
 
-	btrfs_add_free_space(bg, buf->start, buf->len);
-	btrfs_free_reserved_bytes(bg, buf->len, 0);
+	btrfs_add_free_space(bg, buf->start, nodesize);
+	btrfs_free_reserved_bytes(bg, nodesize, 0);
 	btrfs_put_block_group(bg);
-	trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
+	trace_btrfs_reserved_extent_free(fs_info, buf->start, nodesize);
 
 out:
 	return 0;
@@ -4768,7 +4769,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
-	ret = pin_down_extent(trans, cache, eb->start, eb->len, 1);
+	ret = pin_down_extent(trans, cache, eb->start, eb_len(eb), 1);
 	btrfs_put_block_group(cache);
 	return ret;
 }
@@ -5050,6 +5051,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *buf;
 	u64 lockdep_owner = owner;
+	u32 nodesize = fs_info->nodesize;
 
 	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner, level);
 	if (IS_ERR(buf))
@@ -5107,16 +5109,16 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 */
 		if (buf->log_index == 0)
 			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
-					     buf->start + buf->len - 1,
+					     buf->start + nodesize - 1,
 					     EXTENT_DIRTY, NULL);
 		else
 			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
-					     buf->start + buf->len - 1,
+					     buf->start + nodesize - 1,
 					     EXTENT_NEW, NULL);
 	} else {
 		buf->log_index = -1;
 		btrfs_set_extent_bit(&trans->transaction->dirty_pages, buf->start,
-				     buf->start + buf->len - 1, EXTENT_DIRTY, NULL);
+				     buf->start + nodesize - 1, EXTENT_DIRTY, NULL);
 	}
 	/* this returns a buffer locked for blocking */
 	return buf;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 20cdddd924852..e4050fd5db285 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -76,8 +76,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		eb = list_first_entry(&fs_info->allocated_ebs,
 				      struct extent_buffer, leak_list);
 		pr_err(
-	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
+	"BTRFS: buffer leak start %llu refs %d bflags %lu owner %llu\n",
+		       eb->start, atomic_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
 		WARN_ON_ONCE(1);
@@ -1746,8 +1746,8 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 
 		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
 		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-					 -eb->len,
-					 fs_info->dirty_metadata_batch);
+					 -fs_info->nodesize,
+					  fs_info->dirty_metadata_batch);
 		ret = true;
 	} else {
 		spin_unlock(&eb->refs_lock);
@@ -1953,7 +1953,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
 	rcu_read_lock();
 	while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
 		if (!eb_batch_add(batch, eb)) {
-			*start = (eb->start + eb->len) >> fs_info->sectorsize_bits;
+			*start = (eb->start + fs_info->nodesize) >> fs_info->sectorsize_bits;
 			goto out;
 		}
 	}
@@ -2020,7 +2020,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	nritems = btrfs_header_nritems(eb);
 	if (btrfs_header_level(eb) > 0) {
 		end = btrfs_node_key_ptr_offset(eb, nritems);
-		memzero_extent_buffer(eb, end, eb->len - end);
+		memzero_extent_buffer(eb, end, eb_len(eb) - end);
 	} else {
 		/*
 		 * Leaf:
@@ -2056,7 +2056,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
 		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
-				      eb->start + eb->len) - range_start;
+				      eb->start + fs_info->nodesize) - range_start;
 
 		folio_lock(folio);
 		btrfs_meta_folio_clear_dirty(folio, eb);
@@ -2171,7 +2171,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (ctx.zoned_bg) {
 				/* Mark the last eb in the block group. */
 				btrfs_schedule_zone_finish_bg(ctx.zoned_bg, eb);
-				ctx.zoned_bg->meta_write_pointer += eb->len;
+				ctx.zoned_bg->meta_write_pointer += fs_info->nodesize;
 			}
 			write_one_eb(eb, wbc);
 		}
@@ -2807,7 +2807,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 
 	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
 	eb->start = start;
-	eb->len = fs_info->nodesize;
 	eb->fs_info = fs_info;
 	init_rwsem(&eb->lock);
 
@@ -2816,8 +2815,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
 
-	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
-
 	return eb;
 }
 
@@ -3505,7 +3502,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 		return;
 
 	buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
-	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
+	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -fs_info->nodesize,
 				 fs_info->dirty_metadata_batch);
 
 	for (int i = 0; i < num_extent_folios(eb); i++) {
@@ -3557,8 +3554,8 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-					 eb->len,
-					 eb->fs_info->dirty_metadata_batch);
+					  eb_len(eb),
+					  eb->fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
 	for (int i = 0; i < num_extent_folios(eb); i++)
@@ -3670,7 +3667,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
 		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
-				      eb->start + eb->len) - range_start;
+				      eb->start + eb_len(eb)) - range_start;
 
 		bio_add_folio_nofail(&bbio->bio, folio, range_len,
 				     offset_in_folio(folio, range_start));
@@ -3698,8 +3695,8 @@ static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
 			    unsigned long len)
 {
 	btrfs_warn(eb->fs_info,
-		"access to eb bytenr %llu len %u out of range start %lu len %lu",
-		eb->start, eb->len, start, len);
+		"access to eb bytenr %llu out of range start %lu len %lu",
+		eb->start, start, len);
 	DEBUG_WARN();
 
 	return true;
@@ -3717,8 +3714,8 @@ static inline int check_eb_range(const struct extent_buffer *eb,
 {
 	unsigned long offset;
 
-	/* start, start + len should not go beyond eb->len nor overflow */
-	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
+	/* start, start + len should not go beyond nodesize nor overflow */
+	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb_len(eb)))
 		return report_eb_range(eb, start, len);
 
 	return false;
@@ -3774,8 +3771,8 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	unsigned long i = get_eb_folio_index(eb, start);
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(start > eb_len(eb));
+	WARN_ON(start + len > eb->start + eb_len(eb));
 
 	if (eb->addr) {
 		if (copy_to_user_nofault(dstv, eb->addr + start, len))
@@ -3866,8 +3863,8 @@ static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
 		folio = eb->folios[0];
 		ASSERT(i == 0);
 		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, folio,
-							 eb->start, eb->len)))
-			btrfs_subpage_dump_bitmap(fs_info, folio, eb->start, eb->len);
+							 eb->start, fs_info->nodesize)))
+			btrfs_subpage_dump_bitmap(fs_info, folio, eb->start, fs_info->nodesize);
 	} else {
 		WARN_ON(!folio_test_uptodate(folio));
 	}
@@ -3960,12 +3957,10 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 	const int unit_size = src->folio_size;
 	unsigned long cur = 0;
 
-	ASSERT(dst->len == src->len);
-
-	while (cur < src->len) {
+	while (cur < eb_len(src)) {
 		unsigned long index = get_eb_folio_index(src, cur);
 		unsigned long offset = get_eb_offset_in_folio(src, cur);
-		unsigned long cur_len = min(src->len, unit_size - offset);
+		unsigned long cur_len = min(eb_len(src), unit_size - offset);
 		void *addr = folio_address(src->folios[index]) + offset;
 
 		write_extent_buffer(dst, addr, cur, cur_len);
@@ -3980,7 +3975,6 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			unsigned long len)
 {
 	const int unit_size = dst->folio_size;
-	u64 dst_len = dst->len;
 	size_t cur;
 	size_t offset;
 	char *kaddr;
@@ -3990,8 +3984,6 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	    check_eb_range(src, src_offset, len))
 		return;
 
-	WARN_ON(src->len != dst_len);
-
 	offset = get_eb_offset_in_folio(dst, dst_offset);
 
 	while (len > 0) {
@@ -4266,7 +4258,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 			xa_unlock_irq(&fs_info->buffer_tree);
 			break;
 		}
-		cur = eb->start + eb->len;
+		cur = eb->start + fs_info->nodesize;
 
 		/*
 		 * The same as try_release_extent_buffer(), to ensure the eb
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1415679d7f88c..9a842eea47d6d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -16,6 +16,7 @@
 #include "messages.h"
 #include "ulist.h"
 #include "misc.h"
+#include "fs.h"
 
 struct page;
 struct file;
@@ -80,7 +81,6 @@ void __cold extent_buffer_free_cachep(void);
 #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
-	u32 len;
 	u32 folio_size;
 	unsigned long bflags;
 	struct btrfs_fs_info *fs_info;
@@ -263,17 +263,22 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level);
 void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
+static inline u32 eb_len(const struct extent_buffer *eb)
+{
+	return eb->fs_info->nodesize;
+}
+
 /* Note: this can be used in for loops without caching the value in a variable. */
 static inline int __pure num_extent_pages(const struct extent_buffer *eb)
 {
 	/*
 	 * For sectorsize == PAGE_SIZE case, since nodesize is always aligned to
-	 * sectorsize, it's just eb->len >> PAGE_SHIFT.
+	 * sectorsize, it's just nodesize >> PAGE_SHIFT.
 	 *
 	 * For sectorsize < PAGE_SIZE case, we could have nodesize < PAGE_SIZE,
 	 * thus have to ensure we get at least one page.
 	 */
-	return (eb->len >> PAGE_SHIFT) ?: 1;
+	return (eb_len(eb) >> PAGE_SHIFT) ?: 1;
 }
 
 /*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 68fac77fb95d1..6be2d56d44917 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -598,7 +598,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	btrfs_set_root_generation(root_item, trans->transid);
 	btrfs_set_root_level(root_item, 0);
 	btrfs_set_root_refs(root_item, 1);
-	btrfs_set_root_used(root_item, leaf->len);
+	btrfs_set_root_used(root_item, fs_info->nodesize);
 	btrfs_set_root_last_snapshot(root_item, 0);
 
 	btrfs_set_root_generation_v2(root_item,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6287e71ebad5f..5086485a4ae21 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4352,7 +4352,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 			mark_block_processed(rc, node);
 
 		if (first_cow && level > 0)
-			rc->nodes_relocated += buf->len;
+			rc->nodes_relocated += fs_info->nodesize;
 	}
 
 	if (level == 0 && first_cow && rc->stage == UPDATE_DATA_PTRS)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index d4f0192334936..711792f32e9ce 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -631,7 +631,7 @@ void btrfs_meta_folio_set_##name(struct folio *folio, const struct extent_buffer
 		folio_set_func(folio);					\
 		return;							\
 	}								\
-	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb->len); \
+	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb_len(eb)); \
 }									\
 void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
@@ -639,13 +639,13 @@ void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buff
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
-	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb->len); \
+	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb_len(eb)); \
 }									\
 bool btrfs_meta_folio_test_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
 	if (!btrfs_meta_is_subpage(eb->fs_info))			\
 		return folio_test_func(folio);				\
-	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, eb->len); \
+	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, eb_len(eb)); \
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_uptodate,
 			 folio_test_uptodate);
@@ -765,7 +765,7 @@ bool btrfs_meta_folio_clear_and_test_dirty(struct folio *folio, const struct ext
 		return true;
 	}
 
-	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start, eb->len);
+	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start, eb_len(eb));
 	if (last) {
 		folio_clear_dirty_for_io(folio);
 		return true;
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 00da54f0164c9..657f8f1d9263e 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb)
 {
 	unsigned long i;
 
-	for (i = 0; i < eb->len * BITS_PER_BYTE; i++) {
+	for (i = 0; i < eb_len(eb) * BITS_PER_BYTE; i++) {
 		int bit, bit1;
 
 		bit = !!test_bit(i, bitmap);
@@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *name, unsigned long *bitmap,
 static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb)
 {
 	unsigned long i, j;
-	unsigned long byte_len = eb->len;
+	unsigned long byte_len = eb_len(eb);
 	u32 x;
 	int ret;
 
@@ -670,7 +670,7 @@ static int test_find_first_clear_extent_bit(void)
 static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
 					const char *test_name)
 {
-	for (int i = 0; i < eb->len; i++) {
+	for (int i = 0; i < eb_len(eb); i++) {
 		struct page *page = folio_page(eb->folios[i >> PAGE_SHIFT], 0);
 		void *addr = page_address(page) + offset_in_page(i);
 
@@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
 static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
 				const char *test_name)
 {
-	for (int i = 0; i < (eb->len >> PAGE_SHIFT); i++) {
+	for (int i = 0; i < (eb_len(eb) >> PAGE_SHIFT); i++) {
 		void *eb_addr = folio_address(eb->folios[i]);
 
 		if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE) != 0) {
@@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
  */
 static void init_eb_and_memory(struct extent_buffer *eb, void *memory)
 {
-	get_random_bytes(memory, eb->len);
-	write_extent_buffer(eb, memory, 0, eb->len);
+	get_random_bytes(memory, eb_len(eb));
+	write_extent_buffer(eb, memory, 0, eb_len(eb));
 }
 
 static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9d42bf2bfd746..c7a8cdd87c509 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2422,7 +2422,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb)
 {
 	if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtime_flags) ||
-	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
+	    eb->start + eb_len(eb) * 2 <= bg->start + bg->zone_capacity)
 		return;
 
 	if (WARN_ON(bg->zone_finish_work.func == btrfs_zone_finish_endio_workfn)) {
-- 
2.47.2


