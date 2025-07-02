Return-Path: <linux-btrfs+bounces-15197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD9AF15BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 14:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA921C2424F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3E272819;
	Wed,  2 Jul 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fotegxUF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326624677B;
	Wed,  2 Jul 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459664; cv=none; b=DXJDaPkZPMfbrjUQA1cf25dyZ9ZdftSB1wVziiKR0AHY/G5NeBHCI0fTr+BbsGvcZEqZe+ybM70KCUL/j6/uGfi7FKIqpWUCYyGkWBJpuSDjLYvyDKCc7xoYF50y93wjNgiQ9jXlYwg7w3nFz4JR41oHhcLw3myeS9barxquMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459664; c=relaxed/simple;
	bh=gdoP7odKWnop6WBe7JWeC91GPRBufTEUqAv5Bv3myOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gg8fhciFecRkMSQf+C/Ur7MaoOWHjnduups900EIz1inZNHcJ/BwCFgB7G3hXWnHXiFgVgU9VkKNTR6ULrRTFVqMTr6tg1f3UhZK2kXA09MtDZuNf85be3qycgPA5cwYFfOVEOTE8mMAezRXByM5HCtK4KjMRJmeNFbP9yxKNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fotegxUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C349FC4CEF0;
	Wed,  2 Jul 2025 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751459663;
	bh=gdoP7odKWnop6WBe7JWeC91GPRBufTEUqAv5Bv3myOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fotegxUF3W3K53tT96bB1pwsgBAZ4rfxAlKNTc0eL7PrN77Mwu+vy7tXdp31Ci6Rq
	 N2VDCRPWJGH6oT2D9ugEALYlXH+LP8gppqNVPI9nSVzWnbwczwp3i/7IdTMI9U24fK
	 j2cFgfN72t73zwaafYnFPcsfYU9OdAaPiDAgznBsG3rKjSQBdzoFQ/rMgAiPUD+aWV
	 S+B7SJ6uW3JnwML4SKxjuRN+vzzQskdKAJv24SKy9Io7HXWQcWzfxSFrupJbTkcJeL
	 IwEQQ7zMRsMsL32q+7x9MhEVekO+oafh8/bSGUduORwnCemvxNMDY3to9/BRBMPhg9
	 YsY9/XLVf8ATw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso8457570a12.2;
        Wed, 02 Jul 2025 05:34:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp3OOh29D2KvLFgQIRIpnGzBHFv6OQQGd1BZViuENQ0879Q1YZRFzk2jmWC1d4ffov7hQo9Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWV6gw5QAV+KJHo2m7Lx7ueozG6u3dPO6MnZg518p1Gl7sNTrm
	FQCu9ov7CnsJDPJiiQGL9odq/Du8Oq6wTo1vErVxfMdFbweP94SfO3CFCQiHx6VdRrqOad38GS7
	bkL+xHc+Ly4IVErdVTlOym672/KSPy3o=
X-Google-Smtp-Source: AGHT+IFll79N0iCfbBQojKvtNJaVx26oboo5/l4Z5kjm5UhXjtRWvln3asFe7WX9qSUfK03boNbfz4SEk9b/ww+Nz7E=
X-Received: by 2002:a17:907:1ca3:b0:ae0:54b9:dc17 with SMTP id
 a640c23a62f3a-ae3c2a90a00mr273856466b.11.1751459662352; Wed, 02 Jul 2025
 05:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78f495fb6fd5af1f67ef03ca6279342a1b806966.1751434663.git.wqu@suse.com>
In-Reply-To: <78f495fb6fd5af1f67ef03ca6279342a1b806966.1751434663.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 2 Jul 2025 13:33:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Dgo=XsMqG=VzOC5Sv61ioPpkArhkgpv8ak8JG18LYuQ@mail.gmail.com>
X-Gm-Features: Ac12FXyFm8f1Aal-oPlUEnS4YZ4bdPfxvbhixYPhHbSVdC4pewZ5xJmPEIubGes
Message-ID: <CAL3q7H7Dgo=XsMqG=VzOC5Sv61ioPpkArhkgpv8ak8JG18LYuQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: populate otime when logging an inode item
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:38=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [TEST FAILURE WITH EXPERIMENTAL FEATURES]
> When running test case generic/508, the test case will fail with the new
> btrfs shutdown support:
>
> generic/508       - output mismatch (see /home/adam/xfstests/results//gen=
eric/508.out.bad)
>     --- tests/generic/508.out   2022-05-11 11:25:30.806666664 +0930
>     +++ /home/adam/xfstests/results//generic/508.out.bad        2025-07-0=
2 14:53:22.401824212 +0930
>     @@ -1,2 +1,6 @@
>      QA output created by 508
>      Silence is golden
>     +Before:
>     +After : stat.btime =3D Thu Jan  1 09:30:00 1970
>     +Before:
>     +After : stat.btime =3D Wed Jul  2 14:53:22 2025
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/508.out /home/adam/xf=
stests/results//generic/508.out.bad'  to see the entire diff)
> Ran: generic/508
> Failures: generic/508
> Failed 1 of 1 tests
>
> Please note that the test case requires shutdown support, thus the test
> case will be skipped using the current upstream kernel, as it doesn't
> have shutdown ioctl support.
>
> [CAUSE]
> The direct cause the 0 time stamp in the log tree:
>
> leaf 30507008 items 2 free space 16057 generation 9 owner TREE_LOG
> leaf 30507008 flags 0x1(WRITTEN) backref revision 1
> checksum stored e522548d
> checksum calced e522548d
> fs uuid 57d45451-481e-43e4-aa93-289ad707a3a0
> chunk uuid d52bd3fd-5163-4337-98a7-7986993ad398
>         item 0 key (257 INODE_ITEM 0) itemoff 16123 itemsize 160
>                 generation 9 transid 9 size 0 nbytes 0
>                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>                 sequence 1 flags 0x0(none)
>                 atime 1751432947.492000000 (2025-07-02 14:39:07)
>                 ctime 1751432947.492000000 (2025-07-02 14:39:07)
>                 mtime 1751432947.492000000 (2025-07-02 14:39:07)
>                 otime 0.0 (1970-01-01 09:30:00) <<<
>
> But the old fs tree has all the correct time stamp:
>
> btrfs-progs v6.12
> fs tree key (FS_TREE ROOT_ITEM 0)
> leaf 30425088 items 2 free space 16061 generation 5 owner FS_TREE
> leaf 30425088 flags 0x1(WRITTEN) backref revision 1
> checksum stored 48f6c57e
> checksum calced 48f6c57e
> fs uuid 57d45451-481e-43e4-aa93-289ad707a3a0
> chunk uuid d52bd3fd-5163-4337-98a7-7986993ad398
>         item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>                 generation 3 transid 0 size 0 nbytes 16384
>                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>                 sequence 0 flags 0x0(none)
>                 atime 1751432947.0 (2025-07-02 14:39:07)
>                 ctime 1751432947.0 (2025-07-02 14:39:07)
>                 mtime 1751432947.0 (2025-07-02 14:39:07)
>                 otime 1751432947.0 (2025-07-02 14:39:07) <<<
>
> The root cause is that fill_inode_item() in tree-log.c is only
> populating a/c/m time, not the otime (or btime in statx output).
>
> Part of the reason is that, the vfs inode only has a/c/m time, no native
> btime support yet.
>
> [FIX]
> Thankfully btrfs has its otime stored in btrfs_inode::i_otime_sec and
> btrfs_inode::i_otime_nsec.
>
> So what we really need is just fill the otime time stamp in
> fill_inode_item() of tree-log.c
>
> There is another fill_inode_item() in inode.c, which is doing the proper
> otime population.
>
> CC: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Fixes: 94edf4ae43a5 ("Btrfs: don't bother committing delayed inode
updates when fsyncing")

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thans.

> ---
>  fs/btrfs/tree-log.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 7e52d8f92e5b..5bdd89c44193 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4233,6 +4233,9 @@ static void fill_inode_item(struct btrfs_trans_hand=
le *trans,
>         btrfs_set_timespec_sec(leaf, &item->ctime, inode_get_ctime_sec(in=
ode));
>         btrfs_set_timespec_nsec(leaf, &item->ctime, inode_get_ctime_nsec(=
inode));
>
> +       btrfs_set_timespec_sec(leaf, &item->otime, BTRFS_I(inode)->i_otim=
e_sec);
> +       btrfs_set_timespec_nsec(leaf, &item->otime, BTRFS_I(inode)->i_oti=
me_nsec);
> +
>         /*
>          * We do not need to set the nbytes field, in fact during a fast =
fsync
>          * its value may not even be correct, since a fast fsync does not=
 wait
> --
> 2.50.0
>
>

