Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B461FA3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiKGQo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 11:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKGQo4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 11:44:56 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3C1EC7A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 08:44:54 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id i9so7474594qki.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvUXozhMVQ1uu2YO6E82DDkSlvhFFBBwGni7YtoRAm8=;
        b=4rjwRTyof5F+N24fUT75RytLibIw0wAxkpJamGHMNibUR07iYXqMHVurBtir72H9X1
         4giQHciiVSc4wkwqmB0TevijodFLzUpm4PwjcmK2GD11NYz4RsRHtQCggnVxZ5alCZ7E
         uhrTME7ehAe4fu0fVjelhl3xcsCxRbOpfouGTevN3BSZsaCvaYqO2t6FBP3hAYXj95zo
         Mv7/uQfNBTRRX0pF2ejzoWLZWSp/XnCzkboE7HoimaEAAHp8VU+96qM5QQAvOUJ/S7GQ
         nEadLD33Fu5Ojr9a904+WUokWfsWfnOXZ9Mxpt2YILF5xxkXcHs0mZ/1uaPk6nckyzdb
         qCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvUXozhMVQ1uu2YO6E82DDkSlvhFFBBwGni7YtoRAm8=;
        b=E2Kvd0Pu4a91nURVKKWfqwdm3AG/mkMgRZho6h8fENlDDVUX3MgZXLUNpa7buDe067
         MPeysNpizY19ZnH45nn2QqsKVLsCCFkYT+FawMqa1/64u9vvz75m+DXfcsiQa6PTp3XW
         kTRrO6vRDziDT5Kta9nxH85870uy0oNIqYHosp7VeFy7dIA/XYHPrVKEC+aCUeLRqKyV
         bxtaOsU/PHGhsucmgxGfkNEGlHCV3IqpnDNgk8iCXUi1K+CZ9M85C8D3WLsEA1Vqjy9k
         HXvJ/3UJoNfM4g86QEP/Vn5IQmRgxJHyWXzXOWVYYGiYcvDaW2ppG1mBDaZKTivubHxN
         l/yg==
X-Gm-Message-State: ACrzQf1T1oiOovbLTzDpiLnfsqNmhAjVUcs/nN/VWnckU2tlQ95Xj7p0
        I7UpFY7uNX5TU6VSEtHqCogzF5jmD5D4Vw==
X-Google-Smtp-Source: AMsMyM5Fh4QtH9yzJQ0X+25+HP20QA9e4flqRLOtg5DyMR+xlSqCg5Io1kkaPatYbIkG40IV68cRWw==
X-Received: by 2002:a37:c44d:0:b0:6fa:271c:fd20 with SMTP id h13-20020a37c44d000000b006fa271cfd20mr31324005qkm.35.1667839493353;
        Mon, 07 Nov 2022 08:44:53 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bm7-20020a05620a198700b006ce1bfbd603sm7064897qkb.124.2022.11.07.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:44:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: drop path before copying root refs to userspace
Date:   Mon,  7 Nov 2022 11:44:51 -0500
Message-Id: <73b531f0b9b9317a0693244ae7cc4e60566ccf25.1667839482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzbot reported the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor307/3029 is trying to acquire lock:
ffff0000c02525d8 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5576

but task is already holding lock:
ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (btrfs-root-00){++++}-{3:3}:
       down_read_nested+0x64/0x84 kernel/locking/rwsem.c:1624
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root+0x74/0x338 fs/btrfs/ctree.c:1637
       btrfs_search_slot+0x1b0/0xfd8 fs/btrfs/ctree.c:1944
       btrfs_update_root+0x6c/0x5a0 fs/btrfs/root-tree.c:132
       commit_fs_roots+0x1f0/0x33c fs/btrfs/transaction.c:1459
       btrfs_commit_transaction+0x89c/0x12d8 fs/btrfs/transaction.c:2343
       flush_space+0x66c/0x738 fs/btrfs/space-info.c:786
       btrfs_async_reclaim_metadata_space+0x43c/0x4e0 fs/btrfs/space-info.c:1059
       process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
       worker_thread+0x340/0x610 kernel/workqueue.c:2436
       kthread+0x12c/0x158 kernel/kthread.c:376
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #2 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       btrfs_record_root_in_trans fs/btrfs/transaction.c:516 [inline]
       start_transaction+0x248/0x944 fs/btrfs/transaction.c:752
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:781
       btrfs_create_common+0xf0/0x1b4 fs/btrfs/inode.c:6651
       btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6697
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3688
       do_filp_open+0xdc/0x1b8 fs/namei.c:3718
       do_sys_openat2+0xb8/0x22c fs/open.c:1313
       do_sys_open fs/open.c:1329 [inline]
       __do_sys_openat fs/open.c:1345 [inline]
       __se_sys_openat fs/open.c:1340 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (sb_internal#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       start_transaction+0x360/0x944 fs/btrfs/transaction.c:683
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:795
       btrfs_dirty_inode+0x50/0x140 fs/btrfs/inode.c:6103
       btrfs_update_time+0x1c0/0x1e8 fs/btrfs/inode.c:6145
       inode_update_time fs/inode.c:1872 [inline]
       touch_atime+0x1f0/0x4a8 fs/inode.c:1945
       file_accessed include/linux/fs.h:2516 [inline]
       btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2407
       call_mmap include/linux/fs.h:2192 [inline]
       mmap_region+0x7fc/0xc14 mm/mmap.c:1752
       do_mmap+0x644/0x97c mm/mmap.c:1540
       vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:552
       ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1586
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       __might_fault+0x7c/0xb4 mm/memory.c:5577
       _copy_to_user include/linux/uaccess.h:134 [inline]
       copy_to_user include/linux/uaccess.h:160 [inline]
       btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
       btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &fs_info->reloc_mutex --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(&fs_info->reloc_mutex);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor307/3029:
 #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279

stack backtrace:
CPU: 0 PID: 3029 Comm: syz-executor307 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __might_fault+0x7c/0xb4 mm/memory.c:5577
 _copy_to_user include/linux/uaccess.h:134 [inline]
 copy_to_user include/linux/uaccess.h:160 [inline]
 btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
 btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

We do generally the right thing here, copying the references into a
temporary buffer, however we are still holding the path when we do
copy_to_user from the temporary buffer.  Fix this by free'ing the path
before we copy to user space.

Reported-by: syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9c1cb5113178..306524554117 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2303,6 +2303,8 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 	}
 
 out:
+	btrfs_free_path(path);
+
 	if (!ret || ret == -EOVERFLOW) {
 		rootrefs->num_items = found;
 		/* update min_treeid for next search */
@@ -2314,7 +2316,6 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 	}
 
 	kfree(rootrefs);
-	btrfs_free_path(path);
 
 	return ret;
 }
-- 
2.26.3

