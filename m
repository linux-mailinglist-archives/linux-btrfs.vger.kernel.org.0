Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A214E5636
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiCWQVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiCWQVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E851975E6A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D3DB81F12
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DC4C340F2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052381;
        bh=4r+f7/Qe3nOGJiq/PHmXFjCVGpvExaDQ5ZApT7mwDVQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iHhXNI9mtadlDcxJ5Kz5zWi8JTZTNEcDpHiNS5nEhlYv/QXH21/qqr04zjM0/U0ec
         VIYvLu1iYV/iKANvAF9YoFfNdbLSKQ7UbFararxWZWY3nUoWVLq7rJ78pBMBX0PVZW
         tOyPxLlhoh6+BE+SxrrYYAhOhxib00bjwQYjU/F80MAdXGrFXQSJCGSWSaP3fM6sHs
         5iJyxpdQpZpkG+EfGPblTGPCvZOGi7FSglboVfy+9wrm+CUOr5rt6R8odEIy2Qr8gY
         mBQwSWoy3N/VCCc2suEy/5VAAuQHzDZ9zIajAilIrN0en2rHu6riahzI13WXXHwK12
         WPFsQjiqGoJMg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: avoid blocking nowait dio when locking file range
Date:   Wed, 23 Mar 2022 16:19:24 +0000
Message-Id: <8241451e5f9b9b713f58b50711d21caee292b727.1648051582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we are doing a NOWAIT direct IO read/write, we can block when locking
the file range at btrfs_dio_iomap_begin(), as it's possible the range (or
a part of it) is already locked by another task (mmap writes, another
direct IO read/write racing with us, fiemap, etc). We are also waiting for
completion of any ordered extent we find in the range, which also can
block us for a significant amount of time.

There's also the incorrect fallback to buffered IO (returning -ENOTBLK)
when we are dealing with a NOWAIT request and we can't proceed. In this
case we should be returning -EAGAIN, as falling back to buffered IO can
result in blocking for many different reasons, so that the caller can
delegate a retry to a context where blocking is more acceptable.

Fix these cases by:

1) Doing a try lock on the file range and failing with -EAGAIN if we
   can not lock right away;

2) Fail with -EAGAIN if we find an ordered extent;

3) Return -EAGAIN instead of -ENOTBLK when we need to fallback to
   buffered IO and we have a NOWAIT request.

This will also allow us to avoid a duplicated check that verifies if we
are able to do a NOCOW write for NOWAIT direct IO writes, done in the
next patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a10b729fd51..2412116a279d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7255,14 +7255,22 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 }
 
 static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
-			      struct extent_state **cached_state, bool writing)
+			      struct extent_state **cached_state,
+			      unsigned int iomap_flags)
 {
+	const bool writing = (iomap_flags & IOMAP_WRITE);
+	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	int ret = 0;
 
 	while (1) {
-		lock_extent_bits(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-				 cached_state);
+		if (nowait) {
+			if (!try_lock_extent(io_tree, lockstart, lockend))
+				return -EAGAIN;
+		} else {
+			lock_extent_bits(io_tree, lockstart, lockend, cached_state);
+		}
 		/*
 		 * We're concerned with the entire range that we're going to be
 		 * doing DIO to, so we need to make sure there's no ordered
@@ -7283,10 +7291,14 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 							 lockstart, lockend)))
 			break;
 
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-				     cached_state);
+		unlock_extent_cached(io_tree, lockstart, lockend, cached_state);
 
 		if (ordered) {
+			if (nowait) {
+				btrfs_put_ordered_extent(ordered);
+				ret = -EAGAIN;
+				break;
+			}
 			/*
 			 * If we are doing a DIO read and the ordered extent we
 			 * found is for a buffered write, we can not wait for it
@@ -7306,7 +7318,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
 				btrfs_start_ordered_extent(ordered, 1);
 			else
-				ret = -ENOTBLK;
+				ret = nowait ? -EAGAIN : -ENOTBLK;
 			btrfs_put_ordered_extent(ordered);
 		} else {
 			/*
@@ -7322,7 +7334,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 * ordered extent to complete while holding a lock on
 			 * that page.
 			 */
-			ret = -ENOTBLK;
+			ret = nowait ? -EAGAIN : -ENOTBLK;
 		}
 
 		if (ret)
@@ -7577,12 +7589,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
-	 * this range and we need to fallback to buffered.
+	 * this range and we need to fallback to buffered IO, or we are doing a
+	 * NOWAIT read/write and we need to block.
 	 */
-	if (lock_extent_direct(inode, lockstart, lockend, &cached_state, write)) {
-		ret = -ENOTBLK;
+	ret = lock_extent_direct(inode, lockstart, lockend, &cached_state, flags);
+	if (ret < 0)
 		goto err;
-	}
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
 	if (IS_ERR(em)) {
-- 
2.33.0

