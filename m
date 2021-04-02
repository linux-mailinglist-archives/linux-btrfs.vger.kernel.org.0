Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79748352790
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhDBIrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBIrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Apr 2021 04:47:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F12C0613E6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Apr 2021 01:46:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l76so3189288pga.6
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Apr 2021 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=obgvns4uzXukdBt15vUmkphfF9pXePOj2S8anWMozG0=;
        b=AXd3U53xirRzrZKZxurzC2eoAzXj0MtqtIO/493G4tjNBKmEp3Gc1k+aMn/g7QZfin
         tnssxg5oYxPh1M0VGLO+9ilGrvk7+G8RC55bhpq6BvH85fDZA7iilVNYFHrnlEVyuzko
         C06F8T1sLvo52ly1vvjxZdNVkjhqpe4vBcavFLvymbf9XwkEA7nVaor1LNjIARKeF89n
         vR7a5Qgc3ly8YbUo5Sh74j15KtXUHYP9jPSP0opNhQNZAcUf6diWcIjabxD3xITWOR6D
         9SjO6JHisYj/CCJgzQ5lCar5sm/9Og8drIyQcU+k5JiG4e+wfFtNwrvXcXPfjQca/pzj
         2zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=obgvns4uzXukdBt15vUmkphfF9pXePOj2S8anWMozG0=;
        b=skUNeUEGWp5KQqt68Snp7E+5U9pxAu5jNk16nqZkfExyl634QD7GOGv+N4zUsF99sL
         9IvEDZmbhAx+qfywcIp6iXoWjndETMf++3b1YK2+SQvEL7F6lTtGmwSQX045YTgDarv1
         2Puo9dHODeWHCc2az3ZWO7SZnfU5gPF8xIDEeGsP6uriirHyKESjp3Cdcmz/PMAJsSCm
         wKW4QGJumIgoKFs3jSHzzZKGqA5IdgHNttrFZ5eBNbkuc8lF6x63mCVTcoCsPJ/Ys5rq
         IWdBPay1fUrgtc2Sgkmblm2RSs9JHlIAE2uU+dhfX9uo95DyDWMt9/PymjxDxe2PnkAw
         73gA==
X-Gm-Message-State: AOAM532JxrkYEvtH6l6X5+fjIoBeCERTvDPxj6dur20jf1aejUUgq7WW
        ppEdNiKRrp0NfdlugjnW5Ys=
X-Google-Smtp-Source: ABdhPJyaznE2I7QuEDqrkoeIYucjPJhQPqGUNkmODmP2TIWokZkmwiihSQlE7JLXCSBuQ+ipCmzsOw==
X-Received: by 2002:a65:5585:: with SMTP id j5mr10931635pgs.316.1617353215349;
        Fri, 02 Apr 2021 01:46:55 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id d2sm7260209pjx.42.2021.04.02.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 01:46:55 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:16:52 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/02 04:36PM, Qu Wenruo wrote:
>
>
> On 2021/4/2 下午4:33, Ritesh Harjani wrote:
> > On 21/03/29 10:01AM, Qu Wenruo wrote:
> > >
> > >
> > > On 2021/3/29 上午4:02, Ritesh Harjani wrote:
> > > > On 21/03/25 09:16PM, Qu Wenruo wrote:
> > > > >
> > > > >
> > > > > On 2021/3/25 下午8:20, Neal Gompa wrote:
> > > > > > On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
> > > > > > >
> > > > > > > This patchset can be fetched from the following github repo, along with
> > > > > > > the full subpage RW support:
> > > > > > > https://github.com/adam900710/linux/tree/subpage
> > > > > > >
> > > > > > > This patchset is for metadata read write support.
> > > > > > >
> > > > > > > [FULL RW TEST]
> > > > > > > Since the data write path is not included in this patchset, we can't
> > > > > > > really test the patchset itself, but anyone can grab the patch from
> > > > > > > github repo and do fstests/generic tests.
> > > > > > >
> > > > > > > But at least the full RW patchset can pass -g generic/quick -x defrag
> > > > > > > for now.
> > > > > > >
> > > > > > > There are some known issues:
> > > > > > >
> > > > > > > - Defrag behavior change
> > > > > > >      Since current defrag is doing per-page defrag, to support subpage
> > > > > > >      defrag, we need some change in the loop.
> > > > > > >      E.g. if a page has both hole and regular extents in it, then defrag
> > > > > > >      will rewrite the full 64K page.
> > > > > > >
> > > > > > >      Thus for now, defrag related failure is expected.
> > > > > > >      But this should only cause behavior difference, no crash nor hang is
> > > > > > >      expected.
> > > > > > >
> > > > > > > - No compression support yet
> > > > > > >      There are at least 2 known bugs if forcing compression for subpage
> > > > > > >      * Some hard coded PAGE_SIZE screwing up space rsv
> > > > > > >      * Subpage ASSERT() triggered
> > > > > > >        This is because some compression code is unlocking locked_page by
> > > > > > >        calling extent_clear_unlock_delalloc() with locked_page == NULL.
> > > > > > >      So for now compression is also disabled.
> > > > > > >
> > > > > > > - Inode nbytes mismatch
> > > > > > >      Still debugging.
> > > > > > >      The fastest way to trigger is fsx using the following parameters:
> > > > > > >
> > > > > > >        fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tmp/fsx
> > > > > > >
> > > > > > >      Which would cause inode nbytes differs from expected value and
> > > > > > >      triggers btrfs check error.
> > > > > > >
> > > > > > > [DIFFERENCE AGAINST REGULAR SECTORSIZE]
> > > > > > > The metadata part in fact has more new code than data part, as it has
> > > > > > > some different behaviors compared to the regular sector size handling:
> > > > > > >
> > > > > > > - No more page locking
> > > > > > >      Now metadata read/write relies on extent io tree locking, other than
> > > > > > >      page locking.
> > > > > > >      This is to allow behaviors like read lock one eb while also try to
> > > > > > >      read lock another eb in the same page.
> > > > > > >      We can't rely on page lock as now we have multiple extent buffers in
> > > > > > >      the same page.
> > > > > > >
> > > > > > > - Page status update
> > > > > > >      Now we use subpage wrappers to handle page status update.
> > > > > > >
> > > > > > > - How to submit dirty extent buffers
> > > > > > >      Instead of just grabbing extent buffer from page::private, we need to
> > > > > > >      iterate all dirty extent buffers in the page and submit them.
> > > > > > >
> > > > > > > [CHANGELOG]
> > > > > > > v2:
> > > > > > > - Rebased to latest misc-next
> > > > > > >      No conflicts at all.
> > > > > > >
> > > > > > > - Add new sysfs interface to grab supported RO/RW sectorsize
> > > > > > >      This will allow mkfs.btrfs to detect unmountable fs better.
> > > > > > >
> > > > > > > - Use newer naming schema for each patch
> > > > > > >      No more "extent_io:" or "inode:" schema anymore.
> > > > > > >
> > > > > > > - Move two pure cleanups to the series
> > > > > > >      Patch 2~3, originally in RW part.
> > > > > > >
> > > > > > > - Fix one uninitialized variable
> > > > > > >      Patch 6.
> > > > > > >
> > > > > > > v3:
> > > > > > > - Rename the sysfs to supported_sectorsizes
> > > > > > >
> > > > > > > - Rebased to latest misc-next branch
> > > > > > >      This removes 2 cleanup patches.
> > > > > > >
> > > > > > > - Add new overview comment for subpage metadata
> > > > > > >
> > > > > > > Qu Wenruo (13):
> > > > > > >      btrfs: add sysfs interface for supported sectorsize
> > > > > > >      btrfs: use min() to replace open-code in btrfs_invalidatepage()
> > > > > > >      btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
> > > > > > >      btrfs: refactor how we iterate ordered extent in
> > > > > > >        btrfs_invalidatepage()
> > > > > > >      btrfs: introduce helpers for subpage dirty status
> > > > > > >      btrfs: introduce helpers for subpage writeback status
> > > > > > >      btrfs: allow btree_set_page_dirty() to do more sanity check on subpage
> > > > > > >        metadata
> > > > > > >      btrfs: support subpage metadata csum calculation at write time
> > > > > > >      btrfs: make alloc_extent_buffer() check subpage dirty bitmap
> > > > > > >      btrfs: make the page uptodate assert to be subpage compatible
> > > > > > >      btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
> > > > > > >      btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
> > > > > > >        compatible
> > > > > > >      btrfs: add subpage overview comments
> > > > > > >
> > > > > > >     fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++---------
> > > > > > >     fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
> > > > > > >     fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
> > > > > > >     fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
> > > > > > >     fs/btrfs/subpage.h   |  17 +++++
> > > > > > >     fs/btrfs/sysfs.c     |  15 +++++
> > > > > > >     6 files changed, 441 insertions(+), 116 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.30.1
> > > > > > >
> > > > > >
> > > > > > Why wouldn't we just integrate full read-write support with the
> > > > > > caveats as described now? It seems to be relatively reasonable to do
> > > > > > that, and this patch set is essentially unusable without the rest of
> > > > > > it that does enable full read-write support.
> > > > >
> > > > > The metadata part is much more stable than data path (almost not touched
> > > > > for several months), and the metadata part already has some difference
> > > > > in its behavior, which needs review.
> > > > >
> > > > > You point makes some sense, but I still don't believe pushing a super
> > > > > large patchset does any help for the review.
> > > > >
> > > > > If you want to test, you can grab the branch from the github repo.
> > > > > If you want to review, the mails are all here for review.
> > > > >
> > > > > In fact, we used to have subpage support sent as a big patchset from IBM
> > > > > guys, but the result is only some preparation patches get merged, and
> > > > > nothing more.
> > > > >
> > > > > Using this multi-series method, we're already doing better work and
> > > > > received more testing (to ensure regular sectorsize is not affected at
> > > > > least).
> > > >
> > > > Hi Qu Wenruo,
> > > >
> > > > Sorry about chiming in late on this. I don't have any strong objection on either
> > > > approach. Although sometime back when I tested your RW support git tree on
> > > > Power, the unmount patch itself was crashing. I didn't debug it that time
> > > > (this was a month back or so), so I also didn't bother testing xfstests on Power.
> > > >
> > > > But we do have an interest in making sure this patch series work on bs < ps
> > > > on Power platform. I can try helping with testing, reviewing (to best of my
> > > > knowledge) and fixing anything is possible :)
> > >
> > > That's great!
> > >
> > > One of my biggest problem here is, I don't have good enough testing
> > > environment.
> > >
> > > Although SUSE has internal clouds for ARM64/PPC64, but due to the
> > > f**king Great Firewall, it's super slow to access, no to mention doing
> > > proper debugging.
> > >
> > > Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the test.
> > > But their computing power is far from ideal, only generic/quick can
> > > finish in hours.
> > >
> > > Thus real world Power could definitely help.
> > > >
> > > > Let me try and pull your tree and test it on Power. Please let me know if there
> > > > is anything needs to be taken care apart from your github tree and btrfs-progs
> > > > branch with bs < ps support.
> > >
> > > If you're going to test the branch, here are some small notes:
> > >
> > > - Need to use latest btrfs-progs
> > >    As it fixes a false alert on crossing 64K page boundary.
> > >
> > > - Need to slightly modify btrfs-progs to avoid false alerts
> > >    For subpage case, mkfs.btrfs will output a warning, but that warning
> > >    is outputted into stderr, which will screw up generic test groups.
> > >    It's recommended to apply the following diff:
> > >
> > > diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> > > index 569208a9..21976554 100644
> > > --- a/common/fsfeatures.c
> > > +++ b/common/fsfeatures.c
> > > @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
> > >                  return -EINVAL;
> > >          }
> > >          if (page_size != sectorsize)
> > > -               warning(
> > > -"the filesystem may not be mountable, sectorsize %u doesn't match page
> > > size %u",
> > > +               printf(
> > > +"the filesystem may not be mountable, sectorsize %u doesn't match page
> > > size %u\n",
> > >                          sectorsize, page_size);
> > >          return 0;
> > >   }
> > >
> > > - Xfstest/btrfs group will crash at btrfs/143
> > >    Still investigating, but you can ignore btrfs group for now.
> > >
> > > - Very rare hang
> > >    There is a very low change to hang, with "bad ordered accounting"
> > >    dmesg.
> > >    If you can hit, please let me know.
> > >    I had something idea to fix it, but not yet in the branch.
> > >
> > > - btrfs inode nbytes mismatch
> > >    Investigating, as it will make btrfs-check to report error.
> > >
> > > The last two bugs are the final show blocker, I'll give you extra
> > > updates when those are fixed.
> >
> > Thanks Qu Wenruo, for above info.
> > I cloned below git tree as mentioned in your git log to test for RW on Power.
> > However, I still see that RW mount for bs < ps is disabled for in open_ctree()
> > https://github.com/adam900710/linux/tree/subpage
> >
> > I see below code present in this tree.
> >           /* For 4K sector size support, it's only read-only */
> >           if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
> >                   if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
> >                           btrfs_err(fs_info,
> >           "subpage sectorsize %u only supported read-only for page size %lu",
> >                                   sectorsize, PAGE_SIZE);
> >                           err = -EINVAL;
> >                           goto fail_alloc;
> >                   }
> >           }
> >
> > Could you pls point me to the tree I can use for bs < ps testing on Power?
> > Sorry if I missed something.
>
> Sorry, I updated the branch to my current development progress, it's now
> at the ordered extent rework part, without the remaining subpage
> functionality at all.
>
> You may want to grab this tree instead:
> https://github.com/adam900710/linux/tree/subpage_old
>
> But please keep in mind that, you may get random hang, and certain
> generic test case, especially generic/075 can corrupt the inode nbytes
> and leaving all later test cases using TEST_DEV to report error on fsck.
>

Thanks for quick response. Sure, I will exclude generic/075 from the test
for now.

-ritesh
