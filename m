Return-Path: <linux-btrfs+bounces-13048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474ABA8A8BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 22:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6B73AB24B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 20:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E373250C19;
	Tue, 15 Apr 2025 20:01:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034912B94
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747287; cv=none; b=mrb5hTKj5e0JABFuf2OVG/HXl5MjgRMSl8FoukB9j4ZME4qPcSTAD5EJDNzJ7xsOArs9yw9Rf6cv5JZy/Idr6gyUWX4EIEhKEBsX9i+ukriPutVaO/LYPpr41nBWMq1LVPj135u9L14+ZBMd87U338yaaVjJ2WCHiI/PA3ftA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747287; c=relaxed/simple;
	bh=Usm2M5bnAo/HSl150oO1o+J3zItBelXX36gm8k/vIPw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QpdiU1KTmP/8lu2TxOAVrRpZPEAeI1GpjzZmchk4AZ6lWvM+Ql7pY3jYXNwBCboU9yk0QfhH4C9ivBmjiHdhO1ipMPv6uQNOp9869EeM5mPEs+jUQkPUbwTQjA2AdCICCRMjE0tEfh0RFpGeNhVPIW++8T1jVU06Ud++l0KYT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b3b781313so887471139f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 13:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744747285; x=1745352085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnHtifw9HzEB56XAmpErjelYWSi2G7xtAsvYBCQ9nwE=;
        b=v+/k5GparCYCoLoGVnKqgQsMDkn0p2h5ckp9j7Ku8wb8Iu6VvmdGSeSNorE05n8tQW
         pluWeFK2U4EvDqmwF7bBfCU4iD1kXVrCSOINTIRiKIoLdL7MdHczfuXOr7Q8rh1LIU9K
         pbHPaBtFhuO6rUHwLWVqMZaTfE/o0l4Aoyv6ioEys5QR0Q30YkyTJIjTYeW5MA5lN4De
         m+VklHd68pYXQIDympeau/1oXA8KVUDOdGhCPLkOJVpSjjIk5CWGhIaAsUXBXjSNZ4eX
         dV8FZmBJN1iazM3ufnTTY4xDtyqDAYWZzuSO4r1WLS+CYFK5peLko7jlqI9lA/flVaTM
         JX1A==
X-Forwarded-Encrypted: i=1; AJvYcCUvMXWawsCkkmFv7qSKUNhK0V3feQrdVt0wabZ84Soy3vT4ZtIdRSXtB2fS43ZhsNYf5urSQvx/v3ZVsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydQ6BOi4/su+i+kjGMhjmX79+P0v5c3CMNq3xgVq/2qTL5twcr
	eixJftuKIr7FhF1dX2iqLcXBvUUnGlt6fStxucJMMPTzyNzNaUcV9wrpL0RKnl72Fif6B8zF0VF
	85MxUEaXf9cJP3i0qP7iGXEcXkZcbRQm1f/wBWUmm7r6Drw0Q1nltgOc=
X-Google-Smtp-Source: AGHT+IHvo41MGyjbRjEZ32aZi5o+HJU3qnJ+hZI6GIo3G29ymS+lA0LmWj8UhFxxk6mKmRi6IRIkUWyctb0UEil8nImb8urxFMzp
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d812535d88mr8619085ab.12.1744747284220; Tue, 15 Apr 2025
 13:01:24 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:01:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67febb14.050a0220.186b78.000a.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_relocate_block_group
From: syzbot <syzbot+9b6689eb2b9692c761ea@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a1d569a75f3 Merge tag 'edac_urgent_for_v6.15_rc3' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f92470580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a972ee73c2fcf8ca
dashboard link: https://syzkaller.appspot.com/bug?extid=9b6689eb2b9692c761ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-1a1d569a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3cbccbd209b5/vmlinux-1a1d569a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2957e37f5adf/bzImage-1a1d569a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b6689eb2b9692c761ea@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid e417788f-7a09-42b2-9266-8ddc5d5d35d2 devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5328)
BTRFS info (device loop0): first mount of filesystem e417788f-7a09-42b2-9266-8ddc5d5d35d2
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): disk space caching is enabled
BTRFS warning (device loop0): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): balance: start -d -m
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.15.0-rc2-syzkaller-00042-g1a1d569a75f3 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x424/0x570 lib/fault-inject.c:174
 should_failslab+0xac/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4180 [inline]
 kmem_cache_alloc_noprof+0x78/0x390 mm/slub.c:4207
 add_delayed_ref+0x1a0/0x1e90 fs/btrfs/delayed-ref.c:1007
 btrfs_free_tree_block+0x361/0xd10 fs/btrfs/extent-tree.c:3434
 btrfs_force_cow_block+0xf6c/0x2010 fs/btrfs/ctree.c:555
 btrfs_cow_block+0x377/0x840 fs/btrfs/ctree.c:688
 btrfs_search_slot+0xc12/0x31c0 fs/btrfs/ctree.c:2088
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4287
 btrfs_insert_empty_item fs/btrfs/ctree.h:673 [inline]
 btrfs_insert_empty_inode+0x1de/0x2f0 fs/btrfs/inode-item.c:391
 __insert_orphan_inode fs/btrfs/relocation.c:3714 [inline]
 create_reloc_inode+0x408/0xa50 fs/btrfs/relocation.c:3785
 btrfs_relocate_block_group+0x554/0xd80 fs/btrfs/relocation.c:3991
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
 __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
 btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
 btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f830078d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83016c0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f83009a5fa0 RCX: 00007f830078d169
RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 00007f83016c0090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f83009a5fa0 R15: 00007ffc9409cc88
 </TASK>
BTRFS error (device loop0 state A): Transaction aborted (error -12)
BTRFS: error (device loop0 state A) in btrfs_force_cow_block:560: errno=-12 Out of memory
BTRFS info (device loop0 state EA): forced readonly
BTRFS info (device loop0 state EA): relocating block group 6881280 flags data|metadata
Oops: general protection fault, probably for non-canonical address 0xdffffc000000008c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000460-0x0000000000000467]
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.15.0-rc2-syzkaller-00042-g1a1d569a75f3 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:iput+0x3b/0xa50 fs/inode.c:1914
Code: 38 49 89 fe e8 f6 ef 7b ff 4d 85 f6 0f 84 8c 03 00 00 49 bd 00 00 00 00 00 fc ff df 4d 8d be d0 00 00 00 4c 89 fb 48 c1 eb 03 <42> 0f b6 04 2b 84 c0 0f 85 c4 08 00 00 48 89 5c 24 10 41 8b 1f bd
RSP: 0018:ffffc9000d0879c0 EFLAGS: 00010203
RAX: ffffffff8247653a RBX: 000000000000008c RCX: ffff888000cb2440
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000394
RBP: ffff888053019010 R08: ffff888052a5a80b R09: 1ffff1100a54b501
R10: dffffc0000000000 R11: ffffed100a54b502 R12: ffff888052a4c000
R13: dffffc0000000000 R14: 0000000000000394 R15: 0000000000000464
FS:  00007f83016c06c0(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f830169efd8 CR3: 0000000034ce6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_relocate_block_group+0xb86/0xd80 fs/btrfs/relocation.c:4052
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
 __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
 btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
 btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f830078d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83016c0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f83009a5fa0 RCX: 00007f830078d169
RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 00007f83016c0090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f83009a5fa0 R15: 00007ffc9409cc88
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x3b/0xa50 fs/inode.c:1914
Code: 38 49 89 fe e8 f6 ef 7b ff 4d 85 f6 0f 84 8c 03 00 00 49 bd 00 00 00 00 00 fc ff df 4d 8d be d0 00 00 00 4c 89 fb 48 c1 eb 03 <42> 0f b6 04 2b 84 c0 0f 85 c4 08 00 00 48 89 5c 24 10 41 8b 1f bd
RSP: 0018:ffffc9000d0879c0 EFLAGS: 00010203
RAX: ffffffff8247653a RBX: 000000000000008c RCX: ffff888000cb2440
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000394
RBP: ffff888053019010 R08: ffff888052a5a80b R09: 1ffff1100a54b501
R10: dffffc0000000000 R11: ffffed100a54b502 R12: ffff888052a4c000
R13: dffffc0000000000 R14: 0000000000000394 R15: 0000000000000464
FS:  00007f83016c06c0(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f830167dfd8 CR3: 0000000034ce6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	49 89 fe             	mov    %rdi,%r14
   3:	e8 f6 ef 7b ff       	call   0xff7beffe
   8:	4d 85 f6             	test   %r14,%r14
   b:	0f 84 8c 03 00 00    	je     0x39d
  11:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  18:	fc ff df
  1b:	4d 8d be d0 00 00 00 	lea    0xd0(%r14),%r15
  22:	4c 89 fb             	mov    %r15,%rbx
  25:	48 c1 eb 03          	shr    $0x3,%rbx
* 29:	42 0f b6 04 2b       	movzbl (%rbx,%r13,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 c4 08 00 00    	jne    0x8fa
  36:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
  3b:	41 8b 1f             	mov    (%r15),%ebx
  3e:	bd                   	.byte 0xbd


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

