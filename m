Return-Path: <linux-btrfs+bounces-4184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD938A2F22
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC6E1C227F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE65B209;
	Fri, 12 Apr 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSgsDkWG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905550275
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927805; cv=none; b=TYcj/wsPwsh1+KwZhQFgojN7eAEevtdKu+NShExezPgQuHu3vGE9JBkA8enaGIvOrrVA2NHXteFXqOjZzzkZSGctsymmSen2cVHGjYk16GaYEL7ZIJF9f1pdNWivaRiPFTdg4yP6KWStQXZZFbBlFrntUMkuBoQG7C7BYBxXzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927805; c=relaxed/simple;
	bh=yuD1tYtP/4CUYpE9phUZ1FNikxasgGWFXKN5NE6Nk1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djRO0B8VnSEZzrDU6sCQWYfoFT9VJRAfrwKiakcD48cS6yEOWoNz0yV0j0n/J9VbYkHd4dFwqK1BWZxOkxjSzUbMMTtScXO18AjwGb9qdKbar4cKNOH8S7lpV4aEll5f/yk02n9VscqgVnuABCDE8fCwcyl5p6MU8ZX/kkXvVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSgsDkWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E0C113CD
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712927805;
	bh=yuD1tYtP/4CUYpE9phUZ1FNikxasgGWFXKN5NE6Nk1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eSgsDkWGpU/zrgl/qahXYl6XDgiPkmYBfQDHux7FS4/mJVsd2Ztt5yXedvA4FNPd8
	 9bE1oUQ0VbAIluSSXEX5UTkWAP7rfZ0cITFeYyXMW9qwEyQTVcJ7h8F4g4lnWraOuW
	 f+aC0oGUHJ9L9ZdbAEahKg0ZHderDGqScYwnfKmNzS6WHZOHlfzy+fEe5CCzIWLXJD
	 mK0rv0dUwO54XMeMhcQzp7y9ZjIyGRSxK/BoU07vhqmx/mb2PHHYCSw8ucPmwSSYgV
	 teLmB6BRN+xi8QvcVnit9pWdOt19JEhJNEvD3rM1M2kK1pTUsSvjGQ0Ke5xVxpRwFG
	 WHN4Ue8RFyiCA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2da01cb187cso13882231fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 06:16:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEuMC7zVkWz14SpHxDhSYiNb3LpEOPlwDgnzLCn6EbmNLW1wXy
	FjnaQ4sc5zzGx9TGaOLD1Und1XZNv6NEHoDJBYG2FdiL+cPje2tThtbdjKHAMg/halVrES51zhy
	dxjTUQ/5IkUKgqi35lmk7lLXTMc0=
X-Google-Smtp-Source: AGHT+IEXKybmpzD8Xir9EFmWy+yFtuDRzgtMfCue+bxV580iPfvDtR56/w7SAyvWO5c67BJn1BB9V8LdPJBK27KnaQg=
X-Received: by 2002:a2e:b0cd:0:b0:2d6:c749:17bc with SMTP id
 g13-20020a2eb0cd000000b002d6c74917bcmr1843002ljl.31.1712927803807; Fri, 12
 Apr 2024 06:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712875458.git.wqu@suse.com> <CAL3q7H7smJkLMYnSP0akpsc_nORFN4bLp_Wp4VxA2nytxp8Few@mail.gmail.com>
 <2a688a2e-a956-4bec-a231-372ec7134003@suse.com>
In-Reply-To: <2a688a2e-a956-4bec-a231-372ec7134003@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Apr 2024 14:16:07 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7tPq9ZYN6e9ow43-sOatHEAv2D3bj0Co+_at2LT2JJCA@mail.gmail.com>
Message-ID: <CAL3q7H7tPq9ZYN6e9ow43-sOatHEAv2D3bj0Co+_at2LT2JJCA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] btrfs: more explaination on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:45=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/4/12 20:01, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Apr 11, 2024 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> [REPO]
> >> https://github.com/adam900710/linux.git/ em_cleanup
> >>
> >> The first 3 patches only. As later patches are the huge rename part.
> >>
> >> [CHANGELOG]
> >> v4:
> >> - Add extra comments for the extent map merging
> >>    Since extent maps can be merged, the members are only matching
> >>    on-disk file extent items before merging.
> >>    This also means users of extent_map should not rely on it for
> >>    a reliable file extent item member.
> >>    (That's also why we use ordered_extent not extent_maps, to update
> >>     file extent items)
> >
> > So this isn't true.
> > We use information from the ordered extent to create the file extent
> > item, when finishing the ordered extent, because the ordered extent is
> > immediately accessible.
> > We could also use the extent map, we would just have to do a tree searc=
h for it.
> > The extent map created when starting delalloc or at the beginning of a
> > DIO write is pinned and in the list of modified extents, so it can't
> > be merged and it represents exactly one file extent item - the one
> > going to be inserted the inode's subvolume tree when finishing the
> > ordered extent.
>
> If you're doing COW writes, extent map is fine, as it's always new
> extents and they are all pinned thus won't be merged.
>
> For pure NOCOW, it's also fine because there would be no extent map
> inserted, nor updating file extent items.
>
> But for PREALLOC writes (NOCOW into preallocated writes), it's not the
> case as the target extent maps can be merged already.

Yes, but prealloc is an exception, as we don't insert a new file
extent item, just update an existing one or split and change the type
from prealloc to regular, etc.
My comment was obviously for COW, which is the only case that needs to
insert a new file extent item.

>
> Thus that's why for NOCOW we go with a subvolume tree search to grab the
> correct original disk_bytenr/disk_num_bytes/offset to go.
>
> If you use extent map instead of search subvolume tree, the following
> layout can screw up everything:
>
> Filepos 0:
> disk_bytenr X, disk_num_bytes 64K
> num_bytes 64K, offset 0, ram_bytes 64K
>
> Filepos 64K
> disk_bytenr X+64K, disk_num_bytes 64K
> num_bytes 64K, offset 0, ram_bytes 64K.
>
> The extent map would be (after merge):
>
> filepos 0, len 128K block_start X, block len 128K, orig_start 0.
>
> Even with my new disk_bytenr it would be no difference, the disk_bytenr
> would still be X, and disk_num_bytes would be merged 128K.
>
> So the merging behavior is affecting PREALLOC writes, and we're already
> avoiding the only pitfall.
>
> Thanks,
> Qu
>
> >
> >>
> >> v3:
> >> - Rebased to latest for-next branch
> >> - Further comments polishment
> >> - Coding style update to follow the guideline
> >>
> >> v2:
> >> - Add Filipe's cleanup on mod_start/mod_len
> >>    These two members are no longer utilized, saving me quite some time=
 on
> >>    digging into their usage.
> >>
> >> - Update the comments of the extent_map structure
> >>    To make them more readable and less confusing.
> >>
> >> - Further cleanup for inline extent_map reading
> >>
> >> - A new patch to do extra sanity checks for create_io_em()
> >>    Firstly pure NOCOW writes should not call create_io_em(), secondly
> >>    with the new knowledge of extent_map, it's easier to do extra sanit=
y
> >>    checks for the already pretty long parameter list.
> >>
> >> Btrfs uses extent_map to represent a in-memory file extent.
> >>
> >> There are severam members that are 1:1 mappe in on-disk file extent
> >> items and extent maps:
> >>
> >> - extent_map::start     =3D=3D      key.offset
> >> - extent_map::len       =3D=3D      file_extent_num_bytes
> >> - extent_map::ram_bytes =3D=3D      file_extent_ram_bytes
> >>
> >> But that's all, the remaining are pretty different:
> >>
> >> - Use block_start to indicate holes/inline extents
> >>    Meanwhile btrfs on-disk file extent items go with a dedicated type =
for
> >>    inline extents, and disk_bytenr 0 for holes.
> >>
> >> - Weird block_start/orig_block_len/orig_start
> >>    In theory we can directly go with the same file_extent_disk_bytenr,
> >>    file_extent_disk_num_bytes and file_extent_offset to calculate the
> >>    remaining members (block_start/orig_start/orig_block_len/block_len)=
.
> >>
> >>    But for whatever reason, we didn't go that path and have a hell of
> >>    weird and inconsistent calculation for them.
> >>
> >> Qu Wenruo (3):
> >>    btrfs: add extra comments on extent_map members
> >>    btrfs: simplify the inline extent map creation
> >>    btrfs: add extra sanity checks for create_io_em()
> >>
> >>   fs/btrfs/extent_map.h | 58 +++++++++++++++++++++++++++++++++++++++++=
+-
> >>   fs/btrfs/file-item.c  | 20 +++++++--------
> >>   fs/btrfs/inode.c      | 40 ++++++++++++++++++++++++++++-
> >>   3 files changed, 106 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 2.44.0
> >>
> >>

