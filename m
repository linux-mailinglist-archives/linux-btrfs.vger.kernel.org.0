Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D86C6D22
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCWQQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCWQPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 12:15:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B56F34F41
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 09:15:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5139232006F2;
        Thu, 23 Mar 2023 12:15:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 12:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679588130; x=1679674530; bh=Gc
        Z2oFiqyOQDbQgNByOwGI63jvc91QMF+VT15w7RT00=; b=U9JpgMO6tZFx+KIRKJ
        Yr/ccSr7u/+9nAWcnMKk8G0W6LewEzspRWbEbuGanlsAA4zq/l0M85TqSS/kWODV
        USp/XsYmwOs3ygrb1jbyaBEKdsJ1/zklqUmp8ll0n3nLXYYuuV9IZ3xNoJWRGlPK
        EMgpWO3+ZYhFSTX8Iyb5qg09UVh5KOkrERETgDfkkWDgbNDN6/LcSIgA/RAZtTt+
        yO5+5JCcLWnVWZ5sdi+gO8yzpvMLWZU/hkU503rbOhIGMbyNkW9W4sfxlfMDIxeW
        nByJFaSddU96DNXrmGtl08CjqQoyFua8ZSq34XXxyYhBI1xi7F/j4GZG2kbX3pVH
        4wtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679588130; x=1679674530; bh=GcZ2oFiqyOQDb
        QgNByOwGI63jvc91QMF+VT15w7RT00=; b=NGjEPfx8UzEXys05Hc3aEG7jZ40XM
        0oF9XKZKx0+9V9tCVO5IgRQmm97CA95YHs6hPuM7MTMCR0BL71KE44yrLy+veKSY
        LLqG/g6E0k4C8n3YxHe8qdXYBVaiON73r0xKaKnh1cb6tf5MRdYh7iLkTGmiNiDe
        fB0Bt/YuRv9cACSRg4ck5AT/5lUbSW4f9AqJXvNkn4ncan4Rj9gFBd+AeKWdyg+B
        UzgoY+BhkZY8IEOSlh0E4uAs2X/3CCqGhyso8O2Kj+erIymbku3l8vU4siiJp3of
        qSFj7cqzv7uwQ4qpEGIQqO9Rw0WmVhZ5R2Vo4BA1LKfixRmUWNphu6d7A==
X-ME-Sender: <xms:InscZE0A2diHD_sAGkFUpQLFoFk7AWBRfY4OW3-Epk38jBXrQmR-1g>
    <xme:InscZPFqnJ_qOEvJZzQcqckFsgtxppRD1cH-yj62jbxqIkn3LdbSQS9oo_Nf442Se
    h9ECnljFp293NP2KeI>
X-ME-Received: <xmr:InscZM5mOgnOE7N5ko9_1W5SYPtgmGH644VCSiY9zm1lnB_hxzCdvjdJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdeiiefgffevgeffvedthfeijeegvdfgteehudeghffffeeikeehffefveekjeenucff
    ohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:InscZN1FBhXx9LM3ts6as2dYtRo3tNInc5aNXHuyVZkkgZiE1GmWuA>
    <xmx:InscZHERcOAsGAIk5RiDcGCOq9voczB6gpYp4F0jIlKDVQ-x69F9ug>
    <xmx:InscZG-PddLJLIFmfLysZAZVM-whv1chfKR0dxBo3xFmy3126ZTpzg>
    <xmx:InscZNNPexJPJCEbItYfmhv0gNKsqX7NZVdlsWYbFvZ49a_wOW5FWw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 12:15:30 -0400 (EDT)
Date:   Thu, 23 Mar 2023 09:15:29 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <20230323161529.GA8070@zen>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
 <ZBwSIGXZipuob/61@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBwSIGXZipuob/61@infradead.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 01:47:28AM -0700, Christoph Hellwig wrote:
> This is a bit of a mess.  And the root cause of that is that
> btrfs_extract_ordered_extent the way it is used right now does
> the wrong thing in terms of splitting the ordered_extent.  What
> we want is to allocate a new one for the beginning of the range,
> and leave the rest alone.
> 
> I did run into this a while ago during my (nt yet submitted) work
> to keep an ordered_extent pointer in the btrfs_bio, and I have some
> patches to sort it out.
> 
> I've rebased your fix on top of those, can you check if this tree
> makes sense to you;
> 
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-dio-fix-hch
> 
> it passes basic testing so far.

Nice, this is great!

I actually also made the same changes as in your branch while working on
my fix, but didn't know enough about the zoned use case to realize that
the simpler "extract from beginning" constraint also applied to the
zoned case. So what happened in my branch was I implemented the three
way split as two "split at starts" which ultimately felt too messy and I
opted for returning the new split objects from the the existing model.

If it's true that we can always do a "split from front" then I'm all
aboard and think this is the way forward. Given that I found what I
think is a serious bug in the case where pre>0, I suspect you are right,
and we aren't hitting that case.

I will check that this passes my testing for the various dio cases (I
have one modified xfstests case I haven't sent yet for the meanest
version of the deadlock I have come up with so far) and the other tests
that I saw races/flakiness on, but from a quick look, your branch looks
correct to me. I believe the most non-obvious property my fix relies on
is dio_data->ordered having the leftovers from the partial after
submission so that it can be cancelled, which your branch looks to
maintain.

Assuming the tests pass, I do want to get this in sooner than later,
since downstream is still waiting on a fix. Would you be willing to send
your stack soon for my fix to land atop? I don't mind if you just send a
patch series with my patches mixed in, either. If, OTOH, your patches
are still a while out, or depend on something else that's underway,
maybe we could land mine, then gut them for your improvements. I'm fine
with it either way.

Thanks,
Boris
