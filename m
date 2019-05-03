Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC26912BCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfECKp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 06:45:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40951 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECKp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 06:45:57 -0400
Received: by mail-vs1-f67.google.com with SMTP id e207so3284305vsd.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2019 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RB2DKwRfzgwPFDp6ZEMkmTQfqHtQ3oCAxUD9+cdtna4=;
        b=eJpL3zagCSmaRsr1WNRqN6xFEpD2aIWWs5hXEk4lcjjLBMBEkaQ/iz/4wZkOpAB+fQ
         4TsLmdvyEZT4TzTketzwl/AnDQgpQKgIuhv2CqYSWzCzm8QO0eXU3A1N6Y/9VUvW3XnF
         FqvId5ti59hnz7Ez09WEqZfrLIdMwp7G3LVcuqoBMPc5nwJnoHDcd2ebbWvogq9lbfar
         68aW9ZtS4yGfZJprs7sprSY+v/eNA3OOWNv2IYbbbS22yWQs1eT4ClGwMhictHTGQNf6
         ki3tG2oLCNSCwbTXv3Ysin93fIKgcoyvfotx3oraOi/sI00Bd7gWnwk/gbiQpIq11B8F
         tLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RB2DKwRfzgwPFDp6ZEMkmTQfqHtQ3oCAxUD9+cdtna4=;
        b=j1CzOABruRfrOvWGjutbn9UZP7jsIc1RkHC7R3ctOe84oHjd8p9f42dhBBCKnYyzJ+
         tWdiuBOQG/UdL3h1HDSz1tQr6gzvYjKhpt4370Ay/TLDjqYqKHp7wUGwic7RhvSugbP/
         8sGPvkEthf6uE57iWUV51gNC4tigX+1lYZlfHM2kQCK0mQutLqsnco7mWG+yyLhOUyoW
         lF35ZNtcOe53k/GrjXtJcY6/u9yQ263LeoeivHgo07m/H6tVjVy2ua4UqRWGbn0FlGW+
         k4shmbAr8CWvuV/rS3CjT5vDG/zoYb3HHuaeSFFxuO2kVhMdRR2ons8wjGLfDcCDnv60
         rv7g==
X-Gm-Message-State: APjAAAWjXK8SujIF5yuz+if4qxD7zawZ/FygizSfNtzxmLNk5MW+kCcX
        Bn3XzfXuIrnrqjNaY6WLOXRlLyE9h2P6uu3jC/o=
X-Google-Smtp-Source: APXvYqyCiCWmaqYZ8SM/qbUjRnnJ8EJLKSoTTK0IdgBwoFuO3kp+ciiUUIEUA5JrvRaFQNnYb9MgCIQcMS8/HT0VJt0=
X-Received: by 2002:a67:7e57:: with SMTP id z84mr4512799vsc.99.1556880355355;
 Fri, 03 May 2019 03:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190503010852.10342-1-wqu@suse.com> <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
In-Reply-To: <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 May 2019 11:45:44 +0100
Message-ID: <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
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

On Fri, May 3, 2019 at 11:18 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/5/3 =E4=B8=8B=E5=8D=885:21, Filipe Manana wrote:
> > On Fri, May 3, 2019 at 2:46 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > What a great subject. The "reflink:" part is unnecessary, since the
> > rest of the subject already mentions it, that makes it a bit shorter.
> >
> >>
> >> [BUG]
> >> The following command can lead to unexpected data COW:
> >>
> >>   #!/bin/bash
> >>
> >>   dev=3D/dev/test/test
> >>   mnt=3D/mnt/btrfs
> >>
> >>   mkfs.btrfs -f $dev -b 1G > /dev/null
> >>   mount $dev $mnt -o nospace_cache
> >>
> >>   xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
> >>   xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
> >>   umount $dev
> >>
> >> The result extent will be
> >>
> >>         item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
> >>                 generation 6 type 2 (prealloc)
> >>                 prealloc data disk byte 13631488 nr 28672
> >>         item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
> >>                 generation 6 type 1 (regular)
> >>                 extent data disk byte 13660160 nr 12288 <<< COW
> >>         item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
> >>                 generation 6 type 2 (prealloc)
> >>                 prealloc data disk byte 13631488 nr 28672
> >>
> >> Currently we always reserve space even for NOCOW buffered write, thus
> >
> > I would add 'data' between 'reserve' and 'space', to be clear.
> >
> >> under most case it shouldn't cause anything wrong even we fall back to
> >> COW.
> >
> > even we ... -> even if we fallback to COW when running delalloc /
> > starting writeback.
> >
> >>
> >> However when we're out of data space, we fall back to skip data space =
if
> >> we can do NOCOW write.
> >
> > we fall back to skip data space ... -> we fallback to NOCOW write
> > without reserving data space.
> >
> >>
> >> If such behavior happens under that case, we could hit the following
> >> problems:
> >
> >> - data space bytes_may_use underflow
> >>   This will cause kernel warning.
> >
> > Ok.
> >
> >>
> >> - ENOSPC at delalloc time
> >
> > at delalloc time - that is an ambiguous term you use through the change=
 log.
>
> In fact, I have a lot of uncertain terminology through kernel.
>
> Things like flush get referred multiple times in different context (e.g.
> filemap flush, flushoncommit, super block flush).
>
> If we have a terminology list, we can't be more happy to follow.

So, some is kernel wide while others are btrfs specific.

A buffered write creates dealloc - copies data to pages, marks the
pages as dirty and tags the range in the extent io tree as dellaloc.
Running delalloc, flushes writeback (starts IO for the dirty pages and
tags them as under writeback) and does other necessary things (like
reserving extents).
When writeback finishes, we add a task to a work queue to run
btrfs_finish_ordered_io - after that happens we say that the ordered
extent completed.

It can get ambiguous very often.

>
> > You mean when running/starting delalloc, which happens when starting wr=
iteback,
> > but that could be confused with creating delalloc, which happens
> > during the buffered write path.
>
> Another confusion due to different terminology.
>
> My understanding of the write path is:
> buffered write -> delalloc (start delalloc) -> ordered extent -> finish
> ordered io.
>
> Thus I missed the delalloc creating part.
>
> >
> > So I would always replace 'dealloc time' with 'when running delalloc'
> > (or when starting writeback).
>
> I will change use running delalloc, with extra comment reference to the
> function name (btrfs_run_delalloc_range()).
>
> >
> >>   This will lead to transaction abort and fs forced to RO.
> >
> > Where does that happen exactly?
> My bad, I got confused with metadata writeback path.
>
> For data writeback, it should only cause sync related failure.

Ok, so please remove the transaction abort comments for next iteration.
By sync related failure, you mean running dealloc fails with ENOSPC,
since when it tries to reserve a data extent it fails as it can't find
any free extent.

>
> > I don't recall starting transactions when running dealloc, and failed
> > to see where after a quick glance to cow_file_range()
> > and run_delalloc_nocow(). I'm assuming that 'at delalloc time' means
> > when starting writeback.
> >
> >>
> >> [CAUSE]
> >> This is due to the fact that btrfs can only do extent level share chec=
k.
> >>
> >> Btrfs can only tell if an extent is shared, no matter if only part of =
the
> >> extent is shared or not.
> >>
> >> So for above script we have:
> >> - fallocate
> >> - buffered write
> >>   If we don't have enough data space, we fall back to NOCOW check.
> >>   At this timming, the extent is not shared, we can skip data
> >>   reservation.
> >
> > But in the above example we don't fall to nocow mode when doing the
> > buffered write, as there's plenty of data space available (1Gb -
> > 24Kb).
> > You need to update the example.
> I have to admit that the core part is mostly based on the worst case
> *assumption*.
>
> I'll try to make the case convincing by making it fail directly.

Great, thanks.

>
> >
> >
> >> - reflink
> >>   Now part of the large preallocated extent is shared.
> >> - delalloc kicks in
> >
> > writeback kicks in
> >
> >>   For the NOCOW range, as the preallocated extent is shared, we need
> >>   to fall back to COW.
> >>
> >> [WORKAROUND]
> >> The workaround is to ensure any buffered write in the related extents
> >> (not the reflink source range) get flushed before reflink.
> >
> > not the reflink source range -> not just the reflink source range
> >
> >>
> >> However it's pretty expensive to do a comprehensive check.
> >> In the reproducer, the reflink source is just a part of a larger
> >
> > Again, the reproducer needs to be fixed (yes, I tested it even if it's
> > clear by looking at it that it doesn't trigger the nocow case).
> >
> >> preallocated extent, we need to flush all buffered write of that exten=
t
> >> before reflink.
> >> Such backward search can be complex and we may not get much benefit fr=
om
> >> it.
> >>
> >> So this patch will just try to flush the whole inode before reflink.
> >
> >
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Reason for RFC:
> >> Flushing an inode just because it's a reflink source is definitely
> >> overkilling, but I don't have any better way to handle it.
> >>
> >> Any comment on this is welcomed.
> >> ---
> >>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index 7755b503b348..8caa0edb6fbf 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct fi=
le *file, struct file *file_src,
> >>                         return ret;
> >>         }
> >>
> >> +       /*
> >> +        * Workaround to make sure NOCOW buffered write reach disk as =
NOCOW.
> >> +        *
> >> +        * Due to the limit of btrfs extent tree design, we can only h=
ave
> >> +        * extent level share view. Any part of an extent is shared th=
en the
> >
> > Any -> If any
> >
> >> +        * whole extent is shared and any write into that extent needs=
 to fall
> >
> > is -> is considered
> >
> >> +        * back to COW.
> >
> > I would add, something like:
> >
> > That is, btrfs' back references do not have a block level granularity,
> > they work at the whole extent level.
> >
> >> +        *
> >> +        * NOCOW buffered write without data space reserved could to l=
ead to
> >> +        * either data space bytes_may_use underflow (kernel warning) =
or ENOSPC
> >> +        * at delalloc time (transaction abort).
> >
> > I would omit the warning and transaction abort parts, that can change
> > any time. And we have that information in the changelog, so it's not
> > lost.
> >
> >> +        *
> >> +        * Here we take a shortcut by flush the whole inode. We could =
do better
> >> +        * by finding all extents in that range and flush the space re=
ferring
> >> +        * all those extents.
> >> +        * But that's too complex for such corner case.
> >> +        */
> >> +       filemap_flush(src->i_mapping);
> >> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> >> +                    &BTRFS_I(src)->runtime_flags))
> >> +               filemap_flush(src->i_mapping);
> >
> > So a few comments here:
> >
> > - why just in the clone part? The dedupe side has the same problem, doe=
sn't it?
>
> Right.
>
> >
> > - I would move such flushing to btrfs_remap_file_range_prep - this is
> > where we do the source and target range flush and wait.
> >
> > Can you turn the reproducer into an fstests case?
>
> Sure.
>
> Thanks for the info and all the comment,
> Qu
>
> >
> > Thanks.
> >
> >> +
> >>         /*
> >>          * Lock destination range to serialize with concurrent readpag=
es() and
> >>          * source range to serialize with relocation.
> >> --
> >> 2.21.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
