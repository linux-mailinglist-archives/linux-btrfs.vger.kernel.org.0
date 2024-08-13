Return-Path: <linux-btrfs+bounces-7162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A712D95034E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 13:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06885B226F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A885198E61;
	Tue, 13 Aug 2024 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR/GH8Gy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0318B483;
	Tue, 13 Aug 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547312; cv=none; b=ec3dgJvsNqlyJ/baehEXaTBxH14k89yiFq07WWUP5UykU837YIWfbwu9bOUPP33dbIcN3UJ2AkoBqvu9lIjLUSkT0xuXpY4ezlt5oxddVJLzApx4/bZYcnSchK8NvljjPrBfauEgdaJOoYwcZ4a3sQU2TYqHO1SguqxwjBuR3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547312; c=relaxed/simple;
	bh=KDHgfDGEo2nZy9BIe35mA+tEFCEaa1OpUGvw7YEYEuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qal37MlwrM2TZGeui+MftJ8RFGR6u37rJCEb/NC5khbR6BGrFIN2/7paDM7pUd004cd6u/7N4WbtCGgejPba/XO7B936y6SBwJjBmC8dKdHBDAok5kF9XjWDN1oEn9jkv/PcEts2CucK7jb3mEyt1ZOz6EoI4CDt2rpvgZiI5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR/GH8Gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0A1C4AF11;
	Tue, 13 Aug 2024 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547312;
	bh=KDHgfDGEo2nZy9BIe35mA+tEFCEaa1OpUGvw7YEYEuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZR/GH8GyNdW26Ac+VTtDfvRJrQ/m/pHSQfS1y7WD1lXT0Pf4LL3UWg77T+cLcbP08
	 hFrY3IUeQybJCBK6Cf3FhAUcepNtSjAZdpCsCHjI0d11+A402X6W0MQz4lkU5dYtkJ
	 8tzNc783sSQDaAgdW6WNyJhoD1zS25YmHOulPeFoH++T6ss0JJia/4I/CoiLMmQz0f
	 En9KuONeOXeU6ah4g/HeS9mIqB3HGrWRC1penMKGHMpTeP9iYt7G2RC607oV7cap4h
	 AQ/B+mzgc3wRdAh8szbu2JMBoalWQt5/HrjG22PBsBDWZmofS+IlXEf2I8zyUPlqgs
	 y+rzxFLKh8DdA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so5449511a12.2;
        Tue, 13 Aug 2024 04:08:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyrbWcF8C/eheWNeKHOrBZA+wZywdozAwT3dmnzsHCu+AXERE76i9GEAs8UxMFWAKF5W42IZSV3md7rPxgmZvoA3ld1wPyIsErLvuQDA12dXFcyDQI1xhEzeO3EYTRMQCC3eUL9ozIk5U=
X-Gm-Message-State: AOJu0YyjGA+hfxz0rMxzUv6RP4GcewSNACnUXDLeebDgcuYREqkGS+gQ
	fE1PKGLH3ctnCByDmN43DiahVrffUZVtsLyWWntw4ytbYUaO3o+gUmFIDABNRF3KCSHijJGvYE8
	n14DZkvJKzjPFpBlaL6pE7PE1ztc=
X-Google-Smtp-Source: AGHT+IHd6dd30n2JtKGra+pZnI7gjIAYPHyvBr/l2PZ5c7rSldDqd1Z6VPvRse4TM9/VPz6IIAOr2A8/vBpSGWFx8zc=
X-Received: by 2002:a17:907:d16:b0:a7a:a2b7:93ff with SMTP id
 a640c23a62f3a-a80ed2da0fdmr206495666b.57.1723547310595; Tue, 13 Aug 2024
 04:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org>
 <CAL3q7H5jwR75FwT213yteX5m=5G8ehKmnKxv=xYXbY+UuhP+qQ@mail.gmail.com> <603670e6-e0c6-4f54-be6d-272042861bce@wdc.com>
In-Reply-To: <603670e6-e0c6-4f54-be6d-272042861bce@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 13 Aug 2024 12:07:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7R-AHyhz3pNMpAaqR6QKquGmCudOXco7BJ8QY4qA6naw@mail.gmail.com>
Message-ID: <CAL3q7H7R-AHyhz3pNMpAaqR6QKquGmCudOXco7BJ8QY4qA6naw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reduce chunk_map lookups in btrfs_map_block
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:05=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 13.08.24 12:57, Filipe Manana wrote:
> > On Tue, Aug 13, 2024 at 11:49=E2=80=AFAM Johannes Thumshirn <jth@kernel=
.org> wrote:
> >>
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> Currently we're calling btrfs_num_copies() before btrfs_get_chunk_map(=
) in
> >> btrfs_map_block(). But btrfs_num_copies() itself does a chunk map look=
up
> >> to be able to calculate the number of copies.
> >>
> >> So split out the code getting the number of copies from btrfs_num_copi=
es()
> >> into a helper called btrfs_chunk_map_num_copies() and directly call it
> >> from btrfs_map_block() and btrfs_num_copies().
> >>
> >> This saves us one rbtree lookup per btrfs_map_block() invocation.
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >> Changes in v2:
> >> - Added Reviewed-bys
> >> - Reflowed comments
> >> - Moved non RAID56 cases to the end without an if
> >> Link to v1:
> >> https://lore.kernel.org/all/20240812165931.9106-1-jth@kernel.org/
> >>
> >>   fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++-------------------=
--
> >>   1 file changed, 32 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index e07452207426..796f6350a017 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -5781,38 +5781,44 @@ void btrfs_mapping_tree_free(struct btrfs_fs_i=
nfo *fs_info)
> >>          write_unlock(&fs_info->mapping_tree_lock);
> >>   }
> >>
> >> +static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)
> >
> > Same as commented before, can be const.
>
> No it can't:
> fs/btrfs/volumes.c:5784:8: warning: type qualifiers ignored on function
> return type [-Wignored-qualifiers]
>   5784 | static const int btrfs_chunk_map_num_copies(struct
> btrfs_chunk_map *map)
>
> Or did you mean the const struct btrfs_chunk_map? That could be done but
> I don't see a reason.

Yes, I meant const for the argument, not the return type.
It's not needed but it makes it clear for a reader that we don't
intend to change anything. It's just a best practice.

>
> >
> >> +{
> >> +       enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_index(m=
ap->type);
> >> +
> >> +       if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> >> +               return 2;
> >> +
> >> +       /*
> >> +        * There could be two corrupted data stripes, we need to loop
> >> +        * retry in order to rebuild the correct data.
> >> +        *
> >> +        * Fail a stripe at a time on every retry except the stripe
> >> +        * under reconstruction.
> >> +        */
> >> +       if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> >> +               return map->num_stripes;
> >> +
> >> +       /* Non-RAID56, use their ncopies from btrfs_raid_array. */
> >> +       return btrfs_raid_array[index].ncopies;
> >> +}
> >> +
> >>   int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64=
 len)
> >>   {
> >>          struct btrfs_chunk_map *map;
> >> -       enum btrfs_raid_types index;
> >> -       int ret =3D 1;
> >> +       int ret;
> >>
> >>          map =3D btrfs_get_chunk_map(fs_info, logical, len);
> >>          if (IS_ERR(map))
> >>                  /*
> >> -                * We could return errors for these cases, but that co=
uld get
> >> -                * ugly and we'd probably do the same thing which is j=
ust not do
> >> -                * anything else and exit, so return 1 so the callers =
don't try
> >> -                * to use other copies.
> >> +                * We could return errors for these cases, but that
> >> +                * could get ugly and we'd probably do the same thing
> >> +                * which is just not do anything else and exit, so
> >> +                * return 1 so the callers don't try to use other
> >> +                * copies.
> >
> > My previous comment about reformatting was just for the comment that
> > was moved, the one now inside btrfs_chunk_map_num_copies().
> > For this one I don't think we should do it, as we aren't moving it
> > around or changing its content.
> >
> > It's just confusing to have this sort of unrelated change mixed in.
> >
>
> Whoops that was fat fingered somehow.
>

