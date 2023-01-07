Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184A660CA1
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 07:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjAGF6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Jan 2023 00:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAGF6j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Jan 2023 00:58:39 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9F44368
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 21:58:37 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c186ff0506so49028997b3.6
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jan 2023 21:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leblancnet-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Suvvmh6ptb28CeRI8JqdVYSJVzZ7T1g+XXNCXC/o0Ss=;
        b=RqtIxljpX13mduSPcWlwg0P2w10kne0c1R+dNB6C6H+vGQNGok4BOUrad2QZizP55N
         3zGu9LCqMHVhzpFrQOstkKWMxUSIAVz6UAAo+fHArF6mDjItmsa3Ofwu5+j46pS21t0T
         4NKmavzzf4cp1bo0lkHlNMPYqAUj5H2G9uI+tOa3+Y6xry739nv8xCJg2rdigTJLHofJ
         N6ostJdimMh9GYVKPFf9RkGkkRaKoDAdlovOyZACnWg1Z5xf/6i3AjFKett1WEhOnOki
         PAdP3ft0pnxvgrWmk/ImGdW71lqy/0rMRng54HjajV4W0udtkEIukSbHmJ4QEJvHLFbU
         2eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Suvvmh6ptb28CeRI8JqdVYSJVzZ7T1g+XXNCXC/o0Ss=;
        b=fGRUXXuE7xXTn0LAm5OR841pVRpoV3cVXKPFbaVus0NuC7L6lzXLQ6SjIRXPHz2S2I
         kvtYwYbOCXZsUVWFMPMPN94hqOPqoamex5yKB34d55x59Kb26QZhMkEyDeyYa6lB9S7D
         QKDO06gzM1K7tdzXN+opeW+eVnDuoD2ta/nG19/Hlmo21+1encUib+x7QcjP7TXj/ZXc
         xnv04AyGt4sRS+qJtVUBiS5S6uRw+v3FDw3CbMFnFUpAb3fsVWG7cFN+/oPB/GH1O621
         tfYusPqRVdXwYL2lj1gK+gDgqZXzxJaIt3X2E3t3cyyT0+ld1qMfRRS94djCNOD5HLqX
         C8mQ==
X-Gm-Message-State: AFqh2kqr2MipASmQvUUzJ5de8Sc+k89ok7xXIqhdjkJkuARyVPpJSB1Q
        XTkvjXirLxUNKazzjJ0iYJsiKZrAu/UrB21nhzWp9Q==
X-Google-Smtp-Source: AMrXdXsL6Px0o8UlsZ+ONKHKLvaxi65l7dfNOkU3RPTYGynfpvcZvfTL8YkBWR57u3b/ltWXp/7oMSXbRKO25gOnUqM=
X-Received: by 2002:a81:1716:0:b0:3ea:454d:d1ef with SMTP id
 22-20020a811716000000b003ea454dd1efmr6976920ywx.409.1673071116984; Fri, 06
 Jan 2023 21:58:36 -0800 (PST)
MIME-Version: 1.0
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com> <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it> <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
 <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com>
 <3a220ba2-67a6-c3b8-6b07-cf70c1c80fc2@gmx.com> <CAANLjFr9OPyvoGfg7dfU314=ba01Ar=GuiXZmef+skCXEC+OzQ@mail.gmail.com>
In-Reply-To: <CAANLjFr9OPyvoGfg7dfU314=ba01Ar=GuiXZmef+skCXEC+OzQ@mail.gmail.com>
From:   Robert LeBlanc <robert@leblancnet.us>
Date:   Fri, 6 Jan 2023 22:58:25 -0700
Message-ID: <CAANLjFoSoYa3ZXHsG7fML0_RXh4t8yQQ3qVzpBMJqpeM3hKSgg@mail.gmail.com>
Subject: Re: File system can't mount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 6, 2023 at 5:45 PM Robert LeBlanc <robert@leblancnet.us> wrote:
>
> On Fri, Jan 6, 2023 at 12:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > Your assumptions are spot on. One of the two memory dims is either bit
> > > flipping or stuck on 0/1. After running memtest86+, I can verify that
> > > some memory addresses create spoiled data. I'm currently running off
> > > the good DIMM as I get some new RAM ordered and recovering from
> > > backups (apparently my backups stopped in September of last year) and
> > > then trying to pull off the newer data that I need from the bad file
> > > systems.
> >
> > Well, I'd say that filesystem should still be over 99% fine.
> > Even the memory hardware is faulty, it shouldn't cause huge damages for
> > the filesystem.
> >
> > > It's really odd that I never saw csum errors in dmesg and it
> > > only appears that metadata got corrupted.
> >
> > That's because if the corruption happens for data, you won't be able to
> > see any csum mismatch.
> >
> > Because the corruption happens in memory, we calculate the csum using
> > the bad data, thus no csum mismatch would happen.
>
> I would have thought that the csum was being calculated as the data
> was being written to memory and before being stored in memory, but
> thinking about it more, I'm not sure the VFS will let you do that, so
> you can only inspect the data after it's already been written to
> memory and corrupted.
>
> > You can only be sure by comparing with the backup.
> >
> > > It looks like some of my
> > > more critical subvolumes I could either do a `btrfs send/receive` or
> > > do an `rsync` of them from my NVMe btrfs. I hope the HDD will have
> > > similar luck and since there weren't a lot of writes to my large
> > > volume, I'm hoping that it escaped corruption.
> >
> > In fact, that bitflip seems to be the only corruption (that matters).
> > Thus you can go "btrfs check --repair", and still use the fs
> > (if after repair, the fs can pass btrfs check).
> >
> > >
> > > Thinking out loud here, with BTRFS being so good at detecting bit rot
> > > on disk, could that be expanded to in-memory data structures kind of
> > > like RAID with checksums?
> >
> > In fact, if you're using newer kernel from day 1, then such corruption
> > can be prevented directly.
> >
> > Newer kernel (v5.15+?) would reject any write that has obviously bad
> > metadata.
>
> I was on v5.18 for a while (months, maybe since the backups stopped).
> The backups before didn't complain of empty streams or anything so it
> probably happened between then and running v5.18. I created the new
> NVMe btrfs filesystem on 6.0, but the HDD filesystem won't mount on
> 6.0. So, I've got to decide to go with the demon that I know (boot
> into v5.18 and try to get things off), or the demon I don't (repair
> the fs in v6.0 and hope it gets better to mount).

Well, it refuses to repair the file system.

~/code/btrfs-progs$ sudo ./btrfs check --repair /dev/mapper/1EV13X7B
enabling repair mode
WARNING:

       Do not use --repair unless you are advised to do so by a developer
       or an experienced user, and then only after having accepted that no
       fsck can successfully repair all types of filesystem corruption. Eg.
       some software or hardware bugs can fatally damage a volume.
       The operation will start in 10 seconds.
       Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/1EV13X7B
UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
WARNING: tree block [12462950961152, 12462950977536) is not nodesize
aligned, may cause problem for 64K page system
ERROR: add_tree_backref failed (extent items tree block): File exists
ERROR: add_tree_backref failed (non-leaf block): File exists
well this shouldn't happen, extent record overlaps but is metadata?
[12462950973440, 16384]
Aborted

~/code/btrfs-progs$ ./btrfs --version
btrfs-progs v6.1.2

> I enjoy exercises like this to learn more, but they always seem to
> come at inconvenient times.
>
> >
> > Thus in your case, it would result a RO mount, but no such corruption.
> > (But of course, if the memory bitflip happens for data, there is no way
> > to catch it)
> >
> > Thanks,
> > Qu
>
> Thank you,
> Robert LeBlanc

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
