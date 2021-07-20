Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FACC3CF91A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhGTLGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 07:06:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37628 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhGTLFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 07:05:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98DE12246F
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626781552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oGY9979LeVJMzZJKeCm5LnKCbjGsKzpDAR5y+LppNvY=;
        b=TQTHx8HflkUlIdGDKPynSqASc45DZG4Q4ffcctFGh/zrkPv/20u7QTpvSf53vovtrGPZB5
        nJSDFOuLBpOx4od3DUH0Kt/zDehY8moO7mJgZy82LvyQxBAtODiEkRG9Kc3v/m21q4+i66
        OZ+AL8pdQNZQQn8t3PZzPELzX65im4U=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BF2F013AB8
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 11:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id sC5kHm+39mDiUAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 11:45:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make __extent_writepage() not return error if the page is marked error
Date:   Tue, 20 Jul 2021 19:45:48 +0800
Message-Id: <20210720114548.322356-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/160 in a loop for subpage with experimental
compression support, it has a high chance to crash (~20%):

 BTRFS critical (device dm-7): panic in __btrfs_add_ordered_extent:238: inconsistency in ordered tree at offset 0 (errno=-17 Object already exists)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ordered-data.c:238!
 Internal error: Oops - BUG: 0 [#1] SMP
 pc : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
 lr : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
 Call trace:
  __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
  btrfs_add_ordered_extent+0x2c/0x50 [btrfs]
  run_delalloc_nocow+0x81c/0x8fc [btrfs]
  btrfs_run_delalloc_range+0xa4/0x390 [btrfs]
  writepage_delalloc+0xc0/0x1ac [btrfs]
  __extent_writepage+0xf4/0x370 [btrfs]
  extent_write_cache_pages+0x288/0x4f4 [btrfs]
  extent_writepages+0x58/0xe0 [btrfs]
  btrfs_writepages+0x1c/0x30 [btrfs]
  do_writepages+0x60/0x110
  __filemap_fdatawrite_range+0x108/0x170
  filemap_fdatawrite_range+0x20/0x30
  btrfs_fdatawrite_range+0x34/0x4dc [btrfs]
  __btrfs_write_out_cache+0x34c/0x480 [btrfs]
  btrfs_write_out_cache+0x144/0x220 [btrfs]
  btrfs_start_dirty_block_groups+0x3ac/0x6b0 [btrfs]
  btrfs_commit_transaction+0xd0/0xbb4 [btrfs]
  btrfs_sync_fs+0x64/0x1cc [btrfs]
  sync_fs_one_sb+0x3c/0x50
  iterate_supers+0xcc/0x1d4
  ksys_sync+0x6c/0xd0
  __arm64_sys_sync+0x1c/0x30
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0x4c/0xd4
  do_el0_svc+0x30/0x9c
  el0_svc+0x2c/0x54
  el0_sync_handler+0x1a8/0x1b0
  el0_sync+0x198/0x1c0
 ---[ end trace 336f67369ae6e0af ]---

[CAUSE]
For subpage case, we can have multiple sectors inside a page, this makes
it possible for __extent_writepage() to have part of its page submitted
before returning.

In btrfs/160, we are using dm-dust to emulate write error, this means
for certain pages, we could have everything running fine, but at the end
of __extent_writepage(), one of the submitted bios fails due to dm-dust.

Then the page is marked Error, and we change @ret from 0 to -EIO.

This makes the caller extent_write_cache_pages() to error out, without
submitting the remaining pages.

Furthermore, since we're erroring out for free space cache, it doesn't
really care about the error and will update the inode and retry the
writeback.

Then we re-run the delalloc range, and will try to insert the same
delalloc range while previous delalloc range is still hanging there,
triggering the above error.

[FIX]
Ironically, to fix the problem we need to ignore the PageError() part,
at least not to populate @ret.

By this, we fallback to the same behavior of non-subpage case, continue
to submit the remaining pages so that the ordered extent can finish.

The failed bio will still mark the page error and properly inform the
caller that some IO failed, we just don't need to bother the IO error so
early.

Since we're here, also convert the PageError() macros to subpage
compatible helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fff1a4d8fe25..237824caaa84 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3815,7 +3815,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
 				delalloc_end, &page_started, nr_written, wbc);
 		if (ret) {
-			SetPageError(page);
+			btrfs_page_set_error(inode->root->fs_info, page,
+					     page_offset(page), PAGE_SIZE);
 			/*
 			 * btrfs_run_delalloc_range should return < 0 for error
 			 * but just in case, we use > 0 here meaning the IO is
@@ -4092,7 +4093,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 
 	WARN_ON(!PageLocked(page));
 
-	ClearPageError(page);
+	btrfs_page_clear_error(fs_info, page, page_offset(page), PAGE_SIZE);
 
 	pg_offset = offset_in_page(i_size);
 	if (page->index > end_index ||
@@ -4133,10 +4134,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	if (PageError(page)) {
-		ret = ret < 0 ? ret : -EIO;
+	if (PageError(page))
 		end_extent_writepage(page, ret, page_start, page_end);
-	}
 	if (epd->extent_locked) {
 		/*
 		 * If epd->extent_locked, it's from extent_write_locked_range(),
-- 
2.32.0

