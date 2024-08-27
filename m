Return-Path: <linux-btrfs+bounces-7541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310D95FFAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 05:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28C4B21CF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E345028;
	Tue, 27 Aug 2024 03:20:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5313C08A;
	Tue, 27 Aug 2024 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728821; cv=none; b=r3BAyarsnHDFM4k9jTvjJMJkWNTNwOxhgoVnysnK1FL4FG5j81UJeFzKLEB+nVu7BzLXqcEymx2BGBGvc71N+ykxS7i1e9d4lihqDfnoiUvcvc3zhJJmm7+bL0JYG7Z4rcyh/Rhc3/mX8Ws4UXNqijYOqizTGgQ8Imfw9HJ8aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728821; c=relaxed/simple;
	bh=p6fipsd3x1Sw9wjZZGiJ8W3285c/MDM9/55CsKL6FqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HclY9fMm3BgV27jkffbuYKrPzqEb2MGjTdGNFv0BTLmWV7QtwqMvTvUyXIdXfmnjWMlSvEFMR0HpuKu1mk1y9hzlqyzmuYV7nrPn580cQhFPhQ4cRFpHCfNZFhptg3LN/G+QbS0l4GaK5yBPcIFrHedpixtrUhvod1qfaeCePN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECF43227AAA; Tue, 27 Aug 2024 05:20:12 +0200 (CEST)
Date: Tue, 27 Aug 2024 05:20:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] block: rework bio splitting
Message-ID: <20240827032012.GA9357@lst.de>
References: <20240826173820.1690925-1-hch@lst.de> <20240826173820.1690925-2-hch@lst.de> <e59de073-c608-4206-8f98-9f46b1750931@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e59de073-c608-4206-8f98-9f46b1750931@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 07:26:40AM +0900, Damien Le Moal wrote:
> > +static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
> 
> Why not "unsigned int" for split_sectors ? That would avoid the need for the
> first "if" of the function. Note that bio_split() also takes an int for the
> sector count and also checks for < 0 count with a BUG_ON(). We can clean that up
> too. BIOs sector count is unsigned int...

Because we need to handle the case where we do no want to submit any
bio and error out as well, and a negative error code works nicely
for that.  Note that the bios has an unsigned int byte count, so we
have the extra precision for the sign bit.

> But shouldn't this check be:
> 
> 	if (split_sectors >= bio_sectors(bio))
> 		return bio;

The  API is to return the split position or 0 if no split is needed.
That is needed because splits are usually done for limits singnificantly
smaller than what the bio could take.

> > +static inline struct bio *__bio_split_to_limits(struct bio *bio,
> > +		const struct queue_limits *lim, unsigned int *nr_segs)
> >  {
> >  	switch (bio_op(bio)) {
> > +	default:
> > +		if (bio_may_need_split(bio, lim))
> > +			return bio_split_rw(bio, lim, nr_segs);
> > +		*nr_segs = 1;
> > +		return bio;
> 
> Wouldn't it be safer to move the if check inside bio_split_rw(), so that here we
> can have:

The !bio_may_need_split case is the existing fast path optimization
without a function call that I wanted to keep because it made a
difference from some workloads that Jens was testing.

> And at the top of bio_split_rw() add:
> 
> 	if (!bio_may_need_split(bio, lim)) {
> 		*nr_segs = 1;
> 		return bio;
> 	}
> 
> so that bio_split_rw() always does the right thing ?

Note that bio_split_rw still always does the right thing, it'll just
do it a little slower than this fast path optimization.


