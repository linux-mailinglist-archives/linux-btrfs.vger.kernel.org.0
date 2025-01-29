Return-Path: <linux-btrfs+bounces-11152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B5A22094
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93AB163010
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02411DE2BB;
	Wed, 29 Jan 2025 15:40:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B511DD0C7;
	Wed, 29 Jan 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165233; cv=none; b=pEBSyhB6hN20uIZAZQZrwphLLmuGfXVa0Knqg1alOHKIuAQDy8wJ4umr6ddvc4Ab3XMDqlSLwQNw42AS0t6J9sBcbC/Kf7M9rBvykr8Vk/TtLslFQKZt1HiXUSni+5aeMjH4nyiW/BZBTeRGlr3NuMHaoTGTnHqcUg92IG6NFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165233; c=relaxed/simple;
	bh=tkf3QIGgciMySXCGUzbpp3yEbFSgiAHK9R+8XSp0bP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Carqrv3NkIO6RbJDpti2CDW0dEXTrfi60RSg/Rbpk9xXqlDiY4RFaL14PqIre4DoNIrKQz07WTcIaAAlfubkgk+BoV0hI1/5vrr6knErCEtsiH37MQAtv9EauTK1PwNcDmZVd03we4YzG1pdUvck466SBBQ8EgxsGFQxEdyUxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E53E268D07; Wed, 29 Jan 2025 16:40:25 +0100 (CET)
Date: Wed, 29 Jan 2025 16:40:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
	dsterba@suse.com, clm@fb.com, axboe@kernel.dk, hch@lst.de,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250129154025.GA7047@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <Z5pJGHAR7AWCC0T4@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5pJGHAR7AWCC0T4@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 08:28:24AM -0700, Keith Busch wrote:
> On Wed, Jan 29, 2025 at 07:32:04PM +0530, Kanchan Joshi wrote:
> > There is value in avoiding Copy-on-write (COW) checksum tree on
> > a device that can anyway store checksums inline (as part of PI).
> > This would eliminate extra checksum writes/reads, making I/O
> > more CPU-efficient.
> 
> Another potential benefit: if the device does the checksum, then I think
> btrfs could avoid the stable page writeback overhead and let the
> contents be changable all the way until it goes out on the wire.

If the device generates the checksum (aka DIF insert) that problem goes
away.  But we also lose integrity protection over the wire, which would
be unfortunate.

If you feed the checksum / guard tag from the kernel we still have the
same problem.  A while ago I did a prototype where we'd bubble up to the
fs that we had guard tag error vs just the non-specific "protection
error" and the file system would then retry after copying.  This was
pretty sketchy as the error handling blew up frequently and at least my
version would only work for synchronous I/O and not with aio / io_uring
due to the missing MM context.  But if someone has enough spare cycles
that could be something interesting to look into again.

