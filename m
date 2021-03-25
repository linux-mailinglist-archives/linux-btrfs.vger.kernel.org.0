Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239773491CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 13:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCYMVb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 08:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCYMVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 08:21:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC28C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 05:21:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g38so2004642ybi.12
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ghlhLLVI3GPZKy2RF/xOUdFFZrma1fX9PYCULRSfVQo=;
        b=uCrzoNiFN1TPFK0MiNLVmcEn5Am/s+FzehhCQNoVrVQCFW8fUQBXn6Nf1v1Hb+7kSB
         4XT4FsIoS3FEiZpg5CGXX4omoxv3OY7ttl+b2k/NuJ85IHw5fPd1d1AvFRkbsjeqZMT8
         rVnh+3ivmbU7bfOz/uvRqkZjpajmDxKiWNHf9jHKmnrOfCPIlfDossJwAKzggicljAY9
         h6adqWw13ZqNsUj6ul+bDrZvFyVRf//EglUE+1Y8JLoCx23HuLxFfkQP6+tDV5tW2Hup
         vHP6xu+DVOwciC97lLdCZ6+VzTJS6STR/IYZHHJ+qeqOB+Yf6I7j8xLkgpxvww/JmtKv
         Mi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ghlhLLVI3GPZKy2RF/xOUdFFZrma1fX9PYCULRSfVQo=;
        b=gH8OPqbRQhnR8pgV6uP32tCqJaIGweM91Oyq5CmFQX3HO1m5OCDyOkk3aeaHRTBWsa
         0qJG/pfMVPU7Tas/LF0XMeWZjug7jqHC9IBDKoCaPWFgSbIrD6ZfKZpu9FHLfhogaDuf
         FXQ2eTQBFiSeWPYxwTy4P835jzPPWa02mN0RI4NQZLaZHSGorZqSZhr0imucfpkvf8Wq
         rFAFguspcEgFNyQzeUZzIEggV04fLDbfI8L6l1Qi2JGv/bjKrzY7AVW5oZSii844gPP7
         fba/oA10y8U9Uu245MTxdkcBxlB02/Tzc8Bh/J4HXF51BFE4W9YrbjtIqiZtv07Cpq0d
         oJ+Q==
X-Gm-Message-State: AOAM5331+2eqSEBFRDOoK25Ye3MegGrDBvBu6uBvyhNrsMlUuc+MN7C3
        nqJ/dzEb/a9NpD0olsrk882UOI3uPn6PHmc+M9Y=
X-Google-Smtp-Source: ABdhPJyCj/csd++r6cZiqrEb65ksT/MY1cfTEyW+HrZQh0F+5JDqWWDMu/vDpjESOrrebqaI69yVCs17owFpIzF3XrA=
X-Received: by 2002:a25:d10b:: with SMTP id i11mr3680968ybg.0.1616674859523;
 Thu, 25 Mar 2021 05:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210325071445.90896-1-wqu@suse.com>
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 25 Mar 2021 08:20:23 -0400
Message-ID: <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>
> This patchset can be fetched from the following github repo, along with
> the full subpage RW support:
> https://github.com/adam900710/linux/tree/subpage
>
> This patchset is for metadata read write support.
>
> [FULL RW TEST]
> Since the data write path is not included in this patchset, we can't
> really test the patchset itself, but anyone can grab the patch from
> github repo and do fstests/generic tests.
>
> But at least the full RW patchset can pass -g generic/quick -x defrag
> for now.
>
> There are some known issues:
>
> - Defrag behavior change
>   Since current defrag is doing per-page defrag, to support subpage
>   defrag, we need some change in the loop.
>   E.g. if a page has both hole and regular extents in it, then defrag
>   will rewrite the full 64K page.
>
>   Thus for now, defrag related failure is expected.
>   But this should only cause behavior difference, no crash nor hang is
>   expected.
>
> - No compression support yet
>   There are at least 2 known bugs if forcing compression for subpage
>   * Some hard coded PAGE_SIZE screwing up space rsv
>   * Subpage ASSERT() triggered
>     This is because some compression code is unlocking locked_page by
>     calling extent_clear_unlock_delalloc() with locked_page =3D=3D NULL.
>   So for now compression is also disabled.
>
> - Inode nbytes mismatch
>   Still debugging.
>   The fastest way to trigger is fsx using the following parameters:
>
>     fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tmp/fsx
>
>   Which would cause inode nbytes differs from expected value and
>   triggers btrfs check error.
>
> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
> The metadata part in fact has more new code than data part, as it has
> some different behaviors compared to the regular sector size handling:
>
> - No more page locking
>   Now metadata read/write relies on extent io tree locking, other than
>   page locking.
>   This is to allow behaviors like read lock one eb while also try to
>   read lock another eb in the same page.
>   We can't rely on page lock as now we have multiple extent buffers in
>   the same page.
>
> - Page status update
>   Now we use subpage wrappers to handle page status update.
>
> - How to submit dirty extent buffers
>   Instead of just grabbing extent buffer from page::private, we need to
>   iterate all dirty extent buffers in the page and submit them.
>
> [CHANGELOG]
> v2:
> - Rebased to latest misc-next
>   No conflicts at all.
>
> - Add new sysfs interface to grab supported RO/RW sectorsize
>   This will allow mkfs.btrfs to detect unmountable fs better.
>
> - Use newer naming schema for each patch
>   No more "extent_io:" or "inode:" schema anymore.
>
> - Move two pure cleanups to the series
>   Patch 2~3, originally in RW part.
>
> - Fix one uninitialized variable
>   Patch 6.
>
> v3:
> - Rename the sysfs to supported_sectorsizes
>
> - Rebased to latest misc-next branch
>   This removes 2 cleanup patches.
>
> - Add new overview comment for subpage metadata
>
> Qu Wenruo (13):
>   btrfs: add sysfs interface for supported sectorsize
>   btrfs: use min() to replace open-code in btrfs_invalidatepage()
>   btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
>   btrfs: refactor how we iterate ordered extent in
>     btrfs_invalidatepage()
>   btrfs: introduce helpers for subpage dirty status
>   btrfs: introduce helpers for subpage writeback status
>   btrfs: allow btree_set_page_dirty() to do more sanity check on subpage
>     metadata
>   btrfs: support subpage metadata csum calculation at write time
>   btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>   btrfs: make the page uptodate assert to be subpage compatible
>   btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
>   btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
>     compatible
>   btrfs: add subpage overview comments
>
>  fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++---------
>  fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
>  fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
>  fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/subpage.h   |  17 +++++
>  fs/btrfs/sysfs.c     |  15 +++++
>  6 files changed, 441 insertions(+), 116 deletions(-)
>
> --
> 2.30.1
>

Why wouldn't we just integrate full read-write support with the
caveats as described now? It seems to be relatively reasonable to do
that, and this patch set is essentially unusable without the rest of
it that does enable full read-write support.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
