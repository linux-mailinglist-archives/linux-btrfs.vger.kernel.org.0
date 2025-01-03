Return-Path: <linux-btrfs+bounces-10697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B8A00486
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 07:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50F0162BBB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B001B4F3E;
	Fri,  3 Jan 2025 06:49:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3C18E3F;
	Fri,  3 Jan 2025 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886972; cv=none; b=I6xooidL7YDiwFZp/b8A0sSEfT+tl+lFuqEiJBkgbXxCjMSlK0ABggD6jkPUSAp8Fu+C9418xpRQ6lXsRxT5jXMZ2zBpkyEjpKy5gSASkJyrFonGtI+P/S8fR3ZmwKvmxoBECYcNDw/UXYJ82uRuDOZjIisQU4X8xpuNTzrZqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886972; c=relaxed/simple;
	bh=hlWHq0OMSTWoCnf+7Roi9teoijwZHWsV5MnA9LcUc0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZMHvlyWyp0iroB1cLwWWtro4WQj1huL6HrHgis2p4vQPRjoEk9Z5cXZjZJpn8PvlfsKJuWCqmxFK5KduVru2CDXlElbKej3WIMx1asg8Ld+8Tq35cSH25nHt94rV9xzmrin0kg+IFB7XihM4SlJ/h8HQhk1CcsJVwgymJn6MRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03BAE68BEB; Fri,  3 Jan 2025 07:49:26 +0100 (CET)
Date: Fri, 3 Jan 2025 07:49:25 +0100
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
Message-ID: <20250103064925.GB27984@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de> <20241217045527.GA16091@lst.de> <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020> <20241217065614.GA19113@lst.de> <Z3ZhNYHKZPMpv8Cz@ryzen>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3ZhNYHKZPMpv8Cz@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > from below information, it seems an 'ahci' to me. but since I have limited
> > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > please let us know. thanks a lot!
> > 
> > Yes, this looks like ahci.  Thanks a lot!
> 
> Did this ever get resolved?
> 
> I haven't seen a patch that seems to address this.
> 
> AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> reordering when issuing a batch of commands, my guess is that the problem
> also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> or block layer.

I started looking into this before the holidays.  blktrace shows perfectly
sequential writes without any reordering using ahci, directly on the
block device or using xfs and btrfs when using dd.  I also started
looking into what the test does and got as far as checking out the
stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
submission does simple reads and writes using increasing offsets.
So if the test result isn't a fluke either the aio code does some
weird reordering or btrfs does.

Oliver, did the test also show any interesting results on non-btrfs
setups?


