Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C9511EC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiD0RqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbiD0Rp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 13:45:57 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F354E1257
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 10:42:22 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j5-20020a056e020ee500b002cbc90840ecso358334ilk.23
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 10:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9GazW+cSqFWgD0l7JupLhDU20vuxIBdG5YIaEkrtnVo=;
        b=oQK/CozfmJNHxOhZfsseoRX0F7LeEFZ2i+PdCsb/1wgeHEyOA1NuWACAJXMZ8dgAr8
         38gBC+ifNB55KvbKzxzJJRikCoZw/6AY4+9TwDi7DUnVYFxY15XTlMm4s4bhM/fc7mXP
         doZF5Wrn1fLSZ4SVfQKr4sn9UHU09DsTUFlDb7dP4C/eswrSsEkmTKRknzrb3ByqD9WG
         TiVunYpN/tOo/gCwVirtVDvswpI6ixJe8S6rQqcUPEiOG5sEcjAWd6w8gl6+ZBM+i2k5
         j8/mhXZAccarGd5D5GFsOeK5/EMEPZBTx4HiAEOLoo0VwS1dKAEO31LOOe3kEVXuZbDN
         N/bQ==
X-Gm-Message-State: AOAM530W6lVpANWbJaxKRKE/isbPgSTvZdAxzlpe9EC5EO9pVIsd7sMG
        S9HZeuVLwY6crlu8GXxSxfCdKh2iNxc5xk8R/wXYsC49uX5Y
X-Google-Smtp-Source: ABdhPJyHd1Cj2MoYDgYYLBZM50k4siSO16jeKNEgb7lxxVVb1YRVWtf6RUW18atXwmA+1T/hoPtU4RFc5Yvyx9dp3FhlzrBwI46L
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12b4:b0:2ca:e755:ee4a with SMTP id
 f20-20020a056e0212b400b002cae755ee4amr12002773ilr.65.1651081341430; Wed, 27
 Apr 2022 10:42:21 -0700 (PDT)
Date:   Wed, 27 Apr 2022 10:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9f33705dda65450@google.com>
Subject: [syzbot] general protection fault in btrfs_stop_all_workers
From:   syzbot <syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@lst.de, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    088fb7eff349 Add linux-next specific files for 20220426
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141fd6b4f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f49713d2574602b3
dashboard link: https://syzkaller.appspot.com/bug?extid=a2c720e0f056114ea7c6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1000ce34f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13edbbfcf00000

The issue was bisected to:

commit 9d7bd4c387c1b4776832cf8c895ab934efaa2f08
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Apr 18 04:43:11 2022 +0000

    btrfs: use a normal workqueue for rmw_workers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f36f78f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=100b6f78f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f36f78f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
Fixes: 9d7bd4c387c1 ("btrfs: use a normal workqueue for rmw_workers")

general protection fault, probably for non-canonical address 0xdffffc0000000023: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
CPU: 0 PID: 3596 Comm: syz-executor105 Not tainted 5.18.0-rc4-next-20220426-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:workqueue_sysfs_unregister kernel/workqueue.c:5796 [inline]
RIP: 0010:destroy_workqueue+0x2e/0x800 kernel/workqueue.c:4430
Code: 49 89 fe 41 55 41 54 55 53 48 83 ec 08 e8 2a fe 2b 00 49 8d be 18 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 37 07 00 00 49 8b 9e 18 01 00 00 48 85 db 74 19
RSP: 0018:ffffc90002f6f818 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880248b4000 RCX: 0000000000000000
RDX: 0000000000000023 RSI: ffffffff814e4606 RDI: 0000000000000118
RBP: ffff8880248b4000 R08: 0000000000000000 R09: ffffffff9007194f
R10: 0000000000000001 R11: 0000000000000001 R12: 00000000fffffff4
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88801e866000
FS:  00007f4c1f989700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4c1fa2ff78 CR3: 000000002490a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_stop_all_workers+0x14c/0x2fe fs/btrfs/disk-io.c:2286
 open_ctree+0x481f/0x493b fs/btrfs/disk-io.c:3959
 btrfs_fill_super fs/btrfs/super.c:1430 [inline]
 btrfs_mount_root.cold+0x15/0x162 fs/btrfs/super.c:1796
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 fc_mount fs/namespace.c:1043 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1073
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1060
 btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1856
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4c1f9e079a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c1f989168 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4c1f9891c0 RCX: 00007f4c1f9e079a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4c1f989180
RBP: 000000000000008e R08: 00007f4c1f9891c0 R09: 00007f4c1f9896b8
R10: 0000000000000000 R11: 0000000000000286 R12: 00007f4c1f989180
R13: 0000000020000f50 R14: 0000000000000003 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:workqueue_sysfs_unregister kernel/workqueue.c:5796 [inline]
RIP: 0010:destroy_workqueue+0x2e/0x800 kernel/workqueue.c:4430
Code: 49 89 fe 41 55 41 54 55 53 48 83 ec 08 e8 2a fe 2b 00 49 8d be 18 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 37 07 00 00 49 8b 9e 18 01 00 00 48 85 db 74 19
RSP: 0018:ffffc90002f6f818 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880248b4000 RCX: 0000000000000000
RDX: 0000000000000023 RSI: ffffffff814e4606 RDI: 0000000000000118
RBP: ffff8880248b4000 R08: 0000000000000000 R09: ffffffff9007194f
R10: 0000000000000001 R11: 0000000000000001 R12: 00000000fffffff4
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88801e866000
FS:  00007f4c1f989700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4c1fa2ff78 CR3: 000000002490a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 89 fe             	mov    %rdi,%r14
   3:	41 55                	push   %r13
   5:	41 54                	push   %r12
   7:	55                   	push   %rbp
   8:	53                   	push   %rbx
   9:	48 83 ec 08          	sub    $0x8,%rsp
   d:	e8 2a fe 2b 00       	callq  0x2bfe3c
  12:	49 8d be 18 01 00 00 	lea    0x118(%r14),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 37 07 00 00    	jne    0x76b
  34:	49 8b 9e 18 01 00 00 	mov    0x118(%r14),%rbx
  3b:	48 85 db             	test   %rbx,%rbx
  3e:	74 19                	je     0x59


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
