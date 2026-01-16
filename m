Return-Path: <linux-btrfs+bounces-20637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE8D32FD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 16:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 035843041FF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBB3939D3;
	Fri, 16 Jan 2026 14:54:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341723D2B2
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575266; cv=none; b=XwLzF4KmEcyI8U8KRJ8hFe9wT/Lou0dl/G0malfAu5zS6ux6N+Zi14j3OZXiml5DJ36sRBWsT1lStNXNWbkzQzg2JBkIVOTwlb9/2LSDXh9/R1Pezpvi8+t5jOSuFrCiCk7rCpc9DGa/DJIoQyg2NKo7NPzivqnRvGTIwOkZBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575266; c=relaxed/simple;
	bh=5gdjzJIhoTx0MiHmZS7TMkjtOVOAiCHy7ZWU+96xY5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blgDi9AxhNIvtisReJ/EFH/tWfSe0fYMFqfnO/1+icUmU9qfGAJxipK6UvkTW0XmVReJd1uI3hE99rvrGP2w4X3guKkMlyd+8oXT/olOdBKN3Zm20aj06lCWgjm7W7y4xiGCBx0KxusqEjmzVZBjICQhZ9wwR0fvjGYVG2btyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B512227AAE; Fri, 16 Jan 2026 15:54:21 +0100 (CET)
Date: Fri, 16 Jan 2026 15:54:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional
 zones
Message-ID: <20260116145421.GC16842@lst.de>
References: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 16, 2026 at 10:57:36AM +0100, Johannes Thumshirn wrote:
> On a zoned filesystem allocate data block-groups only off of the
> sequential zones of a device.
> 
> Doing so will free up the conventional zones for the system and metadata
> block-groups, eventually removing the need for using the zoned allocator
> and all it's required infrastructure, that needs to be emulated, for
> conventional zones.
> 
> TODO: If the device does not have any sequential zones left, but
> conventional, allocate the data block-group from the conventional zone,
> or just ENOSPC?

How likely is that?  Given that amount of metadata btrfs has I'd be
more worried about the inverse: running out of conventional zones for
metadata.  Did you or anyone do a rough calculation of how much
metadata you need relative to the data for various scenarios (small
files, large files, lots of snapshots, etc)?

Keeping the pools entirely separate is of course much easier, but it
has to work out, and having allowed to combined them before might
have set expectations as well unfortunately.


