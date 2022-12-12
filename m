Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9964995E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiLLHMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiLLHMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:12:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CFBF78
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ta5y5TkY0hEbGhb0D0oJYKsqFHHK06N+JvW98p9Il84=; b=LByPilzcEyB02fJJXX0YoNqqdN
        r4irltxj8L333IVEATEuR77H+xCr5bwuhMHQzX8VdZEcJp9z8GmpdMlKjH0+4rO79CLrRPu068P3J
        mrYc0FvmjH+5xi7+vqbaT6JolfjEYg7a8XQrtGosOpE8f0P4ytWFdXTOeKHOJ6YFTKccD8qG2GjJs
        /OZNGLEJb+NsuIgC2YnU4B6F7oU+ANjlPEWUF+A4A2/qM6frjFMm1sYoydO+Xa3P8WJDwUUrOxa0R
        PA50pZSkbJVgp2OnGRBAo8UcuGdkBNZ/dWwl0QKpt8B8H+e7qOrTanDvVvFbBiAlN9HSPR9sBBpUj
        +/cCkQFQ==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4czV-009Hha-6y; Mon, 12 Dec 2022 07:12:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the wait argument to btrfs_start_ordered_extent
Date:   Mon, 12 Dec 2022 08:12:43 +0100
Message-Id: <20221212071243.7418-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Given that wait is always set to 1, so remove the argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/defrag.c       |  2 +-
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  8 ++++----
 fs/btrfs/ordered-data.c | 25 +++++++++++--------------
 fs/btrfs/ordered-data.h |  2 +-
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 0a3c261b69c9f9..fa69e00fb517a1 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -763,7 +763,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 			break;
 
 		unlock_page(page);
-		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		lock_page(page);
 		/*
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 91b00eb2440e7d..c41c519ca7c44d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1017,7 +1017,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 				unlock_page(pages[i]);
 				put_page(pages[i]);
 			}
-			btrfs_start_ordered_extent(ordered, 1);
+			btrfs_start_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 905ea19df125bc..f56961dd5d1498 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2969,7 +2969,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		unlock_extent(&inode->io_tree, page_start, page_end,
 			      &cached_state);
 		unlock_page(page);
-		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -4987,7 +4987,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		unlock_page(page);
 		put_page(page);
-		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -7392,7 +7392,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 */
 			if (writing ||
 			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
-				btrfs_start_ordered_extent(ordered, 1);
+				btrfs_start_ordered_extent(ordered);
 			else
 				ret = nowait ? -EAGAIN : -ENOTBLK;
 			btrfs_put_ordered_extent(ordered);
@@ -8552,7 +8552,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		unlock_page(page);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
-		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4bed0839b64033..ab1cbb3f554617 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -616,7 +616,7 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
 	struct btrfs_ordered_extent *ordered;
 
 	ordered = container_of(work, struct btrfs_ordered_extent, flush_work);
-	btrfs_start_ordered_extent(ordered, 1);
+	btrfs_start_ordered_extent(ordered);
 	complete(&ordered->completion);
 }
 
@@ -716,13 +716,12 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 }
 
 /*
- * Used to start IO or wait for a given ordered extent to finish.
+ * Used to start IO and wait for a given ordered extent to finish.
  *
- * If wait is one, this effectively waits on page writeback for all the pages
- * in the extent, and it waits on the io completion code to insert
- * metadata into the btree corresponding to the extent
+ * Wait on page writeback for all the pages in the extent and the IO completion
+ * code to insert metadata into the btree corresponding to the extent.
  */
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry, int wait)
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
 {
 	u64 start = entry->file_offset;
 	u64 end = start + entry->num_bytes - 1;
@@ -744,12 +743,10 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry, int wait)
 	 */
 	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
 		filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
-	if (wait) {
-		if (!freespace_inode)
-			btrfs_might_wait_for_event(inode->root->fs_info, btrfs_ordered_extent);
-		wait_event(entry->wait, test_bit(BTRFS_ORDERED_COMPLETE,
-						 &entry->flags));
-	}
+
+	if (!freespace_inode)
+		btrfs_might_wait_for_event(inode->root->fs_info, btrfs_ordered_extent);
+	wait_event(entry->wait, test_bit(BTRFS_ORDERED_COMPLETE, &entry->flags));
 }
 
 /*
@@ -800,7 +797,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
-		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_start_ordered_extent(ordered);
 		end = ordered->file_offset;
 		/*
 		 * If the ordered extent had an error save the error but don't
@@ -1061,7 +1058,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 			break;
 		}
 		unlock_extent(&inode->io_tree, start, end, cachedp);
-		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 89f82b78f590f3..ae3ed748acaf66 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -187,7 +187,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry, int wait);
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
 int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
-- 
2.35.1

