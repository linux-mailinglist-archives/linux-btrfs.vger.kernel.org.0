Return-Path: <linux-btrfs+bounces-17706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155EBD2F53
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60EA3C5282
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7162701CC;
	Mon, 13 Oct 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKcu/uWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73623BCE3
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358408; cv=none; b=bt+beUcakyrWqw9PSQ9fVMub1AkfuNNIgpLxBH/kmG+RGKOU9ZBjbhvoNQc7fhzc+tLJwKumUBU71vTnY33Y/s0NDwtGqgUjDkCK5qSoJ9JU24sUvFZ9tW7b44aiaaEHylbPeVg5ua5uSjS/0dMQ7/a/0X/1Wlk0HMIMU4LhJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358408; c=relaxed/simple;
	bh=pky+xpQzi61wLeiaMNkWBQe5zJKtZ6P+E0vaXL/cCPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k47pwn+GKaN6r2ovAopRc7W0/XSiaCrDwE1O9ne0eiMmZOxBWWwVuRvZJfD3IGz8ZG2Du2bLf2RIaVKNEV2QAC1uMEiCA6CSXEtG+5zGRYh0D+f5d05YmcV8X2BPUgsKm+0HjqbKO/kbha44Ikag1pBTZquVDLUYYVbj5eT6yRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKcu/uWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C901C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358405;
	bh=pky+xpQzi61wLeiaMNkWBQe5zJKtZ6P+E0vaXL/cCPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KKcu/uWmXSg4EBOcQBoxmSXkYbzkAT//91IE7Cjvwt0byhx2vLv8/KRf05ZuqggmK
	 xEa9mVCusoc8vw/04ki8IHSwj4czqiA4AHBhgKIPvux5+HTQ8d35usX0Atx2+h8r4c
	 r3j1bsd6MRw66DKKMCPp7QzKBBvinoMsK+5FXFEpujCS5sTo8n/7edPCIzd+4J/vs9
	 jHGewUF0ERDWYkFZ953KLEgrt9Sks9XR/IH6LOWrhxPU4C/P55PERBmPh5lRfN5uhV
	 IH4ykrxz4TqXdwGuTqJBbZEJkLPvrTkOWvkm9yy6yF3yAureuDuAn+mJ0/H1gBZPLN
	 JJHZvUu7bS12A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso686728766b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:26:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyg+jYERa6hBOXl/0e36ywT+Lld5uV4n12EbWVlLIvk/jxnTi6P
	uIlXkcQyIz82DW8yn+cPEBYUoLs1S+qlwoE/4UU5qjjC8gVNDw2y3yteMhbJV49AyAiYCtxhU/Q
	qKe2uDi/57yHFpqMXlAtYYxGSodHPbRc=
X-Google-Smtp-Source: AGHT+IEAUgRJ8cqj+RmFe62QDrYltdZ4kMYuzcdmO2RNpwXXq018vdP7LhZciaOonWgirMFULuCbdbGRAYswKXdKvKo=
X-Received: by 2002:a17:907:7287:b0:afd:d94b:830d with SMTP id
 a640c23a62f3a-b50ace22561mr1998866366b.62.1760358404048; Mon, 13 Oct 2025
 05:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e3df8da61ea11e45809208e3795452c5291f467.1760028487.git.fdmanana@suse.com>
 <5d465706-b7bd-4302-89d1-7f6b5e16e350@gmx.com>
In-Reply-To: <5d465706-b7bd-4302-89d1-7f6b5e16e350@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 Oct 2025 13:26:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6=dbEFt8ZX4=wT35oMMoWRjqPwSTQ8N192xyZATSLwRw@mail.gmail.com>
X-Gm-Features: AS18NWDzldR8zb0hJC6rw81en5RqVjJGDoHibq4U-EP95s7WhItFIryXVvDYXto
Message-ID: <CAL3q7H6=dbEFt8ZX4=wT35oMMoWRjqPwSTQ8N192xyZATSLwRw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: check: stop checking for csums past i_size
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:38=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2025/10/10 03:19, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > While running test case btrfs/192 from fstests on a kernel with support=
 for
> > large folios (needs CONFIG_BTRFS_EXPERIMENTAL=3Dy kernel configuration =
at the
> > moment) I ended up getting very sporadic btrfs check failures reporting
> > that csum items were missing. Looking into the issue it turned out that=
 we
> > end up looking for csum items of a file extent item with a range that s=
pans
> > beyond the i_size of a file and we don't have any, because the kernel's
> > writeback code skips submitting bios for ranges beyond eof.
> >
> > Example output when this happens:
> >
> >    $ btrfs check /dev/sdc
> >    Opening filesystem to check...
> >    Checking filesystem on /dev/sdc
> >    UUID: 69642c61-5efb-4367-aa31-cdfd4067f713
> >    [1/8] checking log skipped (none written)
> >    [2/8] checking root items
> >    [3/8] checking extents
> >    [4/8] checking free space tree
> >    [5/8] checking fs roots
> >    root 5 inode 332 errors 1000, some csum missing
> >    ERROR: errors found in fs roots
> >    (...)
> >
> > Looking at a tree dump of the fs tree (root 5) for inode 332 we have:
> >
> >     $ btrfs inspect-internal dump-tree -t 5 /dev/sdc
> >     (...)
> >          item 28 key (332 INODE_ITEM 0) itemoff 2006 itemsize 160
> >                  generation 17 transid 19 size 610969 nbytes 86016
> >                  block group 0 mode 100666 links 1 uid 0 gid 0 rdev 0
> >                  sequence 11 flags 0x0(none)
> >                  atime 1759851068.391327881 (2025-10-07 16:31:08)
> >                  ctime 1759851068.410098267 (2025-10-07 16:31:08)
> >                  mtime 1759851068.410098267 (2025-10-07 16:31:08)
> >                  otime 1759851068.391327881 (2025-10-07 16:31:08)
> >          item 29 key (332 INODE_REF 340) itemoff 1993 itemsize 13
> >                  index 2 namelen 3 name: f1f
> >          item 30 key (332 EXTENT_DATA 589824) itemoff 1940 itemsize 53
> >                  generation 19 type 1 (regular)
> >                  extent data disk byte 21745664 nr 65536
> >                  extent data offset 0 nr 65536 ram 65536
> >                  extent compression 0 (none)
> >     (...)
> >
> > We can see that the file extent item for file offset 589824 has a lengt=
h of
> > 64K and its number of bytes is 64K. Looking at the inode item we see th=
at
> > its i_size is 610969 bytes which falls within the range of that file ex=
tent
> > item [589824, 655360[.
> >
> > Looking into the csum tree:
> >
> >    $ btrfs inspect-internal dump-tree /dev/sdc
> >    (...)
> >          item 15 key (EXTENT_CSUM EXTENT_CSUM 21565440) itemoff 991 ite=
msize 200
> >                  range start 21565440 end 21770240 length 204800
> >             item 16 key (EXTENT_CSUM EXTENT_CSUM 1104576512) itemoff 98=
3 itemsize 8
> >                  range start 1104576512 end 1104584704 length 8192
> >    (..)
> >
> > We see that the csum item number 15 covers the first 24K of the file ex=
tent
> > item - it ends at offset 21770240 and the extent's disk_bytenr is 21745=
664,
> > so we have:
> >
> >     21770240 - 21745664 =3D 24K
> >
> > We see that the next csum item (number 16) is completely outside the ra=
nge,
> > so the remaining 40K of the extent doesn't have csum items in the tree.
> >
> > If we round up the i_size to the sector size, we get:
> >
> >     round_up(610969, 4096) =3D 614400
> >
> > If we subtract from that the file offset for the extent item we get:
> >
> >     614400 - 589824 =3D 24K
> >
> > So the missing 40K corresponds to the end of the file extent item's ran=
ge
> > minus the rounded up i_size:
> >
> >     655360 - 614400 =3D 40K
> >
> > Normally we don't expect a file extent item to span over the rounded up
> > i_size of an inode, since when truncating, doing hole punching and othe=
r
> > operations that trim a file extent item, the number of bytes is adjuste=
d.
> >
> > There is however a short time window where the kernel can end up,
> > temporarily,persisting an inode with an i_size that falls in the middle=
 of
> > the last file extent item and the file extent item was not yet trimmed =
(its
> > number of bytes reduced so that it doesn't cross i_size rounded up by t=
he
> > sector size).
> >
> > The steps (in the kernel) that lead to such scenario are the following:
> >
> >   1) We have inode I as an empty file, no allocated extents, i_size is =
0;
> >
> >   2) A buffered write is done for file range [589824, 655360[ (length o=
f
> >      64K) and the i_size is updated to 655360. Note that we got a singl=
e
> >      large folio for the range (64K);
> >
> >   3) A truncate operation starts that reduces the inode's i_size down t=
o
> >      610969 bytes. The truncate sets the inode's new i_size at
> >      btrfs_setsize() by calling truncate_setsize() and before calling
> >      btrfs_truncate();
> >
> >   4) At btrfs_truncate() we trigger writeback for the range starting at
> >      610304 (which is the new i_size rounded down to the sector size) a=
nd
> >      ending at (u64)-1;
> >
> >   5) During the writeback, at extent_write_cache_pages(), we get from t=
he
> >      call to filemap_get_folios_tag(), the 64K folio that starts at fil=
e
> >      offset 589824 since it contains the start offset of the writeback
> >      range (610304);
> >
> >   6) At writepage_delalloc() we find the whole range of the folio is di=
rty
> >      and therefore we run delalloc for that 64K range ([589824, 655360[=
),
> >      reserving a 64K extent, creating an ordered extent, etc;
> >
> >   7) At extent_writepage_io() we submit IO only for subrange [589824, 6=
14400[
> >      because the inode's i_size is 610969 bytes (rounded up by sector s=
ize
> >      is 614400). There, in the while loop we intentionally skip IO beyo=
nd
> >      i_size to avoid any unnecessay work and just call
> >      btrfs_mark_ordered_io_finished() for the range [614400, 655360[ (w=
hich
> >      has a 40K length);
> >
> >   8) Once the IO finishes we finish the ordered extent by ending up at
> >      btrfs_finish_one_ordered(), join transaction N, insert a file exte=
nt
> >      item in the inode's subvolume tree for file offset 589824 with a n=
umber
> >      of bytes of 64K, and update the inode's delayed inode item or dire=
ctly
> >      the inode item with a call to btrfs_update_inode_fallback(), which
> >      results in storing the new i_size of 610969 bytes;
> >
> >   9) Transaction N is committed either by the transaction kthread or so=
me
> >      other task committed it (in response to a sync or fsync for exampl=
e).
> >
> >      At this point we have inode I persisted with an i_size of 610969 b=
ytes
> >      and file extent item that starts at file offset 589824 and has a n=
umber
> >      of bytes of 64K, ending at an offset of 655360 which is beyond the
> >      i_size rounded up to the sector size (614400).
> >
> >      --> So after a crash or power failure here, the btrfs check progra=
m
> >          reports that error about missing checksum items for this inode=
, as
> >       it tries to lookup for checksums covering the whole range of the
> >       extent;
> >
> > 10) Only after transaction N is commited that at btrfs_truncate() the c=
all
> >      to btrfs_start_transaction() starts a new transaction, N + 1, inst=
ead
> >      of joining transaction N. And it's with transaction N + 1 that it =
calls
> >      btrfs_truncate_inode_items() which updates the file extent item at=
 file
> >      offset 589824 to reduce its number of bytes from 64K down to 24K, =
so
> >      that the file extent item's range ends at the i_size rounded up to=
 the
> >      sector size - 614400 bytes.
>
> Thanks a lot for the detailed reason.
>
> >
> > So fix this by skipping the search of csum items beyond the sector that
> > contains a file's i_size.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   check/main.c | 13 +++++++++++++
>
> And lowmem mode is missing the same handling.
>
> In lowmem mode if we hit a file extent we still expect @csum_found to
> match @search_len.

Yes, I forgot lowmem mode.

But it turned out the normal mode has a bug, and this patch could
trigger it with btrfs/034.
The file extent items for an inode are spread over multiple leaves,
and all the leaves are shared due to snapshots.
When we read the first leaf we find the inode item and store an inode
record with the i_size etc in:

wc->nodes[wc->active_node].inode_cache

But then when we move to the second leaf, and find more file extent
items for the inode, we have reset the state in a call to
leave_shared_node().
So we lose all information about the inode and process_one_leaf()
creates a new inode record with a 0 i_size.
Since nothing in process_file_extent_item() currently uses rec->isize,
the bug was not detected before.

Not sure why we have that logic to reset the state, from a quick I
can't find why it's needed.
If the leaves aren't shared, everything works.

Also, lowmem mode works and doesn't have this bug.

Anyway, I've addressed the issue in the kernel and this won't be needed.

>
> Thanks,
> Qu
>
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/check/main.c b/check/main.c
> > index 49a6ad25..f4a135c1 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -1774,6 +1774,19 @@ static int process_file_extent(struct btrfs_root=
 *root,
> >               else
> >                       disk_bytenr +=3D extent_offset;
> >
> > +             /*
> > +              * A truncate, reducing a file's size, can temporarily le=
ave an
> > +              * inode with the new i_size falling somewhere in the mid=
dle of
> > +              * the last file extent item without having any csum item=
s for
> > +              * blocks past the new i_size (rounded up to the i_size).=
 This
> > +              * happens when the new i_size falls in the middle of a d=
elalloc
> > +              * range and that file range does not have yet any alloca=
ted
> > +              * extents. So make sure we don't search for csum items b=
eyond
> > +              * the i_size.
> > +              */
> > +             if (key->offset + num_bytes > rec->isize)
> > +                     num_bytes =3D round_up(rec->isize, gfs_info->sect=
orsize) - key->offset;
> > +
> >               ret =3D count_csum_range(disk_bytenr, num_bytes, &found);
> >               if (ret < 0)
> >                       return ret;
>

