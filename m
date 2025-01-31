Return-Path: <linux-btrfs+bounces-11196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71FAA23A46
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 08:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AE13A8223
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36995156F20;
	Fri, 31 Jan 2025 07:44:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EF4C9F;
	Fri, 31 Jan 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738309471; cv=none; b=guVI0DcrRdi1hH6d1nPOjV5/a6PYajMP/ysJ95ySkVQHw79Wv2foxosu89RHzIW/Jy3Um7Md7+GJ8PICpvqg2ulwDukazmfeNAnDoMFS/qLm9RHBR/hzmf6cu0VGxZv3rX+N76mh+Ktw4DIkCRFTnUh3zbPe3GJjy80mYRkbdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738309471; c=relaxed/simple;
	bh=6/f2vYS0ZVo+L+INYCAHpizNh4nrFmfTga4Vz8fdm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3HfTywpwdNRFlsJh2UBc59QgNISI77Lvz5Xsap7Ie+wbn28HxVpumeH1+d/GvGLxF2IMdBqAsObvQ+JePuKIxLjcbJh2g0lIbia8gOEYdRYiLVplwVfsJRTbEDkKqwM5wtG+lB5U7zyyzRuH0M7grm2yghj1EtOXf0EqsCw7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED57768B05; Fri, 31 Jan 2025 08:44:24 +0100 (CET)
Date: Fri, 31 Jan 2025 08:44:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
	dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250131074424.GA16182@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 30, 2025 at 03:21:45PM -0500, Martin K. Petersen wrote:
> So to me, it's a highly desirable feature that btrfs stores its
> checksums elsewhere on media.

Except for SSDs it generally doesn't - the fact that they are written
at the same time means there is a very high chance they will end up
on media together for traditional SSDs designs.  This might be different
when explicitly using some form of data placement scheme, and SSD
vendors might be able to place PI/metadata different under the hood
when using a big enough customer aks for it (they might not be very
happy about the request :)).


> But that's obviously a trade-off a user
> can make. In some cases media WAR may be more important than extending
> the protection envelope for the data, that's OK. I would suggest you
> look at using CRC32C given the intended 4KB block use case, though,
> because the 16-bit CRC isn't fantastic for large blocks.

One thing that I did implement for my XFS hack/prototype is the ability
to store a crc32c in the non-PI metadata support by nvme.  This allows
for low overhead data checksumming as you don't need a separate data
structure to track where the checksums for a data block are located and
doesn't require out of place writes.  It doesn't provide a reg tag
equivalent or device side checking of the guard tag unfortunately.

I never could come up with a good use of the app_tag for file systems,
so not wasting space for that is actually a good thing.

