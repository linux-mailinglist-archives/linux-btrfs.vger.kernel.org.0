Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FAF304897
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbhAZFn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 00:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbhAYMQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 07:16:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF602C06121F
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 04:15:17 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c12so9456696qtv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 04:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=0uvB4iizeMJIJjZ/jVFdA5IC8cHSY+j5vyS7v+gCK9E=;
        b=JhUSH2P9KiB6g/gBFuTQFaZIsK2sVYQPp8Ly8+UxVTL4AT6V2ooSmb5wQGRRNusID7
         C9qEVWAVO5XNz1MZFAskxon3RYpsugnqXX4yNFJ5rjgdnFJzgl7gKRnP9OGbbiJGZez5
         6AcsuP4zUrIu195ppXbyyZJpGG5e9kxAlF1TmYB+rfm5i7inl7m6P6r6zNdY3JRXadap
         m2S5fFMFW/LcupMiPCjXMc8B9cVewrRrsd81JH+3S+nMEFwvvktvO0k791AWm8CxDpMz
         PyAq0fTpXsfrBqFkLskpAjXXc0PlKN+CTU91MkjmcfA00bjt/0hOGc/qTVc0HY7I0OfH
         mEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=0uvB4iizeMJIJjZ/jVFdA5IC8cHSY+j5vyS7v+gCK9E=;
        b=a1xQ/C7dN9uKOaCu/YbpBSiGWuMbIbV1uBQ2jMDPVKYGejlb/cWsPAnx2Lv94s66vS
         D836uOC6ghP0i7AJBecx98kGpgoiKcHDMbKFaZx3Bsx53TMPbhjxYN0cuRruWYrrFjzi
         QK8ODTDZ5qsnMIPmiRnbJSutV7TEo3hY2pMpCysJfcCKtA8DhRFD0lPUNvyoVgSYhXRd
         zASxvjUIxG84g9vqV7KwgoaDBlVC1OVXsWOFhW7/c/T0gasUzMI29/wiQ2kebxaGNIta
         3mtCUWArb6jBHWUPWXETHqe6xMuL0HpmU9ZZQYcaU9hdQcQJjjetIQpYBqBO+NJTNZvL
         oNHA==
X-Gm-Message-State: AOAM531yfO51VR2WvhBvxvzeLFePAzp68nktKIRfADnXVOZ1NBDNNd0j
        JhunZ3p+xprydb+FZ/6B7oTsVOhZ0pEf34IZN+4=
X-Google-Smtp-Source: ABdhPJwtOQH0+WNv4BBx14Vz9O48ZFxo/RgsPFQ6q6r0W3VklN7z0BzhgN1G48BOhztdpn3wQfhseXrqQc6u5vgGNnQ=
X-Received: by 2002:ac8:520a:: with SMTP id r10mr101340qtn.183.1611576916836;
 Mon, 25 Jan 2021 04:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20210121061354.61271-1-wqu@suse.com> <20210121164706.GD6430@twin.jikos.cz>
In-Reply-To: <20210121164706.GD6430@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 25 Jan 2021 12:15:05 +0000
Message-ID: <CAL3q7H4D_Hu=Xk0+dazruwnqwW7+kqdS3VXTxQ5kWSe+EuT8kg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: rework the order of btrfs_ordered_extent::flags
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 4:52 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jan 21, 2021 at 02:13:54PM +0800, Qu Wenruo wrote:
> > [BUG]
> > There is a long existing bug in the last parameter of
> > btrfs_add_ordered_extent(), in commit 771ed689d2cd ("Btrfs: Optimize
> > compressed writeback and reads") back to 2008.
> >
> > In that ancient commit btrfs_add_ordered_extent() expects the @type
> > parameter to be one of the following:
> > - BTRFS_ORDERED_REGULAR
> > - BTRFS_ORDERED_NOCOW
> > - BTRFS_ORDERED_PREALLOC
> > - BTRFS_ORDERED_COMPRESSED
> >
> > But we pass 0 in cow_file_range(), which means BTRFS_ORDERED_IO_DONE.
> >
> > Ironically extra check in __btrfs_add_ordered_extent() won't set the bi=
t
> > if we're seeing (type =3D=3D IO_DONE || type =3D=3D IO_COMPLETE), and a=
void any
> > obvious bug.
> >
> > But this still leads to regular COW ordered extent having no bit to
> > indicate its type in various trace events, rendering REGULAR bit
> > useless.
> >
> > [FIX]
> > This patch will change the following aspects to avoid such problem:
> > - Reorder btrfs_ordered_extent::flags
> >   Now the type bits go first (REGULAR/NOCOW/PREALLCO/COMPRESSED), then
> >   DIRECT bit, finally extra status bits like IO_DONE/COMPLETE/IOERR.
> >
> > - Add extra ASSERT() for btrfs_add_ordered_extent_*()
> >
> > - Remove @type parameter for btrfs_add_ordered_extent_compress()
> >   As the only valid @type here is BTRFS_ORDERED_COMPRESSED.
> >
> > - Remove the unnecessary special check for IO_DONE/COMPLETE in
> >   __btrfs_add_ordered_extent()
> >   This is just to make the code work, with extra ASSERT(), there are
> >   limited values can be passed in.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to misc-next thanks.

Btw, I see that you added a Reviewed-by tag from me to the patch.
However I did not give the tag, not because I forgot but because there
was a small detail in a comment that should be fixed, which was not
addressed in misc-next.

Thanks.

>
> > ---
> >  fs/btrfs/inode.c             |  4 ++--
> >  fs/btrfs/ordered-data.c      | 18 +++++++++++++-----
> >  fs/btrfs/ordered-data.h      | 37 +++++++++++++++++++++++-------------
> >  include/trace/events/btrfs.h |  7 ++++---
> >  4 files changed, 43 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index ef6cb7b620d0..ea9056cc5559 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -917,7 +917,6 @@ static noinline void submit_compressed_extents(stru=
ct async_chunk *async_chunk)
> >                                               ins.objectid,
> >                                               async_extent->ram_size,
> >                                               ins.offset,
> > -                                             BTRFS_ORDERED_COMPRESSED,
> >                                               async_extent->compress_ty=
pe);
> >               if (ret) {
> >                       btrfs_drop_extent_cache(inode, async_extent->star=
t,
> > @@ -1127,7 +1126,8 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >               free_extent_map(em);
> >
> >               ret =3D btrfs_add_ordered_extent(inode, start, ins.object=
id,
> > -                                            ram_size, cur_alloc_size, =
0);
> > +                                            ram_size, cur_alloc_size,
> > +                                            BTRFS_ORDERED_REGULAR);
> >               if (ret)
> >                       goto out_drop_extent_cache;
> >
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index d5d326c674b1..bd7e187d9b16 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -199,8 +199,11 @@ static int __btrfs_add_ordered_extent(struct btrfs=
_inode *inode, u64 file_offset
> >       entry->compress_type =3D compress_type;
> >       entry->truncated_len =3D (u64)-1;
> >       entry->qgroup_rsv =3D ret;
> > -     if (type !=3D BTRFS_ORDERED_IO_DONE && type !=3D BTRFS_ORDERED_CO=
MPLETE)
> > -             set_bit(type, &entry->flags);
> > +
> > +     ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
> > +            type =3D=3D BTRFS_ORDERED_PREALLOC ||
> > +            type =3D=3D BTRFS_ORDERED_COMPRESSED);
>
> I've reformatted that so that all the checks are on separate lines, it's
> easier to read though it does not fill the whole line.
>
> > +     set_bit(type, &entry->flags);
> >
> >       if (dio) {
> >               percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
> > @@ -256,6 +259,8 @@ int btrfs_add_ordered_extent(struct btrfs_inode *in=
ode, u64 file_offset,
> >                            u64 disk_bytenr, u64 num_bytes, u64 disk_num=
_bytes,
> >                            int type)
> >  {
> > +     ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
> > +            type =3D=3D BTRFS_ORDERED_PREALLOC);
> >       return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr=
,
> >                                         num_bytes, disk_num_bytes, type=
, 0,
> >                                         BTRFS_COMPRESS_NONE);
> > @@ -265,6 +270,8 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode=
 *inode, u64 file_offset,
> >                                u64 disk_bytenr, u64 num_bytes,
> >                                u64 disk_num_bytes, int type)
> >  {
> > +     ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
> > +            type =3D=3D BTRFS_ORDERED_PREALLOC);
> >       return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr=
,
> >                                         num_bytes, disk_num_bytes, type=
, 1,
> >                                         BTRFS_COMPRESS_NONE);
> > @@ -272,11 +279,12 @@ int btrfs_add_ordered_extent_dio(struct btrfs_ino=
de *inode, u64 file_offset,
> >
> >  int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 f=
ile_offset,
> >                                     u64 disk_bytenr, u64 num_bytes,
> > -                                   u64 disk_num_bytes, int type,
> > -                                   int compress_type)
> > +                                   u64 disk_num_bytes, int compress_ty=
pe)
> >  {
> > +     ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
> >       return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr=
,
> > -                                       num_bytes, disk_num_bytes, type=
, 0,
> > +                                       num_bytes, disk_num_bytes,
> > +                                       BTRFS_ORDERED_COMPRESSED, 0,
> >                                         compress_type);
> >  }
> >
> > diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> > index 46194c2c05d4..151ec6bba405 100644
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
> >  };
> >
> >  /*
> > - * bits for the flags field:
> > + * Bits for btrfs_ordered_extent::flags.
> >   *
> >   * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
> >   * It is used to make sure metadata is inserted into the tree only onc=
e
> > @@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
> >   * IO is done and any metadata is inserted into the tree.
> >   */
> >  enum {
> > +     /*
> > +      * Different types for direct io, one and only one of the 4 type =
can
>
> direct io
>
> > +      * be set when creating ordered extent.
> > +      *
> > +      * REGULAR:     For regular non-compressed COW write
> > +      * NOCOW:       For NOCOW write into existing non-hole extent
> > +      * PREALLOC:    For NOCOW write into preallocated extent
> > +      * COMPRESSED:  For compressed COW write
> > +      */
> > +     BTRFS_ORDERED_REGULAR,
> > +     BTRFS_ORDERED_NOCOW,
> > +     BTRFS_ORDERED_PREALLOC,
> > +     BTRFS_ORDERED_COMPRESSED,
> > +
> > +     /*
> > +      * Extra bit for DirectIO, can only be set for
>
> DirectIO
>
> > +      * REGULAR/NOCOW/PREALLOC. No DIO for compressed extent.
>
> DIO
>
> Three different ways to spell that but one is enough. Fixed.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
