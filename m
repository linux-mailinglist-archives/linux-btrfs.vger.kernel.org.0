Return-Path: <linux-btrfs+bounces-7155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5095950279
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504F6B26B97
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBE194A5B;
	Tue, 13 Aug 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8YRfTDQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1A18DF62;
	Tue, 13 Aug 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544827; cv=none; b=PDzB+nUOj7FudkPxADo4APNRN/PT4GK2ZdH0qUcHCqUtnVadHNM+HKFNE+OKPAryKXEefDxr7vC3qWuBh4GUwfcelUdnivwpGugZ/L6vx4g9OEtVBrvItlq6mErjEm4bierU9YIdq/J5GLLwUBTtoBIF8XzFAW3sddvfAz11ALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544827; c=relaxed/simple;
	bh=whD3H4/YPbcQqCEdT/d7oKczontTk3uLQSOgIE/FGxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyUw0jrJI1q1F92u6X7hUkFZJnreFqbBDqq37czzDOE5r1dhyaBYxAzSttz03TTjnbiMe/iX9exRu1/VSesDCuGs4BYrh/91Kky5C2+dr1RATBBsPxqyhIlmCyaKP2wZ/TtlFX6Eft+o90F9Tk9UWivHaZg9T31DkVo9spqA0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8YRfTDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD00C4AF0B;
	Tue, 13 Aug 2024 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723544826;
	bh=whD3H4/YPbcQqCEdT/d7oKczontTk3uLQSOgIE/FGxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q8YRfTDQ5y/6+/BOgtfNk34bYBqLlnZD3dwOMaIunBU8b8KXijf2SMIQK8WOr2qqO
	 dNE2qkpL5S3f9J0PfsHAgJXhs6+w4zHZrwaR30mOt+52RA6xPaSPP9Wvtu1OAdOraZ
	 7T+kLMud80zEMNqrLDh+QSimtFUs4npZs1mEFmH3gAK0iB/FTx7rzM6p69D19tJJWi
	 gqjAJQVlGzRlcd3t2KaVlQSR3Q8nbbTvz/5Ftr1aTJB46xL0NU9ciVHfPVpvwfjX1O
	 Z49R19XENLVpdTqlMKwFo801oC3qq2cD+jdxr4PvEYLjg068+QBs1fG21dfle28WnU
	 YHuTgP5Rz7X4A==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9e25008aso74222466b.0;
        Tue, 13 Aug 2024 03:27:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+lnXIGHP0v6h5cno9BM+z2L8/Qhe2UALAZM1HH73/S8OKQFMCqU+RxtO0kp3zk02wAFv7M4Cdzs3sGPsbKTODZybriYwe7Z73/8Hd7db3R1A/5yDPpNO59DX15MLdEXQaCftOJHPyhXg=
X-Gm-Message-State: AOJu0YzMWw9QeIote+BZPd7/3ZKzIJh65kSUK5EoC+QY8rWol7gECnpf
	BKVQA0xzyvKBIrgsCCJWHdI1zNop4VWGcsHvilC1kXSHKjIiB4ujA5Dr+AtGYviEbynGRkb+9xc
	IndCO3wWtA0G3OWoOJMUZZW+Pp6o=
X-Google-Smtp-Source: AGHT+IGHdspHEbs6oPwEELfckFST2N3+WXraVbD6ObT2rgImU9WBraFQ9WOWSQyKcRluBUbyaJGBFlMgU2YaE06kMR0=
X-Received: by 2002:a17:907:f148:b0:a7a:929f:c0ce with SMTP id
 a640c23a62f3a-a80ed1efe70mr254124966b.19.1723544825105; Tue, 13 Aug 2024
 03:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812165931.9106-1-jth@kernel.org>
In-Reply-To: <20240812165931.9106-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 13 Aug 2024 11:26:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H71KCunZHKZhbNxJEAWriJ4eZzogBNMmpT39o_LzaBWBA@mail.gmail.com>
Message-ID: <CAL3q7H71KCunZHKZhbNxJEAWriJ4eZzogBNMmpT39o_LzaBWBA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reduce chunk_map lookups in btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:18=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
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
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 50 +++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e07452207426..4863bdb4d6f4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5781,10 +5781,33 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info=
 *fs_info)
>         write_unlock(&fs_info->mapping_tree_lock);
>  }
>
> +static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)

Can be made const.

> +{
> +       enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_index(map-=
>type);
> +
> +       /* Non-RAID56, use their ncopies from btrfs_raid_array. */
> +       if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> +               return btrfs_raid_array[index].ncopies;

Since the index is only used here, it could be declared here.
Or just just shorten the function to something like this, which also
addresses Qu's comment:

static int btrfs_chunk_map_num_copies(const struct btrfs_chunk_map *map)
{
     enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_index(map->type=
);

     if (map->type & BTRFS_BLOCK_GROUP_RAID5)
         return 2;

    /*
     * There could be two corrupted data stripes, we need
     * to loop retry in order to rebuild the correct data.
     *
     * Fail a stripe at a time on every retry except the
     * stripe under reconstruction.
     */
    if (map->type & BTRFS_BLOCK_GROUP_RAID6)
        return map->num_stripes;

    /* Non-RAID56, use their ncopies from btrfs_raid_array. */
    return btrfs_raid_array[index].ncopies;
}

Less code, less one if statement, and no need for the assert Qu mentioned.

> +
> +       if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> +               return 2;
> +
> +       /*
> +        * There could be two corrupted data stripes, we need
> +        * to loop retry in order to rebuild the correct data.
> +        *
> +        * Fail a stripe at a time on every retry except the
> +        * stripe under reconstruction.

Since this is moving the comment and it falls too short of the 80
characters line length,
it's a good opportunity to reformat it to have the lines closer to 80
characters.

Otherwise it looks fine:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +        */
> +       if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> +               return map->num_stripes;
> +
> +       return 1;
> +}
> +
>  int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len=
)
>  {
>         struct btrfs_chunk_map *map;
> -       enum btrfs_raid_types index;
>         int ret =3D 1;
>
>         map =3D btrfs_get_chunk_map(fs_info, logical, len);
> @@ -5797,22 +5820,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info=
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
> @@ -6462,14 +6470,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
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

