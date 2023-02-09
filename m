Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2A69143B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 00:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjBIXMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 18:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBIXMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 18:12:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E2627AF
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 15:12:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id c26so6460405ejz.10
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Feb 2023 15:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7GZXYg517nLydu0TWXli33T44WhksZPRnE/G5IgYQQ4=;
        b=662dVnD3AUnduVRTaaza59I9OtmHWLv6wIvpeaVEOsRZOFibkr8BGsBirnFtj/1hly
         bRA1oNFTDgemp3qP/e9zmdIqEVHDxwBoIG8a7tvPUO2kxgmmZ1DZOwgG7qf8tufxyDlB
         sCZB4gx8I3vr/Cku40hLSuVyyHyUUalKVQsSFXtiBGdfABMvy7YfKmWJubIuGg5Ovjlh
         99qA8sDh0E6KzlKjk6H2YaV/oOp+UlJrOLuPkWaLQz/pM/ctB4XOzt5SOxg+8AZmx7Q/
         KWH/EQFdHAB8NGEJUZSFz0czgaUcqPjqYiDjb2Vhu5Al+MczRiqBbPVgwYu15d6fuGON
         Aa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GZXYg517nLydu0TWXli33T44WhksZPRnE/G5IgYQQ4=;
        b=q2uqLvrJEL1CQqbMYOz0gMiUo7hRAyvs5kBrVaT+m/0A2LSMNoHDzBg64+9q23aCfn
         tk8t7gqdWtqCrW1hAjf+KxaV849k4R93TRTQazL4YndEDhBnxA2YKrUH89vvPPOw7A3f
         NeJlnARJW4qGD6kUILzw2cKABZfK27+liLW6ikBzPpGy51VWqWI1IeIqriRGVo85dTbo
         ma2bNR/XyuvLItonK2f61d52MMNSp+DFiRAoiBqMGYXDn8p6xtbm419mwq4X9h+inYS+
         nCuT9sRbFI/iVO2vmlgCFlCrUlswptS7YKzeEuUk26F3WQ0HCfxfbaFoOVDEU+tUvAcb
         bfJA==
X-Gm-Message-State: AO0yUKUtUfJtqxK2YJLnaBzw4qfn13GXfHUvssdvof0GkeZnIG+OUfut
        3/uwpbUutYREqDDdmwl1Pg6Yrdn6Dr7Yk/db/Zzbdw==
X-Google-Smtp-Source: AK7set+JgKkL/q3vPNbrWmziFeyuijmJ/7nW8fwX6vCbsQvbe1QzI1HRg5HNzaN/YcXEM2M+ZPTHZOmsd8Drks+HQJw=
X-Received: by 2002:a17:906:edce:b0:8ad:d3c:b65a with SMTP id
 sb14-20020a170906edce00b008ad0d3cb65amr848506ejb.9.1675984365267; Thu, 09 Feb
 2023 15:12:45 -0800 (PST)
MIME-Version: 1.0
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
 <86f8b839-da7f-aa19-d824-06926db13675@gmx.com> <CAFMvigd+j-ARVRepKKrW4KtjfAHGu9gW0YFb6BCegGj5Lj07ew@mail.gmail.com>
 <7074289e-13cd-ced8-a4d8-0d0b23ba177d@gmx.com>
In-Reply-To: <7074289e-13cd-ced8-a4d8-0d0b23ba177d@gmx.com>
From:   "me@jse.io" <me@jse.io>
Date:   Thu, 9 Feb 2023 19:12:45 -0400
Message-ID: <CAFMvige6+2z3PHHqns3HD-_zAO+OePSM943_QeS+jxaWXiwi8g@mail.gmail.com>
Subject: Re: RAID5 on SSDs - looking for advice
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Ochi <ochi@arcor.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

You know, NOCOW is plagued with issues like this. Imo, it really seems
half baked, particularly around Btrfs RAID. Not only this, but the
fact it has a "write hole" like issue on other RAID profiles since
writes are not atomic, there is no bitmap to track dirty blocks until
all redundant copies are written, and no way for scrub to resync
correctly in cases where we could. Would it be possible to have a
mount option like nodatacow, but does the opposite: it would ignore
the nocow attribute and perform COW+csuming regardless?

Perhaps extend datacow to work like this: datacow=on (the default) and
datacow=always to prevent NOCOW, sort of like discard and
discard=async? It seems asinine to me that something as critical to
data integrity which Btrfs is supposed to help protect can be bypassed
in unprivileged userspace all with a simple attribute, even against
the admins intention. It's especially infuriating since so many
programs do it lately without (ie systemd-tmpfiles, or libvirt), if
you use containers and btrfs subvolumes, then you gotta configure
every container specifically just to prevent this.

On Sun, Feb 5, 2023 at 11:05 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2023/2/6 10:34, me@jse.io wrote:
> > Apologies for the duplicate, I sent the last reply in HTML by mistake.
> > Take two lol.
> >
> > Given that 6.2 basically has fixes for the RMW at least for RAID5, apart
> > from scrub performance deficiencies and the write hole, are there any other
> > gotchas to be aware of?
>
> Firstly, 6.2 would only handle the RMW better for data.
> There is no way to properly handle metadata easily, thus it's still not
> recommended to use RAID56 for metadata.
>
> But still, things like parity-update-failure, read-repair-failure should
> be fixed with the RMW fixes.
>
> Secondly the write hole is not yet fixed, the RMW fix would greately
> migrate the problem, but not a full fix.
>
> Other ones look like regular scrub interface bugs.
>
> > This mailing list post <
> > https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/>
> > listed several concerning bugs, like "spurious degraded read failure" which
> > is a concerning bug for me as I'm hoping to use Btrfs RAID5 for a media
> > server pool and it would be nice to have it be usable when degraded
> > without. It would be nice to be able to read my data when degraded. How
> > many of these bugs listed here have since been fixed or addressed by the
> > RMW fixes in 6.2?
> >
> > Also concerning NOCOW (nocsum data), assuming no device failure, if a write
> > to a NOCOW range gets out of sync with parity (ie, due to a crash/write
> > hole) will scrub trust NOCOW data indiscriminately and update the parity,
> > or does it get ignored like how NOCOW is basically ignored in RAID1?
>
> NOCOW/NOCSUM is not recommended, as even with or without the RMW fix, we
> trust anything we read from disk if there is no csum to verify against.
>
> Our trust priority is:
>
> Data with csum (no matter pass or not, as we would recheck after repair)
>  > Data without csum (read pass, then trust it) > Parity
>
> Thus data without csum can only be repaired if the read itself failed.
> And if such data without csum has mismatch with parity, we always update
> parity unconditionally.
>
> Thanks,
> Qu
>
> >
> >
> > On Sun, Oct 9, 2022 at 8:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/10/9 18:34, Ochi wrote:
> >>> Hello,
> >>>
> >>> I'm currently thinking about migrating my home NAS to SSDs only. As a
> >>> compromise between space efficiency and redundancy, I'm thinking about:
> >>>
> >>> - using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or
> >>> 4 for now, with the option to expand later),
> >>
> >> Btrfs RAID56 is not safe against the following problems:
> >>
> >> - Multi-device data sync (aka, write hole)
> >>     Every time a power loss happens, some RAID56 writes may get de-
> >>     synchronized.
> >>
> >>     Unlike mdraid, we don't have journal/bitmap at all for now.
> >>     We already have a PoC write-intent bitmap.
> >>
> >> - Destructive RMW
> >>     This can happen when some of the existing data is corrupted (can be
> >>     caused by above write-hole, or bitrot.
> >>
> >>     In that case, if we have write into the vertical stripe, we will
> >>     make the original corruption further spread into the P/Q stripes,
> >>     completely killing the possibility to recover the data.
> >>
> >>     This is for all RAID56, including mdraid56, but we're already working
> >>     on this, to do full verification before a RMW cycle.
> >>
> >> - Extra IO for RAID56 scrub.
> >>     It will cause at least twice amount of data read for RAID5, three
> >>     times for RAID6, thus it can be very slow scrubbing the fs.
> >>
> >>     We're aware of this problem, and have one purposal to address it.
> >>
> >>     You may see some advice to only scrub one device one time to speed
> >>     things up. But the truth is, it's causing more IO, and it will
> >>     not ensure your data is correct if you just scrub one device.
> >>
> >>     Thus if you're going to use btrfs RAID56, you have not only to do
> >>     periodical scrub, but also need to endure the slow scrub performance
> >>     for now.
> >>
> >>
> >>> - using compression to get the most out of the relatively expensive SSD
> >>> storage,
> >>> - encrypting each drive seperately below the FS level using LUKS (with
> >>> discard enabled).
> >>>
> >>> The NAS is regularly backed up to another NAS with spinning disks that
> >>> runs a btrfs RAID1 and takes daily snapshots.
> >>>
> >>> I have a few questions regarding this approach which I hope someone with
> >>> more insight into btrfs can answer me:
> >>>
> >>> 1. Are there any known issues regarding discard/TRIM in a RAID5 setup?
> >>
> >> Btrfs doesn't support TRIM inside RAID56 block groups at all.
> >>
> >> Trim will only work for the unallocated space of each disk, and the
> >> unused space inside the METADATA RAID1 block groups.
> >>
> >>> Is discard implemented on a lower level that is independent of the
> >>> actual RAID level used? The very, very old initial merge announcement
> >>> [1] stated that discard support was missing back then. Is it implemented
> >>> now?
> >>>
> >>> 2. How is the parity data calculated when compression is in use? Is it
> >>> calculated on the data _after_ compression? In particular, is the parity
> >>> data expected to have the same size as the _compressed_ data?
> >>
> >> To your question, P/Q is calculated after compression.
> >>
> >> Btrfs and mdraid56, they work at block layer, thus they don't care the
> >> data size of your write.(although full-stripe aligned write is way
> >> better for performance)
> >>
> >> All writes (only considering the real writes which will go to physical
> >> disks, thus the compressed data) will first be split using full stripe
> >> size, then go either full-stripe write path or sub-stripe write.
> >>
> >>>
> >>> 3. Are there any other known issues that come to mind regarding this
> >>> particular setup, or do you have any other advice?
> >>
> >> We recently fixed a bug that read time repair for compressed data is not
> >> really as robust as we think.
> >> E.g. the corruption in compressed data is interleaved (like sector 1 is
> >> corrupted in mirror 1, sector 2 is corrupted in mirror 2).
> >>
> >> In that case, we will consider the full compressed data as corrupted,
> >> but in fact we should be able to repair it.
> >>
> >> You may want to use newer kernel with that fixed if you're going to use
> >> compression.
> >>
> >>>
> >>> [1] https://lwn.net/Articles/536038/
> >>>
> >>> Best regards
> >>> Ochi
