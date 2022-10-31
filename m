Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F17612E32
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 01:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJaAPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Oct 2022 20:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaAPn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Oct 2022 20:15:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59EA190
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Oct 2022 17:15:42 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso757559iot.15
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Oct 2022 17:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oG6TXnPiJympp1y6Yi2/mlEVChYRL1hOkOdNaIe/BIw=;
        b=GQY6ba93QwYRjjw+jMy0bcamJvvZjPVj2AQmyJTHYZkRkw7W6LGEMB7T6u20grOn/Y
         S/lvI6XQ+SL7goVszGEAhQ5o+J2Ijmhk+nMQwkSwte2kqsN4pvqMMQa3LmZllSHNkWss
         LQHUKW+01IFUh5iCW5I4mXiiD6CmsIYBzysCU2SLuPLp2C5Z505o58qsBCNgl6Q1l8Tz
         ajlMfJQIlGCT9Y4hVAQyMAAqX+bF8WdTwEmZRLrjOun6jOPSgDMUYaAWXR59jGCAy5H/
         0uHhXixzbdN22quzI3rvTmWl6NGRlehgT8A/B2t2NGljH5cpTNokVj32xAHtDDDv9Dqf
         8scg==
X-Gm-Message-State: ACrzQf3ZzBht6RHgvuSrG1ufpAD6TKcrbeVBRa1kwhCGDBMyDzFEwFKg
        818Fy+pF6OG1nXo37cnjvlVEPUScHsMFj5/8r9UToIQFRWhO
X-Google-Smtp-Source: AMsMyM6WbHLYe8Ph2uLl/Q1KlLGPdu+K1RGwJWd03k2lZI6/LV+JaDWa/w2S9859VUJExllKXUFaIssHotDGn/zAlGMlf5vxsQl7
MIME-Version: 1.0
X-Received: by 2002:a92:cacd:0:b0:300:9f3b:af12 with SMTP id
 m13-20020a92cacd000000b003009f3baf12mr3031732ilq.291.1667175342249; Sun, 30
 Oct 2022 17:15:42 -0700 (PDT)
Date:   Sun, 30 Oct 2022 17:15:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d9d6f05ec498263@google.com>
Subject: [syzbot] WARNING in btrfs_space_info_update_bytes_may_use
From:   syzbot <syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com>
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=158eaff6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db9ab1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e21b6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/17cf7ba1084e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com

BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3604 at fs/btrfs/space-info.h:122 btrfs_space_info_update_bytes_may_use+0x524/0x820 fs/btrfs/space-info.h:122
Modules linked in:
CPU: 0 PID: 3604 Comm: syz-executor245 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:btrfs_space_info_update_bytes_may_use+0x524/0x820 fs/btrfs/space-info.h:122
Code: fd e9 77 fb ff ff e8 3b 4b fd fd 4d 89 e6 48 89 de 49 f7 de 4c 89 f7 e8 9a 47 fd fd 49 39 de 0f 86 b5 fc ff ff e8 1c 4b fd fd <0f> 0b 31 db e9 af fc ff ff e8 0e 4b fd fd 48 8d 7d 18 be ff ff ff
RSP: 0018:ffffc90003f4f9c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000d0000 RCX: 0000000000000000
RDX: ffff888021f78000 RSI: ffffffff837f5164 RDI: 0000000000000006
RBP: ffff88807da53000 R08: 0000000000000006 R09: 00000000000e0000
R10: 00000000000d0000 R11: 000000000008c07e R12: fffffffffff20000
R13: ffff88807da53060 R14: 00000000000e0000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faff6153690 CR3: 000000000bc8e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
 block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
 btrfs_block_rsv_release+0x515/0x650 fs/btrfs/block-rsv.c:295
 btrfs_release_global_block_rsv+0x22/0x2e0 fs/btrfs/block-rsv.c:463
 btrfs_free_block_groups+0x954/0x1100 fs/btrfs/block-group.c:4051
 close_ctree+0xd17/0xdc3 fs/btrfs/disk-io.c:4710
 generic_shutdown_super+0x154/0x410 fs/super.c:491
 kill_anon_super+0x36/0x60 fs/super.c:1085
 btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2441
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb35/0x2a20 kernel/exit.c:820
 do_group_exit+0xd0/0x2a0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f87197f03e9
Code: Unable to access opcode bytes at 0x7f87197f03bf.
RSP: 002b:00007ffebfd5c0d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f871987d470 RCX: 00007f87197f03e9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffb8 R09: 00007ffebf003031
R10: 0000000080000009 R11: 0000000000000246 R12: 00007f871987d470
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
