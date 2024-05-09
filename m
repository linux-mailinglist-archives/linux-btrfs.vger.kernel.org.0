Return-Path: <linux-btrfs+bounces-4871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A516F8C12A6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 18:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C61D283730
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B816F8F7;
	Thu,  9 May 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHhN2gGz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8716F850
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271777; cv=none; b=ZR/4aIsHrBvZHzLdADrNKh7hLjXNt1uPk+yCWRjiWQdm2W1yymd/Q1n03IgwFdLGno+s9VDZFCRMZCs4WQ41x4NEnpMzwXs/J2kL/KtkV0yWYmS84LWxXeFDR/P4IpqutF2z6ZlJHx+B6+p8wFqRQ89MbmhwPnZAB6nJ77zmAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271777; c=relaxed/simple;
	bh=wxR3L6NTYK3pYMEVIF6TrPrJ9f9IMlvpvZIH14/NUfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfDTj88wqfTwAAmmsAtUNcEi8tX4FqDm+5S/wJU4+xg/mocLSzCI1C57MysPfkZB7NghrGh9ISjJsQruq8StadmIR7HatQMLWMUktVtjd54Q8EnZBT25HEMTZrVMHVrw9okiW10PV+nMQw1WrB9T9FsJVW6zxdaZB7dLGSgzb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHhN2gGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A04C116B1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271776;
	bh=wxR3L6NTYK3pYMEVIF6TrPrJ9f9IMlvpvZIH14/NUfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pHhN2gGzQH4tomzR0gnClhNHfqCMbxomJrhqK4kMTjjDeT6wyHYmQeLRpS5u1mOrJ
	 2KP7Bd1sbFtK1y6eczv2HKfJ+qDzyuUZkhybRsbTqb54T96nk7X3+Tah7bUYAjExon
	 UoHEC2mWJiBAv2s3vttIyDaIJgzKBlPfOHzq3/mH/a0fBIOmkQV27LlXNAhgKK9PR2
	 0qYlAz0bITCUWYEW/QwqF/rjRZKY190ZTw11V75NhD60RRgjyZpSBIGMzFBhotkIun
	 D77YV1aMIGIrbhXFaWS+dgmM9GIs8IHYQs7OKk8rbmwdB3oBXil6qCxvhSjB9tcSCU
	 vAEr7nROPcuww==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a352bbd9so194412766b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:22:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YzTK5mSEZNeDLSN2vPp0bBmA4aycZ9LpOhAn2kNpBn0dCx+1dDD
	mX28/w0mxbLjHWYSqjEjqZ42BZOkKti7ePDA+ZZAu31WfsY9YIeLoNoVCxwQoS+OSa0F8nmVLey
	ugL09DWCf/xpA6MH9A8WhhBoukB8=
X-Google-Smtp-Source: AGHT+IFjeHCV3KSGGkfG+wNUeX0K7lr6JjZe8RUEIMnYOnt0B5B3v79okrdhqxZ32/PYxvm3jLY3VcIzA+YpBDbrwSc=
X-Received: by 2002:a17:906:aec9:b0:a59:b17c:c9d2 with SMTP id
 a640c23a62f3a-a5a115f2dbemr235650266b.12.1715271775354; Thu, 09 May 2024
 09:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <e351482ededb22c1fb81eeed217ae8e34e8e1427.1714707707.git.wqu@suse.com>
In-Reply-To: <e351482ededb22c1fb81eeed217ae8e34e8e1427.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 May 2024 17:22:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4ruNd9xUvp7yY-CPEQAvM+6Kd+N2Nd6SDgXUpj=OhQAg@mail.gmail.com>
Message-ID: <CAL3q7H4ruNd9xUvp7yY-CPEQAvM+6Kd+N2Nd6SDgXUpj=OhQAg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] btrfs: export the expected file extent through can_nocow_extent()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently function can_nocow_extent() only returns members needed for
> extent_map.
>
> However since we will soon change the extent_map structure to be more
> like btrfs_file_extent_item, we want to expose the expected file extent
> caused by the NOCOW write for future usage.
>
> This would introduce a new structure, btrfs_file_extent, to be a more

"would introduce" -> introduces

> memory-access-friendly representation of btrfs_file_extent_item.
> And use that structure to expose the expected file extent caused by the
> NOCOW write.
>
> For now there is no user of the new structure yet.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h | 20 +++++++++++++++++++-
>  fs/btrfs/file.c        |  2 +-
>  fs/btrfs/inode.c       | 22 +++++++++++++++++++---
>  3 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index de918d89a582..18678762615a 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -443,9 +443,27 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs=
_info, struct page *page,
>                             u32 pgoff, u8 *csum, const u8 * const csum_ex=
pected);
>  bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev=
,
>                         u32 bio_offset, struct bio_vec *bv);
> +
> +/*
> + * A more access-friendly representation of btrfs_file_extent_item.
> + *
> + * Unused members are excluded.

A bit confusing this, you want to say this is a subset of
btrfs_file_extent_item.
So just say something like:

This represents details about the target file extent item of a write operat=
ion.

> + */
> +struct btrfs_file_extent {
> +       u64 disk_bytenr;
> +       u64 disk_num_bytes;
> +
> +       u64 num_bytes;
> +       u64 ram_bytes;
> +       u64 offset;
> +
> +       u8 compression;

The blank lines between the members seem kind of ad-hoc, redundant to
me - i.e. no logical grouping.
Maybe I missed something?

> +};
> +
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>                               u64 *orig_start, u64 *orig_block_len,
> -                             u64 *ram_bytes, bool nowait, bool strict);
> +                             u64 *ram_bytes, struct btrfs_file_extent *f=
ile_extent,
> +                             bool nowait, bool strict);
>
>  void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
>  struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dent=
ry);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index d3cbd161cd90..63a13a4cace0 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1104,7 +1104,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inod=
e, loff_t pos,
>                                                    &cached_state);
>         }
>         ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes=
,
> -                       NULL, NULL, NULL, nowait, false);
> +                       NULL, NULL, NULL, NULL, nowait, false);
>         if (ret <=3D 0)
>                 btrfs_drew_write_unlock(&root->snapshot_lock);
>         else
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0e5d4517af0e..2815b72f2d85 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1857,6 +1857,9 @@ struct can_nocow_file_extent_args {
>         u64 extent_offset;
>         /* Number of bytes that can be written to in NOCOW mode. */
>         u64 num_bytes;
> +
> +       /* The expected file extent for the NOCOW write. */
> +       struct btrfs_file_extent file_extent;
>  };
>
>  /*
> @@ -1921,6 +1924,12 @@ static int can_nocow_file_extent(struct btrfs_path=
 *path,
>
>         extent_end =3D btrfs_file_extent_end(path);
>
> +       args->file_extent.disk_bytenr =3D btrfs_file_extent_disk_bytenr(l=
eaf, fi);
> +       args->file_extent.disk_num_bytes =3D btrfs_file_extent_disk_num_b=
ytes(leaf, fi);
> +       args->file_extent.ram_bytes =3D btrfs_file_extent_ram_bytes(leaf,=
 fi);
> +       args->file_extent.offset =3D btrfs_file_extent_offset(leaf, fi);
> +       args->file_extent.compression =3D btrfs_file_extent_compression(l=
eaf, fi);
> +
>         /*
>          * The following checks can be expensive, as they need to take ot=
her
>          * locks and do btree or rbtree searches, so release the path to =
avoid
> @@ -1955,6 +1964,9 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>         args->disk_bytenr +=3D args->start - key->offset;
>         args->num_bytes =3D min(args->end + 1, extent_end) - args->start;
>
> +       args->file_extent.num_bytes =3D args->num_bytes;
> +       args->file_extent.offset +=3D args->start - key->offset;
> +
>         /*
>          * Force COW if csums exist in the range. This ensures that csums=
 for a
>          * given extent are either valid or do not exist.
> @@ -7099,7 +7111,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr)
>   */
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>                               u64 *orig_start, u64 *orig_block_len,
> -                             u64 *ram_bytes, bool nowait, bool strict)
> +                             u64 *ram_bytes, struct btrfs_file_extent *f=
ile_extent,
> +                             bool nowait, bool strict)
>  {
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>         struct can_nocow_file_extent_args nocow_args =3D { 0 };
> @@ -7188,6 +7201,9 @@ noinline int can_nocow_extent(struct inode *inode, =
u64 offset, u64 *len,
>                 *orig_start =3D key.offset - nocow_args.extent_offset;
>         if (orig_block_len)
>                 *orig_block_len =3D nocow_args.disk_num_bytes;
> +       if (file_extent)
> +               memcpy(file_extent, &nocow_args.file_extent,
> +                      sizeof(struct btrfs_file_extent));

Can use instead sizeof(*file_extent), and it will allow to have
everything in the same line without being over 80 characters.

The rest looks fine, but I have to read the rest of the patchset to
see how this is actually used.

Thanks.

>
>         *len =3D nocow_args.num_bytes;
>         ret =3D 1;
> @@ -7407,7 +7423,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 block_start =3D em->block_start + (start - em->start);
>
>                 if (can_nocow_extent(inode, start, &len, &orig_start,
> -                                    &orig_block_len, &ram_bytes, false, =
false) =3D=3D 1) {
> +                                    &orig_block_len, &ram_bytes, NULL, f=
alse, false) =3D=3D 1) {
>                         bg =3D btrfs_inc_nocow_writers(fs_info, block_sta=
rt);
>                         if (bg)
>                                 can_nocow =3D true;
> @@ -10660,7 +10676,7 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>                 free_extent_map(em);
>                 em =3D NULL;
>
> -               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL, false, true);
> +               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL, NULL, false, true);
>                 if (ret < 0) {
>                         goto out;
>                 } else if (ret) {
> --
> 2.45.0
>
>

