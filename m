Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980F5B9648
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIOIYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiIOIXs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 04:23:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F5997ED3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 01:23:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8DD1A206B2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663230192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCLxvVcdOQY0yMudzgioS5Pte0/Q3ZLoelATZ/mmvZY=;
        b=W/sUaKixN6fys48/CD0ylraqP+NBlfHZdbOgEo+lhS+jJDzFs51H8o/GWO3eBUE/xkHkRh
        xq5fkGrso/0cuBkafuMKBqAY+XjUtQPY1P33ARQpYSZ+u+wRGtMHamj+JA53sglGnW/FW0
        VZcRkuyg0Yh3JLcf9BqHvHm3WcrjDfw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8F89139C8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GHFTI+/gImNaeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:23:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: refactor the inline extent read code inside btrfs_get_extent()
Date:   Thu, 15 Sep 2022 16:22:51 +0800
Message-Id: <dc726a7d458d3100602b3507cbf2a236ac47ff55.1663229903.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663229903.git.wqu@suse.com>
References: <cover.1663229903.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
In btrfs_get_extent() we can fill the inline extent directly.

But there are something not that straightforward for the functionality:

- It's behind two levels of indent

- It has a weird reset for extent map values
  This includes resetting:
  * em->start

    This makes no sense, as our current tree-checker ensures that
    inline extent can only at file offset 0.

    This means not only the @extent_start (key.offset) is always 0,
    but also @pg_offset and @extent_offset should also be 0.

  * em->len

    In btrfs_extent_item_to_extent_map(), we already initialize em->len
    to "btrfs_file_extent_end() - extent_start".
    Since @extent_start can only be 0 for inline extents, and
    btrfs_file_extent_end() is already doing ALIGN() (which is rounding
    up).

    So em->len is always sector_size for inlined extent now.

  * em->orig_block_len/orig_start

    They doesn't make much sense for inlined extent anyway.

- Extra complex calculation for inline extent read

  This is mostly caused by the fact it's still assuming we can have
  inline file extents at non-zero file offset.

  Such offset calculation is now a dead code which we will never reach,
  just damaging the readability.

- We have an extra bool for btrfs_extent_item_to_extent_map()

  Which is making no difference for now.

[ENHANCEMENT]
This patch will enhance the behavior by:

- Extract the read code into a new helper, read_inline_extent()

- Much simpler calculation for inline extent read

- Don't touch extent map when reading inline extents

- Remove the bool argument from btrfs_extent_item_to_extent_map()

- New ASSERT()s to ensure inline extents only start at file offset 0

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     |  1 -
 fs/btrfs/file-item.c |  6 +--
 fs/btrfs/inode.c     | 93 +++++++++++++++++++++++++-------------------
 fs/btrfs/ioctl.c     |  2 +-
 4 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 05df502c3c9d..e8ce86516ec8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3356,7 +3356,6 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     const bool new_inline,
 				     struct extent_map *em);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 29999686d234..d9c3b58b63bf 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1196,7 +1196,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     const bool new_inline,
 				     struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1248,10 +1247,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		 */
 		em->orig_start = EXTENT_MAP_HOLE;
 		em->block_len = (u64)-1;
-		if (!new_inline && compress_type != BTRFS_COMPRESS_NONE) {
+		em->compress_type = compress_type;
+		if (em->compress_type != BTRFS_COMPRESS_NONE)
 			set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
-			em->compress_type = compress_type;
-		}
 	} else {
 		btrfs_err(fs_info,
 			  "unknown file extent item type %d, inode %llu, offset %llu, "
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 10849db7f3a5..57fbd8665221 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6830,6 +6830,47 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	return ret;
 }
 
+/* To read the inline extent into the correct page position. */
+static int read_inline_extent(struct btrfs_inode *inode,
+			      struct btrfs_path *path,
+			      struct extent_map *em,
+			      struct page *page)
+{
+	struct btrfs_file_extent_item *fi;
+	u64 ram_bytes;
+	size_t copy_size;
+	void *kaddr;
+	int ret;
+
+	if (!page || PageUptodate(page))
+		return 0;
+
+	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+
+	if (btrfs_file_extent_compression(path->nodes[0], fi)) {
+		ret = uncompress_inline(path, page, 0, 0, fi);
+		if (ret < 0)
+			return ret;
+		flush_dcache_page(page);
+		return 0;
+	}
+
+	ram_bytes = btrfs_file_extent_ram_bytes(path->nodes[0], fi);
+	copy_size = min_t(u64, PAGE_SIZE, ram_bytes);
+
+
+	kaddr = kmap_local_page(page);
+	read_extent_buffer(path->nodes[0], kaddr,
+			   btrfs_file_extent_inline_start(fi), copy_size);
+	kunmap_local(kaddr);
+	/* Zero the remaining part inside the page. */
+	if (copy_size < PAGE_SIZE)
+		memzero_page(page, copy_size, PAGE_SIZE - copy_size);
+	flush_dcache_page(page);
+	return 0;
+}
+
 /**
  * btrfs_get_extent - Lookup the first extent overlapping a range in a file.
  * @inode:	file to search in
@@ -6982,51 +7023,25 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 
-	btrfs_extent_item_to_extent_map(inode, path, item, !page, em);
+	btrfs_extent_item_to_extent_map(inode, path, item, em);
 
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		goto insert;
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		unsigned long ptr;
-		char *map;
-		size_t size;
-		size_t extent_offset;
-		size_t copy_size;
-
-		if (!page)
-			goto out;
-
-		size = btrfs_file_extent_ram_bytes(leaf, item);
-		extent_offset = page_offset(page) + pg_offset - extent_start;
-		copy_size = min_t(u64, PAGE_SIZE - pg_offset,
-				  size - extent_offset);
-		em->start = extent_start + extent_offset;
-		em->len = ALIGN(copy_size, fs_info->sectorsize);
-		em->orig_block_len = em->len;
-		em->orig_start = em->start;
-		ptr = btrfs_file_extent_inline_start(item) + extent_offset;
-
-		if (!PageUptodate(page)) {
-			if (btrfs_file_extent_compression(leaf, item) !=
-			    BTRFS_COMPRESS_NONE) {
-				ret = uncompress_inline(path, page, pg_offset,
-							extent_offset, item);
-				if (ret)
-					goto out;
-			} else {
-				map = kmap_local_page(page);
-				read_extent_buffer(leaf, map + pg_offset, ptr,
-						   copy_size);
-				if (pg_offset + copy_size < PAGE_SIZE) {
-					memset(map + pg_offset + copy_size, 0,
-					       PAGE_SIZE - pg_offset -
-					       copy_size);
-				}
-				kunmap_local(map);
-			}
-			flush_dcache_page(page);
+		/*
+		 * If there is an inline extent, the file offset,
+		 * page_offset(), and @pg_offset must all be zero,
+		 * as inline extent can only exist at file offset 0.
+		 */
+		ASSERT(em->start == 0);
+		if (page) {
+			ASSERT(page_offset(page) == 0);
+			ASSERT(pg_offset == 0);
 		}
+		ret = read_inline_extent(inode, path, em, page);
+		if (ret < 0)
+			goto out;
 		goto insert;
 	}
 not_found:
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe0cc816b4eb..a623bd37d010 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1159,7 +1159,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto next;
 
 		/* Now this extent covers @start, convert it to em */
-		btrfs_extent_item_to_extent_map(inode, &path, fi, false, em);
+		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
 		break;
 next:
 		ret = btrfs_next_item(root, &path);
-- 
2.37.3

