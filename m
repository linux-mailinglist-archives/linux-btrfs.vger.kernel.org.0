Return-Path: <linux-btrfs+bounces-10969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14148A11084
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 19:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB011889198
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D01FBC8A;
	Tue, 14 Jan 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErEen2wJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1518952C
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880765; cv=none; b=jxj6vs44FZ9ayjRy8Sh5tbhB9VOjqu1j7DnISBiqZWSk3CSuZIlTVPQttTaevT6rzyHZFyOxP03adwY5so8NGxce7OON24QCyORMfdKFzfmn0sDGhWaHN1gpcaKW6IMtGcpJqP3s66i7nmPLbAhDc11Ab0aQvwj94VS5CKCy/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880765; c=relaxed/simple;
	bh=owdfZjr9XtM2M9TdPY7ZvHUGXGAOjra7984D5UIvzH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ+HfRDOssoDzvxYOTwNYGYHbG9S0kEQ5lr+OhOGmMCh8lRglMnDoYRCFPg4q/AeGQ1Y7LMc+EUGgJCgZcpW5OqDucSWhr1iPSN7ol/e79FE/ZFDuhhgWve6QRQfH6wVUlW4IoOg8DSZWEagit5EqN/Nfu9DVLvNHHFFIM2aeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErEen2wJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAD0C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736880764;
	bh=owdfZjr9XtM2M9TdPY7ZvHUGXGAOjra7984D5UIvzH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ErEen2wJ5F4m60zsKvVuxQEzNT9yqMMgQsAPZTr6WWR/t04GgS2kFL08ezlo/OVBU
	 9kvgUzrAoscvH92HhJ2pPs89DPEISr/01JTi/3FTOg23IIfghxW/t8IFfDHGvXkGtj
	 iIOIVtz9RkJ5uGNfLyXFWacle3l1zTr90MwtbOtVbTvONvbo3KdKg8PRlHiVX5JK+m
	 E44qi/Y7Kgp/VBFpIejjcyvjxQtQ+KW3c4euTDLyuFZJMMXUN6Nr4M8wbsV6uvcvN5
	 dPJsLgc2PRN0o1j4cFLFGwp0pFStXiI2bGjTrM9vHcnlMP4ckVMPOc+hyQ2XPTAq89
	 oR1jGsD/ay9Vw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so138277a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 10:52:44 -0800 (PST)
X-Gm-Message-State: AOJu0YwAHDBDnSPVjV+dLJMlXiB71huGuAzQ1tWfiAGEisKMzUBMvBzH
	qguBykNS0bDuKxcMFN/43uev4Kyvv1yUOZinW0K87fNPJR++lbsiqUw1GMBbN31F2mDhkCEoHcV
	UBJKrr4eeNFAyNoA9BBtaSL8fdxk=
X-Google-Smtp-Source: AGHT+IFBDX70vySMr04oGu25IObk+mxYiSm2sec+ew++rD1vKbi56eesddS3ouiIVcHvBLrOpAqpk0OI57i5fKNBge0=
X-Received: by 2002:a17:907:a088:b0:ab2:bd80:4519 with SMTP id
 a640c23a62f3a-ab2c3c79997mr2089065666b.16.1736880763204; Tue, 14 Jan 2025
 10:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <efe1ae546864e0f22b4e29794115e3cedb602c30.1736782338.git.fdmanana@suse.com>
 <ef836984-61a0-4a09-95d5-901d499aec4a@gmx.com>
In-Reply-To: <ef836984-61a0-4a09-95d5-901d499aec4a@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 14 Jan 2025 18:52:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ctFOu-naGsfxREKuN7664fXUK=Rd_V_RFk70tXJhcFA@mail.gmail.com>
X-Gm-Features: AbW1kvZFux42Jr-u3LGC3LyUa3ObE8oOEtxES0tWSTFzAm1pMSYsKBX90i64S7I
Message-ID: <CAL3q7H7ctFOu-naGsfxREKuN7664fXUK=Rd_V_RFk70tXJhcFA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix assertion failure when splitting ordered
 extent after transaction abort
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/1/14 02:02, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If while we are doing a direct IO write a transaction abort happens, we
> > mark all existing ordered extents with the BTRFS_ORDERED_IOERR flag (do=
ne
> > at btrfs_destroy_ordered_extents()), and then after that if we enter
> > btrfs_split_ordered_extent() and the ordered extent has bytes left
> > (meaning we have a bio that doesn't cover the whole ordered extent, see
> > details at btrfs_extract_ordered_extent()), we will fail on the followi=
ng
> > assertion at btrfs_split_ordered_extent():
> >
> >     ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
> >
> > because the BTRFS_ORDERED_IOERR flag is set and the definition of
> > BTRFS_ORDERED_TYPE_FLAGS is just the union of all flags that identify t=
he
> > type of write (regular, nocow, prealloc, compressed, direct IO, encoded=
).
> >
> > Fix this by returning an error from btrfs_extract_ordered_extent() if w=
e
> > find the BTRFS_ORDERED_IOERR flag in the ordered extent. The error will
> > be the error that resulted in the transaction abort or -EIO if no
> > transaction abort happened.
> >
> > This was recently reported by syzbot with the following trace:
> >
> >     FAULT_INJECTION: forcing a failure.
> >     name failslab, interval 1, probability 0, space 0, times 1
> >     CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkal=
ler #0
> >     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-deb=
ian-1.16.3-2~bpo12+1 04/01/2014
> >     Call Trace:
> >      <TASK>
> >      __dump_stack lib/dump_stack.c:94 [inline]
> >      dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >      fail_dump lib/fault-inject.c:53 [inline]
> >      should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
> >      should_failslab+0xac/0x100 mm/failslab.c:46
> >      slab_pre_alloc_hook mm/slub.c:4072 [inline]
> >      slab_alloc_node mm/slub.c:4148 [inline]
> >      __do_kmalloc_node mm/slub.c:4297 [inline]
> >      __kmalloc_noprof+0xdd/0x4c0 mm/slub.c:4310
> >      kmalloc_noprof include/linux/slab.h:905 [inline]
> >      kzalloc_noprof include/linux/slab.h:1037 [inline]
> >      btrfs_chunk_alloc_add_chunk_item+0x244/0x1100 fs/btrfs/volumes.c:5=
742
> >      reserve_chunk_space+0x1ca/0x2c0 fs/btrfs/block-group.c:4292
> >      check_system_chunk fs/btrfs/block-group.c:4319 [inline]
> >      do_chunk_alloc fs/btrfs/block-group.c:3891 [inline]
> >      btrfs_chunk_alloc+0x77b/0xf80 fs/btrfs/block-group.c:4187
> >      find_free_extent_update_loop fs/btrfs/extent-tree.c:4166 [inline]
> >      find_free_extent+0x42d1/0x5810 fs/btrfs/extent-tree.c:4579
> >      btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4672
> >      btrfs_new_extent_direct fs/btrfs/direct-io.c:186 [inline]
> >      btrfs_get_blocks_direct_write+0x706/0xfa0 fs/btrfs/direct-io.c:321
> >      btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
> >      iomap_iter+0x697/0xf60 fs/iomap/iter.c:90
> >      __iomap_dio_rw+0xeb9/0x25b0 fs/iomap/direct-io.c:702
> >      btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
> >      btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
> >      btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
> >      do_iter_readv_writev+0x600/0x880
> >      vfs_writev+0x376/0xba0 fs/read_write.c:1050
> >      do_pwritev fs/read_write.c:1146 [inline]
> >      __do_sys_pwritev2 fs/read_write.c:1204 [inline]
> >      __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
> >      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >     RIP: 0033:0x7f1281f85d29
> >     Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >     RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
148
> >     RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
> >     RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
> >     RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
> >     R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
> >     R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
> >      </TASK>
> >     BTRFS error (device loop0 state A): Transaction aborted (error -12)
> >     BTRFS: error (device loop0 state A) in btrfs_chunk_alloc_add_chunk_=
item:5745: errno=3D-12 Out of memory
> >     BTRFS info (device loop0 state EA): forced readonly
> >     assertion failed: !(flags & ~BTRFS_ORDERED_TYPE_FLAGS), in fs/btrfs=
/ordered-data.c:1234
> >     ------------[ cut here ]------------
> >     kernel BUG at fs/btrfs/ordered-data.c:1234!
> >     Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >     CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkal=
ler #0
> >     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-deb=
ian-1.16.3-2~bpo12+1 04/01/2014
> >     RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-d=
ata.c:1234
> >     Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6 8=
0 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b e8=
 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
> >     RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
> >     RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
> >     RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> >     RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
> >     R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
> >     R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
> >     FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
> >     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >     Call Trace:
> >      <TASK>
> >      btrfs_extract_ordered_extent fs/btrfs/direct-io.c:702 [inline]
> >      btrfs_dio_submit_io+0x4be/0x6d0 fs/btrfs/direct-io.c:737
> >      iomap_dio_submit_bio fs/iomap/direct-io.c:85 [inline]
> >      iomap_dio_bio_iter+0x1022/0x1740 fs/iomap/direct-io.c:447
> >      __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
> >      btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
> >      btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
> >      btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
> >      do_iter_readv_writev+0x600/0x880
> >      vfs_writev+0x376/0xba0 fs/read_write.c:1050
> >      do_pwritev fs/read_write.c:1146 [inline]
> >      __do_sys_pwritev2 fs/read_write.c:1204 [inline]
> >      __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
> >      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >     RIP: 0033:0x7f1281f85d29
> >     Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >     RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
148
> >     RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
> >     RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
> >     RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
> >     R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
> >     R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
> >      </TASK>
> >     Modules linked in:
> >     ---[ end trace 0000000000000000 ]---
> >     RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-d=
ata.c:1234
> >     Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6 8=
0 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b e8=
 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
> >     RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
> >     RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
> >     RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> >     RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
> >     R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
> >     R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
> >     FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
> >     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> > In this case the transaction abort was due to (an injected) memory
> > allocation failure when attempting to allocate a new chunk.
> >
> > Reported-by: syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-btrfs/6777f2dd.050a0220.178762.0045=
.GAE@google.com/
> > Fixes: 52b1fdca23ac ("btrfs: handle completed ordered extents in btrfs_=
split_ordered_extent")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/ordered-data.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 30eceaf829a7..3cf95a801086 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -1229,6 +1229,18 @@ struct btrfs_ordered_extent *btrfs_split_ordered=
_extent(
> >        */
> >       if (WARN_ON_ONCE(len >=3D ordered->num_bytes))
> >               return ERR_PTR(-EINVAL);
> > +     /*
> > +      * If our ordered extent had an error there's no point in continu=
ing.
> > +      * The error may have come from a transaction abort done either b=
y this
> > +      * task or some other concurrent task, and the transaction abort =
path
> > +      * iterates over all existing ordered extents and sets the flag
> > +      * BTRFS_ORDERED_IOERR on them.
> > +      */
> > +     if (unlikely(flags & BTRFS_ORDERED_IOERR)) {

This should be:

flags & (1U << BTRFS_ORDERED_IOERR)

I'll fix it up when committing to for-next, thanks.

> > +             const int fs_error =3D BTRFS_FS_ERROR(fs_info);
> > +
> > +             return fs_error ? ERR_PTR(fs_error) : ERR_PTR(-EIO);
> > +     }
> >       /* We cannot split partially completed ordered extents. */
> >       if (ordered->bytes_left) {
> >               ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
>

