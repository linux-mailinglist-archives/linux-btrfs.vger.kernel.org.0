Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49D26F90B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIRJQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 05:16:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:52218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIRJQA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 05:16:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600420555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=iFL9PArQFtqURZbGs7mt3E5r0bFS5g6AVoXchrn+jpg=;
        b=BoENPEXwnTMrurhx4xp3LiRzgpqFzKT5bpgGve+0xtO3XSXPd9KQB5D+KVXxCPsE+2zYrY
        aPXwHz0Qxt9IP55vAuC3/THzJuBKZUla7ZX6Xt2d/vl8o706ric/gp4QgMsHui3YbvO23P
        xbqItXUyiTM98n4i8d1xQ1E9HzqMc+M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1387AD63;
        Fri, 18 Sep 2020 09:16:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/5] btrfs: Remove inode argument from btrfs_start_ordered_extent
Date:   Fri, 18 Sep 2020 12:15:53 +0300
Message-Id: <20200918091553.29584-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918091553.29584-1-nborisov@suse.com>
References: <20200918091553.29584-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The passed in ordered_extent struct is always well-formed and contains
the inode making the explicit argument redundant.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c         |  3 +--
 fs/btrfs/inode.c        |  8 ++++----
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/ordered-data.c | 15 +++++++--------
 fs/btrfs/ordered-data.h |  3 +--
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2969d715c588..038e0afaf3d0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1491,8 +1491,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 				unlock_page(pages[i]);
 				put_page(pages[i]);
 			}
-			btrfs_start_ordered_extent(&inode->vfs_inode,
-					ordered, 1);
+			btrfs_start_ordered_extent(ordered, 1);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3e203d84d86d..9684d2a21986 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2343,7 +2343,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		unlock_extent_cached(&inode->io_tree, page_start, page_end,
 				     &cached_state);
 		unlock_page(page);
-		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
+		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -4567,7 +4567,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 				     &cached_state);
 		unlock_page(page);
 		put_page(page);
-		btrfs_start_ordered_extent(inode, ordered, 1);
+		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -7135,7 +7135,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 */
 			if (writing ||
 			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
-				btrfs_start_ordered_extent(inode, ordered, 1);
+				btrfs_start_ordered_extent(ordered, 1);
 			else
 				ret = -ENOTBLK;
 			btrfs_put_ordered_extent(ordered);
@@ -8310,7 +8310,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent_cached(io_tree, page_start, page_end,
 				     &cached_state);
 		unlock_page(page);
-		btrfs_start_ordered_extent(inode, ordered, 1);
+		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c57c02a61144..d9984fbfade3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1319,7 +1319,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 				break;
 
 			unlock_page(page);
-			btrfs_start_ordered_extent(inode, ordered, 1);
+			btrfs_start_ordered_extent(ordered, 1);
 			btrfs_put_ordered_extent(ordered);
 			lock_page(page);
 			/*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c93b4f2c778b..87bac9ecdf4c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -543,7 +543,7 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
 	struct btrfs_ordered_extent *ordered;
 
 	ordered = container_of(work, struct btrfs_ordered_extent, flush_work);
-	btrfs_start_ordered_extent(ordered->inode, ordered, 1);
+	btrfs_start_ordered_extent(ordered, 1);
 	complete(&ordered->completion);
 }
 
@@ -649,14 +649,13 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
  * in the extent, and it waits on the io completion code to insert
  * metadata into the btree corresponding to the extent
  */
-void btrfs_start_ordered_extent(struct inode *inode,
-				       struct btrfs_ordered_extent *entry,
-				       int wait)
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry, int wait)
 {
 	u64 start = entry->file_offset;
 	u64 end = start + entry->num_bytes - 1;
+	struct btrfs_inode *inode = BTRFS_I(entry->inode);
 
-	trace_btrfs_ordered_extent_start(BTRFS_I(inode), entry);
+	trace_btrfs_ordered_extent_start(inode, entry);
 
 	/*
 	 * pages in the range can be dirty, clean or writeback.  We
@@ -664,7 +663,7 @@ void btrfs_start_ordered_extent(struct inode *inode,
 	 * for the flusher thread to find them
 	 */
 	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
-		filemap_fdatawrite_range(inode->i_mapping, start, end);
+		filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
 	if (wait) {
 		wait_event(entry->wait, test_bit(BTRFS_ORDERED_COMPLETE,
 						 &entry->flags));
@@ -719,7 +718,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
-		btrfs_start_ordered_extent(inode, ordered, 1);
+		btrfs_start_ordered_extent(ordered, 1);
 		end = ordered->file_offset;
 		/*
 		 * If the ordered extent had an error save the error but don't
@@ -939,7 +938,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 			break;
 		}
 		unlock_extent_cached(&inode->io_tree, start, end, cachedp);
-		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
+		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 8fe720da0b31..c3a2325e64a4 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -174,8 +174,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
-void btrfs_start_ordered_extent(struct inode *inode,
-				struct btrfs_ordered_extent *entry, int wait);
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry, int wait);
 int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
-- 
2.17.1

