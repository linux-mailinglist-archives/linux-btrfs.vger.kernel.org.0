Return-Path: <linux-btrfs+bounces-5004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D98C6418
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD37B23477
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19D5915C;
	Wed, 15 May 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxEujjA8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370558AC3
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766491; cv=none; b=GFB+ZdheXxc+9mn232tZ88HfwydRkzUAunte+bd44GSkuBT6FX6heT3SX4QF+Ce7IF42C+n6iQXv4hwiyGiqK7WFdxZK4qMy+kxG0l0t4ZkIDzlMfna2wu6pgqnKQjQuNwVeoz6ZLJjT5uYBPy58rdLZpzhs7zOmF4Vx1Kh35Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766491; c=relaxed/simple;
	bh=u4dgNlu3h1WsQZNfrPjmRmb9zHEqhlSbvorvtN9JibM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwUEcb1B9HgJ6aa3mUOP+ZrobvzqqsxIH8MVt2MTpdfwagk332auDWPpWqzIXUHoVAvutOrYzPUY8A42DSpDOYaH5AowRLQm29OtnICVksJ3LgGHhrOnELYisgiDfgJbjNTsBZn72VoZ1uwrHmJ7WK6AKf+I2KSogbHbfN2gxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxEujjA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A4C32781
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715766490;
	bh=u4dgNlu3h1WsQZNfrPjmRmb9zHEqhlSbvorvtN9JibM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dxEujjA8sZw+pkAyo+uj9iISQcfN6Le/NTt3YUKoX3OFr4bud09rWz5UozCqGzglK
	 e4q2BoXnJhqGxtDoEOVdKZCsZuZKVBDiMAQUkuUY1Og2RRbswwXeZ/a4o+AzLbAM5m
	 iuXV6omu84Hs6jqZd1fXInXT316BZhR92V0HjEdUSjoix62yKMUzWmzhyMEHy9c20M
	 5ty40P1/mUqnhkVi/BRdfTrsrECSgf4cOGnIA0uG9nLC1LSXnqEV5zl17ECChjlHS7
	 OEYeaA8MqGM84W/LVI24PFj5Ci8Kzl1uOpk+ylr5HYpX02sIboqoeu0t0plWlwe9J9
	 XVoI22fXHRnWw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a609dd3fso182263066b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 02:48:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjRYAOFjrgGIBTp73r31GmLLGYVHrPJqZ2iBL4UMo+n3Z6Xslf
	KJqveqTSMdH/2JZnmsHO24SwTUaG3UiNh5IBmZLo6lqUAfljyj7jYP/U79SPYJt+C0sJHblIcwP
	biaHWDzYsbGIBstz0cqzrtjUm37E=
X-Google-Smtp-Source: AGHT+IGiiLEmdPlE6CDkcmWBoP+BmHD97xvDK7572sKJ/ZD3gAmISgAqlo7h3Kbkr1ZikCkZ/amRpsH8C9FrC7uVYkE=
X-Received: by 2002:a17:906:da8d:b0:a5a:7a1:5da3 with SMTP id
 a640c23a62f3a-a5a2d09e4b4mr1518239266b.0.1715766489336; Wed, 15 May 2024
 02:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715688057.git.fdmanana@suse.com> <affef2b4ccd4d0f9a0272cd5883a5922d36bac31.1715688057.git.fdmanana@suse.com>
 <67e9e462-b6d4-4c6d-b409-ae13ab9714a8@gmx.com>
In-Reply-To: <67e9e462-b6d4-4c6d-b409-ae13ab9714a8@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 15 May 2024 10:47:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5zBQYB76O9eLNCWpYrfYuD3VEqX4Cu67SgVdBTU6qz2g@mail.gmail.com>
Message-ID: <CAL3q7H5zBQYB76O9eLNCWpYrfYuD3VEqX4Cu67SgVdBTU6qz2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: drop extent maps after failed COW dio write
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:15=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/5/14 23:53, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > During a COW direct IO write if the call to btrfs_extract_ordered_exten=
t()
> > fails, we don't submit any bios, cleanup the ordered extent but we leav=
e
> > the extent maps we created for the write around.
> >
> > These extent maps point to locations on disk that were not written to,
> > since we haven't submitted a bio for them, and they are new an in the l=
ist
> > of modified extents.
> >
> > This means that if we fsync the file after, we log file extent items ba=
sed
> > on those extent maps, which are invalid since they point to unwritten
> > locations. If a power failure happens after the fsync, on log replay we
> > get a corrupted file range.
> >
> > Fix this by dropping the extent maps if btrfs_extract_ordered_extent()
> > failed.
> >
> > Fixes: b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just a small question inlined below.
> > ---
> >   fs/btrfs/inode.c | 21 +++++++++++++++++++--
> >   1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 5a1014122088..f04852e44123 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7888,11 +7888,28 @@ static void btrfs_dio_submit_io(const struct io=
map_iter *iter, struct bio *bio,
> >        * remaining pages is blocked on the outstanding ordered extent.
> >        */
> >       if (iter->flags & IOMAP_WRITE) {
> > +             struct btrfs_ordered_extent *oe =3D dio_data->ordered;
> >               int ret;
> >
> > -             ret =3D btrfs_extract_ordered_extent(bbio, dio_data->orde=
red);
> > +             ret =3D btrfs_extract_ordered_extent(bbio, oe);
> >               if (ret) {
> > -                     btrfs_finish_ordered_extent(dio_data->ordered, NU=
LL,
> > +                     /*
> > +                      * If this is a COW write it means we created new=
 extent
> > +                      * maps for the range and they point to an unwrit=
ten
> > +                      * location since we got an error and we don't su=
bmit
> > +                      * a bio. We must drop any extent maps within the=
 range,
> > +                      * otherwise a fast fsync would log them and afte=
r a
> > +                      * crash and log replay we would have file extent=
 items
> > +                      * that point to unwritten locations (garbage).
> > +                      */
>
> Is regular read also being affected?

No, it isn't, I'll explain below.

>
> Since the em is already inserted, and we're doing DIO, there should be
> no page cache for the whole dio range (as long as we didn't fallback to
> buffered IO).
>
> In that case, the problem is not only limited to fsync, but also any read=
.

Nop, it has nothing to do with not being buffered IO.

So what happens in this particular error path is that on error we call
btrfs_finish_ordered_extent() with "uptodate" false.

This sets the IO_ERR flag on the ordered extent and then queues the
ordered extent completion,
which results in executing btrfs_finish_one_ordered() in a work queue.

There we check the error flag on the ordered extent, and in fact we
drop extent maps in range - exactly what this patch is doing.

The problem is that once we unlock the inode in the dio write path,
another task can call fsync.

If the fsync is a "fast fsync", it does not wait for ordered extents
to complete before going over new extent maps.
So if the work queue job only finishes after the fsync logs extent
maps, we get the corruption - a log tree with file extent items
pointing to unwritten extents.

For the read path this doesn't happen.

Because for reads, when they start we lock the extent range and wait
for any ordered extents in the range to complete (we call
btrfs_lock_and_flush_ordered_range()),
which will result in dropping the extent maps in the range when the
ordered extents complete.

These are probably a lot of non-obvious details.
So I'll send a v2 with these details in the changelog and comment.

I also noticed there's at least one more error path with the same
problem, so I'll move the call to drop extent maps to
btrfs_finish_ordered_extent().

I'm giving a full fstests run with that updated version and sending it
out later.

Thanks.


>
> Thanks,
> Qu
> > +                     if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
> > +                             const u64 start =3D oe->file_offset;
> > +                             const u64 end =3D start + oe->num_bytes -=
 1;
> > +
> > +                             btrfs_drop_extent_map_range(bbio->inode, =
start, end, false);
> > +                     }
> > +
> > +                     btrfs_finish_ordered_extent(oe, NULL,
> >                                                   file_offset, dip->byt=
es,
> >                                                   !ret);
> >                       bio->bi_status =3D errno_to_blk_status(ret);

