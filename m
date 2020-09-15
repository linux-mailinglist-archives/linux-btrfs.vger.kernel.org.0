Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F626A3D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIOLDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 07:03:34 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:44873 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIOLBV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 07:01:21 -0400
Received: by mail-io1-f77.google.com with SMTP id l8so1868078ioa.11
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 04:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=58qLiwvX+9V/OpLahru/OEuKtk2KKFaE+wKNx1A2XkM=;
        b=hgjcnZv8w5VQ/+U7nM1sBA5sWc3sMYxm1ZRpJypqPZ31FdtV+8BOoWKiLGMVQYSd/k
         8NvpzmH1V1FrUMapErlcHYKlq79WZtFURY10kWbYHjlBfZUtVvqLK3LtU3uWPZEAsPg+
         8XJkoRf038APEEz7iOoxtEP2LTBdFbI7b/65ChyEnm33ycvIw0PPYmiRifG8X1EOQPLJ
         rl9UwHyeReF8kZfsJJK2JeHZJWjwdjYoLzLN6+mz9XPGtLVwZldpzqHVnGqUDdkVTlhc
         4RyZtMBWcwtj4csDllu7XoVnFUcOBY9kuWF1pk9IyzyTBd1cF8N3p/k/+dhfQP0T1x8F
         NpCQ==
X-Gm-Message-State: AOAM533Zr0JR6qPHa+itgvZA2XfxSIwVETQLD9HBGD0TbDkVzA6GdG4L
        5WoG1w336SFKcGkmXBH1v4M8ogtPKbzzDqVfWAn1dsZUVa3h
X-Google-Smtp-Source: ABdhPJxklLlY99p5/t7j14dLe4DOLysVAWxGXvS4F7qQ+qHFSMS/cEb/+ApDo6q33uzwtVGESX5XGm7TURdyZjQFMozGkWwii9aS
MIME-Version: 1.0
X-Received: by 2002:a92:d087:: with SMTP id h7mr9239735ilh.198.1600167621301;
 Tue, 15 Sep 2020 04:00:21 -0700 (PDT)
Date:   Tue, 15 Sep 2020 04:00:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a61d6b05af580e62@google.com>
Subject: kernel BUG at lib/string.c:LINE! (5)
From:   syzbot <syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b17bed900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e864a35d361e1d4e29a5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177582be900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13deb2b5900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com

detected buffer overflow in memcpy
------------[ cut here ]------------
kernel BUG at lib/string.c:1129!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 26 Comm: kworker/u4:2 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: btrfs-endio-meta btrfs_work_helper
RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557335f440d0 CR3: 000000009647d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy include/linux/string.h:405 [inline]
 btree_readpage_end_io_hook.cold+0x206/0x221 fs/btrfs/disk-io.c:642
 end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854
 bio_endio+0x3cf/0x7f0 block/bio.c:1449
 end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1695
 btrfs_work_helper+0x221/0xe20 fs/btrfs/async-thread.c:318
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace b68924293169feef ]---
RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95b7c4d008 CR3: 000000009647d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
