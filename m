Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE92699BB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 19:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBPSAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 13:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPSAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 13:00:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5F37737
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 10:00:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7877F61760
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 18:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D068FC433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676570445;
        bh=Yq9NY3jRv4815vjORBql7VNSXbzweJimB/Iv4qHiKt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F6KAKNLiPKqVI+IgReCkOrsr/4+z6kx2NYU0ZuLlWCwRSkRCB97+Nsg6UJ58GOUsh
         lReKL0z6odFa3hsdYXbP9ehU9p/1wMxjMt+ubcIhEonSD6Fr45bKOPkrYi8mE9ecWP
         bKWnKbIQlKfrAPGB3E3vEzaHFpCPZvgfYsIfdNYqf8vOfX88AG+QrZOyzBG7Ne45Ar
         ZBU7vM8uN26o/M87VoPAoStEIxvhqrog9TzaMDhA/lxW92fU+WHTit5cPrbcJ2RP6t
         fOd3YkxRLJRWwnaH+zS1ZOZCOY782Y3Mcqutd0YlCagjexRpuaRevRcJSGmXDBVHFB
         aGTbs9FeMajQA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-16aa71c1600so3425468fac.11
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 10:00:45 -0800 (PST)
X-Gm-Message-State: AO0yUKXFqyMJ4dsbV4FhwDlz1NybYJzE54tWB1QS+wNPWri00n8pgF57
        nJjXNv0wCq0Tn09ORgT7+gLU/nvL/jpWBd1Zciw=
X-Google-Smtp-Source: AK7set8h7bw1UOHMHueoPdm0Ie9FSKUKBvv2szfjD/v6NbdsYMyICVz0Ds1ddXNNfJWZN7IfTahe0Qv3ksDslDj6CI8=
X-Received: by 2002:a05:6870:d248:b0:16e:11dc:2513 with SMTP id
 h8-20020a056870d24800b0016e11dc2513mr263151oac.98.1676570444904; Thu, 16 Feb
 2023 10:00:44 -0800 (PST)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com> <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen> <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
 <Y+5kjpZJJxU+vz1X@zen>
In-Reply-To: <Y+5kjpZJJxU+vz1X@zen>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 16 Feb 2023 18:00:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
Message-ID: <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Murphy <chris@colorremedies.com>,
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

On Thu, Feb 16, 2023 at 5:15 PM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Feb 16, 2023 at 11:57:37AM +0000, Filipe Manana wrote:
> > On Thu, Feb 16, 2023 at 12:42 AM Boris Burkov <boris@bur.io> wrote:
> > >
> > > On Wed, Feb 15, 2023 at 03:21:38PM -0800, Boris Burkov wrote:
> > > > On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
> > > > >
> > > > >
> > > > > On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> > > > > > Downstream bug report, reproducer test file, and gdb session transcript
> > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > > > > >
> > > > > > I speculated that maybe it's similar to the issue we have with VM's
> > > > > > when O_DIRECT is used, but it seems that's not the case here.
> > > > >
> > > > > I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
> > > > >
> > > > > kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
> > > > >
> > > >
> > > > I was also able to reproduce on the current misc-next. However, when I
> > > > hacked the kernel to always fall back from DIO to buffered IO, it no
> > > > longer reproduced. So that's one hint..
> > > >
> > > > The next observation comes from comparing the happy vs unhappy file
> > > > extents on disk:
> > > > happy: https://pastebin.com/k4EPFKhc
> > > > unhappy: https://pastebin.com/hNSBR0yv
> > > >
> > > > The broken DIO case is missing file extents between bytes 8192 and 65536
> > > > which corresponds to the observed zeros.
> > > >
> > > > Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
> > > > instrumented that codepath. I observed a single successful write to 8192
> > > > bytes, then a second write which first does a partial write from 8192 to
> > > > 65536 and then faults in the rest of the iov_iter and finishes the
> > > > write.
> > > >
> > > > I'm now trying to figure out how these partial writes might lead us to
> > > > not create all the EXTENT_DATA items for the file extents.
> > >
> > > I believe the issue is indeed caused by faults reading the mapped region
> > > during direct io. Roughly what is happening is:
> > >
> > > - we start the dio write (offset 8192 len 1826816)
> > > - __iomap_dio_rw calls iomap_iter which calls btrfs_dio_iomap_begin which
> > >   creates an ordered extent for the full write.
> > > - iomap_dio_iter hits a page fault in bio_iov_iter_get_pages after 57344
> > >   bytes and breaks out early, but submits the partial bio.
> > > - the partial bio completes and calls the various endio callbacks,
> > >   resulting in a call to btrfs_mark_ordered_io_finished.
> > > - btrfs_mark_ordered_io_finished looks up the ordered extent and finds
> > >   the full ordered extent, but the write that finished is partial, so
> > >   the check for entry->bytes_left fails, and we don't call
> > >   finish_ordered_fn and thus don't create a file extent item for this
> > >   endio.
> > > - the IOMAP_DIO_PARTIAL logic results in us retrying starting from 65536
> > >   (8192 + 57344) but we fully exit and re-enter __iomap_dio_rw, which
> > >   creates a new ordered extent for off 65536 len 1769472 and that
> > >   ordered extent proceeds as above but successfully, and we get the
> > >   second file extent.
> >
> > So one thing doesn't add up here.
> >
> > The first write attempt creates the ordered extent for the range
> > [8192, 1835008],
> > we then submit a bio only for the range [8192, 65535], due to the page
> > fault at 64K.
> >
> > That means that the ordered extent can not be completed, as you said
> > before, as ->bytes_left will be > 0 even after the submitted bio
> > completes.
> >
> > However, the second time we enter btrfs_dio_iomap_begin(), for the
> > range [65536, 1835008], when we call lock_extent_direct(), we should
> > find the previous ordered extent, for range [8192, 1835008], which
> > intersects this second range - and that should make us wait for the
> > previous
> > ordered extent until it completes by calling
> > btrfs_start_ordered_extent() at lock_extent_direct(). This is clearly
> > not happening, as it would cause
> > a deadlock/hang.
> >
> > So something is missing in your analysis, and that's important to
> > figure out the best solution to the problem.
> >
> > Thanks.
> >
>
> Good point. I was confused about the extra ordered extents floating
> around as well. I believe I do have an explanation now. I think the
> following annotated callchain should explain it decently, but the tl;dr
> is that iomap_iter calls btrfs_dio_iomap_end which marks the ordered
> extent finished and clears the extent bits, but hits an error so it does
> not do much other endio work. (the error comes from
> mark_ordered_io_finished getting called without uptodate set)
>
> btrfs_direct_write
>   __iomap_dio_rw
>     iomap_iter
>       btrfs_dio_iomap_begin # creates the oe 8192 1835008
>     iomap_dio_iter # submits the partial bio 8192 57344 (CB1)
>       btrfs_dio_iomap_end
>         btrfs_mark_ordered_io_finished 65536 1769472
>         # ^ finds and munges the oe, decides bytes_left is 0 and queues
>         # the full finish work (CB2)
>     # partial write return
>   __iomap_dio_rw # btrfs_direct_write tries again
>     iomap_dio_iter
>       btrfs_dio_iomap_begin # makes the next OE
>     iomap_dio_iter # submits the remaining write 65536 1769472 (CB3)
>
> btrfs_dio_end_io 8192 57344 (CB1)
> # finds the full oe and bails, as discussed above
>
> btrfs_finish_ordered_io 65536 1769472 (CB2)
> # sees BTRFS_ORDERED_IOERR exits and clears the extent
>
> btrfs_dio_end_io 65536 1769472 (CB3)
> # succeeds on the new oe for that range and queues full finish work
> # which writes an extent
>
> In my opinion, the part of this that feels like it is not behaving
> properly is the interaction between the iomap_iter logic of
> __iomap_dio_rw and the implementation of btrfs_dio_iomap_begin/end.
> Something about the begin/end calls the generic loop is doing is getting
> us to believe that large extent was "finished" but with an error set. If
> that is an appropriate way to handle the partial write, then maybe the
> splitting I proposed earlier works as a fix. Otherwise we may need to
> handle this case more explicitly in iomap_iter/btrfs_dio_iomap_end.

Ok, so the problem is btrfs_dio_iomap_end() detects the submitted
amount is less than expected, so it marks the ordered extents as not
up to date, setting the BTRFS_ORDERED_IOERR bit on it.
That results in having an unexpected hole for the range [8192, 65535],
and no error returned to btrfs_direct_write().

My initial thought was to truncate the ordered extent at
btrfs_dio_iomap_end(), similar to what we do at
btrfs_invalidate_folio().
I think that should work, however we would end up with a bookend
extent (but so does your proposed fix), but I don't see an easy way to
get around that.

Thanks.


>
> >
> >
> >
> > >
> > > I'm not yet sure how to fix this, but have a couple ideas/questions:
> > > 1. Is there anyway we can split off a partial ordered extent and finish
> > > it when we get the partial write done?
> > > 2. Can we detect that there is an unfinished ordered extent that
> > > overlaps with our new one on the second write of the partial write
> > > logic?
> > >
> > > I'll play around and see if I can hack together a fix..
> > >
> > > >
> > > > Boris
> > > >
> > > > >
> > > > > --
> > > > > Chris Murphy
