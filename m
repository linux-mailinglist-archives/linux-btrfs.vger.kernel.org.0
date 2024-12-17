Return-Path: <linux-btrfs+bounces-10488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C89F5095
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0AB164324
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA401FE44F;
	Tue, 17 Dec 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U52k0PMH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042081FDE3D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451140; cv=none; b=t9tFyzKi8nA5b4cZhVlt4eVCvUnskXe3/H5Cbf/yBVYW45Al+BWYE2BqYNqHxKws+hbGmDhRNltB2UVC9XdHTwl51AtbfdT0LDbezmf2BOQBzwHhdMmS/DmJodK5FKQ6oQXCn0rPCaGZTpCJGL32m7SGFBnofgf5jBcMdJSRm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451140; c=relaxed/simple;
	bh=og29nDBatCqNQqP3kkuVgGATvZXHtB93GW+771VuVVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/8YK/0WNcT3sn5fEW8doF4OXMO02jPLuj2VUNCBMz8+z73fCzmNeO/yJz3u7JZ47pEVWDl873Tk6EEjfnbbw+wgwrluXkfhJR7WtpuSMBkJh4Kt8kkAspqbwPkQ3hjjdz+fGxZzpqKbGkMu+I2H0/O6VyQimN8UMKuh09tn3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U52k0PMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D3C4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451139;
	bh=og29nDBatCqNQqP3kkuVgGATvZXHtB93GW+771VuVVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U52k0PMHQ42IXyNIG65xrnppuzVz0N3ahRkXcRi2+en9aJVej3MprigtApz4d7fNX
	 lwKljHW5E55wWpiP6eAthf8bYT3SPc4GqivD6MwgrJuXpDfdZYard5e/5yNUinUnwm
	 iLYnPxPYN81HQ1Swdmc2LDqiWyUA1JA3LyUujNTAxcZZUIChTRI6x6AoY94BCwEMfh
	 HwGnnxdB0HJH/jzdwd1wEhSWwOt/LMWvX4SdIJV7ezPXiJl/dMdFuuouCQyduLXZy1
	 cw5f0SAP4aF/fc1O6UFWah2xNR8QgRcjdOJqZrZTJSX6KwFSrbmX67mBtuypkkFh5m
	 gTm3JYARCjhZA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6a618981eso888365166b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:58:59 -0800 (PST)
X-Gm-Message-State: AOJu0Ywltrr5wUm/azwRKIMg3q0WHu4zmRujgefUFmCHKmj0sBSTyBvb
	iDxn6xv8M636xe0PyJNIUdNd7QCDZAp4Jl10esGikBXaFg+AjQIiepbzwCRJX4nl9gSIYM80Of+
	shhg0KfGziaNTf1J4R5TVb5tvgGo=
X-Google-Smtp-Source: AGHT+IEnE4AAy3Jhh5v9QBgDXdD0c8H+elcKXXz9AYuf6LKBbA9ptTB+SiYgUS+hP0EqHNgzZVL8mOFxQCm8yXF1ytc=
X-Received: by 2002:a17:907:3f14:b0:a99:f6ee:1ee3 with SMTP id
 a640c23a62f3a-aab77e7b564mr1769972366b.43.1734451137997; Tue, 17 Dec 2024
 07:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <73a3c0f290dc84b8b802c8705503370d8cb62bc8.1733989299.git.jth@kernel.org>
In-Reply-To: <73a3c0f290dc84b8b802c8705503370d8cb62bc8.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 15:58:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7SfU-UAf+bNrSEx1Ca8qwTbJ+P_Z5FTTxYi=sydzf=qw@mail.gmail.com>
Message-ID: <CAL3q7H7SfU-UAf+bNrSEx1Ca8qwTbJ+P_Z5FTTxYi=sydzf=qw@mail.gmail.com>
Subject: Re: [PATCH 06/14] btrfs: fix deletion of a range spanning parts two
 RAID stripe extents
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
> When a user requests the deletion of a range that spans multiple stripe
> extents and btrfs_search_slot() returns us the second RAID stripe extent,
> we need to pick the previous item and truncate it, if there's still a
> range to delete left, move on to the next item.
>
> The following diagram illustrates the operation:
>
>  |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
>         |--- keep  ---|--- drop ---|
>
> While at it, comment the trivial case of a whole item delete as well.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 6246ab4c1a21..ccf455b30314 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -101,6 +101,33 @@ int btrfs_delete_raid_extent(struct btrfs_trans_hand=
le *trans, u64 start, u64 le
>                 found_end =3D found_start + key.offset;
>                 ret =3D 0;
>
> +               /*
> +                * The stripe extent starts before the range we want to d=
elete,
> +                * but the range spans more than one stripe extent:
> +                *
> +                * |--- RAID Stripe Extent ---||--- RAID Stripe Extent --=
-|
> +                *        |--- keep  ---|--- drop ---|
> +                *
> +                * This means we have to get the previous item, truncate =
its
> +                * length and then restart the search.
> +                */
> +               if (found_start > start) {
> +                       if (slot =3D=3D 0)
> +                               break;

Why?
The last item on the previous leaf may be the first stripe extent in
the diagram, it may partially cover the range we want to delete.
Or there may be no previous item at all with a range that partially
overlaps but the current item partially overlaps, so we shouldn't
break and stop - we should process the current item.

Remember that btrfs_previous_items() goes to the previous leaf in case
the current slot is 0.

Thanks.

> +
> +                       ret =3D btrfs_previous_item(stripe_root, path, st=
art,
> +                                                 BTRFS_RAID_STRIPE_KEY);
> +                       if (ret < 0)
> +                               break;
> +                       ret =3D 0;
> +
> +                       leaf =3D path->nodes[0];
> +                       slot =3D path->slots[0];
> +                       btrfs_item_key_to_cpu(leaf, &key, slot);
> +                       found_start =3D key.objectid;
> +                       found_end =3D found_start + key.offset;
> +               }
> +
>                 if (key.type !=3D BTRFS_RAID_STRIPE_KEY)
>                         break;
>
> @@ -155,6 +182,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>                         break;
>                 }
>
> +               /*
> +                * Finally we can delete the whole item, no more special =
cases.
> +                */
>                 ret =3D btrfs_del_item(trans, stripe_root, path);
>                 if (ret)
>                         break;
> --
> 2.43.0
>
>

