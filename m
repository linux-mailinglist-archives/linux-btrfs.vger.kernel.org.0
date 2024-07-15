Return-Path: <linux-btrfs+bounces-6461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E093131A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 13:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7793B2275F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8E1891BB;
	Mon, 15 Jul 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVCSsfme"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F641465B8;
	Mon, 15 Jul 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042982; cv=none; b=utwH7nIvwem8A3cRyUtkzdbLX5mqXgrgi2XI7rvTgz9TqIGx8W/yfaC+ob/eVrClXwvw9GawRT2j/MqEBcDYEI3qF+mE3Tk0ccRWXkyM4pCKdoognFwoPp64csfb8exKfLbrjOgBOa+fXhqpA/wkETt6kowMLhD9IveQTjSGRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042982; c=relaxed/simple;
	bh=1N4223mPs3579yauQu+sO96e8qWR06N7+yJXhkHKaeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uscQSIULUw5zJA24GTop2x1N2ctxFHhxUe8n1YD9PnoKg5+WOihOCVHHYl2CQEJ/YGvt5+NeZ5YiIxza1ZAOXlInIcv+O7NFFgEqYZ19aYJQ8B6+HQDm87pemOUQfF8I859bEcb0dVwAHAdcAcXSBAgjmkA+YCbTtwj6cZcG/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVCSsfme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F936C4AF10;
	Mon, 15 Jul 2024 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042982;
	bh=1N4223mPs3579yauQu+sO96e8qWR06N7+yJXhkHKaeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BVCSsfmeYWGzo+KFyqJunW10wW5W6WJ5uwAEG0lQhYcb0+ro11Aytw3V+gHRmukcj
	 DV8mltfhpM3PNTDJ1lYVpyaUp910sag0JegogrlnHn1O4gmLYrIC2GtZ0RGskgXBT6
	 noG4RmrufSCYGQiXtWA6WrK0nEGVMvIKMlKXiREj0uhcSnGPdT/8dZsvFRbN4Rm+HX
	 gh+wyhAngRv8s6L2YhGBpYKpmWjvWdvfGWF1+lBXOLwKiWeLFakLUmskvUHDPKF5WI
	 TXI1XYJTTVWEzFHX//1aA+1vlicQTXosiyQxuc2LNOaqlO9Kdnk9bMzLCdRavFssIl
	 AiTIewqaSDfHw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso522968266b.0;
        Mon, 15 Jul 2024 04:29:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpmjItxhU36Ynm5xzvTltVc7PLTioeCsLfKBxEIb8WOcBKXuQ92qQ779a9urdKae2GJqV6S0EpN6G3cLvGLN2zu6Tz3QeG+xnvPo+iOLI9uDtk5OpTBJC+78E3H5vFrW7z80nO6ofDv7M=
X-Gm-Message-State: AOJu0YxNS17DeDoGuXftgkusZtTeR0TsKJd3MtgvcyNeoo8jQs+be4Qa
	yxJ0cVjU3DSwkyqUecKeAaTQVAeB7GDSRs1E1ScGwXqSeI6LQCQ7ahHLI1XYeMgal3En9siISUY
	zE3OPoQVK5eSyf1dKyMbE7I/ydqE=
X-Google-Smtp-Source: AGHT+IEZ3kSK7SImHMGqZkJdVKgy+3UyunJUdzl6H4TAkdgoDTo+pcy8zpkn6cvU8twyFbLm5rFZbSEk5seyvLZIS/k=
X-Received: by 2002:a17:906:6b01:b0:a77:dcda:1fd8 with SMTP id
 a640c23a62f3a-a780b6b203fmr1124819366b.23.1721042980722; Mon, 15 Jul 2024
 04:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org> <20240712-b4-rst-updates-v3-1-5cf27dac98a7@kernel.org>
In-Reply-To: <20240712-b4-rst-updates-v3-1-5cf27dac98a7@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Jul 2024 12:29:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7rFsNf1JOW0MmAda544QKe4GGwNarBQ2VaTytJgQNnsA@mail.gmail.com>
Message-ID: <CAL3q7H7rFsNf1JOW0MmAda544QKe4GGwNarBQ2VaTytJgQNnsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qu Wenru <wqu@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 8:49=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().
>
> It is only needed to protect
> a) calls to find_live_mirror() and
> b) calling into handle_ops_on_dev_replace().
>
> But there is no need to hold the rwsem for any kind of set_io_stripe()
> calls.
>
> So relax taking the dev_replace rwsem to only protect both cases and chec=
k
> if the device replace status has changed in the meantime, for which we ha=
ve
> to re-do the find_live_mirror() calls.
>
> This fixes a deadlock on raid-stripe-tree where device replace performs a
> scrub operation, which in turn calls into btrfs_map_block() to find the
> physical location of the block.
>
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fcedc43ef291..4209419244a1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>         *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
>
> +again:
>         down_read(&dev_replace->rwsem);
>         dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_repla=
ce);
> -       /*
> -        * Hold the semaphore for read during the whole operation, write =
is
> -        * requested at commit time but must wait.
> -        */
> -       if (!dev_replace_is_ongoing)
> -               up_read(&dev_replace->rwsem);
>
>         switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>         case BTRFS_BLOCK_GROUP_RAID0:
> @@ -6695,6 +6690,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                            "stripe index math went horribly wrong, got st=
ripe_index=3D%u, num_stripes=3D%u",
>                            io_geom.stripe_index, map->num_stripes);
>                 ret =3D -EINVAL;
> +               up_read(&dev_replace->rwsem);
>                 goto out;
>         }
>
> @@ -6710,6 +6706,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                  */
>                 num_alloc_stripes +=3D 2;
>
> +       up_read(&dev_replace->rwsem);
> +
>         /*
>          * If this I/O maps to a single device, try to return the device =
and
>          * physical block information on the stack instead of allocating =
an
> @@ -6782,6 +6780,18 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>                 goto out;
>         }
>
> +       /*
> +        * Check if something changed the dev_replace state since
> +        * we've checked it for the last time and if redo the whole
> +        * mapping operation.
> +        */
> +       down_read(&dev_replace->rwsem);
> +       if (dev_replace_is_ongoing !=3D
> +           btrfs_dev_replace_is_ongoing(dev_replace)) {
> +               up_read(&dev_replace->rwsem);
> +               goto again;

We previously allocated bioc, so before the goto we have to free it
(call btrfs_put_bioc(bioc)), otherwise we'll leak it as after the goto
we end up allocating a new one.

Otherwise it looks fine, thanks.

> +       }
> +
>         if (op !=3D BTRFS_MAP_READ)
>                 io_geom.max_errors =3D btrfs_chunk_max_errors(map);
>
> @@ -6789,6 +6799,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>             op !=3D BTRFS_MAP_READ) {
>                 handle_ops_on_dev_replace(bioc, dev_replace, logical, &io=
_geom);
>         }
> +       up_read(&dev_replace->rwsem);
>
>         *bioc_ret =3D bioc;
>         bioc->num_stripes =3D io_geom.num_stripes;
> @@ -6796,11 +6807,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         bioc->mirror_num =3D io_geom.mirror_num;
>
>  out:
> -       if (dev_replace_is_ongoing) {
> -               lockdep_assert_held(&dev_replace->rwsem);
> -               /* Unlock and let waiting writers proceed */
> -               up_read(&dev_replace->rwsem);
> -       }
>         btrfs_free_chunk_map(map);
>         return ret;
>  }
>
> --
> 2.43.0
>
>

