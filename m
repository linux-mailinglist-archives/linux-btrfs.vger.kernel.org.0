Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4EF2A828A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgKEPpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgKEPpv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:51 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB324C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:50 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so1550599qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NoJHUpoDSSSqA7oEpNRFTALZNxQ8j0TntBIs3e1VOLs=;
        b=DyDPl4wLBxqEtpA/HBss3b/z0Fya6yGjkzhI2xvxEFLxiWMpQ1g7SRfF5AEccin9Cl
         3xGWNwvzA+RTg4UYDfjABS9ZKeHkeyMT7/Y5rzlqWLLsXP7IwnT7tJXW+4btwMIsJvhc
         UcLXKQIs8ke29Luql7ggE1//Rw4MKKc0YMDDHTV8sdnMz4EtXVnNBJ7rUIl3ENwwv1p3
         WRNo3pMyLUVQ0p2BnxNiwBcQDnZGsAc+59HdoZqv3I91fbKKJ2PvKB4gu1wQTmVAAEDi
         FIyDVvLz6RLxTI29koMxevPRqX1JetLurxS3yqjT/N+MEvCM9XFiQ54yK+UAR7rOfQFt
         R27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NoJHUpoDSSSqA7oEpNRFTALZNxQ8j0TntBIs3e1VOLs=;
        b=sumuNFiWztXW1u89DJcvCq15SVvrvnl1VkHv085PVH5GHzIYiMuJtzVkGkpDDnBKA+
         RbQ0jR1Sx5yMQ+qosHk7GdC/NBUxid72tx+K8FKGyO6fB5viw//AxezOf3hdIxdQo9BA
         D0IXj0hnemjxJGadOdK8yPC8L2HDM/aywp/z1rL20tzDD243NkYj6aKfHKuXfkSM2c3Z
         OE4sie6MT7pX7XvFvmE5KjOSHlGlz+VorlOQdtvKCQYf/m04zBu76FPtx01phgmSWPnm
         7j2QNYBRDrBH4cSHP4GHkSvNV7ZCp3Fnj8Oy5aFyWf4dRlA5RiTxi9rItq27eJp0/6ef
         r5jw==
X-Gm-Message-State: AOAM532CYyjo4/6R1JKma9Q66TDc8GhIE0enDMORAOk4DVwffILouf6L
        35iG+1BgCb/GusiEOkPSefI4fxokKb5Ly27T
X-Google-Smtp-Source: ABdhPJyIqX+0HZMa9Do4TfRouQN8TxXEQqTAej6UjkOwNOg/lyBYdQt+wHXn1ciDGHk9N4o/VdC02A==
X-Received: by 2002:a37:6195:: with SMTP id v143mr2481166qkb.71.1604591149560;
        Thu, 05 Nov 2020 07:45:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d20sm1245698qkj.49.2020.11.05.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/14] btrfs: set the lockdep class for ebs on creation
Date:   Thu,  5 Nov 2020 10:45:21 -0500
Message-Id: <1cee2922a32c305056a9559ccf7aede49777beae.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
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
index f14398b5d933..a90839426cfa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -577,9 +577,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		goto err;
 	}
 
-	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb),
-				       eb, found_level);
-
 	csum_tree_block(eb, result);
 
 	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 14b6e19f6151..517c2558f973 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4629,6 +4629,11 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
@@ -5018,9 +5023,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
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
index a883350d5e7f..3c61981b2c7b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5196,6 +5196,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	eb = __alloc_extent_buffer(fs_info, start, len);
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
+	btrfs_set_buffer_lockdep_class(owner_root, eb, level);
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++, index++) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0ca2e96a9cda..4830c40fc400 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6902,7 +6902,6 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 	set_extent_buffer_uptodate(sb);
-	btrfs_set_buffer_lockdep_class(root->root_key.objectid, sb, 0);
 	/*
 	 * The sb extent buffer is artificial and just used to read the system array.
 	 * set_extent_buffer_uptodate() call does not properly mark all it's
-- 
2.26.2

