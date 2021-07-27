Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6393D8066
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhG0VDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhG0VDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5634DC08EAF4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d2so10606766qto.6
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2wRRI6yAObgb7kEWDxwxrtz55hTG6kt2Wi+5lMlpdAo=;
        b=sg4HVxHmdlHy2Af4iyihe8hjRy+9MLmDGGzrUV5EmEZXuV4LWq3a1DC73JJZcjIxrW
         c5tIihifTn+Cq/vQs7T58MMRn5qXrVpNZajN40NqzgGad7y1HhDvrmLEs7Q5QYDKyfF+
         uL03GccfEKSo2pOE3n95wyHabMAUdY69N0w2Q276wLAinW6IBBZ8YqQw4Iq8Xol0R+Nh
         S4SDfjFi3/ExaQgAwLVoVpkHtWy6utJkfc6sZVIboOhQL5c1Frlrfgn2EjaqMOSsJjZC
         DvqPHMn8b3AtrTRAaQm18wACHUVcdFxlODgfnXXkR/z4oTT+JkwLXn8qWK5u9Nb+FriK
         QfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wRRI6yAObgb7kEWDxwxrtz55hTG6kt2Wi+5lMlpdAo=;
        b=EOlodWmhVnvFRpCzBz3VuR0QmCUI6HSlfynxC0XoRtyU6ny1rt78F/iBOlnMkxJI5W
         rijBv1CsVTeoImRcWoGspvaIS07Ev1Vh3fFVI0/BAeh9ZsbBNICssDA0xaYfJBPhDhnU
         NPg/mx6bOraA6PQLvdGBpQdOmZOYjx54j38/h0c5UblnipOUTHyBj2iCr01Xwy5Nqcoc
         rmCpzBeD38YiEBslguMvjMHKKGhzuzMxsgbwHaKRSPaasXpJlzXZ78i4QXclm2scQPas
         QNbdLySsKY++NRIoH3XFwZcekIM7nu2aAWOjr14YGfspQPQ2DhPpKt74vmKJRB4BXG1C
         gvig==
X-Gm-Message-State: AOAM533uBE07y8h0PlCNDNmehz1bP7uMjQv7H5RlOqYKNwK2kbAuNUKS
        Cgs1ouFa4u0QaXz6O/kkElAprdYmbUuu5/md
X-Google-Smtp-Source: ABdhPJwcc2h4oM2Fapm8natz4k6WLepoErAOL7c5v02giyl79i9PomIk4Yr8NAAYi/KCkxPPCKZa/Q==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr21523208qtr.69.1627419691139;
        Tue, 27 Jul 2021 14:01:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm1819682qtx.56.2021.07.27.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 7/7] btrfs: do not take the device_list_mutex in clone_fs_devices
Date:   Tue, 27 Jul 2021 17:01:19 -0400
Message-Id: <c3eb810f0b0505757dd2733531c9338c99b8444a.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got the following lockdep splat while testing seed devices

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2+ #409 Not tainted
------------------------------------------------------
mount/34004 is trying to acquire lock:
ffff9eaac48188e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x170

but task is already holding lock:
ffff9eaac766d438 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x100

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (btrfs-chunk-00){++++}-{3:3}:
       down_read_nested+0x46/0x60
       __btrfs_tree_read_lock+0x24/0x100
       btrfs_read_lock_root_node+0x31/0x40
       btrfs_search_slot+0x480/0x930
       btrfs_update_device+0x63/0x180
       btrfs_chunk_alloc_add_chunk_item+0xdc/0x3a0
       btrfs_chunk_alloc+0x281/0x540
       find_free_extent+0x10ca/0x1790
       btrfs_reserve_extent+0xbf/0x1d0
       btrfs_alloc_tree_block+0xb1/0x320
       __btrfs_cow_block+0x136/0x5f0
       btrfs_cow_block+0x107/0x210
       btrfs_search_slot+0x56a/0x930
       btrfs_truncate_inode_items+0x187/0xef0
       btrfs_truncate_free_space_cache+0x11c/0x210
       delete_block_group_cache+0x6f/0xb0
       btrfs_relocate_block_group+0xf8/0x350
       btrfs_relocate_chunk+0x38/0x120
       btrfs_balance+0x79b/0xf00
       btrfs_ioctl_balance+0x327/0x400
       __x64_sys_ioctl+0x80/0xb0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7d/0x750
       btrfs_init_new_device+0x6d6/0x1540
       btrfs_ioctl+0x1b12/0x2d30
       __x64_sys_ioctl+0x80/0xb0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __lock_acquire+0x10ea/0x1d90
       lock_acquire+0xb5/0x2b0
       __mutex_lock+0x7d/0x750
       clone_fs_devices+0x4d/0x170
       btrfs_read_chunk_tree+0x32f/0x800
       open_ctree+0xae3/0x16f0
       btrfs_mount_root.cold+0x12/0xea
       legacy_get_tree+0x2d/0x50
       vfs_get_tree+0x25/0xc0
       vfs_kern_mount.part.0+0x71/0xb0
       btrfs_mount+0x10d/0x380
       legacy_get_tree+0x2d/0x50
       vfs_get_tree+0x25/0xc0
       path_mount+0x433/0xb60
       __x64_sys_mount+0xe3/0x120
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &fs_devs->device_list_mutex --> &fs_info->chunk_mutex --> btrfs-chunk-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-chunk-00);
                               lock(&fs_info->chunk_mutex);
                               lock(btrfs-chunk-00);
  lock(&fs_devs->device_list_mutex);

 *** DEADLOCK ***

3 locks held by mount/34004:
 #0: ffff9eaad75c00e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0xd5/0x3b0
 #1: ffffffffbd2dcf08 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x59/0x800
 #2: ffff9eaac766d438 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x100

stack backtrace:
CPU: 0 PID: 34004 Comm: mount Not tainted 5.14.0-rc2+ #409
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack_lvl+0x57/0x72
 check_noncircular+0xcf/0xf0
 __lock_acquire+0x10ea/0x1d90
 lock_acquire+0xb5/0x2b0
 ? clone_fs_devices+0x4d/0x170
 ? lock_is_held_type+0xa5/0x120
 __mutex_lock+0x7d/0x750
 ? clone_fs_devices+0x4d/0x170
 ? clone_fs_devices+0x4d/0x170
 ? lockdep_init_map_type+0x47/0x220
 ? debug_mutex_init+0x33/0x40
 clone_fs_devices+0x4d/0x170
 ? lock_is_held_type+0xa5/0x120
 btrfs_read_chunk_tree+0x32f/0x800
 ? find_held_lock+0x2b/0x80
 open_ctree+0xae3/0x16f0
 btrfs_mount_root.cold+0x12/0xea
 ? rcu_read_lock_sched_held+0x3f/0x80
 ? kfree+0x1f6/0x410
 legacy_get_tree+0x2d/0x50
 vfs_get_tree+0x25/0xc0
 vfs_kern_mount.part.0+0x71/0xb0
 btrfs_mount+0x10d/0x380
 ? kfree+0x1f6/0x410
 legacy_get_tree+0x2d/0x50
 vfs_get_tree+0x25/0xc0
 path_mount+0x433/0xb60
 __x64_sys_mount+0xe3/0x120
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6cbcd9788e

It is because we take the ->device_list_mutex in this path while holding
onto the tree locks in the chunk root.  However we do not need the lock
here, because we're already holding onto the uuid_mutex, and in fact
have removed all other uses of the ->device_list_mutex in this path
because of this.  Remove the ->device_list_mutex locking here, add an
assert for the uuid_mutex and the problem is fixed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f622e93a6ff1..bdfcc35335c3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1000,11 +1000,12 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 	struct btrfs_device *orig_dev;
 	int ret = 0;
 
+	lockdep_assert_held(&uuid_mutex);
+
 	fs_devices = alloc_fs_devices(orig->fsid, NULL);
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	mutex_lock(&orig->device_list_mutex);
 	fs_devices->total_devices = orig->total_devices;
 
 	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
@@ -1036,10 +1037,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 		device->fs_devices = fs_devices;
 		fs_devices->num_devices++;
 	}
-	mutex_unlock(&orig->device_list_mutex);
 	return fs_devices;
 error:
-	mutex_unlock(&orig->device_list_mutex);
 	free_fs_devices(fs_devices);
 	return ERR_PTR(ret);
 }
-- 
2.26.3

