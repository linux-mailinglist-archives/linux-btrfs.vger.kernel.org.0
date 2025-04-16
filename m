Return-Path: <linux-btrfs+bounces-13061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EEA8B48E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F8E7A7F1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF0323371A;
	Wed, 16 Apr 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRYch43J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707A225A3C;
	Wed, 16 Apr 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793947; cv=none; b=YIwBOjK1++B3i0Pcp3Ma4dmoJs4Oul88MjQmLZFa1vtAjtlyXsn+Lw/7L6uEVxABNv9LnEljdA3voaB/fAzr+0Oo1Ya9U6ezPVnVvaU684vjRizQFr+i3qg6vBNh/rGtrW49OKff2MFCySA/Lh5fMt0czvtuLMZ8PqGnyuDCjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793947; c=relaxed/simple;
	bh=77xW6ec/3xetSN3QR6t4CyQOSb2vev0hWUmFBPKE0h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHVZjLz3XRwmN+MoFbX5JUNyQAs5NfzsQTvXogx4u4hyK3W0r9hcpO0Zq0lik71OUKU4wvd5/9PoiRg4yonVSIGY8UxTcV4wLnkwjhzAyDfWYOw++I13gTMTJhKo/62owiayDo2h5AQUmnSv7L5cq6TUd9l7XatTK5poDjeza40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRYch43J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9B1C4CEE9;
	Wed, 16 Apr 2025 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744793946;
	bh=77xW6ec/3xetSN3QR6t4CyQOSb2vev0hWUmFBPKE0h0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DRYch43JfrtxLkNNirV3qsCFwtVmH6wq4hQb6gqemVjMiCFrnZD5gKr8wkSK+ZO1r
	 xIsKHpnpQcJrm2C+18cvV/Wmy1yEo8vROGW6gLGw3FTGxsazg7nAvk58Bx198jNeRh
	 ro+uat9eroZiwX51hHtnY8xmkOxxxVHBGofVBwdbR2/O0CJKZf1W1QZi0mRUKp3d+9
	 pEYbtdArN8J7k+mGHCY7C18c90qfhkezcQo+kV5384Q+k9K/ZxJa9yxiVxyQ17dL34
	 Lf77L5u554W3Shk+ZaSUbOxZxTYcNQ4hpEmHvB6y9OGLuNDrl3fqZBLRva7uoXGRas
	 FKknFYEdfS7Hw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac25d2b2354so1016682466b.1;
        Wed, 16 Apr 2025 01:59:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb7ygBLc1azSPrx8jzN3ctjULt8TuzieyxljeLxMrO59GPfIVAZcw8oSDbdDTm+FyFfZ/Q6szEnuQD2A==@vger.kernel.org, AJvYcCWv0vISWM/IZy95SdvPzwafQjw1vsTStjbeUOh9+2rz8ptYh85Ts/Kozm9g2R+GTU8bGt0JyxfXXJCwHZqj@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrFoIOOHQq+ud3lIi2oV7NA5WLv/QCVT5uWKftooZVhlEeX06
	ZPyHY751BRa7QXa5vlEb/j4CQ2Z4rbs+NgwB2KsMBvwrJXtEVkPQ4EZhUPX9QPyKPiAt5kuRslq
	jFaQtBtDXH7zbMAT7JIF0F6u77is=
X-Google-Smtp-Source: AGHT+IGi4ezCFNC3plR942u9UfIy85h5LUDj8N7Ruqh/16Nr4wLj8mZR+xHrC+Fnht5lykqvALoY8MoT+kwHy84EOxo=
X-Received: by 2002:a17:907:6e87:b0:acb:34b1:4442 with SMTP id
 a640c23a62f3a-acb42b8eb83mr90200666b.48.1744793945147; Wed, 16 Apr 2025
 01:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67febb14.050a0220.186b78.000a.GAE@google.com>
In-Reply-To: <67febb14.050a0220.186b78.000a.GAE@google.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Apr 2025 09:58:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6DJfaN7iXcT9yuOFWeycRHJHjZhDigFwUALyMXaBjnwg@mail.gmail.com>
X-Gm-Features: ATxdqUEozPAdF2l_9huJxRbgzTH7OkJJUqZN5jNtqV1JWEIzJpBOo6IrbcsNosQ
Message-ID: <CAL3q7H6DJfaN7iXcT9yuOFWeycRHJHjZhDigFwUALyMXaBjnwg@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_relocate_block_group
To: syzbot <syzbot+9b6689eb2b9692c761ea@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 9:01=E2=80=AFPM syzbot
<syzbot+9b6689eb2b9692c761ea@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1a1d569a75f3 Merge tag 'edac_urgent_for_v6.15_rc3' of git=
:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10f9247058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da972ee73c2fcf=
8ca
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9b6689eb2b9692c=
761ea
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-1a1d569a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3cbccbd209b5/vmlinu=
x-1a1d569a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2957e37f5adf/b=
zImage-1a1d569a.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9b6689eb2b9692c761ea@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 32768
> BTRFS: device fsid e417788f-7a09-42b2-9266-8ddc5d5d35d2 devid 1 transid 8=
 /dev/loop0 (7:0) scanned by syz.0.0 (5328)
> BTRFS info (device loop0): first mount of filesystem e417788f-7a09-42b2-9=
266-8ddc5d5d35d2
> BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum alg=
orithm
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS warning (device loop0): space cache v1 is being deprecated and will=
 be removed in a future release, please use -o space_cache=3Dv2
> BTRFS info (device loop0): rebuilding free space tree
> BTRFS info (device loop0): disabling free space tree
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE=
_TREE (0x1)
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE=
_TREE_VALID (0x2)
> BTRFS info (device loop0): balance: start -d -m
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.15.0-rc2-syzkaller-00=
042-g1a1d569a75f3 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  fail_dump lib/fault-inject.c:73 [inline]
>  should_fail_ex+0x424/0x570 lib/fault-inject.c:174
>  should_failslab+0xac/0x100 mm/failslab.c:46
>  slab_pre_alloc_hook mm/slub.c:4104 [inline]
>  slab_alloc_node mm/slub.c:4180 [inline]
>  kmem_cache_alloc_noprof+0x78/0x390 mm/slub.c:4207
>  add_delayed_ref+0x1a0/0x1e90 fs/btrfs/delayed-ref.c:1007
>  btrfs_free_tree_block+0x361/0xd10 fs/btrfs/extent-tree.c:3434
>  btrfs_force_cow_block+0xf6c/0x2010 fs/btrfs/ctree.c:555
>  btrfs_cow_block+0x377/0x840 fs/btrfs/ctree.c:688
>  btrfs_search_slot+0xc12/0x31c0 fs/btrfs/ctree.c:2088
>  btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4287
>  btrfs_insert_empty_item fs/btrfs/ctree.h:673 [inline]
>  btrfs_insert_empty_inode+0x1de/0x2f0 fs/btrfs/inode-item.c:391
>  __insert_orphan_inode fs/btrfs/relocation.c:3714 [inline]
>  create_reloc_inode+0x408/0xa50 fs/btrfs/relocation.c:3785
>  btrfs_relocate_block_group+0x554/0xd80 fs/btrfs/relocation.c:3991
>  btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
>  __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
>  btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
>  btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f830078d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f83016c0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f83009a5fa0 RCX: 00007f830078d169
> RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
> RBP: 00007f83016c0090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> R13: 0000000000000000 R14: 00007f83009a5fa0 R15: 00007ffc9409cc88
>  </TASK>
> BTRFS error (device loop0 state A): Transaction aborted (error -12)
> BTRFS: error (device loop0 state A) in btrfs_force_cow_block:560: errno=
=3D-12 Out of memory
> BTRFS info (device loop0 state EA): forced readonly
> BTRFS info (device loop0 state EA): relocating block group 6881280 flags =
data|metadata
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc000000008c: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000460-0x0000000000000467]
> CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.15.0-rc2-syzkaller-00=
042-g1a1d569a75f3 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> RIP: 0010:iput+0x3b/0xa50 fs/inode.c:1914
> Code: 38 49 89 fe e8 f6 ef 7b ff 4d 85 f6 0f 84 8c 03 00 00 49 bd 00 00 0=
0 00 00 fc ff df 4d 8d be d0 00 00 00 4c 89 fb 48 c1 eb 03 <42> 0f b6 04 2b=
 84 c0 0f 85 c4 08 00 00 48 89 5c 24 10 41 8b 1f bd
> RSP: 0018:ffffc9000d0879c0 EFLAGS: 00010203
> RAX: ffffffff8247653a RBX: 000000000000008c RCX: ffff888000cb2440
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000394
> RBP: ffff888053019010 R08: ffff888052a5a80b R09: 1ffff1100a54b501
> R10: dffffc0000000000 R11: ffffed100a54b502 R12: ffff888052a4c000
> R13: dffffc0000000000 R14: 0000000000000394 R15: 0000000000000464
> FS:  00007f83016c06c0(0000) GS:ffff88808c593000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f830169efd8 CR3: 0000000034ce6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  btrfs_relocate_block_group+0xb86/0xd80 fs/btrfs/relocation.c:4052
>  btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
>  __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
>  btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
>  btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This seems to have the same cause as:

https://lore.kernel.org/linux-btrfs/67f14ee9.050a0220.0a13.023e.GAE@google.=
com/

For which there's a fix on the btrfs mailing list and btrfs' github
repo (for-next branch):

https://lore.kernel.org/linux-btrfs/9ac220a55a540ad22f7cb198856b689079f3e8c=
6.1743875430.git.fdmanana@suse.com/



> RIP: 0033:0x7f830078d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f83016c0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f83009a5fa0 RCX: 00007f830078d169
> RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
> RBP: 00007f83016c0090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> R13: 0000000000000000 R14: 00007f83009a5fa0 R15: 00007ffc9409cc88
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:iput+0x3b/0xa50 fs/inode.c:1914
> Code: 38 49 89 fe e8 f6 ef 7b ff 4d 85 f6 0f 84 8c 03 00 00 49 bd 00 00 0=
0 00 00 fc ff df 4d 8d be d0 00 00 00 4c 89 fb 48 c1 eb 03 <42> 0f b6 04 2b=
 84 c0 0f 85 c4 08 00 00 48 89 5c 24 10 41 8b 1f bd
> RSP: 0018:ffffc9000d0879c0 EFLAGS: 00010203
> RAX: ffffffff8247653a RBX: 000000000000008c RCX: ffff888000cb2440
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000394
> RBP: ffff888053019010 R08: ffff888052a5a80b R09: 1ffff1100a54b501
> R10: dffffc0000000000 R11: ffffed100a54b502 R12: ffff888052a4c000
> R13: dffffc0000000000 R14: 0000000000000394 R15: 0000000000000464
> FS:  00007f83016c06c0(0000) GS:ffff88808c593000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f830167dfd8 CR3: 0000000034ce6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:   49 89 fe                mov    %rdi,%r14
>    3:   e8 f6 ef 7b ff          call   0xff7beffe
>    8:   4d 85 f6                test   %r14,%r14
>    b:   0f 84 8c 03 00 00       je     0x39d
>   11:   49 bd 00 00 00 00 00    movabs $0xdffffc0000000000,%r13
>   18:   fc ff df
>   1b:   4d 8d be d0 00 00 00    lea    0xd0(%r14),%r15
>   22:   4c 89 fb                mov    %r15,%rbx
>   25:   48 c1 eb 03             shr    $0x3,%rbx
> * 29:   42 0f b6 04 2b          movzbl (%rbx,%r13,1),%eax <-- trapping in=
struction
>   2e:   84 c0                   test   %al,%al
>   30:   0f 85 c4 08 00 00       jne    0x8fa
>   36:   48 89 5c 24 10          mov    %rbx,0x10(%rsp)
>   3b:   41 8b 1f                mov    (%r15),%ebx
>   3e:   bd                      .byte 0xbd
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

