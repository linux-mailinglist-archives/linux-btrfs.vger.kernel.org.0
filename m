Return-Path: <linux-btrfs+bounces-14439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB2ACD7CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA410173D80
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8DB26156F;
	Wed,  4 Jun 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKuZGh1G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB422224CC
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749018135; cv=none; b=JEAI2dUJ0zwL2NSN/waIgZNFUipp0fTUjJAR4ZhM0SrYXUTpK8tDE5O5q/QSXZZhGFKUCsl1IrAPqXoMClvlIGi4QhMzBh9duiIqdwaWx8r16o32sWiXcPS4y70cUiS6j/yx39MnYaL0lv/cPMb7fqYLgcwymlksf1zbT03TQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749018135; c=relaxed/simple;
	bh=mwMTcdTVUo9nIc3A2k3aUY3sFP7jGaPz0Vfs2ZHOSu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK7n+180rwubTvaahYHY5a+E4rgMwP4xLlmdjjyIVhx1VwYVU/JJXF3jK1VMWFHi0lGn/+qY7AYWydRrvnNaPgVqpi8CDO67HoD3HvG1OBYrqALnYR+R7l5zsy1umydmc/R16fjL4svML9BbRRQ6OBL5e3A31NqSEVtANoJI+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FKuZGh1G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OqQljQsmioxx3Qznt8rBvxDZNU9CuAIW1MUa2GDgupw=; b=FKuZGh1GQlOsHb4i+vkS2tt+/L
	ZKRBHHudB5HhQAuCoVkt3ziaqsiFFD9RfZ2H1J3GjRGKPjAYCJdXaBQvSRaF0WxIfRV0ga9ITW8+B
	lOdCvZrhLrRYw71fdvCMd3nlDoN9ePnCwyP9OiADNSrkTIsHq1845nuuRXB+RwEYTDL1/5jpvMkA0
	DSDf50/b3w0GgNXSz73/IA+Qnugtr+yymGJyW99EQR4pGEWZRBIav9Xo8nIXRPWGJ77NA3a6rTjwb
	VsGDD/0j68o0VtBkSm0Cix2xzPgTbEa/BFzlvnkVfuR3nSfbrVUPALJj2OCjGnFJdxdJW9/4wTdKd
	lJWbFXHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMhVr-0000000CfoT-2HgV;
	Wed, 04 Jun 2025 06:22:11 +0000
Date: Tue, 3 Jun 2025 23:22:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: Dimitrios Apostolou <jimis@gmx.net>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Anand Jain <anand.jain@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Sequential read(8K) from compressed files are very slow
Message-ID: <aD_mE1n1fmQ09klP@infradead.org>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
 <20250604013611.GA485082@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604013611.GA485082@zen.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 06:36:11PM -0700, Boris Burkov wrote:
> However, I do observe the huge delta between bs=8k and bs=128k for
> compressed which is interesting, even if I am doing something dumb and
> failing to reproduce the fast uncompressed reads.
> 
> I also observe that the performance rapidly drops off below bs=32k.
> Using the highly compressible file, I get 1.4GB/s with 128k, 64k, 32k
> and then 200-400MB/s for 4k-16k.
> 
> IN THEORY, add_ra_bio_pages is supposed to be doing our own readahead
> caching for compressed pages that we have read, so I think any overhead
> we incur is not going to be making tons more IO. It will probably be in
> that readahead caching or in some interaction with VFS readahead.

> However, I do see that in the 8k case, we are repeatedly calling
> btrfs_readahead() while in the 128k case, we only call btrfs_readahead
> ~2500 times, and the rest of the time we loop inside btrfs_readahead
> calling btrfs_do_readpage.

Btw, I found the way add_ra_bio_pages in btrfs always a little
odd.  The core readahead code provides a readahead_expand() that should
do something similar, but more efficiently.  The difference is that it
only works for actual readahead calls and not ->read_folio, but the
latter is pretty much a last resort these days.

> I removed all the extent locking as an experiment, as it is not really
> needed for safety in this single threaded test and did see an
> improvement but not full parity between 8k and 128k for the compressed
> file. I'll keep poking at the other sources of overhead in the builtin
> readahead logic and in calling btrfs_readahead more looping inside it.
> 
> I'll keep trying that to see if I can get a full reproduction and try to
> actually explain the difference.
> 
> If you are able to use some kind of tracing to see if these findings
> hold on your system, I think that would be interesting.
> 
> Also, if someone more knowledgeable in how the generic readahead works
> like Christoph could give me a hint to how to hack up the 8k case to
> make fewer calls to btrfs_readahead, I think that could help bolster the
> theory.

I'm not really a readahead expert, but I added who I suspect is (willy).
But my guess is using readahead_expand is the right answer here, but
another thing to look at might if the compressed extent handling in
btrfs somehow messes up the read ahead window calculations.


