Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1095588525
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 02:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiHCAaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 20:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHCAaC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 20:30:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC761EC60
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 17:30:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gk3so16524201ejb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsSrkaj5RMotTIQ3fpJ6cqiWJt9qhHEEfoVBt/IOoMs=;
        b=jGtJPxzsnI33zid6cemA3aBlyNPXbL9aDfwjFTCSrELSiZWDG55ytcbK37M+Km/H0K
         L8i6RPIlZ5L1DAHoRSGhyu6JR1ZZVdKAR9YlcW2838E09ls3LZs9xC9wZKBGfTjimgnf
         B397WUU7hNJPxUiHMPt76NZy7sRUvd8RJnke8oJeKNozx2w653aqTbygjWBVrQWYJX2F
         el0+PHPpu1FBrrt84Je3PPuMEdflHW9v+YFgT91ro3vCBLJJAL2s2wOxN5Qn9y1+RPjD
         gBx57dWO4+0I7yBv9KhDtmfla1n6VfbgDUtg1x8jsnEkDt7TqpuaOeGQ3soUMQUpaN5q
         o4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsSrkaj5RMotTIQ3fpJ6cqiWJt9qhHEEfoVBt/IOoMs=;
        b=lDdYt7cgoqE1l3yRLyctsfc/aCaY8M/AfHqEhCLIg43RL6o8sgUjHB5MZLKQfR3DxH
         brWcqPAB255L06F/CUlcRQS70yCWKSL90RlQq/yPUk973iEa6fRivAFWR5wRBcjPUjbH
         Ih858qT36Q1TDj+4lzqxDrzzo+wTX3pG9PkL+KZX4L6+4iu7U3hDEZh4vcOWWP8oPE5H
         SqUMDwd0dLZMuMJbou90Nc1tGPafsqLsCHFPz9CwNzbo3r+0DIoI3rWl9gpO8UM4/fWM
         gmhD3yZzCVSeGh7FysEGmAfNlqT0YLkVlb0thbVpbptw1IEYGrv6U3t6Pc4wn7mYBDPT
         grZA==
X-Gm-Message-State: AJIora+/sZBYUpXdVnHbSQxX6NfdBnuvGtCKcPE5AQXt2u+NyKSGLHZz
        9tLOTgNcU29YzeTKo+G1fwddd2Lg7zqw5PhMByJQXNLp6+V0rg==
X-Google-Smtp-Source: AGRyM1sktc1dtixiiO3s3QkoIISKZjl27THZN1FgSxpmg+1auqorRddoxgOq6fUSaiURcj4djjXAX/nwjiZCWaP3DzM=
X-Received: by 2002:a17:907:6e10:b0:72b:7ddc:e9e6 with SMTP id
 sd16-20020a1709076e1000b0072b7ddce9e6mr18106526ejc.12.1659486598884; Tue, 02
 Aug 2022 17:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658726692.git.wqu@suse.com>
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
From:   "me@jse.io" <me@jse.io>
Date:   Tue, 2 Aug 2022 21:29:22 -0300
Message-ID: <CAFMvigdrNM4Jspc=_Pu1UM8Z=+YBdcMuAqJVTK6=LJzC43Aokw@mail.gmail.com>
Subject: Re: [PATCH 00/14] btrfs: introduce write-intent bitmaps for RAID56
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey there,
It would be nice if a bitmap could be used for other purposes too, not
just for RAID5/6. To not only improve resilver times without scrubbing
the entire array, but also for just syncing up NOCOW files. Corruption
sucks, and using NOCOW the user should assume you have no protection
from csums. However, the problem with NOCOW right now is on any
redundant profile, it seems once one copy goes out of sync with
another, unless the user balances the affected chunks or cp
--reflink=never the file, you can end up in a case where one copy may
always be out of sync with the other. Then, the application reading
the file can get different results depending on which disk it reads
from.

That seems worse than the corruption itself that can't be repaired due
to no CSUMs, and is by far worse than MD.

This is especially worrisome since a number of distros and userspace
tools and distros these days are defaulting to using the NOCOW
attribute for common applications. ie. Arch and mySQL, or libvirt.

Is there any way this could be used for these purposes as well, in
addition to the stated purpose for RAID5/6?

On Mon, Jul 25, 2022 at 2:38 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [CHANGELOG]
> v2->v1:
> - Add mount time recovery functionality
>   Now if a dirty bitmap is found, we will do proper recovery at mount
>   time.
>
>   The code is using scrub routine to do the proper recovery for both
>   data and P/Q parity.
>
>   Currently we can only test this by manually setting up a dirty bitmap,
>   and corrupt the full stripe, then mounting it and verify the full
>   stripe using "btrfs check --check-data-csum"
>
> - Skip full stripe writes
>   Full stripe writes are either:
>   * New writes into unallocated space
>     After powerloss, we won't read any data from the full stripe.
>
>   * Writes into NODATACOW ranges
>     We won't have csum for them anyway, thus new way to do any recovery.
>
> - Fix a memory leakage caused by RO mount
>   Previously we only cleanup the write-intent ctrl if it's RW mount,
>   thus for RO mount we will cause memory leak.
>
>
> RFC->v1:
> - Fix a corner case in write_intent_set_bits()
>   If the range covers the last existing entry, but still needs a new
>   entry, the old code will not insert the new entry, causing
>   write_intent_clear_bits() to cause a warning.
>
> - Add selftests for the write intent bitmaps
>   The write intent bitmaps is an sparse array of bitmaps.
>   There are some corner cases tricky to get it done correctly in the
>   first try (see above case).
>   The test case would prevent such problems from happening again.
>
> - Fix hang with dev-replace, and better bitmaps bio submission
>   Previously we will hold device_list_mutex while submitting the bitmaps
>   bio, this can lead to deadlock with dev-replace/dev-removal.
>   Fix it by using RCU to keep an local copy of devices and use them
>   to submit the bitmaps bio.
>
>   Furthermore, there is no need to follow the way of superblocks
>   writeback, as the content of bitmaps are always the same for all
>   devices, we can just submitting the same page and use atomic counter
>   to wait for them to finish.
>
>   Now there is no more crash/warning/deadlock in btrfs/070.
>
> [BACKGROUND]
> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
> loss happens.
>
> For pure mirror based profiles it's fine as btrfs can utilize its csums
> to find the correct mirror the repair the bad ones.
>
> But for RAID56, the repair itself needs the data from other devices,
> thus any out-of-sync data can degrade the tolerance.
>
> Even worse, incorrect RMW can use the stale data to generate P/Q,
> removing the possibility of recovery the data.
>
>
> For md-raid, it goes with write-intent bitmap, to do faster resilver,
> and goes journal (partial parity log for RAID5) to ensure it can even
> stand a powerloss + device lose.
>
> [OBJECTIVE]
>
> This patchset will introduce a btrfs specific write-intent bitmap.
>
> The bitmap will locate at physical offset 1MiB of each device, and the
> content is the same between all devices.
>
> When there is a RAID56 write (currently all RAID56 write, including full
> stripe write), before submitting all the real bios to disks,
> write-intent bitmap will be updated and flushed to all writeable
> devices.
>
> So even if a powerloss happened, at the next mount time we know which
> full stripes needs to check, and can start a scrub for those involved
> logical bytenr ranges.
>
> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
>
> Since btrfs can utilize csum for its metadata and CoWed data, unlike
> dm-bitmap which can only be used for faster re-silver, we can fully
> rebuild the full stripe, as long as:
>
> 1) There is no missing device
>    For missing device case, we still need to go full journal.
>
> 2) Untouched data stays untouched
>    This should be mostly sane for sane hardware.
>
> And since the btrfs specific write-intent bitmaps are pretty small (4KiB
> in size), the overhead much lower than full journal.
>
> In the future, we may allow users to choose between just bitmaps or full
> journal to meet their requirement.
>
> [BITMAPS DESIGN]
>
> The bitmaps on-disk format looks like this:
>
>  [ super ][ entry 1 ][ entry 2 ] ... [entry N]
>  |<---------  super::size (4K) ------------->|
>
> Super block contains how many entires are in use.
>
> Each entry is 128 bits (16 bytes) in size, containing one u64 for
> bytenr, and u64 for one bitmap.
>
> And all utilized entries will be sorted in their bytenr order, and no
> bit can overlap.
>
> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
> can contain at most 4MiB, and the whole bitmaps can contain 224 entries.
>
> For the worst case, it can contain 14MiB dirty ranges.
> (1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).
>
> For the best case, it can contain 896MiB dirty ranges.
> (all bits set per bitmap)
>
> [WHY NOT BTRFS BTREE]
>
> Current write-intent structure needs two features:
>
> - Its data needs to survive cross stripe boundary
>   Normally this means write-intent btree needs to acts like a proper
>   tree root, has METADATA_ITEMs for all its tree blocks.
>
> - Its data update must be outside of a transaction
>   Currently only log tree can do such thing.
>   But unfortunately log tree can not survive across transaction
>   boundary.
>
> Thus write-intent btree can only meet one of the requirement, not a
> suitable solution here.
>
> [TESTING AND BENCHMARK]
>
> For performance benchmark, unfortunately I don't have 3 HDDs to test.
> Will do the benchmark after secured enough hardware.
>
> For testing, it can survive volume/raid/dev-replace test groups, and no
> write-intent bitmap leakage.
>
> Unfortunately there is still a warning triggered in btrfs/070, still
> under investigation, hopefully to be a false alert in bitmap clearing
> path.
>
> [TODO]
> - Extra optimizations
>   * Enlarge the window between btrfs_write_intent_mark_dirty() and
>     btrfs_write_intent_writeback()
>     So that we can merge more dirty bites and cause less bitmaps
>     writeback
>
> - Proper performance benchmark
>   Needs hardware/baremetal VMs, since I don't have any physical machine
>   large enough to contian 3 3.5" HDDs.
>
>
> Qu Wenruo (14):
>   btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
>   btrfs: introduce a new experimental compat RO flag,
>     WRITE_INTENT_BITMAP
>   btrfs: introduce the on-disk format of btrfs write intent bitmaps
>   btrfs: load/create write-intent bitmaps at mount time
>   btrfs: write-intent: write the newly created bitmaps to all disks
>   btrfs: write-intent: introduce an internal helper to set bits for a
>     range.
>   btrfs: write-intent: introduce an internal helper to clear bits for a
>     range.
>   btrfs: selftests: add selftests for write-intent bitmaps
>   btrfs: write back write intent bitmap after barrier_all_devices()
>   btrfs: update and writeback the write-intent bitmap for RAID56 write.
>   btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
>   btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
>   btrfs: avoid recording full stripe write into write-intent bitmaps
>   btrfs: scrub the full stripe which had sub-stripe write at mount time
>
>  fs/btrfs/Makefile                           |   5 +-
>  fs/btrfs/ctree.h                            |  26 +-
>  fs/btrfs/disk-io.c                          |  58 +-
>  fs/btrfs/raid56.c                           |  27 +
>  fs/btrfs/scrub.c                            | 177 +++-
>  fs/btrfs/sysfs.c                            |   2 +
>  fs/btrfs/tests/btrfs-tests.c                |   4 +
>  fs/btrfs/tests/btrfs-tests.h                |   2 +
>  fs/btrfs/tests/write-intent-bitmaps-tests.c | 247 ++++++
>  fs/btrfs/volumes.c                          |  34 +-
>  fs/btrfs/write-intent.c                     | 923 ++++++++++++++++++++
>  fs/btrfs/write-intent.h                     | 303 +++++++
>  fs/btrfs/zoned.c                            |   8 +
>  include/uapi/linux/btrfs.h                  |  17 +
>  14 files changed, 1812 insertions(+), 21 deletions(-)
>  create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c
>  create mode 100644 fs/btrfs/write-intent.c
>  create mode 100644 fs/btrfs/write-intent.h
>
> --
> 2.37.0
>
