Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E112A028D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ3KLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgJ3KLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 06:11:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52215C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 03:11:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a65so2083026qkg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4C47VY8rj0f0TZkMvqSBACCRHl1uymcfamoikS1zYcw=;
        b=ZUIXyGrxqh9DiUr8d9MeGkConoqvm6ObHQ05opE3WL+oxpY95+e0pXoTZpazAnJMUk
         /Kpd3kVuSzz37kWQWWVS++MGsQxcNg/fi9BmtuCL8COxPsFgXUTKqD002hY9Rv2+q+a2
         lCK8dou+h9z+Rge7Z4UnslRgBI38LiAp+15JB2f0UoDZMpW8NkjEqMcFMryvl/AAHxbO
         9akHHvim1WSvYOSyEcxWj4+VTGhAG/7hrZ1T7kwMTeb9nrj/kKhP3pbyecT/QUF3/zeU
         1sVkLEBUeKon2tnfC/PVvi0Z5bqtDJ7qIoUWX2DIT7iTF6/dPs3JmqEcUlx+gxR+2eU/
         IWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4C47VY8rj0f0TZkMvqSBACCRHl1uymcfamoikS1zYcw=;
        b=bzs3r9KZmTCL/Zzci+gcR2e6p+dBTNs6c+eB+2WLlprJ1vnSptkCGd5yo1e1erEPmR
         ditemHd3d+h7U0YZp13E6O7ZIbsIN7cDg+kscPvJNPnDtBB2xP0ggMZlxBb7PxnfC5am
         BzPfpHHgbVxk8QY+cn5gRlrBJBepD0jA8DktSu0TUyUYJfqDSuYSxQDF6lZFQe7kQQ2g
         WlKUMlfS2GRfWZM1txiekMzNw3U3q7n+LkvtKKKhltNtFdBb1S2ER02q7WLAmNdeOA+C
         REv3AzZ5434kiPhEngNBrXlgvmbJhkYb3/QkCzhoXT6yt/iIrNItgj6U3JIwq7bEUIVG
         oCsg==
X-Gm-Message-State: AOAM532UbSQI9T4O7UcmqEYiEToWNXf4LP7rtFztsDpaCZSQDzCntknZ
        1UU5kdpcJp0owAU7FajTvgS6T5byj4L16/TPqkxy4w==
X-Google-Smtp-Source: ABdhPJxf/3+v4bL4dn7MpW2/9jzHYsQxYUtbGD8a7hjNUYn2i5+nq928uMVooytEb5gTEofbRIXzLVX5oZ5G0aEsDsQ=
X-Received: by 2002:a37:9747:: with SMTP id z68mr1265803qkd.424.1604052669287;
 Fri, 30 Oct 2020 03:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008fbadb05af94b61e@google.com> <01bcf380-c806-02fa-67ac-ff66fd0100c7@oracle.com>
In-Reply-To: <01bcf380-c806-02fa-67ac-ff66fd0100c7@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 30 Oct 2020 11:10:58 +0100
Message-ID: <CACT4Y+ZakmsaKN+R94SWyErZc6FeKcmBP8d5yY8FO4+aL5WxOw@mail.gmail.com>
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

On Tue, Sep 22, 2020 at 2:37 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 18/9/20 7:22 pm, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15bf1621900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x198/0x1fd lib/dump_stack.c:118
> >   panic+0x347/0x7c0 kernel/panic.c:231
> >   __warn.cold+0x20/0x46 kernel/panic.c:600
> >   report_bug+0x1bd/0x210 lib/bug.c:198
> >   handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
> >   exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
> >   asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> > RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
> > Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 99 ce 6a fe <0f> 0b e9 71 ff ff ff e8 8d ce 6a fe 0f 0b e9 20 ff ff ff e8 d1 d5
> > RSP: 0018:ffffc900091777e0 EFLAGS: 00010246
> > RAX: 0000000000040000 RBX: ffffffffffffffff RCX: ffffc9000c8b7000
> > RDX: 0000000000040000 RSI: ffffffff83097f47 RDI: 0000000000000007
> > RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880988a187f
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffff88809593a130
> > R13: ffff88809593a1ec R14: ffff8880988a1908 R15: ffff88809593a050
> >   close_fs_devices fs/btrfs/volumes.c:1193 [inline]
> >   btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
> >   open_ctree+0x4984/0x4a2d fs/btrfs/disk-io.c:3434
> >   btrfs_fill_super fs/btrfs/super.c:1316 [inline]
> >   btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
> >   legacy_get_tree+0x105/0x220 fs/fs_context.c:592
> >   vfs_get_tree+0x89/0x2f0 fs/super.c:1547
> >   fc_mount fs/namespace.c:978 [inline]
> >   vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
> >   vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
> >   btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
> >   legacy_get_tree+0x105/0x220 fs/fs_context.c:592
> >   vfs_get_tree+0x89/0x2f0 fs/super.c:1547
> >   do_new_mount fs/namespace.c:2875 [inline]
> >   path_mount+0x1387/0x2070 fs/namespace.c:3192
> >   do_mount fs/namespace.c:3205 [inline]
> >   __do_sys_mount fs/namespace.c:3413 [inline]
> >   __se_sys_mount fs/namespace.c:3390 [inline]
> >   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
> >   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x46004a
> > Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
> > RSP: 002b:00007f414d78da88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 00007f414d78db20 RCX: 000000000046004a
> > RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f414d78dae0
> > RBP: 00007f414d78dae0 R08: 00007f414d78db20 R09: 0000000020000000
> > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
> > R13: 0000000020000100 R14: 0000000020000200 R15: 000000002001a800
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
>
>
> #syz fix: btrfs: fix rw_devices count in __btrfs_free_extra_devids

Is it the correct patch title? It still does not exist anywhere
including linux-next...
