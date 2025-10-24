Return-Path: <linux-btrfs+bounces-18232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A1C04150
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 04:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7874B4F7042
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55476225401;
	Fri, 24 Oct 2025 02:07:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E221D59B
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271649; cv=none; b=ZzYc/YumL4jMdTzIIVeN5R9+5mU/05H2F6gi5A2notHCT1QoUOTUtpHfH4a6rTLpSc6m3u2zQyyS6OJG6qTL12PPxZz3a12abmKxeNDM0KaVzhecMmQsFpw8AzaUnTPf01NjiW6PhV3ZeuzElqLLZ95s+qwfAO2UAV+aBGTajAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271649; c=relaxed/simple;
	bh=IFHOJ4qMI+jpFAB93/ymXlM7o4uTZ8bb8YF/yElDack=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sy+gQwuPr5fSCexQbCRkXWZN6CePpKHPUA95AXh4nNLi3L141tKJF99JtbOeR8rkjikr5AD5vBP3StcpYX25pSIuP+bzlUpHIaR6VJLuxG5XUd0Iir8a5ujgx+4A3vfEZoU28clfUIyw1T0jauATTI7bjrOJxdjiisCSYi1+h+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-940dbc45bc3so145934739f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 19:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271647; x=1761876447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT4EZw6MJA5Bgom7dmmbeHsErxQC55ruUwa3HmUa320=;
        b=W2d9qQOa4B4ds3pBIEX1DNcj5xQuao/8eaRPuEWXhGolfeStLgkOTPdRq/nP6nytuN
         dyzUj2PgDPdznePZK7Xgpqrm/d6JhRunY9oDk4dQQ/LRXBKW+ZLLlRI7BO0oPa9jEUHI
         uOOHrelid/U7yoUcP3nv4k0FGr3MQAyjYcsK3MSRVLps9ovPS+utGcuZeGRqLdOIeZtY
         si72vxkspvtp22ZCejJPsr7pK4DRMBUzlUlAGWffJQlUIjjdfS3kSza8AEEL0WFCm55O
         RzTTo0EdAHAQS3naobZiToeHrTPk5ZhOlnmhmj06UEWa90lcj0sAIogOXNcr2QRKCRTv
         HLyA==
X-Forwarded-Encrypted: i=1; AJvYcCUt1GxQej4aHmt15UoAPlHnLLSmEH5Ijqv3IVzT+x0lqbUePf2SE9RkOwk4t0iA+zTnZrSAeCPl61shoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOl2N1YSrHJKNAN8Q1JhZVGqaaZrdPa/FDZ8xNrvGpO0nc2olM
	eKIYmy0MJiqtC9RYI+ACwEZbyC32Jhx02Pk5C7SfVER/GB+inKKvfj29kX9hv1cXG3K4SGQvsuv
	NAJk/yBeVdT/NLuQ2b569ANDFu6sSZnGowzlXzSNuaSMYfLqat+Y/fFQveBE=
X-Google-Smtp-Source: AGHT+IGdjBNibW3nBb7m91Y5ggiqKO2nAio5DTJW2jbNaNJ5bYLcQUAcT0RkbYmtAZVg69x5zaHRQl1ZZtp9b31mmemkHL+EwyvE
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:42d:84ec:b5da with SMTP id
 e9e14a558f8ab-431ebe051b2mr12316495ab.10.1761271646996; Thu, 23 Oct 2025
 19:07:26 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:07:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fadf5e.050a0220.346f24.008d.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in write_all_supers
From: syzbot <syzbot+f568e0df818a4f9d0dbb@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    93f3bab4310d Add linux-next specific files for 20251017
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f96b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=408308c229eef498
dashboard link: https://syzkaller.appspot.com/bug?extid=f568e0df818a4f9d0dbb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c955a9337646/disk-93f3bab4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/843962ea5283/vmlinux-93f3bab4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42360a7c5734/bzImage-93f3bab4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f568e0df818a4f9d0dbb@syzkaller.appspotmail.com

BTRFS info (device loop3): enabling ssd optimizations
BTRFS info (device loop3): turning on async discard
BTRFS info (device loop3): enabling free space tree
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.3.3420/21516 is trying to acquire lock:
ffff88805a8954d8 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: write_all_supers+0x13fa/0x47d0 fs/btrfs/disk-io.c:4027

but task is already holding lock:
ffff8880585647c0 (&fs_info->tree_log_mutex){+.+.}-{4:4}, at: btrfs_sync_log+0x1dc7/0x29a0 fs/btrfs/tree-log.c:3552

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&fs_info->tree_log_mutex){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       btrfs_sync_log+0x1dc7/0x29a0 fs/btrfs/tree-log.c:3552
       btrfs_sync_file+0xcf9/0x1160 fs/btrfs/file.c:1771
       generic_write_sync include/linux/fs.h:3046 [inline]
       btrfs_do_write_iter+0x689/0x820 fs/btrfs/file.c:1470
       do_iter_readv_writev+0x623/0x8c0 fs/read_write.c:-1
       vfs_writev+0x31a/0x960 fs/read_write.c:1057
       do_pwritev fs/read_write.c:1153 [inline]
       __do_sys_pwritev2 fs/read_write.c:1211 [inline]
       __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       join_transaction+0x1a4/0xd70 fs/btrfs/transaction.c:321
       start_transaction+0x6b6/0x1620 fs/btrfs/transaction.c:705
       btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6282
       inode_update_time fs/inode.c:2117 [inline]
       touch_atime+0x2f9/0x6d0 fs/inode.c:2190
       file_accessed include/linux/fs.h:2673 [inline]
       filemap_read+0x1002/0x11a0 mm/filemap.c:2826
       __kernel_read+0x4cf/0x960 fs/read_write.c:530
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x85e/0x16f0 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x428/0x8f0 security/integrity/ima/ima_api.c:293
       process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:405
       ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:656
       security_file_post_open+0xbb/0x290 security/security.c:3199
       do_open fs/namei.c:3977 [inline]
       path_openat+0x2f26/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (btrfs_trans_num_writers){++++}-{0:0}:
       reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
       percpu_up_read include/linux/percpu-rwsem.h:112 [inline]
       __sb_end_write include/linux/fs.h:1911 [inline]
       sb_end_intwrite+0x26/0x1c0 include/linux/fs.h:2028
       __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1076
       btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6296
       inode_update_time fs/inode.c:2117 [inline]
       touch_atime+0x2f9/0x6d0 fs/inode.c:2190
       file_accessed include/linux/fs.h:2673 [inline]
       btrfs_file_mmap_prepare+0x176/0x1f0 fs/btrfs/file.c:2052
       vfs_mmap_prepare include/linux/fs.h:2410 [inline]
       call_mmap_prepare mm/vma.c:2593 [inline]
       __mmap_region mm/vma.c:2671 [inline]
       mmap_region+0xb38/0x1c70 mm/vma.c:2764
       do_mmap+0xc45/0x10d0 mm/mmap.c:558
       vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:581
       ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1560
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:377
       get_mmap_lock_carefully mm/mmap_lock.c:377 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:428
       do_user_addr_fault+0x331/0x1380 arch/x86/mm/fault.c:1359
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
       user_access_begin arch/x86/include/asm/uaccess.h:-1 [inline]
       filldir+0x29c/0x6c0 fs/readdir.c:290
       dir_emit_dot include/linux/fs.h:3991 [inline]
       dir_emit_dots include/linux/fs.h:4002 [inline]
       offset_readdir+0x1e6/0x560 fs/libfs.c:569
       iterate_dir+0x399/0x570 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:326 [inline]
       __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&type->i_mutex_dir_key#5){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       inode_lock_shared include/linux/fs.h:995 [inline]
       lookup_slow+0x46/0x70 fs/namei.c:1832
       walk_component+0x2d2/0x400 fs/namei.c:2151
       lookup_last fs/namei.c:2652 [inline]
       path_lookupat+0x163/0x430 fs/namei.c:2676
       filename_lookup+0x212/0x570 fs/namei.c:2705
       kern_path+0x35/0x50 fs/namei.c:2863
       is_same_device fs/btrfs/volumes.c:759 [inline]
       device_list_add+0xe2a/0x22a0 fs/btrfs/volumes.c:894
       btrfs_scan_one_device+0x3ee/0x650 fs/btrfs/volumes.c:1493
       btrfs_get_tree_super fs/btrfs/super.c:1865 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2088 [inline]
       btrfs_get_tree+0x436/0x1810 fs/btrfs/super.c:2122
       vfs_get_tree+0x92/0x2b0 fs/super.c:1751
       fc_mount fs/namespace.c:1208 [inline]
       do_new_mount_fc fs/namespace.c:3651 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3727
       do_mount fs/namespace.c:4050 [inline]
       __do_sys_mount fs/namespace.c:4238 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4215
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       write_all_supers+0x13fa/0x47d0 fs/btrfs/disk-io.c:4027
       btrfs_sync_log+0x1e95/0x29a0 fs/btrfs/tree-log.c:3571
       btrfs_sync_file+0xcf9/0x1160 fs/btrfs/file.c:1771
       generic_write_sync include/linux/fs.h:3046 [inline]
       btrfs_do_write_iter+0x689/0x820 fs/btrfs/file.c:1470
       aio_write+0x535/0x7a0 fs/aio.c:1634
       __io_submit_one fs/aio.c:-1 [inline]
       io_submit_one+0x78b/0x1310 fs/aio.c:2053
       __do_sys_io_submit fs/aio.c:2112 [inline]
       __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2082
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &fs_devs->device_list_mutex --> btrfs_trans_num_extwriters --> &fs_info->tree_log_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->tree_log_mutex);
                               lock(btrfs_trans_num_extwriters);
                               lock(&fs_info->tree_log_mutex);
  lock(&fs_devs->device_list_mutex);

 *** DEADLOCK ***

4 locks held by syz.3.3420/21516:
 #0: ffff8880491ea610 (sb_internal#5){.+.+}-{0:0}, at: btrfs_sync_file+0xbf5/0x1160 fs/btrfs/file.c:1726
 #1: ffff888058566538 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x41b/0xd70 fs/btrfs/transaction.c:296
 #2: ffff888058566560 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x41b/0xd70 fs/btrfs/transaction.c:296
 #3: ffff8880585647c0 (&fs_info->tree_log_mutex){+.+.}-{4:4}, at: btrfs_sync_log+0x1dc7/0x29a0 fs/btrfs/tree-log.c:3552

stack backtrace:
CPU: 1 UID: 0 PID: 21516 Comm: syz.3.3420 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:598 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
 write_all_supers+0x13fa/0x47d0 fs/btrfs/disk-io.c:4027
 btrfs_sync_log+0x1e95/0x29a0 fs/btrfs/tree-log.c:3571
 btrfs_sync_file+0xcf9/0x1160 fs/btrfs/file.c:1771
 generic_write_sync include/linux/fs.h:3046 [inline]
 btrfs_do_write_iter+0x689/0x820 fs/btrfs/file.c:1470
 aio_write+0x535/0x7a0 fs/aio.c:1634
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x78b/0x1310 fs/aio.c:2053
 __do_sys_io_submit fs/aio.c:2112 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2082
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe47278efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe4736ad038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007fe4729e5fa0 RCX: 00007fe47278efc9
RDX: 0000200000000540 RSI: 000000000000003b RDI: 00007fe473684000
RBP: 00007fe472811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe4729e6038 R14: 00007fe4729e5fa0 R15: 00007fff3a4e1998
 </TASK>
BTRFS info (device loop3): last unmount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

