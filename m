Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F8063A563
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiK1Juw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 04:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiK1Juv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 04:50:51 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4119023
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 01:50:49 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id s4-20020a056e02216400b003021b648144so8495766ilv.19
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 01:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRrF59NcMBwZCwWNay/Mk38e4kI0Bs68NiHJ09COGdA=;
        b=x44EVsUhWXy41FJ/I34XZ84G8xkJFMVu4/IbKyRGNsjitkPT0lmrH3h0Zg55pRjuOQ
         t913U8i/yRqSSrtSh0FaJ7skgzn24BqYPbOo3ANfaj4166pmVMTwKOofOL3qLK3NNluG
         g0hEKeK8Iahg8g9wNx5kp8QF0u3qkokRZcIbwyeTBKtOL+1uhZvikFE1in7xes7BmkNq
         6AfHqXzF+u/dlOpSwXK1FQ5ezH+v+8OKL3e6pajOkD9JRBkNMSEHwhCiz4WYOSGsuzGK
         YfEF87wTkhmYuuDcZ3CkrtnVmFCmzr8B7sU5sdni5q1T6F3oKMPjul9KRcDwnajZ4BgY
         7FDQ==
X-Gm-Message-State: ANoB5pln+f6gqS+a8A367x87D1OFEx8qJUqmcSqdDNjMShclCvVAaePJ
        Ii7Bi/h3vy66Q/BnEY6ee1tocNaPPdVEGS3anp82/z1v6H5Y
X-Google-Smtp-Source: AA0mqf7ud3UOo+/WaQQ+1ddhBTElmiVenXRvko3ubQLIhH0PCLFyGXcF8f4yzBEu5v4rPxbtnHPHWx+Xn+pp+R+5Qw4Bx4vWRbzp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1189:b0:302:fa94:c735 with SMTP id
 y9-20020a056e02118900b00302fa94c735mr6617014ili.57.1669629049094; Mon, 28 Nov
 2022 01:50:49 -0800 (PST)
Date:   Mon, 28 Nov 2022 01:50:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060cb5005ee84ce27@google.com>
Subject: [syzbot] general protection fault in btrfs_ioctl_send
From:   syzbot <syzbot+c423003741c992ccf56b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    9e46a7996732 Add linux-next specific files for 20221125
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1518a973880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e19c740a0b2926
dashboard link: https://syzkaller.appspot.com/bug?extid=c423003741c992ccf56b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1024ec05880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bc0973880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/758d818cf966/disk-9e46a799.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c8696b40a5/vmlinux-9e46a799.xz
kernel image: https://storage.googleapis.com/syzbot-assets/810f9750b87f/bzImage-9e46a799.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9b34ff4df466/mount_0.gz

The issue was bisected to:

commit d14cd51f13589142902687cfacd09e373251ac6e
Author: Filipe Manana <fdmanana@suse.com>
Date:   Tue Nov 1 16:15:50 2022 +0000

    btrfs: send: cache leaf to roots mapping during backref walking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d92353880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14392353880000
console output: https://syzkaller.appspot.com/x/log.txt?x=10392353880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c423003741c992ccf56b@syzkaller.appspotmail.com
Fixes: d14cd51f1358 ("btrfs: send: cache leaf to roots mapping during backref walking")

BTRFS info (device loop0): enabling ssd optimizations
BTRFS info (device loop0): auto enabling async discard
BTRFS info (device loop0): checking UUID tree
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5294 Comm: syz-executor236 Not tainted 6.1.0-rc6-next-20221125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:empty_backref_cache fs/btrfs/send.c:1396 [inline]
RIP: 0010:btrfs_ioctl_send+0x13ab/0x65a0 fs/btrfs/send.c:8365
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 49 1c 00 00 4d 8b ae c0 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 34 1c 00 00 4c 39 ed 49 8b 5d 00 49 bc 00 00 00
RSP: 0018:ffffc90003bbf8c8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88807735f140 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8380b588 RDI: ffff88807735f000
RBP: ffff88807735f1c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffed100ee6be28
R13: 0000000000000000 R14: ffff88807735f000 R15: 0000000000000000
FS:  00005555556b3300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff4af8bff8 CR3: 000000007dbc9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 _btrfs_ioctl_send+0x231/0x2e0 fs/btrfs/ioctl.c:4343
 btrfs_ioctl+0x4058/0x5870 fs/btrfs/ioctl.c:4634
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5d8166ab09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff55cc13f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5d8166ab09
RDX: 0000000020000040 RSI: 0000000040489426 RDI: 0000000000000003
RBP: 00007f5d8162a3d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5d8162a460
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:empty_backref_cache fs/btrfs/send.c:1396 [inline]
RIP: 0010:btrfs_ioctl_send+0x13ab/0x65a0 fs/btrfs/send.c:8365
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 49 1c 00 00 4d 8b ae c0 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 34 1c 00 00 4c 39 ed 49 8b 5d 00 49 bc 00 00 00
RSP: 0018:ffffc90003bbf8c8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88807735f140 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8380b588 RDI: ffff88807735f000
RBP: ffff88807735f1c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffed100ee6be28
R13: 0000000000000000 R14: ffff88807735f000 R15: 0000000000000000
FS:  00005555556b3300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff4af8bff8 CR3: 000000007dbc9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 49 1c 00 00    	jne    0x1c57
   e:	4d 8b ae c0 01 00 00 	mov    0x1c0(%r14),%r13
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	4c 89 ea             	mov    %r13,%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
* 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a:	0f 85 34 1c 00 00    	jne    0x1c64
  30:	4c 39 ed             	cmp    %r13,%rbp
  33:	49 8b 5d 00          	mov    0x0(%r13),%rbx
  37:	49                   	rex.WB
  38:	bc                   	.byte 0xbc
  39:	00 00                	add    %al,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
