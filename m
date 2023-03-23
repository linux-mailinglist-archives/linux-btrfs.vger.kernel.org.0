Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA926C733E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 23:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCWWno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 18:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWWnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 18:43:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C47ED3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 15:43:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B76AA5C0163;
        Thu, 23 Mar 2023 18:43:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 18:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679611418; x=1679697818; bh=OH
        R0S6vSKGSDw2CUJgtrnOJWeK3MbPeOFKTzGR52KmU=; b=i8gtcHYTUodi/pR2yZ
        z8KEPGmy/rAUJ6CR1YcCH1wEfZ1eNTNUEz0iNMeFwsB80xKrypTCeaG2JrmO7Exo
        9jJ+UPrIHGt12zX4pxKzWO1BcDmGq/XC7pLluo9m2Uc0fcTBzVQBuxAjJ3PXdSMy
        QcuhA7l4ga9orBKYgaaID3hdp2eJcO0ePkXUP2+ZAVkaPLSR6kXv/U5F+1oJyzzF
        XbrC1D2+Ixkgppi0veQtr4pMcVq5XU0JPPYlacYgdUjjODg/s0DfsIH4LLdezwAZ
        c0s84lgjcAPkoU2ujBVWUVNm9BzmqNlWuC8tVJtbauWdilDHss8/VZHWetkea+UM
        0x0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679611418; x=1679697818; bh=OHR0S6vSKGSDw
        2CUJgtrnOJWeK3MbPeOFKTzGR52KmU=; b=MslfXB05scpzV6SwuY26G8RP23oW8
        BinXzRioi/uXtwAL2E5mraBZRFS7v9omRsqbi1h0wyhE+SxUiy89IwtlG1+qA15R
        jLw714VDvZjXsq0GlTRLe/AjLvNwJk6pj9d4v1X+KPg50CW9eBe2noPcb3Q4CH5Y
        n9xAc3cstDn4fFtCV9XyGtRR2xre/J+EQn0D8xYRMm8JjFo3y54hvFBuE8Fvz3VV
        Myguz/8+hfQqSkNa8ueiOqFAeuYEJkLj/EPN0ZJxQWAShW7NGavH/eMiEGocTwcF
        YWBNrgTxMkfFQ2GumgAinR+rNUhO+kAxEQ5ytkU7IOh4PXV9TxcN9Ryng==
X-ME-Sender: <xms:GtYcZE6zgB65MOt0QUsMOmqBaJj4Eyk2rtt6FlduFJ3EqlqFPfMILw>
    <xme:GtYcZF6IwtUSpka1V1_xGiSpquvzStP-SgMjD_5tWNivH8nSYesFGkbgk4pwJM_xg
    mRT_-5mnVFq9E0SXFI>
X-ME-Received: <xmr:GtYcZDfcYPxvnPPdXP9Agsnceja6TKUJjgPADxrVuNLaBNSJ6Zprb8oj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeghedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:GtYcZJKZrnQQ2nfzbI7jL9nQV6QE6XEm68kP7nC7-lTj1WgYr-Dwiw>
    <xmx:GtYcZIJTLPf5mUJnvkN_Tsc7xt1y66pe6y3JsQA5Yn7R4ms2VdGV4Q>
    <xmx:GtYcZKz2pEnQUVmDt_sfskXJTiH6ZdqahYbieLAOHQRUZh0K_tVDLQ>
    <xmx:GtYcZCiFVHdlx2lpnO2NbRqszNDxt_PIBrXic2AwXd-MSWRWOg7iUA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 18:43:38 -0400 (EDT)
Date:   Thu, 23 Mar 2023 15:43:36 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <20230323224336.GA29323@zen>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
 <ZBwSIGXZipuob/61@infradead.org>
 <20230323161529.GA8070@zen>
 <20230323170006.GA28317@zen>
 <ZBzEw4gy8lhNYgo7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBzEw4gy8lhNYgo7@infradead.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 02:29:39PM -0700, Christoph Hellwig wrote:
> On Thu, Mar 23, 2023 at 10:00:06AM -0700, Boris Burkov wrote:
> > Your branch as-is does not pass the existing tests, It's missing a fix
> > from my V5. We need to avoid splitting partial OEs when doing NOCOW dio
> > writes, because iomap_begin() does not create a fresh pinned em in that
> > case, since it reuses the existing extent.
> 
> Oops, yes, that got lost.  I can add this as another patch attributed
> to you.
> 
> That beeing said, I'm a bit confused about:
> 
>  1) if we need this split call at all for the non-zoned case as we don't
>     need to record a different physical disk address

I think I understand this, but maybe I'm missing exactly what you're
asking.

In finish_ordered_io, we call unpin_extent_cache, which blows up on
em->start != oe->file_offset. I believe the rationale is we are creating
a new em which is PINNED when we allocate the extent in
btrfs_new_extent_direct (via the call to btrfs_reserve_extent), so we
need to unpin it and allow it to be merged, etc... For nocow, we don't
allocate that new extent, so we don't need to split/unpin the existing
extent_map which we are just reusing.

>  2) how we clean up this on-disk logical to physical mapping at all on
>     a write failure

This I haven't thought much about, so I will leave it in the "dragons
sleep for now" category.

> 
> Maybe we should let those dragons sleep for now and just do the minimal
> fix, though.
> 
> I just woke up on an airplane, so depending on my jetlag I might have
> a new series ready with the minimal fix for varying definitions of
> "in a few hours".

Great, that works for me. I just didn't want to wait weeks if you were
blocked on other stuff.

> 
> > 
> > e.g.,
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 8cb61f4daec0..bbc89a0872e7 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7719,7 +7719,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
> >          * cancelled in iomap_end to avoid a deadlock wherein faulting the
> >          * remaining pages is blocked on the outstanding ordered extent.
> >          */
> > -       if (iter->flags & IOMAP_WRITE) {
> > +       if (iter->flags & IOMAP_WRITE && !test_bit(BTRFS_ORDERED_NOCOW, &dio_data->ordered->flags)) {
> >                 int err;
> > 
> >                 err = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
> 
> I think the BTRFS_ORDERED_NOCOW should be just around the
> split_extent_map call.  That matches your series, and without
> that we wouldn't split the ordered_extent for nowcow writes and thus
> only fix the original problem for non-nocow writes.

Oops, my bad. Good catch.
