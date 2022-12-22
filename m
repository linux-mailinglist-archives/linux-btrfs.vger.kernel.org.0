Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E0653C85
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Dec 2022 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiLVHbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Dec 2022 02:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiLVHbm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Dec 2022 02:31:42 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B10248C9
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 23:31:40 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a9-20020a921a09000000b0030bda27ddcbso700867ila.18
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 23:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPmhdJO1dscVyydjxIqVGVM6EeEaaoZup7WwmkNURI8=;
        b=1VwH0YLqoRjFRRjhsVa+mgImX9At7SU0MntyFEXzL718LhZa0U44N78ZpQkn7w9zfq
         ISe7IEwl2cVO7P6cYxwSeyl0a++aIbP9rWP0kDHZMC/Yoots2j27h7eXCnQO1HBvWHez
         gdtVtI1rfZKyOMJLPqjMP35YaM7TcsPxOhnddR5MNrqiEfcrr4rtW6cnXM/VWLTkaX9J
         TPFCmSsdalPKXKZKdO0DEq20YwC5oj58RiAZIE/mWxMrhMF2KxLOE36mbsYwSk6AJKjI
         359JtQ4JEJI/v+iA7+58OTZHJyB+MfOUmpAFZVYmPfL7KTsgPepOdqBWn5olZ9b7Lt33
         YuSg==
X-Gm-Message-State: AFqh2kp86GUm+/G+ZSORx+tPYhxSM6zochCqDT0SPRObBB9mYEBzOQNc
        T/LBuHdEVQFijMbF52ay2Dd2jgXGSLCNKQq8uIajK/zxQvUk
X-Google-Smtp-Source: AMrXdXsc+y/qIxNXvGfVdCDzWhayA4p6N+Wf0NxgQOlbpD/XmHbrO1mPuRYfBzFSYz/QHGAffGGRcXsoFlXJDeSMaoATDB1yUV0t
MIME-Version: 1.0
X-Received: by 2002:a92:d248:0:b0:30b:bc94:e9d0 with SMTP id
 v8-20020a92d248000000b0030bbc94e9d0mr474220ilg.50.1671694299511; Wed, 21 Dec
 2022 23:31:39 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:31:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5454b05f065a803@google.com>
Subject: [syzbot] [btrfs?] general protection fault in start_transaction
From:   syzbot <syzbot+96977faa68092ad382c4@syzkaller.appspotmail.com>
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

HEAD commit:    b6bb9676f216 Merge tag 'm68knommu-for-v6.2' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13431bbf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3fb546de56fbf8d
dashboard link: https://syzkaller.appspot.com/bug?extid=96977faa68092ad382c4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11040abf880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f703f794500/disk-b6bb9676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cca7cdd545b/vmlinux-b6bb9676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ce2560b7652/bzImage-b6bb9676.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a6a120f35475/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96977faa68092ad382c4@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
CPU: 1 PID: 34 Comm: kworker/u4:2 Not tainted 6.1.0-syzkaller-13872-gb6bb9676f216 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
RIP: 0010:start_transaction+0x48/0x10f0 fs/btrfs/transaction.c:564
Code: 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 00 90 00 fe 48 89 5c 24 38 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 48 89 44 24 70 <80> 3c 28 00 74 08 48 89 df e8 da 33 56 fe 48 89 5c 24 60 48 8b 03
RSP: 0018:ffffc90000ab7ab0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff88801779ba80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff52000156f5d
R10: fffff52000156f5d R11: 1ffff92000156f5c R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2bea75b718 CR3: 000000001d0cc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_qgroup_rescan_worker+0x3bb/0x6a0 fs/btrfs/qgroup.c:3402
 btrfs_work_helper+0x312/0x850 fs/btrfs/async-thread.c:280
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:start_transaction+0x48/0x10f0 fs/btrfs/transaction.c:564
Code: 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 00 90 00 fe 48 89 5c 24 38 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 48 89 44 24 70 <80> 3c 28 00 74 08 48 89 df e8 da 33 56 fe 48 89 5c 24 60 48 8b 03
RSP: 0018:ffffc90000ab7ab0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff88801779ba80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff52000156f5d
R10: fffff52000156f5d R11: 1ffff92000156f5c R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffeba9a96cc CR3: 000000000d08e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fb             	mov    %rdi,%rbx
   3:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
   a:	fc ff df
   d:	e8 00 90 00 fe       	callq  0xfe009012
  12:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
  17:	48 81 c3 08 02 00 00 	add    $0x208,%rbx
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 da 33 56 fe       	callq  0xfe563412
  38:	48 89 5c 24 60       	mov    %rbx,0x60(%rsp)
  3d:	48 8b 03             	mov    (%rbx),%rax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
