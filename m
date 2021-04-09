Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9B35A032
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDINnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhDINnU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 09:43:20 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE8C061760
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Apr 2021 06:43:07 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b139so416640qkc.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Apr 2021 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tvMm810cPkKaY3jg3EWKNpzFfD8Ky1Uq11CzgDTy57Y=;
        b=qjmacr9zxsI6/IX/I4yIHxkH9aTCwaG/SWSudKCI7T3nPTLc11xRw1dLe+ysKHv8bW
         j0BR5UyDQko9l/xbddpWPBwiw0ixNvSx2xgJho8gWqUxIKG+BQsKc1sUxE/ETFPo+wU3
         GYAXbVfIi2dcD4EkSfLSpZXDAMg7bvsOlVAKIEY4Y54c7xaq7mfxKxZ0fN9b5Qmlz7Od
         Wu60ps8dOIj4CCoKdZpsv9OZrY7VwZTlLM+aWn8dWt+7WymvBdHByDBIeq89bo+LHLPk
         eT6kyOP9JWLJy2Ip0rBEk7Cd9q0qDATzaDuZqcIOZYl+VcLEqwvisM13umSI3CTUgG9L
         tgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tvMm810cPkKaY3jg3EWKNpzFfD8Ky1Uq11CzgDTy57Y=;
        b=X9lQaMYsVRtQeN6y84mNP88tk/Off2x4Dx13kElDPIOch1y6sBVxQ+eH1KcB6dIdT6
         kIG7p7eXnW/TpsmoLEsYJgw2uOjBwYNmWP7/X/2gncwD3eZFKdU+Q1Jm7wMdWOOG4BRv
         wN2vGwXhrYyTkUnLIEdjjpg+ota0SefDdJIgKjZnwd/l6TrwawrbUk5vmgvPe3PVNyKo
         6guRLXCOMFm6u9qRGYGZOh15NtSKaRqtGYnCKd+N4TN97/uV3Id+UJnCQ6Vhr8luHhTt
         QCEI+1yQqjvz7lGxMlig2pX0pqqCbwacOYZ5hyLoGXCk6u2EBhCGfpkb36lQlkLPnUsW
         FTtw==
X-Gm-Message-State: AOAM530rE6iloUfnuQEB13YfmNf6S33K7IE0Yz5MmJ67qrgNuWrvzR4g
        KftFp0qQtsS0+7XMEm4uwrXryECUnxBJdVkUg0M=
X-Google-Smtp-Source: ABdhPJzOWJ3BdqXYRMaVEwCRtZVymq56cLOiJJHcrXHH5QVcsD2WEjd1IfJy9yACmTI+Y0s60ExjMdql32au7OVDGhY=
X-Received: by 2002:a05:620a:78b:: with SMTP id 11mr13900506qka.0.1617975786160;
 Fri, 09 Apr 2021 06:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210408072800.6C1F.409509F4@e16-tech.com> <YG5uFrWpwDHMhdR1@google.com>
 <20210408171959.2D72.409509F4@e16-tech.com> <YG8JsdAebEPqOhr/@google.com>
 <CAL3q7H5RNBjCi708GH7jnczAOe0BLnacT9C+OBgA-Dx9jhB6SQ@mail.gmail.com>
 <YG8a8uJQe/Cca3Ar@google.com> <CAL3q7H4gQBSNUW4aMTEuLx7wjNXD8ZgVOmdkXN3Wq7yayMaacg@mail.gmail.com>
 <YHBZFyLoGUG6LnJN@google.com>
In-Reply-To: <YHBZFyLoGUG6LnJN@google.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 9 Apr 2021 14:42:55 +0100
Message-ID: <CAL3q7H4YvY44afemhSdeV5307Cvpi9+KvFc_CEaAFFJKvg5PxQ@mail.gmail.com>
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

On Fri, Apr 9, 2021 at 2:39 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Fri, Apr 09, 2021 at 12:39:38PM +0100, Filipe Manana wrote:
> > On Thu, Apr 8, 2021 at 4:02 PM Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > On Thu, Apr 08, 2021 at 03:28:20PM +0100, Filipe Manana wrote:
> > > > On Thu, Apr 8, 2021 at 2:50 PM Dennis Zhou <dennis@kernel.org> wrot=
e:
> > > > >
> > > > > On Thu, Apr 08, 2021 at 05:20:00PM +0800, Wang Yugui wrote:
> > > > > > Hi,
> > > > > >
> > > > > > > On Thu, Apr 08, 2021 at 07:28:01AM +0800, Wang Yugui wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > > > > > upper caller:
> > > > > > > > > > > >     nofs_flag =3D memalloc_nofs_save();
> > > > > > > > > > > >     ret =3D btrfs_drew_lock_init(&root->snapshot_lo=
ck);
> > > > > > > > > > > >     memalloc_nofs_restore(nofs_flag);
> > > > > > > > >
> > > > > > > > > The issue is here. nofs is set which means percpu attempt=
s an atomic
> > > > > > > > > allocation. If it cannot find anything already allocated =
it isn't happy.
> > > > > > > > > This was done before memalloc_nofs_{save/restore}() were =
pervasive.
> > > > > > > > >
> > > > > > > > > Percpu should probably try to allocate some pages if poss=
ible even if
> > > > > > > > > nofs is set.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > I will wait for the patch, and then test it.
> > > > > > > >
> > > > > > >
> > > > > > > I'm currently a bit busy with some other things. Adding suppo=
rt I don't
> > > > > > > think will be much work, just a little bit tricky.
> > > > > > >
> > > > > > > I recommend carrying what you have minus the change to reserv=
ed percpu
> > > > > > > memory for now. If I'm the one to write it, I'll cc you.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Dennis
> > > > > >
> > > > > >
> > > > > > In the recent test, another problem is triggered too with my ex=
tended
> > > > > > percpu buffer size patch. maybe this info is helpful.
> > > > > >
> > > > > > problem:
> > > > > > OS/VGA console is freezed , and no call stace is outputed.
> > > > > > Just some info is outputed to IPMI/dell iDRAC
> > > > > >    2 | 04/03/2021 | 11:35:01 | OS Critical Stop #0x46 | Run-tim=
e critical stop () | Asserted
> > > > > >    3 | Linux kernel panic: Fatal excep
> > > > > >    4 | Linux kernel panic: tion
> > > > > >    5 | 04/05/2021 | 19:09:14 | OS Critical Stop #0x46 | Run-tim=
e critical stop () | Asserted
> > > > > >    6 | Linux kernel panic: Fatal excep
> > > > > >    7 | Linux kernel panic: tion
> > > > > >    8 | 04/06/2021 | 13:08:42 | OS Critical Stop #0x46 | Run-tim=
e critical stop () | Asserted
> > > > > >    9 | Linux kernel panic: Fatal excep
> > > > > >    a | Linux kernel panic: tion
> > > > > >    b | 04/08/2021 | 02:12:46 | OS Critical Stop #0x46 | Run-tim=
e critical stop () | Asserted
> > > > > >    c | Linux kernel panic: Fatal excep
> > > > > >    d | Linux kernel panic: tion
> > > > >
> > > > > Unfortunately non of the above to me is useful.
> > > > >
> > > > > > kernel: at least 5.10.26/5.10.27/5.10.28
> > > > > >
> > > > > > This problem is triggered by our application, NOT xfstests.
> > > > > > But our applicaiton have some heavy write load just like xfstes=
t/generic/476.
> > > > > > Our application use at most 75% of memory, if still not enough,
> > > > > > it will write out all buffer info to filesystem.
> > > > >
> > > > > Do you use cgroups at all? If yes can you describe the workload p=
attern
> > > > > a bit.
> > > > >
> > > > > > This problem is happen in linux kernel 5.10.x, but not happen i=
n linux
> > > > > > kernel 5.4.x. It have high frequency to repduce too.
> > > > >
> > > > > Ah. Can you try the following patch?
> > > > > https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/
> > > >
> > > > Btw, this has been happening since 5.9.
> > > > I never managed to find the time to bisect it, but it might be more
> > > > obvious to you or anyone else with deep experience of mm/percpu of
> > > > what changed.
> > > >
> > >
> > > Ah I'm sorry about that. It wasn't brought to my attention and I don'=
t
> > > frequent the btrfs slack anymore. I can try and pop in more frequentl=
y
> > > if that would help with these things.
> >
> > No worries, I don't think anyone reported it before.
> >
> > >
> > > > It's triggered very frequently with long runs of fsstress on btrfs,
> > > > such as with test cases btrfs/078 and generic/476 from fstests.
> > > > It produces a trace like the following:
> > > >
> > > > [128063.794597] ------------[ cut here ]------------
> > > > [128063.795305] BTRFS: Transaction aborted (error -12)
> > > > [128063.795831] WARNING: CPU: 0 PID: 1131545 at
> > > > fs/btrfs/transaction.c:1683 create_pending_snapshot+0xa2a/0xfd0
> > > > [btrfs]
> > > > [128063.796235] Modules linked in: dm_snapshot btrfs dm_thin_pool
> > > > dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_dust
> > > > dm_flakey dm_mod loop xfs blake2b_generic xor raid6_pq libcrc32c
> > > > intel_rapl_msr intel_rapl_common kvm_intel kvm irqbypass
> > > > crct10dif_pclmul g>
> > > > [128063.798521] CPU: 0 PID: 1131545 Comm: fsstress Tainted: G      =
  W
> > > >         5.10.0-rc2-btrfs-next-71 #1
> > > > [128063.799102] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6),
> > > > BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > [128063.800150] RIP: 0010:create_pending_snapshot+0xa2a/0xfd0 [btrf=
s]
> > > > [128063.800748] Code: 02 72 30 83 f8 fb 0f 84 38 03 00 00 83 f8 e2 =
0f
> > > > 84 2f 03 00 00 89 c6 48 c7 c7 e8 af c5 c0 48 89 85 78 ff ff ff e8 6=
d
> > > > 29 6b ca <0f> 0b 48 8b 85 78 ff ff ff 89 c1 ba 93 06 00 00 48 c7 c6=
 90
> > > > a6 c4
> > > > [128063.801886] RSP: 0018:ffffaad1444cfd50 EFLAGS: 00010282
> > > > [128063.802529] RAX: 0000000000000000 RBX: ffff99c4c0d0b500 RCX:
> > > > 0000000000000000
> > > > [128063.803175] RDX: 0000000000000001 RSI: 0000000000000027 RDI:
> > > > 00000000ffffffff
> > > > [128063.803829] RBP: ffffaad1444cfe20 R08: 0000000000000000 R09:
> > > > 0000000000000000
> > > > [128063.804478] R10: 0000000000000000 R11: 0000000000000000 R12:
> > > > ffff99c70a1a4c10
> > > > [128063.805134] R13: ffff99c59e3d0e00 R14: ffff99c70e935d08 R15:
> > > > 00000000fffffff4
> > > > [128063.805816] FS:  00007f0fdd733240(0000) GS:ffff99c7ebe00000(000=
0)
> > > > knlGS:0000000000000000
> > > > [128063.806547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [128063.807264] CR2: 00007f0fdd731000 CR3: 00000001ee3b6003 CR4:
> > > > 00000000003706f0
> > > > [128063.807998] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > > 0000000000000000
> > > > [128063.808707] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > 0000000000000400
> > > > [128063.809415] Call Trace:
> > > > [128063.810172]  ? create_pending_snapshots+0xaa/0xd0 [btrfs]
> > > > [128063.810921]  create_pending_snapshots+0xaa/0xd0 [btrfs]
> > > > [128063.811680]  btrfs_commit_transaction+0x2b6/0xb80 [btrfs]
> > > > [128063.812429]  ? finish_wait+0x90/0x90
> > > > [128063.813176]  ? __ia32_sys_fdatasync+0x20/0x20
> > > > [128063.813898]  iterate_supers+0x87/0xf0
> > > > [128063.814562]  ksys_sync+0x60/0xb0
> > > > [128063.815214]  __do_sys_sync+0xa/0x10
> > > > [128063.815879]  do_syscall_64+0x33/0x80
> > > > [128063.816539]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > [128063.817191] RIP: 0033:0x7f0fdd829bd7
> > > > [128063.817907] Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 15 b1 =
82
> > > > 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 b8 a2 00 0=
0
> > > > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 82 0c 00 f7 d8 64=
 89
> > > > 01 48
> > > > [128063.819411] RSP: 002b:00007fff356b8968 EFLAGS: 00000206 ORIG_RA=
X:
> > > > 00000000000000a2
> > > > [128063.820233] RAX: ffffffffffffffda RBX: 000055acc4127560 RCX:
> > > > 00007f0fdd829bd7
> > > > [128063.821028] RDX: 00000000ffffffff RSI: 000000002ecb3555 RDI:
> > > > 00000000000069f4
> > > > [128063.821808] RBP: 000000000000c350 R08: 0000000000000014 R09:
> > > > 00007fff356b893c
> > > > [128063.822632] R10: 00007fff356b8565 R11: 0000000000000206 R12:
> > > > 00000000000069f4
> > > > [128063.823416] R13: 00007fff356b89d0 R14: 00007fff356b8986 R15:
> > > > 000055acc4115350
> > > > [128063.824249] CPU: 5 PID: 1131545 Comm: fsstress Tainted: G      =
  W
> > > >         5.10.0-rc2-btrfs-next-71 #1
> > > > [128063.824931] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6),
> > > > BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > [128063.826439] Call Trace:
> > > > [128063.827119]  dump_stack+0x8d/0xb5
> > > > [128063.827804]  ? create_pending_snapshot+0xa2a/0xfd0 [btrfs]
> > > > [128063.828456]  __warn.cold+0x24/0x4b
> > > > [128063.829100]  ? create_pending_snapshot+0xa2a/0xfd0 [btrfs]
> > > > [128063.829724]  report_bug+0xd1/0x100
> > > > [128063.830327]  handle_bug+0x35/0x80
> > > > [128063.830910]  exc_invalid_op+0x14/0x70
> > > > [128063.831476]  asm_exc_invalid_op+0x12/0x20
> > > > [128063.832042] RIP: 0010:create_pending_snapshot+0xa2a/0xfd0 [btrf=
s]
> > > >
> > > > With 5.8 and older, I never got such failures on my test boxes.
> > > >
> > >
> > > Ah. Roman's cgroup percpu changes went in for 5.9. Can you please pat=
ch:
> > > https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/
> > >
> > > That most likely will have to be cced to stable for 5.9+.
> >
> > With that patch applied, +12 hours runs of heavy fsstress and fstests
> > did not trigger the issue anymore here.
>
> Wonderful! Is it okay if I throw your Tested-by: on it? I'm going to
> send this up tomorrow and have cced stable on the patch as well.

Sure, please add with my suse address:

Tested-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> >
> > Thanks Dennis.
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D
>
> Thanks,
> Dennis



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
