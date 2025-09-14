Return-Path: <linux-btrfs+bounces-16803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF2FB5671D
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 08:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4409B7A500E
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D622798EC;
	Sun, 14 Sep 2025 06:44:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA528610B
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757832273; cv=none; b=gm8p4bIEA/i0djB9d3eOL6h+TMewUyludwFQ28Mtql3ErdURt9fLTD5/SN39czDrMwa+EfpzaB8nYwJBM9sFm8Ajob3lxPZ1CsZI/qmxO4gWxN7RnbcmCmvOHvmNkcEwb5AEPyme580p10tFFuaGQvskr4xPuEFDAycLD9NZWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757832273; c=relaxed/simple;
	bh=jrBUgjlBPg3x+xR9tOFzZ7evCjzU70FLUvMZaPXfLU0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q7f1XAHJ36oKexH3JLvuRG56ltIQ3Kxt1qeIuDCLtbvMhpt56IhyQtmyQuMX0n5RVG3p6imgq1uvI0uBCbK5apNxdVTak5EtXgQ6JHBDbow4A5B+7v4Z/LRVKW+ZYoqzMxyHMNl4cg+Y8FMRalJiBEafYjY4f6wlBOE5M4omP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886e347d26bso376734439f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Sep 2025 23:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757832271; x=1758437071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jh7N12ZIznXRHjwEs6OTGR6qER4A9V+V4hq5c1+Q5M0=;
        b=VrRdYjHHIqy2hCMkR1SbZ232I9Lww4LtY2+VHPlvmm/YUM1XVc2FPlDpvbtu6fYxOv
         /3DrXRqMASpTOOXUgmCYtz5tUns9niQAv+1lWXNvXGUbbaQQ4/DGPfiSjPORgFehWArA
         1oPecy4gQhGpUjdcRQEUNjVLUI72k7jQkr92HgpHW3bYPqURMluC0Df+ovhFLKxqQ3GV
         V7gJkvMwv9HrPdGDolRMYZqlB1N+w+gwPVJxn/iox1smLp4v9RMqXMWgL5SgX5DQiRGH
         qcdTTx5GqdflL4bDPE3k+PBl3+2uOamVXmd75JGoEiaeAGpVcfn8tNwy8A6gJH4t3We5
         EiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk4c9lulAMWYlG4LH7CGGOZuXWIl15/+BM+BPj9sg9KuSF4BrDTE/ErvM6BuWex/ble67IC3+L1vPyzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynwuCnVCHebNYNHZEIrn3sHBjGrTQh4S/c0ClZrAomc+dSpt9f
	BxR0IWqqtbRVrqpw0FGSDycChihGNW/U1B+y7t3cQoRG32TSgCynFTLgI1ndAMPZJTSG48f5GiB
	zyIGsh7gwE+4wkzHOpdrkvJrhzL1tgeJSQU1YVHaYk14hsACe799yuaLAZFo=
X-Google-Smtp-Source: AGHT+IEZ5IhsR463Dw++PpgMh4V7QbV0n/WlF9fEr8a3j/QEwJbAiEqAecsP4HWzjr+0FuuStlJ9F18XBRsBKU6ph9ZeKVYnplpp
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:489:b0:887:601:c5f6 with SMTP id
 ca18e2360f4ac-89029880341mr1131890939f.7.1757832270841; Sat, 13 Sep 2025
 23:44:30 -0700 (PDT)
Date: Sat, 13 Sep 2025 23:44:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c6644e.050a0220.50883.0000.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in iterate_dir (3)
From: syzbot <syzbot+e290013facb5d5159eca@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d47562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=e290013facb5d5159eca
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63dc392685dc/disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3dfcfb97806e/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddb10128aeb8/bzImage-9dd1835e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e290013facb5d5159eca@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.2.243/11919 is trying to acquire lock:
ffff88803c665110 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:462

but task is already holding lock:
ffff8880298fbd68 (&type->i_mutex_dir_key#5){++++}-{4:4}, at: iterate_dir+0x29e/0x580 fs/readdir.c:101

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&type->i_mutex_dir_key#5){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x97/0x1f0 kernel/locking/rwsem.c:1537
       inode_lock_shared include/linux/fs.h:885 [inline]
       lookup_slow+0x46/0x70 fs/namei.c:1824
       walk_component+0x2d2/0x400 fs/namei.c:2129
       lookup_last fs/namei.c:2630 [inline]
       path_lookupat+0x163/0x430 fs/namei.c:2654
       filename_lookup+0x212/0x570 fs/namei.c:2683
       kern_path+0x35/0x50 fs/namei.c:2816
       is_same_device fs/btrfs/volumes.c:759 [inline]
       device_list_add+0xe2a/0x22a0 fs/btrfs/volumes.c:894
       btrfs_scan_one_device+0x3ee/0x650 fs/btrfs/volumes.c:1493
       btrfs_get_tree_super fs/btrfs/super.c:1853 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
       btrfs_get_tree+0x433/0x1820 fs/btrfs/super.c:2111
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
       do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
       do_mount fs/namespace.c:4136 [inline]
       __do_sys_mount fs/namespace.c:4347 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4324
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/rtmutex_api.c:535 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:547
       btrfs_run_dev_stats+0x102/0x10e0 fs/btrfs/volumes.c:7772
       commit_cowonly_roots+0x1b2/0x860 fs/btrfs/transaction.c:1348
       btrfs_commit_transaction+0xfc7/0x3950 fs/btrfs/transaction.c:2462
       sync_filesystem+0x1ce/0x250 fs/sync.c:66
       __do_sys_syncfs fs/sync.c:160 [inline]
       __se_sys_syncfs+0x94/0x110 fs/sync.c:149
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&fs_info->reloc_mutex){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/rtmutex_api.c:535 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:547
       btrfs_commit_transaction+0xedd/0x3950 fs/btrfs/transaction.c:2408
       sync_filesystem+0x1ce/0x250 fs/sync.c:66
       __do_sys_syncfs fs/sync.c:160 [inline]
       __se_sys_syncfs+0x94/0x110 fs/sync.c:149
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (btrfs_trans_unblocked){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       wait_current_trans+0x22b/0x520 fs/btrfs/transaction.c:531
       start_transaction+0x6d1/0x1620 fs/btrfs/transaction.c:707
       btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6235
       inode_update_time fs/inode.c:2075 [inline]
       touch_atime+0x2f9/0x6d0 fs/inode.c:2148
       file_accessed include/linux/fs.h:2664 [inline]
       filemap_read+0x100b/0x11a0 mm/filemap.c:2784
       __kernel_read+0x4d5/0x970 fs/read_write.c:530
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x86a/0x1700 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x42e/0x8e0 security/integrity/ima/ima_api.c:293
       process_measurement+0x112d/0x1a40 security/integrity/ima/ima_main.c:405
       ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:633
       security_file_post_open+0xbb/0x290 security/security.c:3160
       do_open fs/namei.c:3889 [inline]
       path_openat+0x2f32/0x3840 fs/namei.c:4046
       do_filp_open+0x1fa/0x410 fs/namei.c:4073
       do_sys_openat2+0x121/0x1c0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sb_internal#2){.+.+}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1799 [inline]
       sb_start_intwrite include/linux/fs.h:1982 [inline]
       start_transaction+0x56e/0x1620 fs/btrfs/transaction.c:699
       btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6235
       inode_update_time fs/inode.c:2075 [inline]
       touch_atime+0x2f9/0x6d0 fs/inode.c:2148
       file_accessed include/linux/fs.h:2664 [inline]
       btrfs_file_mmap_prepare+0xde/0x150 fs/btrfs/file.c:2050
       vfs_mmap_prepare include/linux/fs.h:2295 [inline]
       call_mmap_prepare mm/vma.c:2585 [inline]
       __mmap_region mm/vma.c:2653 [inline]
       mmap_region+0xb49/0x20a0 mm/vma.c:2739
       do_mmap+0xc23/0x10c0 mm/mmap.c:558
       vm_mmap_pgoff+0x2a9/0x4d0 mm/util.c:580
       ksys_mmap_pgoff+0x4e9/0x720 mm/mmap.c:604
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read_killable+0x9d/0x220 kernel/locking/rwsem.c:1560
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:462
       get_mmap_lock_carefully mm/mmap_lock.c:286 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:337
       do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1359
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       user_access_begin arch/x86/include/asm/uaccess.h:-1 [inline]
       filldir+0x2a2/0x6c0 fs/readdir.c:290
       dir_emit_dot include/linux/fs.h:3963 [inline]
       dir_emit_dots include/linux/fs.h:3974 [inline]
       offset_readdir+0x1e3/0x560 fs/libfs.c:569
       iterate_dir+0x3a2/0x580 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:326 [inline]
       __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &fs_devs->device_list_mutex --> &type->i_mutex_dir_key#5

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&type->i_mutex_dir_key#5);
                               lock(&fs_devs->device_list_mutex);
                               lock(&type->i_mutex_dir_key#5);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.2.243/11919:
 #0: ffff8880302b6928 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x253/0x320 fs/file.c:1232
 #1: ffff8880298fbd68 (&type->i_mutex_dir_key#5){++++}-{4:4}, at: iterate_dir+0x29e/0x580 fs/readdir.c:101

stack backtrace:
CPU: 1 UID: 0 PID: 11919 Comm: syz.2.243 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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
 down_read_killable+0x9d/0x220 kernel/locking/rwsem.c:1560
 mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:462
 get_mmap_lock_carefully mm/mmap_lock.c:286 [inline]
 lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:337
 do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1359
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:filldir+0x2a2/0x6c0 fs/readdir.c:294
Code: 8f ff 4c 89 ff 4c 89 e6 e8 9b 19 8f ff 4d 39 e7 0f 82 7c 02 00 00 49 39 ef 0f 87 73 02 00 00 0f 01 cb 0f ae e8 48 8b 44 24 50 <49> 89 44 24 08 48 8b 4c 24 08 48 8b 44 24 58 48 89 01 48 8b 04 24
RSP: 0018:ffffc9000c6b7c90 EFLAGS: 00050287
RAX: 0000000000000000 RBX: ffffc9000c6b7e38 RCX: ffff88805b34d940
RDX: 0000000000000000 RSI: 0000200000001fc0 RDI: 0000200000001fd8
RBP: 00007ffffffff000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: ffffffff822f4620 R12: 0000200000001fc0
R13: ffffffff8b191ce0 R14: 0000000000000001 R15: 0000200000001fd8
 dir_emit_dot include/linux/fs.h:3963 [inline]
 dir_emit_dots include/linux/fs.h:3974 [inline]
 offset_readdir+0x1e3/0x560 fs/libfs.c:569
 iterate_dir+0x3a2/0x580 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:326 [inline]
 __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f974ee8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9744ccd038 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f974f0d6090 RCX: 00007f974ee8eba9
RDX: 00000000000000b8 RSI: 0000200000001fc0 RDI: 0000000000000004
RBP: 00007f974ef11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f974f0d6128 R14: 00007f974f0d6090 R15: 00007ffce04f3a78
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	ff 4c 89 ff          	decl   -0x1(%rcx,%rcx,4)
   4:	4c 89 e6             	mov    %r12,%rsi
   7:	e8 9b 19 8f ff       	call   0xff8f19a7
   c:	4d 39 e7             	cmp    %r12,%r15
   f:	0f 82 7c 02 00 00    	jb     0x291
  15:	49 39 ef             	cmp    %rbp,%r15
  18:	0f 87 73 02 00 00    	ja     0x291
  1e:	0f 01 cb             	stac
  21:	0f ae e8             	lfence
  24:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
* 29:	49 89 44 24 08       	mov    %rax,0x8(%r12) <-- trapping instruction
  2e:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  33:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  38:	48 89 01             	mov    %rax,(%rcx)
  3b:	48 8b 04 24          	mov    (%rsp),%rax


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

