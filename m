Return-Path: <linux-btrfs+bounces-14462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE0ACE423
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE483A7909
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6719DF4A;
	Wed,  4 Jun 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GGSfTmya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOjA4qQf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB772171A1
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749060192; cv=none; b=CFVOZ90y0KaB5hNkT1gKJUQZi/eJbn0sCnxBu361aKAiv+lolvqsKynMznee1T9nZo0lrV5LxhmfWPyWUEveVUnI2MfkmiBgHLw8gZl84w+wWMlwdgBpSigWNXhx2QwA2Dc8yUMin5UhSzxjHY1OlcRvupMe1YRBm5uJ1zZr6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749060192; c=relaxed/simple;
	bh=OvV9wbvpJCoRJ98gVHzRUcQaFcJneI73D8C+6Q+1xj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhaNKK0w5QSbgnISgushVfZ8Jhry6S1maqJg4zVF0yaFDzOWGOqfnrj/tt/jcfZkrdABWeLfOsXDVoAVEHgyTnvB1h7ibD6UgSmI2lk//0zlYw40i41wahuQd4w5Dgy2dO7OVxybglISEbfXLUMpSpzAI2SSeY2SMCJ53K/twUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GGSfTmya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOjA4qQf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 984941140109;
	Wed,  4 Jun 2025 14:03:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Jun 2025 14:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749060188; x=1749146588; bh=+tn9bbvTEP
	K9OWUfA7MX+9Wh0g5eyhJNjFTPb+VxTL8=; b=GGSfTmyalcOBaDI0rduLDluUtM
	Oz2UjZFUTooot+klvMJY3bFg48pQTA9+hOdSCABR8MLQCwNLCKSP+etbw2kBGCge
	kKsPEwCKWF3x6zwV9PUXGFBRmpQMFiV0YqCqPRqjMlb0pdXqPwzTeDxb/GfmBva9
	at9clei5w/9+PUs1cJ/Ih88z10TXw9km5sGgJY0pb0yXdwN0qW25NwjsU7qEoOuU
	e7bvzPvhKIH4Rr+8NMl2hD8igClhgCR9uN0CX9tgZCvFgfw/jKTmOwLm6SJ2MbBM
	Tkj7T+XGcPQBHQkwH8TRKrknaWgtygqUlwF7Xaavu9UiOwgJF/FwjHajW25g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749060188; x=1749146588; bh=+tn9bbvTEPK9OWUfA7MX+9Wh0g5eyhJNjFT
	Pb+VxTL8=; b=KOjA4qQfFHJWe9DY9B7eqTfe4+UCl3ACNrRkZB/oI3oqWCqLYht
	AQh/Pwq7SOHJMK3SVnOHZqE9dAsDoAI3CcG61YFpcX18JCsnBNhFnrRmLuT/yhcF
	dOClRvh/AIp3KRnDDQYVkZ+8xdJXBcYT55+sLWBMbA+dMxX1rfZJivU8FS/R2S0j
	Z6VM6KtdYrvDQR6HjhrVI3PsuUtChojdHbAR3C4QATes56x/t1HLNKtqdqatsYi+
	21udIViWgPw7wUt0wcQyEj556x8Crmz2b+JgnF0Nh8H71FAV7JyZNSoFxIR+LWop
	naVy0MlBgNbONmVvmfIEenJ8kvyDWs2EoBg==
X-ME-Sender: <xms:XIpAaMNiwnuBiGfUUv47VTTiU-kw7mJv5HVTBCqt-aYuhc_SCFV1Tw>
    <xme:XIpAaC9bOcRNpuaN0Go-EuX5bdKqSIj30XZdXdh4rVjPe3dXQV48gSj1pm2w_s5tZ
    LiSkL-ixLyFYTYwjCQ>
X-ME-Received: <xmr:XIpAaDRlDN2XVdqI2vSj_buKCU4sA-yUNuheAnCbDJukwCyVP7Hd9Rk_3Q6vG8pAIUeYNN9MKP2cDX_p--RTAGJwOLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvgeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehjihhmihhssehgmhigrdhnvghtpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehquhifvghnrhhuohdrsg
    htrhhfshesghhmgidrtghomhdprhgtphhtthhopegrnhgrnhgurdhjrghinhesohhrrggt
    lhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:XIpAaEs7B-q_RHdd7UC9GaV0_0O3JSrZOzfaleUQ9Nw01hJAKwbzHg>
    <xmx:XIpAaEdlwRO55-PAp1RYI4p4vPgtd-LxrtbF9RiIGdN8ViQpDYpLeQ>
    <xmx:XIpAaI2FsJp4Ou-Yg-rFXPExNTuDgJKZeHNLTciNl4sYKcANqZTaCQ>
    <xmx:XIpAaI8cv0vYUGwUx85I3-CZlcwz4kYxYVnvTN2rrT3TFAHKEv2vbg>
    <xmx:XIpAaD1Py5BeZbubDQqkt_a_G72RcEhSGe6e7ls5SslMC1BOZwKmTVN->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 14:03:07 -0400 (EDT)
Date: Wed, 4 Jun 2025 11:03:03 -0700
From: Boris Burkov <boris@bur.io>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dimitrios Apostolou <jimis@gmx.net>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Anand Jain <anand.jain@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Sequential read(8K) from compressed files are very slow
Message-ID: <20250604180303.GA978719@zen.localdomain>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
 <20250604013611.GA485082@zen.localdomain>
 <aD_mE1n1fmQ09klP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD_mE1n1fmQ09klP@infradead.org>

On Tue, Jun 03, 2025 at 11:22:11PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 03, 2025 at 06:36:11PM -0700, Boris Burkov wrote:
> > However, I do observe the huge delta between bs=8k and bs=128k for
> > compressed which is interesting, even if I am doing something dumb and
> > failing to reproduce the fast uncompressed reads.
> > 
> > I also observe that the performance rapidly drops off below bs=32k.
> > Using the highly compressible file, I get 1.4GB/s with 128k, 64k, 32k
> > and then 200-400MB/s for 4k-16k.
> > 
> > IN THEORY, add_ra_bio_pages is supposed to be doing our own readahead
> > caching for compressed pages that we have read, so I think any overhead
> > we incur is not going to be making tons more IO. It will probably be in
> > that readahead caching or in some interaction with VFS readahead.
> 
> > However, I do see that in the 8k case, we are repeatedly calling
> > btrfs_readahead() while in the 128k case, we only call btrfs_readahead
> > ~2500 times, and the rest of the time we loop inside btrfs_readahead
> > calling btrfs_do_readpage.
> 
> Btw, I found the way add_ra_bio_pages in btrfs always a little
> odd.  The core readahead code provides a readahead_expand() that should
> do something similar, but more efficiently.  The difference is that it
> only works for actual readahead calls and not ->read_folio, but the
> latter is pretty much a last resort these days.
> 

Some more evidence that our add_ra_bio_pages is at least a big part of
where things are going slow:

stats from an 8K run:
$ sudo bpftrace readahead.bt
Attaching 4 probes...

@add_ra_delay_ms: 19450
@add_ra_delay_ns: 19450937640
@add_ra_delay_s: 19

@ra_sz_freq[8]: 81920
@ra_sz_hist:
[8, 16)            81920 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


stats from a 128K run:
$ sudo bpftrace readahead.bt
Attaching 4 probes...

@add_ra_delay_ms: 15
@add_ra_delay_ns: 15333301
@add_ra_delay_s: 0

@ra_sz_freq[512]: 1
@ra_sz_freq[256]: 1
@ra_sz_freq[128]: 2
@ra_sz_freq[1024]: 2559
@ra_sz_hist:
[128, 256)             2 |                                                    |
[256, 512)             1 |                                                    |
[512, 1K)              1 |                                                    |
[1K, 2K)            2559 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


so we are spending 19 seconds (vs 0) in add_ra_bio_pages and calling
btrfs_readahead() 81920 times with 8 pages vs 2559 times with 1024
pages.

The total time difference is ~30s on my setup, so there are still ~10
seconds unaccounted for in my analysis here, though.

> > I removed all the extent locking as an experiment, as it is not really
> > needed for safety in this single threaded test and did see an
> > improvement but not full parity between 8k and 128k for the compressed
> > file. I'll keep poking at the other sources of overhead in the builtin
> > readahead logic and in calling btrfs_readahead more looping inside it.
> > 
> > I'll keep trying that to see if I can get a full reproduction and try to
> > actually explain the difference.
> > 
> > If you are able to use some kind of tracing to see if these findings
> > hold on your system, I think that would be interesting.
> > 
> > Also, if someone more knowledgeable in how the generic readahead works
> > like Christoph could give me a hint to how to hack up the 8k case to
> > make fewer calls to btrfs_readahead, I think that could help bolster the
> > theory.
> 
> I'm not really a readahead expert, but I added who I suspect is (willy).
> But my guess is using readahead_expand is the right answer here, but
> another thing to look at might if the compressed extent handling in
> btrfs somehow messes up the read ahead window calculations.
> 

