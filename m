Return-Path: <linux-btrfs+bounces-14467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A25ACE64B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C0B3A9F15
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538521B8F6;
	Wed,  4 Jun 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TyK7CU44";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZYHDn0ff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8D1EB5DB
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073769; cv=none; b=mkF4mZFbSty/D6ZRrkMmuCCVhcsQDyREb+hHcYEkJA9hOhE+YiSVPQ5jf6vZ1nz+8XWdKt+kfyARSVgp8YFHNMJnDlX3yHp361T29H1bb5YUw+YJILz3P5XOv2gBJ/XgcC6S3CrGlJsrhtTai+RsvKDtCqqLT2o+gX3MoreqfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073769; c=relaxed/simple;
	bh=mekMGDuRDx9jLifqKkXA5EQ7SZSLXUy3GQty8bMN1OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia8y48UB2DnpF1PEUi2CEX/XsGlpf+20ITCPi00nNaFET+44sFZ6rEgKypeOe30fRY97VxUEDcgFttIXDCMEpBvAJNSDi/4dYMWCntLXxWo9xKHC73U4cibee2PbhC/0jb+nVIHsi4a5jH7vdtM9LCn01OqxI+iai+GfQ4rwAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TyK7CU44; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZYHDn0ff; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63CDB2540095;
	Wed,  4 Jun 2025 17:49:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 17:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749073765; x=1749160165; bh=20jwy8tfsT
	2JaWhppOK1Bjlkeratl8AwbWBL5NdTOtM=; b=TyK7CU44KV0iaX53N75wI4GTTE
	HXFUW5mzc3SplXbofVHIVEdDYrAx4yH05KscmFQdiv+bEevptpq/O6KEPrNGlE/3
	zo3fIV38TOhRPEctrtJ1mLwZNx5fgYheoERsLgeL1KiV7WrIjE7xxTddT/yXSps8
	c36ZkHqho35ubbG7Gxik+ADw3tYoqbVtFc+TH8D9nRqtZE5NKAVjPKD+mlvXGjYP
	nnJEaxan8g7zKhsH+6VRBsZRzhaRjFIuWudsWp/pSx1vkoIRoNPnBQ+lmWWL7GvZ
	Y5TAKnZcLKgTYqjyYafiCw8v8XPu5HQrdu0Vf/VnEQ/duwDogyMbiregJlfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749073765; x=1749160165; bh=20jwy8tfsT2JaWhppOK1Bjlkeratl8AwbWB
	L5NdTOtM=; b=ZYHDn0ff6Uf+WY7FiKla8e369wIgs8ye8NM9hqbgVEEC0noP2lK
	xxioqkQyZT07FCAI8riC7ZI8gW2Y6OkaeF1FgCwSndWLGGOPh/QBZhQKcCGCl5LP
	Kf/7chal7aK3pB+tLKKc2kcfyWQ+9iTCZEv1UqGWjqeqUrrdbijVLV0r2rdk/LYM
	pVpgXktn6O5Wu+z94/9VKZ8QYxFzouYJZG5netr2G39VikIJokOk5hLVJRw/cN9N
	z3qpKOdNrK9x/NaDkz79plECLDs7tGfl+MEVzTOWs6SthJafIybiu7ejciDzc18R
	oFzC1UH/hu8sI22VCCcO9CAFGZUQSIb35zw==
X-ME-Sender: <xms:ZL9AaNJ2uHX9CnF60bV8WByKXMJwwG9Dr000GyfPZInNuxooCxn4vA>
    <xme:ZL9AaJJf2cdOZ3B0ehA2n3qke5PF193hH5UBKqyi0d-K7jF5_s3YsGFnjKXETL7nx
    PO7HHvf4bSvGMaWy_M>
X-ME-Received: <xmr:ZL9AaFs1YxEa92usulWC87PQRwz81SK1dgVnd3IEHvzcWI2kvNwyYR7TI78mUBQQ0wkH6uH_jKVtKnUiXvgiFpbdDh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjedvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:ZL9AaObl9Ocd2rHDtei5Dg8KX5ws89IfQAlnpL-FuzLNsAufcKEa3Q>
    <xmx:ZL9AaEZLHmrCI85SAwNkYdyJDFYngfzboy3m-9ObmqM6b9T-nAF3TA>
    <xmx:ZL9AaCCN9f9DT5sW5fXfntgAqoIvyQxiDjdyqZrpFx3AQPdFQ5tyEA>
    <xmx:ZL9AaCZodeSbSCHaC8bnCwbEcRjw_ed5W5PfEq1nAfDXhKL1y4WpLw>
    <xmx:Zb9AaJRdBHjDVbct2oIGxElaYfZkB6wfbAFqbhPPcOcJ-0lH4yrxdxv8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 17:49:24 -0400 (EDT)
Date: Wed, 4 Jun 2025 14:49:19 -0700
From: Boris Burkov <boris@bur.io>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dimitrios Apostolou <jimis@gmx.net>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Anand Jain <anand.jain@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Sequential read(8K) from compressed files are very slow
Message-ID: <20250604214919.GA1123965@zen.localdomain>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
 <20250604013611.GA485082@zen.localdomain>
 <aD_mE1n1fmQ09klP@infradead.org>
 <20250604180303.GA978719@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604180303.GA978719@zen.localdomain>

On Wed, Jun 04, 2025 at 11:03:03AM -0700, Boris Burkov wrote:
> On Tue, Jun 03, 2025 at 11:22:11PM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 03, 2025 at 06:36:11PM -0700, Boris Burkov wrote:
> > > However, I do observe the huge delta between bs=8k and bs=128k for
> > > compressed which is interesting, even if I am doing something dumb and
> > > failing to reproduce the fast uncompressed reads.
> > > 
> > > I also observe that the performance rapidly drops off below bs=32k.
> > > Using the highly compressible file, I get 1.4GB/s with 128k, 64k, 32k
> > > and then 200-400MB/s for 4k-16k.
> > > 
> > > IN THEORY, add_ra_bio_pages is supposed to be doing our own readahead
> > > caching for compressed pages that we have read, so I think any overhead
> > > we incur is not going to be making tons more IO. It will probably be in
> > > that readahead caching or in some interaction with VFS readahead.
> > 
> > > However, I do see that in the 8k case, we are repeatedly calling
> > > btrfs_readahead() while in the 128k case, we only call btrfs_readahead
> > > ~2500 times, and the rest of the time we loop inside btrfs_readahead
> > > calling btrfs_do_readpage.
> > 
> > Btw, I found the way add_ra_bio_pages in btrfs always a little
> > odd.  The core readahead code provides a readahead_expand() that should
> > do something similar, but more efficiently.  The difference is that it
> > only works for actual readahead calls and not ->read_folio, but the
> > latter is pretty much a last resort these days.
> > 
> 
> Some more evidence that our add_ra_bio_pages is at least a big part of
> where things are going slow:
> 
> stats from an 8K run:
> $ sudo bpftrace readahead.bt
> Attaching 4 probes...
> 
> @add_ra_delay_ms: 19450
> @add_ra_delay_ns: 19450937640
> @add_ra_delay_s: 19
> 
> @ra_sz_freq[8]: 81920
> @ra_sz_hist:
> [8, 16)            81920 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> 
> stats from a 128K run:
> $ sudo bpftrace readahead.bt
> Attaching 4 probes...
> 
> @add_ra_delay_ms: 15
> @add_ra_delay_ns: 15333301
> @add_ra_delay_s: 0
> 
> @ra_sz_freq[512]: 1
> @ra_sz_freq[256]: 1
> @ra_sz_freq[128]: 2
> @ra_sz_freq[1024]: 2559
> @ra_sz_hist:
> [128, 256)             2 |                                                    |
> [256, 512)             1 |                                                    |
> [512, 1K)              1 |                                                    |
> [1K, 2K)            2559 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> 
> so we are spending 19 seconds (vs 0) in add_ra_bio_pages and calling
> btrfs_readahead() 81920 times with 8 pages vs 2559 times with 1024
> pages.
> 
> The total time difference is ~30s on my setup, so there are still ~10
> seconds unaccounted for in my analysis here, though.

This gets accounted in the generic vfs code, also presumably due to
inefficient readahead size.

> 
> > > I removed all the extent locking as an experiment, as it is not really
> > > needed for safety in this single threaded test and did see an
> > > improvement but not full parity between 8k and 128k for the compressed
> > > file. I'll keep poking at the other sources of overhead in the builtin
> > > readahead logic and in calling btrfs_readahead more looping inside it.
> > > 
> > > I'll keep trying that to see if I can get a full reproduction and try to
> > > actually explain the difference.
> > > 
> > > If you are able to use some kind of tracing to see if these findings
> > > hold on your system, I think that would be interesting.
> > > 
> > > Also, if someone more knowledgeable in how the generic readahead works
> > > like Christoph could give me a hint to how to hack up the 8k case to
> > > make fewer calls to btrfs_readahead, I think that could help bolster the
> > > theory.
> > 
> > I'm not really a readahead expert, but I added who I suspect is (willy).
> > But my guess is using readahead_expand is the right answer here, but
> > another thing to look at might if the compressed extent handling in
> > btrfs somehow messes up the read ahead window calculations.
> > 

So uhhh this braindead "stick it the first place it fits" patch:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c562b589876e..f77e3b849786 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2553,7 +2553,11 @@ void btrfs_readahead(struct readahead_control *rac)
 	lock_extents_for_read(inode, start, end, &cached_state);

 	while ((folio = readahead_folio(rac)) != NULL)
+	{
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
+		if (em_cached)
+			readahead_expand(rac, start, em_cached->ram_bytes);
+	}

 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);



unlocked the perf on the compressed 8k (and 4k) case without regressing
128k or bs=1M for a file with enormous extents. I get 1.4GB/s on both.
Still less on the incompressible file (though higher than without the
patch. 900MB/s vs 600MB/s)

I don't think this really perfectly makes sense for an actually proper
version, as readahead_folio() will advance the index and we will keep
"expanding" it to be the size of the compressed extent_map. On the other
hand, if it is stupid and it works, is it stupid?

Very promising... I'm going to study this API further and try to make
a real version. Very open to ideas/advice on how the API is best meant
to be used and if this result might be "cheating" in some way.

