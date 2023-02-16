Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0897C699AFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBPRPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 12:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPRPB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 12:15:01 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE64AFD2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 09:14:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B03B93200991;
        Thu, 16 Feb 2023 12:14:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Feb 2023 12:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676567696; x=1676654096; bh=/aLrAwrbNo
        uEgbyH1KMtj3Hr3XWW2DHPektCbYZ5O5E=; b=CRw0oslJAcgfESKwwinRmkN0KB
        J/abT6qPaYHHT4tQzWvmwbtZU11TFnEslSS0mLoYDTmxU8bybslFDo/5Fo448Z6d
        qh3omG87Ch6R01Fb7S09DaGgTfHAbZR5lSyhBPk9h9Z55GnG+PgYTK1ztXBwN4Cz
        N8aYh9HPd4HCEzrgx1I9hTPzg3EizEjTnA5EMBGbAlbYWs9ODOm8kNFiEj15oXoa
        KP98Ms7HWROx7QYXcvchbHixEoGXRhoCXGD8pVlNGgQKzCFRGnLO2Ob2NdCS+Dki
        j4NUgdfsfYT6fj88bUAr7Z4sUvG8N+M3lYnKjgWvwas7fsHeYZT9uCK+M+HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676567696; x=1676654096; bh=/aLrAwrbNouEgbyH1KMtj3Hr3XWW
        2DHPektCbYZ5O5E=; b=U7IDYzwBB9OI90JwZchNEP5Ql+fQUOHcxqTzG4O7Pqpb
        cVJxG8yNt+P78YcKfA7Q0wQZ+0eYrHZlo8tf5GBqlDH1vF6xhU7axryGgxLgojIs
        a0L3mKGRX+ylqYlFoghtimozs7LfisxpxHTsVwKkttKWvYEBKNWj3uVfB7O6v/zo
        Aq2KEE3pVeUvkZdthuabdI/J69Wnm0S6DOq2NbSdsEMizgZ0GfRCxN1TACfOBwn8
        iOJnZZy6ZADeryFAMB1JW21f7cRRBlQC3Z4E0W+w9tn+5p4OQ2yB9ues/QHRutZt
        /IrwnQu1PC4CKEQqQ++VUFje1S8fXPEWv26Fa+epag==
X-ME-Sender: <xms:kGTuY9eqeepTVhPsXJl0kjE4quY-1EtO1vcB9licWOGOadJV634f3g>
    <xme:kGTuY7MDdV2yrPww93uZ64oCY-5YFUCmQHhiuOo1Urm3mOIyMuUshJQksvFrHo0Cp
    XSJxm6Gz9Ok3M2pl_s>
X-ME-Received: <xmr:kGTuY2i9iYawp2VsJ2gaCP3QXhZ0OKWLRfMlqSkRTdt2cg034DOZqFJ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehieegjeehffeuhffhleffueegjeefledtveduvdekgfehfffgtedvudekleffffenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdhprghsthgvsghinhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhr
    rdhioh
X-ME-Proxy: <xmx:kGTuY2-BlBknjmzn9t-0E_Nwxed2joKDhbCOI2Y-1zio0D7mNqa96w>
    <xmx:kGTuY5uaHCG1Sm_rDSk6h0HRAvQWNnXXOhpN0osnLjFJMLLxdjjl3w>
    <xmx:kGTuY1Gy3z347TWanhnBAmUzZCFMCseWU9eI5b2LMvygVJdTTFC--g>
    <xmx:kGTuY6Wr6knVdoIoTgktQhEHpO4bI-1DW2X6iGnXseMPCGXBz6zdiQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 12:14:55 -0500 (EST)
Date:   Thu, 16 Feb 2023 09:14:54 -0800
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+5kjpZJJxU+vz1X@zen>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
 <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 11:57:37AM +0000, Filipe Manana wrote:
> On Thu, Feb 16, 2023 at 12:42 AM Boris Burkov <boris@bur.io> wrote:
> >
> > On Wed, Feb 15, 2023 at 03:21:38PM -0800, Boris Burkov wrote:
> > > On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
> > > >
> > > >
> > > > On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> > > > > Downstream bug report, reproducer test file, and gdb session transcript
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > > > >
> > > > > I speculated that maybe it's similar to the issue we have with VM's
> > > > > when O_DIRECT is used, but it seems that's not the case here.
> > > >
> > > > I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
> > > >
> > > > kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
> > > >
> > >
> > > I was also able to reproduce on the current misc-next. However, when I
> > > hacked the kernel to always fall back from DIO to buffered IO, it no
> > > longer reproduced. So that's one hint..
> > >
> > > The next observation comes from comparing the happy vs unhappy file
> > > extents on disk:
> > > happy: https://pastebin.com/k4EPFKhc
> > > unhappy: https://pastebin.com/hNSBR0yv
> > >
> > > The broken DIO case is missing file extents between bytes 8192 and 65536
> > > which corresponds to the observed zeros.
> > >
> > > Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
> > > instrumented that codepath. I observed a single successful write to 8192
> > > bytes, then a second write which first does a partial write from 8192 to
> > > 65536 and then faults in the rest of the iov_iter and finishes the
> > > write.
> > >
> > > I'm now trying to figure out how these partial writes might lead us to
> > > not create all the EXTENT_DATA items for the file extents.
> >
> > I believe the issue is indeed caused by faults reading the mapped region
> > during direct io. Roughly what is happening is:
> >
> > - we start the dio write (offset 8192 len 1826816)
> > - __iomap_dio_rw calls iomap_iter which calls btrfs_dio_iomap_begin which
> >   creates an ordered extent for the full write.
> > - iomap_dio_iter hits a page fault in bio_iov_iter_get_pages after 57344
> >   bytes and breaks out early, but submits the partial bio.
> > - the partial bio completes and calls the various endio callbacks,
> >   resulting in a call to btrfs_mark_ordered_io_finished.
> > - btrfs_mark_ordered_io_finished looks up the ordered extent and finds
> >   the full ordered extent, but the write that finished is partial, so
> >   the check for entry->bytes_left fails, and we don't call
> >   finish_ordered_fn and thus don't create a file extent item for this
> >   endio.
> > - the IOMAP_DIO_PARTIAL logic results in us retrying starting from 65536
> >   (8192 + 57344) but we fully exit and re-enter __iomap_dio_rw, which
> >   creates a new ordered extent for off 65536 len 1769472 and that
> >   ordered extent proceeds as above but successfully, and we get the
> >   second file extent.
> 
> So one thing doesn't add up here.
> 
> The first write attempt creates the ordered extent for the range
> [8192, 1835008],
> we then submit a bio only for the range [8192, 65535], due to the page
> fault at 64K.
> 
> That means that the ordered extent can not be completed, as you said
> before, as ->bytes_left will be > 0 even after the submitted bio
> completes.
> 
> However, the second time we enter btrfs_dio_iomap_begin(), for the
> range [65536, 1835008], when we call lock_extent_direct(), we should
> find the previous ordered extent, for range [8192, 1835008], which
> intersects this second range - and that should make us wait for the
> previous
> ordered extent until it completes by calling
> btrfs_start_ordered_extent() at lock_extent_direct(). This is clearly
> not happening, as it would cause
> a deadlock/hang.
> 
> So something is missing in your analysis, and that's important to
> figure out the best solution to the problem.
> 
> Thanks.
> 

Good point. I was confused about the extra ordered extents floating
around as well. I believe I do have an explanation now. I think the
following annotated callchain should explain it decently, but the tl;dr
is that iomap_iter calls btrfs_dio_iomap_end which marks the ordered
extent finished and clears the extent bits, but hits an error so it does
not do much other endio work. (the error comes from
mark_ordered_io_finished getting called without uptodate set)

btrfs_direct_write
  __iomap_dio_rw
    iomap_iter
      btrfs_dio_iomap_begin # creates the oe 8192 1835008
    iomap_dio_iter # submits the partial bio 8192 57344 (CB1)
      btrfs_dio_iomap_end
        btrfs_mark_ordered_io_finished 65536 1769472
        # ^ finds and munges the oe, decides bytes_left is 0 and queues
        # the full finish work (CB2)
    # partial write return
  __iomap_dio_rw # btrfs_direct_write tries again
    iomap_dio_iter
      btrfs_dio_iomap_begin # makes the next OE
    iomap_dio_iter # submits the remaining write 65536 1769472 (CB3)

btrfs_dio_end_io 8192 57344 (CB1)
# finds the full oe and bails, as discussed above

btrfs_finish_ordered_io 65536 1769472 (CB2)
# sees BTRFS_ORDERED_IOERR exits and clears the extent

btrfs_dio_end_io 65536 1769472 (CB3)
# succeeds on the new oe for that range and queues full finish work
# which writes an extent

In my opinion, the part of this that feels like it is not behaving
properly is the interaction between the iomap_iter logic of
__iomap_dio_rw and the implementation of btrfs_dio_iomap_begin/end.
Something about the begin/end calls the generic loop is doing is getting
us to believe that large extent was "finished" but with an error set. If
that is an appropriate way to handle the partial write, then maybe the
splitting I proposed earlier works as a fix. Otherwise we may need to
handle this case more explicitly in iomap_iter/btrfs_dio_iomap_end.

> 
> 
> 
> >
> > I'm not yet sure how to fix this, but have a couple ideas/questions:
> > 1. Is there anyway we can split off a partial ordered extent and finish
> > it when we get the partial write done?
> > 2. Can we detect that there is an unfinished ordered extent that
> > overlaps with our new one on the second write of the partial write
> > logic?
> >
> > I'll play around and see if I can hack together a fix..
> >
> > >
> > > Boris
> > >
> > > >
> > > > --
> > > > Chris Murphy
