Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2963D1F6FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfEOO4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 10:56:44 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43582 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfEOO4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 10:56:44 -0400
Received: by mail-vk1-f193.google.com with SMTP id h72so81593vkh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=v7YvY7VcH3aqqS6AD4GHXvFtGQXQTqIXCThQztSvJgU=;
        b=mw+z5e23X7mrd28Z/guvdFLQyVefYeizdgmt6pe9wUuuYJQooe62mjjnUFsm4kRZ+d
         i8h52dvpf8K5OL26L8SeoC9ERK3EuwyNe7UnUaIgxjXkx/tu0xm7nusWi/o/4a/+93LK
         BiSND9qMZb7/MZdF7y2XZF+nZhKE5pOejfqHFdJBtIVhwTS0Rup/VNdun04dz1lsZJ+G
         PhQpHQu/4xqCh5q+hZOg3ULJx6KK6OIUyyLkrSKnpxcOmXTIuCaD18X7c4n07T0VTsL3
         h17jDnTYUDp9VyvFq0y3jzz2kglKtuscdH/Fp34IdOdLz0KtTQEzcUPIGtq6ba0GZu4V
         arUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=v7YvY7VcH3aqqS6AD4GHXvFtGQXQTqIXCThQztSvJgU=;
        b=mkAk12SwEwh6iZRKuBYD53ZO6V6/nxH+sgspjm6l5xrnZCmCMGWENTqtrGp2U0VkZM
         jAF5aq60OooOpqIju+bKcuBJZxvM68hsZFq/BIWRRWMhP9x9lbV4T7ZO1TSPdKykQs/q
         uFzun4p2l75hvv3kgIKQi/DsflJfswo/nTTe+vLgY0PE/UmrtSyxZ7h/uH7to8Ko1KUt
         0RoJ6prHNj+FY2FB9DmgRGKqslI8aGV6J+xofVQGdd2efec5H2uRlr4gBCAYyhxyH4hA
         6kDgs0o+phk/LMRql06C9hVEBps18JKlE6lifLRe3jO0PLj/RudoxxyjJuF+WPdyCF3C
         AGoA==
X-Gm-Message-State: APjAAAWgqfZm/nzNtWF/y6KDivzRRapRq5KgoYwUawAuDpASU67jcPvc
        iE66NV3aNaJWlrGp7RQjCU0Ojq1Vu0TllbLaqom4LBvO
X-Google-Smtp-Source: APXvYqxssMqyD4wUkgXEVLNk2Xh3O3grJIs8bjnU+1dDcMxsz5GOBtkFpZEBl1BmmSqdDMBRMXVDFbxtgkUPsGHZ0Cs=
X-Received: by 2002:a1f:8d0b:: with SMTP id p11mr14963436vkd.31.1557932202707;
 Wed, 15 May 2019 07:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190508104958.18363-1-wqu@suse.com> <20190509144915.GV20156@twin.jikos.cz>
 <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
In-Reply-To: <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 May 2019 15:56:31 +0100
Message-ID: <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 12:30 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/5/9 =E4=B8=8B=E5=8D=8810:49, David Sterba wrote:
> > On Wed, May 08, 2019 at 06:49:58PM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> The following script can cause unexpected fsync failure:
> >>
> >>   #!/bin/bash
> >>
> >>   dev=3D/dev/test/test
> >>   mnt=3D/mnt/btrfs
> >>
> >>   mkfs.btrfs -f $dev -b 512M > /dev/null
> >>   mount $dev $mnt -o nospace_cache
> >>
> >>   # Prealloc one extent
> >>   xfs_io -f -c "falloc 8k 64m" $mnt/file1
> >>   # Fill the remaining data space
> >>   xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
> >>   sync
> >>
> >>   # Write into the prealloc extent
> >>   xfs_io -c "pwrite 1m 16m" $mnt/file1
> >>
> >>   # Reflink then fsync, fsync would fail due to ENOSPC
> >>   xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
> >>   umount $dev
> >>
> >> The fsync fails with ENOSPC, and the last page of the buffered write i=
s
> >> lost.
> >>
> >> [CAUSE]
> >> This is caused by:
> >> - Btrfs' back reference only has extent level granularity
> >>   So write into shared extent must be CoWed even only part of the exte=
nt
> >>   is shared.
> >>
> >> So for above script we have:
> >> - fallocate
> >>   Create a preallocated extent where we can do NOCOW write.
> >>
> >> - fill all the remaining data and unallocated space
> >>
> >> - buffered write into preallocated space
> >>   As we have not enough space available for data and the extent is not
> >>   shared (yet) we fall into NOCOW mode.
> >>
> >> - reflink
> >>   Now part of the large preallocated extent is shared, later write
> >>   into that extent must be CoWed.
> >>
> >> - fsync triggers writeback
> >>   But now the extent is shared and therefore we must fallback into COW
> >>   mode, which fails with ENOSPC since there's not enough space to
> >>   allocate data extents.
> >>
> >> [WORKAROUND]
> >> The workaround is to ensure any buffered write in the related extents
> >> (not just the reflink source range) get flushed before reflink/dedupe,
> >> so that NOCOW writes succeed that happened before reflinking succeed.
> >>
> >> The workaround is expensive
> >
> > Can you please quantify that, how big the performance drop is going to
> > be?
>
> Depends on how many dirty pages there are at the timing of reflink/dedupe=
.
>
> If there are a lot, then it would be a delay for reflink/dedupe.
>
> >
> > If the fsync comes soon after reflink, then it's effectively no change.
> > In case the buffered writes happen on a different range than reflink an=
d
> > fsync comes later, the buffered writes will stall reflink, right?
>
> Fsync doesn't make much difference, it mostly depends on how many dirty
> pages are.
>
> Thus the most impacted use case is concurrent buffered write with
> reflink/dedupe.
>
> >
> > If there are other similar corner cases we'd better know them in advanc=
e
> > and estimate the impact, that'll be something to look for when we get
> > complaints that reflink is suddenly slow.
> >
> >> NOCOW range, but that needs extra accounting for NOCOW range.
> >> For now, fix the possible data loss first.
> >
> > filemap_flush says
> >
> >  437 /**
> >  438  * filemap_flush - mostly a non-blocking flush
> >  439  * @mapping:    target address_space
> >  440  *
> >  441  * This is a mostly non-blocking flush.  Not suitable for data-int=
egrity
> >  442  * purposes - I/O may not be started against all dirty pages.
> >  443  *
> >  444  * Return: %0 on success, negative error code otherwise.
> >  445  */
> >
> > so how does this work together with the statement about preventing data
> > loss?
>
> The data loss is caused by the fact that we can start buffered write
> without reserving data space, but after reflink/dedupe we have to do CoW.
> Without enough space, CoW will fail due to ENOSPC.
>
> The fix here is, we ensure all dirties pages start their writeback
> (start btrfs_run_delalloc_range()) before reflink.
>
> At btrfs_run_delalloc_range() we determine whether a range goes through
> NOCOW or COW, and submit ordered extent to do real write back/csum
> calculation/etc.
>
> As long as the whole inode goes through btrfs_run_delalloc_range(), any
> NOCOW write will go NOCOW on-disk.
> We don't need to wait for the ordered extent to finish, just ensure all
> pages goes through delalloc is enough.
> Waiting for ordered extent will cause even more latency for reflink.
>
> Thus the filemap_flush() is enough, as the point is to ensure delalloc
> is started before reflink.

I believe that David's comment is related to this part of the comment
on filemap_flush():

"I/O may not be started against all dirty pages."

I.e., his concern being that writeback may not be started and
therefore we end up with the data loss due to ENOSPC later, and not to
the technical details of why the ENOSPC failure happens, which is
already described in the changelog and discussed during the review of
previous versions of the patch.

However btrfs has its own writepages() implementation, which even for
WB_SYNC_NONE (used by filemap_flush) starts writeback (and doesn't
wait for it to finish if it started before, which is fine for this use
case).
Anyway, just my interpretation of the doubt/comment.

Thanks.

>
> Thanks,
> Qu
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
