Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9483D5716
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhGZJ2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhGZJ2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:28:53 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C50C061757
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 03:09:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m193so13938435ybf.9
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZYHadafQb/ldcsYcvye29clHgPHEgVxqsCzRTVsV3U=;
        b=SBOzb35osOTX36Wqb56Yv1f+A4rk7i9GSxcHfPODU+4xbl8C8EazKt3Ra2yo0dQz7l
         +pDC5Zbwcbigqq/STvl7BlFxILso/GzeEttNkWj+C5KHvRh8kUudfLnsT3xGR6NsnWtK
         238g/jymPNhyb+bv7Y/8TUDx2mWQKo0WrVjkMwOROHsuOCszRjTQ3hFkMQoCKztSpHE5
         c48eWIDY/mm1H/ORIa7cxx/GxI2ae7/8MFpZybQjv45t213LKUUpl3rw+Fip99cDuMZa
         rNwEmSx75hYB6GRnN6m74L+XnBmMy0MFuNsOA4LpmN8jAZphCqQBPfHwIzAAEPGhwvOH
         fh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZYHadafQb/ldcsYcvye29clHgPHEgVxqsCzRTVsV3U=;
        b=AhmTfXARNyEtIUNSspCP55/2AUlh88PzyZ14aVn5rz4log8FmsI1KyzGjk3XknrwO6
         Tayx0HCHWWrXme2VDViCMAVk638mVBfakQZ50b1ZDPte6DDiBA3SccJAAIXTAvrFy1y7
         mWP/ms0OjRnD+Br6V+G17ttxqoqwkCc0h+LX5FdLHGX+X6seB1h/2XpVY7ux3YNwgKZU
         onCc9VQWttwXapYY7+EuWAgIJvmk7U0uvEF96/Woy+lI1h9l+0StWS7R9EXZchZs5lAo
         LmgPVddFRNoQDe/fFaukDgEoy0Q56M5rwVw9bWWNzUnW3iXfdnqsuKVE68prs0gR/7h/
         wNdg==
X-Gm-Message-State: AOAM531YgEshav0NW7mb8qfwuZmHohvmL7cM++8LnVDJgPgADGl2mMbX
        rtUY0BjrZiGMZMH0+xAYt4ukIqRuHOta1Khe8JQ=
X-Google-Smtp-Source: ABdhPJz3ROYFq40x3N7Nwsvt1cnbUWsMakIX1SJj4NfOM6M6U+e7IcGQqnGXIsxa10zFJp9tY46dVd8mqBU7lhDrutg=
X-Received: by 2002:a25:7351:: with SMTP id o78mr5587180ybc.0.1627294157858;
 Mon, 26 Jul 2021 03:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210726063507.160396-1-wqu@suse.com>
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 26 Jul 2021 06:08:42 -0400
Message-ID: <CAEg-Je-AVYOAHhwmOSKxtwXXBnwFKStBBQhkNaWkw23goG5_5A@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] btrfs: add data write support for subpage
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 2:36 AM Qu Wenruo <wqu@suse.com> wrote:
>
> This much smaller patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
>
> These patchset is targeted at v5.15 merge window.
> There are 11 subpage enablment patches pending for a while, and not
> touched, thus they should be pretty stable and safe.
>
> While there are 7 new patches, 4 of them are straightforward small
> fixes, the remaining 2 are a little scary as they reworked the core code
> of compression.
> The final new patch is a special write path hotfix, aiming to make btrfs
> subpage writeback more robust against tests like dm-dust.
>
> The rework should improve the readabilty thus make reviewing a
> little easier (as least I hope so).
>
> =3D=3D=3D Current stage =3D=3D=3D
> The tests on x86 pass without new failure, and generic test group on
> arm64 with 64K page size passes except known failure and defrag group.
>
> For btrfs test group, all pass except compression/raid56/defrag.
>
> For anyone who is interested in testing, please use btrfs-progs v5.12 to
> avoid false alert at mkfs time.
>
> =3D=3D=3D Limitation =3D=3D=3D
> There are several limitations introduced just for subpage:
> - No compressed write support
>   Read is no problem, but compression write path has more things left to
>   be modified.
>
>   Already have a version passing all test groups with "-o compress"
>   mount option.
>   Will be addressed in later patchset.
>

If you already have this working, why not include it in the patch series?

> - No inline extent will be created
>   This is mostly due to the fact that filemap_fdatawrite_range() will
>   trigger more write than the range specified.
>   In fallocate calls, this behavior can make us to writeback which can
>   be inlined, before we enlarge the isize, causing inline extent being
>   created along with regular extents.
>
>   In fact, even on x86_64, we can still have fsstress to create inodes
>   with mixed inline and regular extents.
>   Thus there is a much bigger problem to solve.
>
> - No support for RAID56
>   There are still too many hardcoded PAGE_SIZE in raid56 code.
>   Considering it's already considered unsafe due to its write-hole
>   problem, disabling RAID56 for subpage looks sane to me.
>
> - No defrag support for subpage
>   The support for subpage defrag has already an initial version
>   submitted to the mail list.
>   Thus the correct support won't be included in this patchset.
>
>   Currently I'm not pushing defrag patchset, as it's really not
>   the priority, and still has rare bugs related to EXTENT_DELALLOC_NEW
>   extent bit.
>
> =3D=3D=3D Patchset structure =3D=3D=3D
> Patch 01~06:    Subpage fixes for compression read path
> Patch 07~07:    Support for subpage relocation
> Patch 09~16:    Subpage specific fixes and extra limitations
> Patch 17:       Enable subpage support
> Patch 18:       Subpage specific write path fix
>
> =3D=3D=3D Changelog =3D=3D=3D
> v2:
> - Rebased to latest misc-next
>   Now metadata write patches are removed from the series, as they are
>   already merged into misc-next.
>
> - Added new Reviewed-by/Tested-by/Reported-by tags
>
> - Use separate endio functions to subpage metadata write path
>
> - Re-order the patches, to make refactors at the top of the series
>   One refactor, the submit_extent_page() one, should benefit 4K page
>   size more than 64K page size, thus it's worthy to be merged early
>
> - New bug fixes exposed by Ritesh Harjani on Power
>
> - Reject RAID56 completely
>   Exposed by btrfs test group, which caused BUG_ON() for various sites.
>   Considering RAID56 is already not considered safe, it's better to
>   reject them completely for now.
>
> - Fix subpage scrub repair failure
>   Caused by hardcoded PAGE_SIZE
>
> - Fix free space cache inode size
>   Same cause as scrub repair failure
>
> v3:
> - Rebased to remove write path prepration patches
>
> - Properly enable btrfs defrag
>   Previsouly, btrfs defrag is in fact just disabled.
>   This makes tons of tests in btrfs/defrag to fail.
>
> - More bug fixes for rare race/crashes
>   * Fix relocation false alert on csum mismatch
>   * Fix relocation data corruption
>   * Fix a rare case of false ASSERT()
>     The fix already get merged into the prepration patches, thus no
>     longer in this patchset though.
>
>   Mostly reported by Ritesh from IBM.
>
> v4:
> - Disable subpage defrag completely
>   As full page defrag can race with fsstress in btrfs/062, causing
>   strange ordered extent bugs.
>   The full subpage defrag will be submitted as an indepdent patchset.
>
> v5:
> - Rebased to latest misc-next branch
>
> v6:
> - Rebased to latest misc-next branch
>   The 11 existing patches have no conflicts at all.
>
> - Added four patches related to compression read path
>   This involves:
>   * One small fix for extent map grabbing
>   * One preparation to remove GFP_HIGHMEM
>     kmap()/kunmap() is not removed yet, as it's only for later
>     subpage related decompression path rework.
>   * Rework btrfs_decompress_buf2page() and lzo_decompress_bio()
>     btrfs_decompress_buf2page() handles the copying of decompressed data
>     to inode pages, without proper subpage handling, we can copy
>     decompressed data to wrong location
>     lzo_decompress_bio() needs a sectorsize related fix to handle
>     padding zeros.
>     Since we're here, I just reworked the code to make more rooms for
>     proper comments.
>
>     These two rework looks scary, and touches the core functions of
>     compression, thus Josef gave me extra tests runs on them and no
>     regression found.
>
>     But still they definitely deserve more review.
>
> v7:
> - Rebased to latest misc-next branch
>   With HIGHMEM cleanup already in misc-next, one patch can be dropped.
>
>   With extra Reviewed-by: tags and fixes.
>
> - Added 3 more fixes for subpage compression read path:
>   * Sticky @this_bio_flag
>     Preivoulys in btrfs_do_readpage() @this_bio_flag is only used once
>     as one page only contains one sector.
>     But for subpage case, we need to reset this flag, or after reading
>     one compressed extent, next uncompressed extent will be treated as
>     compressed and causing problems.
>
>   * NULL pointer fix for csum verification for compressed extent
>     For compressed extent, we rely on PageChecked to skip csum
>     verification for compressed read.
>     But that flag only works for full page, no subpage helper yet.
>     Thankfully we can easily skip compressed read as it never populate
>     io_bio::csum.
>
>   * Disable readahead for compressed read
>     It will be properly enabled in write path, since for 64K page size,
>     we at most readahead two pages, the readahead is way less effective,
>     and we can afford to skip the readahead completely for subpage case.
>
> v8:
> - Rebased to latest misc-next branch
>   No conflicts
>
> - Add a new hotfix to make __extent_writepage() to ignore IO error
>   To enhance the error handling for subpage write path.
>   As subpage adds new cases to trigger the error branch while IO errors
>   are already handled by bio, no need to error out early and trigger
>   another existing (but harder to fix) bug in write path.
>
> Qu Wenruo (18):
>   btrfs: properly reset @this_bio_flag in btrfs_do_readpage() to avoid
>     inheriting old bio flags to next extent
>   btrfs: fix NULL pointer dereference when reading two compressed extent
>     inside the same page
>   btrfs: disable compressed readahead for subpage
>   btrfs: grab correct extent map for subpage compressed extent read
>   btrfs: rework btrfs_decompress_buf2page()
>   btrfs: rework lzo_decompress_bio() to make it subpage compatible
>   btrfs: extract relocation page read and dirty part into its own
>     function
>   btrfs: make relocate_one_page() to handle subpage case
>   btrfs: fix wild subpage writeback which does not have ordered extent.
>   btrfs: disable inline extent creation for subpage
>   btrfs: allow submit_extent_page() to do bio split for subpage
>   btrfs: reject raid5/6 fs for subpage
>   btrfs: fix a crash caused by race between prepare_pages() and
>     btrfs_releasepage()
>   btrfs: fix a use-after-free bug in writeback subpage helper
>   btrfs: fix a subpage false alert for relocating partial preallocated
>     data extents
>   btrfs: fix a subpage relocation data corruption
>   btrfs: allow read-write for 4K sectorsize on 64K page size systems
>   btrfs: unify the error paths in __extent_writepage() for subpage and
>     regular sectorsize
>
>  fs/btrfs/compression.c | 160 +++++++++++----------
>  fs/btrfs/compression.h |   5 +-
>  fs/btrfs/disk-io.c     |  13 +-
>  fs/btrfs/extent_io.c   | 262 ++++++++++++++++++++++++++---------
>  fs/btrfs/file.c        |  13 +-
>  fs/btrfs/inode.c       |  92 ++++++++++--
>  fs/btrfs/ioctl.c       |   6 +
>  fs/btrfs/lzo.c         | 196 ++++++++++++--------------
>  fs/btrfs/relocation.c  | 308 +++++++++++++++++++++++++++--------------
>  fs/btrfs/subpage.c     |  20 ++-
>  fs/btrfs/subpage.h     |   7 +
>  fs/btrfs/super.c       |   7 -
>  fs/btrfs/sysfs.c       |   5 +
>  fs/btrfs/volumes.c     |   7 +
>  fs/btrfs/zlib.c        |  12 +-
>  fs/btrfs/zstd.c        |   6 +-
>  16 files changed, 720 insertions(+), 399 deletions(-)
>
> --
> 2.32.0
>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
