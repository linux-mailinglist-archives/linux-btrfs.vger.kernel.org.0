Return-Path: <linux-btrfs+bounces-10732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB3A01FD0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 08:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147001884E32
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC481D63D9;
	Mon,  6 Jan 2025 07:21:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596B19B5BE;
	Mon,  6 Jan 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736148090; cv=none; b=Qlq93Za0nYoLNTgQMLgRcW/WC/xMKt0pymtp2WS9Qzqol/Mi3gOMsFx8jiVFwOMqFwNHi7EKEdulCb7t68Ty77WUR7S2eDjNGthHcpm209dW1zoLNR5qNqEpj2cRHLazQLr2Aot4suVKwt2XnJbnAR7r7yv4uR1kezWyw7FzJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736148090; c=relaxed/simple;
	bh=YiWoBUG473FR9wE/FXe803n1WddUCgHImRz/5yzb0XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3CclSBzdDSVksNGFurUPLHXFDiLt2YLHZkc+hBMP94OEdXPurYpSOnSZsKMtqu6+rIEQFdhKh/+2UnidTvIRZoBUvxhnaJXQ4BzuoEHufF9I1swztY3iDiG02I6NOHffRpNvweu3fBnqXmcMcPJOdhqGlOlPpvK0THLOQqbj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E30868BFE; Mon,  6 Jan 2025 08:21:17 +0100 (CET)
Date: Mon, 6 Jan 2025 08:21:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Oliver Sang <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-btrfs@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20250106072116.GD16723@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de> <20241217045527.GA16091@lst.de> <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020> <20241217065614.GA19113@lst.de> <Z3ZhNYHKZPMpv8Cz@ryzen> <20250103064925.GB27984@lst.de> <Z3epOlVGDBqj72xC@ryzen>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3epOlVGDBqj72xC@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> One thing that came to mind.
> Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> the I/O scheduler to BFQ for single-queue HDDs.
> 
> It could very well be the I/O scheduler that reorders.
> 
> Oliver, which I/O scheduler are you using?
> $ cat /sys/block/sdb/queue/scheduler 
> none mq-deadline kyber [bfq]

I tried cfq as well and there is no reordering with our without various
file systems in the mix.  I've also tried forcing the rotational
attribute on and off just for an extra variation.


