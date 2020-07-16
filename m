Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40330221D84
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGPHgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 03:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPHgb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 03:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3B49AF43
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 07:36:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: Fix data leakage caused by falloc and truncate
Date:   Thu, 16 Jul 2020 15:36:24 +0800
Message-Id: <20200716073624.7774-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running tests like generic/013 on test device with btrfs quota
enabled, it can normally lead to data leakage, detected at unmount time:

  BTRFS warning (device dm-3): qgroup 0/5 has unreleased space, type 0 rsv 4096
  ------------[ cut here ]------------
  WARNING: CPU: 11 PID: 16386 at fs/btrfs/disk-io.c:4142 close_ctree+0x1dc/0x323 [btrfs]
  RIP: 0010:close_ctree+0x1dc/0x323 [btrfs]
  Call Trace:
   btrfs_put_super+0x15/0x17 [btrfs]
   generic_shutdown_super+0x72/0x110
   kill_anon_super+0x18/0x30
   btrfs_kill_super+0x17/0x30 [btrfs]
   deactivate_locked_super+0x3b/0xa0
   deactivate_super+0x40/0x50
   cleanup_mnt+0x135/0x190
   __cleanup_mnt+0x12/0x20
   task_work_run+0x64/0xb0
   __prepare_exit_to_usermode+0x1bc/0x1c0
   __syscall_return_slowpath+0x47/0x230
   do_syscall_64+0x64/0xb0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ---[ end trace caf08beafeca2392 ]---
  BTRFS error (device dm-3): qgroup reserved space leaked

[CAUSE]
In the offending case, the offending operations are:
2/6: writev f2X[269 1 0 0 0 0] [1006997,67,288] 0
2/7: truncate f2X[269 1 0 0 48 1026293] 18388 0

The first writev will cause btrfs to reserve space for range
[980K, 980K + 24K).

Then the next truncate should free all the reserved qgroup data space of
that range.

However if memory cleaning writeback happens for the first page of that
extent, then that page can have dirty bit cleaned, thus the
btrfs_qgroup_free_data() call in btrfs_invalidatepage() will skip it as
it's not a dirty page.

[FIX]
Instead of checking the dirty bit of a page, call
btrfs_qgroup_free_data() unconditionally in btrfs_invalidatepage().

As qgroup rsv are completely binded to the QGROUP_RESERVED bit of
io_tree, not binded to page status, thus we won't cause double freeing
anyway.

Fixes: 0b34c261e235 ("btrfs: qgroup: Prevent qgroup->reserved from going subzero")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7c03b402529e..0c9251b500b6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8157,21 +8157,15 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	/*
 	 * Qgroup reserved space handler
 	 * Page here will be either
-	 * 1) Already written to disk
+	 * 1) Already written to disk or ordered extent already submitted
 	 *    In this case, its reserved space is released from data rsv map
 	 *    and will be freed by delayed_ref handler finally.
 	 *    So even we call qgroup_free_data(), it won't decrease reserved
 	 *    space.
 	 * 2) Not written to disk
-	 *    This means the reserved space should be freed here. However,
-	 *    if a truncate invalidates the page (by clearing PageDirty)
-	 *    and the page is accounted for while allocating extent
-	 *    in btrfs_check_data_free_space() we let delayed_ref to
-	 *    free the entire extent.
+	 *    This means the reserved space should be freed here.
 	 */
-	if (PageDirty(page))
-		btrfs_qgroup_free_data(BTRFS_I(inode), NULL, page_start,
-				       PAGE_SIZE);
+	btrfs_qgroup_free_data(BTRFS_I(inode), NULL, page_start, PAGE_SIZE);
 	if (!inode_evicting) {
 		clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-- 
2.27.0

