Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC93418FDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhI0HYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56862 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhI0HYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5736120092
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Br28clOaa+IdwPN4jKeG9XeI4+E7oADkIP4iHbbJDc=;
        b=cTV4GuLj7Kv5neoVToBJ089LA84BuPKHfjxVbEZ5cAs7g9/aJ6DVGO4lKJO3vzcLN72wKC
        jwhZ9eWLzDL6xcn61yU6XTZyiLf4QRVa5H9amwFp6D0THSPt9j8FbRl2E9unXLlxgbdPhX
        LYjI3FbJAx4xBnHoE/kJ5Iz1NQNVZ6c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0C9813A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yAsIH0BxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 14/26] btrfs: remove unused function btrfs_bio_fits_in_stripe()
Date:   Mon, 27 Sep 2021 15:21:56 +0800
Message-Id: <20210927072208.21634-15-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As the last caller in compression.c is removed, we don't need that
function anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  2 --
 fs/btrfs/inode.c | 42 ------------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 522ded06fd85..7d6474f15305 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3187,8 +3187,6 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 				 struct extent_state *other);
 void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
-int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
-			     unsigned long bio_flags);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c68ca5002434..796a850b9076 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2233,48 +2233,6 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	}
 }
 
-/*
- * btrfs_bio_fits_in_stripe - Checks whether the size of the given bio will fit
- * in a chunk's stripe. This function ensures that bios do not span a
- * stripe/chunk
- *
- * @page - The page we are about to add to the bio
- * @size - size we want to add to the bio
- * @bio - bio we want to ensure is smaller than a stripe
- * @bio_flags - flags of the bio
- *
- * return 1 if page cannot be added to the bio
- * return 0 if page can be added to the bio
- * return error otherwise
- */
-int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
-			     unsigned long bio_flags)
-{
-	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	u32 bio_len = bio->bi_iter.bi_size;
-	struct extent_map *em;
-	int ret = 0;
-	struct btrfs_io_geometry geom;
-
-	if (bio_flags & EXTENT_BIO_COMPRESSED)
-		return 0;
-
-	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical, &geom);
-	if (ret < 0)
-		goto out;
-
-	if (geom.len < bio_len + size)
-		ret = 1;
-out:
-	free_extent_map(em);
-	return ret;
-}
-
 /*
  * in order to insert checksums into the metadata in large chunks,
  * we wait until bio submission time.   All the pages in the bio are
-- 
2.33.0

