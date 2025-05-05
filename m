Return-Path: <linux-btrfs+bounces-13652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05936AA924E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E964A174B20
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084420408A;
	Mon,  5 May 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ut67B9f6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ihoFe+8t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F205AA3
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445877; cv=none; b=Jyf9hAfJiDyzVFp5pQx3jqKiIKDF2tbNN+t1q9NxFCMJfPyGb2pdIDaAzQMo38HapgEHwm0CtWQEZvpSoMXyTZtzY5RrgkcbGMI8X2o3OjzAaill+tmynBybzZ7NOTP9vhSYgBJ2gEhAv1wb1KxE66fv2/n71MyhWz8il0XjMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445877; c=relaxed/simple;
	bh=iQmBWpF8hCkMdaJUu3CilFaYLGpufC8Y/HmD3CCb8jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtBnY4X+M0kG5y6HYQusL9n3e9IFcQfoXdDTTkYnd6pg+wwhIVdb9TR6Umxyqg8Ofp+2UOZlFu3beC4o5O0n0VDs+d2t8V01lV8h8eRFkzPQejpPfny470n505gE0LM+vkb+f/ML+LsIYDc3QQiMKJD4TJaWSkqLBHbkHksusog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ut67B9f6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ihoFe+8t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C990E21185;
	Mon,  5 May 2025 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746445872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otjNLpEebAlEdkdWJfWGNxXVBJNDmGv2/pxEIfEbXfs=;
	b=Ut67B9f6b7teiGHzHX5uJp/aAdxVXNd2l5eoZCzLsI1rMdQgq7mYDgs4+NSciRnazfZxB3
	tWrDZT4dD31US2WDg3QmdVX/gC9m7P0V2p4fhdhCs2nGpxum5XA45795NAHi9sYiAhHwjg
	lNdVLq8z4/te9OS7//2zQZi2HUeGsFA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ihoFe+8t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746445871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otjNLpEebAlEdkdWJfWGNxXVBJNDmGv2/pxEIfEbXfs=;
	b=ihoFe+8tshjJy26tpSFJkfM2+WmmlWNEgVCas+KpJMqZlPZHOXfIuoGUtLwpT4uexszI5a
	oauY+G94WHQEpcPY96eZQCvlR0UA7F9/9xpLPmnGOmNpSrVpHJUwmzC4V38+b/Wj3hTquq
	SGySlCApnX3V5/iHuEKxdepxrHH9xfM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B05D913883;
	Mon,  5 May 2025 11:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CM97Ki+mGGj3FgAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 05 May 2025 11:51:11 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: remove extent buffer's redundant `len` member field
Date: Mon,  5 May 2025 13:50:54 +0200
Message-ID: <20250505115056.1803847-2-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505115056.1803847-1-neelx@suse.com>
References: <20250502133725.1210587-2-neelx@suse.com>
 <20250505115056.1803847-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C990E21185
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Even super block nowadays uses nodesize for eb->len. This is since commits

551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")

With these the eb->len is not really useful anymore. Let's use the nodesize
directly where applicable.

Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---

v3 changes:
 - use local variable nodesize directly in btree_csum_one_bio(), spotted by Boris
 - include nodesize in the warning logged by report_eb_range(), suggested by Boris

v2 changes:
 - https://lore.kernel.org/linux-btrfs/20250502133725.1210587-2-neelx@suse.com/
 - rebased to this week's for-next
 - use plain eb->fs_info->nodesize instead of a helper function as suggested
   by Filipe and Wenruo
 - constify local nodesize variables as suggested by Wenruo

v1: https://lore.kernel.org/linux-btrfs/20250429151800.649010-1-neelx@suse.com/

---
 fs/btrfs/accessors.c             |  4 +--
 fs/btrfs/disk-io.c               | 11 +++---
 fs/btrfs/extent-tree.c           | 28 ++++++++-------
 fs/btrfs/extent_io.c             | 59 ++++++++++++++------------------
 fs/btrfs/extent_io.h             |  6 ++--
 fs/btrfs/ioctl.c                 |  2 +-
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/subpage.c               | 12 ++++---
 fs/btrfs/tests/extent-io-tests.c | 12 +++----
 fs/btrfs/zoned.c                 |  2 +-
 10 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index e3716516ca387..6839251b09a18 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -14,10 +14,10 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 {
 	const unsigned long member_offset = (unsigned long)ptr + off;
 
-	if (unlikely(member_offset + size > eb->len)) {
+	if (unlikely(member_offset + size > eb->fs_info->nodesize)) {
 		btrfs_warn(eb->fs_info,
 		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
-			(member_offset > eb->len ? "start" : "end"),
+			(member_offset > eb->fs_info->nodesize ? "start" : "end"),
 			(unsigned long)ptr, eb->start, member_offset, size);
 		return false;
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5bcf11246ba66..2f819446cef1c 100644
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
 
@@ -260,6 +260,7 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	const u32 nodesize = fs_info->nodesize;
 	u64 found_start = btrfs_header_bytenr(eb);
 	u64 last_trans;
 	u8 result[BTRFS_CSUM_SIZE];
@@ -268,7 +269,7 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
 	/* Btree blocks are always contiguous on disk. */
 	if (WARN_ON_ONCE(bbio->file_offset != eb->start))
 		return -EIO;
-	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
+	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != nodesize))
 		return -EIO;
 
 	/*
@@ -277,7 +278,7 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
 	 * ordering of I/O without unnecessarily writing out data.
 	 */
 	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
-		memzero_extent_buffer(eb, 0, eb->len);
+		memzero_extent_buffer(eb, 0, nodesize);
 		return 0;
 	}
 
@@ -881,7 +882,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_root_generation(&root->root_item, trans->transid);
 	btrfs_set_root_level(&root->root_item, 0);
 	btrfs_set_root_refs(&root->root_item, 1);
-	btrfs_set_root_used(&root->root_item, leaf->len);
+	btrfs_set_root_used(&root->root_item, fs_info->nodesize);
 	btrfs_set_root_last_snapshot(&root->root_item, 0);
 	btrfs_set_root_dirid(&root->root_item, 0);
 	if (is_fstree(objectid))
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 64e8c653ae8f3..e1cce5b011993 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2186,7 +2186,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	extent_op->update_flags = true;
 	extent_op->update_key = false;
 
-	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len,
+	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->fs_info->nodesize,
 					  btrfs_header_level(eb), extent_op);
 	if (ret)
 		btrfs_free_delayed_extent_op(extent_op);
@@ -2635,10 +2635,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	pin_down_extent(trans, cache, eb->start, eb->len, 0);
+	pin_down_extent(trans, cache, eb->start, eb->fs_info->nodesize, 0);
 
 	/* remove us from the free space cache (if we're there at all) */
-	ret = btrfs_remove_free_space(cache, eb->start, eb->len);
+	ret = btrfs_remove_free_space(cache, eb->start, eb->fs_info->nodesize);
 out:
 	btrfs_put_block_group(cache);
 	return ret;
@@ -3434,13 +3434,14 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *bg;
+	const u32 nodesize = fs_info->nodesize;
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
@@ -3476,7 +3477,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	bg = btrfs_lookup_block_group(fs_info, buf->start);
 
 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-		pin_down_extent(trans, bg, buf->start, buf->len, 1);
+		pin_down_extent(trans, bg, buf->start, nodesize, 1);
 		btrfs_put_block_group(bg);
 		goto out;
 	}
@@ -3500,17 +3501,17 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
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
@@ -4766,7 +4767,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
-	ret = pin_down_extent(trans, cache, eb->start, eb->len, 1);
+	ret = pin_down_extent(trans, cache, eb->start, eb->fs_info->nodesize, 1);
 	btrfs_put_block_group(cache);
 	return ret;
 }
@@ -5048,6 +5049,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *buf;
 	u64 lockdep_owner = owner;
+	const u32 nodesize = fs_info->nodesize;
 
 	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner, level);
 	if (IS_ERR(buf))
@@ -5105,16 +5107,16 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
index fa757f3da64fa..0df5534a834ad 100644
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
@@ -1788,8 +1788,8 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 
 		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
 		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-					 -eb->len,
-					 fs_info->dirty_metadata_batch);
+					 -fs_info->nodesize,
+					  fs_info->dirty_metadata_batch);
 		ret = true;
 	} else {
 		spin_unlock(&eb->refs_lock);
@@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
 	rcu_read_lock();
 	while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
 		if (!eb_batch_add(batch, eb)) {
-			*start = (eb->start + eb->len) >> fs_info->sectorsize_bits;
+			*start = (eb->start + fs_info->nodesize) >> fs_info->sectorsize_bits;
 			goto out;
 		}
 	}
@@ -2050,7 +2050,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	nritems = btrfs_header_nritems(eb);
 	if (btrfs_header_level(eb) > 0) {
 		end = btrfs_node_key_ptr_offset(eb, nritems);
-		memzero_extent_buffer(eb, end, eb->len - end);
+		memzero_extent_buffer(eb, end, eb->fs_info->nodesize - end);
 	} else {
 		/*
 		 * Leaf:
@@ -2086,7 +2086,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
 		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
-				      eb->start + eb->len) - range_start;
+				      eb->start + fs_info->nodesize) - range_start;
 
 		folio_lock(folio);
 		btrfs_meta_folio_clear_dirty(folio, eb);
@@ -2200,7 +2200,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (ctx.zoned_bg) {
 				/* Mark the last eb in the block group. */
 				btrfs_schedule_zone_finish_bg(ctx.zoned_bg, eb);
-				ctx.zoned_bg->meta_write_pointer += eb->len;
+				ctx.zoned_bg->meta_write_pointer += fs_info->nodesize;
 			}
 			write_one_eb(eb, wbc);
 		}
@@ -2836,7 +2836,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 
 	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
 	eb->start = start;
-	eb->len = fs_info->nodesize;
 	eb->fs_info = fs_info;
 	init_rwsem(&eb->lock);
 
@@ -2845,8 +2844,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
 
-	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
-
 	return eb;
 }
 
@@ -3558,7 +3555,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 		return;
 
 	buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
-	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
+	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -fs_info->nodesize,
 				 fs_info->dirty_metadata_batch);
 
 	for (int i = 0; i < num_extent_folios(eb); i++) {
@@ -3589,7 +3586,8 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
 	if (!was_dirty) {
-		bool subpage = btrfs_meta_is_subpage(eb->fs_info);
+		struct btrfs_fs_info *fs_info = eb->fs_info;
+		bool subpage = btrfs_meta_is_subpage(fs_info);
 
 		/*
 		 * For subpage case, we can have other extent buffers in the
@@ -3609,9 +3607,9 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		buffer_tree_set_mark(eb, PAGECACHE_TAG_DIRTY);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
-		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-					 eb->len,
-					 eb->fs_info->dirty_metadata_batch);
+		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
+					  fs_info->nodesize,
+					  fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
 	for (int i = 0; i < num_extent_folios(eb); i++)
@@ -3723,7 +3721,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
 		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
-				      eb->start + eb->len) - range_start;
+				      eb->start + eb->fs_info->nodesize) - range_start;
 
 		bio_add_folio_nofail(&bbio->bio, folio, range_len,
 				     offset_in_folio(folio, range_start));
@@ -3751,8 +3749,8 @@ static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
 			    unsigned long len)
 {
 	btrfs_warn(eb->fs_info,
-		"access to eb bytenr %llu len %u out of range start %lu len %lu",
-		eb->start, eb->len, start, len);
+		"access to eb bytenr %llu nodesize %u out of range start %lu len %lu",
+		eb->start, eb->fs_info->nodesize, start, len);
 	DEBUG_WARN();
 
 	return true;
@@ -3770,8 +3768,8 @@ static inline int check_eb_range(const struct extent_buffer *eb,
 {
 	unsigned long offset;
 
-	/* start, start + len should not go beyond eb->len nor overflow */
-	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
+	/* start, start + len should not go beyond nodesize nor overflow */
+	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->fs_info->nodesize))
 		return report_eb_range(eb, start, len);
 
 	return false;
@@ -3827,8 +3825,8 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	unsigned long i = get_eb_folio_index(eb, start);
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(start > eb->fs_info->nodesize);
+	WARN_ON(start + len > eb->start + eb->fs_info->nodesize);
 
 	if (eb->addr) {
 		if (copy_to_user_nofault(dstv, eb->addr + start, len))
@@ -3919,8 +3917,8 @@ static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
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
@@ -4013,12 +4011,10 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 	const int unit_size = src->folio_size;
 	unsigned long cur = 0;
 
-	ASSERT(dst->len == src->len);
-
-	while (cur < src->len) {
+	while (cur < src->fs_info->nodesize) {
 		unsigned long index = get_eb_folio_index(src, cur);
 		unsigned long offset = get_eb_offset_in_folio(src, cur);
-		unsigned long cur_len = min(src->len, unit_size - offset);
+		unsigned long cur_len = min(src->fs_info->nodesize, unit_size - offset);
 		void *addr = folio_address(src->folios[index]) + offset;
 
 		write_extent_buffer(dst, addr, cur, cur_len);
@@ -4033,7 +4029,6 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			unsigned long len)
 {
 	const int unit_size = dst->folio_size;
-	u64 dst_len = dst->len;
 	size_t cur;
 	size_t offset;
 	char *kaddr;
@@ -4043,8 +4038,6 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	    check_eb_range(src, src_offset, len))
 		return;
 
-	WARN_ON(src->len != dst_len);
-
 	offset = get_eb_offset_in_folio(dst, dst_offset);
 
 	while (len > 0) {
@@ -4315,7 +4308,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 			xa_unlock_irq(&fs_info->buffer_tree);
 			break;
 		}
-		cur = eb->start + eb->len;
+		cur = eb->start + fs_info->nodesize;
 
 		/*
 		 * The same as try_release_extent_buffer(), to ensure the eb
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e36e8d6a00bc5..7a8451c11630a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -16,6 +16,7 @@
 #include "messages.h"
 #include "ulist.h"
 #include "misc.h"
+#include "fs.h"
 
 struct page;
 struct file;
@@ -86,7 +87,6 @@ void __cold extent_buffer_free_cachep(void);
 #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
-	u32 len;
 	u32 folio_size;
 	unsigned long bflags;
 	struct btrfs_fs_info *fs_info;
@@ -274,12 +274,12 @@ static inline int __pure num_extent_pages(const struct extent_buffer *eb)
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
+	return (eb->fs_info->nodesize >> PAGE_SHIFT) ?: 1;
 }
 
 /*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a498fe524c907..d06008ff63de9 100644
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
index 02086191630d0..fb194790406ff 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4353,7 +4353,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 			mark_block_processed(rc, node);
 
 		if (first_cow && level > 0)
-			rc->nodes_relocated += buf->len;
+			rc->nodes_relocated += fs_info->nodesize;
 	}
 
 	if (level == 0 && first_cow && rc->stage == UPDATE_DATA_PTRS)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index d4f0192334936..64c212f76ff12 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -631,7 +631,8 @@ void btrfs_meta_folio_set_##name(struct folio *folio, const struct extent_buffer
 		folio_set_func(folio);					\
 		return;							\
 	}								\
-	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb->len); \
+	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start,		\
+				 eb->fs_info->nodesize);		\
 }									\
 void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
@@ -639,13 +640,15 @@ void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buff
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
-	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb->len); \
+	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start,	\
+				   eb->fs_info->nodesize);		\
 }									\
 bool btrfs_meta_folio_test_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
 	if (!btrfs_meta_is_subpage(eb->fs_info))			\
 		return folio_test_func(folio);				\
-	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, eb->len); \
+	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start,	\
+					 eb->fs_info->nodesize);	\
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_uptodate,
 			 folio_test_uptodate);
@@ -765,7 +768,8 @@ bool btrfs_meta_folio_clear_and_test_dirty(struct folio *folio, const struct ext
 		return true;
 	}
 
-	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start, eb->len);
+	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start,
+						  eb->fs_info->nodesize);
 	if (last) {
 		folio_clear_dirty_for_io(folio);
 		return true;
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 00da54f0164c9..697d558808103 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb)
 {
 	unsigned long i;
 
-	for (i = 0; i < eb->len * BITS_PER_BYTE; i++) {
+	for (i = 0; i < eb->fs_info->nodesize * BITS_PER_BYTE; i++) {
 		int bit, bit1;
 
 		bit = !!test_bit(i, bitmap);
@@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *name, unsigned long *bitmap,
 static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb)
 {
 	unsigned long i, j;
-	unsigned long byte_len = eb->len;
+	unsigned long byte_len = eb->fs_info->nodesize;
 	u32 x;
 	int ret;
 
@@ -670,7 +670,7 @@ static int test_find_first_clear_extent_bit(void)
 static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
 					const char *test_name)
 {
-	for (int i = 0; i < eb->len; i++) {
+	for (int i = 0; i < eb->fs_info->nodesize; i++) {
 		struct page *page = folio_page(eb->folios[i >> PAGE_SHIFT], 0);
 		void *addr = page_address(page) + offset_in_page(i);
 
@@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
 static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
 				const char *test_name)
 {
-	for (int i = 0; i < (eb->len >> PAGE_SHIFT); i++) {
+	for (int i = 0; i < (eb->fs_info->nodesize >> PAGE_SHIFT); i++) {
 		void *eb_addr = folio_address(eb->folios[i]);
 
 		if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE) != 0) {
@@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
  */
 static void init_eb_and_memory(struct extent_buffer *eb, void *memory)
 {
-	get_random_bytes(memory, eb->len);
-	write_extent_buffer(eb, memory, 0, eb->len);
+	get_random_bytes(memory, eb->fs_info->nodesize);
+	write_extent_buffer(eb, memory, 0, eb->fs_info->nodesize);
 }
 
 static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 271c958909cd8..0b87f2e2ee75e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2416,7 +2416,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb)
 {
 	if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtime_flags) ||
-	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
+	    eb->start + eb->fs_info->nodesize * 2 <= bg->start + bg->zone_capacity)
 		return;
 
 	if (WARN_ON(bg->zone_finish_work.func == btrfs_zone_finish_endio_workfn)) {
-- 
2.47.2


