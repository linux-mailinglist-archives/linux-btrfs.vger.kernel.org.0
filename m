Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8433F650908
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 10:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiLSJFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 04:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLSJFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 04:05:47 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8471005
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Dec 2022 01:05:46 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so3761803ioz.8
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Dec 2022 01:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWOajJEnSGvTS82I9sFGcxGqMpzhww1quh5l5HfVQMo=;
        b=phGVe0rCcZo73OeJc9RHzWZQNecBsWXs+4XXa1sGeavAXyqQKOaq4iHjhII0NWfdNZ
         /MbOHM2Hp1juWE7TWGG+9RKNXHfScwgjw20llO1GCYkEEbnVbbsX3imeGjvFb6vVukH0
         GCtRp+yJA//idJIfH4AvThMd9fKgqfvMg416QEep6cNuUoWBjVXioslsAQps9O5Rc39s
         fL6/8+l+aTApC2EIYGcKRIVSeifW+z+yunglv9eeDycIqilsFnyPUU9FH+aCmQe0xdlq
         W1JKl9i3/1cTy+cbGDbvPSJw5FJerqdL6IvAU0CvQ204A3w0+ea9HpBlo3p8l4gIZEhB
         ftYg==
X-Gm-Message-State: AFqh2kpEeQDoaEIDX0ukSb2EC725nhz0RI4HP8qRtHNIGvVm79B+c2ZD
        Wc/IlQx5LL1FwPVe2BX/cWQcybgkeX+3rHuxTujDL22Q7FrT
X-Google-Smtp-Source: AMrXdXvMBZ6zcydBG77Del9/vlqq2KsNYogxJMaVE3ldzoO8dCp6RPqBBbfMO8Hb3rlDv2mHFAuCCjQP86FV3Xw2SYR+FzQB6G9P
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f47:b0:308:86c1:9717 with SMTP id
 y7-20020a056e020f4700b0030886c19717mr860827ilj.8.1671440745677; Mon, 19 Dec
 2022 01:05:45 -0800 (PST)
Date:   Mon, 19 Dec 2022 01:05:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8c98705f02a9f6d@google.com>
Subject: [syzbot] general protection fault in detach_extent_buffer_page (3)
From:   syzbot <syzbot+0c9e903ba426fae1f88d@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141d9ad0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca14f57f6fb6faa7
dashboard link: https://syzkaller.appspot.com/bug?extid=0c9e903ba426fae1f88d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c9e903ba426fae1f88d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000003d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
CPU: 1 PID: 45 Comm: kcompactd0 Not tainted 6.1.0-syzkaller-09941-ge2ca6ba6ba01 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__lock_acquire+0xd83/0x56d0 kernel/locking/lockdep.c:4925
Code: 3d 0f 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 93 56 3d 0f e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 31 00 00 49 81 3e 60 65 f6 8f 0f 84 4c f3 ff
RSP: 0018:ffffc900008d74a8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff9200011aec5 RCX: 0000000000000000
RDX: 000000000000003d RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1ce6862 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801562e100 R14: 00000000000001e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc081fa8000 CR3: 000000006a5b7000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 detach_extent_buffer_page+0x6c7/0xb40 fs/btrfs/extent_io.c:4051
 btrfs_release_extent_buffer_pages+0x12b/0x400 fs/btrfs/extent_io.c:4120
 release_extent_buffer+0x242/0x2b0 fs/btrfs/extent_io.c:4618
 try_release_extent_buffer+0x307/0x8d0 fs/btrfs/extent_io.c:5717
 btree_release_folio+0xc2/0x100 fs/btrfs/disk-io.c:909
 filemap_release_folio+0x13f/0x1b0 mm/filemap.c:3967
 btree_migrate_folio+0xa2/0x100 fs/btrfs/disk-io.c:874
 move_to_new_folio+0x17a/0x6e0 mm/migrate.c:958
 __unmap_and_move mm/migrate.c:1122 [inline]
 unmap_and_move mm/migrate.c:1194 [inline]
 migrate_pages+0x1de8/0x3e10 mm/migrate.c:1477
 compact_zone+0x1c74/0x39f0 mm/compaction.c:2413
 kcompactd_do_work+0x2f7/0x7c0 mm/compaction.c:2851
 kcompactd+0x8c3/0xdf0 mm/compaction.c:2953
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd83/0x56d0 kernel/locking/lockdep.c:4925
Code: 3d 0f 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 93 56 3d 0f e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 31 00 00 49 81 3e 60 65 f6 8f 0f 84 4c f3 ff
RSP: 0018:ffffc900008d74a8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff9200011aec5 RCX: 0000000000000000
RDX: 000000000000003d RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1ce6862 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801562e100 R14: 00000000000001e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc081fa8000 CR3: 000000006a5b7000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	0f 41 bf 01 00 00 00 	cmovno 0x1(%rdi),%edi
   7:	0f 86 c8 00 00 00    	jbe    0xd5
   d:	89 05 93 56 3d 0f    	mov    %eax,0xf3d5693(%rip)        # 0xf3d56a6
  13:	e9 bd 00 00 00       	jmpq   0xd5
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	4c 89 f2             	mov    %r14,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 4e 31 00 00    	jne    0x3181
  33:	49 81 3e 60 65 f6 8f 	cmpq   $0xffffffff8ff66560,(%r14)
  3a:	0f                   	.byte 0xf
  3b:	84 4c f3 ff          	test   %cl,-0x1(%rbx,%rsi,8)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
