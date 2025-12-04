Return-Path: <linux-btrfs+bounces-19518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544FCA3265
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80F60300B8F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E139335574;
	Thu,  4 Dec 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jae/5bZt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F83093CE;
	Thu,  4 Dec 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842799; cv=none; b=LAoLpRwBWU53LJ/1cUwH6gdkwhEayEvGAqep2VPC5n6t1C5gXu6FTKHbIBbo8SuEOBjcmwkwInG8GCgEOulofDWYKzKrKhlQgCuh2gwG0ruDRKHpyLcd0iW5mhnc1ZzrKfuHncjzzvj27pbBQSGgK1n+IRfQL6dCHCVkozC+N8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842799; c=relaxed/simple;
	bh=3CbHWwvx1Y/+aUKlP/ABMg6jMDp3hgDvw2qY8W+kWAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzDNxkZhmFMR3I4/Tk6fsP26ivHVhmn9vUT+5vRwVfnHPP7522N1W1mZMxdAuRoG1KgHD/WD3pzCupQw2I9Dd9+pL8IwiJw8z6o5OURlt1VaLhLQCPDMaS1PGBFgnLSCIPlZ9Y1fKLZ67KId1/zXKp8Y/EyTgYyW3zORv9OVp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jae/5bZt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oTrYaefzNJqnzLYxcV+wzQAlxSf47/Xercf9bzlyWHI=; b=Jae/5bZtLTDGpMScrX7z6aYZVU
	JCn2/5Q0EA58u+M5RjNjdNuhpn5gey5Sbmq4prXWmOqhyouTYXh26mG2hCkdX8eupJiVEHDIaJ3dD
	OSQf34egNGB6CLomrhGhpu7W4XdDvXE0wJlxl7tjkUPuTVFQ9VZ55+hZzPDEt7bskqwiAABSmjpx9
	91mc0b6vST+ZR3+mJck/ymh2mFq4twIMvDRPwmKNCuiKZOWZVDiZ5ckO06YKM7SaherLxaiYYYg2K
	/RF49IDdkRNFDBEl928u8K/tBtpE3BKRKRKyIRDUZqQ5chpy9t14NeOQpJrkjuXfhvtpsr6HrxEBu
	ipeuB/2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6EN-00000007p0e-2Qoe;
	Thu, 04 Dec 2025 10:06:35 +0000
Date: Thu, 4 Dec 2025 02:06:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jani Partanen <jiipee@sotapeli.fi>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, clm@fb.com,
	dsterba@suse.com, terrelln@fb.com, herbert@gondor.apana.org.au,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
	weigang.li@intel.com, senozhatsky@chromium.org
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aTFdK1QU6Q-GPZe4@infradead.org>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aS6a_ae64D4MvBpW@infradead.org>
 <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
 <aS_f9axsi0QmmhiL@infradead.org>
 <9d7b182e-9da7-458f-b913-14eee415359d@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7b182e-9da7-458f-b913-14eee415359d@hogyros.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 03, 2025 at 07:47:11PM +0900, Simon Richter wrote:
> Unpacking is quite a bit faster as well, to the point where unpacking the
> compressed block of 4GiB NUL bytes is faster than reading 4 GiB from
> /dev/zero for me.

Which makes me wonder why Intel isn't showing decompression numbers.
For file system workloads those generally are more much common, and
they are generally synchronous while writes often or not, and
compressible ones should be even less so.

> For acomp, I pretty much always expect offloading to be worth the overhead
> if hardware is available, simply because working with bitstreams is awkward
> on any architecture that isn't specifically designed for it, and when an
> algorithm requires building a dictionary, gathering statistics and two-pass
> processing, that becomes even more visible.

I would be really surprised if it makes sense for just a few kilobyes,
e.g. a single compressible btrfs extent.  I'd love to see numbers
proving me wrong, though.

> For ahash/acrypt, there is a trade-off here, and where it is depends on CPU
> features, the overhead of offloading, the overhead of receiving the result,
> and how much of that overhead can be mitigated by submitting a batch of
> operations.
>
> For the latter, we also need a better submission interface that actually
> allows large batches, and submitters to use that.

For acrypt Eric has shown pretty devastating numbers for offloads.  Which
doesn't surprise me at all given how well modern CPUs handle the
low-level building blocks for cryptographic algorithms.

> As an example of interface pain points: ahash has synchronous import/export
> functions, and no way for the driver to indicate that the result buffer must
> be reachable by DMA as well, so even with a mailbox interface that allows me
> to submit operations with low overhead, I need to synthesize state readbacks
> into an auxiliary buffer and request an interrupt to be delivered after each
> "update" operation, simply so I can have the state available in case it is
> requested, while normally I would only generate an interrupt after an
> "export" or "final" operation is completed (and also rate-limit these).

Which brings me to my previous point:  ahash from the looks off it
just looks like a pretty horrible interface.  So someone really needs
to come up with an easy to use interface that covers to hardware and
software needs.  Note that on the software side offloading to multiple
other CPU core would be a natural fit and make it look a lot like an
async hardware offload.   You'd need to make it use the correct data
structures, e.g. bio_vecs provided for source and destination instead
of scatterlist, and clear definitions of addressability.  Bounce points
for supporting PCIe P2P transfers, which seems like a very natural fit
here.


