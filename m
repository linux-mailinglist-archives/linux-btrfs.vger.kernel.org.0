Return-Path: <linux-btrfs+bounces-18281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 363CFC05AC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5494735C219
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C5313292;
	Fri, 24 Oct 2025 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MOik8nvv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="euFj4lhe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB930E0CD
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303032; cv=none; b=c3doDs/ezjDZB3pPXU2/wl00NTkASghPy7KCSQ8AtuSlqW1Ht3Z//XGgVbqF5ksIJoxfWJ+ty30h9VJpZtXJJmipQaZr8+vl1KCUFRWXQ5S0BkJtzapU0OgJvGEj89V4CpCq/Y1MRJiOd7bEk8/pNa74sWr/U7dNdvo9V1F1wac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303032; c=relaxed/simple;
	bh=tJWhRxRXBpW5aoltqvNDGOrCjlINxSow1YoeqgDoN8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjLv9Nqbh4qbEAQn3xk2CW0n1uVckXRfzq1Z8eDhaMiTzIhYXiIe99iIucEKv3W1wLg4+WwUrTeWJa+y8izO/wgNYOVjSdg+Zwoh9RBgs8lsLt12q2PoqE6ng5btljmkQE8eMz70Rmf0XAfIHqZfLB/I8d7e/GFlA0L0hlRI9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MOik8nvv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=euFj4lhe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48B8E211E8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761303007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5b3bFniXo9TdtX5XhXHP2A0OIkBKH3CmVS2SkIhGNM4=;
	b=MOik8nvvGkwBSKJOw0HGmcRE0oY0xCXgBpK+NnYOetMcaBAOg75FVwVS2G3ZdyeguMscB1
	5ouu4xLDhGg08XtIcNRrGapYIl3OeMetVHxw0bqS1brrx5H4s9bc1NY+186AZ3aJalB4xY
	YNsgK9JEhxpFGYVOVSZ7Vspt1ZDDjHE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761303003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5b3bFniXo9TdtX5XhXHP2A0OIkBKH3CmVS2SkIhGNM4=;
	b=euFj4lheF1cIUWDEU/VPQBOLqdwmsntPyp2eidQJJoI+RWoXuJYpWTNdLmjTYPiKUehzcJ
	4UICLKgQHmT4AYS0qi+o6fwEXhmVtCjRhqqbObjTBRK15NQNZ/Xd+VCCivjQNFrFQwD7Q6
	GussKl0o4DZXU8Opwoe8hJdmlGluClE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E8AD13AEF
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGnlD9pZ+2iaZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
Date: Fri, 24 Oct 2025 21:19:35 +1030
Message-ID: <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761302592.git.wqu@suse.com>
References: <cover.1761302592.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[ENHANCEMENT]
Btrfs currently calculate its data checksum then submit the bio.

But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
if the inode requires checksum"), any writes with data checksum will
fallback to buffered IO, meaning the content will not change during
writeback.

This means we're safe to calculate the data checksum and submit the bio
in parallel, we only need to make sure btrfs_bio::end_io() is called
after the checksum calculation is done.

As usual, such new feature is hidden behind the experimental flag.

[THEORETIC ANALYZE]
Consider the following theoretic hardware performance, which should be
more or less close to modern mainstream hardware:

	Memory bandwidth:	50GiB/s
	CRC32C bandwidth:	45GiB/s
	SSD bandwidth:		8GiB/s

Then btrfs write bandwidth with data checksum before the patch would be

	1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s

After the patch, the bandwidth would be:

	1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s

The difference would be 15.32 % improvement.

[REAL WORLD BENCHMARK]
I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs, the
storage is backed by a PCIE gen3 x4 NVME SSD.

The test is a direct IO write, with 1MiB block size, write 7GiB data
into a btrfs mount with data checksum. Thus the direct write will fallback
to buffered one:

Vanilla Datasum:	1619.97 GiB/s
Patched Datasum:	1792.26 GiB/s
Diff			+10.6 %

In my case, the bottleneck is the storage, thus the improvement is not
reaching the theoretic one, but still some observable improvement.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c       | 17 ++++++++----
 fs/btrfs/bio.h       |  5 ++++
 fs/btrfs/file-item.c | 61 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/file-item.h |  2 +-
 4 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 18272ef4b4d8..a5b83c6c9e7f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -103,6 +103,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	/* Make sure we're already in task context. */
 	ASSERT(in_task());
 
+	if (bbio->async_csum)
+		wait_for_completion(&bbio->csum_done);
+
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
@@ -535,7 +538,7 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
-	return btrfs_csum_one_bio(bbio);
+	return btrfs_csum_one_bio(bbio, true);
 }
 
 /*
@@ -613,10 +616,14 @@ static bool should_async_write(struct btrfs_bio *bbio)
 	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
 	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
 
-	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_OFF)
-		return false;
-
-	auto_csum_mode = (csum_mode == BTRFS_OFFLOAD_CSUM_AUTO);
+	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_ON)
+		return true;
+	/*
+	 * Write bios will calculate checksum and submit bio at the same time.
+	 * Unless explicitly required don't offload serial csum calculate and bio
+	 * submit into a workqueue.
+	 */
+	return false;
 #endif
 
 	/* Submit synchronously if the checksum implementation is fast. */
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 00883aea55d7..277f2ac090d9 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -60,6 +60,8 @@ struct btrfs_bio {
 		struct {
 			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
+			struct work_struct csum_work;
+			struct completion csum_done;
 			u64 orig_physical;
 		};
 
@@ -84,6 +86,9 @@ struct btrfs_bio {
 
 	/* Use the commit root to look up csums (data read bio only). */
 	bool csum_search_commit_root;
+
+	bool async_csum;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a42e6d54e7cd..bedfcf4a088d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -18,6 +18,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "volumes.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
@@ -764,21 +765,46 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 	return ret;
 }
 
-/*
- * Calculate checksums of the data contained inside a bio.
- */
-int btrfs_csum_one_bio(struct btrfs_bio *bbio)
+static void csum_one_bio(struct btrfs_bio *bbio)
 {
-	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
-	struct btrfs_ordered_sum *sums;
+	struct btrfs_ordered_sum *sums = bbio->sums;
 	struct bvec_iter iter = bio->bi_iter;
 	phys_addr_t paddr;
 	const u32 blocksize = fs_info->sectorsize;
-	int index;
+	int index = 0;
+
+	shash->tfm = fs_info->csum_shash;
+
+	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
+		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
+		index += fs_info->csum_size;
+	}
+}
+
+static void csum_one_bio_work(struct work_struct *work)
+{
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, csum_work);
+
+	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
+	ASSERT(bbio->async_csum == true);
+	csum_one_bio(bbio);
+	complete(&bbio->csum_done);
+}
+
+/*
+ * Calculate checksums of the data contained inside a bio.
+ */
+int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
+{
+	struct btrfs_ordered_extent *ordered = bbio->ordered;
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct bio *bio = &bbio->bio;
+	struct btrfs_ordered_sum *sums;
 	unsigned nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
@@ -789,21 +815,20 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	if (!sums)
 		return -ENOMEM;
 
+	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
-
-	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	index = 0;
-
-	shash->tfm = fs_info->csum_shash;
-
-	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
-		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
-		index += fs_info->csum_size;
-	}
-
 	bbio->sums = sums;
 	btrfs_add_ordered_sum(ordered, sums);
+
+	if (!async) {
+		csum_one_bio(bbio);
+		return 0;
+	}
+	init_completion(&bbio->csum_done);
+	bbio->async_csum = true;
+	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
+	schedule_work(&bbio->csum_work);
 	return 0;
 }
 
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 63216c43676d..2a250cf8b2a1 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-int btrfs_csum_one_bio(struct btrfs_bio *bbio);
+int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
 int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
-- 
2.51.0


