Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058464D9E97
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiCOPYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiCOPYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8752DD7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3876120C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86B8C340E8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647357768;
        bh=JVjLPaMEBu3wtaHIGsh2emlb4EtWF0FLHuBp4Cpju6U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KX4b4yn2uzovrjOx1VSgyggg0wYGrHbUkWlPghj3KvvhhdqOKeK6u2xGeqFGeJDck
         mRen7kKIfRXVIpASZwsm5EsgeXWhVBEKGlhVc1F6+iDOpNW76StnsQoooc+AIGy6LT
         66Kbj8PvNjD/B1g+2B2I39Z8jTSpM1he1ZjdVHr8u7jv7fcc60X149uhbg6XpbGk7D
         G0FS3Wt5kwok2BJvjpZCdExHUkTFdv2rjA0PTF4JNZ1l5k7qPEgUF2Lnh9qJLG1IHH
         iAyzp/igjgF9TcICu5uqzeQPlPgIxgDDMEvNFfYBW//LylKGL5sOQ2M+u3yoBymiR+
         oeKp4nUDLkCcw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/7] btrfs: remove ordered extent check and wait during fallocate
Date:   Tue, 15 Mar 2022 15:22:38 +0000
Message-Id: <242b6cd3becd4e523ab4e402b8082493290b44e8.1647357395.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647357395.git.fdmanana@suse.com>
References: <cover.1647357395.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

For fallocate() we have this loop that checks if we have ordered extents
after locking the file range, and if so unlock the range, wait for ordered
extents, and retry until we don't find more ordered extents.

This logic was needed in the past because:

1) Direct IO writes within the i_size boundary did not take the inode's
   VFS lock. This was because that lock used to be a mutex, then some
   years ago it was switched to a rw semaphore (commit 9902af79c01a8e
   ("parallel lookups: actual switch to rwsem")), and then btrfs was
   changed to take the VFS inode's lock in shared mode for writes that
   don't cross the i_size boundary (commit e9adabb9712ef9 ("btrfs: use
   shared lock for direct writes within EOF"));

2) We could race with memory mapped writes, because memory mapped writes
   don't acquire the inode's VFS lock. We don't have that race anymore,
   as we have a rw semaphore to synchronize memory mapped writes with
   fallocate (and reflinking too). That change happened with commit
   8d9b4a162a37ce ("btrfs: exclude mmap from happening during all
   fallocate operations").

So stop looking for ordered extents after locking the file range when
doing a plain fallocate.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 42 ++++++++----------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2f57f7d9d9cb..a7fd05c1d52f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3474,8 +3474,12 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	/*
-	 * wait for ordered IO before we have any locks.  We'll loop again
-	 * below with the locks held.
+	 * We have locked the inode at the VFS level (in exclusive mode) and we
+	 * have locked the i_mmap_lock lock (in exclusive mode). Now before
+	 * locking the file range, flush all dealloc in the range and wait for
+	 * all ordered extents in the range to complete. After this we can lock
+	 * the file range and, due to the previous locking we did, we know there
+	 * can't be more delalloc or ordered extents in the range.
 	 */
 	ret = btrfs_wait_ordered_range(inode, alloc_start,
 				       alloc_end - alloc_start);
@@ -3489,38 +3493,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	locked_end = alloc_end - 1;
-	while (1) {
-		struct btrfs_ordered_extent *ordered;
-
-		/* the extent lock is ordered inside the running
-		 * transaction
-		 */
-		lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start,
-				 locked_end, &cached_state);
-		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
-							    locked_end);
-
-		if (ordered &&
-		    ordered->file_offset + ordered->num_bytes > alloc_start &&
-		    ordered->file_offset < alloc_end) {
-			btrfs_put_ordered_extent(ordered);
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     alloc_start, locked_end,
-					     &cached_state);
-			/*
-			 * we can't wait on the range with the transaction
-			 * running or with the extent lock held
-			 */
-			ret = btrfs_wait_ordered_range(inode, alloc_start,
-						       alloc_end - alloc_start);
-			if (ret)
-				goto out;
-		} else {
-			if (ordered)
-				btrfs_put_ordered_extent(ordered);
-			break;
-		}
-	}
+	lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+			 &cached_state);
 
 	/* First, check if we exceed the qgroup limit */
 	INIT_LIST_HEAD(&reserve_list);
-- 
2.33.0

