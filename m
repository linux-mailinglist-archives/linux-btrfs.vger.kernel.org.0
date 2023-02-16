Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15212698A35
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 02:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBPBrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 20:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPBqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 20:46:54 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F8D2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 17:46:53 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 67FA35C00D9;
        Wed, 15 Feb 2023 20:46:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Feb 2023 20:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676512010; x=1676598410; bh=JaofzMCKOm
        /RgeL655OPuSkuxqTykn1Ulh2YmkLqzDw=; b=TjUoJmVUk98YFUQ3BDPnAjB6lc
        nWQJAG96KF/2DssI+ztDkEzGL5LBFWDuzPNEpmgWTgjdGchqa7tugk6VPVtQDgIv
        NWlyE2rVNzdSddNz0HSxC5kUL0H5YiFI1mZqM5J4CAvBJlDXTITD5YYt9E6zLj6H
        CApObRxRUj7yr+cTyAZaUr+XA5kSdSGnB9DiZuwZCifOcySgtd4//7DMl5Em2ApC
        H7+ecwZZ6utbvd3wEtBctq2W9KQsW80uSwKUT3w/3loJElatCFmq/oK2t6/KSpvA
        w/C8Lyu0xcHQH7TDGGzmtNK8KnJxZSAavFmxLTOJ4fM0MdYGz/2aYqUqdGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676512010; x=1676598410; bh=JaofzMCKOm/RgeL655OPuSkuxqTy
        kn1Ulh2YmkLqzDw=; b=BzIzQRnI51VDPxgD1yDZXuQwWxbOYaSaCpYLA2ftl8pO
        r4+d167cyAPCpVnlBrwziF7ULQRlOH27wOow7AotgNOHu67k2Pacjh0QfQUEQIe3
        8NRoURnXqU5Cod2KBlIOhkN3/4V4LpdWUEw6gFE1awC7ZiBCI4jPFgjygQK65H+Q
        YffL7LH3HnBWwWdlLez9qrawhysgxgNcGYdF1WYsrZTkKUAVJLd14xid6mz5O2Eg
        7rxR322N3itesEfQpi1EDrOWe9ULC+H7OlRvrL03uzBPub48zu/R1JFLVNgwXSh2
        4ljoGThKAqA7Lix+dEeolSjS9/ZPAVwkunV1zuPmhg==
X-ME-Sender: <xms:CovtY5IanQiCZtWYfu6LZzmv1qPIwCzEeuPgNKb-8bb2K8PkViUNkw>
    <xme:CovtY1KYUTPD4YyD6E79L4KBR311_qIvhT6YGNkrMQp12qPlHFtvwIi3noKi5z-r2
    PNmiRWznsOR_0oIDhQ>
X-ME-Received: <xmr:CovtYxvfj6frTv67fgCsNgjPlJ6jRSB3cEuEEQAnDer53C9cGgA0NXaf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehieegjeehffeuhffhleffueegjeefledtveduvdekgfehfffgtedvudekleffffenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdhprghsthgvsghinhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhr
    rdhioh
X-ME-Proxy: <xmx:CovtY6ase_bHXapIpIzwszXwvMLtu0j3-FY8h8jC_AFZ7hnvyZTitA>
    <xmx:CovtYwZrEWlxf7jmEuA_Ye0G-wZLfKHEnZrr2OrwQH_B7DEuKSCJaA>
    <xmx:CovtY-CRAMGZkQZqa4X5YuQY-haQdevr7ZnOe0Euo3I6yDdos8Gosg>
    <xmx:CovtY5CkUSFBKgXQwlUOuhXcicW2LnRnYsTIiGsLB3hYf7YKY1PD_Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 20:46:49 -0500 (EST)
Date:   Wed, 15 Feb 2023 17:46:48 -0800
From:   Boris Burkov <boris@bur.io>
To:     Chris Murphy <chris@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+2LCFrD4Qxff89Y@zen>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+16BVPQiwf8e1J3@zen>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 04:34:13PM -0800, Boris Burkov wrote:
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
> 
> I'm not yet sure how to fix this, but have a couple ideas/questions:
> 1. Is there anyway we can split off a partial ordered extent and finish
> it when we get the partial write done?
> 2. Can we detect that there is an unfinished ordered extent that
> overlaps with our new one on the second write of the partial write
> logic?
> 
> I'll play around and see if I can hack together a fix..

The following patch causes the problem to stop reproducing by splitting
the large ordered extent in the case of a short write and leaving it
alone otherwise. I haven't thoroughly tested it, or even thought it
through that well yet (e.g. I have no clue where that extract function
comes from!), but it's a start. I have to sign off for the evening, so
I will leave my investigation here for now.

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index d8b90f95b157..016b1a77af71 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -647,6 +647,11 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
        }

        if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+
+               ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
+               if (ret)
+                       goto fail_put_bio;
+
                if (use_append) {
                        bio->bi_opf &= ~REQ_OP_WRITE;
                        bio->bi_opf |= REQ_OP_ZONE_APPEND;

> 
> > 
> > Boris
> > 
> > > 
> > > -- 
> > > Chris Murphy
