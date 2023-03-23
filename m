Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2674A6C6F9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 18:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCWRpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 13:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWRpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 13:45:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6415174
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 10:45:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B2A82320097B;
        Thu, 23 Mar 2023 13:45:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 13:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679593504; x=1679679904; bh=lS
        gw1+/3JvgJdh4fBtPPsrorFb15FauokB/Odl/z8PQ=; b=msw3rQZNSYu5e38rCN
        CO5FxYS2Ebr64LBDbmPK1Dz5oBxUGwTS/zvXjkVnDNEpgV/9vV5fK866QtrlNf1/
        ZBj2hKBx87JCmTI0FiF5ax1Lpmscfo9F8iPmSetljVlK8W+XoVElPZ1QEB2nWLu7
        3/8T9NWSpAy7A8ruv5wgcMlS47reoqh0JqQZ2+LQ7ZIo/bcWv8P99MVmubTwK8vY
        h+0aWN/lBXT3yTwbcfWzpMtPda/NU4sMUObuExlJLUf4+Y7/sZxCG9dOm2NyzOOk
        Z26hkuhSyP+BVnG/isumFzMXsm8I46//GC1J63zw02KjuTpkROz6CtH2YzhpvMAn
        jcWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679593504; x=1679679904; bh=lSgw1+/3JvgJd
        h4fBtPPsrorFb15FauokB/Odl/z8PQ=; b=cINAEq5LN7tnXli/INRanML9n1cje
        Gu2UKGKZRMo2bGjBgvqOkEuhqFtZBmIS8HxPPr7pfOS0eeaBQt2fjEOxCF5oGi7m
        aOleMLL3O90zryIKnscJA8J4UYv8eMWW8KAZpVOYdSXqKmHUi2MaqncouXBdtkNA
        gh5qml2fjkik1nQ3AldXZ07r0F92RBUcbm4PEC/v75Sju1H+owfwyIS0uT2Tp0uV
        ku9maXm5EfOq0CIq3pKH3OMa2b9QXn8qw84F6uUH/APHkbZUUDd3MrgxFag6VB4D
        JwnFJNMVwsuqYYG5p3j4RPUc9gXBPIZdE+BbQLwVDT4CI+1Ax4fQI6n8Q==
X-ME-Sender: <xms:IJAcZKbZjC1zpLgsDk4yef1EmIY-ez7SCZm7ou1XYjqxVVCaNgI2-A>
    <xme:IJAcZNbrgdGKMl3HdLwXpuX7tmMFZXRXWFxEN1GdQNf8quL2_vQHBiob_cm0NyTlA
    swwUD6NKSQU7neNGLs>
X-ME-Received: <xmr:IJAcZE8G3OKCDniC01cPUfNQPGAHCl3YvszPJtK0FidKu8pND3OkDOfz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvieeigfffveegffevtdfhieejgedvgfethedugefhffefieekhefffeevkeejnecu
    ffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:IJAcZMoVEd09JBvr--zwGcz_NEy0BZkCYY3xUGY_BJ8muQTTqYlRrQ>
    <xmx:IJAcZFqHVfhrP_cK0n29IORxcD9gSyfd-BTEc9yLpiDyQqLjV5Reyg>
    <xmx:IJAcZKQZ5OeNDywWR8esYSo-08RRHUT-QSSKB0l8ujXjtSwcj2gOrQ>
    <xmx:IJAcZGBQRdMHkBZZhLtmswJMVKyb3nBhXz--6IM8doj7pFyBUtqlPw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 13:45:03 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:45:02 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <20230323174502.GA12221@zen>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
 <ZBwSIGXZipuob/61@infradead.org>
 <20230323161529.GA8070@zen>
 <20230323170006.GA28317@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323170006.GA28317@zen>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 10:00:06AM -0700, Boris Burkov wrote:
> On Thu, Mar 23, 2023 at 09:15:29AM -0700, Boris Burkov wrote:
> > On Thu, Mar 23, 2023 at 01:47:28AM -0700, Christoph Hellwig wrote:
> > > This is a bit of a mess.  And the root cause of that is that
> > > btrfs_extract_ordered_extent the way it is used right now does
> > > the wrong thing in terms of splitting the ordered_extent.  What
> > > we want is to allocate a new one for the beginning of the range,
> > > and leave the rest alone.
> > > 
> > > I did run into this a while ago during my (nt yet submitted) work
> > > to keep an ordered_extent pointer in the btrfs_bio, and I have some
> > > patches to sort it out.
> > > 
> > > I've rebased your fix on top of those, can you check if this tree
> > > makes sense to you;
> > > 
> > >    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-dio-fix-hch
> > > 
> > > it passes basic testing so far.
> > 
> > Nice, this is great!
> > 
> > I actually also made the same changes as in your branch while working on
> > my fix, but didn't know enough about the zoned use case to realize that
> > the simpler "extract from beginning" constraint also applied to the
> > zoned case. So what happened in my branch was I implemented the three
> > way split as two "split at starts" which ultimately felt too messy and I
> > opted for returning the new split objects from the the existing model.
> > 
> > If it's true that we can always do a "split from front" then I'm all
> > aboard and think this is the way forward. Given that I found what I
> > think is a serious bug in the case where pre>0, I suspect you are right,
> > and we aren't hitting that case.
> > 
> > I will check that this passes my testing for the various dio cases (I
> > have one modified xfstests case I haven't sent yet for the meanest
> > version of the deadlock I have come up with so far) and the other tests
> > that I saw races/flakiness on, but from a quick look, your branch looks
> > correct to me. I believe the most non-obvious property my fix relies on
> > is dio_data->ordered having the leftovers from the partial after
> > submission so that it can be cancelled, which your branch looks to
> > maintain.
> 
> Your branch as-is does not pass the existing tests, It's missing a fix
> from my V5. We need to avoid splitting partial OEs when doing NOCOW dio
> writes, because iomap_begin() does not create a fresh pinned em in that
> case, since it reuses the existing extent.
> 
> e.g.,
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8cb61f4daec0..bbc89a0872e7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7719,7 +7719,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
>          * cancelled in iomap_end to avoid a deadlock wherein faulting the
>          * remaining pages is blocked on the outstanding ordered extent.
>          */
> -       if (iter->flags & IOMAP_WRITE) {
> +       if (iter->flags & IOMAP_WRITE && !test_bit(BTRFS_ORDERED_NOCOW, &dio_data->ordered->flags)) {
>                 int err;
> 
>                 err = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
> 
> With that patch, I pass 10x of btrfs/250, so running the full suite next.

fstests in general passed on my system, so I am happy with this branch +
my above tweak if Naohiro/Johannes are on board with the simplified
ordered_extent/extent_map splitting model that assumes the bio is at the
start offset.

> 
> > 
> > Assuming the tests pass, I do want to get this in sooner than later,
> > since downstream is still waiting on a fix. Would you be willing to send
> > your stack soon for my fix to land atop? I don't mind if you just send a
> > patch series with my patches mixed in, either. If, OTOH, your patches
> > are still a while out, or depend on something else that's underway,
> > maybe we could land mine, then gut them for your improvements. I'm fine
> > with it either way.
> > 
> > Thanks,
> > Boris
