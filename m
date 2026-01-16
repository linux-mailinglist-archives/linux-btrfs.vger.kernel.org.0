Return-Path: <linux-btrfs+bounces-20621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08465D2F2DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 11:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 928EA303BFC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1935CBD5;
	Fri, 16 Jan 2026 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff4mcfXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C635F8AA
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557615; cv=none; b=CoyQ23/LNPmiDanCOWxIHfPyvCAr+jPZs7CaDkhnh3ecjeJS0zAo++6rLI3gpdhdV+nRQ/1+bq1HEdv+snu3JmlwMOHZW1GNfgjbt+VF6X3Ca+PuIyP2f/QSFnrpYOiH4JEYxdj7wnrE/Fs4Tr0wPMaota6k0TDcE1A5rjAu4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557615; c=relaxed/simple;
	bh=4+AJQ8UytEJJUdicTICxfCNG7iLOlAie4L/6eKHSWv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2jT2Ucq7kJYWbIlam9llrf7Dw3ovGMJbhheFP5sqeQ/4UNM7wk5iXTG/iqFhntMHikjZFSr2Cq4QhhVr4FpBtPUKkZYmMTeZ/kO8xeOHsvQ13QoXiBBwERNIJXNl0IQTtYwOOD4ya5rJl1mqMd8NDS6uJ433PU4IuC9AE/AUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff4mcfXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F327AC116C6
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768557615;
	bh=4+AJQ8UytEJJUdicTICxfCNG7iLOlAie4L/6eKHSWv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ff4mcfXXJjFNGZuv3KsIjCDPc3uwK/JJ8KyAo2ZXS7Y/Rk2Pbtkm2pBt6BrCfCrGC
	 Dc4Jg+tYEEIQyvK0dTcGJgKVH9kr5uTTlYGM/9fQtQpjVWzP1LgLiGOw8ceeKGparM
	 p6hh6Ul6fbfeFotVGtC2qtiqmRe5+QvjS9/G81HdVtiCdkqPczdMd5SLOlxveL2qlK
	 ELv6AXWtR4OZXzx4rmlqy6KKHa0HgQJ8c6YDIxUwhKg6u141MBAtpKgXJao7yWY0Za
	 8ylpxLU8vc9aJsmvbBJoixjifO+xJAkJYt9uIfgJEA2hhllhTy7BF4nMpIbsLrTxPS
	 ejyPXU9MWbpUw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so440585066b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 02:00:14 -0800 (PST)
X-Gm-Message-State: AOJu0YzViqDZQJ2fOKRT54tNV7fP20VocIe6AMNmQc6KjRl5sFEMepdM
	ZHhjxXJTmvg3qcltCOGTfTfq4Ea2kZvG48M8sPMK+0iwv69M6SNV5o3dyJpNWGLQdNvzB4uulq4
	Irnn2DSkZgJTIxI9oljjCne21tLJMEtY=
X-Received: by 2002:a17:906:730c:b0:b87:72f0:3baf with SMTP id
 a640c23a62f3a-b8792e18ec7mr225381766b.22.1768557613548; Fri, 16 Jan 2026
 02:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com> <20260115222309.GA2118372@zen.localdomain>
In-Reply-To: <20260115222309.GA2118372@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 16 Jan 2026 09:59:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4DvCTO=R78ZRumJ71on=M-RzLNftZdMJiQEbAOpAk4Zw@mail.gmail.com>
X-Gm-Features: AZwV_QjW7r4M7_spqbxdYqcmLdl4OEtWTj4BjrDa7gxdx2WrVIBj7HKge-CwZEk
Message-ID: <CAL3q7H4DvCTO=R78ZRumJ71on=M-RzLNftZdMJiQEbAOpAk4Zw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:23=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Jan 15, 2026 at 09:52:06PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have currently three places that compute how much free space a block
> > group has. Add a helper function for this and use it in those places.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> This is nice, thanks.
>
> FWIW, I personally kind of prefer a name involving "available", as I
> think "free" is less descriptive of the zone_unusable aspect, for
> example. And generally evokes some kind of correlation to the state of
> the free space entries.

I'll rename it to "btrfs_block_group_available_space()" before pushing
to for-next, thanks.

>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >
> > V2: Fix typos leading to compilation failure.
> >
> >  fs/btrfs/block-group.c | 9 ++-------
> >  fs/btrfs/block-group.h | 8 ++++++++
> >  fs/btrfs/space-info.c  | 3 +--
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index a1119f06b6d1..d17fe777b727 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1376,8 +1376,7 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, bool force)
> >               goto out;
> >       }
> >
> > -     num_bytes =3D cache->length - cache->reserved - cache->pinned -
> > -                 cache->bytes_super - cache->zone_unusable - cache->us=
ed;
> > +     num_bytes =3D btrfs_block_group_free_space(cache);
> >
> >       /*
> >        * Data never overcommits, even in mixed mode, so do just the str=
aight
> > @@ -3089,7 +3088,6 @@ int btrfs_inc_block_group_ro(struct btrfs_block_g=
roup *cache,
> >  void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
> >  {
> >       struct btrfs_space_info *sinfo =3D cache->space_info;
> > -     u64 num_bytes;
> >
> >       BUG_ON(!cache->ro);
> >
> > @@ -3105,10 +3103,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block=
_group *cache)
> >                       btrfs_space_info_update_bytes_zone_unusable(sinfo=
, cache->zone_unusable);
> >                       sinfo->bytes_readonly -=3D cache->zone_unusable;
> >               }
> > -             num_bytes =3D cache->length - cache->reserved -
> > -                         cache->pinned - cache->bytes_super -
> > -                         cache->zone_unusable - cache->used;
> > -             sinfo->bytes_readonly -=3D num_bytes;
> > +             sinfo->bytes_readonly -=3D btrfs_block_group_free_space(c=
ache);
> >               list_del_init(&cache->ro_list);
> >       }
> >       spin_unlock(&cache->lock);
> > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > index 5f933455118c..6662e644199a 100644
> > --- a/fs/btrfs/block-group.h
> > +++ b/fs/btrfs/block-group.h
> > @@ -295,6 +295,14 @@ static inline bool btrfs_is_block_group_data_only(=
const struct btrfs_block_group
> >              !(block_group->flags & BTRFS_BLOCK_GROUP_METADATA);
> >  }
> >
> > +static inline u64 btrfs_block_group_free_space(const struct btrfs_bloc=
k_group *bg)
> > +{
> > +     lockdep_assert_held(&bg->lock);
> > +
> > +     return (bg->length - bg->used - bg->pinned - bg->reserved -
> > +             bg->bytes_super - bg->zone_unusable);
> > +}
> > +
> >  #ifdef CONFIG_BTRFS_DEBUG
> >  int btrfs_should_fragment_free_space(const struct btrfs_block_group *b=
lock_group);
> >  #endif
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 857e4fd2c77e..a9fe6b66c5e1 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -656,8 +656,7 @@ void btrfs_dump_space_info(struct btrfs_space_info =
*info, u64 bytes,
> >               u64 avail;
> >
> >               spin_lock(&cache->lock);
> > -             avail =3D cache->length - cache->used - cache->pinned -
> > -                     cache->reserved - cache->bytes_super - cache->zon=
e_unusable;
> > +             avail =3D btrfs_block_group_free_space(cache);
> >               btrfs_info(fs_info,
> >  "block group %llu has %llu bytes, %llu used %llu pinned %llu reserved =
%llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
> >                          cache->start, cache->length, cache->used, cach=
e->pinned,
> > --
> > 2.47.2
> >

