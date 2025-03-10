Return-Path: <linux-btrfs+bounces-12139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E1BA594E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13977A5ECC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523D22A4D2;
	Mon, 10 Mar 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5XWHu9L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D322A1F1
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610519; cv=none; b=bryV1LEA08F6jkB2ynqpd+uDKKaQZa/ksIRR+ZDyE/Ycdyq9iqFwBVXYceC8JVoa8o58bkWW/7+qBDUq3+EVT2I7hUQyKIXaiNZ7+2A4ZcMcjyKld9GWvPXziXalyZbM/X/EKB+BIdrez1F9d7aQlY7YMa6CY6fq0vpwjuh9ruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610519; c=relaxed/simple;
	bh=CpI68KfcRbHEkLaBj/GGaQF5D6xhdBM74VT0Mexd1FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzncyDTDERqEaXBcTS0W7FF7M4k/+gKdgMBzz5NM0E/j+hK9JcuW2B/AYCCiLHXd/YsFipe6m9qDcde95IwqH1NtUpjYykGeP+Vxx1WRqHnAsGUDXcUct7l0NW3bFWMp1U0KjgUEdmuNorPTkgFqwZsFMpxbAILx2i4sF9ae6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5XWHu9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5146FC4CEEA
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741610519;
	bh=CpI68KfcRbHEkLaBj/GGaQF5D6xhdBM74VT0Mexd1FY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u5XWHu9LhXYneRWNPFgNf6MZCdGBn1sKNzPARs1x+vqo4OtQgKi5zs5PKQOsNXMqS
	 uDaT1BrrlTKVTHtizAPHtTWIC3R8V6T0/McczkoOyyca4h7VkXgvMQ81q43d+w+jhy
	 aXV/RStkQcS7zW7K/rCFykb09YSsOBKOuT5bGKeYDkMHGWOp7iF9MQpG2/68daljh6
	 J4MdBW8FG/KWSkEJ3iWQNVp4HLYrPVAcTrKDoeFlc/TkpfO6AoOs6MvDXJ9DbGKoIz
	 0kff17HwYlaEW+tmC2vOk7X2cw4VZD2SDkXGN/omUtAxtiav6o+0O3cTMdPJRWHLFV
	 pdoL9KoQoypww==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so9566221a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:41:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6alcRu+60GdQfro8mEuPnpTIy8C+qzUzcmz0pV6SYM6TMippF
	gQ7MgV4aX/AANW5qGjCxWpsA6TIX9tj//pm8LJJQfa93N0vCeXmRAG095rwkCUQXDgMxjQ0rVHW
	wzVjlWoxCIQlCrHuH1bInIJmWvT0=
X-Google-Smtp-Source: AGHT+IFpl4PfjVcesN7PwRdCWCyeMipUtwM+5s94IFLVrdomWvCRdeF2dMOZfBFvPWyOhNr4SU76jUz8wOMRJlnCm2Y=
X-Received: by 2002:a17:907:868e:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-ac26ca3301bmr1135735566b.8.1741610517880; Mon, 10 Mar 2025
 05:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
 <CAL3q7H4ErZWCa2qC1UgXVCfahA1Qx=WdeEGJ8E3COCLuH-n=5A@mail.gmail.com> <20250307213202.GA3554015@zen.localdomain>
In-Reply-To: <20250307213202.GA3554015@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Mar 2025 12:41:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7k3eTUB3DtUSHAVNxs1kyXuoaT4GUO5MaDUWOO=th-+A@mail.gmail.com>
X-Gm-Features: AQ5f1JrHL5s4xyRXPJW0J_u-I61_YJdwmyh8KV-sd64KOvkDEBERG9qYhgkxsgc
Message-ID: <CAL3q7H7k3eTUB3DtUSHAVNxs1kyXuoaT4GUO5MaDUWOO=th-+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: fix bg refcount race in btrfs_create_pending_block_groups
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:31=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Mar 07, 2025 at 02:13:15PM +0000, Filipe Manana wrote:
> > On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > To avoid a race where mark_bg_unused spuriously "moved" the block_gro=
up
> > > from one bg_list attachment to another without taking a ref, we mark =
a
> > > new block group with the bit BLOCK_GROUP_FLAG_NEW.
> > >
> > > However, this fix is not quite complete. Since it does not use the
> > > unused_bg_lock, it is possible for the following race to occur:
> > >
> > > create_pending_block_groups                     mark_bg_unused
> >
> > mark_bg_unused -> btrfs_mark_bg_unused
> >
> > >                                            if list_empty // false
> > >         list_del_init
> > >         clear_bit
> > >                                            else if (test_bit) // true
> > >                                                 list_move_tail
> >
> > This should mention how that sequence is possible, i.e. on a higher lev=
el.
> >
> > For example the task that created the block group ended up not
> > allocating extents from it,
> > and other tasks allocated extents from it and deallocated so that the
> > block group became empty
> > and was added to the unused list before the task that created it
> > finished btrfs_create_pending_block_groups().
> >
> > Or was it some other scenario?
>
> To be honest, since the detection of the error is so non-local to the
> time of the error with these refcounting issues, I don't have any
> proof that exactly this is happening. I just have a bunch of hosts with
> wrong refcounts detected after a relocation and started squinting at
> places it could have gone wrong.
>
> Your original patch and the very existence of the BLOCK_GROUP_FLAG_NEW
> flag suggest to me that the two running concurrently is expected.

Well, even before that flag, there were problems already, but not so
easy to analyze because list_del_init(), list_empty() and
list_add_tail() are not atomic operations.

>
> Would you like me to attempt to produce this condition on the current
> kernel? Or I can duplicate/link to some of the reasoning from your first
> fix here so that this commit message tells a better self-contained story?

You don't need to go trigger it and trace exactly how it happens, but
mentioning a hypothetical scenario is enough.

Even before finishing the creation of a new block group, other tasks
can allocate and deallocate extents from it, and on deallocation when
it becomes empty we may add the new block group to the unused list.
This is possible because during the lifetime of the transaction, we
often flush (trigger writeback) dirty extent buffers because we
reached the BTRFS_DIRTY_METADATA_THRESH limit or we're under memory
pressure, so btree modifications on the extent buffers will be forced
to COW, freeing the extent buffers previously allocated in the new
block group and allocating new ones in some other block group, so that
the new one becomes empty and is added to the unused list.

With that:
Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Thanks,
> Boris
>
> >
> > Thanks.
> >
> > >
> > > And we get into the exact same broken ref count situation.
> > > Those look something like:
> > > [ 1272.943113] ------------[ cut here ]------------
> > > [ 1272.943527] refcount_t: underflow; use-after-free.
> > > [ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_=
warn_saturate+0xba/0x110
> > > [ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress =
raid6_pq null_blk [last unloaded: btrfs]
> > > [ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loade=
d Tainted: G        W          6.14.0-rc5+ #108
> > > [ 1272.946368] Tainted: [W]=3DWARN
> > > [ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS Arch Linux 1.16.3-1-1 04/01/2014
> > > [ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
> > > [ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
> > > [ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d =
3f 4a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 =
ff <0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7
> > > [ 1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
> > > [ 1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 00000=
00000000000
> > > [ 1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000=
000ffffdfff
> > > [ 1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: fffff=
fff90526268
> > > [ 1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa=
14b00dc28c0
> > > [ 1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 00000=
1285dcd12c0
> > > [ 1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) =
knlGS:0000000000000000
> > > [ 1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 00000=
000000006f0
> > > [ 1272.954474] Call Trace:
> > > [ 1272.954655]  <TASK>
> > > [ 1272.954812]  ? refcount_warn_saturate+0xba/0x110
> > > [ 1272.955173]  ? __warn.cold+0x93/0xd7
> > > [ 1272.955487]  ? refcount_warn_saturate+0xba/0x110
> > > [ 1272.955816]  ? report_bug+0xe7/0x120
> > > [ 1272.956103]  ? handle_bug+0x53/0x90
> > > [ 1272.956424]  ? exc_invalid_op+0x13/0x60
> > > [ 1272.956700]  ? asm_exc_invalid_op+0x16/0x20
> > > [ 1272.957011]  ? refcount_warn_saturate+0xba/0x110
> > > [ 1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
> > > [ 1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
> > > [ 1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
> > > [ 1272.958729]  process_one_work+0x130/0x290
> > > [ 1272.959026]  worker_thread+0x2ea/0x420
> > > [ 1272.959335]  ? __pfx_worker_thread+0x10/0x10
> > > [ 1272.959644]  kthread+0xd7/0x1c0
> > > [ 1272.959872]  ? __pfx_kthread+0x10/0x10
> > > [ 1272.960172]  ret_from_fork+0x30/0x50
> > > [ 1272.960474]  ? __pfx_kthread+0x10/0x10
> > > [ 1272.960745]  ret_from_fork_asm+0x1a/0x30
> > > [ 1272.961035]  </TASK>
> > > [ 1272.961238] ---[ end trace 0000000000000000 ]---
> > >
> > > Though we have seen them in the async discard workfn as well. It is
> > > most likely to happen after a relocation finishes which cancels disca=
rd,
> > > tears down the block group, etc.
> > >
> > > Fix this fully by taking the lock around the list_del_init + clear_bi=
t
> > > so that the two are done atomically.
> > >
> > > Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group th=
at became unused")
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/block-group.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 64f0268dcf02..2db1497b58d9 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -2797,8 +2797,11 @@ void btrfs_create_pending_block_groups(struct =
btrfs_trans_handle *trans)
> > >                 /* Already aborted the transaction if it failed. */
> > >  next:
> > >                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> > > +
> > > +               spin_lock(&fs_info->unused_bgs_lock);
> > >                 list_del_init(&block_group->bg_list);
> > >                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime=
_flags);
> > > +               spin_unlock(&fs_info->unused_bgs_lock);
> > >
> > >                 /*
> > >                  * If the block group is still unused, add it to the =
list of
> > > --
> > > 2.48.1
> > >
> > >

