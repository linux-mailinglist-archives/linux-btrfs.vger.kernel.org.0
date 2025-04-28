Return-Path: <linux-btrfs+bounces-13453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B5A9E5A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 03:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1918B1898669
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC284D13;
	Mon, 28 Apr 2025 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LKKURn5z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LKKURn5z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7E433BE
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745802983; cv=none; b=MLIkTkR62JQL9g3nSjv/tav6zd/spAQ6C4xd0gJlZUmoRIf2yIO7bidMXZNFn/otpDM6XLMBIXAJutaa9+HalXFu7zbEP5+NrK5slLaUgxv72yERxjFFvl0m3wCDf8JZIiMxw+oozxNHcW9AvMeIAESUAgejW9s+oWzMQHdLZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745802983; c=relaxed/simple;
	bh=zkc5yUPUg2LdRKmj0NyJBSyngADNCiECSNvM2eozJuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYo5621+xvhxzA9u19Nj1rtz4ghr4RK4g/TBXbAEYPhLd9+pdddAwZFrNY/PH+KpqJNiCkX/clMP3Of7ivIcgV9EsVegYO3FQP3i9HyQQ41VnOupwKTcB06V/ER+qi3dE3uL4Kl5FAFFDcDCrqFK4Cqi1sNtXE/d7OFBIUJnBKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LKKURn5z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LKKURn5z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06AFA211A7
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745802976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNCp1Xmbuje0DHPjqoHSSLDgMzX99SuKV9r3ghBF6GY=;
	b=LKKURn5zC9a0Z6YLMBdFw7Is3j99YhEzTJ29uUb+GIgWbnATtX23+ZpZorZ7uv4sZOnPHj
	MV5i0+CLAVNTl5X8j8+GcRbGp+aPowcBAaQa/Ei3rIn2UgbfZ2kEcGtHpZC0XvWim/DdcZ
	F3sdfJzBpKxXskl7W3s7o1U5Pu3Hhe4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745802976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNCp1Xmbuje0DHPjqoHSSLDgMzX99SuKV9r3ghBF6GY=;
	b=LKKURn5zC9a0Z6YLMBdFw7Is3j99YhEzTJ29uUb+GIgWbnATtX23+ZpZorZ7uv4sZOnPHj
	MV5i0+CLAVNTl5X8j8+GcRbGp+aPowcBAaQa/Ei3rIn2UgbfZ2kEcGtHpZC0XvWim/DdcZ
	F3sdfJzBpKxXskl7W3s7o1U5Pu3Hhe4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D49013A25
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mMTjAN/WDmhADgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into btrfs_read_disk_super()
Date: Mon, 28 Apr 2025 10:45:51 +0930
Message-ID: <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745802753.git.wqu@suse.com>
References: <cover.1745802753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

We have two functions to read a super block from a block device:

- btrfs_read_dev_one_super()
  Exported from disk-io.c

- btrfs_read_disk_super()
  Local to volumes.c

And they have some minor differences:

- btrfs_read_dev_one_super() uses @copy_num
  Meanwhile btrfs_read_disk_super() relies on the physical and expected
  bytenr passed from the caller.

  To be hoest, the parameter list of btrfs_read_dev_one_super() is more
  user friendly.

- btrfs_read_disk_super() makes sure the label is NUL terminated

We do not need two different functions doing the same job, so merge the
behavior into btrfs_read_disk_super() by:

- Remove btrfs_read_dev_one_super()

- Export btrfs_read_disk_super()
  The name pairs with btrfs_release_disk_super() perfectly

- Change the parameter list of btrfs_read_disk_super() to mimic
  btrfs_read_dev_one_super()
  All existing callers are calculating the physical address and expected
  bytenr before calling btrfs_read_disk_super() already.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 53 +---------------------------
 fs/btrfs/disk-io.h |  2 --
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 86 +++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |  2 ++
 5 files changed, 47 insertions(+), 98 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3d151d189510..df68796288a2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3702,57 +3702,6 @@ static void btrfs_end_super_write(struct bio *bio)
 	bio_put(bio);
 }
 
-struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num, bool drop_cache)
-{
-	struct btrfs_super_block *super;
-	struct page *page;
-	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_mapping;
-	int ret;
-
-	bytenr_orig = btrfs_sb_offset(copy_num);
-	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
-	if (ret == -ENOENT)
-		return ERR_PTR(-EINVAL);
-	else if (ret)
-		return ERR_PTR(ret);
-
-	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
-		return ERR_PTR(-EINVAL);
-
-	if (drop_cache) {
-		/* This should only be called with the primary sb. */
-		ASSERT(copy_num == 0);
-
-		/*
-		 * Drop the page of the primary superblock, so later read will
-		 * always read from the device.
-		 */
-		invalidate_inode_pages2_range(mapping,
-				bytenr >> PAGE_SHIFT,
-				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
-	}
-
-	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
-	if (IS_ERR(page))
-		return ERR_CAST(page);
-
-	super = page_address(page);
-	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
-		btrfs_release_disk_super(super);
-		return ERR_PTR(-ENODATA);
-	}
-
-	if (btrfs_super_bytenr(super) != bytenr_orig) {
-		btrfs_release_disk_super(super);
-		return ERR_PTR(-EINVAL);
-	}
-
-	return super;
-}
-
-
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 {
 	struct btrfs_super_block *super, *latest = NULL;
@@ -3765,7 +3714,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i, false);
+		super = btrfs_read_disk_super(bdev, i, false);
 		if (IS_ERR(super))
 			continue;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f87bbb7f8e7e..0ac9baf1215f 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -59,8 +59,6 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
-struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
-						   int copy_num, bool drop_cache);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					const struct btrfs_key *key);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eb92465536f3..bbaf99b118bb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2292,7 +2292,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		return 0;
 
 	/* Only need to check the primary super block. */
-	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
+	sb = btrfs_read_disk_super(dev->bdev, 0, true);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ab8fccf65996..e751bc32e867 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1401,48 +1401,62 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 	put_page(page);
 }
 
-static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
-						       u64 bytenr, u64 bytenr_orig)
+struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
+						int copy_num, bool drop_cache)
 {
-	struct btrfs_super_block *disk_super;
+	struct btrfs_super_block *super;
 	struct page *page;
-	void *p;
-	pgoff_t index;
+	u64 bytenr, bytenr_orig;
+	struct address_space *mapping = bdev->bd_mapping;
+	int ret;
 
-	/* make sure our super fits in the device */
-	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(bdev))
+	bytenr_orig = btrfs_sb_offset(copy_num);
+	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
+	if (ret == -ENOENT)
+		return ERR_PTR(-EINVAL);
+	else if (ret)
+		return ERR_PTR(ret);
+
+	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
-	/* make sure our super fits in the page */
-	if (sizeof(*disk_super) > PAGE_SIZE)
-		return ERR_PTR(-EINVAL);
+	if (drop_cache) {
+		/* This should only be called with the primary sb. */
+		ASSERT(copy_num == 0);
 
-	/* make sure our super doesn't straddle pages on disk */
-	index = bytenr >> PAGE_SHIFT;
-	if ((bytenr + sizeof(*disk_super) - 1) >> PAGE_SHIFT != index)
-		return ERR_PTR(-EINVAL);
-
-	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_mapping, index, GFP_KERNEL);
+		/*
+		 * Drop the page of the primary superblock, so later read will
+		 * always read from the device.
+		 */
+		invalidate_inode_pages2_range(mapping,
+				bytenr >> PAGE_SHIFT,
+				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
+	}
 
+	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
 
-	p = page_address(page);
+	super = page_address(page);
+	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
+		btrfs_release_disk_super(super);
+		return ERR_PTR(-ENODATA);
+	}
 
-	/* align our pointer to the offset of the super block */
-	disk_super = p + offset_in_page(bytenr);
-
-	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
-	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
-		btrfs_release_disk_super(p);
+	if (btrfs_super_bytenr(super) != bytenr_orig) {
+		btrfs_release_disk_super(super);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (disk_super->label[0] && disk_super->label[BTRFS_LABEL_SIZE - 1])
-		disk_super->label[BTRFS_LABEL_SIZE - 1] = 0;
+	/*
+	 * Make sure the last byte of label is properly NUL termiated.
+	 * We use '%s' to print the label, if not properly NUL termiated we
+	 * can access beyond the label.
+	 */
+	if (super->label[0] && super->label[BTRFS_LABEL_SIZE - 1])
+		super->label[BTRFS_LABEL_SIZE - 1] = 0;
 
-	return disk_super;
+	return super;
 }
 
 int btrfs_forget_devices(dev_t devt)
@@ -1514,7 +1528,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
 	char *canonical_path = NULL;
-	u64 bytenr;
 	dev_t devt;
 	int ret;
 
@@ -1544,20 +1557,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
-	/*
-	 * We would like to check all the super blocks, but doing so would
-	 * allow a mount to succeed after a mkfs from a different filesystem.
-	 * Currently, recovery from a bad primary btrfs superblock is done
-	 * using the userspace command 'btrfs check --super'.
-	 */
-	ret = btrfs_sb_log_location_bdev(file_bdev(bdev_file), 0, READ, &bytenr);
-	if (ret) {
-		device = ERR_PTR(ret);
-		goto error_bdev_put;
-	}
-
-	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr,
-					   btrfs_sb_offset(0));
+	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), 0, false);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
@@ -2223,7 +2223,7 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr);
+	disk_super = btrfs_read_disk_super(bdev, copy_num, false);
 	if (IS_ERR(disk_super))
 		return;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 72b8122938eb..37cfdd71e998 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -785,6 +785,8 @@ struct btrfs_chunk_map *btrfs_find_chunk_map_nolock(struct btrfs_fs_info *fs_inf
 struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
 void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
+struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
+						int copy_num, bool drop_cache);
 void btrfs_release_disk_super(struct btrfs_super_block *super);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
-- 
2.49.0


