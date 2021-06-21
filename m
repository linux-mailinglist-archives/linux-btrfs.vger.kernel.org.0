Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4310E3AE296
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 07:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhFUFIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 01:08:35 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37759 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFUFIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 01:08:34 -0400
Received: by mail-io1-f72.google.com with SMTP id q15-20020a6b710f0000b02904e2f00a469fso3716881iog.4
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 22:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9r48W4h0FyT5pPrVFAU7afHEN1fmEnBomvSChPTyeC0=;
        b=bENEEpsKuljupwy7BgBQLilQhmLi8GyKy2hGWjsItElEK1OGqFpFCuRKCFoTKciKAi
         5P5bRtC5DVU+p1ue1lcsfT2qBOASiN2uysmd+DeUc8aJo2A3lkF8oEbbFA+odnwOw5Tf
         KvhonAfR1iJhwlfDeCMA2wKo8GHbiOLaCpcCLD9azk+xU/D6Z3vCdxlH21dKPCCkrSLI
         o++csnPLfm3ZSCoQueFiWzWCzEasn6z+6VDL+fPauf3wBonL4zjQpBYGWU8OGxFFIL5N
         Lm4/lmU9WzXRJlTlNUYjVPlJAcD9Gg0qpJoQyR+9FzPAivNRJYRJdS6sT1Dy9XPNvRSv
         Ik9A==
X-Gm-Message-State: AOAM530Slt2nbXMbdK8SJAJxdL+ZPEJNMaTo5sM4ziHbzs2sPuV5lf++
        vFMD/3smQiVtsMAE5LVPiqxg26H8obUKTlOjQz/FVnvmq5f7
X-Google-Smtp-Source: ABdhPJwv/uTWAH4C9fRYwyTTxtTssd8nqg/nvTIQgYk4NyxfnInNGmcglaCb3KWWQGsmBVOtzrxbOZIMUspjgVMVIYRSoby5S2Fu
MIME-Version: 1.0
X-Received: by 2002:a6b:e60f:: with SMTP id g15mr18914004ioh.52.1624251980326;
 Sun, 20 Jun 2021 22:06:20 -0700 (PDT)
Date:   Sun, 20 Jun 2021 22:06:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000502c1a05c53fa2e1@google.com>
Subject: [syzbot] general protection fault in detach_extent_buffer_page
From:   syzbot <syzbot+38cd5310bb0818ffc964@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6b00bc63 Merge tag 'dmaengine-fix-5.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1591a33fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ca96a2d153c74b0
dashboard link: https://syzkaller.appspot.com/bug?extid=38cd5310bb0818ffc964
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38cd5310bb0818ffc964@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
CPU: 1 PID: 10005 Comm: syz-fuzzer Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__lock_acquire+0xcf0/0x5230 kernel/locking/lockdep.c:4772
Code: 3d 0e 41 bf 01 00 00 00 0f 86 8c 00 00 00 89 05 06 49 3d 0e e9 81 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 2f 00 00 49 81 3e c0 b3 42 8f 0f 84 da f3 ff
RSP: 0000:ffffc9000d27e9e0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000001 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1b92d2a R11: 0000000000000000 R12: ffff888017401c40
R13: 0000000000000000 R14: 0000000000000150 R15: 0000000000000000
FS:  000000c013afc090(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000009a67f0 CR3: 000000001b446000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 detach_extent_buffer_page+0x402/0xd20 fs/btrfs/extent_io.c:5446
 btrfs_release_extent_buffer_pages+0xf1/0x320 fs/btrfs/extent_io.c:5515
 release_extent_buffer+0x242/0x2b0 fs/btrfs/extent_io.c:5985
 try_release_extent_buffer+0x706/0x900 fs/btrfs/extent_io.c:7032
 btree_releasepage+0x1fe/0x310 fs/btrfs/disk-io.c:1023
 try_to_release_page+0x27b/0x3e0 mm/filemap.c:3856
 shrink_page_list+0x3cb6/0x6060 mm/vmscan.c:1599
 shrink_inactive_list+0x347/0xca0 mm/vmscan.c:2145
 shrink_list mm/vmscan.c:2367 [inline]
 shrink_lruvec+0x7f9/0x14f0 mm/vmscan.c:2662
 shrink_node_memcgs mm/vmscan.c:2850 [inline]
 shrink_node+0x868/0x1de0 mm/vmscan.c:2967
 shrink_zones mm/vmscan.c:3170 [inline]
 do_try_to_free_pages+0x388/0x14b0 mm/vmscan.c:3225
 try_to_free_pages+0x29f/0x750 mm/vmscan.c:3464
 __perform_reclaim mm/page_alloc.c:4430 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4451 [inline]
 __alloc_pages_slowpath.constprop.0+0x84e/0x2140 mm/page_alloc.c:4855
 __alloc_pages+0x422/0x500 mm/page_alloc.c:5213
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 __page_cache_alloc mm/filemap.c:1005 [inline]
 __page_cache_alloc+0x303/0x3a0 mm/filemap.c:990
 pagecache_get_page+0x38f/0x18d0 mm/filemap.c:1885
 filemap_fault+0x166c/0x25b0 mm/filemap.c:2992
 ext4_filemap_fault+0x87/0xc0 fs/ext4/inode.c:6194
 __do_fault+0x10d/0x4d0 mm/memory.c:3680
 do_read_fault mm/memory.c:3984 [inline]
 do_fault mm/memory.c:4112 [inline]
 handle_pte_fault mm/memory.c:4371 [inline]
 __handle_mm_fault+0x2c5f/0x52c0 mm/memory.c:4506
 handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4604
 do_user_addr_fault+0x483/0x1210 arch/x86/mm/fault.c:1390
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0033:0x455709
Code: 24 40 8b 44 24 60 85 c0 7d 1b c7 44 24 70 ff ff ff ff 48 c7 44 24 78 00 00 00 00 48 8b 6c 24 40 48 83 c4 48 c3 48 8b 4c 24 50 <39> 41 20 7e db 48 8d 51 27 48 63 c0 48 8d 04 82 48 8d 40 01 8b 00
RSP: 002b:000000c00d74b848 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000099b3a0 RCX: 0000000000a03f30
RDX: 0000000000495e89 RSI: 0000000000495e89 RDI: 0000000000495f60
RBP: 000000c00d74b888 R08: 00000000000005fe R09: 000000c00038a600
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000005608
R13: 0000000000000200 R14: 000000000094b641 R15: 0000000000000000
Modules linked in:
---[ end trace c2509809fbde7be8 ]---
RIP: 0010:__lock_acquire+0xcf0/0x5230 kernel/locking/lockdep.c:4772
Code: 3d 0e 41 bf 01 00 00 00 0f 86 8c 00 00 00 89 05 06 49 3d 0e e9 81 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 2f 00 00 49 81 3e c0 b3 42 8f 0f 84 da f3 ff
RSP: 0000:ffffc9000d27e9e0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000001 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1b92d2a R11: 0000000000000000 R12: ffff888017401c40
R13: 0000000000000000 R14: 0000000000000150 R15: 0000000000000000
FS:  000000c013afc090(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000009a67f0 CR3: 000000001b446000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
