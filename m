Return-Path: <linux-btrfs+bounces-10489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E09F50A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D036A1886463
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6D1F75BE;
	Tue, 17 Dec 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJB5ezCW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D41F4E50
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451589; cv=none; b=UihrYjZifdXwGTSRqa81uKvvg3c9k0kxjhj0QToHbtHVlZQ60cpZn3/vUVbPoMIt2TYJYZQBPNi3KtA+TTo4bM85tGpSIV4G9vbUr9bGd/3Y9hsN0Xpqdc84by0tlvid4YfVWvUJhNh+wBATuRzaDWd6WbPHtO2rVvbUWrw1oGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451589; c=relaxed/simple;
	bh=5obMox9EtmUwiPYyiQlZT4IGGtZsOl34BSf0dLIOKmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4SrH7oy5giXk90yZqWq9sDvhXEoL+CFuAA8xj4bkgFio9Bx5LkBRdOtmtEsPtijDf8XxogP9koTzRmR2Uoy7wHggCj0uzZ31wlSBiM71q6JT9OxGxkVf5jx9R7wTQ+9SRnIlmIvjnCrSoAO1O5LctwTpphLJgJ5uHFCgju0neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJB5ezCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FA4C4CED6
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451589;
	bh=5obMox9EtmUwiPYyiQlZT4IGGtZsOl34BSf0dLIOKmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iJB5ezCWw0xqwlk4eXqFMZhLVMHr/1h5zzzKAKOSwVZxkjR7FtloCGRM/1krmT22l
	 mS+XA/nCcakX2TWDrKZzih83sT2nS5oJ4qzKIXzNS8j2A1YdUVr2Rqv4OjZUQJpotp
	 fjQhmv9gVQ2kyRlJ1OTsFvxLrjkoItQYxOuzbRil/6esmJpOknH4YPd6PjkWqLPYME
	 SP2H56OJChdbVvo/UiVGp/Mbw8CNmiJausZwBj27mbIbQ27mCmgywWfevOLte062rx
	 UV1a0kK96Air5anqDyszBYg7Z8nhcA2K8rSJgJ5+N43ENgIej8o2RBxxP9j+yfA6xX
	 5nqsNYQCgBxkw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1109099466b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:06:29 -0800 (PST)
X-Gm-Message-State: AOJu0YzDoOMlNCT8qggdukSligos2PwyoAL2eZL2p9jOU3eHZ5pQcXeI
	7SXYH6cGrVLQukwuq+mjb1GZHqKDeykRPOGANq5Fzc3UB/PHGr6/uu7mng3hA/og9vtzj2Rss5j
	nrrCbl8weVljLjwLF4x07cCj76H4=
X-Google-Smtp-Source: AGHT+IFPskmknFNCu8zseDeCcZFPWlAlr0Esu1J7kSufYubPRnChLT8Td0KtWTAkDrJ4Dc1SDx8JfWO5aF4hlIdg1v0=
X-Received: by 2002:a17:906:3c49:b0:aab:ee4a:6788 with SMTP id
 a640c23a62f3a-aabee4a68a6mr77126166b.57.1734451588277; Tue, 17 Dec 2024
 08:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <038e3971d12f2f8aef69a96c999916f37165f12b.1733989299.git.jth@kernel.org>
In-Reply-To: <038e3971d12f2f8aef69a96c999916f37165f12b.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:05:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7a_6fGhMwUvN7YOCKTq2JOncX9-qo4PJw4jPP=CEvHvw@mail.gmail.com>
Message-ID: <CAL3q7H7a_6fGhMwUvN7YOCKTq2JOncX9-qo4PJw4jPP=CEvHvw@mail.gmail.com>
Subject: Re: [PATCH 07/14] btrfs: implement hole punching for RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:56=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
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
> ---
>  fs/btrfs/ctree.c            |  1 +
>  fs/btrfs/raid-stripe-tree.c | 54 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 693dc27ffb89..5682692b5ba5 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3903,6 +3903,7 @@ static noinline int setup_leaf_for_split(struct btr=
fs_trans_handle *trans,
>         btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>
>         BUG_ON(key.type !=3D BTRFS_EXTENT_DATA_KEY &&
> +              key.type !=3D BTRFS_RAID_STRIPE_KEY &&
>                key.type !=3D BTRFS_EXTENT_CSUM_KEY);
>
>         if (btrfs_leaf_free_space(leaf) >=3D ins_len)
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index ccf455b30314..6ec72732c4ad 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -138,6 +138,60 @@ int btrfs_delete_raid_extent(struct btrfs_trans_hand=
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
_size);
> +                            i++) {

We can place this in a single line, nowadays we tolerate more than 80
characters, anything up to 90 is fine.
It makes things more readable.

> +                               struct btrfs_raid_stride *stride =3D
> +                                       &extent->strides[i];

Same here.

> +                               u64 phys;
> +
> +                               phys =3D btrfs_raid_stride_physical(leaf,=
 stride);
> +                               phys +=3D diff_start + length;
> +                               btrfs_set_raid_stride_physical(leaf, stri=
de,
> +                                                              phys);

Same here.
> +                       }
> +                       btrfs_mark_buffer_dirty(trans, leaf);

Not needed, already done down the call chain of btrfs_duplicate_item().

> +
> +                       /* "left" item */
> +                       path->slots[0]--;
> +                       btrfs_item_key_to_cpu(leaf, &key, path->slots[0])=
;
> +                       btrfs_partially_delete_raid_extent(trans, path, &=
key,
> +                                                          diff_start, 0)=
;
> +                       length =3D 0;
> +                       break;

There's the 'break', no need to assign 0 to the length as it's not
used anymore after breaking out of the loop.

Otherwise it looks good, thanks.

> +               }
> +
>                 /*
>                  * The stripe extent starts before the range we want to d=
elete:
>                  *
> --
> 2.43.0
>
>

