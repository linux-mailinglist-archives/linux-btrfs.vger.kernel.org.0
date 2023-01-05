Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56965E264
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjAEBQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 20:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAEBPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 20:15:46 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A1030578
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 17:15:44 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so22055945ilb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jan 2023 17:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4XwA2WIOMhHxfPunRfxDwfkdvR24Gn3rMnr/1ezfYk=;
        b=sWAB2YvEQRIhXHWCpX6EXCSAZNWb5VQKoGlcHoLUm+2tcF9l4hSbAe1eeJvSXejIh9
         fYAPLGgNdYDdsR5cmHO+X1f60tUFexLDaZnSvEmH4s6PZ2fWkx4aJgKfQDIuMghgrGF0
         D4+UOkbywU3RZBiRcHn8Vx7K2TAql+afr5Z8qYoXPiTCA1HENaXwBA+vxDeiQNKxcPZA
         k7DvMp02J8sP9D54Ck8uF75rd/4jtk3IY8t/zVAGIHlQg2zF5zi+2nGPHx+txbWtiAHD
         BuxpDLFFDn2tc1WD+lxmzKRh/hgWx2+PjdX082Z6gw1qn1kTAlZtavl62Uic4W5gpHu6
         qKyw==
X-Gm-Message-State: AFqh2kpC0UNRLSgLRzWZz449pSLo8tKWArJKn/gS1nUVCDQCNrmeoItQ
        CANgKectMG8K+4xLaa06xKALcm+XbQu2MP9gJtfaGBGnancc
X-Google-Smtp-Source: AMrXdXt1O0jsfhplciVZiLxUAY18ZG46Dpsl/NyiTpPavbg7IT/AlXwqYIpS0cyAxOktV7GGDkVAWBiKcz/7gBm0F9KO/hTjEd6f
MIME-Version: 1.0
X-Received: by 2002:a02:a59a:0:b0:38a:b88c:7caa with SMTP id
 b26-20020a02a59a000000b0038ab88c7caamr4563338jam.10.1672881343829; Wed, 04
 Jan 2023 17:15:43 -0800 (PST)
Date:   Wed, 04 Jan 2023 17:15:43 -0800
In-Reply-To: <000000000000e5454b05f065a803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000401c5105f17a0ac1@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in start_transaction
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143721cc480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=96977faa68092ad382c4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1382a02a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c7f2c2480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3aac1573b20/disk-69b41ac8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f5a860f3b3/vmlinux-69b41ac8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4a7091814ba/bzImage-69b41ac8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/48b08567f044/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96977faa68092ad382c4@syzkaller.appspotmail.com

BTRFS info (device loop3): qgroup scan completed (inconsistency flag cleared)
general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
CPU: 0 PID: 33 Comm: kworker/u4:2 Not tainted 6.2.0-rc2-syzkaller-00010-g69b41ac87e4a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
RIP: 0010:start_transaction+0x48/0x10f0 fs/btrfs/transaction.c:564
Code: 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 b0 72 00 fe 48 89 5c 24 38 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 48 89 44 24 70 <80> 3c 28 00 74 08 48 89 df e8 7a 1c 56 fe 48 89 5c 24 60 48 8b 03
RSP: 0018:ffffc90000aa7ab0 EFLAGS: 00010206

RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff888012a98000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff52000154f5d
R10: fffff52000154f5d R11: 1ffff92000154f5c R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc4b7306e68 CR3: 000000007c876000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_qgroup_rescan_worker+0x3bb/0x6a0 fs/btrfs/qgroup.c:3403
 btrfs_work_helper+0x312/0x850 fs/btrfs/async-thread.c:280
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:start_transaction+0x48/0x10f0 fs/btrfs/transaction.c:564
Code: 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 b0 72 00 fe 48 89 5c 24 38 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 48 89 44 24 70 <80> 3c 28 00 74 08 48 89 df e8 7a 1c 56 fe 48 89 5c 24 60 48 8b 03
RSP: 0018:ffffc90000aa7ab0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff888012a98000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff52000154f5d
R10: fffff52000154f5d R11: 1ffff92000154f5c R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdbdc81068 CR3: 000000007e8b3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fb             	mov    %rdi,%rbx
   3:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
   a:	fc ff df
   d:	e8 b0 72 00 fe       	callq  0xfe0072c2
  12:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
  17:	48 81 c3 08 02 00 00 	add    $0x208,%rbx
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 7a 1c 56 fe       	callq  0xfe561cb2
  38:	48 89 5c 24 60       	mov    %rbx,0x60(%rsp)
  3d:	48 8b 03             	mov    (%rbx),%rax

