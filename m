Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A034BEB2
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhC1UDF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 16:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhC1UCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 16:02:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8714FC061756
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 13:02:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w8so4998389pjf.4
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1bX38xDgQBkiHIqltbjAQiLDAH1CFYr3yOguDUYlnqw=;
        b=A1j25huLf1da32PHkoqLb6UfzJbWZE/WAqQeK3djoGC/LZLMCHWQTVFFCjVrAkY/Ds
         3dbVhOGwKHqLd760VDMahRmAuLjrcanfTm66DBBsNXujmMWuRjzqwofDelW86FaG06Im
         pgiYrcfRCt/rvmTScfF4bz+M2p4S0WuxEVz0srWWD2bdGoinNIBT92A8OilebhMoEGW6
         slP5lLbCjCBj/W2xZy1fYiGgKEIl21ynARUl5a0rToyV2o0OYAHyMsGCNfOBLVCtpRkh
         PBXlCC9KrDTTcDCkAlyyrjlDsZc1rPfEaBF++UbmU8dinpe0CG34C1fMUgq60okfcaVF
         ucnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1bX38xDgQBkiHIqltbjAQiLDAH1CFYr3yOguDUYlnqw=;
        b=NmxjYUtKo1/i+zQaYDAiteNh9p+VYGhlsOq5adTk8QTHLeWXuLy31VQUHC3bhlFQL7
         l27i5upCbXYH7PnTo3ch5IDyMMnjUMZw6eWpNxdmmThEfNpACeKI6cpzooNVxthOXnEO
         vKglq4qcy/7Sx15zZlB7pimx2K8GvWp7Aio8vU4eim5GtmDAyM9NpBZJhQR3ZvJqAZae
         SkWJr+3KpnNL03RkHTh/9UAK9CAfvfB/zFPykMENW6Q7j2MkOsu4Qq8+LfRE7P4tn8LH
         6DjUoDfLjSMTvOuKYNmJgwFbMtrA28PbjLhz1LXfvYZn8uvrU4d9DR6MClYFJLDfLiOd
         g5ng==
X-Gm-Message-State: AOAM5309FuDb3fo2si2UjG2ZuM/aCRFY/Y3d4SOXwbpVHlkwXk7CPcuZ
        qwhzgCrTFiIcS7ulBLeH36s=
X-Google-Smtp-Source: ABdhPJxEjlJFJGVTAjGnyx5DvLCqwxvcN8Lm7hHVl/iLANHBcRj9vEHhxDtcuQ7BGMXnggOuNs0B1A==
X-Received: by 2002:a17:90a:8981:: with SMTP id v1mr24265764pjn.230.1616961771947;
        Sun, 28 Mar 2021 13:02:51 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id z11sm15001992pgj.22.2021.03.28.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 13:02:49 -0700 (PDT)
Date:   Mon, 29 Mar 2021 01:32:46 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/03/25 09:16PM, Qu Wenruo wrote:
>
>
> On 2021/3/25 下午8:20, Neal Gompa wrote:
> > On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
> > >
> > > This patchset can be fetched from the following github repo, along with
> > > the full subpage RW support:
> > > https://github.com/adam900710/linux/tree/subpage
> > >
> > > This patchset is for metadata read write support.
> > >
> > > [FULL RW TEST]
> > > Since the data write path is not included in this patchset, we can't
> > > really test the patchset itself, but anyone can grab the patch from
> > > github repo and do fstests/generic tests.
> > >
> > > But at least the full RW patchset can pass -g generic/quick -x defrag
> > > for now.
> > >
> > > There are some known issues:
> > >
> > > - Defrag behavior change
> > >    Since current defrag is doing per-page defrag, to support subpage
> > >    defrag, we need some change in the loop.
> > >    E.g. if a page has both hole and regular extents in it, then defrag
> > >    will rewrite the full 64K page.
> > >
> > >    Thus for now, defrag related failure is expected.
> > >    But this should only cause behavior difference, no crash nor hang is
> > >    expected.
> > >
> > > - No compression support yet
> > >    There are at least 2 known bugs if forcing compression for subpage
> > >    * Some hard coded PAGE_SIZE screwing up space rsv
> > >    * Subpage ASSERT() triggered
> > >      This is because some compression code is unlocking locked_page by
> > >      calling extent_clear_unlock_delalloc() with locked_page == NULL.
> > >    So for now compression is also disabled.
> > >
> > > - Inode nbytes mismatch
> > >    Still debugging.
> > >    The fastest way to trigger is fsx using the following parameters:
> > >
> > >      fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tmp/fsx
> > >
> > >    Which would cause inode nbytes differs from expected value and
> > >    triggers btrfs check error.
> > >
> > > [DIFFERENCE AGAINST REGULAR SECTORSIZE]
> > > The metadata part in fact has more new code than data part, as it has
> > > some different behaviors compared to the regular sector size handling:
> > >
> > > - No more page locking
> > >    Now metadata read/write relies on extent io tree locking, other than
> > >    page locking.
> > >    This is to allow behaviors like read lock one eb while also try to
> > >    read lock another eb in the same page.
> > >    We can't rely on page lock as now we have multiple extent buffers in
> > >    the same page.
> > >
> > > - Page status update
> > >    Now we use subpage wrappers to handle page status update.
> > >
> > > - How to submit dirty extent buffers
> > >    Instead of just grabbing extent buffer from page::private, we need to
> > >    iterate all dirty extent buffers in the page and submit them.
> > >
> > > [CHANGELOG]
> > > v2:
> > > - Rebased to latest misc-next
> > >    No conflicts at all.
> > >
> > > - Add new sysfs interface to grab supported RO/RW sectorsize
> > >    This will allow mkfs.btrfs to detect unmountable fs better.
> > >
> > > - Use newer naming schema for each patch
> > >    No more "extent_io:" or "inode:" schema anymore.
> > >
> > > - Move two pure cleanups to the series
> > >    Patch 2~3, originally in RW part.
> > >
> > > - Fix one uninitialized variable
> > >    Patch 6.
> > >
> > > v3:
> > > - Rename the sysfs to supported_sectorsizes
> > >
> > > - Rebased to latest misc-next branch
> > >    This removes 2 cleanup patches.
> > >
> > > - Add new overview comment for subpage metadata
> > >
> > > Qu Wenruo (13):
> > >    btrfs: add sysfs interface for supported sectorsize
> > >    btrfs: use min() to replace open-code in btrfs_invalidatepage()
> > >    btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
> > >    btrfs: refactor how we iterate ordered extent in
> > >      btrfs_invalidatepage()
> > >    btrfs: introduce helpers for subpage dirty status
> > >    btrfs: introduce helpers for subpage writeback status
> > >    btrfs: allow btree_set_page_dirty() to do more sanity check on subpage
> > >      metadata
> > >    btrfs: support subpage metadata csum calculation at write time
> > >    btrfs: make alloc_extent_buffer() check subpage dirty bitmap
> > >    btrfs: make the page uptodate assert to be subpage compatible
> > >    btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
> > >    btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
> > >      compatible
> > >    btrfs: add subpage overview comments
> > >
> > >   fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++---------
> > >   fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
> > >   fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
> > >   fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
> > >   fs/btrfs/subpage.h   |  17 +++++
> > >   fs/btrfs/sysfs.c     |  15 +++++
> > >   6 files changed, 441 insertions(+), 116 deletions(-)
> > >
> > > --
> > > 2.30.1
> > >
> >
> > Why wouldn't we just integrate full read-write support with the
> > caveats as described now? It seems to be relatively reasonable to do
> > that, and this patch set is essentially unusable without the rest of
> > it that does enable full read-write support.
>
> The metadata part is much more stable than data path (almost not touched
> for several months), and the metadata part already has some difference
> in its behavior, which needs review.
>
> You point makes some sense, but I still don't believe pushing a super
> large patchset does any help for the review.
>
> If you want to test, you can grab the branch from the github repo.
> If you want to review, the mails are all here for review.
>
> In fact, we used to have subpage support sent as a big patchset from IBM
> guys, but the result is only some preparation patches get merged, and
> nothing more.
>
> Using this multi-series method, we're already doing better work and
> received more testing (to ensure regular sectorsize is not affected at
> least).

Hi Qu Wenruo,

Sorry about chiming in late on this. I don't have any strong objection on either
approach. Although sometime back when I tested your RW support git tree on
Power, the unmount patch itself was crashing. I didn't debug it that time
(this was a month back or so), so I also didn't bother testing xfstests on Power.

But we do have an interest in making sure this patch series work on bs < ps
on Power platform. I can try helping with testing, reviewing (to best of my
knowledge) and fixing anything is possible :)

Let me try and pull your tree and test it on Power. Please let me know if there
is anything needs to be taken care apart from your github tree and btrfs-progs
branch with bs < ps support.

-ritesh


