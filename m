Return-Path: <linux-btrfs+bounces-10868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE6A07C10
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D2D3A5464
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D521D004;
	Thu,  9 Jan 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNdY7Ewz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E2249E5;
	Thu,  9 Jan 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436785; cv=none; b=lbyEOEnFemqgU6miIEKmUxysqYeI036doGk+JysGTfWlBlH7/fDHqnWWGJj4pFldvbOE1PqG4pE9ox9gdWaMkd9xQraa8XAK+biX32rURkqmQTmOulU2osUQBGMoq66sf90fjA+49piwChDmNr3kqua7O8Hd/qkWBhGLQH5PZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436785; c=relaxed/simple;
	bh=BiuL/aasHnfCNHBUk66AaDVdfvMq8j836rodmaIN9n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI4OC0VxtzCRhV5knU1p+TR6m9AX9v589h3ZD4YPDKwWU8qmIKxkkVGN8oHOYhEQWcxU1WnHOV6vADQ3aYz91OGNjcG0ccHZUyNszYtmNu3/KwPTHm+lIVTbvDYXrYvsjDH15kRA+7n5ixkKgJgJV17QO9fWXVbV7vUbvJNGutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNdY7Ewz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25343C4CED2;
	Thu,  9 Jan 2025 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436785;
	bh=BiuL/aasHnfCNHBUk66AaDVdfvMq8j836rodmaIN9n8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iNdY7EwzsI2QBKZFveTi2yIARRJHLgjT+mQSlCMp0X/3X41AG2AlqGuOWuPysBexq
	 DhdDKYl+pPG5V1StaUYs9I0bkeSOoqZM7A0XpNXlxv9fFfeEE9GD5dDBKCIw6KVjOi
	 YFcSRpQuyoIhMpF/nc+sGqkR2FpaGfD59Wm/bslgqLOi44oKMLVUMFRpCl/8NzNV9J
	 u7ZQ/9X1eGwKWCfP39gAdVGt5eUbTpWArkQeguoSyQxoi2aJGgyU+mhMMQzea/XtjX
	 GYnK9FddSByOzNcK/6MSh4kJYrRMmNlMSTxZ0d2CqfE71kFCZ7qwg5IjiLb+7ABe9y
	 zG6ZxutGdxmPA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso1305298a12.2;
        Thu, 09 Jan 2025 07:33:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWdU2ekxvw3A2VL0fL5X+qoY3SYWiMQt50KI1hiTrT4lc5oTNZwI18Wo5DL3HAizMdCToMVLvPzbJjUA==@vger.kernel.org, AJvYcCWfx/svjKXPDpi4Bg7+8OgWKm+eVNLF2B+1VXNJQFRMu4FEfVs28zueCw0RjJnPtYZ+HmHXX6Q8hzvir/g/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rAhdAtL3WQXPbd5BWMVoX8HdlnCuf/J1TrLBv0tRL7AVs2+B
	InqHdqkjemFfPlHCCN3jOqPGIVdnoCQEX6Z82qvoo01OTyB1yOETo3cLLotLqJm8Rslyuo3nU+w
	QdzCtUBE71lRwKCBcVesXK/2uIiA=
X-Google-Smtp-Source: AGHT+IEDBwaL2KKMsMmTtXmcAS+9UjUqdQ8MW5f0fJULnD0ZpkXtMI1JPCGB7lIuv+YF3UO20AKIz4cQ9+DcY3P+MtY=
X-Received: by 2002:a17:907:3f89:b0:aac:501:5629 with SMTP id
 a640c23a62f3a-ab2abc95256mr610863966b.56.1736436783623; Thu, 09 Jan 2025
 07:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-7-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-7-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 15:32:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5arrRQJvGPVJzfTsmfX6+xDMemM11sg6Y=aPnXLkCJKQ@mail.gmail.com>
X-Gm-Features: AbW1kvbyF7sW7tZn1Xt4YIPAVVjz-Aue3vki3r_qCJ57kEzBmcc63uTTy6QoHpM
Message-ID: <CAL3q7H5arrRQJvGPVJzfTsmfX6+xDMemM11sg6Y=aPnXLkCJKQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] btrfs: implement hole punching for RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:59=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> If the stripe extent we want to delete starts before the range we want to
> delete and ends after the range we want to delete we're punching a
> hole in the stripe extent:
>
>   |--- RAID Stripe Extent ---|
>   | keep |--- drop ---| keep |
>
> This means we need to a) truncate the existing item and b)
> create a second item for the remaining range.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c            |  1 +
>  fs/btrfs/raid-stripe-tree.c | 49 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index c93f52a30a16028470594de1d1256dbec5c7899c..92071ca0655f0f1920eb841e7=
7d3444a0e0d8834 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3833,6 +3833,7 @@ static noinline int setup_leaf_for_split(struct btr=
fs_trans_handle *trans,
>         btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>
>         BUG_ON(key.type !=3D BTRFS_EXTENT_DATA_KEY &&
> +              key.type !=3D BTRFS_RAID_STRIPE_KEY &&
>                key.type !=3D BTRFS_EXTENT_CSUM_KEY);
>
>         if (btrfs_leaf_free_space(leaf) >=3D ins_len)
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 893d963951315abfc734e1ca232b3087b7889431..d15df49c61a86a4188b822b05=
453428e444920b5 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -138,6 +138,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_hand=
le *trans, u64 start, u64 le
>                 trace_btrfs_raid_extent_delete(fs_info, start, end,
>                                                found_start, found_end);
>
> +               /*
> +                * The stripe extent starts before the range we want to d=
elete
> +                * and ends after the range we want to delete, i.e. we're
> +                * punching a hole in the stripe extent:
> +                *
> +                *  |--- RAID Stripe Extent ---|
> +                *  | keep |--- drop ---| keep |
> +                *
> +                * This means we need to a) truncate the existing item an=
d b)
> +                * create a second item for the remaining range.
> +                */
> +               if (found_start < start && found_end > end) {
> +                       size_t item_size;
> +                       u64 diff_start =3D start - found_start;
> +                       u64 diff_end =3D found_end - end;
> +                       struct btrfs_stripe_extent *extent;
> +                       struct btrfs_key newkey =3D {
> +                               .objectid =3D end,
> +                               .type =3D BTRFS_RAID_STRIPE_KEY,
> +                               .offset =3D diff_end,
> +                       };
> +
> +                       /* "right" item */
> +                       ret =3D btrfs_duplicate_item(trans, stripe_root, =
path,
> +                                                  &newkey);
> +                       if (ret)
> +                               break;
> +
> +                       item_size =3D btrfs_item_size(leaf, path->slots[0=
]);
> +                       extent =3D btrfs_item_ptr(leaf, path->slots[0],
> +                                               struct btrfs_stripe_exten=
t);
> +
> +                       for (int i =3D 0; i < btrfs_num_raid_stripes(item=
_size); i++) {
> +                               struct btrfs_raid_stride *stride =3D &ext=
ent->strides[i];
> +                               u64 phys;
> +
> +                               phys =3D btrfs_raid_stride_physical(leaf,=
 stride);
> +                               phys +=3D diff_start + length;
> +                               btrfs_set_raid_stride_physical(leaf, stri=
de, phys);
> +                       }
> +
> +                       /* "left" item */
> +                       path->slots[0]--;
> +                       btrfs_item_key_to_cpu(leaf, &key, path->slots[0])=
;
> +                       btrfs_partially_delete_raid_extent(trans, path, &=
key,
> +                                                          diff_start, 0)=
;
> +                       break;
> +               }
> +
>                 /*
>                  * The stripe extent starts before the range we want to d=
elete:
>                  *
>
> --
> 2.43.0
>
>

