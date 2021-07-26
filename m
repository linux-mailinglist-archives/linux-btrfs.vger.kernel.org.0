Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A613D5944
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhGZLh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54730 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZLh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3230E21F7A;
        Mon, 26 Jul 2021 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrZZ5xljBDfXEWDjQ1HgMkAb9wg0m+cfhzUKW1wbQv8=;
        b=taBjX5y95EencnAerqvXbhYHoLWzn+CCpR1arZAM8Y6UTE2R3rnc+RT5+dC7kaPkf1MVut
        XgLw1Qh/uC01HVcKwHWTRGuPuV2H1uctFI1p+DYpc+1qkXXv/ypPm2sRs2sQXdpxCqW0ap
        27nyHFuvu2G+Rxh3b/XEmDeT0Nt4mz8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 29C5AA3BDF;
        Mon, 26 Jul 2021 12:17:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E208DA8D8; Mon, 26 Jul 2021 14:15:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/10] btrfs: remove uptodate parameter from btrfs_dec_test_first_ordered_pending
Date:   Mon, 26 Jul 2021 14:15:10 +0200
Message-Id: <2b01784d09b77a3209dda4284887271e1f8d434b.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In commit e65f152e4348 ("btrfs: refactor how we finish ordered extent io
for endio functions") there was last caller not using 1 for the uptodate
parameter. Now there's only one, passing 1, so we can remove it and
simplify the code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c        | 2 +-
 fs/btrfs/ordered-data.c | 5 +----
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 43b1393eec67..ba0bba9f5505 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8554,7 +8554,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		spin_unlock_irq(&inode->ordered_tree.lock);
 
 		if (btrfs_dec_test_ordered_pending(inode, &ordered,
-					cur, range_end + 1 - cur, 1)) {
+						   cur, range_end + 1 - cur)) {
 			btrfs_finish_ordered_io(ordered);
 			/*
 			 * The ordered extent has finished, now we're again
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 5c0f8481e25e..edb65abf0393 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -446,7 +446,6 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
  * 		 Will be also used to store the finished ordered extent.
  * @file_offset: File offset for the finished IO
  * @io_size:	 Length of the finish IO range
- * @uptodate:	 If the IO finishes without problem
  *
  * Return true if the ordered extent is finished in the range, and update
  * @cached.
@@ -457,7 +456,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
  */
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
-				    u64 file_offset, u64 io_size, int uptodate)
+				    u64 file_offset, u64 io_size)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
@@ -486,8 +485,6 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 		       entry->bytes_left, io_size);
 
 	entry->bytes_left -= io_size;
-	if (!uptodate)
-		set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
 
 	if (entry->bytes_left == 0) {
 		/*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b2d88aba8420..4194e960ff61 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -177,7 +177,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				bool uptodate);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
-				    u64 file_offset, u64 io_size, int uptodate);
+				    u64 file_offset, u64 io_size);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type);
-- 
2.31.1

