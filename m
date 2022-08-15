Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8185927E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiHOCwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 22:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHOCwN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 22:52:13 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Aug 2022 19:52:12 PDT
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F913DF4
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Aug 2022 19:52:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.45.240])
        by synology.com (Postfix) with ESMTPA id D2EAA2E550A5E;
        Mon, 15 Aug 2022 10:42:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1660531367; bh=CbrwuBdZ1Bg1tixDuz5o/NB2QhoyjVqpY+azz61lXb0=;
        h=From:To:Cc:Subject:Date;
        b=XYnkNhLB/9eoCMRGR/E7RdNnN5YvzQZbtIfSTi9rR+4QfzB+bMX617zU4K7wjLVSV
         vJJi7wLQF9oA2wG2FtKsWmchcQEK5KlkwQkxJTXsqJb6kigi6of/qf5da5Id1qE7pb
         F6L+Y7tj+CWZ2+C3e7lXn/aty4rYOWaDfVSZNoRI=
From:   ethanlien <ethanlien@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     cunankimo@gmail.com, Ethan Lien <ethanlien@synology.com>
Subject: [PATCH] btrfs: remove unnecessary EXTENT_UPTODATE state in buffered I/O path
Date:   Mon, 15 Aug 2022 10:42:09 +0800
Message-Id: <20220815024209.26122-1-ethanlien@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Ethan Lien <ethanlien@synology.com>

After we copied data to page cache in buffered I/O, we
1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
   endio_readpage_release_extent(), set_extent_delalloc() or
   set_extent_defrag().
2. Set page uptodate before we unlock the page.

But the only place we check io_tree's EXTENT_UPTODATE state is in
btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when we
have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODATE.

For example, when performing a buffered random read:

	fio --rw=randread --ioengine=libaio --direct=0 --numjobs=4 \
		--filesize=32G --size=4G --bs=4k --name=job \
		--filename=/mnt/file --name=job

Then check how many extent_state in io_tree:

	cat /proc/slabinfo | grep btrfs_extent_state | awk '{print $2}'

w/o this patch, we got 640567 btrfs_extent_state.
w/  this patch, we got    204 btrfs_extent_state.

Maintaining such a big tree brings overhead since every I/O needs to insert
EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. And in
every insert or remove, we need to lock io_tree, do tree search, alloc or
dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we keep
io_tree in a minimal size and reduce overhead when performing buffered I/O.

Signed-off-by: Ethan Lien <ethanlien@synology.com>
Reviewed-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent-io-tree.h | 4 ++--
 fs/btrfs/extent_io.c      | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index c3eb52dbe61c..53ae849d0248 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -211,7 +211,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 				      struct extent_state **cached_state)
 {
 	return set_extent_bit(tree, start, end,
-			      EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
+			      EXTENT_DELALLOC | extra_bits,
 			      0, NULL, cached_state, GFP_NOFS, NULL);
 }
 
@@ -219,7 +219,7 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
 	return set_extent_bit(tree, start, end,
-			      EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
+			      EXTENT_DELALLOC | EXTENT_DEFRAG,
 			      0, NULL, cached_state, GFP_NOFS, NULL);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfae67c593c5..e0f0a39cd6eb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2924,9 +2924,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	 * Now we don't have range contiguous to the processed range, release
 	 * the processed range now.
 	 */
-	if (processed->uptodate && tree->track_uptodate)
-		set_extent_uptodate(tree, processed->start, processed->end,
-				    &cached, GFP_ATOMIC);
 	unlock_extent_cached_atomic(tree, processed->start, processed->end,
 				    &cached);
 
-- 
2.17.1

