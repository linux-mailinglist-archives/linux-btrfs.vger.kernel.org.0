Return-Path: <linux-btrfs+bounces-9992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88249DF6A5
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 18:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57341B2079A
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE61D7E31;
	Sun,  1 Dec 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPLPLtGx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177E1F94D;
	Sun,  1 Dec 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733074753; cv=none; b=Cj+YHvyHsC8IB/DtiPqVRvpMs3b2c/0LDzb4JHZQAQzTyifxtfKy1/GhK/NWE9rDodzKJueJAjmnvX0xd+n2Mbznm++cHsqn8Ug0karraCN7A100xR9u7UX/+KCu852spUJcSUHAWXOjdrK1uaqa7F8UuJBxo6uyMUyXD2f1jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733074753; c=relaxed/simple;
	bh=iZrQ+PW/aXC6+qenIK7Cj0znypPYiGYtdnrpzgUGfqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nk+LahBCGtIPTZ/P5DJ8O29NruAK5pxBKz6A0mo8QaPDVZZw9yURsSgP3CNpW6RZKt8MRT+xlw2ALOkGt79BfB2OofeDKdgFcdc9WcIQnu7DlfdgzXjm7Mbo9d/QRNSYPgan9+BgPfdAYdOpT0vElyKk+2QmSZGl43j8DZZ5mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPLPLtGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE4EC4CED2;
	Sun,  1 Dec 2024 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733074752;
	bh=iZrQ+PW/aXC6+qenIK7Cj0znypPYiGYtdnrpzgUGfqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uPLPLtGxOGzr6k5Vhm7x4/+S3DEqVjFl4BHb1BnHtUZf9OOSbHCMIB5E0GU9lI1q4
	 Jxc7aXKe8QIaHn1xGm00DSQ1uTgTJ3HxYXeKk7RpwjnVpdlezu+OKXBtojtj0x2hxx
	 wqxlQRWOFicDz4lBgKZpsn+HEKKkooeAKkmj73ryjYhygkhoY28UDi5CxBqGwKjMmx
	 j2/LFowZDzrurbM9SIU1ixiur5B0/mMkgxbST66t7nIr/mLpmDSDVP+ZciC0kQSUpT
	 ZhrIgfL2h0/7h5FeC3mSwP/nsB/V3Uy/wyook0brQ2WhlXikRbrCjJJYfG+MtZrxsz
	 y+NDXsVgTqRmQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so4076998a12.2;
        Sun, 01 Dec 2024 09:39:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOcpTMZqxTnH0FKXQNzEF3ghylOZLtnRBe+VRjpEYAcitPAkohjX/PWHib9XbWn/JJz4IbRY2EKRRVpDhb@vger.kernel.org, AJvYcCXPgejcYohsmN6Q/TkWvGni50iEOP8635udqkx9swggbqmZv+BAkeb9LaBTbACxlvUJoSWlybtHNobI3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwguztDDBQTIbqucqWW2ldth+9GbJEqaOPKrIZYFNKRwwJZZFw/
	o05nXd4hnM7ni9u6Sr2Z/7tj2lJkEt3JR3WPgH6UYnl3/aBY6aO7rfG1eSWaZvQGcASWwy3vFvZ
	wKojkvsPYom6u9sSf8ZhGxbkIwtg=
X-Google-Smtp-Source: AGHT+IFLeaiTo/1WhCZIw191BzL2IzSWg3sRObmO7/YIA19fQmQjtycwdWjFt3tVQHYrPb336rlZrwbFZ1b7Vefm3To=
X-Received: by 2002:a17:906:3198:b0:aa5:d06:4578 with SMTP id
 a640c23a62f3a-aa580f55bb8mr1827749866b.28.1733074751007; Sun, 01 Dec 2024
 09:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201112550.107383-1-zhenghaoran154@gmail.com>
In-Reply-To: <20241201112550.107383-1-zhenghaoran154@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 1 Dec 2024 17:38:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4P9O-6jay6cPYLrrX85y1t52QRQ=_feifY_A0D7p_gLQ@mail.gmail.com>
Message-ID: <CAL3q7H4P9O-6jay6cPYLrrX85y1t52QRQ=_feifY_A0D7p_gLQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix data race in btrfs_drop_extents
To: Hao-ran Zheng <zhenghaoran154@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 11:26=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gmail=
.com> wrote:
>
> A data race occurs when the function `insert_ordered_extent_file_extent()=
`
> and the function `btrfs_inode_safe_disk_i_size_write()` are executed
> concurrently. The function `insert_ordered_extent_file_extent()` is not
> locked when reading inode->disk_i_size, causing
> `btrfs_inode_safe_disk_i_size_write()`to cause data competition when
> writing inode->disk_i_size, thus affecting the value of `modify_tree`,
> leading to some unexpected results such as disk data being overwritten.

How can that cause "disk data being overwritten"?
And the results are not unexpected at all.

The value of modify_tree is irrelevant from a correctness point of view.
It's used for an optimization to avoid taking write locks on the btree
in case we're doing a write at or beyond eof.

If we end up taking a write lock when it's not needed, everything's
fine - we just may unnecessarily block concurrent readers that need to
access the same btree path (leaf and parent node).

If we don't take a write lock and we need it, we will later figure
that out and switch to a write lock.

> The specific call stack that appears during testing is as follows:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  btrfs_drop_extents+0x89a/0xa060 [btrfs]
>  insert_reserved_file_extent+0xb54/0x2960 [btrfs]
>  insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
>  btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
>  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
>  finish_ordered_fn+0x3e/0x50 [btrfs]
>  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
>  process_scheduled_works+0x716/0xf10
>  worker_thread+0xb6a/0x1190
>  kthread+0x292/0x330
>  ret_from_fork+0x4d/0x80
>  ret_from_fork_asm+0x1a/0x30
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
>  btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
>  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
>  finish_ordered_fn+0x3e/0x50 [btrfs]
>  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
>  process_scheduled_works+0x716/0xf10
>  worker_thread+0xb6a/0x1190
>  kthread+0x292/0x330
>  ret_from_fork+0x4d/0x80
>  ret_from_fork_asm+0x1a/0x30
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> To address this issue, it is recommended to add locks when reading
> inode->disk_i_size and setting the value of modify_tree to prevent
> data inconsistency.

Can also use data_race() here, as it's a harmless race.

Also, please use a proper subject like for example:

btrfs: fix data race when accessing the inode's disk_i_size at
btrfs_drop_extents()

Also please update the changelog with a proper analysis - saying it's
a harmless race and why.

Thanks.

>
> Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> ---
>  fs/btrfs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 4fb521d91b06..189708e6e91a 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -242,8 +242,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>         if (args->drop_cache)
>                 btrfs_drop_extent_map_range(inode, args->start, args->end=
 - 1, false);
>
> +       spin_lock(&inode->lock);
>         if (args->start >=3D inode->disk_i_size && !args->replace_extent)
>                 modify_tree =3D 0;
> +       spin_unlock(&inode->lock);
>
>         update_refs =3D (btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJECTID=
);
>         while (1) {
> --
> 2.34.1
>
>

