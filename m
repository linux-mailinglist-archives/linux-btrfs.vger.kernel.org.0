Return-Path: <linux-btrfs+bounces-12942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B109A83909
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 08:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2188C3AFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 06:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953B2036F3;
	Thu, 10 Apr 2025 06:17:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575D2036E6
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265874; cv=none; b=rcxTXrxKcs8WvGakE1Y8l6VpmfHurymmF2WF5vjmRscnVYI3UIZCDxaha+6d/jpqYVGIv0P2Nm3oIczsfQ3ghg8338WhPFJKJ+k6GIqNPGeVgmQmlGXuyyctt2ZABHTE3TJtwYau5UgMJPO618IjT6/HuaFTOh2a2cXtPLiK7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265874; c=relaxed/simple;
	bh=CAuMaQGDBlXoDxa7as8Keny9vYekXtEuRAN1tQLPHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFGSLadLtamQJWHiaYqcNv3zh5tAhV3xzz/LvE5VUMbmu9F6deei1d4zEa/zhtPXgQEZLhnDL4UrmwQq12EaBJfRdlOB8eKbgcriA8ByCQVqQQ+AqYLNyu5AmGBDjQyhuEQBAra2YB3RMJJTxOEgYlgI1eH/4O68QWJcn/cxq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE06368BFE; Thu, 10 Apr 2025 08:17:48 +0200 (CEST)
Date: Thu, 10 Apr 2025 08:17:48 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, WenRuo Qu <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] btrfs: pass a physical address to
 btrfs_repair_io_failure
Message-ID: <20250410061748.GA31075@lst.de>
References: <20250409111055.3640328-1-hch@lst.de> <20250409111055.3640328-4-hch@lst.de> <02a4b8ab-6f70-4cd0-9ae5-27e219c38a67@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a4b8ab-6f70-4cd0-9ae5-27e219c38a67@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 06:06:08AM +0000, Johannes Thumshirn wrote:
> On 09.04.25 13:11, Christoph Hellwig wrote:
> >   	bio_init(&bio, smap.dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
> >   	bio.bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
> > -	ret = bio_add_folio(&bio, folio, length, folio_offset);
> > -	ASSERT(ret);
> > +	__bio_add_page(&bio, phys_to_page(paddr), length, offset_in_page(paddr));
> 
> Why are we going back to using a pages and __bio_add_page() here?

Because it is the most direct interface right now, bio_add_folio is
just a pointless wrapper.   I plan to add a bio_add_phys in a bit,
but don't want this to depend on it for now.

> Can we 
> lift phys_to_folio() from s390 into asm-generic/memory_model.h?

Yes, volunteers please.  Also we shouldn't depend on that for now.


