Return-Path: <linux-btrfs+bounces-5479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE38FD4FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 20:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4CE1F21812
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3513C83D;
	Wed,  5 Jun 2024 18:01:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA042168C4
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610494; cv=none; b=QgSmZWZaOcfRYPgqFv9nsCZVJEIsF5YDMrPfGF3Eq3HcLbqZCRdyBPnMN9kK+lSi0A8vUXePj3UU3fMcwciMSG1fD4AqZnvRpM1lvyQQRotQc6TpLvL/BbvQa9dfJXReBeMYCTiSXhxZlKUGuDrBSMAGuEwP6bDYEJBLNPgXdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610494; c=relaxed/simple;
	bh=AhS5EzMEpZW4dc+BnuGeZl1BkoHsadluS8Ad7Tbugxs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tmN94l5sVJb7hr0R9d0eEW5r3iNZUwtuN2zHOioPZzgj+rsag73L690QJZLd6YwDUTSx8G6+YJaoMPgoa0FoByBlTc71+uqvbEQ8m1xc0DHXjSsv/wgK4HdtKSf7bOf03TAtxApgcYDuz+Oth3pV9j4kZlWzwBvtkwI96wAiPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eb43d50fdcso10603639f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jun 2024 11:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610492; x=1718215292;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcjNq4EyJK72cVmrRnOIMPkrwFEsKP6VPHiyNXVXjOw=;
        b=hAXoeEWdntQwACMRi2sOsaBKBe8vm0rPbnQmGNRlzD5gu/lmJyT4uxNvBwMgsoh5eL
         VQkMtuBkDd5YjDXDV+QrVsMGCGayWtB/KNhSFz3SxORvDf0xgt4F4E93kJ0nyN2ngyWl
         kO/lceSSrvWbGUl1BqwqVEdvJBehGWTRc9kAJ2Kfiy67aon66SvJH7lAZGhdqBxOWUwP
         uisWeGfZcfpFI2cOn0pRQpWJ7L3pFPjgd76uJsB07G2ZIbH46rutSRyobsIor5w1JVsi
         hZaNKgpP5ikxMGE8j5eft70CMTWncWJI7HwC9803YaZCwG5a8F+8LxfYOPHVj4dgQm++
         fHJg==
X-Forwarded-Encrypted: i=1; AJvYcCX5y8o38JWR7gvrpod1OvLhSMMVHruL72wsxsdT/hjDl780W2wj5Hv5CV+K3E0QvatwPTj9/5NABdzRJM68HTDDhbP2BpsfYv5dUNc=
X-Gm-Message-State: AOJu0YwBcriJ0d2zEX/MTmNGvI9a0JLJeuEqN5NO7vRyDejOwdtSTBQo
	S8+K3/XcYJID3LGiOZn8QygL5cH/5twVGpmx/HSf0T1qeEdEC9ntwxPORZwvENA31BQc0uyjIaO
	CDO1qLRptSddRPANlNs7d4gAJSyhDufsieMv5nQ+1+akAQCVLhQBHZDI=
X-Google-Smtp-Source: AGHT+IEhZXpXBPsc2jpwuqxeJ85wy20d84rh23oOcZN9sseuWOHr9aZJZohQcK6QHFb4eWMcs4+lVhpzWzL8cGx4kxznIOLtMOHK
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-374b1f56c81mr2061885ab.3.1717610492101; Wed, 05 Jun 2024
 11:01:32 -0700 (PDT)
Date: Wed, 05 Jun 2024 11:01:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e9581061a285b4c@google.com>
Subject: [syzbot] [btrfs?] general protection fault in detach_extent_buffer_folio
From: syzbot <syzbot+f80b066392366b4af85e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71d7b52cc33b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a94aba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96fd46a1ee1615e0
dashboard link: https://syzkaller.appspot.com/bug?extid=f80b066392366b4af85e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-71d7b52c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2083371f9b54/vmlinux-71d7b52c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f8b0934f579/bzImage-71d7b52c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f80b066392366b4af85e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
CPU: 0 PID: 111 Comm: kswapd0 Not tainted 6.10.0-rc2-syzkaller-00064-g71d7b52cc33b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 93 86 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 e0 fd e2 92 0f 84 98 f2
RSP: 0018:ffffc90001f96f10 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000002a RSI: ffff888019192440 RDI: 0000000000000150
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff8fe2c157 R11: 0000000000000002 R12: 0000000000000150
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020202018 CR3: 000000001d6ac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 detach_extent_buffer_folio+0x33c/0x870 fs/btrfs/extent_io.c:3385
 btrfs_release_extent_buffer_pages+0xaa/0x1b0 fs/btrfs/extent_io.c:3446
 release_extent_buffer+0x240/0x2c0 fs/btrfs/extent_io.c:4074
 try_release_extent_buffer+0x78d/0x9e0 fs/btrfs/extent_io.c:5115
 btree_release_folio+0xbf/0x100 fs/btrfs/disk-io.c:524
 filemap_release_folio+0x1ed/0x280 mm/filemap.c:4173
 shrink_folio_list+0x254a/0x4150 mm/vmscan.c:1394
 evict_folios+0x6e6/0x1bf0 mm/vmscan.c:4553
 try_to_shrink_lruvec+0x618/0x9b0 mm/vmscan.c:4749
 shrink_one+0x3f8/0x7c0 mm/vmscan.c:4788
 shrink_many mm/vmscan.c:4851 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
 shrink_node mm/vmscan.c:5910 [inline]
 kswapd_shrink_node mm/vmscan.c:6720 [inline]
 balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 93 86 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 e0 fd e2 92 0f 84 98 f2
RSP: 0018:ffffc90001f96f10 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000002a RSI: ffff888019192440 RDI: 0000000000000150
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff8fe2c157 R11: 0000000000000002 R12: 0000000000000150
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020202018 CR3: 000000001d6ac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	11 00                	adc    %eax,(%rax)
   2:	00 39                	add    %bh,(%rcx)
   4:	05 93 86 1f 12       	add    $0x121f8693,%eax
   9:	0f 82 be 05 00 00    	jb     0x5cd
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	e9 e4 00 00 00       	jmp    0xfd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 82 1f 00 00    	jne    0x1fb6
  34:	49 81 3c 24 e0 fd e2 	cmpq   $0xffffffff92e2fde0,(%r12)
  3b:	92
  3c:	0f                   	.byte 0xf
  3d:	84                   	.byte 0x84
  3e:	98                   	cwtl
  3f:	f2                   	repnz


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

