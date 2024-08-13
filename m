Return-Path: <linux-btrfs+bounces-7164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135F950433
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 13:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3C41F21A01
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C874199EAD;
	Tue, 13 Aug 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZnTb09T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846831990D6;
	Tue, 13 Aug 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549874; cv=none; b=F2m7ATcafBMSmkNwMf326/EsuHValjc8hbjvRKWt5TleAeZUsOqXcBHkMLmrZ4Y8Gfb18qzNOXTv6RF5uVDWRFXBnSxZFUolGECNEXVnN13SdKr83/ARRwmi1+umzGn4aiCO/3Ybr4utQ+cr0Kh91M4fFdW+5tHWVhnoDrP2pGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549874; c=relaxed/simple;
	bh=dSSqx1y/BmkNR6Oj/AKVGhrdEKwya+e1UfiUUQgAkNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fybNf7Mzm8vuDqR/SZTS0MhSl0M1PtVVWznakKnVyVikgTLwkCLVBrooY6CKVS9/ceP3zHGZna/3M6H7KeP7UTZRFXEKEhfq7hLXISW4pwXWCom+mt3gdXt0MJ/81QkHcScA8qdFUSDA26TIWXI33p16fRXV030MAtFCUvkL2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZnTb09T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01926C4AF0B;
	Tue, 13 Aug 2024 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723549874;
	bh=dSSqx1y/BmkNR6Oj/AKVGhrdEKwya+e1UfiUUQgAkNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PZnTb09TGZetZtsxQqkaYfwPiXWaf+BYt/e00aLoyeTVMH32n4ARb51DyYSysfXDE
	 3iFHkkoObn9DYUrF/L0OSIw2t91Egzh6pPDtHWoU01rCp3KmxF7PM4OG6Y0GjE7KSo
	 tPOR+t4JHs/RhhdPRlWvV34vAoGV3n/nFUfdfguciEzVfkc7DjVTZMSN+wLBlNlmG5
	 TAeXQvDQEOSzeYOGbUZL+iyC8ubnI2djGNEfPJMLgVJ9OOM7s1fiRsAECWsb2A1Dkd
	 vz1y3bBK+38ZFJSNQMytwoXWYLQOtaULKqs6R/LO1GNEVr4om4RJJJXTyIwceaegfM
	 fwVUr+6cWBgNQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso9823601e87.3;
        Tue, 13 Aug 2024 04:51:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtbMy9LZT2qtjIg3MLQfNpbDS7MBiENu9K9eELYu973lMNVF+MqqAyJcHwzKwmIqdNPyTDccwTrWQu/U/TXMS988urJ77L6S3g3+JRN/Rt0OAsP4ctYv6MJlLt5yCPGJCdftCHpmbDo7Y=
X-Gm-Message-State: AOJu0YyMEIYK72/YtVxqg4kDd3DOLQ5Qv8OsTtzNoi8iaVEw5b/4NdrS
	0eGYbqkYwi8zfFSobPG2PzKSmG7R2BwN7dSoVN1qYL0H9JJfJZoZ05Qccd0TZ267413XoeqG8Y9
	msaFWEMeWVmfxz+hceyUkMdXta8Q=
X-Google-Smtp-Source: AGHT+IH/RYqKYqg7Ekl9GF/FH88BeAzf7ErB6NrAqoPeE7uJba3lT1uMsdfQeapm5vDVT2qvaMukn5p8fqYsJvQ+lY0=
X-Received: by 2002:a05:6512:3b06:b0:530:b773:b4ce with SMTP id
 2adb3069b0e04-5321365c8e3mr2439420e87.33.1723549872098; Tue, 13 Aug 2024
 04:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813113641.26579-1-jth@kernel.org>
In-Reply-To: <20240813113641.26579-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 13 Aug 2024 12:50:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6pCGcT=xGX4h5Rcb2Ky1wzK=7s1iqA4XevsYE7KNc2EQ@mail.gmail.com>
Message-ID: <CAL3q7H6pCGcT=xGX4h5Rcb2Ky1wzK=7s1iqA4XevsYE7KNc2EQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: reduce chunk_map lookups in btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:37=E2=80=AFPM Johannes Thumshirn <jth@kernel.org=
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
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changes in v2:
> - Added Reviewed-bys
> - Reflowed comments
> - Moved non RAID56 cases to the end without an if
> Link to v1:
> https://lore.kernel.org/all/20240812165931.9106-1-jth@kernel.org/
>
> Changes in v3:
> - constified btrfs_chunk_map_num_copies() parameter
> - fixed accidentially changed comment
> Link to v2:
> https://lore.kernel.org/all/bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723=
546054.git.jth@kernel.org/
>
>  fs/btrfs/volumes.c | 49 +++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e07452207426..4b9b647a7e29 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5781,11 +5781,31 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info=
 *fs_info)
>         write_unlock(&fs_info->mapping_tree_lock);
>  }
>
> +static int btrfs_chunk_map_num_copies(const struct btrfs_chunk_map *map)
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
> @@ -5797,22 +5817,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info=
, u64 logical, u64 len)
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
> @@ -6462,14 +6467,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
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

