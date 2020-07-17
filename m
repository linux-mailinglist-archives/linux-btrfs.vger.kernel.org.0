Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D620C224403
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgGQTMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 15:12:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C565C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 12:12:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w27so8452837qtb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JG4TRDjZbhXGqW5R4WRiF/swqrbe2/kZtZolF6m3Fhw=;
        b=h+BP+ViMIqteFU5A+MyYAvn9ia/xbb9kvQ/irve/lRR++9PaF7ZDoxIszNXdkuf8hE
         uVZNmFm62OmfvpObWBN3+06sDmugPnlt7M+2lQTKlVw028faENhY8U+yPZrUBc5omndw
         f9tQA8zpF7+We7LPGo/nFO+sstp3zsNMr8d3dIsjXy85KgT4SC4Mu7XiHf2c0DgR7wq8
         oZbBMThXsaeDeB6SchG7emBXsmoS46aBg4YtcJwGo2honjazXszvVTi9n28w4oIR1iGA
         Vh+jGynDkJoIHRGvG1oy9pdGkIYHVMiAAzg/UPK4bnRHvvCK7KDxpCT3BX+M0hNFGAeI
         gY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JG4TRDjZbhXGqW5R4WRiF/swqrbe2/kZtZolF6m3Fhw=;
        b=XOmsL1+7A9gXkoWtlx4pLt4G4CEN6WEm5TlI5rbfTT/BeBkn/wazxyxNTVSqLk5/Np
         FvBhbLYLvOZfRneyQB8A7m0PeVuTvsGaHAFKDhyhZxy4hSQQWIluBPH/dWMMI2dbXA3B
         DZIJfjBBgZwYFvjJBQvKY5x0XnpKYeoSkmKynHtej6SHmCurGmwqYbCLquI35JsLDWJU
         VYEmIHvFGoEakKsAptU7ZhBp6eJgFisUn+4V5YwpYkxXftCQxuODv1yDTIrpvkqGkBdW
         VTz/9aYE3pj51buSYvV/EX8P/Q7W7hxy7W6RkBn6U+JjwvqDlqreHVusetjV7mqc1NBe
         0Z9g==
X-Gm-Message-State: AOAM531I4sABxcRasXpQcJpjkD9SA88NuA31xNcc5aJjfhAtjI8x6UcU
        bnlyDfCPVOz9VwkIKg7LKlKrqV2kWz/1qA==
X-Google-Smtp-Source: ABdhPJxrZ/RxrYIyKtDkrSqcYFv9AbRxdQeI59wMyVBAhNKlEemk3YY5g2tD5XMWsY9oRbAd2a472w==
X-Received: by 2002:aed:3fac:: with SMTP id s41mr11906111qth.86.1595013157960;
        Fri, 17 Jul 2020 12:12:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s190sm7230616qkh.116.2020.07.17.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:12:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: move the chunk_mutex in btrfs_read_chunk_tree
Date:   Fri, 17 Jul 2020 15:12:28 -0400
Message-Id: <20200717191229.2283043-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200717191229.2283043-1-josef@toxicpanda.com>
References: <20200717191229.2283043-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are currently getting this lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc5+ #20 Tainted: G            E
------------------------------------------------------
mount/678048 is trying to acquire lock:
ffff9b769f15b6e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x170 [btrfs]

but task is already holding lock:
ffff9b76abdb08d0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x6a/0x800 [btrfs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __mutex_lock+0x8b/0x8f0
       btrfs_init_new_device+0x2d2/0x1240 [btrfs]
       btrfs_ioctl+0x1de/0x2d20 [btrfs]
       ksys_ioctl+0x87/0xc0
       __x64_sys_ioctl+0x16/0x20
       do_syscall_64+0x52/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __lock_acquire+0x1240/0x2460
       lock_acquire+0xab/0x360
       __mutex_lock+0x8b/0x8f0
       clone_fs_devices+0x4d/0x170 [btrfs]
       btrfs_read_chunk_tree+0x330/0x800 [btrfs]
       open_ctree+0xb7c/0x18ce [btrfs]
       btrfs_mount_root.cold+0x13/0xfa [btrfs]
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       fc_mount+0xe/0x40
       vfs_kern_mount.part.0+0x71/0x90
       btrfs_mount+0x13b/0x3e0 [btrfs]
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       do_mount+0x7de/0xb30
       __x64_sys_mount+0x8e/0xd0
       do_syscall_64+0x52/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->chunk_mutex);
                               lock(&fs_devs->device_list_mutex);
                               lock(&fs_info->chunk_mutex);
  lock(&fs_devs->device_list_mutex);

 *** DEADLOCK ***

3 locks held by mount/678048:
 #0: ffff9b75ff5fb0e0 (&type->s_umount_key#63/1){+.+.}-{3:3}, at: alloc_super+0xb5/0x380
 #1: ffffffffc0c2fbc8 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x54/0x800 [btrfs]
 #2: ffff9b76abdb08d0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x6a/0x800 [btrfs]

stack backtrace:
CPU: 2 PID: 678048 Comm: mount Tainted: G            E     5.8.0-rc5+ #20
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./890FX Deluxe5, BIOS P1.40 05/03/2011
Call Trace:
 dump_stack+0x96/0xd0
 check_noncircular+0x162/0x180
 __lock_acquire+0x1240/0x2460
 ? asm_sysvec_apic_timer_interrupt+0x12/0x20
 lock_acquire+0xab/0x360
 ? clone_fs_devices+0x4d/0x170 [btrfs]
 __mutex_lock+0x8b/0x8f0
 ? clone_fs_devices+0x4d/0x170 [btrfs]
 ? rcu_read_lock_sched_held+0x52/0x60
 ? cpumask_next+0x16/0x20
 ? module_assert_mutex_or_preempt+0x14/0x40
 ? __module_address+0x28/0xf0
 ? clone_fs_devices+0x4d/0x170 [btrfs]
 ? static_obj+0x4f/0x60
 ? lockdep_init_map_waits+0x43/0x200
 ? clone_fs_devices+0x4d/0x170 [btrfs]
 clone_fs_devices+0x4d/0x170 [btrfs]
 btrfs_read_chunk_tree+0x330/0x800 [btrfs]
 open_ctree+0xb7c/0x18ce [btrfs]
 ? super_setup_bdi_name+0x79/0xd0
 btrfs_mount_root.cold+0x13/0xfa [btrfs]
 ? vfs_parse_fs_string+0x84/0xb0
 ? rcu_read_lock_sched_held+0x52/0x60
 ? kfree+0x2b5/0x310
 legacy_get_tree+0x30/0x50
 vfs_get_tree+0x28/0xc0
 fc_mount+0xe/0x40
 vfs_kern_mount.part.0+0x71/0x90
 btrfs_mount+0x13b/0x3e0 [btrfs]
 ? cred_has_capability+0x7c/0x120
 ? rcu_read_lock_sched_held+0x52/0x60
 ? legacy_get_tree+0x30/0x50
 legacy_get_tree+0x30/0x50
 vfs_get_tree+0x28/0xc0
 do_mount+0x7de/0xb30
 ? memdup_user+0x4e/0x90
 __x64_sys_mount+0x8e/0xd0
 do_syscall_64+0x52/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is because btrfs_read_chunk_tree() can come upon DEV_EXTENT's and
then read the device, which takes the device_list_mutex.  The
device_list_mutex needs to be taken before the chunk_mutex, so this is a
problem.  We only really need the chunk mutex around adding the chunk,
so move the mutex around read_one_chunk.

An argument could be made that we don't even need the chunk_mutex here
as it's during mount, and we are protected by various other locks.
However we already have special rules for ->device_list_mutex, and I'd
rather not have another special case for ->chunk_mutex.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 20295441251a..adc7bc2a3094 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7053,7 +7053,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * otherwise we don't need it.
 	 */
 	mutex_lock(&uuid_mutex);
-	mutex_lock(&fs_info->chunk_mutex);
 
 	/*
 	 * Read all device items, and then all the chunk items. All
@@ -7103,7 +7102,9 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 		} else if (found_key.type == BTRFS_CHUNK_ITEM_KEY) {
 			struct btrfs_chunk *chunk;
 			chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
+			mutex_lock(&fs_info->chunk_mutex);
 			ret = read_one_chunk(&found_key, leaf, chunk);
+			mutex_unlock(&fs_info->chunk_mutex);
 			if (ret)
 				goto error;
 		}
@@ -7133,7 +7134,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	}
 	ret = 0;
 error:
-	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&uuid_mutex);
 
 	btrfs_free_path(path);
-- 
2.24.1

