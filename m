Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3E638ED5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 18:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKYRJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 12:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKYRJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 12:09:48 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234941CFCD
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 09:09:47 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so3149055ild.11
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 09:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+gVepjvy5i5gmcpNK9MMQgLScOA+o4Qp5rBSKy/Ei8=;
        b=IqLoVl3H9vqvLlyQBs7BcW9aRnp5uTyUzFpOz5tIN09/l12ufWgN9L3wUt3ha05h9w
         nBKjfTjz0FvGo74iPsMkSupBIWUO3ZrdErBMVsC9MKc0lr47upLWE1flwVNNOdf3iZqr
         A6eFMpsTjVEwJYeONqSVxkU4v6l5lFVbpfy0E2vh86WkhE6W5TDQIO10CoY1stSsu/C6
         g7eIYBJjjfsOZrMt1clWSXCEMBor6P314hpL+u+LV+IVKEkacdi66TJ1p0Q0+EKRno+T
         4kcK7JC4euMvNhnFTWXv/Hc3FYXQpV/JBONmCuKsn7T4uYEKHEEtY50k6+yQLB9Ty4wr
         K/Xw==
X-Gm-Message-State: ANoB5plkbnnkN3S21Y7PQB7Bsrm/BjR+zdvU4dsCpU5KKxBLoj7+b2DJ
        X7JIWCwiuoTNkmwnnOzhVeeW61qsRHfoL73Uhi1N9AXt74N7
X-Google-Smtp-Source: AA0mqf5gtWhSDlEfr7MDlFe+1/3XGbS501s0+ORv6vupK7k0UwVKcXKxB0rvUfmp6AstWPdoZlgd68RgvFIY+TSIbY5vV8nEU1Dy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2408:b0:389:5377:d86f with SMTP id
 z8-20020a056638240800b003895377d86fmr3200049jat.142.1669396186442; Fri, 25
 Nov 2022 09:09:46 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:09:46 -0800
In-Reply-To: <0000000000003f315b05ee1ed3f4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aeaf5a05ee4e96d7@google.com>
Subject: Re: [syzbot] kernel BUG in close_ctree
From:   syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>
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

HEAD commit:    c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115013c5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1360d8e3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175f0d53880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb11fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb11fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f5bd1887114f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com

assertion failed: list_empty(&fs_info->delayed_iputs), in fs/btrfs/disk-io.c:4664
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3713!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3632 Comm: syz-executor235 Not tainted 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3713
Code: 48 c7 c2 80 aa 38 8b 31 c0 e8 ef e3 ff ff 0f 0b 89 f1 48 89 fe 48 c7 c7 60 d9 38 8b 48 c7 c2 50 0a 39 8b 31 c0 e8 d3 e3 ff ff <0f> 0b 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec
RSP: 0018:ffffc90003d7fa58 EFLAGS: 00010246
RAX: 0000000000000051 RBX: ffff88807c960d58 RCX: 83509907ab950400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003d7fbe8 R08: ffffffff816e568d R09: fffff520007aff05
R10: fffff520007aff05 R11: 1ffff920007aff04 R12: 0000000000000000
R13: ffff88807c960000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00005555573a6300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcab996e28 CR3: 0000000078318000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 close_ctree+0x818/0xbde fs/btrfs/disk-io.c:4664
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_anon_super+0x36/0x60 fs/super.c:1086
 btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 ptrace_notify+0x29a/0x340 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:251
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd3e400af67
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcab997568 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fd3e400af67
RDX: 00007ffcab99762a RSI: 000000000000000a RDI: 00007ffcab997620
RBP: 00007ffcab997620 R08: 00000000ffffffff R09: 00007ffcab997400
R10: 00005555573a7653 R11: 0000000000000202 R12: 00007ffcab9986e0
R13: 00005555573a75f0 R14: 00007ffcab997590 R15: 00007ffcab998700
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3713
Code: 48 c7 c2 80 aa 38 8b 31 c0 e8 ef e3 ff ff 0f 0b 89 f1 48 89 fe 48 c7 c7 60 d9 38 8b 48 c7 c2 50 0a 39 8b 31 c0 e8 d3 e3 ff ff <0f> 0b 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec
RSP: 0018:ffffc90003d7fa58 EFLAGS: 00010246
RAX: 0000000000000051 RBX: ffff88807c960d58 RCX: 83509907ab950400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003d7fbe8 R08: ffffffff816e568d R09: fffff520007aff05
R10: fffff520007aff05 R11: 1ffff920007aff04 R12: 0000000000000000
R13: ffff88807c960000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00005555573a6300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd3e405ad48 CR3: 0000000078318000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

