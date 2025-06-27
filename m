Return-Path: <linux-btrfs+bounces-15044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00562AEB6A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E147AD163
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4C29B218;
	Fri, 27 Jun 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tdNVTeK6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47021129E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024337; cv=none; b=p2neiwWPaYQpwPZ/a+81GgKsCFtMdiCV5EVkddNyHLjE5PtT+KDyWKoY2HwuqsPLc/VSkqjk/pB4jlKkE5AuqzMKORs/sr/peoKRnXCvXURPqYehmY6V2uh6qcZJyGpzllhTk5YAfYr2e/DHcWgfhFuf2g0Hb12/HwZOFJ7DrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024337; c=relaxed/simple;
	bh=UIHr+rng7rm2FAkIxDAoKALNuIt4fVGxQBfZB316NgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbcZNgIhfziEeFPNQagRhoePegjmB5420EJeVVv1DaCVWN+StAWf2OkzYzNyvj52cSd0hUGhd+fvVUQh/p68UPhtqsakO4NrK/s2h3LfbHBKRcn28xoC7H4Boqfj6O8pPePBbDXQwSOkJSpz49iEEBShm5E40Q6pl+KCkrNkPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tdNVTeK6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Otp5Vr66bTcbZ1dSVSNZlpvm34Z7rJMSmb1Is2tDzro=; b=tdNVTeK6saHbf9fOfLExJKNB3O
	T1STraPas0elqS9CGRHFSGdOeEa3emHyB+5cpfmDZ6CnEsGsePDiB6qP/4mlglszOYhtDSYb0FxuS
	sUX8P8yVYh25fZasOqv3XWXq0pMsWK6VhmBD+Px3V4c7JfWmxhy6w0Xp9Bor8DR8lIh6ExsmM5P/+
	JTOBvXz0u5yDN5qxRTvGME+k3jNavReLYtVo54CNd3WXmAae7OxqQGJrJCGJ5wvOrFJUcAV74ZnTN
	v68b+n6SLgf8HtQt3JBc5m1vDRQf+dAhce4l8H3SaqBWFuZzI9MzMImZ0n4EoR38eOB4HRRht56LU
	5ZdMjFzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV7Px-0000000EWAu-45O1;
	Fri, 27 Jun 2025 11:38:53 +0000
Date: Fri, 27 Jun 2025 04:38:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC 9/9] btrfs: remove unused bgs on allocation failure
Message-ID: <aF6CzXUlUNE5ruWH@infradead.org>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-10-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627091914.100715-10-jth@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 27, 2025 at 11:19:14AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> In case find_free_extent() return ENOSPC, check if there are block-groups
> in the filsystem which have been marked as 'unused' and if so, reclaim the
> space occupied by these block-groups.
> 
> Restart the search for free space to place the extent afterwards.
> 
> In case the allocation is targeted for the data relocation root, skip this
> step, as it can cause deadlocks between block group deletion and relocation.

Assuming an unused BG is one without space in it that just needs a zone
reset or discard (a quick look at the code seems to confirm that, but
with some extra caveats):  why don't you reclaim it ASAP once it becomes
unused, at least modulo those space reservation caveats (which I don't
understand from that quick look).


