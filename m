Return-Path: <linux-btrfs+bounces-10528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406539F61F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5407D1621AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED33193079;
	Wed, 18 Dec 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kgUYSfA/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kgUYSfA/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919D1917D9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514919; cv=none; b=ckImjukyj7vpe+dLv88L6hNWqUwenNKATAzhLq2ebtp7imasByzE5qJmiGMawuM+TaM/w9WTmD8WSlYBifcfkC5wQhscdkNsHJq+jbTxVHJvEQp8sSGSg4Cqoq3XqgISTQroZoCUF7E8irXL3zspQLMJhRd9//2FJE8YeUk3hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514919; c=relaxed/simple;
	bh=vkG0nn1CstCwXRZgpm4Z9EHe2TPCY3iUnJKsDSg8hPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaTLvz3fxGzqUe615ciacbm8RvnhtOrIQv/iP1xhMO3L4KQjF2GbxjvgstDReEGYMKBBniyeV7FBV/NQhlbYaxYrCkItsX67gaD15DJcV2/G3mNrCLN6ydXE6gAZ9A5D1rynVtZuXpBuplNO2q/ubp7YLOwsu2qdUg8NZayXOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kgUYSfA/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kgUYSfA/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F09E1F399
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRpvH1sIcMBlT22vtr7fNqIp36ztQVUa4efCdaxTmio=;
	b=kgUYSfA/BsXpW41XJt18w/0wtE5CuaFdEeqZ3RYdNgO4Bss61b9xi7itbBUJTpMRnuQVHJ
	oBttLBzbF9oqGAtdyNiFyPNCW+3aC48nyMxgCx01ZiGKs1BCvT+NAQr+Skcr8l4x36uiZk
	lDZ3DOaaRgDLVJQOTOfALWw3rImUdLI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRpvH1sIcMBlT22vtr7fNqIp36ztQVUa4efCdaxTmio=;
	b=kgUYSfA/BsXpW41XJt18w/0wtE5CuaFdEeqZ3RYdNgO4Bss61b9xi7itbBUJTpMRnuQVHJ
	oBttLBzbF9oqGAtdyNiFyPNCW+3aC48nyMxgCx01ZiGKs1BCvT+NAQr+Skcr8l4x36uiZk
	lDZ3DOaaRgDLVJQOTOfALWw3rImUdLI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B196E132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SICUG+GYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/18] btrfs: rename btrfs_fs_info::sectorsize to blocksize for disk-io.c
Date: Wed, 18 Dec 2024 20:11:17 +1030
Message-ID: <7d28eec4349d9b4ec5d7097e5194418a9cb16883.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

All other file systems use the terminology "block size" for the minimum
data block size, but due to historical reasons we use "sector size" for
btrfs from day 1.

Furthermore the kernel has its own sector size, fixed to 512 as the
minimal supported block IO size.

This can cause confusion when talking with other MM/FS people.

So here we rename btrfs_fs_info::sectorsize to blocksize.
But there are over 800 such usages across btrfs already, to make the
transaction more smooth, for now @sectorsize and @blocksize are inside
an anonymous union, so that both name can be utilized until we finish
the full transaction.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 82 +++++++++++++++++++++++-----------------------
 fs/btrfs/fs.h      | 25 +++++++++-----
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eff0dd1ae62f..d3d2c9e2356a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -555,7 +555,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 	int cur_bit = 0;
 	u64 page_start = folio_pos(folio);
 
-	if (fs_info->sectorsize == PAGE_SIZE) {
+	if (fs_info->blocksize == PAGE_SIZE) {
 		eb = folio_get_private(folio);
 		BUG_ON(!eb);
 		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
@@ -579,7 +579,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 			continue;
 		}
 		spin_unlock_irqrestore(&subpage->lock, flags);
-		cur = page_start + cur_bit * fs_info->sectorsize;
+		cur = page_start + cur_bit * fs_info->blocksize;
 
 		eb = find_extent_buffer(fs_info, cur);
 		ASSERT(eb);
@@ -588,7 +588,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		btrfs_assert_tree_write_locked(eb);
 		free_extent_buffer(eb);
 
-		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits) - 1;
+		cur_bit += (fs_info->nodesize >> fs_info->blocksize_bits) - 1;
 	}
 	return filemap_dirty_folio(mapping, folio);
 }
@@ -738,7 +738,7 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info)
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 
-	/* We don't use the stripesize in selftest, set it as sectorsize */
+	/* We don't use the stripesize in selftest, set it as blocksize */
 	root->alloc_bytenr = 0;
 
 	return root;
@@ -2341,7 +2341,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num)
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
-	u64 sectorsize = btrfs_super_sectorsize(sb);
+	u64 blocksize = btrfs_super_sectorsize(sb);
 	int ret = 0;
 	const bool ignore_flags = btrfs_test_opt(fs_info, IGNORESUPERFLAGS);
 
@@ -2378,31 +2378,31 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	}
 
 	/*
-	 * Check sectorsize and nodesize first, other check will need it.
-	 * Check all possible sectorsize(4K, 8K, 16K, 32K, 64K) here.
+	 * Check blocksize and nodesize first, other check will need it.
+	 * Check all possible blocksize(4K, 8K, 16K, 32K, 64K) here.
 	 */
-	if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
-	    sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {
-		btrfs_err(fs_info, "invalid sectorsize %llu", sectorsize);
+	if (!is_power_of_2(blocksize) || blocksize < 4096 ||
+	    blocksize > BTRFS_MAX_METADATA_BLOCKSIZE) {
+		btrfs_err(fs_info, "invalid blocksize %llu", blocksize);
 		ret = -EINVAL;
 	}
 
 	/*
-	 * We only support at most two sectorsizes: 4K and PAGE_SIZE.
+	 * We only support at most two blocksizes: 4K and PAGE_SIZE.
 	 *
-	 * We can support 16K sectorsize with 64K page size without problem,
-	 * but such sectorsize/pagesize combination doesn't make much sense.
+	 * We can support 16K blocksize with 64K page size without problem,
+	 * but such blocksize/pagesize combination doesn't make much sense.
 	 * 4K will be our future standard, PAGE_SIZE is supported from the very
 	 * beginning.
 	 */
-	if (sectorsize > PAGE_SIZE || (sectorsize != SZ_4K && sectorsize != PAGE_SIZE)) {
+	if (blocksize > PAGE_SIZE || (blocksize != SZ_4K && blocksize != PAGE_SIZE)) {
 		btrfs_err(fs_info,
-			"sectorsize %llu not yet supported for page size %lu",
-			sectorsize, PAGE_SIZE);
+			"blocksize %llu not yet supported for page size %lu",
+			blocksize, PAGE_SIZE);
 		ret = -EINVAL;
 	}
 
-	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
+	if (!is_power_of_2(nodesize) || nodesize < blocksize ||
 	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
 		ret = -EINVAL;
@@ -2414,17 +2414,17 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	}
 
 	/* Root alignment check */
-	if (!IS_ALIGNED(btrfs_super_root(sb), sectorsize)) {
+	if (!IS_ALIGNED(btrfs_super_root(sb), blocksize)) {
 		btrfs_warn(fs_info, "tree_root block unaligned: %llu",
 			   btrfs_super_root(sb));
 		ret = -EINVAL;
 	}
-	if (!IS_ALIGNED(btrfs_super_chunk_root(sb), sectorsize)) {
+	if (!IS_ALIGNED(btrfs_super_chunk_root(sb), blocksize)) {
 		btrfs_warn(fs_info, "chunk_root block unaligned: %llu",
 			   btrfs_super_chunk_root(sb));
 		ret = -EINVAL;
 	}
-	if (!IS_ALIGNED(btrfs_super_log_root(sb), sectorsize)) {
+	if (!IS_ALIGNED(btrfs_super_log_root(sb), blocksize)) {
 		btrfs_warn(fs_info, "log_root block unaligned: %llu",
 			   btrfs_super_log_root(sb));
 		ret = -EINVAL;
@@ -2819,8 +2819,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	/* Usable values until the real ones are cached from the superblock */
 	fs_info->nodesize = 4096;
-	fs_info->sectorsize = 4096;
-	fs_info->sectorsize_bits = ilog2(4096);
+	fs_info->blocksize = 4096;
+	fs_info->blocksize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
 	/* Default compress algorithm when user does -o compress */
@@ -3123,10 +3123,10 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 
 	/* Runtime limitation for mixed block groups. */
 	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
-	    (fs_info->sectorsize != fs_info->nodesize)) {
+	    (fs_info->blocksize != fs_info->nodesize)) {
 		btrfs_err(fs_info,
-"unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
-			fs_info->nodesize, fs_info->sectorsize);
+"unequal nodesize/blocksize (%u != %u) are not allowed for mixed block groups",
+			fs_info->nodesize, fs_info->blocksize);
 		return -EINVAL;
 	}
 
@@ -3185,10 +3185,10 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	 * we're already defaulting to v2 cache, no need to bother v1 as it's
 	 * going to be deprecated anyway.
 	 */
-	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
+	if (fs_info->blocksize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
 		btrfs_warn(fs_info,
-	"v1 space cache is not supported for page size %lu with sectorsize %u",
-			   PAGE_SIZE, fs_info->sectorsize);
+	"v1 space cache is not supported for page size %lu with blocksize %u",
+			   PAGE_SIZE, fs_info->blocksize);
 		return -EINVAL;
 	}
 
@@ -3202,7 +3202,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices)
 {
-	u32 sectorsize;
+	u32 blocksize;
 	u32 nodesize;
 	u32 stripesize;
 	u64 generation;
@@ -3310,15 +3310,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
-	sectorsize = btrfs_super_sectorsize(disk_super);
-	stripesize = sectorsize;
+	blocksize = btrfs_super_sectorsize(disk_super);
+	stripesize = blocksize;
 	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
-	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
+	fs_info->delalloc_batch = blocksize * 512 * (1 + ilog2(nr_cpu_ids));
 
 	fs_info->nodesize = nodesize;
-	fs_info->sectorsize = sectorsize;
-	fs_info->sectorsize_bits = ilog2(sectorsize);
-	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
+	fs_info->blocksize = blocksize;
+	fs_info->blocksize_bits = ilog2(blocksize);
+	fs_info->blocks_per_page = (PAGE_SIZE >> fs_info->blocksize_bits);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
@@ -3339,14 +3339,14 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	/*
 	 * At this point our mount options are validated, if we set ->max_inline
-	 * to something non-standard make sure we truncate it to sectorsize.
+	 * to something non-standard make sure we truncate it to blocksize.
 	 */
-	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
+	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->blocksize);
 
-	if (sectorsize < PAGE_SIZE)
+	if (blocksize < PAGE_SIZE)
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
-			   sectorsize, PAGE_SIZE);
+			   blocksize, PAGE_SIZE);
 
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret)
@@ -3356,8 +3356,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
 	/* Update the values for the current filesystem. */
-	sb->s_blocksize = sectorsize;
-	sb->s_blocksize_bits = blksize_bits(sectorsize);
+	sb->s_blocksize = blocksize;
+	sb->s_blocksize_bits = blksize_bits(blocksize);
 	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
 
 	mutex_lock(&fs_info->chunk_mutex);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 58e6b4b953f1..9f8324ae3800 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -179,7 +179,7 @@ enum {
 
 	/*
 	 * Indicate that we have found a tree block which is only aligned to
-	 * sectorsize, but not to nodesize.  This should be rare nowadays.
+	 * blocksize, but not to nodesize.  This should be rare nowadays.
 	 */
 	BTRFS_FS_UNALIGNED_TREE_BLOCK,
 
@@ -707,7 +707,10 @@ struct btrfs_fs_info {
 	 * running.
 	 */
 	refcount_t scrub_workers_refcnt;
-	u32 sectors_per_page;
+	union {
+		u32 sectors_per_page;
+		u32 blocks_per_page;
+	};
 	struct workqueue_struct *scrub_workers;
 
 	struct btrfs_discard_ctl discard_ctl;
@@ -762,7 +765,7 @@ struct btrfs_fs_info {
 
 	/* Extent buffer radix tree */
 	spinlock_t buffer_lock;
-	/* Entries are eb->start / sectorsize */
+	/* Entries are eb->start / blocksize */
 	struct radix_tree_root buffer_radix;
 
 	/* Next backup root to be overwritten */
@@ -794,9 +797,15 @@ struct btrfs_fs_info {
 
 	/* Cached block sizes */
 	u32 nodesize;
-	u32 sectorsize;
-	/* ilog2 of sectorsize, use to avoid 64bit division */
-	u32 sectorsize_bits;
+	union {
+		u32 sectorsize;
+		u32 blocksize;
+	};
+	/* ilog2 of blocksize, use to avoid 64bit division */
+	union {
+		u32 sectorsize_bits;
+		u32 blocksize_bits;
+	};
 	u32 csum_size;
 	u32 csums_per_leaf;
 	u32 stripesize;
@@ -931,7 +940,7 @@ static inline u64 btrfs_get_last_root_drop_gen(const struct btrfs_fs_info *fs_in
 static inline u64 btrfs_csum_bytes_to_leaves(
 			const struct btrfs_fs_info *fs_info, u64 csum_bytes)
 {
-	const u64 num_csums = csum_bytes >> fs_info->sectorsize_bits;
+	const u64 num_csums = csum_bytes >> fs_info->blocksize_bits;
 
 	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
 }
@@ -959,7 +968,7 @@ static inline u64 btrfs_calc_metadata_size(const struct btrfs_fs_info *fs_info,
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
 
-#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) ((bytes) >> (fs_info)->sectorsize_bits)
+#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) ((bytes) >> (fs_info)->blocksize_bits)
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
-- 
2.47.1


