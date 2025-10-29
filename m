Return-Path: <linux-btrfs+bounces-18388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D10C184F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB54E55E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3D30C636;
	Wed, 29 Oct 2025 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jkaObh6U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jkaObh6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282F30B52B
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716092; cv=none; b=uOs4uNMWUd2vjnSsZuTO7XTucu4Plrghhmtiw+YaxuWTpEuY1fbkKvwnEFQ+WIokgiRirELt9UMW5Defc6qbHbOXCDfJS5eMZCYMeDWkwwFBB8i4BdWbgMOLDuMnxfcyw2YC5jJI152nzycBPd+jufmwbOmewaix4bOW9tRhoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716092; c=relaxed/simple;
	bh=5IE/rvlvskgQO7xq3FtlWTVi5Ts3GmL5mz1BS3mw5Is=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pezRUW7ze7X8353KB2vJrGDYzBnPCR7a5HyoX/YvLO76cXXH14UwHHMNLEmbmX6N7rRYao/y7qpctEvLD96ehHEbcy8KPZxEf7kazCFQzcMnKPbG+hBhZAK/Yh9rR0M4ghVXMCjE1yA15/Bw8TsKPo08nOFpLj9exFTjG1kGATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jkaObh6U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jkaObh6U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F3AA1FD91
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+PUzZYTV7Btb2oGpan16tNUDzyy9DlIs3Ddq/iuHzw=;
	b=jkaObh6UjRcoIeK1fs0MAWOQo+Tbq+grIt23IGKtRgvtmJyPOdaC+JZb+/6KJmlFoRdR6i
	XgYWNVEUPtUO0iI49UMNg6WWCRsMgIYhUiLd4cDy2wLvNEqrUAo8BW1wgehrM3oxMeDrFq
	nVVbe2a00obZjVtgI0C47l0qhwoQBsQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+PUzZYTV7Btb2oGpan16tNUDzyy9DlIs3Ddq/iuHzw=;
	b=jkaObh6UjRcoIeK1fs0MAWOQo+Tbq+grIt23IGKtRgvtmJyPOdaC+JZb+/6KJmlFoRdR6i
	XgYWNVEUPtUO0iI49UMNg6WWCRsMgIYhUiLd4cDy2wLvNEqrUAo8BW1wgehrM3oxMeDrFq
	nVVbe2a00obZjVtgI0C47l0qhwoQBsQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6449E13886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eAGCCW+nAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/7] btrfs: remove btrfs_bio::fs_info by extracting it from btrfs_bio::inode
Date: Wed, 29 Oct 2025 16:04:13 +1030
Message-ID: <a4679554867589ffdd4169f79797c7aa833e4c00.1761715650.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761715649.git.wqu@suse.com>
References: <cover.1761715649.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Currently there is only one caller which doesn't populate
btrfs_bio::inode, and that's scrub.

The idea is scrub doesn't want any automatic csum verification nor
read-repair, as everything will be handled by scrub itself.

However that behavior is really no different than metadata inode, thus
we can reuse btree_inode as btrfs_bio::inode for scrub.

The only exception is in btrfs_submit_chunk() where if a bbio is from
scrub or data reloc inode, we set rst_search_commit_root to true.
This means we still need a way to distinguish scrub from metadata, but
that can be done by a new flag inside btrfs_bio.

Now btrfs_bio::inode is a mandatory parameter, we can extract fs_info
from that inode thus can remove btrfs_bio::fs_info to save 8 bytes from
btrfs_bio structure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         | 51 ++++++++++++++++++++++--------------------
 fs/btrfs/bio.h         | 18 ++++++++++-----
 fs/btrfs/compression.c |  6 ++---
 fs/btrfs/compression.h |  3 ++-
 fs/btrfs/direct-io.c   |  4 +---
 fs/btrfs/extent_io.c   | 22 ++++++++----------
 fs/btrfs/inode.c       |  7 ++----
 fs/btrfs/scrub.c       | 49 ++++++++++++++++++++++------------------
 fs/btrfs/zoned.c       |  4 ++--
 9 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa..6028d8f0c8fc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -41,13 +41,17 @@ static bool bbio_has_ordered_extent(const struct btrfs_bio *bbio)
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
  */
-void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
+void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode, u64 file_offset,
 		    btrfs_bio_end_io_t end_io, void *private)
 {
+	/* @inode parameter is mandatory. */
+	ASSERT(inode);
+
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
-	bbio->fs_info = fs_info;
+	bbio->inode = inode;
 	bbio->end_io = end_io;
 	bbio->private = private;
+	bbio->file_offset = file_offset;
 	atomic_set(&bbio->pending_ios, 1);
 	WRITE_ONCE(bbio->status, BLK_STS_OK);
 }
@@ -60,7 +64,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
  * a mempool.
  */
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-				  struct btrfs_fs_info *fs_info,
+				  struct btrfs_inode *inode, u64 file_offset,
 				  btrfs_bio_end_io_t end_io, void *private)
 {
 	struct btrfs_bio *bbio;
@@ -68,7 +72,7 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 
 	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, fs_info, end_io, private);
+	btrfs_bio_init(bbio, inode, file_offset, end_io, private);
 	return bbio;
 }
 
@@ -85,9 +89,7 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 		return ERR_CAST(bio);
 
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
-	bbio->inode = orig_bbio->inode;
-	bbio->file_offset = orig_bbio->file_offset;
+	btrfs_bio_init(bbio, orig_bbio->inode, orig_bbio->file_offset, NULL, orig_bbio);
 	orig_bbio->file_offset += map_length;
 	if (bbio_has_ordered_extent(bbio)) {
 		refcount_inc(&orig_bbio->ordered->refs);
@@ -244,9 +246,8 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	bio_add_folio_nofail(repair_bio, folio, sectorsize, foff);
 
 	repair_bbio = btrfs_bio(repair_bio);
-	btrfs_bio_init(repair_bbio, fs_info, NULL, fbio);
-	repair_bbio->inode = failed_bbio->inode;
-	repair_bbio->file_offset = failed_bbio->file_offset + bio_offset;
+	btrfs_bio_init(repair_bbio, failed_bbio->inode, failed_bbio->file_offset + bio_offset,
+		       NULL, fbio);
 
 	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
 	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
@@ -332,7 +333,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_device *dev = bio->bi_private;
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
 	btrfs_bio_counter_dec(fs_info);
 
@@ -581,10 +582,11 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 static bool should_async_write(struct btrfs_bio *bbio)
 {
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	bool auto_csum_mode = true;
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
 
 	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_OFF)
@@ -594,7 +596,7 @@ static bool should_async_write(struct btrfs_bio *bbio)
 #endif
 
 	/* Submit synchronously if the checksum implementation is fast. */
-	if (auto_csum_mode && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	if (auto_csum_mode && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
 		return false;
 
 	/*
@@ -605,7 +607,7 @@ static bool should_async_write(struct btrfs_bio *bbio)
 		return false;
 
 	/* Zoned devices require I/O to be submitted in order. */
-	if ((bbio->bio.bi_opf & REQ_META) && btrfs_is_zoned(bbio->fs_info))
+	if ((bbio->bio.bi_opf & REQ_META) && btrfs_is_zoned(fs_info))
 		return false;
 
 	return true;
@@ -620,7 +622,7 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_io_stripe *smap, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	struct async_submit_bio *async;
 
 	async = kmalloc(sizeof(*async), GFP_NOFS);
@@ -639,11 +641,12 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 
 static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 {
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	unsigned int nr_segs;
 	int sector_offset;
 
-	map_length = min(map_length, bbio->fs_info->max_zone_append_size);
-	sector_offset = bio_split_rw_at(&bbio->bio, &bbio->fs_info->limits,
+	map_length = min(map_length, fs_info->max_zone_append_size);
+	sector_offset = bio_split_rw_at(&bbio->bio, &fs_info->limits,
 					&nr_segs, map_length);
 	if (sector_offset) {
 		/*
@@ -651,7 +654,7 @@ static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 		 * sectorsize and thus cause unaligned I/Os.  Fix that by
 		 * always rounding down to the nearest boundary.
 		 */
-		return ALIGN_DOWN(sector_offset << SECTOR_SHIFT, bbio->fs_info->sectorsize);
+		return ALIGN_DOWN(sector_offset << SECTOR_SHIFT, fs_info->sectorsize);
 	}
 	return map_length;
 }
@@ -659,7 +662,7 @@ static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 {
 	struct btrfs_inode *inode = bbio->inode;
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
@@ -670,7 +673,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t status;
 	int ret;
 
-	if (!bbio->inode || btrfs_is_data_reloc_root(inode->root))
+	if (bbio->is_scrub || btrfs_is_data_reloc_root(inode->root))
 		smap.rst_search_commit_root = true;
 	else
 		smap.rst_search_commit_root = false;
@@ -782,7 +785,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 static void assert_bbio_alignment(struct btrfs_bio *bbio)
 {
 #ifdef CONFIG_BTRFS_ASSERT
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	const u32 blocksize = fs_info->sectorsize;
@@ -885,16 +888,16 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
  */
 void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_replace)
 {
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	u64 logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bbio->bio.bi_iter.bi_size;
 	struct btrfs_io_stripe smap = { 0 };
 	int ret;
 
-	ASSERT(fs_info);
 	ASSERT(mirror_num > 0);
 	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
-	ASSERT(!bbio->inode);
+	ASSERT(!is_data_inode(bbio->inode));
+	ASSERT(bbio->is_scrub);
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_repair_block(fs_info, &smap, logical, length, mirror_num);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 3cc0fe23898f..5d20f959e12d 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -27,7 +27,10 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 struct btrfs_bio {
 	/*
 	 * Inode and offset into it that this I/O operates on.
-	 * Only set for data I/O.
+	 *
+	 * If the inode is a data one, csum verification and read-repair
+	 * will be done automatically.
+	 * If the inode is a metadata one, everything is handled by the caller.
 	 */
 	struct btrfs_inode *inode;
 	u64 file_offset;
@@ -69,14 +72,17 @@ struct btrfs_bio {
 	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
-	/* File system that this I/O operates on. */
-	struct btrfs_fs_info *fs_info;
-
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
 	/* Use the commit root to look up csums (data read bio only). */
 	bool csum_search_commit_root;
+
+	/*
+	 * Since scrub will reuse btree inode, we need this flag to distinguish
+	 * scrub bios.
+	 */
+	bool is_scrub;
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
@@ -92,10 +98,10 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 int __init btrfs_bioset_init(void);
 void __cold btrfs_bioset_exit(void);
 
-void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
+void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode, u64 file_offset,
 		    btrfs_bio_end_io_t end_io, void *private);
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-				  struct btrfs_fs_info *fs_info,
+				  struct btrfs_inode *inode, u64 file_offset,
 				  btrfs_bio_end_io_t end_io, void *private);
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..8c3899832a1a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -67,9 +67,7 @@ static struct compressed_bio *alloc_compressed_bio(struct btrfs_inode *inode,
 
 	bbio = btrfs_bio(bio_alloc_bioset(NULL, BTRFS_MAX_COMPRESSED_PAGES, op,
 					  GFP_NOFS, &btrfs_compressed_bioset));
-	btrfs_bio_init(bbio, inode->root->fs_info, end_io, NULL);
-	bbio->inode = inode;
-	bbio->file_offset = start;
+	btrfs_bio_init(bbio, inode, start, end_io, NULL);
 	return to_compressed_bio(bbio);
 }
 
@@ -354,7 +352,7 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 
 static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
 {
-	struct btrfs_fs_info *fs_info = cb->bbio.fs_info;
+	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	struct bio *bio = &cb->bbio.bio;
 	u32 offset = 0;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index c6812d5fcab7..062ebd9c2d32 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include "bio.h"
 #include "fs.h"
+#include "btrfs_inode.h"
 
 struct address_space;
 struct inode;
@@ -74,7 +75,7 @@ struct compressed_bio {
 
 static inline struct btrfs_fs_info *cb_to_fs_info(const struct compressed_bio *cb)
 {
-	return cb->bbio.fs_info;
+	return cb->bbio.inode->root->fs_info;
 }
 
 /* @range_end must be exclusive. */
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index f225cc3fd3a1..962fccceffd6 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -715,10 +715,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
 
-	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
+	btrfs_bio_init(bbio, BTRFS_I(iter->inode), file_offset,
 		       btrfs_dio_end_io, bio->bi_private);
-	bbio->inode = BTRFS_I(iter->inode);
-	bbio->file_offset = file_offset;
 
 	dip->file_offset = file_offset;
 	dip->bytes = bio->bi_iter.bi_size;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cb680cdeb77d..b25a2b45047e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -517,7 +517,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
  */
 static void end_bbio_data_write(struct btrfs_bio *bbio)
 {
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
@@ -573,7 +573,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
  */
 static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 	struct folio_iter fi;
 
@@ -738,12 +738,10 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_bio *bbio;
 
-	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, fs_info,
-			       bio_ctrl->end_io_func, NULL);
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
+			       file_offset, bio_ctrl->end_io_func, NULL);
 	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	bbio->bio.bi_write_hint = inode->vfs_inode.i_write_hint;
-	bbio->inode = inode;
-	bbio->file_offset = file_offset;
 	bio_ctrl->bbio = bbio;
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
 	bio_ctrl->next_file_offset = file_offset;
@@ -2224,12 +2222,11 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
-			       eb->fs_info, end_bbio_meta_write, eb);
+			       BTRFS_I(fs_info->btree_inode), eb->start,
+			       end_bbio_meta_write, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
 	wbc_init_bio(wbc, &bbio->bio);
-	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
-	bbio->file_offset = eb->start;
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
@@ -3844,6 +3841,7 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 				    const struct btrfs_tree_parent_check *check)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_bio *bbio;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
@@ -3877,11 +3875,9 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	refcount_inc(&eb->refs);
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
-			       REQ_OP_READ | REQ_META, eb->fs_info,
-			       end_bbio_meta_read, eb);
+			       REQ_OP_READ | REQ_META, BTRFS_I(fs_info->btree_inode),
+			       eb->start, end_bbio_meta_read, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
-	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
-	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2ca7a34fc73b..bfcac2c68474 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9404,7 +9404,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 disk_bytenr, u64 disk_io_size,
 					  struct page **pages, void *uring_ctx)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private *priv, sync_priv;
 	struct completion sync_reads;
 	unsigned long i = 0;
@@ -9429,10 +9428,9 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
 
-	bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode, 0,
 			       btrfs_encoded_read_endio, priv);
 	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	bbio->inode = inode;
 
 	do {
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
@@ -9441,10 +9439,9 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 			refcount_inc(&priv->pending_refs);
 			btrfs_submit_bbio(bbio, 0);
 
-			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
+			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode, 0,
 					       btrfs_encoded_read_endio, priv);
 			bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-			bbio->inode = inode;
 			continue;
 		}
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe266785804e..4951022ab402 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -929,10 +929,11 @@ static int calc_next_mirror(int mirror, int num_copies)
 static void scrub_bio_add_sector(struct btrfs_bio *bbio, struct scrub_stripe *stripe,
 				 int sector_nr)
 {
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
 	int ret;
 
-	ret = bio_add_page(&bbio->bio, virt_to_page(kaddr), bbio->fs_info->sectorsize,
+	ret = bio_add_page(&bbio->bio, virt_to_page(kaddr), fs_info->sectorsize,
 			   offset_in_page(kaddr));
 	/*
 	 * Caller should ensure the bbio has enough size.
@@ -942,7 +943,19 @@ static void scrub_bio_add_sector(struct btrfs_bio *bbio, struct scrub_stripe *st
 	 * to create the minimal amount of bio vectors, for fs block size < page
 	 * size cases.
 	 */
-	ASSERT(ret == bbio->fs_info->sectorsize);
+	ASSERT(ret == fs_info->sectorsize);
+}
+
+static struct btrfs_bio *alloc_scrub_bbio(struct btrfs_fs_info *fs_info,
+					  unsigned int nr_vecs, blk_opf_t opf,
+					  u64 logical,
+					  btrfs_bio_end_io_t end_io, void *private)
+{
+	struct btrfs_bio *bbio = btrfs_bio_alloc(nr_vecs, opf, BTRFS_I(fs_info->btree_inode),
+						 logical, end_io, private);
+	bbio->is_scrub = true;
+	bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+	return bbio;
 }
 
 static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
@@ -968,12 +981,10 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 			bbio = NULL;
 		}
 
-		if (!bbio) {
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
-				fs_info, scrub_repair_read_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = (stripe->logical +
-				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
-		}
+		if (!bbio)
+			bbio = alloc_scrub_bbio(fs_info, stripe->nr_sectors, REQ_OP_READ,
+						stripe->logical + (i << fs_info->sectorsize_bits),
+						scrub_repair_read_endio, stripe);
 
 		scrub_bio_add_sector(bbio, stripe, i);
 	}
@@ -1352,13 +1363,10 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 			scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
 			bbio = NULL;
 		}
-		if (!bbio) {
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_WRITE,
-					       fs_info, scrub_write_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = (stripe->logical +
-				(sector_nr << fs_info->sectorsize_bits)) >>
-				SECTOR_SHIFT;
-		}
+		if (!bbio)
+			bbio = alloc_scrub_bbio(fs_info, stripe->nr_sectors, REQ_OP_WRITE,
+					stripe->logical + (sector_nr << fs_info->sectorsize_bits),
+					scrub_write_endio, stripe);
 		scrub_bio_add_sector(bbio, stripe, sector_nr);
 	}
 	if (bbio)
@@ -1849,9 +1857,8 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 				continue;
 			}
 
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
-					       fs_info, scrub_read_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+			bbio = alloc_scrub_bbio(fs_info, stripe->nr_sectors, REQ_OP_READ, logical,
+						scrub_read_endio, stripe);
 		}
 
 		scrub_bio_add_sector(bbio, stripe, i);
@@ -1888,10 +1895,8 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 		return;
 	}
 
-	bbio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> min_folio_shift, REQ_OP_READ, fs_info,
-			       scrub_read_endio, stripe);
-
-	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
+	bbio = alloc_scrub_bbio(fs_info, BTRFS_STRIPE_LEN >> min_folio_shift, REQ_OP_READ,
+				stripe->logical, scrub_read_endio, stripe);
 	/* Read the whole range inside the chunk boundary. */
 	for (unsigned int cur = 0; cur < nr_sectors; cur++)
 		scrub_bio_add_sector(bbio, stripe, cur);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e3145c1a102..8833fa54b07b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1813,14 +1813,14 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
 	u64 start = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT);
 	struct btrfs_inode *inode = bbio->inode;
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_block_group *cache;
 	bool ret = false;
 
 	if (!btrfs_is_zoned(fs_info))
 		return false;
 
-	if (!inode || !is_data_inode(inode))
+	if (!is_data_inode(inode))
 		return false;
 
 	if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE)
-- 
2.51.0


