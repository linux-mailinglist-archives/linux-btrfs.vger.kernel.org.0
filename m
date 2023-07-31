Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC30769A7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjGaPKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjGaPKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 11:10:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729C1BC6
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 08:09:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso80985e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690816189; x=1691420989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkSACQ185yDNC2p76NT2Z17d4EwKu0PvetEljtWKaTU=;
        b=4FQcXvP+5xbo5XsQOMlicCIUHJMhfFvtoyQPpdydoNjzhClsruYv34uvqcK/2dvoC4
         2onQbf1Y20yXHNGEUNNEzPhNSKD9KZnCy4V5Nx6d0M/09F4K80PHaSqSEX/dS50EXtwD
         YMgust/h9o+AYo1cgIfRfSLXm+ZoUkwNf7hifiCvbow2YH5q8Wddfc0J+m82yQNto56T
         m4KH8oc0wVfABihgrLHD4CtM2xsfwfdonWCkG4jz9yYfRY17PdW11BXLXsMNFj1F/PP8
         HX1zd0BWWQUXhZS8y05KsfiLIusXFK42CALzdpXRl9MfmoAWrCgWlEgF6776Q15/Ofuk
         e80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816189; x=1691420989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkSACQ185yDNC2p76NT2Z17d4EwKu0PvetEljtWKaTU=;
        b=Juf2Ll6Hr9VRaqMG8zBHTzz4xDGTARGXEeYCZp8ggToAs2D2glkS3jkplTMo7neX7y
         Sf8G3657fta1BrqtQLuKY9o14DluilzJmNNmY//oNXRMRMzK3ZGUciokgz78LlHXsz9W
         zDjTlsyLvUZegHMMaJxo4CC/nX7/+53FxNmNQYy2J0lIg3ahlKQFOjqZqGI+NF302AdN
         tdOLubwCk/oEfeLJu1hChVSGo0Eeza3SPbtbk08ajrLKnLeqNjWz3+7ok+hhY05qvsr/
         DlNHmi2EberIQEcBvcYcfUphYsbIvzBCsDtkgxjNHh8XuJ8x1wbsLks77QH5ExSLiBgC
         lXSg==
X-Gm-Message-State: ABy/qLZFI/1YDnwgxIWM/e3uQ/z8H6QvMCWWVOXQldP//UFaF5Oxdfwl
        OlhYYH9UrgQkXGnooyb3fcoILt1m4tSDSPShP09CVw==
X-Google-Smtp-Source: APBJJlEqealXDm6xQmEIgqmI5g5eVpSrfgqDalsc/CjusIOfJwOScJ7VPEIJob8wJEkS3Oj26SYWUho8DY8CwApPe2g=
X-Received: by 2002:a7b:cbcd:0:b0:3fd:e15:6d5 with SMTP id n13-20020a7bcbcd000000b003fd0e1506d5mr155706wmi.2.1690816189181;
 Mon, 31 Jul 2023 08:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003d4a1a05ef104401@google.com> <2de85e6f-b1ad-69ae-1e60-cd47c91115a9@gmx.com>
In-Reply-To: <2de85e6f-b1ad-69ae-1e60-cd47c91115a9@gmx.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 31 Jul 2023 18:09:34 +0300
Message-ID: <CANp29Y7RuSVpcM935CghayAyfMvPYAis=XhzrU8SQXYWgSJQeg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in lookup_inline_extent_backref
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     syzbot <syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 8:56=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2022/12/5 16:13, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a4412fdd49dc error-injection: Add prompt for function e=
rro..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1469bdbd880=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2325e409a9a=
893e1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd6f9ff86c1d80=
4ba2bc6
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2=
da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12d892478=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16b1ca83880=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3bbe66b25958/d=
isk-a4412fdd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6851483ca667/vmli=
nux-a4412fdd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2d5b23cb4616=
/bzImage-a4412fdd.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/1f178223=
dd56/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 6559 at fs/btrfs/extent-tree.c:865 lookup_inline_e=
xtent_backref+0x8c1/0x13f0
> > Modules linked in:
> > CPU: 0 PID: 6559 Comm: syz-executor311 Not tainted 6.1.0-rc7-syzkaller-=
00123-ga4412fdd49dc #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/26/2022
> > RIP: 0010:lookup_inline_extent_backref+0x8c1/0x13f0 fs/btrfs/extent-tre=
e.c:865
> > Code: 98 00 00 00 0f 87 42 0b 00 00 e8 5a 9c 07 fe 4c 8b 6c 24 28 eb 3d=
 83 7d 28 00 4c 8b 6c 24 28 0f 84 b0 04 00 00 e8 3f 9c 07 fe <0f> 0b 41 bc =
fb ff ff ff e9 f3 05 00 00 e8 2d 9c 07 fe e9 ca 05 00
> > RSP: 0018:ffffc90006296e40 EFLAGS: 00010293
> > RAX: ffffffff8382fbb1 RBX: 0000000000000000 RCX: ffff88801eab1d40
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffc90006296ff0 R08: ffffffff8382f700 R09: ffffed100faf1008
> > R10: ffffed100faf1008 R11: 1ffff1100faf1007 R12: dffffc0000000000
> > R13: ffff888075edcd10 R14: ffffc90006296f60 R15: ffff88807d788000
> > FS:  00007fdb617d5700(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055912e028900 CR3: 000000001954b000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   insert_inline_extent_backref+0xcc/0x260 fs/btrfs/extent-tree.c:1152
> >   __btrfs_inc_extent_ref+0x108/0x5e0 fs/btrfs/extent-tree.c:1455
> >   btrfs_run_delayed_refs_for_head+0xf00/0x1df0 fs/btrfs/extent-tree.c:1=
943
> >   __btrfs_run_delayed_refs+0x25f/0x490 fs/btrfs/extent-tree.c:2008
> >   btrfs_run_delayed_refs+0x312/0x490 fs/btrfs/extent-tree.c:2139
> >   qgroup_account_snapshot+0xce/0x340 fs/btrfs/transaction.c:1538
> >   create_pending_snapshot+0xf35/0x2560 fs/btrfs/transaction.c:1800
> >   create_pending_snapshots+0x1a8/0x1e0 fs/btrfs/transaction.c:1868
> >   btrfs_commit_transaction+0x13f0/0x3760 fs/btrfs/transaction.c:2323
> >   create_snapshot+0x4aa/0x7e0 fs/btrfs/ioctl.c:833
> >   btrfs_mksubvol+0x62e/0x760 fs/btrfs/ioctl.c:983
> >   btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1029
> >   __btrfs_ioctl_snap_create+0x339/0x450 fs/btrfs/ioctl.c:2184
> >   btrfs_ioctl_snap_create+0x134/0x190 fs/btrfs/ioctl.c:2211
> >   btrfs_ioctl+0x15c/0xc10
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:870 [inline]
> >   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fdb6184aa69
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fdb617d52f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fdb618d57f0 RCX: 00007fdb6184aa69
> > RDX: 00000000200000c0 RSI: 0000000050009401 RDI: 0000000000000004
> > RBP: 00007fdb618a226c R08: 00007fdb617d5700 R09: 0000000000000000
> > R10: 00007fdb617d5700 R11: 0000000000000246 R12: 8000000000000000
> > R13: 00007fdb618a1270 R14: 0000000100000000 R15: 00007fdb618d57f8
> >   </TASK>
>
> # syz test: git://github.com/adam900710/linux.git inline_lookup_debug

The bot does not expect the space between # and syz, so

 #syz test: git://github.com/adam900710/linux.git inline_lookup_debug
