Return-Path: <linux-btrfs+bounces-890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB18107E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 02:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AFE282460
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EFC1844;
	Wed, 13 Dec 2023 01:58:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D19FBE
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 17:58:28 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-20311c36565so1272456fac.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 17:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432707; x=1703037507;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PrtuHHvlJSMCcRmxVI9cTjTpHHaK6QJDP9Ybf63EDQ=;
        b=irIG5FZ4JUYg+8nOGr8bQUsK1c1LT0P6AQaFnW40BurFBwi/ncrZpGcJ+IuZyCDWSG
         hCY3lMOCrvuNwJJdrnncCmqiaUk51S/YPtCgJK9SLVhatRQ3F4hxEDlnV4LLH6lEyNsV
         s/FrQGN251U76gg0OQscB6xB2+VIJWrP2wd1fe1+4rOuSZ5Rn18GrZbngSdbexUNn+IY
         oNh8A6m+UIw0DVxUYsSNVLuJFnICgrkduxiINy7GmQ0fpsBTJgndwHgzXG6XgOoOuRkp
         dDsHzFTyq953tdsZoaaAaVlXaGODgZ71/4rmVckLpqfWfJ7dFCSypjBW7DeoqfOxgVyL
         J1UA==
X-Gm-Message-State: AOJu0YzP6n98EO9U15EU8GJ7fG1b3/Iu68e7e4DCuGSxFrHRsIXNStSz
	m+JC7YnBCA6nZnVArcNEDMIlvS4KiL6x1EfJWUfWjH8DS4ok
X-Google-Smtp-Source: AGHT+IHQJk1gbg4Wx6lUKmYs13gpjy4Av/Pw1eg8OFwM0J4J7KWB/N8rxnbR3QT94q1YH4IaXCN015JSQi8xSf+ab5+ygeGaf56P
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:798c:b0:1fa:de51:f90b with SMTP id
 pb12-20020a056871798c00b001fade51f90bmr8315757oac.11.1702432707268; Tue, 12
 Dec 2023 17:58:27 -0800 (PST)
Date: Tue, 12 Dec 2023 17:58:27 -0800
In-Reply-To: <000000000000169326060971d07a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5542e060c5a80fc@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
From: syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    eaadbbaaff74 Merge tag 'fuse-fixes-6.7-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f9a15ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc9deae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a3a26b045d0/disk-eaadbbaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ca3ec5e1332/vmlinux-eaadbbaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8cfd867e4c2/bzImage-eaadbbaa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fafd72a5cce8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1356
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1356!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.7.0-rc5-syzkaller-00030-geaadbbaaff74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: writeback wb_workfn (flush-btrfs-137)
RIP: 0010:__extent_writepage_io+0xcd5/0xd00 fs/btrfs/extent_io.c:1356
Code: 77 07 90 0f 0b e8 fb 23 f1 fd 48 c7 c7 80 c5 ab 8b 48 c7 c6 80 d2 ab 8b 48 c7 c2 20 c5 ab 8b b9 4c 05 00 00 e8 7c 49 77 07 90 <0f> 0b e8 d4 23 f1 fd 48 8b 3c 24 e8 db 22 01 00 48 89 c7 48 c7 c6
RSP: 0018:ffffc90000116f40 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: 759e2408fa89b300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: fffffffffffffffd R08: ffffffff81713a3c R09: 1ffff92000022d3c
R10: dffffc0000000000 R11: fffff52000022d3d R12: 0000000000007000
R13: 0000000000007000 R14: ffffea00019cd168 R15: ffff888027a0b680
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54a22c2723 CR3: 000000001d013000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __extent_writepage fs/btrfs/extent_io.c:1446 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2108 [inline]
 extent_writepages+0x1260/0x26a0 fs/btrfs/extent_io.c:2230
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 __writeback_single_inode+0x155/0xfc0 fs/fs-writeback.c:1625
 writeback_sb_inodes+0x8e3/0x1220 fs/fs-writeback.c:1916
 wb_writeback+0x44d/0xc70 fs/fs-writeback.c:2092
 wb_do_writeback fs/fs-writeback.c:2239 [inline]
 wb_workfn+0x400/0xfb0 fs/fs-writeback.c:2279
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__extent_writepage_io+0xcd5/0xd00 fs/btrfs/extent_io.c:1356
Code: 77 07 90 0f 0b e8 fb 23 f1 fd 48 c7 c7 80 c5 ab 8b 48 c7 c6 80 d2 ab 8b 48 c7 c2 20 c5 ab 8b b9 4c 05 00 00 e8 7c 49 77 07 90 <0f> 0b e8 d4 23 f1 fd 48 8b 3c 24 e8 db 22 01 00 48 89 c7 48 c7 c6
RSP: 0018:ffffc90000116f40 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: 759e2408fa89b300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: fffffffffffffffd R08: ffffffff81713a3c R09: 1ffff92000022d3c
R10: dffffc0000000000 R11: fffff52000022d3d R12: 0000000000007000
R13: 0000000000007000 R14: ffffea00019cd168 R15: ffff888027a0b680
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fac72b5f000 CR3: 000000001d013000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

