Return-Path: <linux-btrfs+bounces-18909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C822C543F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CA43B6804
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB434DB45;
	Wed, 12 Nov 2025 19:36:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8F34D914
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976206; cv=none; b=Q0m3fjjYSYDnSFDPABfmUhe8OWzbV/ctds+u8BwPrLrGEzuSRCiMRkm9MfBr6wje/WXBAMN6hep0BNjWETRzjRYe8AU/xd7PzoWknEU+enRR+MaK5ZZCjDsb1qn+gVDLrzyGRuIkD7s3PPRRh0uN9JR7vnRTYKSnVWnma8IbqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976206; c=relaxed/simple;
	bh=cJRleMYkhB7ftVmOOWDmYy5Xb7gMv+BWoTmEtMo3il0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nnqa+WMgsVuNQ8gMSGrYuH55pott4RLtmSfo0PFZFrCQj6I8qn4IK+QBDgCgwROVAfaz2lLS72Iy9jzMbYzgDme0wh4ugPJ42cSJ1OIh/go8WSFB6/d+V8U6cfNhFzhXZlhdAFCMKGSZGeEczZMM9DJnQF1oZRLPuSl0T78T16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A00C1F7A1;
	Wed, 12 Nov 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2403D3EA61;
	Wed, 12 Nov 2025 19:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6IBNCMrhFGm+YgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 12 Nov 2025 19:36:42 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
Date: Wed, 12 Nov 2025 20:36:03 +0100
Message-ID: <20251112193611.2536093-4-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112193611.2536093-1-neelx@suse.com>
References: <20251112193611.2536093-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 3A00C1F7A1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

From: Josef Bacik <josef@toxicpanda.com>

We only ever needed the bbio in btrfs_csum_one_bio, since that has the
bio embedded in it.  However with encryption we'll have a different bio
with the encrypted data in it, and the original bbio.  Update
btrfs_csum_one_bio to take the bio we're going to csum as an argument,
which will allow us to csum the encrypted bio and stuff the csums into
the corresponding bbio to be used later when the IO completes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
Compared to v5 this needed to adapt to recent async csum changes.
---
 fs/btrfs/bio.c       |  4 ++--
 fs/btrfs/bio.h       |  1 +
 fs/btrfs/file-item.c | 17 ++++++++---------
 fs/btrfs/file-item.h |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a73652b8724a..a69174b2b6b6 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-	return btrfs_csum_one_bio(bbio, true);
+	return btrfs_csum_one_bio(bbio, &bbio->bio, true);
 #else
-	return btrfs_csum_one_bio(bbio, false);
+	return btrfs_csum_one_bio(bbio, &bbio->bio, false);
 #endif
 }
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index deaeea3becf4..c5a6c66d51a0 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -58,6 +58,7 @@ struct btrfs_bio {
 			struct btrfs_ordered_sum *sums;
 			struct work_struct csum_work;
 			struct completion csum_done;
+			struct bio *csum_bio;
 			struct bvec_iter csum_saved_iter;
 			u64 orig_physical;
 		};
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 72be3ede0edf..474949074da8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 	return ret;
 }
 
-static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
+static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, struct bvec_iter *iter)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums = bbio->sums;
-	struct bvec_iter iter = *src;
 	phys_addr_t paddr;
 	const u32 blocksize = fs_info->sectorsize;
 	int index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
-	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
+	btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
 		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
 		index += fs_info->csum_size;
 	}
@@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_struct *work)
 
 	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
 	ASSERT(bbio->async_csum == true);
-	csum_one_bio(bbio, &bbio->csum_saved_iter);
+	csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
 	complete(&bbio->csum_done);
 }
 
 /*
  * Calculate checksums of the data contained inside a bio.
  */
-int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
+int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async)
 {
 	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
 	unsigned nofs_flag;
 
@@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
 	btrfs_add_ordered_sum(ordered, sums);
 
 	if (!async) {
-		csum_one_bio(bbio, &bbio->bio.bi_iter);
+		struct bvec_iter iter = bio->bi_iter;
+		csum_one_bio(bbio, bio, &iter);
 		return 0;
 	}
 	init_completion(&bbio->csum_done);
 	bbio->async_csum = true;
-	bbio->csum_saved_iter = bbio->bio.bi_iter;
+	bbio->csum_bio = bio;
+	bbio->csum_saved_iter = bio->bi_iter;
 	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
 	schedule_work(&bbio->csum_work);
 	return 0;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 5645c5e3abdb..d16fd2144552 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
+int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async);
 int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
-- 
2.51.0


