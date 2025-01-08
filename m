Return-Path: <linux-btrfs+bounces-10790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C1A05851
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269D1167E30
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9081F8698;
	Wed,  8 Jan 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvOE7pRE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AD38F82;
	Wed,  8 Jan 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332774; cv=none; b=AuxclAxGTnqan6KMGk7NG8SiOwo+suALXPRFGx1/5ITsder+SLNTFhG1+hkfDbR/jEQXPWtrmx9dL+WUUNDNYBVa342h7ciRB40ndntTvb5f6RgccvZnJif544ipstH+sLvnzeyIsabODmmOKRRe0KXhVraFjnjDK55VXQNSOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332774; c=relaxed/simple;
	bh=wWO6nKxlaHTQ6vNc0Fh7xbXckRbHyUTC/A+5O8lcDs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR8MbnbJYcvpfrB6ec6HR3MhZMuSGFVlTp0g40nA5h0eH0YE+vyGI4VUoPvof2AHRUuBBPZHK+gvA3fdcTN4T1T/eX8PXVeJ+9dAdJM2EMCM4KaM1XBaXU/wIzOA6LMujHtpsiK2QB3n2QnzDBrNkzRA+1NY0FnBfx3QZh27utQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvOE7pRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C209FC4CEDF;
	Wed,  8 Jan 2025 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736332773;
	bh=wWO6nKxlaHTQ6vNc0Fh7xbXckRbHyUTC/A+5O8lcDs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvOE7pREw2XNT2FOLTj9XPsqmdUeDCjXbEwyNhfEKPa7cxVIO69gpfrMyzn35bcNj
	 iMJzQvYfKm382us4awXbrEM/hNYmEI2kU9LmXnB45a24U4ZNqSS81qrpyoY9+0cEmL
	 KBQTxCUgaAWuU8YY5mKpXW7a2dOw0w93XLnr8MiWLQCV4//I1omUR1lbpBdvMpvCoH
	 lJr2Eo6tE9UM7t07kb8xvCs0q1KaRAzicyugQE0QlBSJ34BBMoWrOe8jenbsiu+Zgv
	 18H1f1QFusrNdKMR0ldDqAUoMNCwVawZaNxftCXhzc1N4S6yPunX+b9YQZvLaFYSud
	 TeOhkvgOJhi5w==
Date: Wed, 8 Jan 2025 11:39:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z35VVvuT0nl0iDfd@ryzen>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>

On Tue, Jan 07, 2025 at 04:27:44PM +0800, Oliver Sang wrote:
> hi, Niklas,
> 
> On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> > On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> > > On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > > > please let us know. thanks a lot!
> > > > > 
> > > > > Yes, this looks like ahci.  Thanks a lot!
> > > > 
> > > > Did this ever get resolved?
> > > > 
> > > > I haven't seen a patch that seems to address this.
> > > > 
> > > > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > > > reordering when issuing a batch of commands, my guess is that the problem
> > > > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > > > or block layer.
> > > 
> > > I started looking into this before the holidays.  blktrace shows perfectly
> > > sequential writes without any reordering using ahci, directly on the
> > > block device or using xfs and btrfs when using dd.  I also started
> > > looking into what the test does and got as far as checking out the
> > > stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> > > submission does simple reads and writes using increasing offsets.
> > > So if the test result isn't a fluke either the aio code does some
> > > weird reordering or btrfs does.
> > > 
> > > Oliver, did the test also show any interesting results on non-btrfs
> > > setups?
> > > 
> > 
> > One thing that came to mind.
> > Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> > the I/O scheduler to BFQ for single-queue HDDs.
> > 
> > It could very well be the I/O scheduler that reorders.
> > 
> > Oliver, which I/O scheduler are you using?
> > $ cat /sys/block/sdb/queue/scheduler 
> > none mq-deadline kyber [bfq]
> 
> while our test running:
> 
> # cat /sys/block/sdb/queue/scheduler
> none [mq-deadline] kyber bfq

The stddev numbers you showed is all over the place, so are we certain
if this is a regression caused by commit e70c301faece ("block:
don't reorder requests in blk_add_rq_to_plug") ?

Do you know if the stddev has such big variation for this test even before
the commit?


If it is not too much to ask... It might be interesting to know if we see
a regression when comparing before/after e70c301faece with scheduler none
instead of mq-deadline.


Kind regards,
Niklas

