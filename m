Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1500D38FA45
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhEYFyS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 01:54:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhEYFyS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 01:54:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621921968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LbRzLbsKLrVQc77FU915FrS7vlVj0Gu8QjIJ5L9EZ4c=;
        b=etPfM3AeyHK6kAgYJQRyWmrRC8dun35NAabGVciACXsPyIM7iITG0zmQvK5QPBesAp2NFp
        BC8ZkxKvbeCSTRBWA35h/KFjuK6N+0RwBJoz/96Z7WzmlgLaS8DC14iD9b3Ar9/xpoGT+J
        OZgIJSgKHqHBCvOeiBcQmBtplDyZ7X0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1042CAE72;
        Tue, 25 May 2021 05:52:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: fix a bug where a compressed write can cross stripe boundary
Date:   Tue, 25 May 2021 13:52:43 +0800
Message-Id: <20210525055243.85166-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/027 with "-o compress" mount option, it always crash
with the following call trace:

  BTRFS critical (device dm-4): mapping failed logical 298901504 bio len 12288 len 8192
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/volumes.c:6651!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 5 PID: 31089 Comm: kworker/u24:10 Tainted: G           OE     5.13.0-rc2-custom+ #26
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
  RIP: 0010:btrfs_map_bio.cold+0x58/0x5a [btrfs]
  Call Trace:
   btrfs_submit_compressed_write+0x2d7/0x470 [btrfs]
   submit_compressed_extents+0x3b0/0x470 [btrfs]
   ? mark_held_locks+0x49/0x70
   btrfs_work_helper+0x131/0x3e0 [btrfs]
   process_one_work+0x28f/0x5d0
   worker_thread+0x55/0x3c0
   ? process_one_work+0x5d0/0x5d0
   kthread+0x141/0x160
   ? __kthread_bind_mask+0x60/0x60
   ret_from_fork+0x22/0x30
  ---[ end trace 63113a3a91f34e68 ]---

[CAUSE]
The critical message before the crash means we have a bio at logical
bytenr 298901504 length 12288, but only 8192 bytes can fit into one
stripe, the remaining 4096 bytes is into another stripe.

In btrfs, all bio is properly split to avoid cross stripe boundary, but
commit 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
changed the behavior for compressed write.

The offending code looks like this:

                        submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
                                                          0);

+               if (pg_index == 0 && use_append)
+                       len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
+               else
+                       len = bio_add_page(bio, page, PAGE_SIZE, 0);
+
                page->mapping = NULL;
-               if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
-                   PAGE_SIZE) {
+               if (submit || len < PAGE_SIZE) {

Previously if we find our new page can't be fitted into current stripe,
aka "submitted == 1" case, we submit current bio without adding current
page.

But after the modification, we will add the page no matter if it crosses
stripe boundary, leading to the above crash.

[FIX]
It's no longer possible to revert to the original code style as we have
two different bio_add_*_page() calls now.

The new fix is to skip the bio_add_*_page() call if @submit is true.

Also to avoid @len to be uninitialized, always initialize it to zero.

If @submit is true, @len will not be checked.
If @submit is not true, @len will be the return value of
bio_add_*_page() call.
Either way, the behavior is still the same as the old code.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d17ac301032e..1346d698463a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -457,7 +457,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	bytes_left = compressed_len;
 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
 		int submit = 0;
-		int len;
+		int len = 0;
 
 		page = compressed_pages[pg_index];
 		page->mapping = inode->vfs_inode.i_mapping;
@@ -465,10 +465,17 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
 							  0);
 
-		if (pg_index == 0 && use_append)
-			len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
-		else
-			len = bio_add_page(bio, page, PAGE_SIZE, 0);
+		/*
+		 * Page can only be added to bio if the current bio fits in
+		 * stripe.
+		 */
+		if (!submit) {
+			if (pg_index == 0 && use_append)
+				len = bio_add_zone_append_page(bio, page,
+							       PAGE_SIZE, 0);
+			else
+				len = bio_add_page(bio, page, PAGE_SIZE, 0);
+		}
 
 		page->mapping = NULL;
 		if (submit || len < PAGE_SIZE) {
-- 
2.31.1

