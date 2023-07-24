Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7132E75F9B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGXOWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjGXOWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FEAB7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nmuhtZoGLRIjF7U6JdFSvOOnfV2Ls5UB4SJyqThOUok=; b=CYroLKFjtWidxe5EWLM82xWguC
        57dwuifZQBOqkwMI6LNRe/7NCXqPK3aIIhxU9tp7IHFAZl231TKK0YoZ1h1lEhKGXqZObHB8OqLNX
        P2cJlFotW2Mg2zJqQ/vwZwmXomT+P0+c4x6jY9voQFLBsIxB4Jck/Is38yVI9d5QV8AzYkpZeeWLm
        /atjEmHWap7w/OCKvqW9TE2bt9VF4A3xTv+qeXfHdtxH608yMWG4PWrcDYErM0UOVHR/WhCsc5+Le
        6FvXtZd4R/31jcrDpUtPqpy16VMrW+6/D8bFd2IIVV9Rkz3w4oeJ0hgk890EpHbNzMnEkLNs0JRqg
        fp5lO9Rw==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSS-004bA4-2C;
        Mon, 24 Jul 2023 14:22:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: clone relocation checksums in btrfs_alloc_ordered_extent
Date:   Mon, 24 Jul 2023 07:22:43 -0700
Message-Id: <20230724142243.5742-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
References: <20230724142243.5742-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error handling for btrfs_reloc_clone_csums is a royal pain.  That is
not because btrfs_reloc_clone_csums does something particularly nasty:
the only failure can come from looking up the csums in the csum tree -
instead it is because btrfs_reloc_clone_csums is called after
btrfs_alloc_ordered_extent because it adds those founds csums to the
list in the ordred extent, and cleaning up after an ordered extent
has been added to the lookup data structures is very cumbersome.

Fix this by calling btrfs_reloc_clone_csums in
btrfs_alloc_ordered_extent after allocting the ordered extents, but
before making it reachable by the wider word and thus bypassing the
complex ordered extent removal path entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        | 44 -----------------------------------------
 fs/btrfs/ordered-data.c | 24 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index caaf2c002d795d..7864cae3ee2094 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1435,26 +1435,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
 		}
-
-		if (btrfs_is_data_reloc_root(root)) {
-			ret = btrfs_reloc_clone_csums(ordered);
-
-			/*
-			 * Only drop cache here, and process as normal.
-			 *
-			 * We must not allow extent_clear_unlock_delalloc()
-			 * at out_unlock label to free meta of this ordered
-			 * extent, as its meta should be freed by
-			 * btrfs_finish_ordered_io().
-			 *
-			 * So we must continue until @start is increased to
-			 * skip current ordered extent.
-			 */
-			if (ret)
-				btrfs_drop_extent_map_range(inode, start,
-							    start + ram_size - 1,
-							    false);
-		}
 		btrfs_put_ordered_extent(ordered);
 
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -1481,14 +1461,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		alloc_hint = ins.objectid + ins.offset;
 		start += cur_alloc_size;
 		extent_reserved = false;
-
-		/*
-		 * btrfs_reloc_clone_csums() error, since start is increased
-		 * extent_clear_unlock_delalloc() at out_unlock label won't
-		 * free metadata of current ordered extent, we're OK to exit.
-		 */
-		if (ret)
-			goto out_unlock;
 	}
 done:
 	if (done_offset)
@@ -2171,14 +2143,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			ret = PTR_ERR(ordered);
 			goto error;
 		}
-
-		if (btrfs_is_data_reloc_root(root))
-			/*
-			 * Error handled later, as we must prevent
-			 * extent_clear_unlock_delalloc() in error handler
-			 * from freeing metadata of created ordered extent.
-			 */
-			ret = btrfs_reloc_clone_csums(ordered);
 		btrfs_put_ordered_extent(ordered);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
@@ -2188,14 +2152,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
 
 		cur_offset = nocow_end + 1;
-
-		/*
-		 * btrfs_reloc_clone_csums() error, now we're OK to call error
-		 * handler, as metadata for created ordered extent will only
-		 * be freed by btrfs_finish_ordered_io().
-		 */
-		if (ret)
-			goto error;
 		if (cur_offset > end)
 			break;
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 109e80ed25b669..caa5dbf48db572 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -18,6 +18,7 @@
 #include "delalloc-space.h"
 #include "qgroup.h"
 #include "subpage.h"
+#include "relocation.h"
 #include "file.h"
 #include "super.h"
 
@@ -274,8 +275,27 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 	entry = alloc_ordered_extent(inode, file_offset, num_bytes, ram_bytes,
 				     disk_bytenr, disk_num_bytes, offset, flags,
 				     compress_type);
-	if (!IS_ERR(entry))
-		insert_ordered_extent(entry);
+	if (IS_ERR(entry))
+		return entry;
+
+	/*
+	 * Writes to relocation roots are special, and clones the existing csums
+	 * from the csum tree instead of calculating them.
+	 *
+	 * Clone the csums here so that the ordered extent never gets inserted
+	 * into the per-inode ordered extent tree and per-root list on failure.
+	 */
+	if (btrfs_is_data_reloc_root(inode->root)) {
+		int ret;
+
+		ret = btrfs_reloc_clone_csums(entry);
+		if (ret) {
+			kmem_cache_free(btrfs_ordered_extent_cache, entry);
+			return ERR_PTR(ret);
+		}
+	}
+
+	insert_ordered_extent(entry);
 	return entry;
 }
 
-- 
2.39.2

