Return-Path: <linux-btrfs+bounces-17322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA2BB1DED
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4033B7E43
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B231195D;
	Wed,  1 Oct 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu1qTaSn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8943269CE5
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354862; cv=none; b=ivXJNl2BAlDXGrNt6yrjpFCv1qJDrz+1huA0FtEirN0Qe47mZYVRaCGoPUi+J6TPWYo2iWLhp2P+fKpKgOQ7+aCYyUAZMN2nl4wsl18b0L+pvVeC8iRHym4mNvUqyn4qKbm9H51NIh2id3uGCvIuXcfr6pjHbKyuxui3XSVFX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354862; c=relaxed/simple;
	bh=4tNrwefdUObfWfGHwL/FUT0JhvsU6Ppdcoz2VevIO5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+os8DGBJ46rR047LDV+e7wFiGfzA/4Uny1cAqWgaVbi/3VCPz42u3tn1o/7T2+KxvnbR676j+50JFddESs2BaqM25tw7r5oHyT0PQdc6M1arkCSphHTMef1/RLAZpleg3Ssp96yOl99m7X/SMTQw1X85So4OWUVE2UqJwRyoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu1qTaSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DF1C4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759354861;
	bh=4tNrwefdUObfWfGHwL/FUT0JhvsU6Ppdcoz2VevIO5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qu1qTaSn4sphi980dUWY8413A0jCf1CmFVkAOwymLZQN6LKxcICvyMTMVWRr+RTdY
	 NMbBxMedo7kXwF6W1r6w4VxLptK+FD+k3AW7063Q1z95/FZ+VxnNIpoE6M3+Tug5of
	 2q2voawD3X2WJmi49RRnmLJ+/4UcUjYBu5RSWSVWsatzyLAr3kRkvY5rANE0sxOkfK
	 PIEGr/P3YF9Ah4XO9IRtfFCRIb/Plo8V4r6Oxz9jZgtLfW8KlKF6r2zjvMTMKcgUwJ
	 RgRsCTAO8gdcG4umQOfYIa5UmJeXnqd2GO8Bc0emfyBw2ieTNffKl61qQcykdfRrv6
	 dOcJsllUpA0bA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d80891c6cso248347566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 14:41:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHrykd6e5MaP2iSJftNOULLGQmhn14r/goQyu5AvYSXu2suifM
	vglZ35JL320+vNQuphqHb8Kz4ijNcVoSN8GLDggnNZp4+ZE/ilX8AwRV3BEcTJ7kSHlYDJ1yyPo
	dhEFvaF3DguHpTnxnQMYq5RVHPhfjC9E=
X-Google-Smtp-Source: AGHT+IGfepBFNjhuOZbzc9+Og5Qw1NKD6oBQqfn+iW1v7Fsv21F33Ew3qD7QZPYdzqmfVCE0uxRaXJx21y1jBbMIu9w=
X-Received: by 2002:a17:907:968d:b0:b3f:f6d:1d9e with SMTP id
 a640c23a62f3a-b48595942bamr148693766b.6.1759354859680; Wed, 01 Oct 2025
 14:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9e4f03c7e13d29156da0b2cbe7c55840e526fa0.1759318478.git.fdmanana@suse.com>
 <1c64a0d5-d25b-48a6-9c5d-d3f562567599@suse.com>
In-Reply-To: <1c64a0d5-d25b-48a6-9c5d-d3f562567599@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 1 Oct 2025 22:40:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4=Z+KXriOdGbiZPR40KMS+tjR=kzoWkEB0PYG4MA0Dnw@mail.gmail.com>
X-Gm-Features: AS18NWB1vKY4Uzj7SaIYr7Q27_9XqVRd_KhXEYLj4TFO-O7rEkAD_fuVR0pDXb4
Message-ID: <CAL3q7H4=Z+KXriOdGbiZPR40KMS+tjR=kzoWkEB0PYG4MA0Dnw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not assert we found block group item when
 creating free space tree
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 10:30=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/1 21:07, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently, when building a free space tree at populate_free_space_tree(=
),
> > if we are not using the block group tree feature, we always expect to f=
ind
> > block group items (either extent items or a block group item with key t=
ype
> > BTRFS_BLOCK_GROUP_ITEM_KEY) when we search the extent tree with
> > btrfs_search_slot_for_read(), so we assert that we found an item. Howev=
er
> > this expectation is wrong since we can have a new block group created i=
n
> > the current transaction which is still empty and for which we still hav=
e
> > not added the block group's item to the extent tree, in which case we d=
o
> > not have any items in the extent tree associated to the block group.
> >
> > The insertion of a new block group's block group item in the extent tre=
e
> > happens at btrfs_create_pending_block_groups() when it calls the helper
> > insert_block_group_item(). This typically is done when a transaction
> > handle is released, committed or when running delayed refs (either as
> > part of a transaction commit or when serving tickets for space reservat=
ion
> > if we are low on free space).
> >
> > So remove the assertion at populate_free_space_tree() even when the blo=
ck
> > group tree feature is not enabled and update the comment to mention thi=
s
> > case.
> >
> > Syzbot reported this with the following stack trace:
> >
> >    BTRFS info (device loop3 state M): rebuilding free space tree
> >    assertion failed: ret =3D=3D 0 :: 0, in fs/btrfs/free-space-tree.c:1=
115
> >    ------------[ cut here ]------------
> >    kernel BUG at fs/btrfs/free-space-tree.c:1115!
> >    Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> >    CPU: 1 UID: 0 PID: 6352 Comm: syz.3.25 Not tainted syzkaller #0 PREE=
MPT(full)
> >    Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 08/18/2025
> >    RIP: 0010:populate_free_space_tree+0x700/0x710 fs/btrfs/free-space-t=
ree.c:1115
> >    Code: ff ff e8 d3 (...)
> >    RSP: 0018:ffffc9000430f780 EFLAGS: 00010246
> >    RAX: 0000000000000043 RBX: ffff88805b709630 RCX: fea61d0e2e79d000
> >    RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> >    RBP: ffffc9000430f8b0 R08: ffffc9000430f4a7 R09: 1ffff92000861e94
> >    R10: dffffc0000000000 R11: fffff52000861e95 R12: 0000000000000001
> >    R13: 1ffff92000861f00 R14: dffffc0000000000 R15: 0000000000000000
> >    FS:  00007f424d9fe6c0(0000) GS:ffff888125afc000(0000) knlGS:00000000=
00000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: 00007fd78ad212c0 CR3: 0000000076d68000 CR4: 00000000003526f0
> >    Call Trace:
> >     <TASK>
> >     btrfs_rebuild_free_space_tree+0x1ba/0x6d0 fs/btrfs/free-space-tree.=
c:1364
> >     btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3062
> >     btrfs_remount_rw fs/btrfs/super.c:1334 [inline]
> >     btrfs_reconfigure+0xaed/0x2160 fs/btrfs/super.c:1559
> >     reconfigure_super+0x227/0x890 fs/super.c:1076
> >     do_remount fs/namespace.c:3279 [inline]
> >     path_mount+0xd1a/0xfe0 fs/namespace.c:4027
> >     do_mount fs/namespace.c:4048 [inline]
> >     __do_sys_mount fs/namespace.c:4236 [inline]
> >     __se_sys_mount+0x313/0x410 fs/namespace.c:4213
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >     RIP: 0033:0x7f424e39066a
> >    Code: d8 64 89 02 (...)
> >    RSP: 002b:00007f424d9fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
a5
> >    RAX: ffffffffffffffda RBX: 00007f424d9fdef0 RCX: 00007f424e39066a
> >    RDX: 0000200000000180 RSI: 0000200000000380 RDI: 0000000000000000
> >    RBP: 0000200000000180 R08: 00007f424d9fdef0 R09: 0000000000000020
> >    R10: 0000000000000020 R11: 0000000000000246 R12: 0000200000000380
> >    R13: 00007f424d9fdeb0 R14: 0000000000000000 R15: 00002000000002c0
> >     </TASK>
> >    Modules linked in:
> >    ---[ end trace 0000000000000000 ]---
> >
> > Reported-by: syzbot+884dc4621377ba579a6f@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-btrfs/68dc3dab.a00a0220.102ee.004e.=
GAE@google.com/
> > Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")
>
> Since the ASSERT() is only introduced in 1961d20f6fa8: btrfs: fix
> assertion when building free space tree, I think the fixed tag should
> also use that commit.
> > Cc: <stable@vger.kernel.org> # 6.1.x: 1961d20f6fa8: btrfs: fix assertio=
n when building free space tree
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/free-space-tree.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > index b44e8a736cea..26e23c5b9d0c 100644
> > --- a/fs/btrfs/free-space-tree.c
> > +++ b/fs/btrfs/free-space-tree.c
> > @@ -1100,14 +1100,15 @@ static int populate_free_space_tree(struct btrf=
s_trans_handle *trans,
> >        * If ret is 1 (no key found), it means this is an empty block gr=
oup,
> >        * without any extents allocated from it and there's no block gro=
up
> >        * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tr=
ee
> > -      * because we are using the block group tree feature, so block gr=
oup
> > -      * items are stored in the block group tree. It also means there =
are no
> > -      * extents allocated for block groups with a start offset beyond =
this
> > -      * block group's end offset (this is the last, highest, block gro=
up).
> > +      * because we are using the block group tree feature (so block gr=
oup
> > +      * items are stored in the in the block group tree) or this is a =
new
> > +      * block group created in the current transaction and its block g=
roup
> > +      * item was not yet inserted in the extent tree (that happens in
> > +      * btrfs_create_pending_block_groups() -> insert_block_group_item=
()).
> > +      * It also means there are no extents allocated for block groups =
with a
> > +      * start offset beyond this block group's end offset (this is the=
 last,
> > +      * highest, block group).
>
> I'm also wondering if the last 3 lines are still true.

They are.

>
> We can have multiple pending block groups, thus the assumption of "no
> extents allocated for block groups with a start offset beyond this bg's
> end" doesn't sound correct to me.

If there are other pending block groups (with a higher start offset)
without extents allocated, 1 is returned.
If they have allocated extents, 0 is returned and then we enter into
the loop and we just leave since they are for another block group
(key.objectid >=3D end).

>
> >        */
> > -     if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
> > -             ASSERT(ret =3D=3D 0);
> > -
> >       start =3D block_group->start;
> >       end =3D block_group->start + block_group->length;
> >       while (ret =3D=3D 0) {
>
> And we just skip adding free space items for pending block groups, is
> this the expected behavior?

Yes. If there are no extents found for a block group, we don't enter
the loop and following the loop we add a free space entry for the
entire range of the block group.

>
> Thanks,
> Qu
>

