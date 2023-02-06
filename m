Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468868B42B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 03:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBFCee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 21:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 21:34:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBD516AD9
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 18:34:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bk15so30302048ejb.9
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Feb 2023 18:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=56UF/bUF+DfvqtwsQ5vDT20I4jlWGkIfQwA2ZOY6NTU=;
        b=hI1WRo3Ete7aM3GIw3WkWbbQwr7l5vdxVsgR8ZXWHqg/TuVKfurWBF7hVkIH/NLqnQ
         fMhY/GSGVYl3xyCiGw+YwiGTMIJB7zGfHcejsQDiaLoBhhm/muCAegxc+06ZlFWbj2WR
         5A4IABQp542qDPykcQPnfPZO3o7xKNHVC9J3tK2riKbnhvar5DxR/uK6PjwEavfPTOWn
         yt4FyGTNipiH0hFnnilpWW4lsGid31i0jZ9YDBrCI9gYUoe2ua2gwskPPWMJdIZvLPE8
         M6aFI2/Fb7PsefueE9iheA3Vya8IcB/VHTk7tlY6XFr6vTIHl0sEDs9VvS22kejozLjN
         Pwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56UF/bUF+DfvqtwsQ5vDT20I4jlWGkIfQwA2ZOY6NTU=;
        b=nF4KfnM67IHphfI74j7Fy4hCatgTxZVjDqrY2deBUqcxgEzHFDjXSoeRImBC38VMS3
         sNcZx+qPi2NHCMatICFke0MuL4jBmgtKCxjkqNDnkltHpeTtp7R4HKKMob3rpYws84ga
         Yt8lvEb49/DSazsKKSqe1yHD2Y3mQigI37hbu9yaKKlsUK0pdK2urx0U9cES27CMYtss
         4TC45+LlKTyamj+5Wk73oRqtcg1Yyu5aLc74u6208x3XX4tjJZ/n7PKnQrtvDEsOh4ho
         YhEt40raiyUO3pgjHK6WbKcc90yrDy8PFzImufVf0UHWlaFOgXJTQj0wAM9xOp/vdDbd
         jQDg==
X-Gm-Message-State: AO0yUKWOvqskoeTdnC+heRxAjjnaYk0TP+WitJxmCSGK6yzUq7wNqNkH
        TS5tmxSRMuD7J96v/6zWW1y4VeGZLSaf0gtU+11oWA==
X-Google-Smtp-Source: AK7set/epEVsDy9JeF4iBhwYYsSHrFTMvHqc4eN6N0UuoJoNgqXu08YgvRWQIAOqA+WgEEeha8xqoT+aQ4z0RRWkuBs=
X-Received: by 2002:a17:906:6851:b0:88a:2a05:5b47 with SMTP id
 a17-20020a170906685100b0088a2a055b47mr4314198ejs.294.1675650870663; Sun, 05
 Feb 2023 18:34:30 -0800 (PST)
MIME-Version: 1.0
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de> <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
In-Reply-To: <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
From:   "me@jse.io" <me@jse.io>
Date:   Sun, 5 Feb 2023 22:34:30 -0400
Message-ID: <CAFMvigd+j-ARVRepKKrW4KtjfAHGu9gW0YFb6BCegGj5Lj07ew@mail.gmail.com>
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

Apologies for the duplicate, I sent the last reply in HTML by mistake.
Take two lol.

Given that 6.2 basically has fixes for the RMW at least for RAID5, apart
from scrub performance deficiencies and the write hole, are there any other
gotchas to be aware of? This mailing list post <
https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/>
listed several concerning bugs, like "spurious degraded read failure" which
is a concerning bug for me as I'm hoping to use Btrfs RAID5 for a media
server pool and it would be nice to have it be usable when degraded
without. It would be nice to be able to read my data when degraded. How
many of these bugs listed here have since been fixed or addressed by the
RMW fixes in 6.2?

Also concerning NOCOW (nocsum data), assuming no device failure, if a write
to a NOCOW range gets out of sync with parity (ie, due to a crash/write
hole) will scrub trust NOCOW data indiscriminately and update the parity,
or does it get ignored like how NOCOW is basically ignored in RAID1?


On Sun, Oct 9, 2022 at 8:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/10/9 18:34, Ochi wrote:
> > Hello,
> >
> > I'm currently thinking about migrating my home NAS to SSDs only. As a
> > compromise between space efficiency and redundancy, I'm thinking about:
> >
> > - using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or
> > 4 for now, with the option to expand later),
>
> Btrfs RAID56 is not safe against the following problems:
>
> - Multi-device data sync (aka, write hole)
>    Every time a power loss happens, some RAID56 writes may get de-
>    synchronized.
>
>    Unlike mdraid, we don't have journal/bitmap at all for now.
>    We already have a PoC write-intent bitmap.
>
> - Destructive RMW
>    This can happen when some of the existing data is corrupted (can be
>    caused by above write-hole, or bitrot.
>
>    In that case, if we have write into the vertical stripe, we will
>    make the original corruption further spread into the P/Q stripes,
>    completely killing the possibility to recover the data.
>
>    This is for all RAID56, including mdraid56, but we're already working
>    on this, to do full verification before a RMW cycle.
>
> - Extra IO for RAID56 scrub.
>    It will cause at least twice amount of data read for RAID5, three
>    times for RAID6, thus it can be very slow scrubbing the fs.
>
>    We're aware of this problem, and have one purposal to address it.
>
>    You may see some advice to only scrub one device one time to speed
>    things up. But the truth is, it's causing more IO, and it will
>    not ensure your data is correct if you just scrub one device.
>
>    Thus if you're going to use btrfs RAID56, you have not only to do
>    periodical scrub, but also need to endure the slow scrub performance
>    for now.
>
>
> > - using compression to get the most out of the relatively expensive SSD
> > storage,
> > - encrypting each drive seperately below the FS level using LUKS (with
> > discard enabled).
> >
> > The NAS is regularly backed up to another NAS with spinning disks that
> > runs a btrfs RAID1 and takes daily snapshots.
> >
> > I have a few questions regarding this approach which I hope someone with
> > more insight into btrfs can answer me:
> >
> > 1. Are there any known issues regarding discard/TRIM in a RAID5 setup?
>
> Btrfs doesn't support TRIM inside RAID56 block groups at all.
>
> Trim will only work for the unallocated space of each disk, and the
> unused space inside the METADATA RAID1 block groups.
>
> > Is discard implemented on a lower level that is independent of the
> > actual RAID level used? The very, very old initial merge announcement
> > [1] stated that discard support was missing back then. Is it implemented
> > now?
> >
> > 2. How is the parity data calculated when compression is in use? Is it
> > calculated on the data _after_ compression? In particular, is the parity
> > data expected to have the same size as the _compressed_ data?
>
> To your question, P/Q is calculated after compression.
>
> Btrfs and mdraid56, they work at block layer, thus they don't care the
> data size of your write.(although full-stripe aligned write is way
> better for performance)
>
> All writes (only considering the real writes which will go to physical
> disks, thus the compressed data) will first be split using full stripe
> size, then go either full-stripe write path or sub-stripe write.
>
> >
> > 3. Are there any other known issues that come to mind regarding this
> > particular setup, or do you have any other advice?
>
> We recently fixed a bug that read time repair for compressed data is not
> really as robust as we think.
> E.g. the corruption in compressed data is interleaved (like sector 1 is
> corrupted in mirror 1, sector 2 is corrupted in mirror 2).
>
> In that case, we will consider the full compressed data as corrupted,
> but in fact we should be able to repair it.
>
> You may want to use newer kernel with that fixed if you're going to use
> compression.
>
> >
> > [1] https://lwn.net/Articles/536038/
> >
> > Best regards
> > Ochi
