Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F4699FD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBPWpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 17:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 17:45:45 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CE46164
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 14:45:44 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 58D5E32009B1;
        Thu, 16 Feb 2023 17:45:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Feb 2023 17:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676587541; x=1676673941; bh=o0i1xmxZbk
        opv4G+1szWJzPAgw4XK2HIjxRfe/F1C9M=; b=I4QXPyRZlHfvR2TRacbDUMF16R
        5RvgEWpoYPYNxePxk5o4yXN7nPZ2az2CU85wx5qMQj7R1P8HHW8vJf3vekWupOma
        R32V28AoD54my7nara6gEx94OeslwRjPkZ20deyPF5eZyMP1kcb/+f+QKE4LOd+x
        EsXct0gtoqEr/1CDZY7xSqd6Ldb8EXqZrTtvqIyC+l7yeLz26ufJxOHFIeKufes+
        FaQ9M8lFGxV+MfdoRtphFkUdaIwPaaMA519ad5m6h68FhPK6p6VBwC8W860c55nW
        5wQ6atug21eUHRxZOA5SP5Ah/zH/0H5iRGxTED/jX9c74Me7htRue1aSzTGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676587541; x=1676673941; bh=o0i1xmxZbkopv4G+1szWJzPAgw4X
        K2HIjxRfe/F1C9M=; b=JA1kG0ZN+nixuJBRCEli0XDh0WhooP8yC3cUTjxvS2pe
        UQpQWAyAtX4gNBVyV3NShvV7b3bJrzqJ2ljkHMrzNrTeNGuMNBTjQwu6BMQrgq7s
        De/u0xeZltO2JY6uPO7eaNa+Wb03TvP2Bt+8za30HCCQzFFZHTEccenm4LMfL3VR
        TPO4S7OOhR7oqbRdiJSq/Rnr0cs4Tu5peA3fH8x770GrqreeS5jbUL2Lk/n1BgAD
        jJqH7gBkr4+OPa9YNbRBP6L6RDwUMBMtcJOOfMGUtHSs0EHCuD4DBSqFcyJa3FD5
        Y2tutKw5Bo89Ns4abBsLMraixbUGbhYHYnhNDaJ7rw==
X-ME-Sender: <xms:FbLuY_PGUjxQiOn82zsl9T1NPPAk8pmvuAIsTquz4xLyEiMOBW03Gw>
    <xme:FbLuY58j93ez-hGl--9Qcbc9FR0wbuY7A5mZ6-ma5cVgzSs66euWovjdDzlQtLE7S
    EoePZxPVlvUFCwS4-w>
X-ME-Received: <xmr:FbLuY-RcL85wh2NwPqSQ-eDQtwz--Kd5CetMguVmjeoaKyPS0QvReuG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeikedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:FbLuYzvRsvbP70xkbZ_dae3potWa1CTk1BDckheuSjMUr_OPt2geBw>
    <xmx:FbLuY3fcxfrLShEh-ZSOaGfY_M-xds7Zco8tI89Aci6Z83bTwUqtMA>
    <xmx:FbLuY_1k7HpyXCd63Prw4_WPlHnvxjWkfPRNExPefednsHGyf7O3NQ>
    <xmx:FbLuY4phbbqH88TR8QvdgEaSurGifz4epHwkSS8b1PuSjQ1GavFoOQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 17:45:41 -0500 (EST)
Date:   Thu, 16 Feb 2023 14:45:39 -0800
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+6yEwymCdyOQ/4V@zen>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
 <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
 <Y+5kjpZJJxU+vz1X@zen>
 <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
 <Y+56sPyNHZRVQdnj@infradead.org>
 <CAL3q7H7gWmJhJ-xMcDifQ2hK=wMWJTmQ0tQWd8KRsaQM6fwiDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7gWmJhJ-xMcDifQ2hK=wMWJTmQ0tQWd8KRsaQM6fwiDg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 09:43:03PM +0000, Filipe Manana wrote:
> On Thu, Feb 16, 2023 at 6:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Feb 16, 2023 at 06:00:08PM +0000, Filipe Manana wrote:
> > > Ok, so the problem is btrfs_dio_iomap_end() detects the submitted
> > > amount is less than expected, so it marks the ordered extents as not
> > > up to date, setting the BTRFS_ORDERED_IOERR bit on it.
> > > That results in having an unexpected hole for the range [8192, 65535],
> > > and no error returned to btrfs_direct_write().
> > >
> > > My initial thought was to truncate the ordered extent at
> > > btrfs_dio_iomap_end(), similar to what we do at
> > > btrfs_invalidate_folio().
> > > I think that should work, however we would end up with a bookend
> > > extent (but so does your proposed fix), but I don't see an easy way to
> > > get around that.
> >
> > Wouldn't a better way to handle this be to cache the ordered_extent in
> > the btrfs_dio_data, and just reuse it on the next iteration if present
> > and covering the range?
> 
> That may work too, yes.

Quick update, I just got a preliminary version of this proposal working:
- reuse btrfs_dio_data across calls to __iomap_dio_rw
- store the dio ordered_extent when we create it in btrfs_dio_iomap_begin
- modify btrfs_dio_iomap_end to not mark the unfinished ios done in the
  incomplete case. (and to drop the ordered extent on done or error)
- modify btrfs_dio_iomap_begin to short-circuit when it has a cached
  ordered_extent

The resulting behavior on this workload is:
- write 8192
- finish OE, write file extent
- write 57344 (no extent, cached OE)
- re-enter __iomap_dio_rw with a live OE
- skip locking extent, reserving space, etc.
- write 1769472
- finish OE, write file extent

and the file looks as if there were no partial write. I think this is a
good structure for a fix to this bug, and plan to polish it up and send
it soon, unless someone objects and thinks we should go a different way.
