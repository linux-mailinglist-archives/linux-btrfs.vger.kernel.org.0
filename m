Return-Path: <linux-btrfs+bounces-18393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BCC18505
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C967340186D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDC2FA0EF;
	Wed, 29 Oct 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rhiTTj8B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rhiTTj8B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208D2F9D88
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716113; cv=none; b=la9mH+xtNRgHwe4VdWpgHU/IJE7vyq6N2AYpsF/srBrO+Dyzn5L5qKDkcpm4kfq1rhWxZv4qikm9ibUqqxardxUEz/LExFX2ix0T1Gb4i3GxuPvlxrgCC/pOcXt1ZBD6eBxPjikXWyVpcmtuVSe8gNAfKfSLgmGZ5tn4rgXllEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716113; c=relaxed/simple;
	bh=1DSeyE7nabNuiAEAsn35MTcgoKDI3fhLZ/HASiyAUsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQMKncKkXNclg9ZaDGhKFCukJiWaySzI90UgImiN+hjaMTJsu12Y935nxd8KJi5toQ33/5ihu7LDXTAf3cPG2+bInHGphA6YgYw4th7nxCe1C/EyBlGwFqWPYM4T5RSd8D7551sWbayT6YODvYrpyebwdZ2pXQo8fJ9/cYEtu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rhiTTj8B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rhiTTj8B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D9931FD93
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTTfENXyPv3fDBFSjop7xqJ50hkjO7igsT5N2fCHl9M=;
	b=rhiTTj8BCVviZtUeTpHlqlBqyAZNJzlFsI7LMvr/gdqXwx4ChdogMDSnl/pO1B4+WiTgbP
	quCdcOw8FLwqKbzMsyP4ulJhz0BcCiVMErVkvgEeCewRAXWm5QWiDBC3/te5WIkKxsA3kx
	Jk5psb474KSR04svT+5e2MjrSvdfsv8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rhiTTj8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTTfENXyPv3fDBFSjop7xqJ50hkjO7igsT5N2fCHl9M=;
	b=rhiTTj8BCVviZtUeTpHlqlBqyAZNJzlFsI7LMvr/gdqXwx4ChdogMDSnl/pO1B4+WiTgbP
	quCdcOw8FLwqKbzMsyP4ulJhz0BcCiVMErVkvgEeCewRAXWm5QWiDBC3/te5WIkKxsA3kx
	Jk5psb474KSR04svT+5e2MjrSvdfsv8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B50CA13886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AMYrHXSnAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
Date: Wed, 29 Oct 2025 16:04:17 +1030
Message-ID: <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7D9931FD93
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[ENHANCEMENT]
Btrfs currently calculate its data checksum then submit the bio.

But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
if the inode requires checksum"), any writes with data checksum will
fallback to buffered IO, meaning the content will not change during
writeback.

This means we're safe to calculate the data checksum and submit the bio
in parallel, and only need the following new behaviors:

- Wait the csum generation to finish before calling btrfs_bio::end_io()
  Or we can lead to use-after-free for the csum generation worker.

- Save the current bi_iter for csum_one_bio()
  As the submission part can advance btrfs_bio::bio.bi_iter, if not
  saved csum_one_bio() may got an empty bi_iter and do not generate any
  checksum.

  Unfortunately this means we have to increase the size of btrfs_bio for
  16 bytes.

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
 fs/btrfs/bio.c       | 21 +++++++++++----
 fs/btrfs/bio.h       |  7 +++++
 fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/file-item.h |  2 +-
 4 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5a5f23332c2e..8af2b68c2d53 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	/* Make sure we're already in task context. */
 	ASSERT(in_task());
 
+	if (bbio->async_csum)
+		wait_for_completion(&bbio->csum_done);
+
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
@@ -538,7 +541,11 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
-	return btrfs_csum_one_bio(bbio);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	return btrfs_csum_one_bio(bbio, true);
+#else
+	return btrfs_csum_one_bio(bbio, false);
+#endif
 }
 
 /*
@@ -617,10 +624,14 @@ static bool should_async_write(struct btrfs_bio *bbio)
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
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
index 5d20f959e12d..deaeea3becf4 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -56,6 +56,9 @@ struct btrfs_bio {
 		struct {
 			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
+			struct work_struct csum_work;
+			struct completion csum_done;
+			struct bvec_iter csum_saved_iter;
 			u64 orig_physical;
 		};
 
@@ -83,6 +86,10 @@ struct btrfs_bio {
 	 * scrub bios.
 	 */
 	bool is_scrub;
+
+	/* Whether the csum generation for data write is async. */
+	bool async_csum;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a42e6d54e7cd..4b7c40f05e8f 100644
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
+static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
 {
-	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
-	struct btrfs_ordered_sum *sums;
-	struct bvec_iter iter = bio->bi_iter;
+	struct btrfs_ordered_sum *sums = bbio->sums;
+	struct bvec_iter iter = *src;
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
+	csum_one_bio(bbio, &bbio->csum_saved_iter);
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
@@ -789,21 +815,21 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
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
+		csum_one_bio(bbio, &bbio->bio.bi_iter);
+		return 0;
+	}
+	init_completion(&bbio->csum_done);
+	bbio->async_csum = true;
+	bbio->csum_saved_iter = bbio->bio.bi_iter;
+	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
+	schedule_work(&bbio->csum_work);
 	return 0;
 }
 
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 0d59e830018a..5645c5e3abdb 100644
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


