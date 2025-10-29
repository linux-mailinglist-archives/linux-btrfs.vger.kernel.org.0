Return-Path: <linux-btrfs+bounces-18395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6428C1A6F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 13:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A86C188E0C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740F366FB1;
	Wed, 29 Oct 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdaWzlMg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716D301001
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740778; cv=none; b=UoMwZ6eBPxRdQvAToNxQdvhbQBPagzfZSj8pjiq9KGIkw9LJEDHGXCyaORHW+nrHn8qHczZ6/rWzikhy6AJ3pkmnpVrrjjzriklDVAHWiepiXsk7bLJJEtjE4kckz0OMB9ocfO6GgXp7NdH5JQlxGSkxmzdPaYEnHQwB/NMTU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740778; c=relaxed/simple;
	bh=PRBAZTNyiydChIzc8GZyhj1fxIKID37S1bQrK70ubF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIcWgpjgygKAROR9WdEBygEaeRGdDFreCWuCfLudT25IHyYvHrE9U+fyhkDRqF6XZZpiX7FOD9fh2OpVUQDmoL+licelzYpoilvDD8hxVnrFLCDdq1WMOeCC8nnn03GTu27CAbPJcCusPs2CVgDnNibFPLteFZlptrA2GviuXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdaWzlMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8986C116C6
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740778;
	bh=PRBAZTNyiydChIzc8GZyhj1fxIKID37S1bQrK70ubF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fdaWzlMgsK9IEq9NbVSipiyA5yIFmOMAww1Ts45A5i5JjbKyabmkJ+ibgf6cZzevB
	 2WzI7mBEx7C7qyw9ra5FxpNBjjN9x2TzjD13FdP2LZUIki1Mn7Z9gw01yLDAl2nhJ6
	 BOc/GnJiBkFpCBOkvbeZooKlwptbX+E+0+v/O1hNPynRR99C4kphy9fIkiCV76fEPH
	 a2b3UabwPN+ODTiC5t0biqaHvRpsEBy2eLlgeCUNuNrl0AZKDru00tEoWy9JXPwiML
	 yi/uigJmHAhY+yyynYzRjxt6wjt89sIZHFR+/T9Bk6UWwI7oUUBjHbOeYJpSynABF7
	 iypy4tCbST1gA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e9d633b78so241097566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:26:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDc+EjdSpZrklauDnvso8o1ImbbfZoieLiD7i7U4BFy0ioMB+Jn2vhlRVhbKCKAYf48cXbAe+jDZILfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxic2VWp7rcHXE0DM9K06Ru/T0dggxi3iEZRJAUR8aUps2XLhwD
	IjJnRI8DmqCMOZl1mM0mFU7dfHzbp3pl5+eRDtnAUWYtz+Rsady+FrVZvB8thG4OG21uYTdR3Rr
	jwAbitycNQc8aicUBMebo1LhjM0Pc008=
X-Google-Smtp-Source: AGHT+IGB5sZp0t6z+hxIw+nvxgAjh8c7VK8FatXMmUoIsyDrSSHCPA8QiPeCQwIKyXeukOhsOlpH1dFNrxJM7WHVRJs=
X-Received: by 2002:a17:907:7b87:b0:b6d:ba71:a17f with SMTP id
 a640c23a62f3a-b6dbbfb74a7mr743412566b.18.1761740777291; Wed, 29 Oct 2025
 05:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029093527.2938961-1-austinchang@synology.com>
In-Reply-To: <20251029093527.2938961-1-austinchang@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 29 Oct 2025 12:25:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7sHW7fK4zwpz2po1RFYryFZotXj8YNVKQbZ0jhXQkKPA@mail.gmail.com>
X-Gm-Features: AWmQ_bkk8s58OO_JT0dUfp5opYxaYJ9n_D_8uxojO2wZeJRJXYe7Muh3yORLm_U
Message-ID: <CAL3q7H7sHW7fK4zwpz2po1RFYryFZotXj8YNVKQbZ0jhXQkKPA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: mark dirty bit for out of bound prealloc extents
To: austinchang <austinchang@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:36=E2=80=AFAM austinchang <austinchang@synology.c=
om> wrote:
>
> In btrfs_fallocate(), when the allocated range overlaps with a prealloc
> extent and the extent starts after i_size, the range doesn't get marked
> dirty in file_extent_tree.
>
> This is reproducible since the commit
> 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree"),
> and became hidden since
> 3d7db6e8bd22 ("btrfs: don't allocate file extent tree for non regular fil=
es")
> stops initializing file_extent_tree.

So this is confusing because it misses mentioning that the issue
became visible again after commit 8679d2687c35 ("btrfs: initialize
inode::file_extent_tree after i_mode has been set").

I'll add that information when merging this to for-next.

>
> The following reproducer triggers the problem:
> $ cat test.sh
> #!/bin/sh
>
> MNT=3D/mnt/test
> DEV=3D/dev/vdb
>
> mkdir -p $MNT
>
> mkfs.btrfs -f -O ^no-holes $DEV
> mount $DEV $MNT
>
> touch $MNT/file1
> # Add a 2M extent at the file offset 1M without increasing i_size
> fallocate -n -o 1M -l 2M $MNT/file1
>
> # Unmount and mount again to clear the in-memory extent tree
> umount $MNT
> mount $DEV $MNT
>
> # Use a length that doesn't trigger realloc of the 2M extent before

This comment is confusing.
What do you mean by "trigger realloc"?
Doing an fallocate against a range which already has allocated extents
won't drop the extents and allocate new ones.

Perhaps what you want to say is that we want fallocate within the
range of the previously allocated extent just to increase the i_size.

You don't need to send a new patch version for that. I can just replace it =
with:

"Allocate within the range of the previously allocated extent just to
increase i_size."

> len=3D$((1 * 1024 * 1024))
>
> # fallocate on the prealloc extent to change i_size
> fallocate -o 1M -l $len $MNT/file1
>
> # Check the file size, expecting 2M
> du --bytes $MNT/file1
>
> # Unmount and mount again the fs.
> umount $MNT
> mount $DEV $MNT
>
> # The file size should be the same as before
> du --bytes $MNT/file1
>
> umount $MNT
>
> Running the reproducer gives the following result:
>
> $ ./test.sh
> (...)
> 2097152 /mnt/test/file1
> 1048576 /mnt/test/file1
>
> The difference is exactly 1048576 as we assigned.

See?
This is how a reproducer for a change log should be.
Easy to copy paste, modify as needed and run, with comments explaining step=
s.
The previous one with snapshot and subvolume and magic numbers was not
explained at all and more complex than it needed to be.

Thanks.

>
> Fix by adding a call to btrfs_inode_set_file_extent_range() in
> btrfs_fallocate_update_isize().
>
> Fixes: 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")
>
> Signed-off-by: austinchang <austinchang@synology.com>
> ---
> Changelog:
> v2: make a simpler reproducer and move the call of
> btrfs_inode_set_file_extent_range().
>
> The snapshot in v1 is to make the extent tree empty for the inode, so
> "unmount then mount" can also trigger the issue.
>
> We discovered that the unaligned length is only needed when the punch
> hole is present. It will drop and replace the extent to be aligned, and
> the later fallocate only marks the range on newly allocated 1M extent,
> which is also aligned. Once the punch hole is removed, the requirement
> become not to trigger new allocation on the 2M extent initially.
>
> V2 also moves the call of btrfs_inode_set_file_extent_range() into
> btrfs_fallocate_update_isize() so that the range can be updated for all
> the extent operations that might affect i_size.
> ---
>  fs/btrfs/file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 204674934..882bb21ad 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2855,12 +2855,23 @@ static int btrfs_fallocate_update_isize(struct in=
ode *inode,
>  {
>         struct btrfs_trans_handle *trans;
>         struct btrfs_root *root =3D BTRFS_I(inode)->root;
> +       u64 range_start;
> +       u64 range_end;
>         int ret;
>         int ret2;
>
>         if (mode & FALLOC_FL_KEEP_SIZE || end <=3D i_size_read(inode))
>                 return 0;
>
> +       range_start =3D round_down(i_size_read(inode), root->fs_info->sec=
torsize);
> +       range_end =3D round_up(end, root->fs_info->sectorsize);
> +
> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), range_s=
tart,
> +                                               range_end - range_start);
> +
> +       if (ret)
> +               return ret;
> +
>         trans =3D btrfs_start_transaction(root, 1);
>         if (IS_ERR(trans))
>                 return PTR_ERR(trans);
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.

