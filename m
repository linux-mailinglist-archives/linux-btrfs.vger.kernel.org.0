Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA25893DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiHCVBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiHCVBk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 17:01:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEDE459B8
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 14:01:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z2so12558231edc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Aug 2022 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pKUtGnrdWjxky+g+Jm0pyulH4d9oucsFVyw1xkv/2/E=;
        b=MonEybvadH1FtsPDXr3LuIxBB2MuI9ES397hhIjPVrKdt6BWYOvjMZD9tPZTEvtWMK
         kK8bNf0v4ZTpFap8FRf1r3u2NjF+T+7ylTjy0N419blW+j/T9XW+7pC1SzQrLJi/UeV3
         dTUvkshjgQTTF2Ukz57t06XZzBDADDNpqRLq2WMC2zqqvrW18fW1moGeZfHT9bq009tK
         OvTLvcfl2Ph3GDxefZGbJGuNYs+C33zEKKY99KpUn5cGsuLPJ3V+LU+fRm7HEUGG1f0+
         5viJGVlfHSNMhLRjdCM/sQAO99JjMXmixfPhMGJhAEfFCUe3syo/IWlacBAHWZz5OJAr
         5s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pKUtGnrdWjxky+g+Jm0pyulH4d9oucsFVyw1xkv/2/E=;
        b=uw5cWLNQMlgOa5bFCCKlhNxozLkhAjZurp5ZAhk2bblNm/xBXDToblcSkfhjaB6pA+
         iwtADQJ/fvR0OeQQ+Ff8lmjU8PzzJLBADb1isid640YyPjhjtJCEYS7vyNtrmsIbkgJ/
         RcL4svCaLyM1pnZkcTAx0FEtgoxEIZ3D8MQ0LepYGXCr+AlA0cvCw5ds422xwNrsy3Rm
         h5VnbuZDE9lUlZt/yixDhlX+2C9npjKbY6YU19QGUENiVpHwPsz/u0I48liOWVirQX/2
         eTJH+P9VbmSraLpQW7TghGPrpS9EdHXhyL+49vfH3MrgvMdZdxEQ8BIXuCO1T6RXHcES
         wy/g==
X-Gm-Message-State: AJIora8PpffLcAykWijIX+G1Ul2EoTbyuqYIGko908h8+r54NMmamtrz
        5pEsgxzuStoz8TQRypfjPUeAGWnCeWVf+bOhvAR0ZwqhbvM=
X-Google-Smtp-Source: AGRyM1vO1FonhGeCGFO55//7iWgT3F056bI1dZSRjc+bUSS0SKfanoxdXx7mG14ryhuQqVPJPze4G/1G2jOCE4XcAv4=
X-Received: by 2002:a05:6402:288c:b0:43c:d371:48e4 with SMTP id
 eg12-20020a056402288c00b0043cd37148e4mr26533347edb.239.1659560495836; Wed, 03
 Aug 2022 14:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658726692.git.wqu@suse.com> <CAFMvigdrNM4Jspc=_Pu1UM8Z=+YBdcMuAqJVTK6=LJzC43Aokw@mail.gmail.com>
 <e2ea258a-baa8-e437-a303-c55184a55106@gmx.com> <feb3072c-794f-8b15-23d3-4a212191fd90@libero.it>
In-Reply-To: <feb3072c-794f-8b15-23d3-4a212191fd90@libero.it>
From:   "me@jse.io" <me@jse.io>
Date:   Wed, 3 Aug 2022 18:00:59 -0300
Message-ID: <CAFMvigcXp1q+EXoo3Ppvgs7RnbPAD-=6f9g4mS6rEvTHapsVyw@mail.gmail.com>
Subject: Re: [PATCH 00/14] btrfs: introduce write-intent bitmaps for RAID56
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 3, 2022 at 6:11 AM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 03/08/2022 02.58, Qu Wenruo wrote:
> >
> >
> > On 2022/8/3 08:29, me@jse.io wrote:
> >> Hey there,
> [...]
> >>
> >> That seems worse than the corruption itself that can't be repaired due
> >> to no CSUMs, and is by far worse than MD.
> >
> > The problem for NOCOW file is, it also implies NOCSUM, and even we can
> > detect mismatches in copies, it only really helps limited profiles like
> > RAID1C3, RAID1C4, and maybe RAID56.
> >
> > The problem here is, for 2 mirrors profiles, even if we can detect the
> > mismatch, we have no idea which is correct.
> >
> > We rely on csum to determine which copy is correct, but NOCOW/NOCSUM
> > makes it very hard to do.
> >
> > For RAID1C3/C4 we can go democracy, but for RAID1C4 it's also possible
> > that we got two different content from all the mirrors.
>
> The same is true for all the "even" redundancy. I.e. even for raid6
> you can have two different matches: one with P and one with Q.
>
> Anyway I think that the point of 'me' is to not have two different
> data depending by the read path. To this, it is preferable to have always
> the same data, even if it is wrong.

You're exactly right. As it stands now, even if the corruption is read
by the application and repaired/worked around, depending on how the
application works, now you may have corruption on your other copy
until you manually intervene. If the user isn't aware of this
situation, then they'll just assume that "btrfs is unstable" and not
really understand why their VM or database keeps corrupting at
'random'. Btrfs doesn't really provide a way to easily identify when
you run into this situation anyway. I'm coming from the standpoint of
a user who just goes with defaults, given libvirt and distros are
defaulting the attribute for certain applications.

It would be preferable to be able to sync it from the get go through
the use of bitmaps, knowing that Btrfs cannot determine which copy is
correct, but neither can MD. It just knows the range on a specific
disk is 'dirty'. All we should expect of Btrfs in the NOCOW case is it
should at least produce similar behavior to how MD would work with a
traditional overwriting filesystem on it. It would sync the range in
question thanks to its bitmap.

>
> What does scrub when it works on a raid4c (or raid 5/6) with a nocow
> data and each block is different ?
>
> If this can "solve" the problem of 'me' we could discuss to refine
> the logic to skip only under the conditions "full stripe" **and**
> "cow data".
>
> This is a problem that we need to discuss even with a
> full journal (where still have the option to skip a full stripe).
>
> BR
> G.Baroncelli
>
> >
> > If we really want to solve the NOCOW/NOCSUM problem, I guess full
> > journal is the only solution, and I'm pretty sure we will go that
> > direction anyway (after the write-intent part get merged, as the full
> > journal still relies on a lot of things from write-intent code).
> >
> >>
> >> This is especially worrisome since a number of distros and userspace
> >> tools and distros these days are defaulting to using the NOCOW
> >> attribute for common applications. ie. Arch and mySQL, or libvirt.
> >>
> >> Is there any way this could be used for these purposes as well, in
> >> addition to the stated purpose for RAID5/6?
> >
> > For now, the plan for future development on write-intent only includes:
> >
> > - For degraded mount
> > - As basis for later full journal implement.
> >
> > For your concern, it's in fact not related to write-intent, but in scrub
> > code.
> >
> > In that part, I have some plan to rework the scrub interface completely,
> > and with the rework, it will have the ability to detect content
> > difference between mirrors, even without csum.
> >
> > But that would take a longer time, and the main purpose is to improve
> > the RAID56 scrub perf, not really the problem you mentioned.
> >
> > Thanks,
> > Qu
> >
> >>
> >> On Mon, Jul 25, 2022 at 2:38 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>
> >>> [CHANGELOG]
> >>> v2->v1:
> >>> - Add mount time recovery functionality
> >>>    Now if a dirty bitmap is found, we will do proper recovery at mount
> >>>    time.
> >>>
> >>>    The code is using scrub routine to do the proper recovery for both
> >>>    data and P/Q parity.
> >>>
> >>>    Currently we can only test this by manually setting up a dirty bitmap,
> >>>    and corrupt the full stripe, then mounting it and verify the full
> >>>    stripe using "btrfs check --check-data-csum"
> >>>
> >>> - Skip full stripe writes
> >>>    Full stripe writes are either:
> >>>    * New writes into unallocated space
> >>>      After powerloss, we won't read any data from the full stripe.
> >>>
> >>>    * Writes into NODATACOW ranges
> >>>      We won't have csum for them anyway, thus new way to do any recovery.
> >>>
> >>> - Fix a memory leakage caused by RO mount
> >>>    Previously we only cleanup the write-intent ctrl if it's RW mount,
> >>>    thus for RO mount we will cause memory leak.
> >>>
> >>>
> >>> RFC->v1:
> >>> - Fix a corner case in write_intent_set_bits()
> >>>    If the range covers the last existing entry, but still needs a new
> >>>    entry, the old code will not insert the new entry, causing
> >>>    write_intent_clear_bits() to cause a warning.
> >>>
> >>> - Add selftests for the write intent bitmaps
> >>>    The write intent bitmaps is an sparse array of bitmaps.
> >>>    There are some corner cases tricky to get it done correctly in the
> >>>    first try (see above case).
> >>>    The test case would prevent such problems from happening again.
> >>>
> >>> - Fix hang with dev-replace, and better bitmaps bio submission
> >>>    Previously we will hold device_list_mutex while submitting the bitmaps
> >>>    bio, this can lead to deadlock with dev-replace/dev-removal.
> >>>    Fix it by using RCU to keep an local copy of devices and use them
> >>>    to submit the bitmaps bio.
> >>>
> >>>    Furthermore, there is no need to follow the way of superblocks
> >>>    writeback, as the content of bitmaps are always the same for all
> >>>    devices, we can just submitting the same page and use atomic counter
> >>>    to wait for them to finish.
> >>>
> >>>    Now there is no more crash/warning/deadlock in btrfs/070.
> >>>
> >>> [BACKGROUND]
> >>> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
> >>> loss happens.
> >>>
> >>> For pure mirror based profiles it's fine as btrfs can utilize its csums
> >>> to find the correct mirror the repair the bad ones.
> >>>
> >>> But for RAID56, the repair itself needs the data from other devices,
> >>> thus any out-of-sync data can degrade the tolerance.
> >>>
> >>> Even worse, incorrect RMW can use the stale data to generate P/Q,
> >>> removing the possibility of recovery the data.
> >>>
> >>>
> >>> For md-raid, it goes with write-intent bitmap, to do faster resilver,
> >>> and goes journal (partial parity log for RAID5) to ensure it can even
> >>> stand a powerloss + device lose.
> >>>
> >>> [OBJECTIVE]
> >>>
> >>> This patchset will introduce a btrfs specific write-intent bitmap.
> >>>
> >>> The bitmap will locate at physical offset 1MiB of each device, and the
> >>> content is the same between all devices.
> >>>
> >>> When there is a RAID56 write (currently all RAID56 write, including full
> >>> stripe write), before submitting all the real bios to disks,
> >>> write-intent bitmap will be updated and flushed to all writeable
> >>> devices.
> >>>
> >>> So even if a powerloss happened, at the next mount time we know which
> >>> full stripes needs to check, and can start a scrub for those involved
> >>> logical bytenr ranges.
> >>>
> >>> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
> >>>
> >>> Since btrfs can utilize csum for its metadata and CoWed data, unlike
> >>> dm-bitmap which can only be used for faster re-silver, we can fully
> >>> rebuild the full stripe, as long as:
> >>>
> >>> 1) There is no missing device
> >>>     For missing device case, we still need to go full journal.
> >>>
> >>> 2) Untouched data stays untouched
> >>>     This should be mostly sane for sane hardware.
> >>>
> >>> And since the btrfs specific write-intent bitmaps are pretty small (4KiB
> >>> in size), the overhead much lower than full journal.
> >>>
> >>> In the future, we may allow users to choose between just bitmaps or full
> >>> journal to meet their requirement.
> >>>
> >>> [BITMAPS DESIGN]
> >>>
> >>> The bitmaps on-disk format looks like this:
> >>>
> >>>   [ super ][ entry 1 ][ entry 2 ] ... [entry N]
> >>>   |<---------  super::size (4K) ------------->|
> >>>
> >>> Super block contains how many entires are in use.
> >>>
> >>> Each entry is 128 bits (16 bytes) in size, containing one u64 for
> >>> bytenr, and u64 for one bitmap.
> >>>
> >>> And all utilized entries will be sorted in their bytenr order, and no
> >>> bit can overlap.
> >>>
> >>> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
> >>> can contain at most 4MiB, and the whole bitmaps can contain 224 entries.
> >>>
> >>> For the worst case, it can contain 14MiB dirty ranges.
> >>> (1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).
> >>>
> >>> For the best case, it can contain 896MiB dirty ranges.
> >>> (all bits set per bitmap)
> >>>
> >>> [WHY NOT BTRFS BTREE]
> >>>
> >>> Current write-intent structure needs two features:
> >>>
> >>> - Its data needs to survive cross stripe boundary
> >>>    Normally this means write-intent btree needs to acts like a proper
> >>>    tree root, has METADATA_ITEMs for all its tree blocks.
> >>>
> >>> - Its data update must be outside of a transaction
> >>>    Currently only log tree can do such thing.
> >>>    But unfortunately log tree can not survive across transaction
> >>>    boundary.
> >>>
> >>> Thus write-intent btree can only meet one of the requirement, not a
> >>> suitable solution here.
> >>>
> >>> [TESTING AND BENCHMARK]
> >>>
> >>> For performance benchmark, unfortunately I don't have 3 HDDs to test.
> >>> Will do the benchmark after secured enough hardware.
> >>>
> >>> For testing, it can survive volume/raid/dev-replace test groups, and no
> >>> write-intent bitmap leakage.
> >>>
> >>> Unfortunately there is still a warning triggered in btrfs/070, still
> >>> under investigation, hopefully to be a false alert in bitmap clearing
> >>> path.
> >>>
> >>> [TODO]
> >>> - Extra optimizations
> >>>    * Enlarge the window between btrfs_write_intent_mark_dirty() and
> >>>      btrfs_write_intent_writeback()
> >>>      So that we can merge more dirty bites and cause less bitmaps
> >>>      writeback
> >>>
> >>> - Proper performance benchmark
> >>>    Needs hardware/baremetal VMs, since I don't have any physical machine
> >>>    large enough to contian 3 3.5" HDDs.
> >>>
> >>>
> >>> Qu Wenruo (14):
> >>>    btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
> >>>    btrfs: introduce a new experimental compat RO flag,
> >>>      WRITE_INTENT_BITMAP
> >>>    btrfs: introduce the on-disk format of btrfs write intent bitmaps
> >>>    btrfs: load/create write-intent bitmaps at mount time
> >>>    btrfs: write-intent: write the newly created bitmaps to all disks
> >>>    btrfs: write-intent: introduce an internal helper to set bits for a
> >>>      range.
> >>>    btrfs: write-intent: introduce an internal helper to clear bits for a
> >>>      range.
> >>>    btrfs: selftests: add selftests for write-intent bitmaps
> >>>    btrfs: write back write intent bitmap after barrier_all_devices()
> >>>    btrfs: update and writeback the write-intent bitmap for RAID56 write.
> >>>    btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
> >>>    btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
> >>>    btrfs: avoid recording full stripe write into write-intent bitmaps
> >>>    btrfs: scrub the full stripe which had sub-stripe write at mount time
> >>>
> >>>   fs/btrfs/Makefile                           |   5 +-
> >>>   fs/btrfs/ctree.h                            |  26 +-
> >>>   fs/btrfs/disk-io.c                          |  58 +-
> >>>   fs/btrfs/raid56.c                           |  27 +
> >>>   fs/btrfs/scrub.c                            | 177 +++-
> >>>   fs/btrfs/sysfs.c                            |   2 +
> >>>   fs/btrfs/tests/btrfs-tests.c                |   4 +
> >>>   fs/btrfs/tests/btrfs-tests.h                |   2 +
> >>>   fs/btrfs/tests/write-intent-bitmaps-tests.c | 247 ++++++
> >>>   fs/btrfs/volumes.c                          |  34 +-
> >>>   fs/btrfs/write-intent.c                     | 923 ++++++++++++++++++++
> >>>   fs/btrfs/write-intent.h                     | 303 +++++++
> >>>   fs/btrfs/zoned.c                            |   8 +
> >>>   include/uapi/linux/btrfs.h                  |  17 +
> >>>   14 files changed, 1812 insertions(+), 21 deletions(-)
> >>>   create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c
> >>>   create mode 100644 fs/btrfs/write-intent.c
> >>>   create mode 100644 fs/btrfs/write-intent.h
> >>>
> >>> --
> >>> 2.37.0
> >>>
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
