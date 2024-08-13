Return-Path: <linux-btrfs+bounces-7160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83E95031A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF861F237F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CF19ADB0;
	Tue, 13 Aug 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moSxF8sf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF819A2AE;
	Tue, 13 Aug 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546656; cv=none; b=DP8mL51FJJ1OlhBeGf2wt86uLnarb2O2/AAs5NbLJ4PX9ApV5Ew3NOVp8Pbz6La1N3IK0bKiyIVfnzmOO9XMkZk6qxTBDVWRAQ3xqirhOQgSrZhbZukpBrdQoU8XMqbgew4t5utjSi/uQkuuwVk+P0KKSCdCHeQO5KpxmzfnZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546656; c=relaxed/simple;
	bh=mx050o4jCRlSnjcrqLzEeH8cgw5cGnvTCmlBHag64iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLk+PM/NzpyOIOD9UYiQji0MwjPrPMH20Wbwm0ocgoxSrNGrFkEljo3zDFhW+DYs2lF0DgLThq53Im/GtyDwtkOOww7Cw8MkI4gkT/RZnp5dosRQETtZ0x1xPBQlBwnVSBle7kpXWm/zsWk2R0nZGb+PWFJX/uJ32UeAwr9e6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moSxF8sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DF6C4AF13;
	Tue, 13 Aug 2024 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546656;
	bh=mx050o4jCRlSnjcrqLzEeH8cgw5cGnvTCmlBHag64iA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=moSxF8sfqTUhuoAuvAoyuy03WLfuvBxLbECNkNdILCexNjkpmoCVbDpM8zsqYbkrj
	 HQ5haQWDWvmbF+B4KxBpZ95qphVaikxnnOv3kLS0WRmZmwnFYCRBHG8bVkE1kPlZ2N
	 MH2YbrJZe273F0qJc+S01QKY40BTt0PIPfgcHx6znS1/IF5shkagq3Un0LY6oMiuw0
	 eKkiLJK636v1vPERvdRUYYixy6b/f67mdwCeDlYwXB2G6q34a5nImvrcLGO54zMa4Q
	 y3SVo/wsxWhiYS+R1rUl0NcO4iA/IgHquUGIPgNkDKKb5ZslvEcmmp+Vf18NDUa8tc
	 vLG9jKy8Z58Yw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so5687186a12.3;
        Tue, 13 Aug 2024 03:57:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKnigQATalhkmtAlj5Ko1apoXnGHF3vmS1PVADJZ4h5lhIwQvdbB/QNiV8B6V23SfUNF/uUseNtEmK8FUI8jRLkmi/Ff1IczkoH9TIe7KDDbRz1QhQKFL/t/58EfL2EggyuoXPHz1Nxzk=
X-Gm-Message-State: AOJu0YzkzTbQLMISOw1UzLRFLhnvFU1IOLfHA9LW7QcFilRHH5EwF21D
	L32NVvazKeH1Kw1AHtc79b1w8dWIsU/r5Qqg87Qj5WP1oISQMot+naX9hvQcVNRChyuHgsTjGmU
	PFmXuICw+KW5Q1oZzRwsh5hwPK1g=
X-Google-Smtp-Source: AGHT+IF0VOqfA+Tl46cH7aory7plXaIpyYQMWNWVLRdTqw16VPAQFUN5+KhHyOBZFhBvF8dop4sdnE0EDJwK6gKKZb4=
X-Received: by 2002:a17:906:c153:b0:a7a:a33e:47cc with SMTP id
 a640c23a62f3a-a80ed2d1779mr212590466b.59.1723546654537; Tue, 13 Aug 2024
 03:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org>
In-Reply-To: <bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 13 Aug 2024 11:56:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5jwR75FwT213yteX5m=5G8ehKmnKxv=xYXbY+UuhP+qQ@mail.gmail.com>
Message-ID: <CAL3q7H5jwR75FwT213yteX5m=5G8ehKmnKxv=xYXbY+UuhP+qQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reduce chunk_map lookups in btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:49=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Currently we're calling btrfs_num_copies() before btrfs_get_chunk_map() i=
n
> btrfs_map_block(). But btrfs_num_copies() itself does a chunk map lookup
> to be able to calculate the number of copies.
>
> So split out the code getting the number of copies from btrfs_num_copies(=
)
> into a helper called btrfs_chunk_map_num_copies() and directly call it
> from btrfs_map_block() and btrfs_num_copies().
>
> This saves us one rbtree lookup per btrfs_map_block() invocation.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes in v2:
> - Added Reviewed-bys
> - Reflowed comments
> - Moved non RAID56 cases to the end without an if
> Link to v1:
> https://lore.kernel.org/all/20240812165931.9106-1-jth@kernel.org/
>
>  fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e07452207426..796f6350a017 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5781,38 +5781,44 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info=
 *fs_info)
>         write_unlock(&fs_info->mapping_tree_lock);
>  }
>
> +static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)

Same as commented before, can be const.

> +{
> +       enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_index(map-=
>type);
> +
> +       if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> +               return 2;
> +
> +       /*
> +        * There could be two corrupted data stripes, we need to loop
> +        * retry in order to rebuild the correct data.
> +        *
> +        * Fail a stripe at a time on every retry except the stripe
> +        * under reconstruction.
> +        */
> +       if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> +               return map->num_stripes;
> +
> +       /* Non-RAID56, use their ncopies from btrfs_raid_array. */
> +       return btrfs_raid_array[index].ncopies;
> +}
> +
>  int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len=
)
>  {
>         struct btrfs_chunk_map *map;
> -       enum btrfs_raid_types index;
> -       int ret =3D 1;
> +       int ret;
>
>         map =3D btrfs_get_chunk_map(fs_info, logical, len);
>         if (IS_ERR(map))
>                 /*
> -                * We could return errors for these cases, but that could=
 get
> -                * ugly and we'd probably do the same thing which is just=
 not do
> -                * anything else and exit, so return 1 so the callers don=
't try
> -                * to use other copies.
> +                * We could return errors for these cases, but that
> +                * could get ugly and we'd probably do the same thing
> +                * which is just not do anything else and exit, so
> +                * return 1 so the callers don't try to use other
> +                * copies.

My previous comment about reformatting was just for the comment that
was moved, the one now inside btrfs_chunk_map_num_copies().
For this one I don't think we should do it, as we aren't moving it
around or changing its content.

It's just confusing to have this sort of unrelated change mixed in.

Thanks.

>                  */
>                 return 1;
>
> -       index =3D btrfs_bg_flags_to_raid_index(map->type);
> -
> -       /* Non-RAID56, use their ncopies from btrfs_raid_array. */
> -       if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> -               ret =3D btrfs_raid_array[index].ncopies;
> -       else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> -               ret =3D 2;
> -       else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> -               /*
> -                * There could be two corrupted data stripes, we need
> -                * to loop retry in order to rebuild the correct data.
> -                *
> -                * Fail a stripe at a time on every retry except the
> -                * stripe under reconstruction.
> -                */
> -               ret =3D map->num_stripes;
> +       ret =3D btrfs_chunk_map_num_copies(map);
>         btrfs_free_chunk_map(map);
>         return ret;
>  }
> @@ -6462,14 +6468,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>         io_geom.stripe_index =3D 0;
>         io_geom.op =3D op;
>
> -       num_copies =3D btrfs_num_copies(fs_info, logical, fs_info->sector=
size);
> -       if (io_geom.mirror_num > num_copies)
> -               return -EINVAL;
> -
>         map =3D btrfs_get_chunk_map(fs_info, logical, *length);
>         if (IS_ERR(map))
>                 return PTR_ERR(map);
>
> +       num_copies =3D btrfs_chunk_map_num_copies(map);
> +       if (io_geom.mirror_num > num_copies)
> +               return -EINVAL;
> +
>         map_offset =3D logical - map->start;
>         io_geom.raid56_full_stripe_start =3D (u64)-1;
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
> --
> 2.43.0
>
>

