Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B736215FE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 10:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEGI4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 04:56:52 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45187 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEGI4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 04:56:52 -0400
Received: by mail-ua1-f66.google.com with SMTP id o33so5709888uae.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=VQApjmHwpaaQNOquTIXrY4x7QLkmnlWjYKGf6Uo7rRM=;
        b=CN8D/PtCDxwzkjWRwradfMKQDbv3snb4TDYXPWAy2X0SyBfdfUaUkmzEG5LG+1Ftxx
         eNvP98kU+KYmTJYc6BLZ/fFeV8ucqVd1amQxa6Mxo/KxuRhadr2jws/0B1OXMa3/E84w
         lmhdeLd+8dUM+ZiD6xQW9rN/xwHiwyBg7Hh/sC0CeU4aM8hmTpe5yxhe35xnHHBDFom/
         bPs/uAKmxXEPx15sReorZ97WP0s5rvLcNk/4Bu3Ey8HDGiAvsrOVBAcd0NmXJoRYplQH
         0ooUf+Bo29dNjO7PEVFdCqAdvu59izHmu7y5oTQDgHpgHOdPXslRIGkRrTEPimCVl5uU
         QsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=VQApjmHwpaaQNOquTIXrY4x7QLkmnlWjYKGf6Uo7rRM=;
        b=qhG2nH/lwct01SpAV+TZLgspxDWzmulswtpaxveNeT4ammBJLxTHEP3scci4DGPwUl
         JMJRl/IuAQ9vpgpSOsQz9NjgLXG1oADauVYvcS3trehL3DlppYsrL/dW3NiwovDEdVqi
         w85phcy03XzO9ziyo6SBhKHQcymNlhk4J0VcXD30scZdMm4oINfrwpKCDT8iiU/oAtl2
         hsewJZywgIbhkbUQQ1n2AC3MiWu1we/spit5aQTzLeZRLhukqpg0QcP5hZWWxy9i2Seu
         CGlYlexv7v+wDvsqvEc43LuQwHAGzXT1dqOF6FotRmVGlpiB2GibQx8TVjNbwNjT5Z9m
         1AjQ==
X-Gm-Message-State: APjAAAVA1Euv5JEyA4But4g6LO5KXVFZER0IpQ8rBINYxqQyAeawAJqH
        iOoCO6be9VygBPI8C31gAezYQmL4+c2q5m9yPxU=
X-Google-Smtp-Source: APXvYqwTtkdCcI+YMqEvmbUh+uJwDEZZvIvWotqxF677Poeqfj/4QaPwZTAtaAVUnq2IYKqVmEc+XMhgqfJ/7auwVtE=
X-Received: by 2002:ab0:3351:: with SMTP id h17mr9236098uap.123.1557219411042;
 Tue, 07 May 2019 01:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190503010852.10342-1-wqu@suse.com> <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com> <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
 <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
In-Reply-To: <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 7 May 2019 09:56:40 +0100
Message-ID: <CAL3q7H7jmCnObo4Mtnnm9_07pePySbsRqdOFX+348s_q4VnA2Q@mail.gmail.com>
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

On Mon, May 6, 2019 at 3:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> [snip]
> >>
> >> For data writeback, it should only cause sync related failure.
> >
> > Ok, so please remove the transaction abort comments for next iteration.
> > By sync related failure, you mean running dealloc fails with ENOSPC,
> > since when it tries to reserve a data extent it fails as it can't find
> > any free extent.
>
> Well, btrfs has some hidden way to fix such problem by itself already.
>
> At buffered write time, we have the following call chain:
> btrfs_buffered_write()
> |- btrfs_check_data_free_space()
>    |- btrfs_alloc_data_chunk_ondemand()
>       |- need_commit =3D 2; /* We have 2 chance to retry, 1 to flush */
>       |- do_chunk_alloc() /* we have no data space available */
>       |- if (ret < 0 && ret =3D=3D -ENOSPC)
>       |-     goto commit_trans;  /* try to free some space */
>       |- commit_trans:
>       |-     need_commit--;
>       |-     if (need_commit > 0) {
>       |-         btrfs_start_delalloc_roots();
>       |-         btrfs_wait_ordered_roots();
>       |-     }
>
> This means, as long as we hit ENOSPC for data space, we will start write
> back, thus NODATACOW data will still hit disk as NODATACOW.
>
> Such hidden behavior along with always-reserve-data-space solves the
> problem pretty well.

It doesn't solve the problem you reported in the rfc patch.

What happens:

1) We have a file with a prealloc extent, that isn't shared

2) We have 0 bytes of available data space (or any amount less then
that of the buffered write size)

3) A buffered write happens that falls within a subrange of the prealloc ex=
tent.
    We can't reserve space, we do all those things at
btrfs_alloc_data_chunk_ondemand(), but we can't get any data space
released, since it's all allocated.
    Therefore we fall back to nodatacow mode. We dirty the pages, mark
the range as dealloc, etc.

4) The reflink happens, for a subrange of the prealloc extent that
does not overlap the range of the buffered write.

5) Some time after the reflink, writeback starts for the inode.
    During the writeback we fallback to COW mode, because the prealloc
extent is shared, even if the subrange of the buffered write does not
overlap the reflinked subrange.
    Now the write silently fails with -ENOSPC, and a user doesn't know
about it unless it does an fsync after that writeback, which will
report the error via filemap_check_wb_err().

> We either:
> - reserve data space
>   Then no matter how it ends, we're OK, although it may end as CoW.
>
> - Failed to reserve data space
>   Writeback will be triggered anyway, no way to screw things around.
>
> Thus this workaround has nothing to fix, but only make certain NODATACOW
> reach disk as NODATACOW.
>
> It makes some NODATACOW behaves more correctly but won't fix any obvious
> bug.
>
> My personal take is to fix any strange behavior even it won't cause any
> problem, but the full inode writeback can be performance heavy.
>
> So my question is, do we really need this anyway?

Do we need what? Your patch, that logic at
btrfs_alloc_data_chunk_ondemand(), something else?

Thanks.

>
> Thanks,
> Qu
>
> >
> >>
> >>> I don't recall starting transactions when running dealloc, and failed
> >>> to see where after a quick glance to cow_file_range()
> >>> and run_delalloc_nocow(). I'm assuming that 'at delalloc time' means
> >>> when starting writeback.
> >>>
> >>>>
> >>>> [CAUSE]
> >>>> This is due to the fact that btrfs can only do extent level share ch=
eck.
> >>>>
> >>>> Btrfs can only tell if an extent is shared, no matter if only part o=
f the
> >>>> extent is shared or not.
> >>>>
> >>>> So for above script we have:
> >>>> - fallocate
> >>>> - buffered write
> >>>>   If we don't have enough data space, we fall back to NOCOW check.
> >>>>   At this timming, the extent is not shared, we can skip data
> >>>>   reservation.
> >>>
> >>> But in the above example we don't fall to nocow mode when doing the
> >>> buffered write, as there's plenty of data space available (1Gb -
> >>> 24Kb).
> >>> You need to update the example.
> >> I have to admit that the core part is mostly based on the worst case
> >> *assumption*.
> >>
> >> I'll try to make the case convincing by making it fail directly.
> >
> > Great, thanks.
> >
> >>
> >>>
> >>>
> >>>> - reflink
> >>>>   Now part of the large preallocated extent is shared.
> >>>> - delalloc kicks in
> >>>
> >>> writeback kicks in
> >>>
> >>>>   For the NOCOW range, as the preallocated extent is shared, we need
> >>>>   to fall back to COW.
> >>>>
> >>>> [WORKAROUND]
> >>>> The workaround is to ensure any buffered write in the related extent=
s
> >>>> (not the reflink source range) get flushed before reflink.
> >>>
> >>> not the reflink source range -> not just the reflink source range
> >>>
> >>>>
> >>>> However it's pretty expensive to do a comprehensive check.
> >>>> In the reproducer, the reflink source is just a part of a larger
> >>>
> >>> Again, the reproducer needs to be fixed (yes, I tested it even if it'=
s
> >>> clear by looking at it that it doesn't trigger the nocow case).
> >>>
> >>>> preallocated extent, we need to flush all buffered write of that ext=
ent
> >>>> before reflink.
> >>>> Such backward search can be complex and we may not get much benefit =
from
> >>>> it.
> >>>>
> >>>> So this patch will just try to flush the whole inode before reflink.
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>> Reason for RFC:
> >>>> Flushing an inode just because it's a reflink source is definitely
> >>>> overkilling, but I don't have any better way to handle it.
> >>>>
> >>>> Any comment on this is welcomed.
> >>>> ---
> >>>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
> >>>>  1 file changed, 22 insertions(+)
> >>>>
> >>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >>>> index 7755b503b348..8caa0edb6fbf 100644
> >>>> --- a/fs/btrfs/ioctl.c
> >>>> +++ b/fs/btrfs/ioctl.c
> >>>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct =
file *file, struct file *file_src,
> >>>>                         return ret;
> >>>>         }
> >>>>
> >>>> +       /*
> >>>> +        * Workaround to make sure NOCOW buffered write reach disk a=
s NOCOW.
> >>>> +        *
> >>>> +        * Due to the limit of btrfs extent tree design, we can only=
 have
> >>>> +        * extent level share view. Any part of an extent is shared =
then the
> >>>
> >>> Any -> If any
> >>>
> >>>> +        * whole extent is shared and any write into that extent nee=
ds to fall
> >>>
> >>> is -> is considered
> >>>
> >>>> +        * back to COW.
> >>>
> >>> I would add, something like:
> >>>
> >>> That is, btrfs' back references do not have a block level granularity=
,
> >>> they work at the whole extent level.
> >>>
> >>>> +        *
> >>>> +        * NOCOW buffered write without data space reserved could to=
 lead to
> >>>> +        * either data space bytes_may_use underflow (kernel warning=
) or ENOSPC
> >>>> +        * at delalloc time (transaction abort).
> >>>
> >>> I would omit the warning and transaction abort parts, that can change
> >>> any time. And we have that information in the changelog, so it's not
> >>> lost.
> >>>
> >>>> +        *
> >>>> +        * Here we take a shortcut by flush the whole inode. We coul=
d do better
> >>>> +        * by finding all extents in that range and flush the space =
referring
> >>>> +        * all those extents.
> >>>> +        * But that's too complex for such corner case.
> >>>> +        */
> >>>> +       filemap_flush(src->i_mapping);
> >>>> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> >>>> +                    &BTRFS_I(src)->runtime_flags))
> >>>> +               filemap_flush(src->i_mapping);
> >>>
> >>> So a few comments here:
> >>>
> >>> - why just in the clone part? The dedupe side has the same problem, d=
oesn't it?
> >>
> >> Right.
> >>
> >>>
> >>> - I would move such flushing to btrfs_remap_file_range_prep - this is
> >>> where we do the source and target range flush and wait.
> >>>
> >>> Can you turn the reproducer into an fstests case?
> >>
> >> Sure.
> >>
> >> Thanks for the info and all the comment,
> >> Qu
> >>
> >>>
> >>> Thanks.
> >>>
> >>>> +
> >>>>         /*
> >>>>          * Lock destination range to serialize with concurrent readp=
ages() and
> >>>>          * source range to serialize with relocation.
> >>>> --
> >>>> 2.21.0
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
