Return-Path: <linux-btrfs+bounces-10347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BE9F0BCF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD954282BED
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F61DF728;
	Fri, 13 Dec 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj8VUVJ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBE2F43;
	Fri, 13 Dec 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091331; cv=none; b=qyHSGKodSFS1/V66CPifyzjCNb3o7I8ENWkD79l0NFErFll5wGCP3duRZalv5/qQEeGlQMI21egeXpyJuGkgIy9VMaoL9gwd/KIjm0seriz/68Cid9Fs+bJwF3uk+/cIhvgoUhEpiOc+EeNVds1z3TvLeYZD9rUL5QSGTBTvlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091331; c=relaxed/simple;
	bh=az4GPp6xvC23EpE7U8RzOeKh5Dy4c21F4RX5zPylDxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5noW0DWwFXP74zw6SWGdIzPGHU5xVr14kUc5xa3QobT4VJN/5ISY8dvLSLHYEd5m0BDZnMj7A/M/3r2T00xRUHLtu6oBq/UsfPMtiSiXuWeL3LBApxtJLKyO8DQx4L3tk+T2z37t8Q8+oQaySt5LdLlNKHODtdWzGRsN8VUAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj8VUVJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB30C4CEDD;
	Fri, 13 Dec 2024 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734091329;
	bh=az4GPp6xvC23EpE7U8RzOeKh5Dy4c21F4RX5zPylDxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yj8VUVJ2MQ6yZhBeQjVriJ5EcZxJiSaOtZ3rQlzaFhLMr4odU1QulnneuaOKj1j/9
	 JeXSI/SnP0kE5Bt0Kc0HIn+vQZ7Y7WwMfFnvmpjNWdaRNRtr0SlklU/hEaB6Hb5Qnz
	 Je6d2DPFuB9aov+u0egvPcBa8A8YlR7+Ui45rBSULo0WsGo3lWfxIT+infDnCa7auc
	 8ahNctIFeFJ6OwXteWvmTh8VbWsY55jEf9ltSWOSoK0St5F/YxUrvxyaqm4DUIONgZ
	 TwtzbNgUMzPBb1aUkHcY1ZJtZsBuCi9LNco0gouRh+DlxU658e3kt/arvlPrzVGC8p
	 V9Fo2as3cebPw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so338274766b.0;
        Fri, 13 Dec 2024 04:02:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7455x9a51PGDeYoTRBvNtyZPl0rHP30/fJEnPrFGXZomk/+4RNdFeRsx4Au5DUEQZL5IPwWNCZSFVaO5s@vger.kernel.org, AJvYcCUTxnGt5pdzH66cMkVnd4/4UJWqx6jw9QLCF5ThQ3aVlI3EZFsugfRN8kYgb0Wx7vC2ccyd9Nw/Jh2zxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDmn5G9dibzoQ5rJNC+djl7TsK25S9U0kOAoZOZbpeLlF9D9Z
	mTGfPpb7dVkUFF8liG4dpNg22njgfD6qHyUcr/e/a90mqBZbA0wT6k+K5aqTyWMHoHXeASrIT4m
	nv3DkhaV7vZHfJowv6BOV36iaAp8=
X-Google-Smtp-Source: AGHT+IE590SvZFni5wi9V0YJXvJzj+4Q6UkW0OPLK50tM7BnVFLWiiIzWug5JnRCPdlgkxndaPZKR7PMICX/GJU8R+4=
X-Received: by 2002:a17:907:72cb:b0:aa6:af4b:7c88 with SMTP id
 a640c23a62f3a-aab77ec58cdmr274161666b.57.1734091327850; Fri, 13 Dec 2024
 04:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
 <20241212-btrfs_need_stripe_tree_update-cleanups-v1-2-d842b6d8d02b@kernel.org>
In-Reply-To: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-2-d842b6d8d02b@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Dec 2024 12:01:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4XY7FBMHUUBjjStZCfwvR=ZWTGsZ-xnPdmagaF6HJ+bw@mail.gmail.com>
Message-ID: <CAL3q7H4XY7FBMHUUBjjStZCfwvR=ZWTGsZ-xnPdmagaF6HJ+bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: cache RAID stripe tree decission in btrfs_io_context
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
> Cache the decission if a particular I/O needs to update RAID stripe tree

decission -> decision

The subject also has this typo.

> entries in struct btrfs_io_context.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/bio.c     | 3 +--
>  fs/btrfs/volumes.c | 1 +
>  fs/btrfs/volumes.h | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 7ea6f0b43b95072b380172dc16e3c0de208a952b..bc80ee4f95a5a8de05f2664f6=
8ac4fcb62864d7b 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -725,8 +725,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio=
, int mirror_num)
>                         bio->bi_opf |=3D REQ_OP_ZONE_APPEND;
>                 }
>
> -               if (is_data_bbio(bbio) && bioc &&
> -                   btrfs_need_stripe_tree_update(bioc->fs_info, bioc->ma=
p_type)) {
> +               if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
>                         /*
>                          * No locking for the list update, as we only add=
 to
>                          * the list in the I/O submission path, and list
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa190f7108545eacf82ef2b5f1f3838d56ca683e..088ba0499e184c93a402a3f92=
167cccfa33eec58 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6663,6 +6663,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                 goto out;
>         }
>         bioc->map_type =3D map->type;
> +       bioc->use_rst =3D io_geom.use_rst;
>
>         /*
>          * For RAID56 full map, we need to make sure the stripes[] follow=
s the
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 3a416b1bc24cb0735c783de90fb7490d795d7d96..0a00ee36f66b6d6831c43abda=
4a791684c11ea02 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -490,6 +490,8 @@ struct btrfs_io_context {
>         u64 size;
>         /* Raid stripe tree ordered entry. */
>         struct list_head rst_ordered_entry;
> +       /* This I/O operation uses the RAID stripe tree */

The comment seems kind of pointless as the variable name makes it
clear what the purpose is.
In the previous patch there's no comment about the new field in the
btrfs_io_geometry structure, which is fine, so I don't see why it's
needed here.

Also, for style consistency we should finish the sentence with punctuation.

> +       bool use_rst;

This increases the structure size from 88 bytes to 96 bytes on a
release kernel for x86_64.

As we can have many of these structures allocated at any given time,
it would be better to avoid increasing the size.
One way is to place the field in a hole such as right after the
'max_errors' field, so that the size of the structure doesn't change.

Thanks.

>
>         /*
>          * The total number of stripes, including the extra duplicated
>
> --
> 2.43.0
>
>

