Return-Path: <linux-btrfs+bounces-10033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26649E1C2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 13:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3A616666B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD701E5733;
	Tue,  3 Dec 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfID4RVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD61E5721;
	Tue,  3 Dec 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228972; cv=none; b=kM81GbWtNu+UtMgagwiVe+FofZSSB7dSOXXC3F0R2/FeIUujeVYgQlJPBTVkhb9SCIrUzwuTgiG9mC5PjGrGS3aVZCEBBosc1IiqjJ3IrRDS2cLw4um0rOdAvMhf62aQD1AeChTXLYa8g5cL2DDH1093HbjRFhF7IiNeQwXlAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228972; c=relaxed/simple;
	bh=xaniAyyHBtuk84nS9xeOmnF1qLlks52yPULsv2NO2cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1wIKx4EPUFmtMnrpg0di7dZcAi3UmBga9tO7hJ/b2is15YYTsBMlfB4lWYFoEAxmtyQ7FG6Ynz5IUEY4KM1zyUuk0NM2BaGEEtHo+Ygx4w5c8u3TvCnBdywqYSZfEkl0re05owUiP46dvlE/4/DH/+uScS8/2OFonWNSAjXH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfID4RVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F689C4CEDA;
	Tue,  3 Dec 2024 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733228972;
	bh=xaniAyyHBtuk84nS9xeOmnF1qLlks52yPULsv2NO2cU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tfID4RVdLNMxRkVd3kjhZWsTQv81Zrxzba4e4MBuhEx9R8ddbyInErc/AM1oPHW6S
	 WJSTiok9cd2/f1tLNX6fVhKUtwBrgRdburJc52SYNMkdQd69icfb1I6jC5IbVUAF+3
	 7ANXNaw1Z7bELaz7xWE4UWnNeF0TUB0xc7kzbhYdqoBzkpPTHDOOOIiixNToUDWfSw
	 gmoIva+46aylEATlatDCQWfo9rYuxU2idBk7Znap/3ZELlrekh/NhDPK0bbuQEzrpC
	 fBY/4lHDogvVh9VZgDhsdnutC7otx3CRCyN+kWYaLYJooubBZbLWIiChfi5JnbaRY5
	 cuCwFZ87/TP4w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa55da18f89so824014266b.0;
        Tue, 03 Dec 2024 04:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVphnVbo0u7t664OiyDJ6a2dwEoujhphTMlO+eteSwTLM59kbGrVU4Fv1JcZkD5BZnVDltTLRS5//9sS0sH@vger.kernel.org, AJvYcCW0urfUzNgGjOj0MWVskE47Lo+JqSRsUpvA1aNyXGbyHgSH8qQrvh4+uKMB7x6FE1SSYlix+8SkmgqR8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgA5vbECkmbMy7WCc7l1SFnUjh3zkgnml0vAGeJyT4d5WjO5wX
	WoV2IxlV2Gkd7UoltjjY9ozciUCpELUe4+07/Ce9ql0qlJS6u6wV5iEYrcjbZOHY8I68hkq7mTm
	E70kWL/SutjKvjWcHLYhYlf/3vvI=
X-Google-Smtp-Source: AGHT+IEb/6P1sWsBtg3cHoU4F7ZMyPOhUXLgCx3owvN0Yj/L6Xy64OuXer/JB50msAsAh8aZVJhiTxtR9/YwIC/hiXw=
X-Received: by 2002:a17:907:762d:b0:aa5:29b8:15ce with SMTP id
 a640c23a62f3a-aa5f7f3c495mr191513966b.56.1733228970733; Tue, 03 Dec 2024
 04:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
 <20241203075651.109899-1-zhenghaoran154@gmail.com>
In-Reply-To: <20241203075651.109899-1-zhenghaoran154@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Dec 2024 12:28:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4NZGq2QkNz8ZRR=_MqTB1z=+x7PF5to6P=Lgt-B_E4nA@mail.gmail.com>
Message-ID: <CAL3q7H4NZGq2QkNz8ZRR=_MqTB1z=+x7PF5to6P=Lgt-B_E4nA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: fix data race when accessing the inode's
 disk_i_size at btrfs_drop_extents()
To: Hao-ran Zheng <zhenghaoran154@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:59=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gmail.=
com> wrote:
>
> A data race occurs when the function `insert_ordered_extent_file_extent()=
`
> and the function `btrfs_inode_safe_disk_i_size_write()` are executed
> concurrently. The function `insert_ordered_extent_file_extent()` is not
> locked when reading inode->disk_i_size, causing
> `btrfs_inode_safe_disk_i_size_write()` to cause data competition when
> writing inode->disk_i_size, thus affecting the value of `modify_tree`.
>
> The specific call stack that appears during testing is as follows:
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
> The main purpose of the modify_tree variable is to optimize the
> acquisition of read-write locks at or after the end of file (EOF).
> When the value of modify_tree is modified due to concurrency, resulting
> in unnecessary acquisition of write locks, the correctness of the
> system will not be affected. When the system requires a write lock but
> does not acquire the write lock because the value of modify_tree is
> incorrect, the path will be subsequently released and the lock will
> be reacquired to ensure the correctness of the system.

Looks good, I'll slightly rephrase this on things like "modify_tree is
modified due to concurrency" because what gets modified concurrently
is inode->disk_i_size.
I'll push it to the github btrfs for-next branch soon with this
paragraph instead:

"The main purpose of the check of the inode's disk_i_size is to avoid
taking write locks on a btree path when we have a write at or beyond
eof, since in these cases we don't expect to find extent items in the
root to drop. However if we end up taking write locks due to a data
race on disk_i_size, everything is still correct, we only add extra
lock contention on the tree in case there's concurrency from other tasks.
If the race causes us to not take write locks when we actually need them,
then everything is functionally correct as well, since if we find out we
have extent items to drop and we took read locks (modify_tree set to 0),
we release the path and retry again with write locks."

Thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
> Since this data race does not affect the correctness of the function,
> it is a harmless data race, and it is recommended to use `data_race`
> to mark it.
>
> Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> ---
> V2->V3: Added details on why this is a harmless data race
> V1->V2: Modified patch description and format
> ---
>  fs/btrfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 4fb521d91b06..559c177456e6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -242,7 +242,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tra=
ns,
>         if (args->drop_cache)
>                 btrfs_drop_extent_map_range(inode, args->start, args->end=
 - 1, false);
>
> -       if (args->start >=3D inode->disk_i_size && !args->replace_extent)
> +       if (data_race(args->start >=3D inode->disk_i_size) && !args->repl=
ace_extent)
>                 modify_tree =3D 0;
>
>         update_refs =3D (btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJECTID=
);
> --
> 2.34.1
>
>

