Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1588360173
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhDOFGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhDOFGY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DXMUSk8Y9mxZm99ReClLnFpbTdLFbThdJnzVzo/G8c=;
        b=BZCta9l2L+0Jv3GbJOK7LC0RsXfZ2fBVs4k+JIIlsbh2dpP9KsNvLFz5d667SUmWtaVMM4
        34ebSGGo1uOcnM/Vg/rPt6qEw+uu5QqPdorfpmjFmN9dpVhD3hm2+jAU7K/Le0GuEy8z/5
        UIQnzsz9QOdw6xtmnMr3XbK5HSrVIKM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 476F4AF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:06:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 36/42] btrfs: fix wild subpage writeback which does not have ordered extent.
Date:   Thu, 15 Apr 2021 13:04:42 +0800
Message-Id: <20210415050448.267306-37-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running fsstress with subpage RW support, there are random
BUG_ON()s triggered with the following trace:

 kernel BUG at fs/btrfs/file-item.c:667!
 Internal error: Oops - BUG: 0 [#1] SMP
 CPU: 1 PID: 3486 Comm: kworker/u13:2 Tainted: G        WC O      5.11.0-rc4-custom+ #43
 Hardware name: Radxa ROCK Pi 4B (DT)
 Workqueue: btrfs-worker-high btrfs_work_helper [btrfs]
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
 pc : btrfs_csum_one_bio+0x420/0x4e0 [btrfs]
 lr : btrfs_csum_one_bio+0x400/0x4e0 [btrfs]
 Call trace:
  btrfs_csum_one_bio+0x420/0x4e0 [btrfs]
  btrfs_submit_bio_start+0x20/0x30 [btrfs]
  run_one_async_start+0x28/0x44 [btrfs]
  btrfs_work_helper+0x128/0x1b4 [btrfs]
  process_one_work+0x22c/0x430
  worker_thread+0x70/0x3a0
  kthread+0x13c/0x140
  ret_from_fork+0x10/0x30

[CAUSE]
Above BUG_ON() means there are some bio range which doesn't have ordered
extent, which indeed is worthy a BUG_ON().

Unlike regular sectorsize == PAGE_SIZE case, in subpage we have extra
subpage dirty bitmap to record which range is dirty and should be
written back.

This means, if we submit bio for a subpage range, we do not only need to
clear page dirty, but also need to clear subpage dirty bits.

In __extent_writepage_io(), we will call btrfs_page_clear_dirty() for
any range we submit a bio.

But there is loophole, if we hit a range which is beyond isize, we just
call btrfs_writepage_endio_finish_ordered() to finish the ordered io,
then break out, without clearing the subpage dirty.

This means, if we hit above branch, the subpage dirty bits are still
there, if other range of the page get dirtied and we need to writeback
that page again, we will submit bio for the old range, leaving a wild
bio range which doesn't have ordered extent.

[FIX]
Fix it by always calling btrfs_page_clear_dirty() in
__extent_writepage_io().

Also to avoid such problem from happening again, add a new assert,
btrfs_page_assert_not_dirty(), to make sure both page dirty and subpage
dirty bits are cleared before exiting __extent_writepage_io().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++++++++++++++
 fs/btrfs/subpage.c   | 16 ++++++++++++++++
 fs/btrfs/subpage.h   |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ae6357a6749e..152aface4eeb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3852,6 +3852,16 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		if (cur >= i_size) {
 			btrfs_writepage_endio_finish_ordered(inode, page, cur,
 							     end, 1);
+			/*
+			 * This range is beyond isize, thus we don't need to
+			 * bother writing back.
+			 * But we still need to clear the dirty subpage bit, or
+			 * the next time the page get dirtied, we will try to
+			 * writeback the sectors with subpage diryt bits,
+			 * causing writeback without ordered extent.
+			 */
+			btrfs_page_clear_dirty(fs_info, page, cur,
+					       end + 1 - cur);
 			break;
 		}
 
@@ -3902,6 +3912,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			else
 				btrfs_writepage_endio_finish_ordered(inode,
 						page, cur, cur + iosize - 1, 1);
+			btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 			cur += iosize;
 			continue;
 		}
@@ -3936,6 +3947,12 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		cur += iosize;
 		nr++;
 	}
+	/*
+	 * If we finishes without problem, we should not only clear page dirty,
+	 * but also emptied subpage dirty bits
+	 */
+	if (!ret)
+		btrfs_page_assert_not_dirty(fs_info, page);
 	*nr_ret = nr;
 	return ret;
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 516e0b3f2ed9..696485ab68a2 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -548,3 +548,19 @@ IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
 			 PageWriteback);
 IMPLEMENT_BTRFS_PAGE_OPS(ordered, SetPageOrdered, ClearPageOrdered,
 			 PageOrdered);
+
+void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
+				 struct page *page)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+
+	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
+		return;
+
+	ASSERT(!PageDirty(page));
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->private);
+	ASSERT(subpage->dirty_bitmap == 0);
+}
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 3419b152c00f..7188e9d2fbea 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -119,4 +119,11 @@ DECLARE_BTRFS_SUBPAGE_OPS(ordered);
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len);
 
+/*
+ * Extra assert to make sure not only the page dirty bit is cleared, but also
+ * subpage dirty bit is cleared.
+ */
+void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
+				 struct page *page);
+
 #endif
-- 
2.31.1

