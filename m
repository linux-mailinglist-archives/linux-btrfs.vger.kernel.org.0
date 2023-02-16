Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A966993B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 12:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBPL6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 06:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjBPL6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 06:58:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993D54573
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 03:58:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7325B82718
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 11:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D0BC4339B
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 11:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676548694;
        bh=e3O6Ob4gjIvGRt/Ov7+pckzrmfyIT+5buJWoXspyjCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PSiCzlw/AuJc+dYVtO1DCzw9DT1gwLXn+kXb4QnejojPXOJw1U+VJ684IZc4RBOEP
         5i1LkNVWeuma9cytqt1C6IcX8WZ4VJpvsj1aEhs8UuI+ItV0yjL+mQWSF4hwAA1yOx
         sYWqiRPLvq/7CO4G7sdMW5HoDa8ZU3eaxUm2d72nbnRW2+fBev9MUObnrbeit8PQ1Z
         M0HkpCOqRexoQ4WmUFFNrt3B/y1s2A4ctSfJQRZ993lWgQ7mKugdlt2m7DyGVxN2Zg
         G5C759QylZwlsj0AzUY+TaEQyxv4ZLqvO8YxDzBFcwugvEwc5K0Fc2Nlv6xYPBSkMb
         l/HpEUuP5Vs3w==
Received: by mail-oi1-f182.google.com with SMTP id 26so255678oix.7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 03:58:14 -0800 (PST)
X-Gm-Message-State: AO0yUKWgC5JbxPQ5VbShn1LPB32/rniUFqz1plvPmFRVtzV9BgGWIhW6
        +NB8FZDBz3P6CIKS0rYm5UeM6kdfOdA3vdmD6j4=
X-Google-Smtp-Source: AK7set+ZuC26jO077iMa6GZTEWmc7HS2GnxyQ+JE8W56HmknxZbOqRjA7IzXcvwzbVHIRj9DX6nqg6W+5V3wKBrfjuk=
X-Received: by 2002:a05:6808:2394:b0:37d:5e52:6844 with SMTP id
 bp20-20020a056808239400b0037d5e526844mr152677oib.98.1676548693611; Thu, 16
 Feb 2023 03:58:13 -0800 (PST)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com> <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
In-Reply-To: <Y+16BVPQiwf8e1J3@zen>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 16 Feb 2023 11:57:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
Message-ID: <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
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

On Thu, Feb 16, 2023 at 12:42 AM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Feb 15, 2023 at 03:21:38PM -0800, Boris Burkov wrote:
> > On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
> > >
> > >
> > > On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> > > > Downstream bug report, reproducer test file, and gdb session transcript
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > > >
> > > > I speculated that maybe it's similar to the issue we have with VM's
> > > > when O_DIRECT is used, but it seems that's not the case here.
> > >
> > > I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
> > >
> > > kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
> > >
> >
> > I was also able to reproduce on the current misc-next. However, when I
> > hacked the kernel to always fall back from DIO to buffered IO, it no
> > longer reproduced. So that's one hint..
> >
> > The next observation comes from comparing the happy vs unhappy file
> > extents on disk:
> > happy: https://pastebin.com/k4EPFKhc
> > unhappy: https://pastebin.com/hNSBR0yv
> >
> > The broken DIO case is missing file extents between bytes 8192 and 65536
> > which corresponds to the observed zeros.
> >
> > Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
> > instrumented that codepath. I observed a single successful write to 8192
> > bytes, then a second write which first does a partial write from 8192 to
> > 65536 and then faults in the rest of the iov_iter and finishes the
> > write.
> >
> > I'm now trying to figure out how these partial writes might lead us to
> > not create all the EXTENT_DATA items for the file extents.
>
> I believe the issue is indeed caused by faults reading the mapped region
> during direct io. Roughly what is happening is:
>
> - we start the dio write (offset 8192 len 1826816)
> - __iomap_dio_rw calls iomap_iter which calls btrfs_dio_iomap_begin which
>   creates an ordered extent for the full write.
> - iomap_dio_iter hits a page fault in bio_iov_iter_get_pages after 57344
>   bytes and breaks out early, but submits the partial bio.
> - the partial bio completes and calls the various endio callbacks,
>   resulting in a call to btrfs_mark_ordered_io_finished.
> - btrfs_mark_ordered_io_finished looks up the ordered extent and finds
>   the full ordered extent, but the write that finished is partial, so
>   the check for entry->bytes_left fails, and we don't call
>   finish_ordered_fn and thus don't create a file extent item for this
>   endio.
> - the IOMAP_DIO_PARTIAL logic results in us retrying starting from 65536
>   (8192 + 57344) but we fully exit and re-enter __iomap_dio_rw, which
>   creates a new ordered extent for off 65536 len 1769472 and that
>   ordered extent proceeds as above but successfully, and we get the
>   second file extent.

So one thing doesn't add up here.

The first write attempt creates the ordered extent for the range
[8192, 1835008],
we then submit a bio only for the range [8192, 65535], due to the page
fault at 64K.

That means that the ordered extent can not be completed, as you said
before, as ->bytes_left will be > 0 even after the submitted bio
completes.

However, the second time we enter btrfs_dio_iomap_begin(), for the
range [65536, 1835008], when we call lock_extent_direct(), we should
find the previous ordered extent, for range [8192, 1835008], which
intersects this second range - and that should make us wait for the
previous
ordered extent until it completes by calling
btrfs_start_ordered_extent() at lock_extent_direct(). This is clearly
not happening, as it would cause
a deadlock/hang.

So something is missing in your analysis, and that's important to
figure out the best solution to the problem.

Thanks.




>
> I'm not yet sure how to fix this, but have a couple ideas/questions:
> 1. Is there anyway we can split off a partial ordered extent and finish
> it when we get the partial write done?
> 2. Can we detect that there is an unfinished ordered extent that
> overlaps with our new one on the second write of the partial write
> logic?
>
> I'll play around and see if I can hack together a fix..
>
> >
> > Boris
> >
> > >
> > > --
> > > Chris Murphy
