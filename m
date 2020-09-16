Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CB26C832
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgIPSmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 14:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgIPS1p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 14:27:45 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37BA722208;
        Wed, 16 Sep 2020 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600280864;
        bh=8qlak/iJZ1weobruO4cvNi1WhYgt0OC+6iovuMs7szE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AprUEuZQ7/3taf12uhi7pHpICffnF/MiMUikckj/6bEyw1ldvY9YVR8uPSnE2o7Ab
         rqf84Nw0IPvGCvX3Z9U8gIkBsFHGMF/SQYTojHEP9zH7Ewkx2/fMmeJWmLc4oPmffC
         zCInOFKGiYQDzrft/0Y1uKrDkkbWlaA92OD/H6Ps=
Date:   Wed, 16 Sep 2020 11:27:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Chris Mason <clm@fb.com>, squashfs-devel@lists.sourceforge.net,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nick Terrell <nickrterrell@gmail.com>,
        Yann Collet <cyan@fb.com>, Petr Malat <oss@malat.biz>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Nick Terrell <terrelln@fb.com>, linux-crypto@vger.kernel.org,
        Kernel Team <Kernel-team@fb.com>,
        Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Message-ID: <20200916182742.GB4373@sol.localdomain>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
 <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
 <20200916143046.GA13543@infradead.org>
 <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
 <20200916144618.GB16392@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916144618.GB16392@infradead.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 16, 2020 at 03:46:18PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 16, 2020 at 10:43:04AM -0400, Chris Mason wrote:
> > Otherwise we just end up with drift and kernel-specific bugs that are harder
> > to debug.  To the extent those APIs make us contort the kernel code, I???m
> > sure Nick is interested in improving things in both places.
> 
> Seriously, we do not care elsewhere.  Why would zlib be any different?
> 
> > There are probably 1000 constructive ways to have that conversation.  Please
> > choose one of those instead of being an asshole.
> 
> I think you are the asshole here by ignoring the practices we are using
> elsewhere and think your employers pet project is somehow special.  It
> is not, and claiming so is everything but constructive.
> 

The userspace Zstandard library is widely used and has been heavily reviewed,
tested, and fuzzed.

The options are either (a) write and maintain a separate kernel implementation
of Zstandard, or (b) periodically sync from upstream and make minimal, easily
reviewable changes to integrate with the kernel.

I don't see option (a) working for Zstandard.  For short and simple code, it's
the usual Linux kernel practice and it works fine.  But it's far too hard to
write and maintain a good implementation of Zstandard -- meaning correct, fast,
fully fuzzed, and supporting all needed compression levels.  Optimizing
compressors and decompressors is really hard.  A "naive" implementation wouldn't
be too hard, but it would be slow and wouldn't support high compression ratios.

Similarly, some of the crypto assembly code in the kernel is taken from the
OpenSSL project, since the kernel community doesn't have the capacity to
properly optimize algorithms like Poly1305 for x86, arm, arm64, mips, ...

If your main concern is about the camel case function naming, that doesn't seem
very important, relatively speaking.

- Eric
