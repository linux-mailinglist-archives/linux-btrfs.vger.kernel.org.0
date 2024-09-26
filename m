Return-Path: <linux-btrfs+bounces-8255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B031398727A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 13:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751F82863DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644111AD412;
	Thu, 26 Sep 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBg49vCq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5951AC89C;
	Thu, 26 Sep 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348956; cv=none; b=awvV9f3oMjK4+t22TyGEWLeCpdjZB3BjXwA/AQHjXASbhmXjzRUwyEx8fagfzUmuY+vH8kPnibXQOtzwkywcBn9GEtlaUvsY1X7IV0pVu5zeStZRgCGAIthI4dcfX9HhEkJO7Ul0Ej6ZD1dUKfne3vxOTuhqKgRgV/Vh6NZRLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348956; c=relaxed/simple;
	bh=MHsThCsnX5L3ixiV0HnAl0jd8z+ktstNxSlvb6X77j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+mXP7GZYv2ZOSIPaTOZwIHpyRVOxAlwkPQH3stnEiI1mnQesAl6fYoronsJq4GfHIsO74BRx9svaF6ygy5JY7qUVdE3li1OSrpvdWhy5Ot8+o8JZmvxD3zeEyZAaydQiZASZmlzfwqCKSB9+Td5EEZ9PfHnxSLY2JfIGa+rRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBg49vCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1481BC4CECF;
	Thu, 26 Sep 2024 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727348956;
	bh=MHsThCsnX5L3ixiV0HnAl0jd8z+ktstNxSlvb6X77j0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WBg49vCqcraWcjVvyXEkCrGJv6elwuQ0UOGhkH5s8NNMtEY8FotlJfq6fAwGgqiPp
	 R2WgNSzg+xSMAXUHXo6UfTNQKRVXJ7jPh+fbtJ6DauT2i9UvfG+DBnXbWRRANMLHFh
	 0/eoglRimy4sn9anghBD+QixHeMd4oH1JF5HD5XiATmVx/2t2qjPXdoR2BRsGbHaMG
	 o0fQ9RJ4mB+nt4OW+ZY9OC52LoB5AQLTq+vG04KWbbkhnR/BH4XLKXZUsd38GuHeg/
	 S8dCt6m68ZS1ED6yF4D+l4UZx6EBwFWWeL2lIUWaBx9hDjO6kl95jMF+LwI4qHYJTe
	 tQ/lCCVBVBMDw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8ce5db8668so136330866b.1;
        Thu, 26 Sep 2024 04:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUreTfHH7fMFdodQ7gfVdtcjR3qKU7djFdQYJJ5MPtoO3JMGLju9zi502zkqDdKiYPFBR44qaQ9ErjkZw==@vger.kernel.org, AJvYcCX4UfaCZ8ezFoqHRlxBXIN8HJAUTnnO2hkiKi5lAee/jjVR1hPG4U6ji77tYQ8Vr9rRI2JNFJTsdxxPPBJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiQE5s8fr4SpHFLo25Q/2PA6sXj41PpPMueo/JlVu2o6HeZqA
	4Dg779hQHvucfdagCzHsqvPKXgGza/ErUBRhsWsajDxf7aDBh8Hdsb4qxEyo+bfUkKgApwePUh9
	pa9Y94Kp1Mgv2CTTnpexlY0VWQsw=
X-Google-Smtp-Source: AGHT+IEXMsckiPWMadbJQ/gZ8OMPjfY51C+L/yYNlc5nVAAxQcnTuDz531kU3IMrQK5m7jy59z5Rx4YyQcSHM6e/xy4=
X-Received: by 2002:a17:907:3f89:b0:a8d:1655:a423 with SMTP id
 a640c23a62f3a-a93a06a03b5mr587603266b.56.1727348954464; Thu, 26 Sep 2024
 04:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911095206.31060-1-jth@kernel.org>
In-Reply-To: <20240911095206.31060-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 12:08:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6J6QjO5UevdVPpRpyXnkZ92HoAA_wckE4F-Cn7zciHSw@mail.gmail.com>
Message-ID: <CAL3q7H6J6QjO5UevdVPpRpyXnkZ92HoAA_wckE4F-Cn7zciHSw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: stripe-tree: correctly truncate stripe extents
 on delete
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:52=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> In our CI system, we're seeing the following ASSERT()ion to trigger when
> running RAID stripe-tree tests on non-zoned devices:
>
>  assertion failed: found_start >=3D start && found_end <=3D end, in fs/bt=
rfs/raid-stripe-tree.c:64
>
> This ASSERT()ion triggers, because for the initial design of RAID stripe-=
tree,
> I had the "one ordered-extent equals one bio" rule of zoned btrfs in mind=
.
>
> But for a RAID stripe-tree based system, that is not hosted on a zoned
> storage device, but on a regular device this rule doesn't apply.
>
> So in case the range we want to delete starts in the middle of the
> previous item, grab the item and "truncate" it's length. That is, subtrac=
t
> the deleted portion from the key's offset.
>
> In case the range to delete ends in the middle of an item, we have to
> adjust both the item's key as well as the stripe extents.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>
> Changes to v1:
> - ASSERT() that slot > 0 before calling btrfs_previous_item()
>
>  fs/btrfs/raid-stripe-tree.c | 52 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 4c859b550f6c..075fecd08d87 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -61,7 +61,57 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle=
 *trans, u64 start, u64 le
>                 trace_btrfs_raid_extent_delete(fs_info, start, end,
>                                                found_start, found_end);
>
> -               ASSERT(found_start >=3D start && found_end <=3D end);

I was looking at this in for-next, and several questions popped in my
mind, see below.

> +               if (found_start < start) {
> +                       struct btrfs_key prev;
> +                       u64 diff =3D start - found_start;
> +
> +                       ASSERT(slot > 0);
> +
> +                       ret =3D btrfs_previous_item(stripe_root, path, st=
art,
> +                                                 BTRFS_RAID_STRIPE_KEY);

This doesn't do anything, we ignore the return value and then the
"continue" below makes us go to the start of the loop and do a
btrfs_search_slot(), without using the leaf (see below as well).

> +                       leaf =3D path->nodes[0];
> +                       slot =3D path->slots[0];
> +                       btrfs_item_key_to_cpu(leaf, &prev, slot);
> +                       prev.offset -=3D diff;

Why do we decrement prom prev.offset?
It's a local variable and then we don't use it anymore.

I.e. these 4 lines can be removed.

> +
> +                       btrfs_mark_buffer_dirty(trans, leaf);

Why do we mark the leaf as dirty?
We haven't changed it

> +
> +                       start +=3D diff;
> +                       length -=3D diff;
> +
> +                       btrfs_release_path(path);

We don't use the path for anything, we extract the key, don't do
anything with it and then release the path.

Or did I miss something?

Thanks.

> +                       continue;
> +               }
> +
> +               if (end < found_end && found_end - end < key.offset) {
> +                       struct btrfs_stripe_extent *stripe_extent;
> +                       u64 diff =3D key.offset - length;
> +                       int num_stripes;
> +
> +                       num_stripes =3D btrfs_num_raid_stripes(
> +                               btrfs_item_size(leaf, slot));
> +                       stripe_extent =3D btrfs_item_ptr(
> +                               leaf, slot, struct btrfs_stripe_extent);
> +
> +                       for (int i =3D 0; i < num_stripes; i++) {
> +                               struct btrfs_raid_stride *stride =3D
> +                                       &stripe_extent->strides[i];
> +                               u64 physical =3D btrfs_raid_stride_physic=
al(
> +                                       leaf, stride);
> +
> +                               physical +=3D diff;
> +                               btrfs_set_raid_stride_physical(leaf, stri=
de,
> +                                                              physical);
> +                       }
> +
> +                       key.objectid +=3D diff;
> +                       key.offset -=3D diff;
> +
> +                       btrfs_mark_buffer_dirty(trans, leaf);
> +                       btrfs_release_path(path);
> +                       break;
> +               }
> +
>                 ret =3D btrfs_del_item(trans, stripe_root, path);
>                 if (ret)
>                         break;
> --
> 2.43.0
>
>

