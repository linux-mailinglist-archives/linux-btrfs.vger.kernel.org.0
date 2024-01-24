Return-Path: <linux-btrfs+bounces-1675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3183A179
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 06:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB48F1F24A15
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B5F51C;
	Wed, 24 Jan 2024 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lok+F+da"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A7F501
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075030; cv=none; b=SqBJKYoWYFQI3NImLh0GSJp73dgoEwkKaHWSm0u3ARD8X+3AqzNN+QvzEnwK7B8qCQiyAmLRozagqPJCO5Gr0IJLB9FRj2FJZfGKhycJLjbYFc/K3myF1m7sE1cS0vySsXBkvwwUeJJOTNjv1t6hjR81qLywH/wYQG5cSb7Ga5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075030; c=relaxed/simple;
	bh=0GzBqCU5HwCXOLHJ0LQTKC5Q5yKXAb0S/8vyBpw3BCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5G636nSx/xSNnDFlVBk6fDRuN29i9tFaqOwdSu9T9rNyoIEjtooVcfQFGHXoDCW8bS+reaDgbmSy1kTtM2AYmtOR4uQ12cw6V4CZk5QSi7mF/PVvU+SJNdINGQrYUxtTPQv4bClheES/c7eq4O3GFdF8qoG8Y3ufRC2awaPhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lok+F+da; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nTzX0ljJVXQ+O0UX99CLGNwm7GzGUiVuz7AM8TsDxNk=; b=lok+F+daa3q9v83La6MUdJ/nOc
	hzI+A/DJNcIodVcDbnyRV/wTc7r4V0vA2wUdIFfC3KwJDRW7bbNJZwpehRRMHtljUj1p0v8suiNCt
	zmJxF3PJsxRkK1dJBYFr4JxefUXs6ImIJufGHjul1qqoRkvv9ZLIYOznp5x9zPyLJIIsFKhc2MaFh
	cpu7DhvmExwCeCQy8hh5Nq5D2iU5vYtWzlXCX8u1guVZON8d7BK4P2LVsFW/GUr+O6M8X+cV+Hdwh
	12JLYAtowIOe9PErdJd1v96MBMNynj1MLrqqIn8JctYTdM92GGrgsHFyAVqCBUFzR6xqup2nqPcFH
	7ZuvslLA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSW39-00000005Yax-0BJE;
	Wed, 24 Jan 2024 05:43:47 +0000
Date: Wed, 24 Jan 2024 05:43:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for
 multi-page sector size
Message-ID: <ZbCjkrOwaMyvhRD8@casper.infradead.org>
References: <cover.1706068026.git.wqu@suse.com>
 <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
 <ZbCWi98hWKnIW1zq@casper.infradead.org>
 <45066165-3d2d-4026-87d3-2cfe3369a86b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45066165-3d2d-4026-87d3-2cfe3369a86b@gmx.com>

On Wed, Jan 24, 2024 at 03:57:39PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/24 15:18, Matthew Wilcox wrote:
> > On Wed, Jan 24, 2024 at 02:33:22PM +1030, Qu Wenruo wrote:
> > > I'm pretty sure we would have some filesystems go utilizing larger folios to
> > > implement their multi-page block size support.
> > > 
> > > Thus in that case, can we have an interface change to make all folio
> > > versions of filemap_*() to accept a file offset instead of page index?
> > 
> > You're confused.  There's no change needed to the filemap API to support
> > large folios used by large block sizes.  Quite possibly more of btrfs
> > is confused, but it's really very simple.  index == pos / PAGE_SIZE.
> > That's all.  Even if you have a 64kB block size device on a 4kB PAGE_SIZE
> > machine.
> 
> Yes, I understand that filemap API is always working on PAGE_SHIFTed index.

OK, good.

> The concern is, (hopefully) with more fses going to utilized large
> folios, there would be two shifts.
> 
> One folio shift (ilog2(blocksize)), one PAGE_SHIFT for filemap interfaces.

Don't shift the file position by the folio_shift().  You want to support
large(r) folios _and_ large blocksizes at the same time.  ie 64kB might
be the block size, but all that would mean would be that folio_shift()
would be at least 16.  It might be 17, 18 or 21 (for a THP).

Filesystems already have to deal with different PAGE_SIZE, SECTOR_SIZE,
fsblock size and LBA size.  Folios aren't making things any worse here
(they're also not making anything better in this area, but I never
claimed they would).

btrfs is slightly unusual in that it defined PAGE_SIZE and fsblock size
to be the same (and then had to deal with the consequences of arm64/x86
interoperability later).  But most filesystems have pretty good separation
of the four concepts.

