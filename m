Return-Path: <linux-btrfs+bounces-12471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11850A6B2AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 02:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75AE3AD404
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 01:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59051DF754;
	Fri, 21 Mar 2025 01:37:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6451DC184
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521045; cv=none; b=k8523rDmM/yDazfTF/WGgpyU8dfS2Auas+dT5Ewg0tpFkfmCOb9p1VkUsGnn7MvYeoL82nT3xZC9yVpM3bA+olXt3ToLSNVJNNyY9TP2ipg9P3JR+1F4H3Ezu92fqJ/qQPULzlV64GsUlH35rl9pXykckmeRwPlTwef64eypRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521045; c=relaxed/simple;
	bh=ZqEUfoapnhYuCDQD1EXqUT+qYSYTYNhFIkYMUC/eofM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WxGTRzrx8H2griU+tIDNggqkERRfpcLufLFmoxEuH0k31mf7AtC+Ea87jo8pehmEtMSACu74K6V4Ylw4kQqzxpdCOPIpQLAIWAeAWdghqNdI7ohrOac3qV0gA2yYb0Ea46vBUZoIjsU1zKKmGw7uCImP2muoh08qdUwj2se2LIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso11897555ab.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 18:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742521041; x=1743125841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jszjkOJjwLi/7v5PVoBHAtfeBojk/KDRvfGZp3lZaI0=;
        b=FkKugakVkme3GruQdKU/E7rhF8AXB+Qhb6GXXT5Cbaj2XF3fDsQtLDdbtETi8axbe6
         PPN2skzVLVWfiYoeBZA9VZwd57ZoPrQwrITp9uzQ/CZerDfchc5DLQO00k1p/s3srJcA
         CkNBtvZ+aln502Bo9fVyzz56U7ZsiObvCf+OvaliRx/jiKC5JJvbGvs0MHHOnPRBLUHx
         Gd2eEmPplEWAZt5XuYPiydfjsah6NFCSbEgLZ+8ZV8mOqd7qy8ghhQ6nmmwtxZwPvr96
         SO7Unq4CPF8Mf29HzT+WOclzHy/4sBzIBXRzxZHLS4l9JQ6WvToyCGOgNafIjyLdcHP9
         fegQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL9sGd3k/kKkYGOunT90MUN8nTdJiwrJkr8H5rLTrS1cJpvjyOemlFiTgrEeOBdJuXUn0eg+buns+AIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RaCPj4m72kcqmDZYzm1LhPS+JLlMVD5ZxKUE0dY/F3N+nMuk
	ealHKf6xNgmpZ2PQzVDr/lfDBJLd6FxewemdrYfEX6cSf5zYfXCIy1+CZeZXhmVwVY1jQSSHcwn
	y5GhMmvpH0eSCRe4P3UzTGPOqSpNifw5biL2gY89mJL2XvUEjBmcT/44=
X-Google-Smtp-Source: AGHT+IEmA5c/370Wds6/1PBW62vPq4kqKjtEJ1jSiHef+/wKd4O0x7JlFsZi9O0opxZ+LXcx18cd4bWV3i25hJwcBygNUZHoy4Br
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:3d1:79a1:5b85 with SMTP id
 e9e14a558f8ab-3d59618603fmr20984395ab.21.1742521041545; Thu, 20 Mar 2025
 18:37:21 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:37:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dcc2d1.050a0220.31a16b.0017.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in add_to_free_space_tree (2)
From: syzbot <syzbot+a6563a38d2eeb6e42942@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1275e99d1c4 Merge tag 'media/v6.14-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17139e54580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67fb5d057adc2bbe
dashboard link: https://syzkaller.appspot.com/bug?extid=a6563a38d2eeb6e42942
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d183442a7ac1/disk-d1275e99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8c36f255b468/vmlinux-d1275e99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6a9840cb963/bzImage-d1275e99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6563a38d2eeb6e42942@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 3016 at fs/btrfs/free-space-tree.c:1052 add_to_free_space_tree+0x2e7/0x320 fs/btrfs/free-space-tree.c:1052
Modules linked in:
CPU: 1 UID: 0 PID: 3016 Comm: kworker/u8:7 Not tainted 6.14.0-rc6-syzkaller-00263-gd1275e99d1c4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:add_to_free_space_tree+0x2e7/0x320 fs/btrfs/free-space-tree.c:1052
Code: 4e 6e 8c 48 89 dd 89 ea e8 16 02 1f fd e9 33 ff ff ff e8 dc 2b b9 fd 90 48 c7 c7 00 4e 6e 8c 48 89 dd 89 ee e8 2a e7 78 fd 90 <0f> 0b 90 90 e9 12 ff ff ff e8 bb 2b b9 fd 48 c7 c7 80 4d 6e 8c 48
RSP: 0018:ffffc9000c5b6e50 EFLAGS: 00010246
RAX: 98d2a73c3254fc00 RBX: 00000000ffffffe4 RCX: ffff8880309dbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffffe4 R08: ffffffff81819d62 R09: fffffbfff1d3a69c
R10: dffffc0000000000 R11: fffffbfff1d3a69c R12: 0000000000000000
R13: ffff88805a6c3060 R14: 1ffff1100b4d860c R15: ffff88805a6c3000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bdbb5c3ff0 CR3: 0000000061b4c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_free_extent_accounting fs/btrfs/extent-tree.c:2969 [inline]
 __btrfs_free_extent+0x1ce9/0x3980 fs/btrfs/extent-tree.c:3338
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1976 [inline]
 __btrfs_run_delayed_refs+0xf9f/0x40f0 fs/btrfs/extent-tree.c:2046
 btrfs_run_delayed_refs+0xe3/0x2f0 fs/btrfs/extent-tree.c:2158
 commit_cowonly_roots+0x66b/0x860 fs/btrfs/transaction.c:1373
 btrfs_commit_transaction+0xfe4/0x3760 fs/btrfs/transaction.c:2446
 flush_space+0x529/0xd30 fs/btrfs/space-info.c:842
 btrfs_async_reclaim_metadata_space+0x178/0x3b0 fs/btrfs/space-info.c:1120
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

