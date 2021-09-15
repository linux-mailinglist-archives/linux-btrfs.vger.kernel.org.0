Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53EB40BDED
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 04:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhIOC6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhIOC6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 22:58:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DEEC061574;
        Tue, 14 Sep 2021 19:57:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y17so1287252pfl.13;
        Tue, 14 Sep 2021 19:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QerLtYFhyBoiMxUDzcHQOlMQYU3YOoR9s6yK1SSR1HA=;
        b=m9Y3ObsMoZSPstj9eJATcQtCRbIu8YG9qwTWBHvtvLXuWOssP+dHHkmakcpg3RGCal
         UIAMsjWshHBiWXR+XolGsy8QruK+UiknuBHXKocAn/cXe8dsFRegmR5S/u1sJpgNFQRu
         CWDzEEJvq/etXgCtigfGepJpZj0aDYFsFbYwmOtMAaeU81U9J9WfQLEVKwEvYbn5qTG7
         R54kF6JRra/x/fCb2HtbrWBrb5YXll3epYgPibN+dcLtTj9Z9l8PdMtbquG8KdVH2KW4
         DHTvcVuDWEqgHNtKXCBr9NsjSVgPL3OqoKheQvwtFl/AmpwLHpgpcpA4mBN2sZ2f2ROe
         OKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QerLtYFhyBoiMxUDzcHQOlMQYU3YOoR9s6yK1SSR1HA=;
        b=p01laRfm9OFsZewQ3EEsWqIYeT72yLH6FuDylhQpLAz42ulowivj5AbretXyOSoL9Z
         luNACsUeqYwBOp0lbIfMtsR15QRJDDRjUiAavMWVeheL2sTYQDVzhPi9NkFjW1B+tpmU
         mrEnYgLuN1QY5vUAo+mUmaTEhlP7cgrrrbqeoLw2TRV5pcPmTMUK4zt89sKPyybaoXP9
         njFvPCyJGLEPUNECeGa7HRnE6rZUk2afo4CzqdvFcXPzrNnPMvQVEP0GHFY1KpasWZ/m
         D9Rm/Qh72daLxINyxt2g/xS0BgBSKxdqSGHsv9ldDC2FccR/UMp9gSiEEfknOM1n9zdQ
         gQiA==
X-Gm-Message-State: AOAM530yKtUPb1yl4MF5OLOcydyOLgW96tmcLqkCiDAw1zzKAy0FxO/a
        AE8sH/mxuAp5ClF29wNzNEjVxMilxhb4RXRpig==
X-Google-Smtp-Source: ABdhPJx35VGPMxNJWVP3WGniKF6MuphRkRCYx88RnO2+/cYxMCz0JlpmrJcspjcVf+3iet0Iw/afBSJdVhvqIuTuNxo=
X-Received: by 2002:a65:6389:: with SMTP id h9mr18386923pgv.83.1631674624307;
 Tue, 14 Sep 2021 19:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsa0wQ5oDQh0CABfV-UoAa9czS6DAuAA0fBrM_HhVxd6+w@mail.gmail.com>
 <a911ac2c-d743-03ea-513d-0b9756808d17@gmx.com>
In-Reply-To: <a911ac2c-d743-03ea-513d-0b9756808d17@gmx.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 10:56:53 +0800
Message-ID: <CACkBjsa6uQU9RGKVmtbkAjBkQn4QZNCWo5N_wq4RHjPcJKt2Kw@mail.gmail.com>
Subject: Re: WARNING in btrfs_run_delayed_refs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2021/9/15 =E4=B8=8A=E5=8D=8810:14, Hao Sun wrote:
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
> >
> > HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1gd0dl74MyvvVAYqsCDKSGmcfpZszD0kt/view?=
usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTL=
JvsUdWcgB/view?usp=3Dsharing
> > C reproducer: https://drive.google.com/file/d/1WKQukijOJ7D0NYk1iKf47FES=
jYfAjrlz/view?usp=3Dsharing
> > Syzlang reproducer:
> > https://drive.google.com/file/d/1Gi9-Mgbrjw1OI-ymO4zDVIFej2Qf4ppL/view?=
usp=3Dsharing
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> >
> > loop11: detected capacity change from 0 to 32768
> > BTRFS info (device loop11): disk space caching is enabled
> > BTRFS info (device loop11): has skinny extents
> > BTRFS info (device loop11): enabling ssd optimizations
> > FAULT_INJECTION: forcing a failure.
> > name failslab, interval 1, probability 0, space 0, times 0
> > CPU: 0 PID: 7769 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
> >   fail_dump lib/fault-inject.c:52 [inline]
> >   should_fail+0x13c/0x160 lib/fault-inject.c:146
> >   should_failslab+0x5/0x10 mm/slab_common.c:1328
> >   slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
> >   slab_alloc_node mm/slub.c:3120 [inline]
> >   slab_alloc mm/slub.c:3214 [inline]
> >   kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
> >   __btrfs_free_extent.isra.53+0x7b/0x1180 fs/btrfs/extent-tree.c:2942
> >   run_delayed_tree_ref fs/btrfs/extent-tree.c:1687 [inline]
> >   run_one_delayed_ref fs/btrfs/extent-tree.c:1711 [inline]
> >   btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1952 [inline]
> >   __btrfs_run_delayed_refs+0x83e/0x1a00 fs/btrfs/extent-tree.c:2017
> >   btrfs_run_delayed_refs+0xb1/0x2b0 fs/btrfs/extent-tree.c:2148
> >   btrfs_commit_transaction+0x7d/0x1430 fs/btrfs/transaction.c:2065
> >   btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
> >   btrfs_ioctl+0x209b/0x3be0 fs/btrfs/ioctl.c:4970
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:874 [inline]
> >   __se_sys_ioctl fs/ioctl.c:860 [inline]
> >   __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x46ae99
> > Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f8ac08c7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> > RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
> > RBP: 00007f8ac08c7c80 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> > R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffccc1d6390
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 7769 at fs/btrfs/extent-tree.c:2150
> > btrfs_run_delayed_refs+0x245/0x2b0 fs/btrfs/extent-tree.c:2150
>
> This is again btrfs_abort_transaction().
>
> This makes me wonder, should we add ENOMEM to abort transaction warning
> condition to make the ENOMEM injection code happy.
>
> Mind to test the following diff?
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8c6ee947a68d..6bc79f6716fa 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3548,7 +3548,8 @@ do {
>                  \
>          /* Report first abort since mount */                    \
>          if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,     \
>                          &((trans)->fs_info->fs_state))) {       \
> -               if ((errno) !=3D -EIO && (errno) !=3D -EROFS) {          =
   \
> +               if ((errno) !=3D -EIO && (errno) !=3D -EROFS &&     \
> +                   (errno) !=3D -ENOMEM) {                       \
>                          WARN(1, KERN_DEBUG                              =
\
>                          "BTRFS: Transaction aborted (error %d)\n",      =
\
>                          (errno));                                       =
\
>

Just tested it. This did fixed most `WARNING` reports, e.g., "WARNING
in btrfs_add_link", "WARNING in btrfs_run_delayed_refs".
I think it would be better if we can judge whether the  `ENOMEM` is
caused by `fault injection` or not.
