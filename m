Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFB6399C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Nov 2022 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiK0Ius (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Nov 2022 03:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK0Iuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Nov 2022 03:50:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366401274C
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Nov 2022 00:50:39 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id w9-20020a056e021c8900b0030247910269so6130076ill.4
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Nov 2022 00:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hT5DgejXLG1VEeatPWPF6TXh+aFuSyUr4LfGy5xM6GE=;
        b=BN8w7IoUEWxhW7WAt+kkCSfxmJO7kxvmly4sK8yIsFeVu5h585m3EtKhM7GsvcHuE/
         tXP1ksng9Kw29wUgFleQztaCS7CFeVgQSQ1UgMeyg0A3464IL+9I/8sL1HXJPCroQrbJ
         p+cPOd42pY8sJq5Fr6yI1TqS+5ZCP+gwQwaUa0S6roYCw29Zc4J0XHgJ8XU2MBhBSRQP
         qtEhEBYWPyYP3j/eARP4LgS+FFKnSe4sW8KN63SSkTWRKPnHF/NwD28oz4nITbGF2AKQ
         BYbSnHYKPgp8DoNAfHd2tWP32BCSt6AOo8NElI1V8U1qh3DyeVY9YlJxOwauxIHJ/OsP
         NaNQ==
X-Gm-Message-State: ANoB5pm0QWt1Y6Js2nU/I/DfjhUVev8+h5oBszDgYmIsrZG1rDgiwwlt
        2oH/uuif34/3SB3NGDXxlSBhZcCrObY9GHZ/108BjU1Bhqgq
X-Google-Smtp-Source: AA0mqf7/b6Z1dIxDI3j6l50TbC8lTfUuvb93V6Gdz+EBsCavgLLPplQv7WmqGe8QShVt27Gc1QfPROGRUHkQXk+4wz3lUQoTnSbt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4395:b0:36d:9ec0:14e3 with SMTP id
 bo21-20020a056638439500b0036d9ec014e3mr14837140jab.44.1669539038180; Sun, 27
 Nov 2022 00:50:38 -0800 (PST)
Date:   Sun, 27 Nov 2022 00:50:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f406b05ee6fd9f9@google.com>
Subject: [syzbot] kernel BUG in btrfs_global_root_delete
From:   syzbot <syzbot+c53508efe63e66c13e68@syzkaller.appspotmail.com>
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=133c91bb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=c53508efe63e66c13e68
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1534adbb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11820973880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/57b749caa804/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c53508efe63e66c13e68@syzkaller.appspotmail.com

BTRFS error (device loop0): parent transid verify failed on logical 5255168 mirror 1 wanted 5 found 7
BTRFS warning (device loop0): couldn't read tree root
assertion failed: !tmp, in fs/btrfs/disk-io.c:1098
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3713!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor365 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : assertfail+0x28/0x2c fs/btrfs/ctree.h:3712
lr : assertfail+0x28/0x2c fs/btrfs/ctree.h:3712
sp : ffff800012df3800
x29: ffff800012df3800 x28: 0000000000000000 x27: 000000000000000b
x26: 0000000000000000 x25: ffff0000c734e000 x24: ffff0000c734e000
x23: 0000000000000000 x22: ffff0000c99141f7 x21: ffff0000c9b9c0a0
x20: ffff0000c9914000 x19: ffff0000c9b9c060 x18: 0000000000000201
x17: 000000000000b67e x16: ffff80000dbe6158 x15: ffff0000c6904ec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6904ec0
x11: ff808000081c4d40 x10: 0000000000000000 x9 : 3743abf7676a7c00
x8 : 3743abf7676a7c00 x7 : ffff80000c08e4f4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000032
Call trace:
 assertfail+0x28/0x2c fs/btrfs/ctree.h:3712
 btrfs_global_root_delete+0x0/0x54 fs/btrfs/disk-io.c:1098
 load_global_roots_objectid+0x20c/0x460 fs/btrfs/disk-io.c:2460
 load_global_roots fs/btrfs/disk-io.c:2494 [inline]
 btrfs_read_roots+0x60/0x530 fs/btrfs/disk-io.c:2521
 init_tree_roots+0x288/0x3d0 fs/btrfs/disk-io.c:2940
 open_ctree+0x688/0xdc8 fs/btrfs/disk-io.c:3634
 btrfs_fill_super+0xc0/0x174 fs/btrfs/super.c:1461
 btrfs_mount_root+0x4a4/0x558 fs/btrfs/super.c:1829
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 fc_mount fs/namespace.c:1043 [inline]
 vfs_kern_mount+0xe0/0x140 fs/namespace.c:1073
 btrfs_mount+0x20c/0x5e8 fs/btrfs/super.c:1889
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d00060a2 910f0c00 91096c42 97fffbda (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
