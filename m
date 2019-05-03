Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8812A58
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfECJVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 05:21:36 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40211 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECJVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 05:21:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id e207so3162703vsd.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2019 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eC1h78dxl34zmZzKCFTMeKVnM9p6DMDkknR7lCudUVc=;
        b=dZVJSJCia1JZUUVial6AExRjW/FulSdKqT8v54SF3FhTXWYgXKK2jR4FI8+GKlzvkV
         989+zh0Lle9RhkF6wcORdPbKJdKxaWQHrF3iy/X/t6z1UJXYsYyREWgnm2qC6Y1GdOEw
         l8RggQbqaJXJuwefBLh4x8rUHxSPod2bw163K5/LyBlbeHm4oMai+My4GZNJteqe+RoT
         ZvGtj8G6GS8oKzqbX9E6R4qZq+M4gwc7lhgWnAayNc6Dy9s8OvqYfqcd5qWTNNUbIk1R
         0NIVM/vF/MWzp7kWr7Q69A9ueeEqMrVw4wqAzmkcx8r74cuVga16uQT8LLj5vtnz+bbI
         VTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eC1h78dxl34zmZzKCFTMeKVnM9p6DMDkknR7lCudUVc=;
        b=qDoJ+GfRi0GBchvGg0oGK+0rtKzg6kzOPrjDnnC4zZfl43HnOMyUUGk7dIJ7g3Cr6n
         bHWp/YaDomX28mRhOmM3CaeAmOqJHPNGpZsAqlmhCRtrlaEvWBqNUx3zuMCp0b+EKIn6
         mBDkDbUSL71FOK52fDKCeUtw04quFk4H4HEIGeI3Tx83kBaCzqqPxyLJaHuxht04g7Q3
         RPuoFd4ySYLsHkAiNDrEZXAkxX1pMHx0kGSeLSqWkRopVJGnt1QdU7VHRg/wxCoU1DRl
         1GjEBO1PjOHojYo2yrshPK4EIwROJeSz1WU9MwWa+O6GTfFeVivHrecPaImKwTTVyAqi
         U/oQ==
X-Gm-Message-State: APjAAAVQ/LvBP9lZ4HW3t92a1QKM7uL0vtxM1WMC1GDD2Wupmdyy/WCc
        3f1SXFQ/Q8JS8N61+GxIYL046c1xhexKOqckQGK9cA==
X-Google-Smtp-Source: APXvYqxjYvRmZUFFgdZZ1QlROLwQOtGJX9VtK1fQUstL6GfsMOiyGcGiU3Qb5vEkdiSeNitf6xNaDtCTt84immrwcUM=
X-Received: by 2002:a67:1582:: with SMTP id 124mr4883340vsv.14.1556875295338;
 Fri, 03 May 2019 02:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190503010852.10342-1-wqu@suse.com>
In-Reply-To: <20190503010852.10342-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 May 2019 10:21:24 +0100
Message-ID: <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 3, 2019 at 2:46 AM Qu Wenruo <wqu@suse.com> wrote:

What a great subject. The "reflink:" part is unnecessary, since the
rest of the subject already mentions it, that makes it a bit shorter.

>
> [BUG]
> The following command can lead to unexpected data COW:
>
>   #!/bin/bash
>
>   dev=3D/dev/test/test
>   mnt=3D/mnt/btrfs
>
>   mkfs.btrfs -f $dev -b 1G > /dev/null
>   mount $dev $mnt -o nospace_cache
>
>   xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
>   xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
>   umount $dev
>
> The result extent will be
>
>         item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
>                 generation 6 type 2 (prealloc)
>                 prealloc data disk byte 13631488 nr 28672
>         item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
>                 generation 6 type 1 (regular)
>                 extent data disk byte 13660160 nr 12288 <<< COW
>         item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
>                 generation 6 type 2 (prealloc)
>                 prealloc data disk byte 13631488 nr 28672
>
> Currently we always reserve space even for NOCOW buffered write, thus

I would add 'data' between 'reserve' and 'space', to be clear.

> under most case it shouldn't cause anything wrong even we fall back to
> COW.

even we ... -> even if we fallback to COW when running delalloc /
starting writeback.

>
> However when we're out of data space, we fall back to skip data space if
> we can do NOCOW write.

we fall back to skip data space ... -> we fallback to NOCOW write
without reserving data space.

>
> If such behavior happens under that case, we could hit the following
> problems:

> - data space bytes_may_use underflow
>   This will cause kernel warning.

Ok.

>
> - ENOSPC at delalloc time

at delalloc time - that is an ambiguous term you use through the change log=
.
You mean when running/starting delalloc, which happens when starting writeb=
ack,
but that could be confused with creating delalloc, which happens
during the buffered write path.

So I would always replace 'dealloc time' with 'when running delalloc'
(or when starting writeback).

>   This will lead to transaction abort and fs forced to RO.

Where does that happen exactly?
I don't recall starting transactions when running dealloc, and failed
to see where after a quick glance to cow_file_range()
and run_delalloc_nocow(). I'm assuming that 'at delalloc time' means
when starting writeback.

>
> [CAUSE]
> This is due to the fact that btrfs can only do extent level share check.
>
> Btrfs can only tell if an extent is shared, no matter if only part of the
> extent is shared or not.
>
> So for above script we have:
> - fallocate
> - buffered write
>   If we don't have enough data space, we fall back to NOCOW check.
>   At this timming, the extent is not shared, we can skip data
>   reservation.

But in the above example we don't fall to nocow mode when doing the
buffered write, as there's plenty of data space available (1Gb -
24Kb).
You need to update the example.


> - reflink
>   Now part of the large preallocated extent is shared.
> - delalloc kicks in

writeback kicks in

>   For the NOCOW range, as the preallocated extent is shared, we need
>   to fall back to COW.
>
> [WORKAROUND]
> The workaround is to ensure any buffered write in the related extents
> (not the reflink source range) get flushed before reflink.

not the reflink source range -> not just the reflink source range

>
> However it's pretty expensive to do a comprehensive check.
> In the reproducer, the reflink source is just a part of a larger

Again, the reproducer needs to be fixed (yes, I tested it even if it's
clear by looking at it that it doesn't trigger the nocow case).

> preallocated extent, we need to flush all buffered write of that extent
> before reflink.
> Such backward search can be complex and we may not get much benefit from
> it.
>
> So this patch will just try to flush the whole inode before reflink.


>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> Flushing an inode just because it's a reflink source is definitely
> overkilling, but I don't have any better way to handle it.
>
> Any comment on this is welcomed.
> ---
>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7755b503b348..8caa0edb6fbf 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
>                         return ret;
>         }
>
> +       /*
> +        * Workaround to make sure NOCOW buffered write reach disk as NOC=
OW.
> +        *
> +        * Due to the limit of btrfs extent tree design, we can only have
> +        * extent level share view. Any part of an extent is shared then =
the

Any -> If any

> +        * whole extent is shared and any write into that extent needs to=
 fall

is -> is considered

> +        * back to COW.

I would add, something like:

That is, btrfs' back references do not have a block level granularity,
they work at the whole extent level.

> +        *
> +        * NOCOW buffered write without data space reserved could to lead=
 to
> +        * either data space bytes_may_use underflow (kernel warning) or =
ENOSPC
> +        * at delalloc time (transaction abort).

I would omit the warning and transaction abort parts, that can change
any time. And we have that information in the changelog, so it's not
lost.

> +        *
> +        * Here we take a shortcut by flush the whole inode. We could do =
better
> +        * by finding all extents in that range and flush the space refer=
ring
> +        * all those extents.
> +        * But that's too complex for such corner case.
> +        */
> +       filemap_flush(src->i_mapping);
> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> +                    &BTRFS_I(src)->runtime_flags))
> +               filemap_flush(src->i_mapping);

So a few comments here:

- why just in the clone part? The dedupe side has the same problem, doesn't=
 it?

- I would move such flushing to btrfs_remap_file_range_prep - this is
where we do the source and target range flush and wait.

Can you turn the reproducer into an fstests case?

Thanks.

> +
>         /*
>          * Lock destination range to serialize with concurrent readpages(=
) and
>          * source range to serialize with relocation.
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
