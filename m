Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E084310504
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 07:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBEGjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 01:39:37 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34103 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230191AbhBEGjg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 01:39:36 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 723BC5C0187;
        Fri,  5 Feb 2021 01:38:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 05 Feb 2021 01:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=9Qe7wwHaUKVDGesS/xCBgQu4QdU
        AnFGxd+l8QTGV1p0=; b=T3RmIlclHjPBHUfn1v7epP4y5X3vNwEf9hN99xIsVMV
        cDd9Kd5bisYukEdrA2oAcIYEL5amJqqsmzKaovRspUD+KI2rXUbqfuqU2NCqgTOm
        q5bCNxHoKB1g9VRxmOVueloFPAhLpjtdXewATvQkoTBz/5GOt27fnCvZA2CQk1bB
        ByM0GuCkqiGouNc3a1/D/xN42C5vLuaLuiVhfVPGwMijsOmkBZmMgoDRC6NFbC5k
        BiDjwxR4jroK87aURNtqjaAoePa9zkVR5joe8slAahAVWv0B5PVP7xa3nf/2uVAe
        5cMDX0GCAG2k+f/oZjsm2OvduazlvGAt/YyVzhwfM+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9Qe7ww
        HaUKVDGesS/xCBgQu4QdUAnFGxd+l8QTGV1p0=; b=XewWKUwl0tjM34dUryfa6f
        eabmxi/Ihb3aMPLDEqMpQ7oHmIfolIZzIpfT4pSnCeMB0xpxaAOvVY3rNuhHXoFo
        PeDuE/5Sh9QfS4Cps7ZKYnkbWJ9hkWIIsEVm+4UpZPYHLVbjP0th7VLAVK14sLCx
        /mQYKY4G2P9QERQHQpsG9e40CnaWBOQncU1HnQtJAz4loNCm8PecohujBtlqvb57
        xHkwB5GeAwUXDMw6Fc2uqUNsOfSFM3McADgSy5Q7OdHgukARTGrO1dQWqyqmdqaV
        wzNcMgjk0qeYb4+He+x2WpuLHsSCo0b7P7zGvx27cUCRLOVzYK9QP+86vJNfJGUg
        ==
X-ME-Sender: <xms:5uccYChdyjW-ZT19KVYNk6KEGDiMNJ55SPIsbPLhxZNrTujj1V9k6Q>
    <xme:5uccYDC2sY-1a88E9VDJ3ELlxoZJI2CqFwDJdRIVn_7S9eh4Wb1YAADKdBr66Qaro
    yDLcXb9c4v2aUxPNBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepvd
    fhgffhteeugefgtdegudevudegkeeguedvvdfhudegudfhteekvedtiedtgeeunecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:5uccYKEK-mPzrY2mB1RZep_vqjxLi_rkNut0DEtG8cOpawADoz1d4Q>
    <xmx:5uccYLSYUuZNHmH2eVOCpTUt1BMR-IndCaiT27_WwLN0lLqiJ42TTA>
    <xmx:5uccYPyAkGCX82WA2WK3n0YFmvB0ux8h3GWcRfg0VQ2kxu-voMxLGg>
    <xmx:5uccYIqG2Padsl3_4f2KhkxBb5DE0fjm9RW9U-hmxpvBM30mKVJbVg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id BBE691080057;
        Fri,  5 Feb 2021 01:38:29 -0500 (EST)
Date:   Thu, 4 Feb 2021 22:38:23 -0800
From:   Boris Burkov <boris@bur.io>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a test for btrfs fsverity
Message-ID: <20210205063823.GA2428856@devbig008.ftw2.facebook.com>
References: <c16cbe8ad5795f059af45bfe7cf673dab58028a2.1612468162.git.boris@bur.io>
 <YBzf1z6EGCAK7JWN@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBzf1z6EGCAK7JWN@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thu, Feb 04, 2021 at 10:04:07PM -0800, Eric Biggers wrote:
> Thanks for writing a test for this!
> 
> On Thu, Feb 04, 2021 at 03:24:26PM -0800, Boris Burkov wrote:
> > There are some btrfs specific fsverity scenarios that don't map
> > neatly onto the tests in generic/574, like holes, inline extents,
> > and preallocated extents. Cover those in a btrfs specific test.
> > 
> > That test relies on assumptions about how the Merkle tree is stored
> > by ext4/f2fs which don't apply to btrfs, so we also test Merkle tree
> > corruption here. This could be merged by some generic abstraction.
> 
> The only part of generic/574 that cares where the Merkle tree is stored is
> _fsv_scratch_corrupt_merkle_tree().  Couldn't that be updated to handle btrfs?
> 

I agree that would be an easy enough fix, I'll make it in this patch.
Until I get 574 fully passing, I think I ought to leave the Merkle
corruption here as well, though, right?

> > Finally, that test relies extensively on fiemap, which is currently
> > broken on btrfs for offsets and sizes that don't align to PAGE_SIZE,
> > so put a simple regular file case in this test for now, while we fix
> > fiemap or generalize extent lookup.
> 
> fiemap is only used by _fsv_scratch_corrupt_bytes().  It just wants to know the
> list of extents that intersect the requested byte range.  Does that really not
> work on btrfs if the range isn't page-aligned?
> 

Unfortunately, fiemap is in fact broken in btrfs in that case, and prints
silly stuff like [K..K-1]. I wrote up a fix for it, but am still figuring
out how to test it, and decided to get the verity stuff out ahead of it.

However, even if I did get that fix in, it would still not be quite
right. Btrfs fiemap is in terms of logical block addresses, so
an additional translation with btrfs-map-logical is needed, and I
couldn't figure out how to elegantly inject that into
_fsv_scratch_corrupt_bytes. I do hope to get btrfs to pass generic/574
soon, though.

> - Eric 

Thanks for the review,
Boris
