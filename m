Return-Path: <linux-btrfs+bounces-11900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29917A47893
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 10:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B684D7A410C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23550227EA8;
	Thu, 27 Feb 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLspYqEw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BA22576C;
	Thu, 27 Feb 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646985; cv=none; b=SXR8cJvgeK28GNoIUbBSC2CPnlCrYcK/9dVqrQpjDaOGIlyGtuwOtFQzhJipfNsUeKFa/BIMsHrA1G2R803n1cQaxQVYJz9d+QJehmR/Yf+HaVqdBnH8oJyFsNBBR3+r4BDXyug7fcHXuRTj/6ijAVIDeeyMWCfqhxBC2jokAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646985; c=relaxed/simple;
	bh=NVCpCk+nbSUsNJ/EU7EEuGOPqCNbb7okhZbn+Sil+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiKcbViOayNAePsy0pUklxZwqZAKz5ZhJDjiW/QdW5lHGaxT+Vo5tfm0VqNhLPVFOMwAeAQi6wKqh5GEy+E3dflZVAGVaC6KcIWdzpA9FRLlTu4DM+sBdi+mk0OWcEJ+q7823JMaOAgky+oPyeIZyWfWStoybPumk/gacdR9Byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLspYqEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7E3C4CEDD;
	Thu, 27 Feb 2025 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740646984;
	bh=NVCpCk+nbSUsNJ/EU7EEuGOPqCNbb7okhZbn+Sil+6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLspYqEw609cIT0ad0o594ZSe9+944oOqgtsX4PvzoyBCh2CjxvcaZKHcRlfZbkg3
	 o98sgutNPNtNQvtB1V2TWfdkxk0jvPKNau6dHa8OKjnpZRzHC9C6ErL5o2r0XNXfYe
	 ynD51HJPuofVM3zovm3pWhAZDAaeGPoIRj6tCVyu8o4t7sFTQlvipwFQwyRdAzsR2d
	 B6voWJuIrlI+Cf1lPSYN2ZjYhqS7rvygaip7lyyFeeh6HBrO8Q/DpezIvl2iQUtyVl
	 OXwKmfMuglQQ5kuzM1Q6kxE36HyfrIokC3I3woeNs2DsuZou71wXc13B0RkvyLg9Ys
	 NykE1mhZbbdJQ==
Date: Thu, 27 Feb 2025 10:02:45 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, Yaron Avizrat <yaron.avizrat@intel.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, James Smart <james.smart@broadcom.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 00/16] Converge on using secs_to_jiffies() part two
Message-ID: <3apo7evpkvcy5mafw7zdatr3n7lytugvfmumq2zou4nifyptnc@ucbu4c5g5jrq>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
 <hJl1qb89zCHWejINoRSGGIO0m7NNi3wAmY9N_VC7royLnZoyL-ZozLkmLO-vCPlYc55-IPh76PIB_2_aKKjp1A==@protonmail.internalid>
 <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>

On Wed, Feb 26, 2025 at 12:38:51PM -0800, Andrew Morton wrote:
> On Wed, 26 Feb 2025 11:29:53 +0000 Mark Brown <broonie@kernel.org> wrote:
> 
> > On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> > > This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> > > either use the multiply pattern of either of:
> > > - msecs_to_jiffies(N*1000) or
> > > - msecs_to_jiffies(N*MSEC_PER_SEC)
> > >
> > > where N is a constant or an expression, to avoid the multiplication.
> >
> > Please don't combine patches for multiple subsystems into a single
> > series if there's no dependencies between them, it just creates
> > confusion about how things get merged, problems for tooling and makes
> > everything more noisy.  It's best to split things up per subsystem in
> > that case.
> 
> I asked for this.  I'll merge everything, spend a few weeks gathering
> up maintainer acks.  Anything which a subsystem maintainer merges will
> be reported by Stephen and I'll drop that particular patch.

I'm removing this from my queue then and let it go through your tree.
Cheers,

Carlos

> 
> This way, nothing gets lost.  I take this approach often and it works.
> 
> If these were sent as a bunch of individual patches then it would be up
> to the sender to keep track of what has been merged and what hasn't.
> That person will be resending some stragglers many times.  Until they
> give up and some patches get permanently lost.
> 
> Scale all that across many senders and the whole process becomes costly
> and unreliable.  Whereas centralizing it on akpm is more efficient,
> more reliable, more scalable, lower latency and less frustrating for
> senders.
> 

