Return-Path: <linux-btrfs+bounces-5263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DC8CD9F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB2DB22A12
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7B84A24;
	Thu, 23 May 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP94I1OB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237984FA9
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488847; cv=none; b=BrawClq6dG2Pv3x+2Y92R4nk5r+0tFZ0BiDjm/hZLn1m0tQ+TVRqNeb2jMP/ab694jvIgLJh5eL4VthIfTbXC94yLPie0f/NOkyFrGOxQhUM+28sJBQTekQ3Y9REJM57XT+ePZ9EGF3JPFYCK7sJluY25HKYF86lXlaLRV7A0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488847; c=relaxed/simple;
	bh=Gl/B7uzRduQ/wYrXUxdzjqC+dxaI+xZzMuA75F0TJvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2l63bVhkKgXbJK2I/GqyIp44bsdJGQFY0uccinZ/qa5xosKuhM0WyzdxDGVgDvs04wbEaB3Uaqx4oaqGzub7oxmhmowTz87w0y6yBe8KT0jDjuUugHVvor1NI1F4FZUs7+2Yn8O/970OLhBg8eSAzMH1vUW57wmcDFKUOQkruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP94I1OB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D642C3277B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 18:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716488846;
	bh=Gl/B7uzRduQ/wYrXUxdzjqC+dxaI+xZzMuA75F0TJvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UP94I1OB9dREyz/Go9jiwGI++YUOBUVk7A2ZoJfxa0BGD6nxiX4+L6Zz9xOWn8ZCZ
	 B2cn+yvGAcBsmjNxu3BXAjYyjgJKN3jjYXmC78F61rRa0yGxGJ7D7M8cz1usLWd8+F
	 ZnCsT/cBzHuv5DfMU+AB9rrqL+uOb6qMjycIx9T0t36v3npk2mWoQMpmrwxRFFAr+C
	 3LUDenlDWQPzXmAO6c2vLFwXkqxYkoPMjWv3drqoOw6BWQ6NLlYm6EpSJhvbPVuJCL
	 G/ZTuoXKPMLMqBxYNS09TwnRXIDeXWYDqkXDuNGkxvcWkf/uDCoHKg36yb2hd2bCYZ
	 G79svxyREIR9g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso8296792e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 11:27:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YwyCBeneqzKToSBH9Pz6BuZmDomkQo/ymKHDvFqcvyq+SCUmA8B
	9DzTh6k3bu+j+C0lBEMCsal03McuDvLFxvK41ApaOm/xgh+SfxHLQNen68RTmAlo8BNH/y9H/9b
	RXOdilndxr8WkoNKKjjJKJDJNIyU=
X-Google-Smtp-Source: AGHT+IHGggMdEoM3veJsU8ZUwZEE9QGY93wY/LQPVkLZa2bPeF3ia4yu5LC9rZtzOD15jQnEdii2F4CmVCwV2JEhwzA=
X-Received: by 2002:ac2:4a6e:0:b0:523:88e9:9cd2 with SMTP id
 2adb3069b0e04-526c130b7cdmr3177637e87.67.1716488844951; Thu, 23 May 2024
 11:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716440169.git.wqu@suse.com>
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 23 May 2024 19:26:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5+LSCB751tAdZ0iZN=MyjfT9yNaFU1CRqiJaqV4qYg8A@mail.gmail.com>
Message-ID: <CAL3q7H5+LSCB751tAdZ0iZN=MyjfT9yNaFU1CRqiJaqV4qYg8A@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] btrfs: extent-map: unify the members with btrfs_ordered_extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 6:04=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [CHANGELOG]
> v3:
> - Rebased to the latest for-next
>   There is a small conflicts with the extent map tree members changes,
>   no big deal.
>
> - Fix an error where original code is checking
>   btrfs_file_extent_disk_bytenr()
>   The newer code is checking disk_num_bytes, which is wrong.
>
> - Various commit messages/comments update
>   Mostly some grammar fixes and removal of rants on the btrfs_file_extent
>   member mismatches for btrfs_alloc_ordered_extent().
>   However a comment is still left inside btrfs_alloc_ordered_extent()
>   for NOCOW/PREALLOC as a reminder for further cleanup.

I went through each new patch version, and it looks good.

I replied to some individual patches with minor things that can be
fixed at commit time when adding to for-next in case you don't send a
new version.
For patch 7/11 there's one issue.

Otherwise looks great, so after the 7/11 fix you can add:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

>
> v2:
> - Rebased to the latest for-next
>   There is a conflicts with extent locking, and maybe some other
>   hidden conflicts for NOCOW/PREALLOC?
>   As previously the patchset passes fstests auto group, but after
>   the merging with other patches, it always crashes as btrfs/060.
>
> - Fix an error in the final cleanup patch
>   It's the NOCOW/PREALLOC shenanigans again, in the buffered NOCOW path,
>   that we have to use the old inaccurate numbers for NOCOW/PREALLOC OEs.
>
> - Split the final cleanup into 4 patches
>   Most cleanups are very straightforward, but the cleanup for
>   btrfs_alloc_ordered_extent() needs extra special handling for
>   NOCOW/PREALLOC.
>
> v1:
> - Rebased to the latest for-next
>   To resolve the conflicts with the recently introduced extent map
>   shrinker
>
> - A new cleanup patch to remove the recursive header inclusion
>
> - Use a new structure to pass the file extent item related members
>   around
>
> - Add a new comment on why we're intentionally passing incorrect
>   numbers for NOCOW/PREALLOC ordered extents inside
>   btrfs_create_dio_extent()
>
> [REPO]
> https://github.com/adam900710/linux/tree/em_cleanup
>
> This series introduce two new members (disk_bytenr/offset) to
> extent_map, and removes three old members
> (block_start/block_len/offset), finally rename one member
> (orig_block_len -> disk_num_bytes).
>
> This should save us one u64 for extent_map, although with the recent
> extent map shrinker, the saving is not that useful.
>
> But to make things safe to migrate, I introduce extra sanity checks for
> extent_map, and do cross check for both old and new members.
>
> The extra sanity checks already exposed one bug (thankfully harmless)
> causing em::block_start to be incorrect.
>
> But so far, the patchset is fine for default fstests run.
>
> Furthermore, since we're already having too long parameter lists for
> extent_map/ordered_extent/can_nocow_extent, here is a new structure,
> btrfs_file_extent, a memory-access-friendly structure to represent a
> btrfs_file_extent_item.
>
> With the help of that structure, we can use that to represent a file
> extent item without a super long parameter list.
>
> The patchset would rename orig_block_len to disk_num_bytes first.
> Then introduce the new member, the extra sanity checks, and introduce the
> new btrfs_file_extent structure and use that to remove the older 3 member=
s
> from extent_map.
>
> After all above works done, use btrfs_file_extent to further cleanup
> can_nocow_file_extent_args()/btrfs_alloc_ordered_extent()/create_io_em()/
> btrfs_create_dio_extent().
>
> The cleanup is in fact pretty tricky, the current code base never
> expects correct numbers for NOCOW/PREALLOC OEs, thus we have to keep the
> old but incorrect numbers just for NOCOW/PREALLOC.
>
> I will address the NOCOW/PREALLOC shenanigans the future, but
> after the huge cleanup across multiple core structures.
>
> Qu Wenruo (11):
>   btrfs: rename extent_map::orig_block_len to disk_num_bytes
>   btrfs: export the expected file extent through can_nocow_extent()
>   btrfs: introduce new members for extent_map
>   btrfs: introduce extra sanity checks for extent maps
>   btrfs: remove extent_map::orig_start member
>   btrfs: remove extent_map::block_len member
>   btrfs: remove extent_map::block_start member
>   btrfs: cleanup duplicated parameters related to
>     can_nocow_file_extent_args
>   btrfs: cleanup duplicated parameters related to
>     btrfs_alloc_ordered_extent
>   btrfs: cleanup duplicated parameters related to create_io_em()
>   btrfs: cleanup duplicated parameters related to
>     btrfs_create_dio_extent()
>
>  fs/btrfs/btrfs_inode.h            |   4 +-
>  fs/btrfs/compression.c            |   7 +-
>  fs/btrfs/defrag.c                 |  14 +-
>  fs/btrfs/extent_io.c              |  10 +-
>  fs/btrfs/extent_map.c             | 192 +++++++++++++------
>  fs/btrfs/extent_map.h             |  51 +++--
>  fs/btrfs/file-item.c              |  23 +--
>  fs/btrfs/file.c                   |  18 +-
>  fs/btrfs/inode.c                  | 308 +++++++++++++-----------------
>  fs/btrfs/ordered-data.c           |  34 +++-
>  fs/btrfs/ordered-data.h           |  19 +-
>  fs/btrfs/relocation.c             |   5 +-
>  fs/btrfs/tests/extent-map-tests.c | 114 ++++++-----
>  fs/btrfs/tests/inode-tests.c      | 177 ++++++++---------
>  fs/btrfs/tree-log.c               |  23 ++-
>  fs/btrfs/zoned.c                  |   4 +-
>  include/trace/events/btrfs.h      |  18 +-
>  17 files changed, 541 insertions(+), 480 deletions(-)
>
> --
> 2.45.1
>
>

