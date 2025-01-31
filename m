Return-Path: <linux-btrfs+bounces-11200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12170A23C6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 11:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D63166E37
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932D1B422D;
	Fri, 31 Jan 2025 10:43:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4311779B8;
	Fri, 31 Jan 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320188; cv=none; b=DI3hqOKHtb+umj6xcwPB277oFFbI3Pg/vp0DxFMWkrrPgCsw4NyOq+GhlOfVh6yirttbSzZMTOFHy+t/8DXhEW0PFGrQvOZL2R75YRJct69Hn3s56O2aKY6XPM5ube+yVv2NFdYexTrbR+jmT0q/hkovxsYDzsuXgUgc/TqGWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320188; c=relaxed/simple;
	bh=7YuYotA467XIRFTLLAiDaaEj24Zkk+sK4MQQJdS41WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZGNWCkE8DX0eRFA0waWslfrbfWiwJFiGGr5KDDhkkIFDVW5R273I6Gsf374DtFJkHQBbppBWUoUoLOBvjT3xPi4VOouU80H6gQrdhTrK/nByPgVLVSA7yQB3BS6/PM5KBWPQnmiOz6gDpGlxIgawApaGHkGWzvIE7g/gZpb3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 557D568C4E; Fri, 31 Jan 2025 11:43:00 +0100 (CET)
Date: Fri, 31 Jan 2025 11:42:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com, dsterba@suse.com,
	clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250131104259.GA20153@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de> <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com> <20250130125306.GA19390@lst.de> <12ee6895-aafe-491e-8dea-c024a2a34563@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ee6895-aafe-491e-8dea-c024a2a34563@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 31, 2025 at 03:59:17PM +0530, Kanchan Joshi wrote:
> > Also if you trust the device to get things right you do not
> > need to use PI at all - SSDs or hard drives that support PI generally
> > use PI internally anyway, and PRACT just means you treat a format
> > with PI like one without.  In other words - no need for an offload
> > here, you might as well just trust the device if you're not doing
> > end to end protection.
> 
> Agree that device maybe implementing internal E2E, but that's not a 
> contract to be honored. Host can't trust until device says it explicitly.

But you're not doing end to end protection.  Once you set PRACT you
basically tell the device to pretend the LU/namespace was formatted
without protection information.  That fact that you even need the
flag has always been very confusing to me - the logical way to expose
PI would have been to make PRACT the default and require a flag to
actually look at the passed information.  I suspect for SCSI this
is a result of shoe-horning DIF and DIX into existing infrastructure,
and NVMe then blindly copied much of that without thinking how it
fits into an architecture without a separate HBA and without all
the legacy concerns.


