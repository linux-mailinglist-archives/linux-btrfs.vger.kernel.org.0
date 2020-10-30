Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BE2A0FE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgJ3VDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502AC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s39so5171080qtb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s7FiwgcGjSfDhX/Lpxflgb2UTT8b3aN4mUKTmLw4FpI=;
        b=HhUAIN+v5dzKMzIILYF6xWB6w6bPeScf2FvidW8ZE4rAFbmaAbI6bDU9xMBSySmMHW
         oY1VSg9aoIY4d+bMV5Pk1OKWvRSYGyT9nbW9CT/VY6W1J2Jo2xTlkbSwR4r7ig2JrY5M
         C7lzZfrwgt6Zb4x/9R0If8PyrDxtA+Sfcn/A2Ld8EJZ70V2M9a32ZEJVcRQyfxb+QeQT
         C/Te3wA+ZnpAF23yKDeWxeadYAhkMb15rR1/6R/SVhNVF2uAeAx2sdqc+a4fBeVSLpCu
         Hhjc1JwDPb+9oFA6VLdHlvzZw/Udjuo6XrNUx2rlzFpY/M9zM/kIwi6E+BEMhkjjyL75
         kahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7FiwgcGjSfDhX/Lpxflgb2UTT8b3aN4mUKTmLw4FpI=;
        b=FM7fHHrs6r7rX+Trxnj8kPs0s0P4Krx2Vq62RWrgAj4tz7+SqueexGSJoYZXfJguFY
         Uq7jTsB7q7nsdKG1gXEELVjSnlRU8YePRT0Y63CYZ0LyH1lqVpsFfwnh//Mu2cs3s6w7
         Eh7vgj609iX1IXcJ01UDiTsFt1Vd9Ov+m0Y6MEDsNZd3HleUewuvBWUdMt8TShHhJLjT
         2d2bzaE71o+SsSz+qn1+iE4kqv3/9aLXFsddVIgSpHtlQUgFzRQwZs4adHGx2iYMjVMH
         I4oMz/+CFTfV/izlDCtutlE/z5v88gIjmNbaAPsA5L+mMkgAcP7A8JYZ4g1yB7vHtogg
         iiqQ==
X-Gm-Message-State: AOAM530leeZRG68mxw/ZaNEUq75j1qQBw0zSlNlcS9MWiZIKbDJ57rLw
        4RYKXAWQlTSQyF+Oap/EAzstwKKv5N/C5N31
X-Google-Smtp-Source: ABdhPJzNelHSXcB80f7t7v0c3qMoqACh7Pq/HKXFfgFYuykCNtj/MOxNrXcNjDdigZJszU1ltTBGuw==
X-Received: by 2002:ac8:5916:: with SMTP id 22mr4061842qty.352.1604091815220;
        Fri, 30 Oct 2020 14:03:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z26sm3290419qki.40.2020.10.30.14.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/14] btrfs: set the lockdep class for ebs on creation
Date:   Fri, 30 Oct 2020 17:03:06 -0400
Message-Id: <684352674d9bc1db4373af4b94cbe56667f90503.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both Filipe and Fedora QA recently hit the following lockdep splat

WARNING: possible recursive locking detected
5.10.0-0.rc1.20201028gited8780e3f2ec.57.fc34.x86_64 #1 Not tainted
--------------------------------------------
rsync/2610 is trying to acquire lock:
ffff89617ed48f20 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140

but task is already holding lock:
ffff8961757b1130 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140

other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0
       ----
  lock(&eb->lock);
  lock(&eb->lock);

 *** DEADLOCK ***
 May be due to missing lock nesting notation
2 locks held by rsync/2610:
 #0: ffff896107212b90 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: walk_component+0x10c/0x190
 #1: ffff8961757b1130 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x140

stack backtrace:
CPU: 1 PID: 2610 Comm: rsync Not tainted 5.10.0-0.rc1.20201028gited8780e3f2ec.57.fc34.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
Call Trace:
 dump_stack+0x8b/0xb0
 __lock_acquire.cold+0x12d/0x2a4
 ? kvm_sched_clock_read+0x14/0x30
 ? sched_clock+0x5/0x10
 lock_acquire+0xc8/0x400
 ? btrfs_tree_read_lock_atomic+0x34/0x140
 ? read_block_for_search.isra.0+0xdd/0x320
 _raw_read_lock+0x3d/0xa0
 ? btrfs_tree_read_lock_atomic+0x34/0x140
 btrfs_tree_read_lock_atomic+0x34/0x140
 btrfs_search_slot+0x616/0x9a0
 btrfs_lookup_dir_item+0x6c/0xb0
 btrfs_lookup_dentry+0xa8/0x520
 ? lockdep_init_map_waits+0x4c/0x210
 btrfs_lookup+0xe/0x30
 __lookup_slow+0x10f/0x1e0
 walk_component+0x11b/0x190
 path_lookupat+0x72/0x1c0
 filename_lookup+0x97/0x180
 ? strncpy_from_user+0x96/0x1e0
 ? getname_flags.part.0+0x45/0x1a0
 vfs_statx+0x64/0x100
 ? lockdep_hardirqs_on_prepare+0xff/0x180
 ? _raw_spin_unlock_irqrestore+0x41/0x50
 __do_sys_newlstat+0x26/0x40
 ? lockdep_hardirqs_on_prepare+0xff/0x180
 ? syscall_enter_from_user_mode+0x27/0x80
 ? syscall_enter_from_user_mode+0x27/0x80
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

I have also seen a report of lockdep complaining about the lock class
that was looked up being the same as the lock class on the lock we were
using, but I can't find the report.

These are problems that occur because we do not have the lockdep class
set on the extent buffer until _after_ we read the eb in properly.  This
is problematic for concurrent readers, because we will create the extent
buffer, lock it, and then attempt to read the extent buffer.

If a second thread comes in and tries to do a search down the same path
they'll get the above lockdep splat because the class isn't set properly
on the extent buffer.

There was a good reason for this, we generally didn't know the real
owner of the eb until we read it, specifically in refcount'ed roots.

However now all refcount'ed roots have the same class name, so we no
longer need to worry about this.  For non-refcount'ed tree's we know
which root we're on based on the parent.

Fix this by setting the lockdep class on the eb at creation time instead
of read time.  This will fix the splat and the weirdness where the class
changes in the middle of locking the block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 3 ---
 fs/btrfs/extent-tree.c | 8 +++++---
 fs/btrfs/extent_io.c   | 1 +
 fs/btrfs/volumes.c     | 1 -
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 989412501a92..d8ce8bbb3a45 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -578,9 +578,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		goto err;
 	}
 
-	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb),
-				       eb, found_level);
-
 	csum_tree_block(eb, result);
 
 	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a2c611a83057..1ddd8f4e9564 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4679,6 +4679,11 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		return ERR_PTR(-EUCLEAN);
 	}
 
+	/*
+	 * This needs to stay, because we could allocate a free'd block from an
+	 * old tree into a new tree, so we need to make sure this new block is
+	 * set to the appropriate level and owner.
+	 */
 	btrfs_set_buffer_lockdep_class(owner, buf, level);
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clean_tree_block(buf);
@@ -5069,9 +5074,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 						    level - 1);
 		if (IS_ERR(next))
 			return PTR_ERR(next);
-
-		btrfs_set_buffer_lockdep_class(root->root_key.objectid, next,
-					       level - 1);
 		reada = 1;
 	}
 	btrfs_tree_lock(next);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0af8333ccca1..4e758d670fc1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5188,6 +5188,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	eb = __alloc_extent_buffer(fs_info, start, len);
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
+	btrfs_set_buffer_lockdep_class(owner_root, eb, level);
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++, index++) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9ef1a51379e9..ad244b44a3a1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6914,7 +6914,6 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 	set_extent_buffer_uptodate(sb);
-	btrfs_set_buffer_lockdep_class(root->root_key.objectid, sb, 0);
 	/*
 	 * The sb extent buffer is artificial and just used to read the system array.
 	 * set_extent_buffer_uptodate() call does not properly mark all it's
-- 
2.26.2

