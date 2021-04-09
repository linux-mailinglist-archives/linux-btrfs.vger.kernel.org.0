Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E5359D8A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDILkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDILkF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 07:40:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98CC061760
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Apr 2021 04:39:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c3so5435738qkc.5
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Apr 2021 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=n6kG64sSQGZeoJDQwpKXTmXY9H14h1av0i3P5Us6SFs=;
        b=BXbJ1L5xRQpCGxnEOqFfCnNW2c69wYcmTrGaQebwA38O1n2xim6oQz8szF4jNR2VlX
         71oemixjMlVA+oIVN0Oz0H1bKsN+PKXSLATX3kZ6GAB0ZcgWhowC+u6dth96vWAUWDs7
         P9VvmJOLwvd0/DXj+66Z80NkDYVdzRM7DXvzKvnuepG30l8Aa6w3tWXs0TxEYySBFAmH
         xfv6Y1rEn+XVmskEYX4PV6I/1LNf+ptaRjre4kFZXXGycVh0Z2b0Rs4TUDwD7s9CLX+n
         wuBWsmQtrQyEx98ZNFyrgWLeBZq4dhhnMK2KdGN9FpS+fOXTA30bbYmhaaY50kh/pc54
         Up+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=n6kG64sSQGZeoJDQwpKXTmXY9H14h1av0i3P5Us6SFs=;
        b=T+t8pSzBmv760R5O+rJjX3aoDIr6S7GKxv1Js29yRgVFxiIebRldxJpRUE/BlOm7xj
         8+bQcGsTf8uKFan5t+g1iw4pjE4/4SRR8/GkNLETVvNj5rNedB1W3TdnE9uAqHpFwP4d
         /mJagSeaR4yXGjSROsNGxaX61YEXLMIi46DAoo3Aj6DGEuSRVxW92kPlJi4XPciFnHVb
         EyWIydPtgJmv1TXUkj13nz2Db1bK1bl0LpVZ+6YCby9UUhh/gWYcZGcKITcAvEyjwkwi
         YMvIEtKhDQE928fgWLP0jxzLB0KSrvkCaMACbAzXLmFTUvlzEI7bpix8YI+R9Kmy4HVC
         DPRA==
X-Gm-Message-State: AOAM531XA9awDWAdn6JZABqV+4JsxPyaxGHluAk2Vauz8Hns6ZzFVA6H
        RjrCJirkEVLnO3DpKMlsuMbNbcE3YHYgGOpo0Ws=
X-Google-Smtp-Source: ABdhPJwg73tSmKXp6M8rcjqNBXtAmIaG1SYy0llAs93aIKkB8GScyNTywIbSeGRgvDHIHLbXp+ctSXoKMt8NJdQg6Lw=
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr13823682qkk.438.1617968389636;
 Fri, 09 Apr 2021 04:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210408072800.6C1F.409509F4@e16-tech.com> <YG5uFrWpwDHMhdR1@google.com>
 <20210408171959.2D72.409509F4@e16-tech.com> <YG8JsdAebEPqOhr/@google.com>
 <CAL3q7H5RNBjCi708GH7jnczAOe0BLnacT9C+OBgA-Dx9jhB6SQ@mail.gmail.com> <YG8a8uJQe/Cca3Ar@google.com>
In-Reply-To: <YG8a8uJQe/Cca3Ar@google.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 9 Apr 2021 12:39:38 +0100
Message-ID: <CAL3q7H4gQBSNUW4aMTEuLx7wjNXD8ZgVOmdkXN3Wq7yayMaacg@mail.gmail.com>
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 8, 2021 at 4:02 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Thu, Apr 08, 2021 at 03:28:20PM +0100, Filipe Manana wrote:
> > On Thu, Apr 8, 2021 at 2:50 PM Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > On Thu, Apr 08, 2021 at 05:20:00PM +0800, Wang Yugui wrote:
> > > > Hi,
> > > >
> > > > > On Thu, Apr 08, 2021 at 07:28:01AM +0800, Wang Yugui wrote:
> > > > > > Hi,
> > > > > >
> > > > > > > > > > upper caller:
> > > > > > > > > >     nofs_flag =3D memalloc_nofs_save();
> > > > > > > > > >     ret =3D btrfs_drew_lock_init(&root->snapshot_lock);
> > > > > > > > > >     memalloc_nofs_restore(nofs_flag);
> > > > > > >
> > > > > > > The issue is here. nofs is set which means percpu attempts an=
 atomic
> > > > > > > allocation. If it cannot find anything already allocated it i=
sn't happy.
> > > > > > > This was done before memalloc_nofs_{save/restore}() were perv=
asive.
> > > > > > >
> > > > > > > Percpu should probably try to allocate some pages if possible=
 even if
> > > > > > > nofs is set.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > I will wait for the patch, and then test it.
> > > > > >
> > > > >
> > > > > I'm currently a bit busy with some other things. Adding support I=
 don't
> > > > > think will be much work, just a little bit tricky.
> > > > >
> > > > > I recommend carrying what you have minus the change to reserved p=
ercpu
> > > > > memory for now. If I'm the one to write it, I'll cc you.
> > > > >
> > > > > Thanks,
> > > > > Dennis
> > > >
> > > >
> > > > In the recent test, another problem is triggered too with my extend=
ed
> > > > percpu buffer size patch. maybe this info is helpful.
> > > >
> > > > problem:
> > > > OS/VGA console is freezed , and no call stace is outputed.
> > > > Just some info is outputed to IPMI/dell iDRAC
> > > >    2 | 04/03/2021 | 11:35:01 | OS Critical Stop #0x46 | Run-time cr=
itical stop () | Asserted
> > > >    3 | Linux kernel panic: Fatal excep
> > > >    4 | Linux kernel panic: tion
> > > >    5 | 04/05/2021 | 19:09:14 | OS Critical Stop #0x46 | Run-time cr=
itical stop () | Asserted
> > > >    6 | Linux kernel panic: Fatal excep
> > > >    7 | Linux kernel panic: tion
> > > >    8 | 04/06/2021 | 13:08:42 | OS Critical Stop #0x46 | Run-time cr=
itical stop () | Asserted
> > > >    9 | Linux kernel panic: Fatal excep
> > > >    a | Linux kernel panic: tion
> > > >    b | 04/08/2021 | 02:12:46 | OS Critical Stop #0x46 | Run-time cr=
itical stop () | Asserted
> > > >    c | Linux kernel panic: Fatal excep
> > > >    d | Linux kernel panic: tion
> > >
> > > Unfortunately non of the above to me is useful.
> > >
> > > > kernel: at least 5.10.26/5.10.27/5.10.28
> > > >
> > > > This problem is triggered by our application, NOT xfstests.
> > > > But our applicaiton have some heavy write load just like xfstest/ge=
neric/476.
> > > > Our application use at most 75% of memory, if still not enough,
> > > > it will write out all buffer info to filesystem.
> > >
> > > Do you use cgroups at all? If yes can you describe the workload patte=
rn
> > > a bit.
> > >
> > > > This problem is happen in linux kernel 5.10.x, but not happen in li=
nux
> > > > kernel 5.4.x. It have high frequency to repduce too.
> > >
> > > Ah. Can you try the following patch?
> > > https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/
> >
> > Btw, this has been happening since 5.9.
> > I never managed to find the time to bisect it, but it might be more
> > obvious to you or anyone else with deep experience of mm/percpu of
> > what changed.
> >
>
> Ah I'm sorry about that. It wasn't brought to my attention and I don't
> frequent the btrfs slack anymore. I can try and pop in more frequently
> if that would help with these things.

No worries, I don't think anyone reported it before.

>
> > It's triggered very frequently with long runs of fsstress on btrfs,
> > such as with test cases btrfs/078 and generic/476 from fstests.
> > It produces a trace like the following:
> >
> > [128063.794597] ------------[ cut here ]------------
> > [128063.795305] BTRFS: Transaction aborted (error -12)
> > [128063.795831] WARNING: CPU: 0 PID: 1131545 at
> > fs/btrfs/transaction.c:1683 create_pending_snapshot+0xa2a/0xfd0
> > [btrfs]
> > [128063.796235] Modules linked in: dm_snapshot btrfs dm_thin_pool
> > dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_dust
> > dm_flakey dm_mod loop xfs blake2b_generic xor raid6_pq libcrc32c
> > intel_rapl_msr intel_rapl_common kvm_intel kvm irqbypass
> > crct10dif_pclmul g>
> > [128063.798521] CPU: 0 PID: 1131545 Comm: fsstress Tainted: G        W
> >         5.10.0-rc2-btrfs-next-71 #1
> > [128063.799102] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > [128063.800150] RIP: 0010:create_pending_snapshot+0xa2a/0xfd0 [btrfs]
> > [128063.800748] Code: 02 72 30 83 f8 fb 0f 84 38 03 00 00 83 f8 e2 0f
> > 84 2f 03 00 00 89 c6 48 c7 c7 e8 af c5 c0 48 89 85 78 ff ff ff e8 6d
> > 29 6b ca <0f> 0b 48 8b 85 78 ff ff ff 89 c1 ba 93 06 00 00 48 c7 c6 90
> > a6 c4
> > [128063.801886] RSP: 0018:ffffaad1444cfd50 EFLAGS: 00010282
> > [128063.802529] RAX: 0000000000000000 RBX: ffff99c4c0d0b500 RCX:
> > 0000000000000000
> > [128063.803175] RDX: 0000000000000001 RSI: 0000000000000027 RDI:
> > 00000000ffffffff
> > [128063.803829] RBP: ffffaad1444cfe20 R08: 0000000000000000 R09:
> > 0000000000000000
> > [128063.804478] R10: 0000000000000000 R11: 0000000000000000 R12:
> > ffff99c70a1a4c10
> > [128063.805134] R13: ffff99c59e3d0e00 R14: ffff99c70e935d08 R15:
> > 00000000fffffff4
> > [128063.805816] FS:  00007f0fdd733240(0000) GS:ffff99c7ebe00000(0000)
> > knlGS:0000000000000000
> > [128063.806547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [128063.807264] CR2: 00007f0fdd731000 CR3: 00000001ee3b6003 CR4:
> > 00000000003706f0
> > [128063.807998] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [128063.808707] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [128063.809415] Call Trace:
> > [128063.810172]  ? create_pending_snapshots+0xaa/0xd0 [btrfs]
> > [128063.810921]  create_pending_snapshots+0xaa/0xd0 [btrfs]
> > [128063.811680]  btrfs_commit_transaction+0x2b6/0xb80 [btrfs]
> > [128063.812429]  ? finish_wait+0x90/0x90
> > [128063.813176]  ? __ia32_sys_fdatasync+0x20/0x20
> > [128063.813898]  iterate_supers+0x87/0xf0
> > [128063.814562]  ksys_sync+0x60/0xb0
> > [128063.815214]  __do_sys_sync+0xa/0x10
> > [128063.815879]  do_syscall_64+0x33/0x80
> > [128063.816539]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [128063.817191] RIP: 0033:0x7f0fdd829bd7
> > [128063.817907] Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 15 b1 82
> > 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 b8 a2 00 00
> > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 82 0c 00 f7 d8 64 89
> > 01 48
> > [128063.819411] RSP: 002b:00007fff356b8968 EFLAGS: 00000206 ORIG_RAX:
> > 00000000000000a2
> > [128063.820233] RAX: ffffffffffffffda RBX: 000055acc4127560 RCX:
> > 00007f0fdd829bd7
> > [128063.821028] RDX: 00000000ffffffff RSI: 000000002ecb3555 RDI:
> > 00000000000069f4
> > [128063.821808] RBP: 000000000000c350 R08: 0000000000000014 R09:
> > 00007fff356b893c
> > [128063.822632] R10: 00007fff356b8565 R11: 0000000000000206 R12:
> > 00000000000069f4
> > [128063.823416] R13: 00007fff356b89d0 R14: 00007fff356b8986 R15:
> > 000055acc4115350
> > [128063.824249] CPU: 5 PID: 1131545 Comm: fsstress Tainted: G        W
> >         5.10.0-rc2-btrfs-next-71 #1
> > [128063.824931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > [128063.826439] Call Trace:
> > [128063.827119]  dump_stack+0x8d/0xb5
> > [128063.827804]  ? create_pending_snapshot+0xa2a/0xfd0 [btrfs]
> > [128063.828456]  __warn.cold+0x24/0x4b
> > [128063.829100]  ? create_pending_snapshot+0xa2a/0xfd0 [btrfs]
> > [128063.829724]  report_bug+0xd1/0x100
> > [128063.830327]  handle_bug+0x35/0x80
> > [128063.830910]  exc_invalid_op+0x14/0x70
> > [128063.831476]  asm_exc_invalid_op+0x12/0x20
> > [128063.832042] RIP: 0010:create_pending_snapshot+0xa2a/0xfd0 [btrfs]
> >
> > With 5.8 and older, I never got such failures on my test boxes.
> >
>
> Ah. Roman's cgroup percpu changes went in for 5.9. Can you please patch:
> https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/
>
> That most likely will have to be cced to stable for 5.9+.

With that patch applied, +12 hours runs of heavy fsstress and fstests
did not trigger the issue anymore here.

Thanks Dennis.

>
> Thanks,
> Dennis



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
