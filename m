Return-Path: <linux-btrfs+bounces-9075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB799AB250
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47681C221A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1C51A08DB;
	Tue, 22 Oct 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOs0qJGu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3D2E406
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611737; cv=none; b=u2f4t7u6HPAcxczUSYigo53VntVGpIB4Aj2V3Xv2gMMXuZK1uNOwgE2LaFbYz5gezH7wJCWvGgXnsuKRrldl/VkS5N49KvxsVW9cixaYvaNiBVV1m8LJc0qpPBe7uPt6nIcPGdVNI9N/nE+P/TlHSI4PonubQYZif+RWADF7Hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611737; c=relaxed/simple;
	bh=jRml7AzyD0psi9rGyY9OYl6vhpA9+ZQnop/pVG+TI5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etX/zks4kBVisVVPpPbi4uWMTI130Y6riamI/+UKoM7HVDH3cFf5yKnnRTvClJq0px8K+ilGNP1aHUVEpzNN6Ls5hRbTRJj7jgZod+Nkw289d7FKatOVN9PxifNyEdirE9VBhQKAfjQj1867i0/S9QOGsj6tTiKHshCJHDgnG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOs0qJGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6035C4CEC3
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611736;
	bh=jRml7AzyD0psi9rGyY9OYl6vhpA9+ZQnop/pVG+TI5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOs0qJGumpZIFDfPqNMEIpiwZdkRjQmQxA3IaiGHzaEaTm7Qoa8CjqwgYa9Gfn0CQ
	 vitR8XO3fU1RugUcrqtvWhUK0fpQWwuqowjNVc+QZ0H/mTxwQ1T5Q4sI5MNgm/j44K
	 1hruO5UaKsDqjjHk8hJi6szZaWvXa1Fpo4fgaBpwtWefTOq99qv5PqjIm1oQfOSgmo
	 Wa27JWZXibOPNLpN5GZKBVhRbReCRmW+/68VR0i4Jm48Nd1RlNz5B+YahaCqrXJCxx
	 MHg4TGx7csS2qAEREXeqQ7hrwHYBBNSgcFuiPM7ONsM3cC3CV1ufyaN8x8c7ckeMGV
	 Fcl1nkAVp9l9g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a628b68a7so753776266b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 08:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVih11XXn/nv5IesX56CVuufQuX/BUInwJCrqp/ic8kT8kFgUoEmcx9Agku9+7FdudFqZGXa1yTiqXfnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmxhrxhzID9Cj+b0Env8Xp0/jLRqYimDQPuS8Moh7oMnC56cR
	/0oAx4yzrYxi57JQ53VFIGrN08OEip2PKuOWyuJyFqoeAmkQqX3hbAPbqutqNWgJwknAHa1TQDo
	pfgLjrPMAL/It7IQDbPfAuvLuA3U=
X-Google-Smtp-Source: AGHT+IE5CbzklnKLv/pLc8+5+Se/MOOaeYrs9WY6TdQXP+6LjRyPfgrF5Qf0fXt2HqZ3TzIachv5iuGl5caX8ZX3Tak=
X-Received: by 2002:a17:907:72c1:b0:a99:8a5c:a357 with SMTP id
 a640c23a62f3a-a9a69ca4b7bmr1683433366b.58.1729611735392; Tue, 22 Oct 2024
 08:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017090411.25336-1-jth@kernel.org> <20241017090411.25336-2-jth@kernel.org>
 <CAL3q7H45VMP=NeU7itO4M-T4m0kA9XYEsTkLttODy5W4_m5OLw@mail.gmail.com> <0e990104-19c5-4695-bbdb-4dbceba80490@wdc.com>
In-Reply-To: <0e990104-19c5-4695-bbdb-4dbceba80490@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Oct 2024 16:41:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5VdtA193w6YP5vbSO_TM8tw58xqFrUYbbP4sZBsuOpfA@mail.gmail.com>
Message-ID: <CAL3q7H5VdtA193w6YP5vbSO_TM8tw58xqFrUYbbP4sZBsuOpfA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] btrfs: implement partial deletion of RAID stripe extents
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 4:37=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 22.10.24 15:53, Filipe Manana wrote:
> > On Thu, Oct 17, 2024 at 10:04=E2=80=AFAM Johannes Thumshirn <jth@kernel=
.org> wrote:
> >>
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> In our CI system, the RAID stripe tree configuration sometimes fails w=
ith
> >> the following ASSERT():
> >>
> >>   assertion failed: found_start >=3D start && found_end <=3D end, in f=
s/btrfs/raid-stripe-tree.c:64
> >>
> >> This ASSERT()ion triggers, because for the initial design of RAID
> >> stripe-tree, I had the "one ordered-extent equals one bio" rule of zon=
ed
> >> btrfs in mind.
> >>
> >> But for a RAID stripe-tree based system, that is not hosted on a zoned
> >> storage device, but on a regular device this rule doesn't apply.
> >>
> >> So in case the range we want to delete starts in the middle of the
> >> previous item, grab the item and "truncate" it's length. That is, clon=
e
> >> the item, subtract the deleted portion from the key's offset, delete t=
he
> >> old item and insert the new one.
> >>
> >> In case the range to delete ends in the middle of an item, we have to
> >> adjust both the item's key as well as the stripe extents and then
> >> re-insert the modified clone into the tree after deleting the old stri=
pe
> >> extent.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/ctree.c            |  1 +
> >>   fs/btrfs/raid-stripe-tree.c | 94 ++++++++++++++++++++++++++++++++++-=
--
> >>   2 files changed, 88 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> >> index b11ec86102e3..3f320f6e7767 100644
> >> --- a/fs/btrfs/ctree.c
> >> +++ b/fs/btrfs/ctree.c
> >> @@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct =
btrfs_trans_handle *trans,
> >>          btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> >>
> >>          BUG_ON(key.type !=3D BTRFS_EXTENT_DATA_KEY &&
> >> +              key.type !=3D BTRFS_RAID_STRIPE_KEY &&
> >>                 key.type !=3D BTRFS_EXTENT_CSUM_KEY);
> >>
> >>          if (btrfs_leaf_free_space(leaf) >=3D ins_len)
> >> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> >> index 41970bbdb05f..569273e42d85 100644
> >> --- a/fs/btrfs/raid-stripe-tree.c
> >> +++ b/fs/btrfs/raid-stripe-tree.c
> >> @@ -13,6 +13,50 @@
> >>   #include "volumes.h"
> >>   #include "print-tree.h"
> >>
> >> +static int btrfs_partially_delete_raid_extent(struct btrfs_trans_hand=
le *trans,
> >> +                                             struct btrfs_path *path,
> >> +                                             struct btrfs_key *oldkey=
,
> >
> > oldkey can be made const.
> >
> >> +                                             u64 newlen, u64 frontpad=
)
> >> +{
> >> +       struct btrfs_root *stripe_root =3D trans->fs_info->stripe_root=
;
> >> +       struct btrfs_stripe_extent *extent;
> >> +       struct extent_buffer *leaf;
> >> +       int slot;
> >> +       size_t item_size;
> >> +       int ret;
> >> +       struct btrfs_key newkey =3D {
> >> +               .objectid =3D oldkey->objectid + frontpad,
> >> +               .type =3D BTRFS_RAID_STRIPE_KEY,
> >> +               .offset =3D newlen,
> >> +       };
> >> +
> >> +       ASSERT(oldkey->type =3D=3D BTRFS_RAID_STRIPE_KEY);
> >> +       ret =3D btrfs_duplicate_item(trans, stripe_root, path, &newkey=
);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       leaf =3D path->nodes[0];
> >> +       slot =3D path->slots[0];
> >> +       item_size =3D btrfs_item_size(leaf, slot);
> >> +       extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_exte=
nt);
> >> +
> >> +       for (int i =3D 0; i < btrfs_num_raid_stripes(item_size); i++) =
{
> >> +               struct btrfs_raid_stride *stride =3D &extent->strides[=
i];
> >> +               u64 phys;
> >> +
> >> +               phys =3D btrfs_raid_stride_physical(leaf, stride);
> >> +               btrfs_set_raid_stride_physical(leaf, stride, phys + fr=
ontpad);
> >> +       }
> >> +
> >> +       btrfs_mark_buffer_dirty(trans, leaf);
> >
> > This is redundant, it was already done by btrfs_duplicate_item(), by
> > the btrfs_search_slot() call in the caller and done by
> > btrfs_del_item() below as well.
> >
> >
> >> +
> >> +       /* delete the old item, after we've inserted a new one. */
> >> +       path->slots[0]--;
> >> +       ret =3D btrfs_del_item(trans, stripe_root, path);
> >
> > So actually looking at this, we don't need  btrfs_duplicate_item()
> > plus btrfs_del_item(), this can be more lightweight and simpler by
> > doing just:
> >
> > 1) Do the for loop as it is.
> >
> > 2) Then after, or before the for loop, the order doesn't really
> > matter, just do:   btrfs_set_item_key_safe(trans, path, &newkey).
> >
> > Less code and it avoids adding a new item and deleting another one,
> > with the shiftings of data in the leaf, etc.
>
> Oh I didn't know about btrfs_set_item_key_safe(), that sounds like a
> good plan thanks :)
> Can I still get rid of btrfs_mark_buffer_dirty then?

Yes, even because btrfs_set_item_key_safe() already does it.

