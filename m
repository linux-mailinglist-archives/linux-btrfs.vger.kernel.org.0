Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE06C6E4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCWRAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCWRAK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 13:00:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7914A2D62
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 10:00:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C040C3200983;
        Thu, 23 Mar 2023 13:00:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 13:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679590808; x=1679677208; bh=x+
        Rb3jFqhtAl6UfoAICz1BxO1bz340PRo1eB0HX3l7I=; b=C1HFWR6ghJSLpXxlIn
        ayrR9wAru303Oe3x2AzLyahPHWs9/9EaLSp3w0qVPWbd7hPCijFk3pfY32nettwd
        33oSQtOOteha4OvRSTTxzAHlILrLVz9DW7OXLfl55Cy4Y3EeeSZLiZaNdu8x3xCG
        Zx2Xr3sT3pfnLL031OMoR8j36YW4lSBy1dfcCwiQt1G4H/eHzzvWOExDVC4VQdC6
        xdU9K2DOxpfsdAjSEVv1ykWbf08Y84TrvwvU/rSyJevOvxwSlCe3KOR7JgjdJykm
        wIrf4NU+BAlwKDKU5ZAqPw976nOU5YKlTB+2970Zdw/KSCVT8Lekx1/3KMGYV2CG
        GLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679590808; x=1679677208; bh=x+Rb3jFqhtAl6
        UfoAICz1BxO1bz340PRo1eB0HX3l7I=; b=XA+0VbylVRxafr2AsQ9I5VvaiZw0F
        qDHXAqedzMIWb4ElMI7/2qW3gWqhDOQ/1iSoCpFd309G1t0rnIkKQWR025PZLu5I
        gQiC9BeSwOQ9WZ5w2di9i8jQSdVpmwKupIo4q0k9/V1kn210Fv/UONEoCbYIjbtQ
        gfJ6WUmHjseFi238yEWJ8Kj1dUZEuoqb6XNnXGWFCbnrVUHcEvHegHvHljnllpoa
        4dKkkVy9i+zuST5QP0Na37WlaGO1GJXoIFXdLX43w0JN6F3MVMr6HgPL+21VHThf
        sCgWL0/icDYre31oD1jSoAL02GGKfinIe4BMs+K+Qkty+dneLtnBH5Rcw==
X-ME-Sender: <xms:mIUcZIz67g-uO0Vz70VjqzHEOtbD_Pj3M9XjTuwhdXO4hc0IUSLCAA>
    <xme:mIUcZMSR4CbeaGt0WF4Qm1KcIs7yFW2EXhAy1p1ytIbbFXUNc--I_y6LcB6Dqkv-z
    q4Ae9Uj6XHMDZ-z5pk>
X-ME-Received: <xmr:mIUcZKWApKBIcgnEhbGHq9uVjHhon-qwdbu863QBgJZJo3iNYRm38Qs1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdeiiefgffevgeffvedthfeijeegvdfgteehudeghffffeeikeehffefveekjeenucff
    ohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:mIUcZGhwniTx2uslpRAi_xFzAVs0sVHHRjACbsHxaDD3DzYRAibVeg>
    <xmx:mIUcZKAQl_xFQ38Wi14Kt5nFlWYchHT2oHFnqzlschPLSPD94NXagA>
    <xmx:mIUcZHJwqNmr54b6Gvon4nM-AhIZRhU9m_tFP61F6ezOhuQrrvKJ-g>
    <xmx:mIUcZL4gnBI8X6_yp-9Fz_Thdh8cKyIVR0ct1V0cIHl1L26PtQ_Nrg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 13:00:07 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:00:06 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <20230323170006.GA28317@zen>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
 <ZBwSIGXZipuob/61@infradead.org>
 <20230323161529.GA8070@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323161529.GA8070@zen>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 09:15:29AM -0700, Boris Burkov wrote:
> On Thu, Mar 23, 2023 at 01:47:28AM -0700, Christoph Hellwig wrote:
> > This is a bit of a mess.  And the root cause of that is that
> > btrfs_extract_ordered_extent the way it is used right now does
> > the wrong thing in terms of splitting the ordered_extent.  What
> > we want is to allocate a new one for the beginning of the range,
> > and leave the rest alone.
> > 
> > I did run into this a while ago during my (nt yet submitted) work
> > to keep an ordered_extent pointer in the btrfs_bio, and I have some
> > patches to sort it out.
> > 
> > I've rebased your fix on top of those, can you check if this tree
> > makes sense to you;
> > 
> >    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-dio-fix-hch
> > 
> > it passes basic testing so far.
> 
> Nice, this is great!
> 
> I actually also made the same changes as in your branch while working on
> my fix, but didn't know enough about the zoned use case to realize that
> the simpler "extract from beginning" constraint also applied to the
> zoned case. So what happened in my branch was I implemented the three
> way split as two "split at starts" which ultimately felt too messy and I
> opted for returning the new split objects from the the existing model.
> 
> If it's true that we can always do a "split from front" then I'm all
> aboard and think this is the way forward. Given that I found what I
> think is a serious bug in the case where pre>0, I suspect you are right,
> and we aren't hitting that case.
> 
> I will check that this passes my testing for the various dio cases (I
> have one modified xfstests case I haven't sent yet for the meanest
> version of the deadlock I have come up with so far) and the other tests
> that I saw races/flakiness on, but from a quick look, your branch looks
> correct to me. I believe the most non-obvious property my fix relies on
> is dio_data->ordered having the leftovers from the partial after
> submission so that it can be cancelled, which your branch looks to
> maintain.

Your branch as-is does not pass the existing tests, It's missing a fix
from my V5. We need to avoid splitting partial OEs when doing NOCOW dio
writes, because iomap_begin() does not create a fresh pinned em in that
case, since it reuses the existing extent.

e.g.,

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cb61f4daec0..bbc89a0872e7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7719,7 +7719,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
         * cancelled in iomap_end to avoid a deadlock wherein faulting the
         * remaining pages is blocked on the outstanding ordered extent.
         */
-       if (iter->flags & IOMAP_WRITE) {
+       if (iter->flags & IOMAP_WRITE && !test_bit(BTRFS_ORDERED_NOCOW, &dio_data->ordered->flags)) {
                int err;

                err = btrfs_extract_ordered_extent(bbio, dio_data->ordered);

With that patch, I pass 10x of btrfs/250, so running the full suite next.

> 
> Assuming the tests pass, I do want to get this in sooner than later,
> since downstream is still waiting on a fix. Would you be willing to send
> your stack soon for my fix to land atop? I don't mind if you just send a
> patch series with my patches mixed in, either. If, OTOH, your patches
> are still a while out, or depend on something else that's underway,
> maybe we could land mine, then gut them for your improvements. I'm fine
> with it either way.
> 
> Thanks,
> Boris
