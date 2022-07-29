Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E858520C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiG2PEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiG2PEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 11:04:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1C80F79
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 08:04:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E07D820127;
        Fri, 29 Jul 2022 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659107046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nxYDyJWtLVgZrisb3iVK4cJpGZdblyabsoOlGmjFE8=;
        b=dpAoH9g6P5wTvnSKBpjhRR5e4QaVZYCUGAw6TQ0sVnezQz2cHyWXZet4JGdlsNkE6Cm92T
        iZJF1aI9vHDX4p2AAuTog0YalRtq1ViM2MfwfwK9bx4fEX7CnYl2ofQ1pmjbL4iy0GEnSI
        VNCQecAvanatGPIck7s2lptJecUaa0Y=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D84092C141;
        Fri, 29 Jul 2022 15:04:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2A05DA85A; Fri, 29 Jul 2022 16:59:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: prepare more slots for checksum shash
Date:   Fri, 29 Jul 2022 16:59:08 +0200
Message-Id: <975b483454847df3ff97b68d77d398b684ceceeb.1659106597.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659106597.git.dsterba@suse.com>
References: <cover.1659106597.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's now one checksum template fs_info::csum_shash that contains
whatever the crypto API decides is the best available implementation. To
allow loading other implementations after mount add more slots and
symbolic names. The slot 0 is always used when calculating checksum,
other slots may be set later or left empty.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/check-integrity.c |  4 ++--
 fs/btrfs/compression.c     |  4 ++--
 fs/btrfs/ctree.h           | 13 ++++++++++++-
 fs/btrfs/disk-io.c         | 19 ++++++++++---------
 fs/btrfs/file-item.c       |  4 ++--
 fs/btrfs/inode.c           |  4 ++--
 fs/btrfs/scrub.c           | 12 ++++++------
 fs/btrfs/sysfs.c           |  2 +-
 8 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 5d20137b7b67..dbabdd01ed66 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1647,7 +1647,7 @@ static noinline_for_stack int btrfsic_test_for_metadata(
 		char **datav, unsigned int num_pages)
 {
 	struct btrfs_fs_info *fs_info = state->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	struct btrfs_header *h;
 	u8 csum[BTRFS_CSUM_SIZE];
 	unsigned int i;
@@ -1660,7 +1660,7 @@ static noinline_for_stack int btrfsic_test_for_metadata(
 	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE))
 		return 1;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 	crypto_shash_init(shash);
 
 	for (i = 0; i < num_pages; i++) {
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d9..096284cdf2ea 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -147,7 +147,7 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 				 u64 disk_start)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	const u32 csum_size = fs_info->csum_size;
 	const u32 sectorsize = fs_info->sectorsize;
 	struct page *page;
@@ -161,7 +161,7 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
 		return 0;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 
 	for (i = 0; i < cb->nr_pages; i++) {
 		u32 pg_offset;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c21e214d29e..9f145b59e7d2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -656,6 +656,13 @@ enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_SWAP_ACTIVATE,
 };
 
+enum btrfs_csum_impl {
+	CSUM_DEFAULT,
+	CSUM_GENERIC,
+	CSUM_ACCEL,
+	CSUM_COUNT
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -1036,7 +1043,11 @@ struct btrfs_fs_info {
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
 
-	struct crypto_shash *csum_shash;
+	/*
+	 * Templates for checksum calculation, slot 0 is for the currently used
+	 * one, other slots are optional for available implementations.
+	 */
+	struct crypto_shash *csum_shash[CSUM_COUNT];
 
 	/* Type of exclusive operation running, protected by super_lock */
 	enum btrfs_exclusive_operation exclusive_operation;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index de440ebf5648..dc41db822322 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -100,8 +100,9 @@ void __cold btrfs_end_io_wq_exit(void)
 
 static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->csum_shash)
-		crypto_free_shash(fs_info->csum_shash);
+	for (int i = 0; i < CSUM_COUNT; i++)
+		if (fs_info->csum_shash[i])
+			crypto_free_shash(fs_info->csum_shash[i]);
 }
 
 /*
@@ -211,11 +212,11 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	const int num_pages = num_extent_pages(buf);
 	const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	char *kaddr;
 	int i;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 	crypto_shash_init(shash);
 	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
@@ -290,9 +291,9 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	struct btrfs_super_block *disk_sb =
 		(struct btrfs_super_block *)raw_disk_sb;
 	char result[BTRFS_CSUM_SIZE];
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 
 	/*
 	 * The super_block structure does not span the whole
@@ -2535,7 +2536,7 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		return PTR_ERR(csum_shash);
 	}
 
-	fs_info->csum_shash = csum_shash;
+	fs_info->csum_shash[CSUM_DEFAULT] = csum_shash;
 
 	return 0;
 }
@@ -4090,7 +4091,7 @@ static int write_dev_supers(struct btrfs_device *device,
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	int i;
 	int errors = 0;
 	int ret;
@@ -4099,7 +4100,7 @@ static int write_dev_supers(struct btrfs_device *device,
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c828f971a346..6e416230733b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -635,7 +635,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				u64 offset, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
 	const bool use_page_offsets = (offset == (u64)-1);
@@ -663,7 +663,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	sums->bytenr = bio->bi_iter.bi_sector << 9;
 	index = 0;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 
 	bio_for_each_segment(bvec, bio, iter) {
 		if (use_page_offsets)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d50448bf8eed..86885f78c6c6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3344,7 +3344,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 			   u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	char *kaddr;
 	u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
@@ -3358,7 +3358,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 
 	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
 	kunmap_atomic(kaddr);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e7b0323e6efd..cc2ee8b71086 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1786,7 +1786,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	u8 csum[BTRFS_CSUM_SIZE];
 	struct scrub_sector *sector;
 	char *kaddr;
@@ -1798,7 +1798,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 
 	kaddr = page_address(sector->page);
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 	crypto_shash_init(shash);
 
 	/*
@@ -1817,7 +1817,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_header *h;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	/*
@@ -1861,7 +1861,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		   BTRFS_UUID_SIZE))
 		sblock->header_error = 1;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 	crypto_shash_init(shash);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    sectorsize - BTRFS_CSUM_SIZE);
@@ -1883,7 +1883,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	struct btrfs_super_block *s;
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash[CSUM_DEFAULT]);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	struct scrub_sector *sector;
 	char *kaddr;
@@ -1904,7 +1904,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	if (!scrub_check_fsid(s->fsid, sector))
 		++fail_cor;
 
-	shash->tfm = fs_info->csum_shash;
+	shash->tfm = fs_info->csum_shash[CSUM_DEFAULT];
 	crypto_shash_init(shash);
 	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
 			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 92a1fa8e3da6..caa84d398fec 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -939,7 +939,7 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
 	return sysfs_emit(buf, "%s (%s)\n",
 			  btrfs_super_csum_name(csum_type),
-			  crypto_shash_driver_name(fs_info->csum_shash));
+			  crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]));
 }
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
-- 
2.36.1

