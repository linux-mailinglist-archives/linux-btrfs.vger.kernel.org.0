Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83428658C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 12:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiL2Ltu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Dec 2022 06:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiL2Lts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Dec 2022 06:49:48 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA51CFAE2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Dec 2022 03:49:47 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso5752889iob.7
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Dec 2022 03:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxXQnBivBvS5Io4jtX9fYGxpNHPwBgCya+UQD8rvg/Q=;
        b=A3uNLQIJMfKiJHRjo11YKCDEWUBjOeckjDCrUI0SSZDyJzG/lpRjhWMAdpjrIhL/4q
         ZtMvZSLkOLxMiY9CbmLTHopWm6+LtKRU/kt7fU4RnnCoJ11W6HdJSI/q/Bajw6Sy89rf
         zPmr6leQO087CD552Wp6zYmAly4kKKim7l2vO0lUPi3jVfmGuoio7O7aSydqmmjcssDe
         B169MnBNedqlfPiWcQPy8bLyBBxJw29XiVOtFt7CJIlTnxZbBYDRAYiGMEUFOGHhhbwi
         uDT52EvvCe7PXgXvGL46QzeQKuLRwjjKzQdBrT0v7PyKZTglJ3kGWzj9tMMV3yV8K8Fg
         NxJw==
X-Gm-Message-State: AFqh2kqV2gPKLvaizUevSFw9Z7QNajZ6mY+iS5fdgK3a7rbGLmzR1/l3
        MOseaD8fcQPWUXOR91pdhG7rYPIOh8vAVNU+yddWeKFjQ0bc
X-Google-Smtp-Source: AMrXdXt6rrsKj8NEyX9WQjWSdYEsl7eIAv/WasV2qWDBByJoup7eNvKeEaZ/WZzis89vAQWxSK5KOG53ILMBvCKGfn1mQPzLpXh+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a1:b0:38a:7f45:a5ff with SMTP id
 b1-20020a05663801a100b0038a7f45a5ffmr2322457jaq.9.1672314587167; Thu, 29 Dec
 2022 03:49:47 -0800 (PST)
Date:   Thu, 29 Dec 2022 03:49:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebc50f05f0f614ee@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_finish_ordered_io
From:   syzbot <syzbot+b3a2926f65a93a3cf55b@syzkaller.appspotmail.com>
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

HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136100a8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=b3a2926f65a93a3cf55b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114b2aac480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1765ae54480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/510d16df06c8/disk-72a85e2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50ef5477a1d4/vmlinux-72a85e2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2acd6f1189a/bzImage-72a85e2b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/989578dc9fd1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3a2926f65a93a3cf55b@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 56 at fs/btrfs/inode.c:3343 btrfs_finish_ordered_io+0x1ac9/0x1cb0 fs/btrfs/inode.c:3343
Modules linked in:
CPU: 1 PID: 56 Comm: kworker/u4:4 Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: btrfs-endio-write btrfs_work_helper
RIP: 0010:btrfs_finish_ordered_io+0x1ac9/0x1cb0 fs/btrfs/inode.c:3343
Code: 8b 44 89 ee 31 c0 e8 26 e8 c5 fd 0f 0b b0 01 e9 4b ff ff ff e8 58 f8 fe fd 48 c7 c7 c0 9f 39 8b 44 89 ee 31 c0 e8 07 e8 c5 fd <0f> 0b e9 a6 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 11 ed ff
RSP: 0018:ffffc900015779e0 EFLAGS: 00010246
RAX: 203bb8e87d482d00 RBX: 0000000000000024 RCX: ffff888017d91d40
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90001577bc0 R08: ffffffff816f2c9d R09: fffff520002aeef5
R10: fffff520002aeef5 R11: 1ffff920002aeef4 R12: 0000000000000000
R13: 00000000ffffffe4 R14: dffffc0000000000 R15: ffff88807292d540
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef9d1dda0 CR3: 00000000290a7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_work_helper+0x312/0x850 fs/btrfs/async-thread.c:280
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
