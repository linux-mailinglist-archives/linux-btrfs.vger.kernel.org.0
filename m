Return-Path: <linux-btrfs+bounces-10105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BB9E7C74
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 00:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFD16A8E8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2631213E65;
	Fri,  6 Dec 2024 23:30:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A31FCD18
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527835; cv=none; b=mZ53TMJz12jOj37Ga0LHHJc80KdfNhi2nmPbR1ibJ//pAArmihWMhKoJACXvA/OpWxaconiQmuh4jOhUU75qWtn890ceTngOeOxxjQjJB3hNDIZZ/aR813N+Numue0HerZH9MvhhV/wo8r8GsPAgAjBK0r0tpCGYx6dOHT7Csoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527835; c=relaxed/simple;
	bh=bsMOdF9t+yZgl6nzP3eTKIJMsR1qdGjpAXoI3Rd5J3g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m6Pszy8zPnhuFkCLEzRGJOqWB47pfL6FA8BQK5AJQnX7j4s4leMbywsPnrhc4ZFgO6/ASyiC4PFt7DrOPFI5slzVlLHeXwYMjK1lqJoBeyWQa3Te4Lfb5xkHjO68BRLRxX5gbbl0rPkI7Bk5G5IuUC/7E0fbB2rQkemHcXb+JuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-84386a9b7e2so468718639f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2024 15:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733527832; x=1734132632;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hp+viSbRlsRqNZfXm2mpqqZBCwoZAdp6M0GYeJNUQ6Q=;
        b=Y4bdS550P73T3YVF8QIu9thhZv4b3ucugK7j2CKZOBhC1X8V29W8vXXr/KBkWHH6ze
         O5PlH92zZRzhEBEPvRsLh31goHpJM2tHymdMNVQXKVAtSDCIj5jsdIYGyAFoNee4tHNq
         bko/1JPABUXldZXrRlAzsCF53fSJmTW/2gCnqCdFLp7+vLu4vE9NPATEaQBDaM3QMuz1
         olQgglcQTDSQ+nCf1THTxtmhf+c/Q4cyeAiw4DWGl9pOks6qTTx++MK9xsebouewgBFB
         XRmEM5u96W7CubgdXESbgaQoPQQSwtAks/i3PSIu16EjgpeMMswytF4cu8tQc173ayQB
         KWXg==
X-Forwarded-Encrypted: i=1; AJvYcCWebhNIJ6/UAlIFt/lvZHGVH+gKtBwfzxlRkHkIeJCXKDHR5aFJmj6YLzmULxhS3KGauyY0j0bTYous+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTfmFKXp786Cgt2wQWf7Cg5K4fjEuCA0+yMuYsW6w+igrvcUS
	JRRMtcQgX+cKuY5ADzxWTHIrsv4jk/zq9P3ks/86fZJcvYgKkSGhtHATqXnpWaK4g0zvSHueBsC
	wyaV95qAitHp4L59WVHztjDeWBArSS7cR3D0p1JRb8uBIFWqNJTeZnzE=
X-Google-Smtp-Source: AGHT+IFrFvDjkqMKbkN9cLKLl5XUaN62rGYgzNt/vfJD41BP4lc52+5MlX2vBTMoIa4jqWsaHlfCGQWxMslJDrKFcANCxgDNDwcB
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3a7:15aa:3fcc with SMTP id
 e9e14a558f8ab-3a811d774abmr67770135ab.1.1733527832584; Fri, 06 Dec 2024
 15:30:32 -0800 (PST)
Date: Fri, 06 Dec 2024 15:30:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67538918.050a0220.a30f1.014a.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_get_extent_inline_ref_type
From: syzbot <syzbot+4983e68a6d77180bfe33@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e70140ba0d2b Get rid of 'remove_new' relic from platform d..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156a0330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=4983e68a6d77180bfe33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a904c062768/disk-e70140ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4c464adbbce/vmlinux-e70140ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a1fb1b0c526/bzImage-e70140ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4983e68a6d77180bfe33@syzkaller.appspotmail.com

assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOTA), in fs/btrfs/extent-tree.c:344
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-tree.c:344!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 83 Comm: kworker/u8:5 Not tainted 6.13.0-rc1-syzkaller-00001-ge70140ba0d2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:btrfs_get_extent_inline_ref_type+0x42c/0x480 fs/btrfs/extent-tree.c:344
Code: 4d fd 90 0f 0b e8 c4 52 e6 fd 48 c7 c7 a0 b0 4a 8c 48 c7 c6 00 b1 4a 8c 48 c7 c2 c0 ae 4a 8c b9 58 01 00 00 e8 15 e3 4d fd 90 <0f> 0b e8 9d 52 e6 fd 48 c7 c7 a0 b0 4a 8c 48 c7 c6 60 b1 4a 8c 48
RSP: 0018:ffffc900015970c0 EFLAGS: 00010246
RAX: 0000000000000059 RBX: 00000000000003c5 RCX: f7095654c42f1300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff817f070c R09: 1ffff920002b2db4
R10: dffffc0000000000 R11: fffff520002b2db5 R12: 00000000000000ac
R13: ffff888029a91a40 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f653c3ff000 CR3: 000000002a19a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lookup_inline_extent_backref+0x7ad/0x1a00 fs/btrfs/extent-tree.c:882
 lookup_extent_backref fs/btrfs/extent-tree.c:1064 [inline]
 __btrfs_free_extent+0x443/0x3a10 fs/btrfs/extent-tree.c:3095
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2007 [inline]
 __btrfs_run_delayed_refs+0x102a/0x4310 fs/btrfs/extent-tree.c:2077
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2189
 flush_space+0x2f7/0xcf0
 btrfs_async_reclaim_metadata_space+0x28e/0x350 fs/btrfs/space-info.c:1105
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_get_extent_inline_ref_type+0x42c/0x480 fs/btrfs/extent-tree.c:344
Code: 4d fd 90 0f 0b e8 c4 52 e6 fd 48 c7 c7 a0 b0 4a 8c 48 c7 c6 00 b1 4a 8c 48 c7 c2 c0 ae 4a 8c b9 58 01 00 00 e8 15 e3 4d fd 90 <0f> 0b e8 9d 52 e6 fd 48 c7 c7 a0 b0 4a 8c 48 c7 c6 60 b1 4a 8c 48
RSP: 0018:ffffc900015970c0 EFLAGS: 00010246
RAX: 0000000000000059 RBX: 00000000000003c5 RCX: f7095654c42f1300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff817f070c R09: 1ffff920002b2db4
R10: dffffc0000000000 R11: fffff520002b2db5 R12: 00000000000000ac
R13: ffff888029a91a40 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f653c3ff000 CR3: 000000002a19a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

