Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49963E111
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Nov 2022 20:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiK3T6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Nov 2022 14:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiK3T6k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Nov 2022 14:58:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0A8C696
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 11:58:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso16361696ilg.14
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 11:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6m31B3T4WPKdD8D5Hi6zvUudwhOCA6A3RJwv+AxyDTQ=;
        b=u8G7bK5JOQY+utbaK9kG4DG47w3DURjesMNMHgMW75QDgDzAMSpGnqlIULJgvvSzb3
         xphKLBhT3ata82KBZ2GC1BmEIqXBfY4IlCiHX9yzo0K+p6dqPukz87lyQ7rlhxFcY1Sv
         prlvASBlENgRLOjKgbWmYRKZFXomGhSsMF8T/RnOsr1b74Szl25W7Hrbk6p35w2S/B/5
         ug4s9lC//lejZhqGih97UYhVhe2qHpQcqRoYVe315QPhErLlxGeFaJuHPJtOKWvobCfH
         9EMW9OKbV0UQ83Xu41BsPE+lHiAbUQ+PYJjqwACiHEoOCZ5A5dZxZaUcrRoWe45HnThl
         ULBw==
X-Gm-Message-State: ANoB5pmjGlKnuaOVXtKFjKeHJr3TV0cyjkiJ2Bla+OAvOKh6yEsiRA98
        6WwGVwBEUxf6r1OQ635BaNLyvx4hJV0BbO+jH9HlNCuVL33g
X-Google-Smtp-Source: AA0mqf4/7eLRzvNNL8cDkrvtuTLVvoEVDNrUsEeYSY195AdijVZNdTLla0EuIvYRI1zuEmDkU7f6jTqZiNp6x9qVQwC48M1iU2Rs
MIME-Version: 1.0
X-Received: by 2002:a5d:8e0a:0:b0:6df:c191:c691 with SMTP id
 e10-20020a5d8e0a000000b006dfc191c691mr1824785iod.103.1669838318673; Wed, 30
 Nov 2022 11:58:38 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:58:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1495205eeb58712@google.com>
Subject: [syzbot] WARNING in btrfs_put_transaction
From:   syzbot <syzbot+3706b1df47f2464f0c1e@syzkaller.appspotmail.com>
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

HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=134bee03880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3706b1df47f2464f0c1e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1476f2c3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6e3c9880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/68219d51df73/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3706b1df47f2464f0c1e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3706 at fs/btrfs/transaction.c:132 btrfs_put_transaction+0x377/0x3d0
Modules linked in:
CPU: 0 PID: 3706 Comm: btrfs-transacti Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:btrfs_put_transaction+0x377/0x3d0 fs/btrfs/transaction.c:131
Code: da 31 c0 e8 bd 56 09 07 e9 e5 fd ff ff e8 a1 a1 03 fe 0f 0b e9 f7 fc ff ff e8 95 a1 03 fe 0f 0b e9 69 fd ff ff e8 89 a1 03 fe <0f> 0b e9 89 fd ff ff e8 7d a1 03 fe 4c 89 ff be 03 00 00 00 48 83
RSP: 0018:ffffc90003fefbf8 EFLAGS: 00010293
RAX: ffffffff8386f627 RBX: ffff8880188b3330 RCX: ffff8880799eba80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff8880188b3000 R08: ffffffff8386f330 R09: ffffed1003116603
R10: ffffed1003116603 R11: 1ffff11003116602 R12: ffff8880188b3028
R13: dffffc0000000000 R14: ffff888027cecce8 R15: ffff8880188b3010
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b2eb954e90 CR3: 0000000027fcd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_cleanup_transaction+0x55b/0x1b60 fs/btrfs/disk-io.c:5237
 transaction_kthread+0x3f5/0x490 fs/btrfs/disk-io.c:1913
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
