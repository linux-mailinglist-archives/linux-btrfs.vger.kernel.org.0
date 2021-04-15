Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B8436015A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhDOFFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhDOFFg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMRKlPtWNS6PiMKYwooRQDL2akO4Rku7QGQmehoq2H8=;
        b=SzYCWA0LuFeztRu8cYCK7PrF423YFVYrZC8/y9kiD11josWC4evaksIdQUpmvGjzsQvq75
        GptwfIUl69JRoL/Nviva+sva5IkUkbFFJjUFicoCUd/5/ON7Y8eJr4QzPP3jE6DD10r5ui
        FsUbG8cW7xLQAZMm0dyLRrBSiDz4f48=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C177AF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/42] btrfs: refactor btrfs_invalidatepage()
Date:   Thu, 15 Apr 2021 13:04:17 +0800
Message-Id: <20210415050448.267306-12-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will refactor btrfs_invalidatepage() for the incoming subpage
support.

The invovled modifcations are:
- Use while() loop instead of "goto again;"
- Use single variable to determine whether to delete extent states
  Each branch will also have comments why we can or cannot delete the
  extent states
- Do qgroup free and extent states deletion per-loop
  Current code can only work for PAGE_SIZE == sectorsize case.

This refactor also makes it clear what we do for different sectors:
- Sectors without ordered extent
  We're completely safe to remove all extent states for the sector(s)

- Sectors with ordered extent, but no Private2 bit
  This means the endio has already been executed, we can't remove all
  extent states for the sector(s).

- Sectors with ordere extent, still has Private2 bit
  This means we need to decrease the ordered extent accounting.
  And then it comes to two different variants:
  * We have finished and removed the ordered extent
    Then it's the same as "sectors without ordered extent"
  * We didn't finished the ordered extent
    We can remove some extent states, but not all.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 173 +++++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4c894de2e813..93bb7c0482ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8320,15 +8320,12 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	struct extent_io_tree *tree = &inode->io_tree;
-	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	u64 page_start = page_offset(page);
 	u64 page_end = page_start + PAGE_SIZE - 1;
-	u64 start;
-	u64 end;
+	u64 cur;
+	u32 sectorsize = inode->root->fs_info->sectorsize;
 	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
-	bool found_ordered = false;
-	bool completed_ordered = false;
 
 	/*
 	 * We have page locked so no new ordered extent can be created on
@@ -8352,96 +8349,114 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	if (!inode_evicting)
 		lock_extent_bits(tree, page_start, page_end, &cached_state);
 
-	start = page_start;
-again:
-	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
-	if (ordered) {
-		found_ordered = true;
-		end = min(page_end,
-			  ordered->file_offset + ordered->num_bytes - 1);
+	cur = page_start;
+	while (cur < page_end) {
+		struct btrfs_ordered_extent *ordered;
+		bool delete_states = false;
+		u64 range_end;
+
+		/*
+		 * Here we can't pass "file_offset = cur" and
+		 * "len = page_end + 1 - cur", as btrfs_lookup_ordered_range()
+		 * may not return the first ordered extent after @file_offset.
+		 *
+		 * Here we want to iterate through the range in byte order.
+		 * This is slower but definitely correct.
+		 *
+		 * TODO: Make btrfs_lookup_ordered_range() to return the
+		 * first ordered extent in the range to reduce the number
+		 * of loops.
+		 */
+		ordered = btrfs_lookup_ordered_range(inode, cur, sectorsize);
+		if (!ordered) {
+			range_end = cur + sectorsize - 1;
+			/*
+			 * No ordered extent covering this sector, we are safe
+			 * to delete all extent states in the range.
+			 */
+			delete_states = true;
+			goto next;
+		}
+
+		range_end = min(ordered->file_offset + ordered->num_bytes - 1,
+				page_end);
+		if (!PagePrivate2(page)) {
+			/*
+			 * If Private2 is cleared, it means endio has already
+			 * been executed for the range.
+			 * We can't delete the extent states as
+			 * btrfs_finish_ordered_io() may still use some of them.
+			 */
+			delete_states = false;
+			goto next;
+		}
+		ClearPagePrivate2(page);
+
 		/*
 		 * IO on this page will never be started, so we need to account
 		 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
 		 * here, must leave that up for the ordered extent completion.
+		 *
+		 * This will also unlock the range for incoming
+		 * btrfs_finish_ordered_io().
 		 */
 		if (!inode_evicting)
-			clear_extent_bit(tree, start, end,
+			clear_extent_bit(tree, cur, range_end,
 					 EXTENT_DELALLOC |
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, 1, 0, &cached_state);
+
+		spin_lock_irq(&inode->ordered_tree.lock);
+		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+		ASSERT(cur - ordered->file_offset < U32_MAX);
+		ordered->truncated_len = min_t(u32, ordered->truncated_len,
+					       cur - ordered->file_offset);
+		spin_unlock_irq(&inode->ordered_tree.lock);
+
+		ASSERT(range_end + 1 - cur < U32_MAX);
+		if (btrfs_dec_test_ordered_pending(inode, &ordered,
+					cur, range_end + 1 - cur, 1)) {
+			btrfs_finish_ordered_io(ordered);
+			/*
+			 * The ordered extent has finished, now we're again
+			 * safe to delete all extent states of the range.
+			 */
+			delete_states = true;
+		} else {
+			/*
+			 * btrfs_finish_ordered_io() will get executed by endio of
+			 * other pages, thus we can't delete extent states any more
+			 */
+			delete_states = false;
+		}
+next:
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
 		/*
-		 * A page with Private2 bit means no bio has submitted covering
-		 * the page, thus we have to manually do the ordered extent
-		 * accounting.
+		 * Qgroup reserved space handler
+		 * Sector(s) here will be either
+		 * 1) Already written to disk or bio already finished
+		 *    Then its QGROUP_RESERVED bit in io_tree is already cleaned.
+		 *    Qgroup will be handled by its qgroup_record then.
+		 *    btrfs_qgroup_free_data() call will do nothing here.
 		 *
-		 * For page without Private2, the ordered extent accounting is
-		 * done in its endio function of the submitted bio.
+		 * 2) Not written to disk yet
+		 *    Then btrfs_qgroup_free_data() call will clear the
+		 *    QGROUP_RESERVED bit of its io_tree, and free the qgroup
+		 *    reserved data space.
+		 *    Since the IO will never happen for this page.
 		 */
-		if (TestClearPagePrivate2(page)) {
-			spin_lock_irq(&inode->ordered_tree.lock);
-			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-			ASSERT(start - ordered->file_offset < U32_MAX);
-			ordered->truncated_len = min_t(u32,
-						ordered->truncated_len,
-						start - ordered->file_offset);
-			spin_unlock_irq(&inode->ordered_tree.lock);
-
-			ASSERT(end - start + 1 < U32_MAX);
-			if (btrfs_dec_test_ordered_pending(inode, &ordered,
-							   start,
-							   end - start + 1, 1)) {
-				btrfs_finish_ordered_io(ordered);
-				completed_ordered = true;
-			}
-		}
-		btrfs_put_ordered_extent(ordered);
+		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
 		if (!inode_evicting) {
-			cached_state = NULL;
-			lock_extent_bits(tree, start, end,
-					 &cached_state);
-		}
-
-		start = end + 1;
-		if (start < page_end)
-			goto again;
-	}
-
-	/*
-	 * Qgroup reserved space handler
-	 * Page here will be either
-	 * 1) Already written to disk or ordered extent already submitted
-	 *    Then its QGROUP_RESERVED bit in io_tree is already cleaned.
-	 *    Qgroup will be handled by its qgroup_record then.
-	 *    btrfs_qgroup_free_data() call will do nothing here.
-	 *
-	 * 2) Not written to disk yet
-	 *    Then btrfs_qgroup_free_data() call will clear the QGROUP_RESERVED
-	 *    bit of its io_tree, and free the qgroup reserved data space.
-	 *    Since the IO will never happen for this page.
-	 */
-	btrfs_qgroup_free_data(inode, NULL, page_start, PAGE_SIZE);
-	if (!inode_evicting) {
-		bool delete = true;
-
-		/*
-		 * If there's an ordered extent for this range and we have not
-		 * finished it ourselves, we must leave EXTENT_DELALLOC_NEW set
-		 * in the range for the ordered extent completion. We must also
-		 * not delete the range, otherwise we would lose that bit (and
-		 * any other bits set in the range). Make sure EXTENT_UPTODATE
-		 * is cleared if we don't delete, otherwise it can lead to
-		 * corruptions if the i_size is extented later.
-		 */
-		if (found_ordered && !completed_ordered)
-			delete = false;
-		clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKED |
+			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
 				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1,
-				 delete, &cached_state);
-
-		__btrfs_releasepage(page, GFP_NOFS);
+				 delete_states, &cached_state);
+		}
+		cur = range_end + 1;
 	}
-
+	if (!inode_evicting)
+		__btrfs_releasepage(page, GFP_NOFS);
 	ClearPageChecked(page);
 	clear_page_extent_mapped(page);
 }
-- 
2.31.1

