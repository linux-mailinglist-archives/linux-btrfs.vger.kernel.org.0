Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AED14105
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2019 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEEQYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 May 2019 12:24:44 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36889 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfEEQYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 May 2019 12:24:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id l17so3808264uar.4
        for <linux-btrfs@vger.kernel.org>; Sun, 05 May 2019 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TG3DRpmRMchcOCepUftAo2plnM8+4L3h43S5j+3fo+8=;
        b=K4D1uYOOKpq40hkmcG90UO5Ab+aZpUpv+Lbf5VMcBD3JzIXhxVkSmqz16UDmrG2HLb
         fLDkpxOHKnEQwTfq0ewytu85yVAkwhMKoEys93z7ybjglWR6R+Y/z/05ZZ0XfkdR+mDP
         SdIJzBhrFS8eMNkmD46rmFbwSm2gqBJ+CYdtqWreD42JiYdtNLqH3DpIUfamhr665XPg
         c4S60kK2tBhGkFM71dLjkd7gv2JSqW8mqlhY4A2MvPgw/45npKK6HOtYRlV7zA0L6PUo
         iQdiFZ4RDzE9/EjOuQsuBWZ5z1eDRDDGJ9BwIjj3sUI16UnGXnly2R0x/rv5QFUM+pl1
         ebgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TG3DRpmRMchcOCepUftAo2plnM8+4L3h43S5j+3fo+8=;
        b=ULpNSusRS3ZwFKRsQwo4ipXVukF+Az0QtBNWSmHhWyYYVgZ4t2KATocfjKMewBKvbt
         ExIwbAyDW03wXpfGgnjUyBRd0iDYQhtifdErUOyWbudYQbg6IhHH9CuLKW0mWsnPEtY4
         6VoCTu4MOQkTrWD7M8AzweybQMwCt9QIBB24KFBYs9wbCCqzdWTOW+2N5i1GR7OqQZVJ
         UzgCDYC25J/M2AlEjYR5w3t0mZmRde5D1P32b6wAS5PQWZcdDP35ThHczfWpFtFxUxBZ
         26eJXSfdzyjybnOpN5gij7My1pl7uaDq3nOBaiefTVRMZt0cQg8oR4mz40teo/2kmwiQ
         mQ+w==
X-Gm-Message-State: APjAAAVkKoPsEzydi4Lb85r1Rr4padVsjh++7TbzkdI59c+Ou/5HvSxr
        fu0bB7X48fLchVF61OhHznrCMlwpTkFq+Q9mIgg=
X-Google-Smtp-Source: APXvYqzPpuXrqQdUqMdGKNo2H4UzT251VLRGCnJZzAS0Gc5XBU1oVUCWeaNLcQLyl7ZVkyuvQavAgOVt4/cVFNclE2o=
X-Received: by 2002:a9f:326e:: with SMTP id y43mr2416460uad.83.1557073480134;
 Sun, 05 May 2019 09:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190503010852.10342-1-wqu@suse.com> <20190503215622.GC20359@hungrycats.org>
 <448c9a50-98b0-15aa-cbde-81b294bd74e4@gmx.com> <20190505150724.GD20359@hungrycats.org>
In-Reply-To: <20190505150724.GD20359@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sun, 5 May 2019 17:24:29 +0100
Message-ID: <CAL3q7H4mQ1MggsxiugFfnCmDaSgNjD==VKg=FsOzRwAbS8cw2g@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 5, 2019 at 4:33 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Sat, May 04, 2019 at 08:32:11AM +0800, Qu Wenruo wrote:
> >
> >
> > On 2019/5/4 =E4=B8=8A=E5=8D=885:56, Zygo Blaxell wrote:
> > > On Fri, May 03, 2019 at 09:08:52AM +0800, Qu Wenruo wrote:
> > >> [BUG]
> > >> The following command can lead to unexpected data COW:
> > >>
> > >>   #!/bin/bash
> > >>
> > >>   dev=3D/dev/test/test
> > >>   mnt=3D/mnt/btrfs
> > >>
> > >>   mkfs.btrfs -f $dev -b 1G > /dev/null
> > >>   mount $dev $mnt -o nospace_cache
> > >>
> > >>   xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
> > >>   xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
> > >>   umount $dev
> > >>
> > >> The result extent will be
> > >>
> > >>    item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
> > >>            generation 6 type 2 (prealloc)
> > >>            prealloc data disk byte 13631488 nr 28672
> > >>    item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
> > >>            generation 6 type 1 (regular)
> > >>            extent data disk byte 13660160 nr 12288 <<< COW
> > >>    item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
> > >>            generation 6 type 2 (prealloc)
> > >>            prealloc data disk byte 13631488 nr 28672
> > >>
> > >> Currently we always reserve space even for NOCOW buffered write, thu=
s
> > >> under most case it shouldn't cause anything wrong even we fall back =
to
> > >> COW.
> > >>
> > >> However when we're out of data space, we fall back to skip data spac=
e if
> > >> we can do NOCOW write.
> > >>
> > >> If such behavior happens under that case, we could hit the following
> > >> problems:
> > >> - data space bytes_may_use underflow
> > >>   This will cause kernel warning.
> > >>
> > >> - ENOSPC at delalloc time
> > >>   This will lead to transaction abort and fs forced to RO.
> > >>
> > >> [CAUSE]
> > >> This is due to the fact that btrfs can only do extent level share ch=
eck.
> > >>
> > >> Btrfs can only tell if an extent is shared, no matter if only part o=
f the
> > >> extent is shared or not.
> > >>
> > >> So for above script we have:
> > >> - fallocate
> > >> - buffered write
> > >>   If we don't have enough data space, we fall back to NOCOW check.
> > >>   At this timming, the extent is not shared, we can skip data
> > >>   reservation.
> > >> - reflink
> > >>   Now part of the large preallocated extent is shared.
> > >> - delalloc kicks in
> > >>   For the NOCOW range, as the preallocated extent is shared, we need
> > >>   to fall back to COW.
> > >>
> > >> [WORKAROUND]
> > >> The workaround is to ensure any buffered write in the related extent=
s
> > >> (not the reflink source range) get flushed before reflink.
> > >>
> > >> However it's pretty expensive to do a comprehensive check.
> > >> In the reproducer, the reflink source is just a part of a larger
> > >> preallocated extent, we need to flush all buffered write of that ext=
ent
> > >> before reflink.
> > >> Such backward search can be complex and we may not get much benefit =
from
> > >> it.
> > >>
> > >> So this patch will just try to flush the whole inode before reflink.
> > >
> > > Does that mean that if a large file is being written and deduped
> > > simultaneously, that the dedupes would now trigger flushes over the
> > > entire file?  That seems like it could be slow.
> >
> > Yes, also my reason for RFC.
> >
> > But it shouldn't be that heavy, as after the first dedupe/reflink, most
> > IO should be flushed back, later dedupe has much less work to do.
>
> Sure, but if writes are continuously happening (e.g. writes at offset
> 10GB, dedupe at 1GB), these will get flushed out on the next dedupe.
> I'm thinking of scenarious where both writes and dedupes are happening
> continuously, e.g. a host with multiple VM images running out of raw
> image files that are deduped on the host filesystem.
>
> I'm not sure what all the conditions for this flush are.  From the list
> above, it sounds like this only occurs _after_ the filesystem has found
> there is no free space.  If that's true, then the extra overhead is
> negligible since it rarely happens (assuming that having no free space
> is a rare condition for filesystems).

The problem is not that flush is done only when low on available space.
The flush would always happen on the entire source file before
reflinking, so that buffered writes that happened before the
clone/dedupe operation and "entered" nodatacow mode (because at the
time there was not enough available data space) will not fail when
their writeback starts - which would happen after the reflinking -
that's why the entire range is flushed.

Even if btrfs' reference counts are tracked per extent and not per
block, here we could maybe do something like check each reference,
extract the inode number, root number and offset. Then use that to
find the respective file extent items, and using those extract their
length and determine exactly which parts (blocks) of an extent are
shared. That would be a lot of work to do, and would always be racy
for checks for inodes that are not the inode we have locked for the
reflink operation. Very impractical.

So it's one more big inconvenience from the extent based back
references, other then the already known space wasting inconvenience
(even if only 1 block of an extent is really referenced, the rest of
the extent is unavailable for allocation, considered used space).



>
>
> > > e.g. if the file is a big VM image file and it is used src and for de=
dupe
> > > (which is quite common in VM image files), we'd be hammering the disk
> > > with writes similar to hitting it with fsync() in a tight loop?
> >
> > The original behavior also flush the target and source range, so we're
> > not completely creating some new overhead.
> >
> > Thanks,
> > Qu
> >
> > >
> > >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > >> ---
> > >> Reason for RFC:
> > >> Flushing an inode just because it's a reflink source is definitely
> > >> overkilling, but I don't have any better way to handle it.
> > >>
> > >> Any comment on this is welcomed.
> > >> ---
> > >>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
> > >>  1 file changed, 22 insertions(+)
> > >>
> > >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > >> index 7755b503b348..8caa0edb6fbf 100644
> > >> --- a/fs/btrfs/ioctl.c
> > >> +++ b/fs/btrfs/ioctl.c
> > >> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct =
file *file, struct file *file_src,
> > >>                    return ret;
> > >>    }
> > >>
> > >> +  /*
> > >> +   * Workaround to make sure NOCOW buffered write reach disk as NOC=
OW.
> > >> +   *
> > >> +   * Due to the limit of btrfs extent tree design, we can only have
> > >> +   * extent level share view. Any part of an extent is shared then =
the
> > >> +   * whole extent is shared and any write into that extent needs to=
 fall
> > >> +   * back to COW.
> > >> +   *
> > >> +   * NOCOW buffered write without data space reserved could to lead=
 to
> > >> +   * either data space bytes_may_use underflow (kernel warning) or =
ENOSPC
> > >> +   * at delalloc time (transaction abort).
> > >> +   *
> > >> +   * Here we take a shortcut by flush the whole inode. We could do =
better
> > >> +   * by finding all extents in that range and flush the space refer=
ring
> > >> +   * all those extents.
> > >> +   * But that's too complex for such corner case.
> > >> +   */
> > >> +  filemap_flush(src->i_mapping);
> > >> +  if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> > >> +               &BTRFS_I(src)->runtime_flags))
> > >> +          filemap_flush(src->i_mapping);
> > >> +
> > >>    /*
> > >>     * Lock destination range to serialize with concurrent readpages(=
) and
> > >>     * source range to serialize with relocation.
> > >> --
> > >> 2.21.0
> > >>
> >
>
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
