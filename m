Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490842A0D83
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgJ3Sgd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgJ3Sgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 14:36:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24FC0613D5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 11:36:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so3220681qvz.4
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTrlthIyFtftD2m5EBlBgqVry26bZDISwU7MtF7KwS8=;
        b=b4kgJZ930lo++BS+rfZiuLXh99wtCuS6m8cqmZUQWZrARkHk6tEZKFyv94tnw/x7p2
         pwQWaO9rxeTB5CNrqknzbDrtj8+dm9TkiMC6kSGMRZv+7pyLKC0z+a11T2a5Mou9H4wi
         TzDLJmn5F9+zrc4meXC/y/anvQ6JoMA6oxRe/r+JB895KMxQwgUNfoGEzapsP5l2Zf2X
         VwZDYwpXjyRVFYbKlZiPeBeDyj945KYfPpP+/lJcsDZIAYw+FPAYfZg9a2zw97aZcmTV
         XA681ZVggUzd7X9Xkz/7+iHee6BTEUH2hpQrsD7Yh6dp2smKm9gQEMmAAKMq4UBFNrqJ
         RB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTrlthIyFtftD2m5EBlBgqVry26bZDISwU7MtF7KwS8=;
        b=mO/lvVhpMrYlGkKsC3GzR2r7WhwM0SJQ33WSk4JvwaT/185fU01UjCv7xpopbSwLYe
         6+wd4VcfVWxhi1u392RcsWryljdFoucgQIkVSgfs0EJ4IvqKoguWfI+xGr/DhWcwUPMZ
         5rqn3hro7TKNI9xAjKDECl5WpRmTT5jrFmO0FduL0vWxqoSSXoJS1WzdEPaEi/xRd0Mt
         LgatTg8aXdyqw2AYcapR8DNl/3HargUqlz29+Cc6GZTjHcCEqGW/bqMyjFblRhJdk/xG
         VJ5ZtXbUtV+nLnTJnOkkSaXuX1v7zmnRvk/GM4sa6P6pmFXYOf5LMZmy5ahNHbahOzRJ
         kE0A==
X-Gm-Message-State: AOAM530ZvsEv6QEBFVCWivETCkvZXHzbXZnWDKfqb0HmujBsqJeLsYXL
        tBzPkkshNZZySw/OxRuGyCYiDDMMKOmmX6TGpkA9RA==
X-Google-Smtp-Source: ABdhPJwL9HuCxO4g7K/2k1Q0TQobPiTq5N3dR3sXNdpQ1nbia742ljNH5dOyeWHDpZOJ3iMq9K0IGdJXqko2U8dp1gc=
X-Received: by 2002:ad4:54e9:: with SMTP id k9mr10743384qvx.18.1604082990051;
 Fri, 30 Oct 2020 11:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008fbadb05af94b61e@google.com> <01bcf380-c806-02fa-67ac-ff66fd0100c7@oracle.com>
 <CACT4Y+ZakmsaKN+R94SWyErZc6FeKcmBP8d5yY8FO4+aL5WxOw@mail.gmail.com> <b0bc728a-0957-ca93-10a7-4851a9d3b043@oracle.com>
In-Reply-To: <b0bc728a-0957-ca93-10a7-4851a9d3b043@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 30 Oct 2020 19:36:18 +0100
Message-ID: <CACT4Y+ZqRC2H7N9zRh2QPn=Nc31V2kjF7uniYft4u4GQtuMCgw@mail.gmail.com>
Subject: Re: WARNING in close_fs_devices (2)
To:     Anand Jain <anand.jain@oracle.com>
Cc:     syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020 at 3:01 PM Anand Jain <anand.jain@oracle.com> wrote:
> On 30/10/20 6:10 pm, Dmitry Vyukov wrote:
> > On Tue, Sep 22, 2020 at 2:37 PM Anand Jain <anand.jain@oracle.com> wrote:
> >>
> >> On 18/9/20 7:22 pm, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=15bf1621900000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
> >>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
> >>>
> >>> ------------[ cut here ]------------
> >>> WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
> >>> Kernel panic - not syncing: panic_on_warn set ...
> >>> CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >>> Call Trace:
> >>>    __dump_stack lib/dump_stack.c:77 [inline]
> >>>    dump_stack+0x198/0x1fd lib/dump_stack.c:118
> >>>    panic+0x347/0x7c0 kernel/panic.c:231
> >>>    __warn.cold+0x20/0x46 kernel/panic.c:600
> >>>    report_bug+0x1bd/0x210 lib/bug.c:198
> >>>    handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
> >>>    exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
> >>>    asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> >>> RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
> >>> Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 99 ce 6a fe <0f> 0b e9 71 ff ff ff e8 8d ce 6a fe 0f 0b e9 20 ff ff ff e8 d1 d5
> >>> RSP: 0018:ffffc900091777e0 EFLAGS: 00010246
> >>> RAX: 0000000000040000 RBX: ffffffffffffffff RCX: ffffc9000c8b7000
> >>> RDX: 0000000000040000 RSI: ffffffff83097f47 RDI: 0000000000000007
> >>> RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880988a187f
> >>> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88809593a130
> >>> R13: ffff88809593a1ec R14: ffff8880988a1908 R15: ffff88809593a050
> >>>    close_fs_devices fs/btrfs/volumes.c:1193 [inline]
> >>>    btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
> >>>    open_ctree+0x4984/0x4a2d fs/btrfs/disk-io.c:3434
> >>>    btrfs_fill_super fs/btrfs/super.c:1316 [inline]
> >>>    btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
> >>>    legacy_get_tree+0x105/0x220 fs/fs_context.c:592
> >>>    vfs_get_tree+0x89/0x2f0 fs/super.c:1547
> >>>    fc_mount fs/namespace.c:978 [inline]
> >>>    vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
> >>>    vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
> >>>    btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
> >>>    legacy_get_tree+0x105/0x220 fs/fs_context.c:592
> >>>    vfs_get_tree+0x89/0x2f0 fs/super.c:1547
> >>>    do_new_mount fs/namespace.c:2875 [inline]
> >>>    path_mount+0x1387/0x2070 fs/namespace.c:3192
> >>>    do_mount fs/namespace.c:3205 [inline]
> >>>    __do_sys_mount fs/namespace.c:3413 [inline]
> >>>    __se_sys_mount fs/namespace.c:3390 [inline]
> >>>    __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
> >>>    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>> RIP: 0033:0x46004a
> >>> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
> >>> RSP: 002b:00007f414d78da88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> >>> RAX: ffffffffffffffda RBX: 00007f414d78db20 RCX: 000000000046004a
> >>> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f414d78dae0
> >>> RBP: 00007f414d78dae0 R08: 00007f414d78db20 R09: 0000000020000000
> >>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
> >>> R13: 0000000020000100 R14: 0000000020000200 R15: 000000002001a800
> >>> Kernel Offset: disabled
> >>> Rebooting in 86400 seconds..
> >>
> >>
> >> #syz fix: btrfs: fix rw_devices count in __btrfs_free_extra_devids
> >
> > Is it the correct patch title? It still does not exist anywhere
> > including linux-next...
> >
>
> V2 is here [1]. The patch title is changed. Also the cover letter talks
> about the path dependency. It is not yet integrated.
>
> [1]
> https://patchwork.kernel.org/project/linux-btrfs/patch/d0b5790792b8b826504dd239ad9efc514f3d9109.1604009248.git.anand.jain@oracle.com/
>
> Thanks, Anand


Thanks for double checking.
I was confused by the fact that the previous patch appeared briefly in
linux-next, but then disappeared.

I see the new patch contains the syzbot tag, so we are all good here.
