Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B54573450
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiGMKbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiGMKbf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:35 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F522FD231
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:34 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 740548112C;
        Wed, 13 Jul 2022 06:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708293; bh=AQ/C3FoEQ+BKCBP1r64DSKtSDuzhJ+2thZq33EtEhVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ApjJexIiaOHxgYZH8KO9gORc/5BJVyWEA86SsYaEViPeh+BEdpSURKhSvCYVquBbf
         FgIbHoZGRjgodxx2aAZDS9pOWXjZAbgfeYrQFL2zvMo7Ez6jWMNM4hfp8pTtUDEAwb
         93q4F4EZU3eSEM3AwHuRXymqo0/XmQzSoWjZDmzUpFxXlbqrq2AlWVevOWQzOMbphL
         yMppG+ZWNFxqLiOaMJpjw4lMU5yoU0PnizlF9IGaFLOk6p5E1mpwausX+c7rCDUgcq
         /C1RHdYLHdxKlHiv1/llQgK0Q8LbQQFHQ0pzTESoXFci4mO059Ez75Ia0IH7qWQcah
         f6geNUtbj1Evw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 23/23] btrfs: enable encryption for normal file extent data
Date:   Wed, 13 Jul 2022 06:29:56 -0400
Message-Id: <46f91ad6f27527dcb54d4cf9896544c6ecb55a40.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add in the necessary calls to encrypt and decrypt data to achieve
encryption of normal data.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/extent_io.c    | 53 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/file-item.c    |  9 +++++--
 fs/btrfs/fscrypt.c      | 27 +++++++++++++++++----
 fs/btrfs/tree-checker.c | 11 ++++++---
 4 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 235f9612676a..b0ceee84d81c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -190,7 +190,11 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 		return;
 
 	bio = bio_ctrl->bio;
-	inode = bio_first_page_all(bio)->mapping->host;
+	struct page *first_page = bio_first_page_all(bio);
+	if (fscrypt_is_bounce_page(first_page))
+		inode = fscrypt_pagecache_page(first_page)->mapping->host;
+	else
+		inode = bio_first_page_all(bio)->mapping->host;
 	mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
@@ -2869,9 +2873,19 @@ static void end_bio_extent_writepage(struct bio *bio)
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u32 sectorsize = fs_info->sectorsize;
+		struct inode *inode;
+		struct btrfs_fs_info *fs_info;
+		u32 sectorsize;
+		struct page *bounce_page = NULL;
+
+		if (fscrypt_is_bounce_page(page)) {
+			bounce_page = page;
+			page = fscrypt_pagecache_page(bounce_page);
+		}
+
+		inode = page->mapping->host;
+		fs_info = btrfs_sb(inode->i_sb);
+		sectorsize = fs_info->sectorsize;
 
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
@@ -2892,7 +2906,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 		}
 
 		end_extent_writepage(page, error, start, end);
-
+		fscrypt_free_bounce_page(bounce_page);
 		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
 	}
 
@@ -3089,6 +3103,17 @@ static void end_bio_extent_readpage(struct bio *bio)
 			}
 		}
 
+		if (likely(uptodate)) {
+			if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
+				int ret = fscrypt_decrypt_pagecache_blocks(page,
+									   bvec->bv_len,
+									   bvec->bv_offset);
+				if (ret) {
+					error_bitmap = (unsigned int) -1;
+					uptodate = false;
+					}
+			}
+		}
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
@@ -3442,11 +3467,29 @@ static int submit_extent_page(unsigned int opf,
 			      bool force_bio_submit)
 {
 	int ret = 0;
+	struct page *bounce_page = NULL;
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	unsigned int cur = pg_offset;
 
 	ASSERT(bio_ctrl);
 
+	if ((opf & REQ_OP_MASK) == REQ_OP_WRITE &&
+	    fscrypt_inode_uses_fs_layer_crypto(&inode->vfs_inode)) {
+		gfp_t gfp_flags = GFP_NOFS;
+
+		if (bio_ctrl->bio)
+			gfp_flags = GFP_NOWAIT | __GFP_NOWARN;
+		else
+			gfp_flags = GFP_NOFS;
+		bounce_page = fscrypt_encrypt_pagecache_blocks(page, size,
+							       pg_offset,
+							       gfp_flags);
+		if (IS_ERR(bounce_page))
+			return PTR_ERR(bounce_page);
+		page = bounce_page;
+		pg_offset = 0;
+	}
+
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
 	if (force_bio_submit)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 066d59707408..c3780eacdd35 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -663,8 +663,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (use_page_offsets)
-			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
+		if (use_page_offsets) {
+			struct page *page = bvec.bv_page;
+
+			if (fscrypt_is_bounce_page(page))
+				page = fscrypt_pagecache_page(page);
+			offset = page_offset(page) + bvec.bv_offset;
+		}
 
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 82eb9654f60f..1a211734c28e 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -188,11 +188,28 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
 static void btrfs_fscrypt_get_iv(u8 *iv, int ivsize, struct inode *inode,
 				 u64 lblk_num)
 {
-	/*
-	 * For encryption that doesn't involve extent data, juse use the
-	 * nonce already loaded into the iv buffer.
-	 */
-	return;
+	u64 offset = lblk_num << inode->i_blkbits;
+	struct extent_map *em;
+
+	if (lblk_num == 0) {
+		/* Must be a filename or a symlink. Just use the nonce. */
+		return;
+	}
+
+	/* Since IO must be in progress on this extent, this must succeed */
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, PAGE_SIZE);
+	ASSERT(!IS_ERR(em) && em);
+	if (em) {
+		__le64 *iv_64 = (__le64 *)iv;
+		memcpy(iv, em->iv, ivsize);
+		/*
+		 * Add the lblk_num to the low bits of the IV to ensure
+		 * the IV changes for every page
+		 */
+		*iv_64 = cpu_to_le64(le64_to_cpu(*iv_64) + lblk_num);
+		free_extent_map(em);
+		return;
+	}
 }
 
 const struct fscrypt_operations btrfs_fscrypt_ops = {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 458877442ce5..6908dcb5d737 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -273,9 +273,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			return -EUCLEAN;
 		}
 
-		/* Compressed inline extent has no on-disk size, skip it */
-		if (btrfs_file_extent_compression(leaf, fi) !=
-		    BTRFS_COMPRESS_NONE)
+		/*
+		 * Compressed inline extent has no on-disk size; encrypted has
+		 * variable size; skip them
+		 */
+		if ((btrfs_file_extent_compression(leaf, fi) !=
+		     BTRFS_COMPRESS_NONE) ||
+		    (btrfs_file_extent_encryption(leaf, fi) !=
+		     BTRFS_ENCRYPTION_NONE))
 			return 0;
 
 		/* Uncompressed inline extent size must match item size */
-- 
2.35.1

