Return-Path: <linux-btrfs+bounces-17707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68FBD2F65
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38043C533E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1327144B;
	Mon, 13 Oct 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAbQthQl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79228261B9C
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358549; cv=none; b=h4W+Hhs1LvWEZxxuz5hndGEG3ydTt7qOrB6N7O9X4Mx3A6jokSOPXQJ/5RNcFz4+bJ7kXsHXZDvcYKt4WFIk96PpIircGFNX2oMRXhwRdYLYrMWCdUFkrJ48tac81npVm+QclJKuSGT43A6Ul6liRkNlKV/anTwt6ibDwvcF0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358549; c=relaxed/simple;
	bh=4UG7n3cbtM4Z5hajrwmhXcTu7ZNHj1+x8pvRCAxEZHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyLsfKWmb9YCwJV3YNZxXQflDKC/jo89VGrzvB9P84CyBb7M/zLHqAeC35W+0p61sFevMduD2IVpK8DVAW6kqheVWs1sxKjqrOvTwtiNnrRSpnPX5veP2KeDCXk4uTCKmgo/ooJjp2HhHNkREVVeuDcnWPwuDUiYIf8WHRUcAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAbQthQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA69FC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358548;
	bh=4UG7n3cbtM4Z5hajrwmhXcTu7ZNHj1+x8pvRCAxEZHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YAbQthQlhGq5QaDZpV+WBTK/Hnl0syOTFGnXw8YSbxCFKD9f5hIGfTvXvZS9crUwp
	 pXxJ1MLkNnjuhDcvEiOxjrEkQoFQobA4fSphfxGwyPA8Ic7WH2znvWJ4P0aWpglt4R
	 4EPwGuHOG0RbdjfNjqhU7ojNzFWSbf6Pj7nMOI7iBMKHinh3Wgz8s1pOYjRzcA+WAv
	 iZ8wqyWtiAMoAKg/SA7K5/Jr07Q2fkt8dwE4mj1e1YVqe5sK6GlU/psIjooVn7SEqs
	 DBEvSmyKwROCCRQmlSJiMlZ9RVV9r1jV8my+gfx8gtAtfvkhZp13qyH4Q56LL6eh66
	 aWNJVVd7HX6BQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b50645ecfbbso840363966b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:29:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw2Vn9560lsvvAesDoeDR8dLwmaCWujce54qPF3dG5f0Xf1oYqC
	Acj3kBWdbW3WiaKq2OAM6fMyfbxV2+UcXGqdWJ3SLh+YC/IUl8nDRUf40fdQ9eNYCq+78PYUNmg
	VMqb1Xz61sLd8EXc8tZnq3V++Jq9Hgcs=
X-Google-Smtp-Source: AGHT+IG2SkHqbsTa71jvjWRVyq/XPeaJ5IwAHhPgOHhHl90q7xLkrXFGMQmdsKNjJ1fjaIox+kVi42C43+EnQGzdrE4=
X-Received: by 2002:a17:907:968b:b0:b3b:9832:f9b with SMTP id
 a640c23a62f3a-b50aa8a1827mr2523040366b.25.1760358547363; Mon, 13 Oct 2025
 05:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e3df8da61ea11e45809208e3795452c5291f467.1760028487.git.fdmanana@suse.com>
 <5d465706-b7bd-4302-89d1-7f6b5e16e350@gmx.com> <bc1f98b9-c013-4e5f-8e6f-16c724367a3e@gmx.com>
In-Reply-To: <bc1f98b9-c013-4e5f-8e6f-16c724367a3e@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 Oct 2025 13:28:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4ZRe7m_M6g5cr9EuG8UnECsQ2sQ+gZ-GFyk9-mXkPk3Q@mail.gmail.com>
X-Gm-Features: AS18NWBhqizwX-kDez3cpeYa_zaBLKmPDasT_XsCuBvIZzqTQ78zZ3R6sY_MAs0
Message-ID: <CAL3q7H4ZRe7m_M6g5cr9EuG8UnECsQ2sQ+gZ-GFyk9-mXkPk3Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: check: stop checking for csums past i_size
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:54=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/10/10 07:07, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/10/10 03:19, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> While running test case btrfs/192 from fstests on a kernel with
> >> support for
> >> large folios (needs CONFIG_BTRFS_EXPERIMENTAL=3Dy kernel configuration
> >> at the
> >> moment) I ended up getting very sporadic btrfs check failures reportin=
g
> >> that csum items were missing. Looking into the issue it turned out
> >> that we
> >> end up looking for csum items of a file extent item with a range that
> >> spans
> >> beyond the i_size of a file and we don't have any, because the kernel'=
s
> >> writeback code skips submitting bios for ranges beyond eof.
> >>
> >> Example output when this happens:
> >>
> >>    $ btrfs check /dev/sdc
> >>    Opening filesystem to check...
> >>    Checking filesystem on /dev/sdc
> >>    UUID: 69642c61-5efb-4367-aa31-cdfd4067f713
> >>    [1/8] checking log skipped (none written)
> >>    [2/8] checking root items
> >>    [3/8] checking extents
> >>    [4/8] checking free space tree
> >>    [5/8] checking fs roots
> >>    root 5 inode 332 errors 1000, some csum missing
> >>    ERROR: errors found in fs roots
> >>    (...)
> >>
> >> Looking at a tree dump of the fs tree (root 5) for inode 332 we have:
> >>
> >>     $ btrfs inspect-internal dump-tree -t 5 /dev/sdc
> >>     (...)
> >>          item 28 key (332 INODE_ITEM 0) itemoff 2006 itemsize 160
> >>                  generation 17 transid 19 size 610969 nbytes 86016
> >>                  block group 0 mode 100666 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 11 flags 0x0(none)
> >>                  atime 1759851068.391327881 (2025-10-07 16:31:08)
> >>                  ctime 1759851068.410098267 (2025-10-07 16:31:08)
> >>                  mtime 1759851068.410098267 (2025-10-07 16:31:08)
> >>                  otime 1759851068.391327881 (2025-10-07 16:31:08)
> >>          item 29 key (332 INODE_REF 340) itemoff 1993 itemsize 13
> >>                  index 2 namelen 3 name: f1f
> >>          item 30 key (332 EXTENT_DATA 589824) itemoff 1940 itemsize 53
> >>                  generation 19 type 1 (regular)
> >>                  extent data disk byte 21745664 nr 65536
> >>                  extent data offset 0 nr 65536 ram 65536
> >>                  extent compression 0 (none)
> >>     (...)
> >>
> >> We can see that the file extent item for file offset 589824 has a
> >> length of
> >> 64K and its number of bytes is 64K. Looking at the inode item we see t=
hat
> >> its i_size is 610969 bytes which falls within the range of that file
> >> extent
> >> item [589824, 655360[.
> >>
> >> Looking into the csum tree:
> >>
> >>    $ btrfs inspect-internal dump-tree /dev/sdc
> >>    (...)
> >>          item 15 key (EXTENT_CSUM EXTENT_CSUM 21565440) itemoff 991
> >> itemsize 200
> >>                  range start 21565440 end 21770240 length 204800
> >>             item 16 key (EXTENT_CSUM EXTENT_CSUM 1104576512) itemoff
> >> 983 itemsize 8
> >>                  range start 1104576512 end 1104584704 length 8192
> >>    (..)
> >>
> >> We see that the csum item number 15 covers the first 24K of the file
> >> extent
> >> item - it ends at offset 21770240 and the extent's disk_bytenr is
> >> 21745664,
> >> so we have:
> >>
> >>     21770240 - 21745664 =3D 24K
> >>
> >> We see that the next csum item (number 16) is completely outside the
> >> range,
> >> so the remaining 40K of the extent doesn't have csum items in the tree=
.
> >>
> >> If we round up the i_size to the sector size, we get:
> >>
> >>     round_up(610969, 4096) =3D 614400
> >>
> >> If we subtract from that the file offset for the extent item we get:
> >>
> >>     614400 - 589824 =3D 24K
> >>
> >> So the missing 40K corresponds to the end of the file extent item's ra=
nge
> >> minus the rounded up i_size:
> >>
> >>     655360 - 614400 =3D 40K
> >>
> >> Normally we don't expect a file extent item to span over the rounded u=
p
> >> i_size of an inode, since when truncating, doing hole punching and oth=
er
> >> operations that trim a file extent item, the number of bytes is adjust=
ed.
> >>
> >> There is however a short time window where the kernel can end up,
> >> temporarily,persisting an inode with an i_size that falls in the
> >> middle of
> >> the last file extent item and the file extent item was not yet trimmed
> >> (its
> >> number of bytes reduced so that it doesn't cross i_size rounded up by =
the
> >> sector size).
> >>
> >> The steps (in the kernel) that lead to such scenario are the following=
:
> >>
> >>   1) We have inode I as an empty file, no allocated extents, i_size is=
 0;
> >>
> >>   2) A buffered write is done for file range [589824, 655360[ (length =
of
> >>      64K) and the i_size is updated to 655360. Note that we got a sing=
le
> >>      large folio for the range (64K);
> >>
> >>   3) A truncate operation starts that reduces the inode's i_size down =
to
> >>      610969 bytes. The truncate sets the inode's new i_size at
> >>      btrfs_setsize() by calling truncate_setsize() and before calling
> >>      btrfs_truncate();
> >>
> >>   4) At btrfs_truncate() we trigger writeback for the range starting a=
t
> >>      610304 (which is the new i_size rounded down to the sector size) =
and
> >>      ending at (u64)-1;
> >>
> >>   5) During the writeback, at extent_write_cache_pages(), we get from =
the
> >>      call to filemap_get_folios_tag(), the 64K folio that starts at fi=
le
> >>      offset 589824 since it contains the start offset of the writeback
> >>      range (610304);
> >>
> >>   6) At writepage_delalloc() we find the whole range of the folio is
> >> dirty
> >>      and therefore we run delalloc for that 64K range ([589824, 655360=
[),
> >>      reserving a 64K extent, creating an ordered extent, etc;
> >>
> >>   7) At extent_writepage_io() we submit IO only for subrange [589824,
> >> 614400[
> >>      because the inode's i_size is 610969 bytes (rounded up by sector
> >> size
> >>      is 614400). There, in the while loop we intentionally skip IO bey=
ond
> >>      i_size to avoid any unnecessay work and just call
> >>      btrfs_mark_ordered_io_finished() for the range [614400,
> >> 655360[ (which
> >>      has a 40K length);
> >>
> >>   8) Once the IO finishes we finish the ordered extent by ending up at
> >>      btrfs_finish_one_ordered(), join transaction N, insert a file ext=
ent
> >>      item in the inode's subvolume tree for file offset 589824 with a
> >> number
> >>      of bytes of 64K, and update the inode's delayed inode item or
> >> directly
> >>      the inode item with a call to btrfs_update_inode_fallback(), whic=
h
> >>      results in storing the new i_size of 610969 bytes;
> >>
> >>   9) Transaction N is committed either by the transaction kthread or s=
ome
> >>      other task committed it (in response to a sync or fsync for
> >> example).
> >>
> >>      At this point we have inode I persisted with an i_size of 610969
> >> bytes
> >>      and file extent item that starts at file offset 589824 and has a
> >> number
> >>      of bytes of 64K, ending at an offset of 655360 which is beyond th=
e
> >>      i_size rounded up to the sector size (614400).
> >>
> >>      --> So after a crash or power failure here, the btrfs check progr=
am
> >>          reports that error about missing checksum items for this
> >> inode, as
> >>     it tries to lookup for checksums covering the whole range of the
> >>     extent;
> >>
> >> 10) Only after transaction N is commited that at btrfs_truncate() the
> >> call
> >>      to btrfs_start_transaction() starts a new transaction, N + 1,
> >> instead
> >>      of joining transaction N. And it's with transaction N + 1 that it
> >> calls
> >>      btrfs_truncate_inode_items() which updates the file extent item
> >> at file
> >>      offset 589824 to reduce its number of bytes from 64K down to 24K,=
 so
> >>      that the file extent item's range ends at the i_size rounded up
> >> to the
> >>      sector size - 614400 bytes.
> >
> > Thanks a lot for the detailed reason.
> >
> >>
> >> So fix this by skipping the search of csum items beyond the sector tha=
t
> >> contains a file's i_size.
> >>
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >> ---
> >>   check/main.c | 13 +++++++++++++
> >
> > And lowmem mode is missing the same handling.
> >
> > In lowmem mode if we hit a file extent we still expect @csum_found to
> > match @search_len.
>
> Another thing I'm wondering is, can we make the beyond i_size writes to
> behave more like truncated ordered extent.
>
> With truncated OE, the num_bytes of the file extent will still be inside
> the rounded up inodes, and the existing btrfs check will handle them
> correctly.

I tried before to invalidate the range with
truncate_inode_pages_range() after setting the new i_size in the
truncate path and before flushing delalloc/wait for ordered extents,
but it was causing issues.

I managed to make it simpler by only truncating the ordered extent in
the writeback path where we skip bio submissions past i_size, and it's
working.
Just sent a patchset with that approach.

Thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks,
> > Qu
> >
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/check/main.c b/check/main.c
> >> index 49a6ad25..f4a135c1 100644
> >> --- a/check/main.c
> >> +++ b/check/main.c
> >> @@ -1774,6 +1774,19 @@ static int process_file_extent(struct
> >> btrfs_root *root,
> >>           else
> >>               disk_bytenr +=3D extent_offset;
> >> +        /*
> >> +         * A truncate, reducing a file's size, can temporarily leave =
an
> >> +         * inode with the new i_size falling somewhere in the middle =
of
> >> +         * the last file extent item without having any csum items fo=
r
> >> +         * blocks past the new i_size (rounded up to the i_size). Thi=
s
> >> +         * happens when the new i_size falls in the middle of a delal=
loc
> >> +         * range and that file range does not have yet any allocated
> >> +         * extents. So make sure we don't search for csum items beyon=
d
> >> +         * the i_size.
> >> +         */
> >> +        if (key->offset + num_bytes > rec->isize)
> >> +            num_bytes =3D round_up(rec->isize, gfs_info->sectorsize) =
-
> >> key->offset;
> >> +
> >>           ret =3D count_csum_range(disk_bytenr, num_bytes, &found);
> >>           if (ret < 0)
> >>               return ret;
> >
> >
>

