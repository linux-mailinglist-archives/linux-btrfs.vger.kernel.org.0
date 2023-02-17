Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32D69AA91
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 12:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBQLjC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 06:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBQLjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 06:39:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4CA6569C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 03:39:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EFD61AB3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 11:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63138C4339B
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676633939;
        bh=TW5FQBnM3qSro7K3KnYEQyY7yJmrU2ojEuPut3Igusg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XP7y/IP9xD9zJm13XLZfLX9huSyshNSdthzskbBxkTwRksSNhRyYazXUq9HDSj1ic
         7moxUvriINwI0MVjjWMvssyBa4G5jH+UG+JLKlO0uiQKPjByeH5l64+gAMI0BcdgHr
         GX3NfDptAyFx/LHoe88OQsyMJx0lFgZjW5xggqv5Rkcp94JaT93SvCw76Bp26nSwNw
         fda5e1sgAto9SH/Dk9+rZ/sBy5rCYSCTMVffbQA0tJ/vQycyYv6nKRNyUOIn6c4tXp
         LFALGjda51L52nzf6JpvdzJ2KFav4ywBAw8AppPmFMEuxKpyuk2mwsJ1TU3fgIu9Nk
         aYtAvIhIIGRWg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17068acb0c2so1128345fac.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 03:38:59 -0800 (PST)
X-Gm-Message-State: AO0yUKU0k3EGTxJeR00MrxLpoSHHI57Dgu8YaHn/3AtaSuexXos7BVjT
        yrMAeYWwT/g53ZxIWvehYeH4BDPXt+ywNG8Tf0U=
X-Google-Smtp-Source: AK7set+q+yWcnja6/Gf/jpmS0Nhi2nDJPlsrsZ5gRrGILFWA30R1hbw0mDupKwhRhMlMX19Hb8xxN/6ZHSb/3cMrAD0=
X-Received: by 2002:a05:6870:d248:b0:16e:11dc:2513 with SMTP id
 h8-20020a056870d24800b0016e11dc2513mr481673oac.98.1676633938465; Fri, 17 Feb
 2023 03:38:58 -0800 (PST)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com> <Y+1pAoetotjEuef7@zen>
 <dabed1bf-da8b-6ef4-77c4-e2c28cf9106f@gmx.com> <CAL3q7H4nHvNtH84ZwkZm0kGSALNfFZNYc7=WuQ=FBcrGuYd7Dg@mail.gmail.com>
 <9cdc5adf-3479-c79e-2549-d4743affd26c@gmx.com>
In-Reply-To: <9cdc5adf-3479-c79e-2549-d4743affd26c@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Feb 2023 11:38:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ykMQBt8P04VV6oBZfQS3H0jwPkmtcu7a9iGvL9bOxEA@mail.gmail.com>
Message-ID: <CAL3q7H7ykMQBt8P04VV6oBZfQS3H0jwPkmtcu7a9iGvL9bOxEA@mail.gmail.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 17, 2023 at 12:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2023/2/16 20:01, Filipe Manana wrote:
> > On Thu, Feb 16, 2023 at 10:23 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2023/2/16 07:21, Boris Burkov wrote:
> >>> On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
> >>>>
> >>>>
> >>>> On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> >>>>> Downstream bug report, reproducer test file, and gdb session transcript
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> >>>>>
> >>>>> I speculated that maybe it's similar to the issue we have with VM's
> >>>>> when O_DIRECT is used, but it seems that's not the case here.
> >>>>
> >>>> I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
> >>>>
> >>>> kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
> >>>>
> >>>
> >>> I was also able to reproduce on the current misc-next. However, when I
> >>> hacked the kernel to always fall back from DIO to buffered IO, it no
> >>> longer reproduced. So that's one hint..
> >>>
> >>> The next observation comes from comparing the happy vs unhappy file
> >>> extents on disk:
> >>> happy: https://pastebin.com/k4EPFKhc
> >>> unhappy: https://pastebin.com/hNSBR0yv
> >>>
> >>> The broken DIO case is missing file extents between bytes 8192 and 65536
> >>> which corresponds to the observed zeros.
> >>>
> >>> Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
> >>> instrumented that codepath. I observed a single successful write to 8192
> >>> bytes, then a second write which first does a partial write from 8192 to
> >>> 65536 and then faults in the rest of the iov_iter and finishes the
> >>> write.
> >>
> >> A little off-topic, as I'm not familiar with Direct IO at all.
> >>
> >> That fault (I guess means page fault?) means the Direct IO source
> >> (memory of the user space program) can not be accessible right now?
> >> (being swapped?)
> >>
> >> If that's the case, any idea why we can not wait for the page fault to
> >> fill the user space memory?
> >
> > Sure, you can call fault_in_iov_iter_readable() for the whole iov_iter
> > before starting the actual direct IO,
> > and that will work and not result in any problems most of the time.
> >
> > However:
> >
> > 1) After that and before starting the write, all pages or some pages
> > may have been evicted from memory due to memory pressure for e.g.;
> >
> > 2) If the iov_iter refers to a very large buffer, it's inefficient to
> > fault in all pages.
>
> Indeed. As even we load in all the pages, there is no guarantee unless
> the user space program pins the pages in advance.
>
> Another question is, can we fall back to buffered IO half way?
> E.g. if we hit page fault for certain range, then fall back to buffered
> IO for the remaining part?

That doesn't solve any problem in this case.
It would still result in the partial ordered extent getting marked
with an IO error and result in the hole for the partially completed
range.

>
> Thanks,
> Qu
>
> >
> >> I guess it's some deadlock but is not for sure.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> I'm now trying to figure out how these partial writes might lead us to
> >>> not create all the EXTENT_DATA items for the file extents.
> >>>
> >>> Boris
> >>>
> >>>>
> >>>> --
> >>>> Chris Murphy
