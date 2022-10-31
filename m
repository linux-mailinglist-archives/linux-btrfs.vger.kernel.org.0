Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4D613A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiJaPpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiJaPpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 11:45:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118312636;
        Mon, 31 Oct 2022 08:44:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a5so18001753edb.11;
        Mon, 31 Oct 2022 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qnWhdk0VieEk7vh40EvWTR4LqDHki8+24nSogRUOBk=;
        b=AKmfodvpGGhDyczCVn0UzETDdsnhtuif8sA89BFNygohnecF4CxxpHdmxfIDUBGoeI
         4JNPGcP7IUPqjUSX4cykw42mYx44Uju1O/th/tux5SxK0JFNUykJDiAsKHswqky5Hty0
         o3LxnxwEA5/DAzMlqwM+yFEJU7Mv+JCMUuRv10NXZOb7Ao3WIAgkOClE3ZkLTnYWAWSJ
         /1vAhqVflV1v6V2piKbPOBIBOxARk1dswLFb3BSHWneKfXlmt7FXQz0MSXvwe1dM0kHH
         jQkeuE2agWCT47tCj4JpzhYp+5SqaC73275F9AIVLi9KMBNLTdiXySPeFxfKwmBW/gIp
         230g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qnWhdk0VieEk7vh40EvWTR4LqDHki8+24nSogRUOBk=;
        b=bUAOVyVY/WHoI6eG716WkEclL153yx2wMoTnAsUKR3Gd7nTbtym1qlM831/Mmq9KgF
         mX3Tr5f92K1esiprf1+i95ekkgbcRkS1Ze4zhmNT1HWV6Llb4vu5wu3yK6hY5mx5Le3A
         9bxqjypmUMCIa4Ya1YzR9z27TXF/G9g24gznsq3I0zMLyZv6+nemKie04SLSMiHLGZTY
         gDDeGRHafJzc7MrSyhPeT5Bki2g8cKcD3BUk7Non+b1lcPtEl36sez4k8b6OinK9x8Xn
         9OoCRhvGEW8BiMAdSqGJ7Q7fY+e9x2GkF3ExjOlLk9IbJLp85GLXDQeX6V6LwyprGW68
         ebjQ==
X-Gm-Message-State: ACrzQf10XOlCXdCX9ALtWP0BfCkEZusOVF8pTsnMGFe9fFKvdtziXnkY
        AxmNfdyWjjxhYVtwTxzPAYLx2KZgcsdID2DLIV0=
X-Google-Smtp-Source: AMsMyM4iTooOaldZ34X1S42+O4GreKSu6ywKipaEwi2Teo6hZUOtkY+bKKL1EcMIc2KUw7+Rp1WFYByAFgYnD9N8aKc=
X-Received: by 2002:a05:6402:f2a:b0:461:eff7:bae8 with SMTP id
 i42-20020a0564020f2a00b00461eff7bae8mr14300620eda.322.1667231080002; Mon, 31
 Oct 2022 08:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221030162223.25970-1-yin31149@gmail.com> <Y1/lvgHE4JKvxsi8@localhost.localdomain>
In-Reply-To: <Y1/lvgHE4JKvxsi8@localhost.localdomain>
From:   Hawkins Jiawei <yin31149@gmail.com>
Date:   Mon, 31 Oct 2022 23:44:28 +0800
Message-ID: <CAKrof1NNK=BAUoTb0cP+8N+68NsSRfHuJ7k47UVv_h-hW_GKGA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: update bytes_may_use in btrfs_free_reserved_bytes()
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        18801353760@163.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

On Mon, 31 Oct 2022 at 23:12, Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Mon, Oct 31, 2022 at 12:22:24AM +0800, Hawkins Jiawei wrote:
> > Syzkaller reports warning as follows:
> > =====================================
> > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122
> >   btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122
> >   block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
> > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122
> >   btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
> > Modules linked in:
> > [...]
> > RIP: 0010:btrfs_space_info_update_bytes_may_use
> >   fs/btrfs/space-info.h:122 [inline]
> > RIP: 0010:btrfs_space_info_free_bytes_may_use
> >   fs/btrfs/space-info.h:154 [inline]
> > RIP: 0010:block_rsv_release_bytes
> >   fs/btrfs/block-rsv.c:151 [inline]
> > RIP: 0010:btrfs_block_rsv_release+0x5d1/0x730
> >   fs/btrfs/block-rsv.c:295
> > [...]
> > Call Trace:
> >  <TASK>
> >  btrfs_release_global_block_rsv+0x2f/0x250 fs/btrfs/block-rsv.c:463
> >  btrfs_free_block_groups+0xb67/0xfd0 fs/btrfs/block-group.c:4053
> >  close_ctree+0x6c5/0xbde fs/btrfs/disk-io.c:4710
> >  generic_shutdown_super+0x130/0x310 fs/super.c:491
> >  kill_anon_super+0x36/0x60 fs/super.c:1085
> >  btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
> >  deactivate_locked_super+0xa7/0xf0 fs/super.c:331
> >  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
> >  task_work_run+0x146/0x1c0 kernel/task_work.c:177
> >  ptrace_notify+0x29a/0x340 kernel/signal.c:2354
> >  ptrace_report_syscall include/linux/ptrace.h:420 [inline]
> >  ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
> >  syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
> >  syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
> >  syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
> >  do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  [...]
> >  </TASK>
> > =====================================
> >
> > In btrfs_new_extent_direct(), kernel will reserves space for extent
> > by btrfs_reserve_extent(), and frees those space by
> > btrfs_free_reserved_extent() if btrfs_create_dio_extent() fails.
> >
> > Yet the problem is that, it may not update the space
> > info correctly. To be more specific, kernel will
> > converts space from ->bytes_may_use to ->bytes_reserved, in
> > btrfs_add_reserved_bytes() when reserving space.
> > But when freeing those space in btrfs_free_reserved_bytes(),
> > kernel does not convert space from ->bytes_reserved back to
> > ->bytes_may_use, which triggers the above warning.
> >
> > This patch solves it by converting space from ->bytes_reserved
> > back to ->bytes_may_use in btrfs_free_reserved_bytes().
> >
>
> This isn't correct.  I haven't looked at the code yet, but reservations go into
> ->bytes_may_use, and then when we reserve the space we subtract the reservation
> from ->bytes_may_use and add it to ->bytes_reserved.  If we free the reserved
> extent we only have to update ->bytes_reserved.  What may be happening here is
> we're failing to free the rest of our ->bytes_may_use resrvation, and that part
> needs to be addressed.  This fix as it stands however is incorrect.  Thanks,
Thanks for your explanation! I will re-analyse this bug in the way you
suggested.

>
> Josef
