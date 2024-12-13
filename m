Return-Path: <linux-btrfs+bounces-10348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3F9F0BD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 13:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A43188A97E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E01DF733;
	Fri, 13 Dec 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfqd4581"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702E1DE2B2;
	Fri, 13 Dec 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091487; cv=none; b=V8nzPTpg7bwnhI2+weeeF+e/R0su/3gKhyNE7ZFzKDOVwSWl6hHQEfJaqO3sqqwFBz4yJebFvynzednMk0Ox7vMueubFzAdtEofBPhIAIbQR388naR6qtyWSsRhHorGLi77hBDHf0nYSisBs37jibii3EcmdDvKaKopqbIVVa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091487; c=relaxed/simple;
	bh=WcniSQgVJLHfCMtrvyW4Luo0Ii/2lI46/4EdKPcjfMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuOygoNtK2FgUgXJyHV5ED9SvgDOI4IXlRYgqFjUj0MBIhXEuRDCOOA6V6uQ1CUEduToaioChfAnr4GH2+E9e+NmCcN5VggbNzkhmjGY6ApVEoZOFMdX8rPKk7BBEL/IdhGMPk5d/nYicxhBQIFYCvzmb/SqYZP0a+9eiHexhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfqd4581; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FC1C4CED6;
	Fri, 13 Dec 2024 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734091486;
	bh=WcniSQgVJLHfCMtrvyW4Luo0Ii/2lI46/4EdKPcjfMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rfqd4581qrcDIQFwOCUczRbjnEamfD0qAPDNh7ywxPYEkzGr0IHt6bfexb9ljc/9q
	 MyvTczyoDYo9Vv477YRNUMTxIkDVtP85Fl6JgqlSt4ZA+xqQS1TyTZ+yY8fUyJYeUw
	 aYfXY/eVdLXi8y0cOJ7WapOBOZBwEuD+RmAanG85dfbC5c2zRuL0A5xhiJ8/Jn7lk9
	 mhJt4Bj0N9fCueY+6bwRogUO6a/OSvleeuQtjFOaLjEBWZ2iPr2Zcs88mzehB3455e
	 on+mixI13SuRqO4kZPOwbBYU25YH+zRDbuCFIUlBJD6Yixn8Cf8oa/9KGFesEFktMJ
	 gTwMzSEbLJlCw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ec267b879so230881366b.2;
        Fri, 13 Dec 2024 04:04:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx6BOd1C5512Gfn2DSfzj5R6DTlJ73My1/nYgimn/Wj33A3/afkKLTgXVdf5jGz4uoH2X41Xg38L1t2BXh@vger.kernel.org, AJvYcCVUzW79Sr1oOXK2ITIGlFmLZ7zq/pIAU+z8CPEjMUkDKBpg0NEND9IkQSSfjWwySJ4kEniAEIyXUNkmsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7tsUSM1V0vErSpOzlNE3rB3JsAuUFkAybvUTj9cTRTtOCtwy
	A8dRSdIUdC4HMswmgIVCSyPH02QG/Re9EyY+01Vrboa8C/W3sta1VbNZqtT1OoV3zM5dP74r9FD
	wtji/IPCzSi2sc3CAgkIRutCGcCA=
X-Google-Smtp-Source: AGHT+IEAc5VTRs/VwLLEfupJwd8Mbf6qXGbxNToLw+JMu2Ex/AKcsct0fgEj0J3Vp2xJp+P3/whyFBcpvDLol+aL7dc=
X-Received: by 2002:a17:907:7f17:b0:aa6:519c:ef9a with SMTP id
 a640c23a62f3a-aab77ead24bmr206389166b.53.1734091485302; Fri, 13 Dec 2024
 04:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
 <20241212-btrfs_need_stripe_tree_update-cleanups-v1-1-d842b6d8d02b@kernel.org>
In-Reply-To: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-1-d842b6d8d02b@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Dec 2024 12:04:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5wOD4fJQ2BTpeqMmscbcS6pV9UN7ThHgi_W6vF4nPrAg@mail.gmail.com>
Message-ID: <CAL3q7H5wOD4fJQ2BTpeqMmscbcS6pV9UN7ThHgi_W6vF4nPrAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: cache stripe tree usage in io_geometry
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:55=E2=80=AFPM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Cache the return of btrfs_need_stripe_tree_update() in struct
> btrfs_io_geometry.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

You can also mention this reduces the object size, since
btrfs_need_stripe_tree_update() is inlined and has quite some logic
there.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
>  fs/btrfs/volumes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1cccaf9c2b0d5d4029440c46a4a92c7d6541d474..fa190f7108545eacf82ef2b5f=
1f3838d56ca683e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -48,6 +48,7 @@ struct btrfs_io_geometry {
>         u64 raid56_full_stripe_start;
>         int max_errors;
>         enum btrfs_map_op op;
> +       bool use_rst;
>  };
>
>  const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] =3D {
> @@ -6346,8 +6347,7 @@ static int set_io_stripe(struct btrfs_fs_info *fs_i=
nfo, u64 logical,
>  {
>         dst->dev =3D map->stripes[io_geom->stripe_index].dev;
>
> -       if (io_geom->op =3D=3D BTRFS_MAP_READ &&
> -           btrfs_need_stripe_tree_update(fs_info, map->type))
> +       if (io_geom->op =3D=3D BTRFS_MAP_READ && io_geom->use_rst)
>                 return btrfs_get_raid_extent_offset(fs_info, logical, len=
gth,
>                                                     map->type,
>                                                     io_geom->stripe_index=
, dst);
> @@ -6579,6 +6579,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>         io_geom.raid56_full_stripe_start =3D (u64)-1;
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>         *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
> +       io_geom.use_rst =3D btrfs_need_stripe_tree_update(fs_info, map->t=
ype);
>
>         if (dev_replace->replace_task !=3D current)
>                 down_read(&dev_replace->rwsem);
>
> --
> 2.43.0
>
>

