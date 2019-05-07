Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C454F162F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfEGLhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 07:37:01 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35759 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGLhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 07:37:01 -0400
Received: by mail-ua1-f68.google.com with SMTP id g16so5879186uad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iO6xdgL+NmTi6/tMHQhaTaXs/P7Hs1Vqj1E+VqZbgbI=;
        b=fh4sjnStHVHdw0rENa3MijivdGS2RR4oiCxM9eI7D94xHy6+4E+w04khCZzaCnqfA4
         ZRziLEFOaT2Q8DQ0FlbkxXVyghXNRkYE2MsHvrN/eMdrd8Vn0uq8JVbMXlDCyU/p8KGZ
         KZLVZi1Gp1nbvTjpzJX3kAovjGyu++eqnpEL6nLD0tG8cObKWHTaY91lpQ64IcIp/pVL
         dTlvekmrGmrHyIx4OjofodOSzU2pQmkk3eQY91sMCXBPC6fJuaozvEDer1nXv4PtQgrM
         tspBPxzFCgleBF79o7X5xe6E0OUf8ObX7k+1yUYxPZXGLCzMNbbH0uAURk63jZrXeZWk
         hELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iO6xdgL+NmTi6/tMHQhaTaXs/P7Hs1Vqj1E+VqZbgbI=;
        b=s/ExBv2cJgBhKqBnoSTRcPwgN2aSjOM7naI5SjYDSiJqARORPE73idALJX58AOF5hA
         DfKHDDhTiZp7fAQCE58MB9cQM4uneYgxsJFYzIEwVMoJ0NOp7zuPBLYKt9HVtAEMOpHi
         GWAN1SctYaIYM4mOljhiZ6iyaozF9H4aBEiPNzqVD//a3+6R4E7pxuhprLlvjT0kSzVa
         FvRcD6EbYazXgaw8XQxaU2lZijhBA2361gb1dQN/wgVZiP0hUvyKTmjWRD2oiSGb3ZqH
         5aoRxQHCvelylZ8nCM1P+sEBUzcBPneqCNyaVUbGdk4Bu0dywHPGoE/H6V4368HEuopS
         chEA==
X-Gm-Message-State: APjAAAVWjU/0dCH7lo0dffAEH5sC72yCS8IhUK6b1okrIXg+L/1oryZ7
        py8ZikvjpiRzvqqPoFCYiIo5pGcUK0nsULrmGn8A/Fgv
X-Google-Smtp-Source: APXvYqyTpbF5/3wNv/WkEG7PoUmnmjBYPAOtK+Kks6qKmZCnna68krqxU57GgxjAlDruwhzCvFljQIivBxnWVllSiBQ=
X-Received: by 2002:ab0:3351:: with SMTP id h17mr9606095uap.123.1557229019457;
 Tue, 07 May 2019 04:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190503010852.10342-1-wqu@suse.com> <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com> <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
 <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com> <CAL3q7H7jmCnObo4Mtnnm9_07pePySbsRqdOFX+348s_q4VnA2Q@mail.gmail.com>
 <028e58f3-99a6-f4bc-51f0-12eafee92c76@gmx.com>
In-Reply-To: <028e58f3-99a6-f4bc-51f0-12eafee92c76@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 7 May 2019 12:36:47 +0100
Message-ID: <CAL3q7H7GbZNf1bCrYbBF3Gn54zP2xpaOMBUebnTnsMnCzxUraQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 7, 2019 at 12:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/5/7 =E4=B8=8B=E5=8D=884:56, Filipe Manana wrote:
> > On Mon, May 6, 2019 at 3:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >> [snip]
> >>>>
> >>>> For data writeback, it should only cause sync related failure.
> >>>
> >>> Ok, so please remove the transaction abort comments for next iteratio=
n.
> >>> By sync related failure, you mean running dealloc fails with ENOSPC,
> >>> since when it tries to reserve a data extent it fails as it can't fin=
d
> >>> any free extent.
> >>
> >> Well, btrfs has some hidden way to fix such problem by itself already.
> >>
> >> At buffered write time, we have the following call chain:
> >> btrfs_buffered_write()
> >> |- btrfs_check_data_free_space()
> >>    |- btrfs_alloc_data_chunk_ondemand()
> >>       |- need_commit =3D 2; /* We have 2 chance to retry, 1 to flush *=
/
> >>       |- do_chunk_alloc() /* we have no data space available */
> >>       |- if (ret < 0 && ret =3D=3D -ENOSPC)
> >>       |-     goto commit_trans;  /* try to free some space */
> >>       |- commit_trans:
> >>       |-     need_commit--;
> >>       |-     if (need_commit > 0) {
> >>       |-         btrfs_start_delalloc_roots();
> >>       |-         btrfs_wait_ordered_roots();
> >>       |-     }
> >>
> >> This means, as long as we hit ENOSPC for data space, we will start wri=
te
> >> back, thus NODATACOW data will still hit disk as NODATACOW.
> >>
> >> Such hidden behavior along with always-reserve-data-space solves the
> >> problem pretty well.
> >
> > It doesn't solve the problem you reported in the rfc patch.
>
> You're right, it doesn't solve the problem at all.
> In fact, another bug caused my test script to pass even with some dirty
> pages unable to be flushed back.
>
> But it at least make sure all other pages reach disk as NODATACOW except
> the last page.
>
> >
> > What happens:
> >
> > 1) We have a file with a prealloc extent, that isn't shared
> >
> > 2) We have 0 bytes of available data space (or any amount less then
> > that of the buffered write size)
> >
> > 3) A buffered write happens that falls within a subrange of the preallo=
c extent.
> >     We can't reserve space, we do all those things at
> > btrfs_alloc_data_chunk_ondemand(), but we can't get any data space
> > released, since it's all allocated.
>
> At that time, we're already flushing all previously buffered write data.
>
> E.g. if we're writing into one 1M preallocated extent.
> The first 4K, we have no data space reserved, dirtied the page, prepare
> all delalloc.
>
> Then the 2nd 4K, we call btrfs_check_data_free_space(), as we're at low
> data free space already, we flush all inodes, including the previous 4K
> we just dirtied.
> Then the first 4K get written to disk NODATACOW, as expected.
>
> This loop happens until we reach the last page.

We fragment a buffered write into several chunks depending on its
size, the size of a page, the size of a pointer, etc.
We will hardly iterate for each page alone.
If your point is that btrfs_check_data_free_space() can be called
multiple times for a single buffered write, yes, that's true if it's
large than a certain threshold, but that will hardly be for each
individual page, typically it's much more than that.

>
> >     Therefore we fall back to nodatacow mode. We dirty the pages, mark
> > the range as dealloc, etc.
> >
> > 4) The reflink happens, for a subrange of the prealloc extent that
> > does not overlap the range of the buffered write.
>
> Just before the reflink, we only have 1 dirty page (the last page of
> that buffered write) doesn't reach disk yet.
>
> For the final page, we have no choice but do COW, and it fails with -ENOS=
PC.

Yes, isn't that what I said?

>
> However due to some other problem, the -ENOSPC doesn't reach user space
> at all.

Yes, isn't that what I said?

Yes... Same as the snapshotting case Robbie fixed. No news here.
Same as many other silent data loss issues I fixed with fsync a few
times sometime ago as well.

>
>
> >
> > 5) Some time after the reflink, writeback starts for the inode.
> >     During the writeback we fallback to COW mode, because the prealloc
> > extent is shared, even if the subrange of the buffered write does not
> > overlap the reflinked subrange.
> >     Now the write silently fails with -ENOSPC, and a user doesn't know
> > about it unless it does an fsync after that writeback, which will
> > report the error via filemap_check_wb_err().
> >
> >> We either:
> >> - reserve data space
> >>   Then no matter how it ends, we're OK, although it may end as CoW.
> >>
> >> - Failed to reserve data space
> >>   Writeback will be triggered anyway, no way to screw things around.
> >>
> >> Thus this workaround has nothing to fix, but only make certain NODATAC=
OW
> >> reach disk as NODATACOW.
> >>
> >> It makes some NODATACOW behaves more correctly but won't fix any obvio=
us
> >> bug.
> >>
> >> My personal take is to fix any strange behavior even it won't cause an=
y
> >> problem, but the full inode writeback can be performance heavy.
> >>
> >> So my question is, do we really need this anyway?
> >
> > Do we need what? Your patch, that logic at
> > btrfs_alloc_data_chunk_ondemand(), something else?
>
> I meant the patch, but the deeper I dig into the problem, more problem I
> found.
>
> The patch is still needed, but there is a more important bug, that
> btrfs_run_delalloc_range() failure won't be reported in sync.

How could it report a failure?

sync calls sync(2), which returns void, meaning it always succeeds and
has no way to report errors.
See https://linux.die.net/man/2/sync

Error tracking and reporting was precisely one of main goals of
filemap_check_wb_err() and all the related work Jeff Layton did
sometime ago.

>
> The script here I'm using is:
> ------
> #!/bin/bash
>
> dev=3D/dev/test/test
> mnt=3D/mnt/btrfs
>
> #mkfs.btrfs -f $dev -b 1G > /dev/null
> #mount $dev $mnt -o nospace_cache
>
> umount $mnt &> /dev/null
> umount $dev &> /dev/null
>
> dmesg -C
> mkfs.btrfs -f $dev -b 512M > /dev/null
>
> mount $dev $mnt -o nospace_cache
>
> xfs_io -f -c "falloc 8k 64m" $mnt/file1
> xfs_io -f -c "pwrite 0 -b 4k 370M" $mnt/padding
>
> sync
> btrfs fi df $mnt --raw
>
> xfs_io -c "pwrite 1m 16m" $mnt/file1
> echo "nodatacow write finished" >> /dev/kmsg
> xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
> echo "reflink finished" >> /dev/kmsg
> sync
> echo "sync finished ret=3D$?" >> /dev/kmsg
> umount $dev
> ------
>
> As describe, the last write at 17821696 (17M - 4K) will fail due to ENOSP=
C.
> But the sync succeeded without reporting any problem.
>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>>
> >>>>> I don't recall starting transactions when running dealloc, and fail=
ed
> >>>>> to see where after a quick glance to cow_file_range()
> >>>>> and run_delalloc_nocow(). I'm assuming that 'at delalloc time' mean=
s
> >>>>> when starting writeback.
> >>>>>
> >>>>>>
> >>>>>> [CAUSE]
> >>>>>> This is due to the fact that btrfs can only do extent level share =
check.
> >>>>>>
> >>>>>> Btrfs can only tell if an extent is shared, no matter if only part=
 of the
> >>>>>> extent is shared or not.
> >>>>>>
> >>>>>> So for above script we have:
> >>>>>> - fallocate
> >>>>>> - buffered write
> >>>>>>   If we don't have enough data space, we fall back to NOCOW check.
> >>>>>>   At this timming, the extent is not shared, we can skip data
> >>>>>>   reservation.
> >>>>>
> >>>>> But in the above example we don't fall to nocow mode when doing the
> >>>>> buffered write, as there's plenty of data space available (1Gb -
> >>>>> 24Kb).
> >>>>> You need to update the example.
> >>>> I have to admit that the core part is mostly based on the worst case
> >>>> *assumption*.
> >>>>
> >>>> I'll try to make the case convincing by making it fail directly.
> >>>
> >>> Great, thanks.
> >>>
> >>>>
> >>>>>
> >>>>>
> >>>>>> - reflink
> >>>>>>   Now part of the large preallocated extent is shared.
> >>>>>> - delalloc kicks in
> >>>>>
> >>>>> writeback kicks in
> >>>>>
> >>>>>>   For the NOCOW range, as the preallocated extent is shared, we ne=
ed
> >>>>>>   to fall back to COW.
> >>>>>>
> >>>>>> [WORKAROUND]
> >>>>>> The workaround is to ensure any buffered write in the related exte=
nts
> >>>>>> (not the reflink source range) get flushed before reflink.
> >>>>>
> >>>>> not the reflink source range -> not just the reflink source range
> >>>>>
> >>>>>>
> >>>>>> However it's pretty expensive to do a comprehensive check.
> >>>>>> In the reproducer, the reflink source is just a part of a larger
> >>>>>
> >>>>> Again, the reproducer needs to be fixed (yes, I tested it even if i=
t's
> >>>>> clear by looking at it that it doesn't trigger the nocow case).
> >>>>>
> >>>>>> preallocated extent, we need to flush all buffered write of that e=
xtent
> >>>>>> before reflink.
> >>>>>> Such backward search can be complex and we may not get much benefi=
t from
> >>>>>> it.
> >>>>>>
> >>>>>> So this patch will just try to flush the whole inode before reflin=
k.
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>>>> ---
> >>>>>> Reason for RFC:
> >>>>>> Flushing an inode just because it's a reflink source is definitely
> >>>>>> overkilling, but I don't have any better way to handle it.
> >>>>>>
> >>>>>> Any comment on this is welcomed.
> >>>>>> ---
> >>>>>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
> >>>>>>  1 file changed, 22 insertions(+)
> >>>>>>
> >>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >>>>>> index 7755b503b348..8caa0edb6fbf 100644
> >>>>>> --- a/fs/btrfs/ioctl.c
> >>>>>> +++ b/fs/btrfs/ioctl.c
> >>>>>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struc=
t file *file, struct file *file_src,
> >>>>>>                         return ret;
> >>>>>>         }
> >>>>>>
> >>>>>> +       /*
> >>>>>> +        * Workaround to make sure NOCOW buffered write reach disk=
 as NOCOW.
> >>>>>> +        *
> >>>>>> +        * Due to the limit of btrfs extent tree design, we can on=
ly have
> >>>>>> +        * extent level share view. Any part of an extent is share=
d then the
> >>>>>
> >>>>> Any -> If any
> >>>>>
> >>>>>> +        * whole extent is shared and any write into that extent n=
eeds to fall
> >>>>>
> >>>>> is -> is considered
> >>>>>
> >>>>>> +        * back to COW.
> >>>>>
> >>>>> I would add, something like:
> >>>>>
> >>>>> That is, btrfs' back references do not have a block level granulari=
ty,
> >>>>> they work at the whole extent level.
> >>>>>
> >>>>>> +        *
> >>>>>> +        * NOCOW buffered write without data space reserved could =
to lead to
> >>>>>> +        * either data space bytes_may_use underflow (kernel warni=
ng) or ENOSPC
> >>>>>> +        * at delalloc time (transaction abort).
> >>>>>
> >>>>> I would omit the warning and transaction abort parts, that can chan=
ge
> >>>>> any time. And we have that information in the changelog, so it's no=
t
> >>>>> lost.
> >>>>>
> >>>>>> +        *
> >>>>>> +        * Here we take a shortcut by flush the whole inode. We co=
uld do better
> >>>>>> +        * by finding all extents in that range and flush the spac=
e referring
> >>>>>> +        * all those extents.
> >>>>>> +        * But that's too complex for such corner case.
> >>>>>> +        */
> >>>>>> +       filemap_flush(src->i_mapping);
> >>>>>> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> >>>>>> +                    &BTRFS_I(src)->runtime_flags))
> >>>>>> +               filemap_flush(src->i_mapping);
> >>>>>
> >>>>> So a few comments here:
> >>>>>
> >>>>> - why just in the clone part? The dedupe side has the same problem,=
 doesn't it?
> >>>>
> >>>> Right.
> >>>>
> >>>>>
> >>>>> - I would move such flushing to btrfs_remap_file_range_prep - this =
is
> >>>>> where we do the source and target range flush and wait.
> >>>>>
> >>>>> Can you turn the reproducer into an fstests case?
> >>>>
> >>>> Sure.
> >>>>
> >>>> Thanks for the info and all the comment,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>>> +
> >>>>>>         /*
> >>>>>>          * Lock destination range to serialize with concurrent rea=
dpages() and
> >>>>>>          * source range to serialize with relocation.
> >>>>>> --
> >>>>>> 2.21.0
> >>>>>>
> >>>>>
> >>>>>
> >>>>
> >>>
> >>>
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
