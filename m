Return-Path: <linux-btrfs+bounces-10699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9DA00682
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 10:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5393C1884351
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A31D54F7;
	Fri,  3 Jan 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOPpH7Z1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367181D4610;
	Fri,  3 Jan 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895360; cv=none; b=UlWDeMzUrG8ROmARTx0gHq7HHy/Y12zRAxFcv4x8QQmeNpVppcIqsOQXP0BnKVEKWjDZeTmTx930ruS6N2zNM48HH6BJfIXq9VqxoDtLq0qSesCP7AMiwFu7DzZwGZKnM0s1LMFrL+0XUUS+DYA6qvyg38cOmcEmEmJDhVgepBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895360; c=relaxed/simple;
	bh=EV+hiXpMnVwPGQUO7JrQyTZCFrVUBDW19vmgMtQRWGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyG5dDRmR1dCRCqvAwVGpvgCWVw5yh835bv0ahlbnUg7sfLTICHQ4hk/MozQhXJ9wDJu4SuLVI+NEf9d857GWUaAw1urT7cA/WrlhNFSSVhd163kZce/jja02DmIHqa8DUH6ARROxTviKC0EyOS3pgsrkw4Uze+JYfjRTpLaKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOPpH7Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27344C4CECE;
	Fri,  3 Jan 2025 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735895359;
	bh=EV+hiXpMnVwPGQUO7JrQyTZCFrVUBDW19vmgMtQRWGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOPpH7Z1DWY+qC+ZswNYpEj1NogUVt18Le5PmNjKRycWQMWFCXz5ZLu/ps6JGuouv
	 YSRXpSielIWAG4ix5MM9Ly/Bue7AivSVToUq8B4/BO/uVX4jr/jg4rg3eP+2SNDEUL
	 44mc7IJ9OfPI5JQsikHpGMEibSRHvEs/rBPlE6w4zebF34+H49VhgEMNJjevnkXpJq
	 sF6JIRKKHop6Iz5soaFjfVKtPAMAu5fFp6/IasYWTFyXhJZ30e4piw20lSDqRQdUJL
	 zy3JPS0vSxCPQDWkerdOHwvXMT5v7NOsqhiTJW/U4huW6LtT4kQBvtn0daaSZ8Ix0R
	 1x37gPSi3R4Kw==
Date: Fri, 3 Jan 2025 10:09:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-btrfs@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z3epOlVGDBqj72xC@ryzen>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103064925.GB27984@lst.de>

On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > please let us know. thanks a lot!
> > > 
> > > Yes, this looks like ahci.  Thanks a lot!
> > 
> > Did this ever get resolved?
> > 
> > I haven't seen a patch that seems to address this.
> > 
> > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > reordering when issuing a batch of commands, my guess is that the problem
> > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > or block layer.
> 
> I started looking into this before the holidays.  blktrace shows perfectly
> sequential writes without any reordering using ahci, directly on the
> block device or using xfs and btrfs when using dd.  I also started
> looking into what the test does and got as far as checking out the
> stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> submission does simple reads and writes using increasing offsets.
> So if the test result isn't a fluke either the aio code does some
> weird reordering or btrfs does.
> 
> Oliver, did the test also show any interesting results on non-btrfs
> setups?
> 

One thing that came to mind.
Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
the I/O scheduler to BFQ for single-queue HDDs.

It could very well be the I/O scheduler that reorders.

Oliver, which I/O scheduler are you using?
$ cat /sys/block/sdb/queue/scheduler 
none mq-deadline kyber [bfq]


Kind regards,
Niklas

