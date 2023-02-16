Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EA69894E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 01:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBPAeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 19:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPAeS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 19:34:18 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65942DCF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 16:34:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 15B1F5C00EE;
        Wed, 15 Feb 2023 19:34:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Feb 2023 19:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676507655; x=1676594055; bh=mhoWpbcSr+
        Zioqs+rJzfwvvAwA6qAFvaV4cJBNE6/40=; b=TkiOa76xOiW7wvnK2h0rttxXBC
        e5GlogkH6A44bO4pWXr6p3zGsXLdw/aysg70Y50azRs9HHupTaToICM0pVlWq1M9
        loMJTIprSx0VzYATCdgcIBM9uSENw2gDwaVr7lIH9Nhavw0C99TfZHgQuksSzhnW
        F9g7CxEOsQxN4B/ZM8ZdPrWLdPnTD8QGpQSqXk+LRP57k9I6MKnsGiPifqKuUqtA
        UCnoTmviilzKDpHtG749NPTXi0kXEJ3mTjD/dpsIOEAp7kTHbOkj4CCBMd4iNLzH
        WVJKtdSbI0kkX5qVOkfHEIV1EaEtBeHzTROx3EgAyxR1fpXwII9z35hCxKgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676507655; x=1676594055; bh=mhoWpbcSr+Zioqs+rJzfwvvAwA6q
        AFvaV4cJBNE6/40=; b=CnFrY9xV8AJvIX/at0Xj2VSbmWAfpEJOYLuOH0aRyGh0
        wZBHuTWjw0U3dIql6cJ+2whwK1lFU5U64ChOhgSA1fN9rztiMLLDjjc0/5tU+bqS
        g7bzLtZubihqxU8GcaV0i35Hx+Zol/kYdvPMuzJZhkzLQcRTaEu4TkWMfyvgPJXl
        GQlyxOX8TSOUDG3iN79YzoLuTHVOVtV5dcl+li9g7mMkcbspehD1UBAvRccVqAeZ
        LM44ME69ay/E66cm9TGSlwCjW7ru9kGSAKtOoWqNhAaepcxNx706GdPfRx05oaCH
        k3jbaaUiYt5Hf1b0R27H142lwV9YftyT5EnOsqhYjQ==
X-ME-Sender: <xms:BnrtY7IrmUXRtV63IDlxLnc8janS6J-vEXgLFaMe-OhPN4GLJyrLLw>
    <xme:BnrtY_KihyuZaQRK2XIvbBxkuLlRvQWXQ0x4INWWgplsrGFsdV0hp3_zoe09JhNiU
    EyJe_rDzWeTNXYJ7o0>
X-ME-Received: <xmr:BnrtYzslnm_irZQFxdYk6XTJBvDOIYOJEC4Djn4GEQaYcrVdtPs55TPx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehieegjeehffeuhffhleffueegjeefledtveduvdekgfehfffgtedvudekleffffenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdhprghsthgvsghinhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhr
    rdhioh
X-ME-Proxy: <xmx:BnrtY0ZIEF0rWEmInmiOE0hxx4qk1SuLg0-aZI03vfCBiOYpnQpaPw>
    <xmx:BnrtYyZuqdEqkN70ouk6U5vqgNZHLY6CUongYOEZVDUN7cFReCzSZw>
    <xmx:BnrtY4CmCH5rU3rn6KgIO4GmAyGvQuIBFvIU2Z3W7fkXldiOlTyleA>
    <xmx:B3rtY7COVsvb0yMWreWfChcVpbufCtkTm3rEcjkUEdlKn6a39AJgbw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 19:34:14 -0500 (EST)
Date:   Wed, 15 Feb 2023 16:34:13 -0800
From:   Boris Burkov <boris@bur.io>
To:     Chris Murphy <chris@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+16BVPQiwf8e1J3@zen>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+1pAoetotjEuef7@zen>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 03:21:38PM -0800, Boris Burkov wrote:
> On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
> > 
> > 
> > On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> > > Downstream bug report, reproducer test file, and gdb session transcript
> > > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > >
> > > I speculated that maybe it's similar to the issue we have with VM's 
> > > when O_DIRECT is used, but it seems that's not the case here.
> > 
> > I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
> > 
> > kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
> > 
> 
> I was also able to reproduce on the current misc-next. However, when I
> hacked the kernel to always fall back from DIO to buffered IO, it no
> longer reproduced. So that's one hint..
> 
> The next observation comes from comparing the happy vs unhappy file
> extents on disk:
> happy: https://pastebin.com/k4EPFKhc
> unhappy: https://pastebin.com/hNSBR0yv
> 
> The broken DIO case is missing file extents between bytes 8192 and 65536
> which corresponds to the observed zeros.
> 
> Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
> instrumented that codepath. I observed a single successful write to 8192
> bytes, then a second write which first does a partial write from 8192 to
> 65536 and then faults in the rest of the iov_iter and finishes the
> write.
> 
> I'm now trying to figure out how these partial writes might lead us to
> not create all the EXTENT_DATA items for the file extents.

I believe the issue is indeed caused by faults reading the mapped region
during direct io. Roughly what is happening is:

- we start the dio write (offset 8192 len 1826816)
- __iomap_dio_rw calls iomap_iter which calls btrfs_dio_iomap_begin which
  creates an ordered extent for the full write.
- iomap_dio_iter hits a page fault in bio_iov_iter_get_pages after 57344
  bytes and breaks out early, but submits the partial bio.
- the partial bio completes and calls the various endio callbacks,
  resulting in a call to btrfs_mark_ordered_io_finished.
- btrfs_mark_ordered_io_finished looks up the ordered extent and finds
  the full ordered extent, but the write that finished is partial, so
  the check for entry->bytes_left fails, and we don't call
  finish_ordered_fn and thus don't create a file extent item for this
  endio.
- the IOMAP_DIO_PARTIAL logic results in us retrying starting from 65536
  (8192 + 57344) but we fully exit and re-enter __iomap_dio_rw, which
  creates a new ordered extent for off 65536 len 1769472 and that
  ordered extent proceeds as above but successfully, and we get the
  second file extent.

I'm not yet sure how to fix this, but have a couple ideas/questions:
1. Is there anyway we can split off a partial ordered extent and finish
it when we get the partial write done?
2. Can we detect that there is an unfinished ordered extent that
overlaps with our new one on the second write of the partial write
logic?

I'll play around and see if I can hack together a fix..

> 
> Boris
> 
> > 
> > -- 
> > Chris Murphy
