Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315EB639932
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Nov 2022 03:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiK0Coj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Nov 2022 21:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiK0Coi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Nov 2022 21:44:38 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50C15727
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Nov 2022 18:44:36 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so5684418ilv.16
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Nov 2022 18:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2Wlsv+VYPj+/PHBrA6LKzK7bHl/NuBOJ73q0NuYt5o=;
        b=IJiXe8eQu7HK56H7bD0vyLGH0Lu95Mg+3lqnFKRGscYnY0oT420Q/Aj1e+CJkZphwr
         UFEOnhlBYvxPJRAUpjttJSH3/4r/7jayDd0/BJVgCfKODRebMV+gjVdyle65W/ywH4CG
         dbpW6PYwotYBh9oe3ogPBzhVNPPWNE2q3tO0NYJ7mrMT2K4HnWU34py/6OJ5GSiAiCRo
         pHXi/MlY6kmWkDOJvjwqpLO1cmZ/oZ7ZOm27rNiAz7l5H82sVNbDXyw54qVW/5PPeToq
         c8InzHHRTKlxUkQNzgpSFoGfQICqGSwJvFSxTTcAnUNLnNEa5CMpGUx71rtt0DFfjAzN
         0fQw==
X-Gm-Message-State: ANoB5plcHkwjea9Y6iz/GgbEhCFA27FnW6e4k13nbFQc7prhUAef6NyX
        BwbefqdItRiljiEWSCCkOBaDV0djwuQK5EVnH1DfbpukRcLi
X-Google-Smtp-Source: AA0mqf7oUs5VcmwZ0YznYucRYXBF/yuRbwaaGBAgAjEUipIm4AXlucnMoIVJwz76dFfj9ixSF83vqilbZXLGBMjPAqNaidzN7T/3
MIME-Version: 1.0
X-Received: by 2002:a92:cc8f:0:b0:300:c067:e72c with SMTP id
 x15-20020a92cc8f000000b00300c067e72cmr10610322ilo.319.1669517075971; Sat, 26
 Nov 2022 18:44:35 -0800 (PST)
Date:   Sat, 26 Nov 2022 18:44:35 -0800
In-Reply-To: <000000000000cf908705eaa8c5a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042884105ee6abce9@google.com>
Subject: Re: [syzbot] WARNING in __kernel_write_iter
From:   syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11f871bb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114ef275880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a92353880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/609bce089bbe/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com

BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
BTRFS info (device loop0): checking UUID tree
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3072 at fs/read_write.c:504 __kernel_write_iter+0x250/0x284 fs/read_write.c:504
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor372 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kernel_write_iter+0x250/0x284 fs/read_write.c:504
lr : __kernel_write_iter+0x250/0x284 fs/read_write.c:504
sp : ffff800012d9ba90
x29: ffff800012d9bad0 x28: ffff0000c9367000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000011 x24: ffff0000ca81f580
x23: 0000000000000000 x22: ffff0000c993f808 x21: ffff0000c0292c00
x20: ffff800012d9bb20 x19: 00000000000a801d x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c7d38000
x14: 0000000000000000 x13: 00000007ffffffff x12: ffff0000c7d38000
x11: ff808000085ba5e8 x10: 0000000000000000 x9 : ffff8000085ba5e8
x8 : ffff0000c7d38000 x7 : 6b636f6c5f746e65 x6 : ffff80000801154c
x5 : ffff80000e0caee8 x4 : 0000000000000011 x3 : 0000000000000001
x2 : ffff0000c993f808 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __kernel_write_iter+0x250/0x284 fs/read_write.c:504
 __kernel_write fs/read_write.c:537 [inline]
 kernel_write+0x10c/0x1d0 fs/read_write.c:558
 write_buf fs/btrfs/send.c:591 [inline]
 send_header fs/btrfs/send.c:709 [inline]
 send_subvol+0x94/0x17ec fs/btrfs/send.c:7653
 btrfs_ioctl_send+0xd74/0xed0 fs/btrfs/send.c:8019
 _btrfs_ioctl_send+0x188/0x218 fs/btrfs/ioctl.c:5233
 btrfs_ioctl+0x5c0/0xa64
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 82496
hardirqs last  enabled at (82495): [<ffff80000844b028>] mod_lruvec_page_state include/linux/vmstat.h:563 [inline]
hardirqs last  enabled at (82495): [<ffff80000844b028>] __kmalloc_large_node+0x108/0x188 mm/slab_common.c:1099
hardirqs last disabled at (82496): [<ffff80000c0808b4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (81982): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (81980): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---

