Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBCCAFF44
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfIKOzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 10:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfIKOzq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 10:55:46 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9792085B
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568213745;
        bh=L6F//hlfflkfOfFl3oPlSN7K8JvFBCgjpr8mFvpdGoI=;
        h=From:To:Subject:Date:From;
        b=BvRzjFqmW93gCXae4FHnVMZFT6vJgUKM6O8a/LoMLDYw4o3sBO5VIfcgnxVt61UEk
         ESczRFJ04cXNJ+ujgS8pAOG9I5NkfD62zeeJAPntzFrDvKgP6AR5Oro9HY59zUVaKP
         nczbgAPQwYoFTERX6ElJUgKCGbpCeo0Y2CQdFpsU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix unwritten extent buffers and hangs on future writeback attempts
Date:   Wed, 11 Sep 2019 15:55:42 +0100
Message-Id: <20190911145542.1125-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The lock_extent_buffer_io() returns 1 to the caller to tell it everything
went fine and the callers needs to start writeback for the extent buffer
(submit a bio, etc), 0 to tell the caller everything went fine but it does
not need to start writeback for the extent buffer, and a negative value if
some error happened.

When it's about to return 1 it tries to lock all pages, and if a try lock
on a page fails, and we didn't flush any existing bio in our "epd", it
calls flush_write_bio(epd) and overwrites the return value of 1 to 0 or
an error. The page might have been locked elsewhere, not with the goal
of starting writeback of the extent buffer, and even by some code other
than btrfs, like page migration for example, so it does not mean the
writeback of the extent buffer was already started by some other task,
so returning a 0 tells the caller (btree_write_cache_pages()) to not
start writeback for the extent buffer. Note that epd might currently have
either no bio, so flush_write_bio() returns 0 (success) or it might have
a bio for another extent buffer with a lower index (logical address).

Since we return 0 with the EXTENT_BUFFER_WRITEBACK bit set on the
extent buffer and writeback is never started for the extent buffer,
future attempts to writeback the extent buffer will hang forever waiting
on that bit to be cleared, since it can only be cleared after writeback
completes. Such hang is reported with a trace like the following:

  [49887.347053] INFO: task btrfs-transacti:1752 blocked for more than 122 seconds.
  [49887.347059]       Not tainted 5.2.13-gentoo #2
  [49887.347060] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [49887.347062] btrfs-transacti D    0  1752      2 0x80004000
  [49887.347064] Call Trace:
  [49887.347069]  ? __schedule+0x265/0x830
  [49887.347071]  ? bit_wait+0x50/0x50
  [49887.347072]  ? bit_wait+0x50/0x50
  [49887.347074]  schedule+0x24/0x90
  [49887.347075]  io_schedule+0x3c/0x60
  [49887.347077]  bit_wait_io+0x8/0x50
  [49887.347079]  __wait_on_bit+0x6c/0x80
  [49887.347081]  ? __lock_release.isra.29+0x155/0x2d0
  [49887.347083]  out_of_line_wait_on_bit+0x7b/0x80
  [49887.347084]  ? var_wake_function+0x20/0x20
  [49887.347087]  lock_extent_buffer_for_io+0x28c/0x390
  [49887.347089]  btree_write_cache_pages+0x18e/0x340
  [49887.347091]  do_writepages+0x29/0xb0
  [49887.347093]  ? kmem_cache_free+0x132/0x160
  [49887.347095]  ? convert_extent_bit+0x544/0x680
  [49887.347097]  filemap_fdatawrite_range+0x70/0x90
  [49887.347099]  btrfs_write_marked_extents+0x53/0x120
  [49887.347100]  btrfs_write_and_wait_transaction.isra.4+0x38/0xa0
  [49887.347102]  btrfs_commit_transaction+0x6bb/0x990
  [49887.347103]  ? start_transaction+0x33e/0x500
  [49887.347105]  transaction_kthread+0x139/0x15c

So fix this by not overwriting the return value (ret) with the result
from flush_write_bio(). We also need to clear the EXTENT_BUFFER_WRITEBACK
bit in case flush_write_bio() returns an error, otherwise it will hang
any future attempts to writeback the extent buffer.

This is a regression introduced in the 5.2 kernel.

Fixes: 2e3c25136adfb ("btrfs: extent_io: add proper error handling to lock_extent_buffer_for_io()")
Fixes: f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in flush_write_bio() one level up")
Reported-by: Zdenek Sojka <zsojka@seznam.cz>
Link: https://lore.kernel.org/linux-btrfs/GpO.2yos.3WGDOLpx6t%7D.1TUDYM@seznam.cz/T/#u
Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Link: https://lore.kernel.org/linux-btrfs/5c4688ac-10a7-fb07-70e8-c5d31a3fbb38@profihost.ag/T/#t
Reported-by: Drazen Kacar <drazen.kacar@oradian.com>
Link: https://lore.kernel.org/linux-btrfs/DB8PR03MB562876ECE2319B3E579590F799C80@DB8PR03MB5628.eurprd03.prod.outlook.com/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204377
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ff438fd5bc2..1311ba0fc031 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3628,6 +3628,13 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
 		       TASK_UNINTERRUPTIBLE);
 }
 
+static void end_extent_buffer_writeback(struct extent_buffer *eb)
+{
+	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
+	smp_mb__after_atomic();
+	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
+}
+
 /*
  * Lock eb pages and flush the bio if we can't the locks
  *
@@ -3699,8 +3706,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 		if (!trylock_page(p)) {
 			if (!flush) {
-				ret = flush_write_bio(epd);
-				if (ret < 0) {
+				int err;
+
+				err = flush_write_bio(epd);
+				if (err < 0) {
+					ret = err;
 					failed_page_nr = i;
 					goto err_unlock;
 				}
@@ -3715,16 +3725,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	/* Unlock already locked pages */
 	for (i = 0; i < failed_page_nr; i++)
 		unlock_page(eb->pages[i]);
+	/* Clear EXTENT_BUFFER_WRITEBACK and wake up anyone waiting on it. */
+	end_extent_buffer_writeback(eb);
 	return ret;
 }
 
-static void end_extent_buffer_writeback(struct extent_buffer *eb)
-{
-	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
-	smp_mb__after_atomic();
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
-}
-
 static void set_btree_ioerr(struct page *page)
 {
 	struct extent_buffer *eb = (struct extent_buffer *)page->private;
-- 
2.11.0

