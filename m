Return-Path: <linux-btrfs+bounces-5118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C4E8CA0F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0CB211E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0CC137C20;
	Mon, 20 May 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOvjc/5l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287879EF
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224166; cv=none; b=Td0827eXiTzcTZ7+hiKBe6+FZqzNqi/zmmq2gR7faqvClb2jYTgms8EYe5Jmhm1LTWgyRTcMVhqKUHnFseFLxVyQyQCfYjG9pASxNZ7c9G2/q8iCSbK3rYbhNAIjlIyYAV7YxQ6qFA6ZHNI1Hb8UGhg95ylDZQXi/gtTpOSyUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224166; c=relaxed/simple;
	bh=bzKf8r7a3uOF9WkMqefu6IbkmVWHG13QDGN6uE+orYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNZf4KTkaBeqGXc/2RS0qqHHvkSIUDbEsbGZbf4rrrXSaqwPKEZjNMqks6ZjWRM6ngrfCBWXPlUXyncvGzG8AJ7WdzJOXsUDyGE/9l0wfJckAXl4Ur5VibNGmBYFdinjC0nIcrWjOF4UxzanpCOztwNaZp1DdPX2gQsPF/9ypes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOvjc/5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CD6C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716224166;
	bh=bzKf8r7a3uOF9WkMqefu6IbkmVWHG13QDGN6uE+orYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JOvjc/5lgVmr1GCtGmSNvjyodqOOXWLebLF9yaiu0XDYsz0TLGrxhalqwC8c4qfID
	 Rfb2cC9E1L4BZgrg1VZC/UAQH2DvGsA54X550AK/JfmT1V7NwlSpHHN7LioyDkHcG/
	 iRlho2mdnf6QRfsW8bq/HKCBPNjjfELCFuG/INPM4QL5paMDPYNVVop1NcnEoxivuu
	 4yJqMPGtlgcpKeLJHUPhgdT0EqDwhoCCBh9zryej9dj48qpnKPNu3wQX9E9r51GKbq
	 E4IWCszIhZVLMEV6EkfHLX9U4ohZpmHKChsCg6pvdSsTIG2TtGWwCbLp1Wyi/7KXlr
	 L4pJufRxRRY4A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e428242a38so61546651fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:56:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2w+B7Y0y2Ya8PNALxgNUW2dT9YSFOBatpVy/Q11nMA6kR1KZs
	8+UcXI/YVAw/oNZ+JuBR6+neDkeBSGM6rSRCjE9LCd7x1mChhqnyGCym9SSK6Mv5ogJJ+PLlGJh
	RMixm3WedjPyavVNDF2ZMSx1VwUM=
X-Google-Smtp-Source: AGHT+IHvP55z90jLin2N7F1E3j9ScljDexM8ALxD1CqZKVyVai3jzFPJALIa6YFgEodrqLJ+5wMe/svihHxgOaLocaA=
X-Received: by 2002:a2e:9695:0:b0:2e0:5d7:a3a6 with SMTP id
 38308e7fff4ca-2e51fc3442emr229111701fa.9.1716224164679; Mon, 20 May 2024
 09:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com>
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 17:55:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H59-6saCXaFtsGisT1Yvn21PS+oJhhbNH8yg4nDNnAYvA@mail.gmail.com>
Message-ID: <CAL3q7H59-6saCXaFtsGisT1Yvn21PS+oJhhbNH8yg4nDNnAYvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] btrfs: extent-map: unify the members with btrfs_ordered_extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [CHANGELOG]
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

The shrinker doesn't invalidate or make this patchset less useful.

It's always good to reduce the size of a structure like this for which
we can easily have millions of instances, it reduces the number of
pages we consume.

Things are a bit hard to review here, because a lot of code is added
and then removed later and fields at a time, so a lot of cross
reference checks are needed.
Changing the approach here would be a lot of work, and probably would
be more bike shedding than anything else.

But it looks fine, and all the comments on the individual patches are
minor, except for a bug in patch 8/11.

Thanks!

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
>  fs/btrfs/extent_map.c             | 187 ++++++++++++------
>  fs/btrfs/extent_map.h             |  51 +++--
>  fs/btrfs/file-item.c              |  23 +--
>  fs/btrfs/file.c                   |  18 +-
>  fs/btrfs/inode.c                  | 308 +++++++++++++-----------------
>  fs/btrfs/ordered-data.c           |  36 +++-
>  fs/btrfs/ordered-data.h           |  22 ++-
>  fs/btrfs/relocation.c             |   5 +-
>  fs/btrfs/tests/extent-map-tests.c | 114 ++++++-----
>  fs/btrfs/tests/inode-tests.c      | 177 ++++++++---------
>  fs/btrfs/tree-log.c               |  25 +--
>  fs/btrfs/zoned.c                  |   4 +-
>  include/trace/events/btrfs.h      |  26 +--
>  17 files changed, 548 insertions(+), 483 deletions(-)
>
> --
> 2.45.0
>
>

