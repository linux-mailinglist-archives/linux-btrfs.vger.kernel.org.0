Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D53D5334
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGZFy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 01:54:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhGZFyy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 01:54:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48E4021F10
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627281323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2mXTb/qj6s8bTEqo+yI8WqGrrNJJd9N/g5vPl7tlK2c=;
        b=hIsVu43JlJtzRUvi8eYBQYcwWBDV+3gT+wQPqui+0QQzHVBL/fMzU/4GhFZM96NpYCU8uH
        TEJI7lBiTyi6BB+lQaZOYM847mL0Jm92baDIQzuV7Q3hxD1+X7w6Gdl+sn/H08HuLICoFc
        XJE9a8Lr1Ro0DUokJ7mEZbrIf8B5wVw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7F20D1365C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2FoIEKpX/mCXBQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v8 09/18] btrfs: fix wild subpage writeback which does not have ordered extent.
Date:   Mon, 26 Jul 2021 14:34:58 +0800
Message-Id: <20210726063507.160396-10-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
References: <20210726063507.160396-1-wqu@suse.com>
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
 CPU: 1 PID: 3486 Comm: kworker/u13:2 5.11.0-rc4-custom+ #43
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
index a834ba61a729..a0e9af49a74f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3865,6 +3865,16 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
 
@@ -3915,6 +3925,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			else
 				btrfs_writepage_endio_finish_ordered(inode,
 						page, cur, cur + iosize - 1, 1);
+			btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 			cur += iosize;
 			continue;
 		}
@@ -3950,6 +3961,12 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
index 640bcd21bf28..b2bad9a0295f 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -559,3 +559,19 @@ IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
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
index 4d7aca85d915..9aa40d795ba9 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -126,4 +126,11 @@ DECLARE_BTRFS_SUBPAGE_OPS(ordered);
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
2.32.0

