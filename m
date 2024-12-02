Return-Path: <linux-btrfs+bounces-10002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0319E00B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B97E2829DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FA1FCD0D;
	Mon,  2 Dec 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J96BEOwX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D29F9EC;
	Mon,  2 Dec 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139450; cv=none; b=fN/aVT+TjZK97Z00Vna6j6kCEuU26E3b5NoJ5TQYTeNJOBs5tcjQ/mes3qVmp6nM3VsrZ7cJp28N/pIVbyW2UysRcYy3Eg3Dxv2dyeyvOVLeWRaFIKiEyvYSHIkYUQXA+a9KIZonK7aL1wqGneGv3rI/eMNAVD6SnhiN8VSa5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139450; c=relaxed/simple;
	bh=phIVK3XlpAayOnNFNec7a95lT1gPt4cYMnuf/zARFhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdtMbiushl0vUsxBWabJGtXVk4lraB8wWhjzvUlj2vBbmtl2PJbqtuLR7MG/EJFzLS9HwuvQHP3FiwEYpGfCYHzWZs1I+s9vw+uOT1NN8fojQtYXk6dkwK+HUVJlRpF8NzaZu7FbuIcessISogFGmxKYJlX98b8F2RSgBp+j/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J96BEOwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DB9C4CEDD;
	Mon,  2 Dec 2024 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733139449;
	bh=phIVK3XlpAayOnNFNec7a95lT1gPt4cYMnuf/zARFhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J96BEOwX5lRIG2ds9a7VdEVmLQ7bLsdxSOo4TKrQsTj7oVJzJQt85fBM4HFHj5hx0
	 p+92WAMepzjKn4M7dOLJlm5Nrl+L02bb+I+tbpWCiJqz+0POObg9pOulTJpoMX8tNa
	 alE/7AWFd5/mpNUT9cvDZvYI0wPJsDM0V13TWX6LGyVp65zbzWQQVLKEVnRqwP2kEd
	 0Y349txN6BmSpjhbQHsaj67H0MTB8neIuchSyprE2hutO8QFtmXi/YUiIq6OUKr9GA
	 3g0cj3tmsHjuLuN5UDBPo5r17x/8nIyyUFcOezSG6FwFiOXhfZdSQ855594ogQp6x9
	 tkTEk6tDYYxUg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so33342391fa.2;
        Mon, 02 Dec 2024 03:37:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0KQyQtwCU0ZDSHsDRGqBvynHMe5DlFIbIiSjTWpX1gqQcHAeXcdB8UxqZNnwEOl2/c00Ibf7AyJMw329w@vger.kernel.org, AJvYcCVkNgc0qhBkxhLFelGKFajx+M3x2n8TNJRksz1tp6B8YoCENbHD5p/5SOFIyM9n8S8h+8o3qd09NHENQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwytmNxIs8pNLm7wHzLn8gqmD5/HJ5ZSruVC/TOgWTGRpJTKggb
	5CBZueCjtnSDkHT45F9QF+sHcFEKc094Ys1JI6zPio3vm+h4UzypvRHwRCibZxg+uFZCQSguz49
	g0bnwor6tqkP1oWoX40kVY8+pqWU=
X-Google-Smtp-Source: AGHT+IE9fUhcFPdK7qYRTDI/05e3h/KjTbv6pxfLprMiKRX4YWReYvYAp75jDlXaAZ/cFvKM9yWaVt0m7Ua+7BGAbRQ=
X-Received: by 2002:a2e:bccd:0:b0:2fb:4bee:47ec with SMTP id
 38308e7fff4ca-2ffd60db9f8mr126254051fa.33.1733139447808; Mon, 02 Dec 2024
 03:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201112550.107383-1-zhenghaoran154@gmail.com>
 <CAL3q7H4P9O-6jay6cPYLrrX85y1t52QRQ=_feifY_A0D7p_gLQ@mail.gmail.com>
 <CAKa5YKiedRVhJoORSa3t7cENo8sZ_Nxq4bHfiMvbDrh_ccvcTg@mail.gmail.com> <CAKa5YKjmKA8hGJgp_Px1-EGifLY_N9gR13=i54PoDcb=dMjMeA@mail.gmail.com>
In-Reply-To: <CAKa5YKjmKA8hGJgp_Px1-EGifLY_N9gR13=i54PoDcb=dMjMeA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Dec 2024 11:36:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
Message-ID: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix data race in btrfs_drop_extents
To: haoran zheng <zhenghaoran154@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:36=E2=80=AFAM haoran zheng <zhenghaoran154@gmail.c=
om> wrote:
>
> I read the relevant code again and found that modify_tree is also used fo=
r
> judgment at line 331, but the judgment here may lead to the release of th=
e
> path. Will this cause other problems such as unexpected path release?
> 331: if (recow || !modify_tree) {
> 332:     modify_tree =3D -1;
> 333:     btrfs_release_path(path);
> 334:     continue;
> 335: }

This is what I told you before - this is triggered when we have taken
a read lock (modify_tree =3D=3D 0) but it turns out we need a write lock
(in order to drop extent items from the inode's root).
In that case we release the path and reacquire it again with write
locks, that's the meaning of setting modify_tree to -1 and doing the
continue.

Btw, before you do extraordinary claims in a change log such as
"unexpected results" and "disk data being overwritten", make sure you
actually have a good understanding, not just of this
function (which you clearly don't), as well as btrfs' metadata, the
btree data structure and its operations and the write path in general
(which you clearly don't have as well).

Extraordinary claims demand a good explanation.

This time you found a harmless race (with KCSAN), but not long ago
you've sent out another patch that was even more puzzling:

https://lore.kernel.org/linux-btrfs/20241101035133.925251-1-zhenghaoran@bua=
a.edu.cn/

You claimed a race on code that is run sequentially for a data
structure that is not shared amongst threads, so there's no way on
earth a race condition could happen there.
This lack of explanation demonstrated a total lack of understanding of
the btrfs logging code, and even worse the patch didn't even compile -
you didn't even test compilation, let alone exercise the code.

That sort of behaviour made me think you were a bot or one of those
trolls that often show up (like the infamous Nick Krause some years
ago).
Avoid that sort of behaviour please, otherwise no one will take you serious=
ly.

Thanks.

>
> On Mon, Dec 2, 2024 at 11:13=E2=80=AFAM haoran zheng <zhenghaoran154@gmai=
l.com> wrote:
> >
> > Thanks for the explanation. I will fix the description and resubmit the=
 patch.
> >
> > On Mon, Dec 2, 2024 at 1:39=E2=80=AFAM Filipe Manana <fdmanana@kernel.o=
rg> wrote:
> >>
> >> On Sun, Dec 1, 2024 at 11:26=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@=
gmail.com> wrote:
> >> >
> >> > A data race occurs when the function `insert_ordered_extent_file_ext=
ent()`
> >> > and the function `btrfs_inode_safe_disk_i_size_write()` are executed
> >> > concurrently. The function `insert_ordered_extent_file_extent()` is =
not
> >> > locked when reading inode->disk_i_size, causing
> >> > `btrfs_inode_safe_disk_i_size_write()`to cause data competition when
> >> > writing inode->disk_i_size, thus affecting the value of `modify_tree=
`,
> >> > leading to some unexpected results such as disk data being overwritt=
en.
> >>
> >> How can that cause "disk data being overwritten"?
> >> And the results are not unexpected at all.
> >>
> >> The value of modify_tree is irrelevant from a correctness point of vie=
w.
> >> It's used for an optimization to avoid taking write locks on the btree
> >> in case we're doing a write at or beyond eof.
> >>
> >> If we end up taking a write lock when it's not needed, everything's
> >> fine - we just may unnecessarily block concurrent readers that need to
> >> access the same btree path (leaf and parent node).
> >>
> >> If we don't take a write lock and we need it, we will later figure
> >> that out and switch to a write lock.
> >>
> >> > The specific call stack that appears during testing is as follows:
> >> >
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> >  btrfs_drop_extents+0x89a/0xa060 [btrfs]
> >> >  insert_reserved_file_extent+0xb54/0x2960 [btrfs]
> >> >  insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
> >> >  btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
> >> >  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
> >> >  finish_ordered_fn+0x3e/0x50 [btrfs]
> >> >  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
> >> >  process_scheduled_works+0x716/0xf10
> >> >  worker_thread+0xb6a/0x1190
> >> >  kthread+0x292/0x330
> >> >  ret_from_fork+0x4d/0x80
> >> >  ret_from_fork_asm+0x1a/0x30
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> >  btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
> >> >  btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
> >> >  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
> >> >  finish_ordered_fn+0x3e/0x50 [btrfs]
> >> >  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
> >> >  process_scheduled_works+0x716/0xf10
> >> >  worker_thread+0xb6a/0x1190
> >> >  kthread+0x292/0x330
> >> >  ret_from_fork+0x4d/0x80
> >> >  ret_from_fork_asm+0x1a/0x30
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >
> >> > To address this issue, it is recommended to add locks when reading
> >> > inode->disk_i_size and setting the value of modify_tree to prevent
> >> > data inconsistency.
> >>
> >> Can also use data_race() here, as it's a harmless race.
> >>
> >> Also, please use a proper subject like for example:
> >>
> >> btrfs: fix data race when accessing the inode's disk_i_size at
> >> btrfs_drop_extents()
> >>
> >> Also please update the changelog with a proper analysis - saying it's
> >> a harmless race and why.
> >>
> >> Thanks.
> >>
> >> >
> >> > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> >> > ---
> >> >  fs/btrfs/file.c | 2 ++
> >> >  1 file changed, 2 insertions(+)
> >> >
> >> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> >> > index 4fb521d91b06..189708e6e91a 100644
> >> > --- a/fs/btrfs/file.c
> >> > +++ b/fs/btrfs/file.c
> >> > @@ -242,8 +242,10 @@ int btrfs_drop_extents(struct btrfs_trans_handl=
e *trans,
> >> >         if (args->drop_cache)
> >> >                 btrfs_drop_extent_map_range(inode, args->start, args=
->end - 1, false);
> >> >
> >> > +       spin_lock(&inode->lock);
> >> >         if (args->start >=3D inode->disk_i_size && !args->replace_ex=
tent)
> >> >                 modify_tree =3D 0;
> >> > +       spin_unlock(&inode->lock);
> >> >
> >> >         update_refs =3D (btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJ=
ECTID);
> >> >         while (1) {
> >> > --
> >> > 2.34.1
> >> >
> >> >

