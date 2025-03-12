Return-Path: <linux-btrfs+bounces-12222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47513A5D6C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 08:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A0C3B1AE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 07:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE018FC75;
	Wed, 12 Mar 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iD11eW9b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CAC13B;
	Wed, 12 Mar 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762845; cv=none; b=sH0Dkh8Exf0fXmBBgQct062p9F/2AWivL5NJkzMAaQKcuRpeSHu6rzbk+e3bVIcukap6euSrDmG9sWrSALgK//R7ndbBfMAUIIBOF4YToE/Cj85sFNdK+nID/ULNSNb9znIe8IneurZ2saTAjgGA+X6qz11AB7lKrHUHZGrBIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762845; c=relaxed/simple;
	bh=su2B5gzY9Z7kOS717Qnj99cM8hMF0RUtVfOQ53+COi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0dC+Zbs6oExfJDxcl/wFJIwNigGmbPqpKrh6uVc0ROhQQ5nw0p0fPBtf4gdNfXyT1XkM43X0kZL6+Im3s/N+jnQLJ+nkWZJH2SuxS2M4vydmGwmuM/osTIhmQKmg5/pkiRZ4F/6irZovjDAT+WxI7wIV6WLV7MWFgCw78P1veU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iD11eW9b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zkGx+vxu3+dGmy4JcqhI7enK6vrKixVtFZ68atCxLxY=; b=iD11eW9bfeLcptt+UFc8Lbj1gG
	AYy82kY1431SBHaCP2K4dab6IbN98i5s4s3ix1x7sj5aG8AhGeO+XDw/fBSfJBKfKFqsgoe623omQ
	1RkG7g4A/vHUK2o0apCTaA0Ell8PyGBoeIrmDFnmHmEFT8heW6HtveUo2wpBv0SOX7WJiUxf7beqm
	Pab+DO4yzMGZ6xntMSNd7htiU3xw1IYEtYHZRes8Kc9zV4Kf2dVyilZRndsHlO+X7qh8Kmc8zuxec
	7iJgWQ5sWwDkcBb+/P+iRA3ypEsRqvZygDUARBaK0KWGesjdVSpRTDnkcdPi5GWus5mvLBtx6A8aF
	fzw3aK3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsG54-00000007eZg-0Qn3;
	Wed, 12 Mar 2025 07:00:42 +0000
Date: Wed, 12 Mar 2025 00:00:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: introduce zone capacity helper
Message-ID: <Z9ExGqwUZWu3oHVR@infradead.org>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
 <Z9EbSZh-OtLGttoB@infradead.org>
 <dfa516c7-2a4f-45c5-a184-0b0e64336c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa516c7-2a4f-45c5-a184-0b0e64336c38@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 03:55:31PM +0900, Damien Le Moal wrote:
> On 3/12/25 14:27, Christoph Hellwig wrote:
> > On Wed, Mar 12, 2025 at 10:31:03AM +0900, Naohiro Aota wrote:
> >> +#ifdef CONFIG_BLK_DEV_ZONED
> >> +static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)
> > 
> > Overly long line.
> > 
> >> +{
> >> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
> >> +
> >> +	if (pos + zone_sectors >= get_capacity(disk))
> >> +		return disk->last_zone_capacity;
> >> +	return disk->zone_capacity;
> > 
> > But I also don't understand how pos plays in here.  Maybe add a
> > kerneldoc comment describing what the function is supposed to do?
> 
> The last zone can be smaller than all other zones, hence we have
> disk->zone_capacity and disk->last_zone_capacity. Pos is a sector used to
> indicate the zone for which you want the capacity.
> 
> But yes, agreed, a kernel doc would be nice to clarify that.

Should it be zoned_start then to make that obvious?


