Return-Path: <linux-btrfs+bounces-11138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF26A21DA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D413A368B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117B145B14;
	Wed, 29 Jan 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxBm5goJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E82CA9;
	Wed, 29 Jan 2025 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156389; cv=none; b=PyFzC6kJ0jFowwD0nfgvsJ7ZZYxmaOnstxAaMY7iyEboxMcQuTEAv9FOOTgaL3DqsiTonJ4J77pZa1hEjrBVvFJUfnpWJTjXWdqYRGALTgduEE5c85PDYxd/CoFojB03+0NNsqD97xzar5ptK2/oIZbc+QhIXqQEOXwsEBMOdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156389; c=relaxed/simple;
	bh=uWLMAkjiPxmd0IZ1cdFsHKZZFguDfleylm6v197BRzQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ARMhNx1n9bES05kDWAepJ5y3q8rZYyi8p/4J8ZHrvQvT0EdpWvQfAQH1xqZo/87qDwRYT59eiSHTwVf7gcz2QxCNsu5Z7DxUThGsGNhsbMgLX+mswDSCUesSq1KyMaBY1fxIWD4dnZ7o/k0De5FAp3xhlzu4Ob1ycJU+VBKCveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxBm5goJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738156388; x=1769692388;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uWLMAkjiPxmd0IZ1cdFsHKZZFguDfleylm6v197BRzQ=;
  b=SxBm5goJ+drv5/j21Nr5L4bB4AiKSLqdl2lYsm1T+xntrZBkeN0w8M1G
   F4+NyhAgrsl+fxFpq7CVKVv5bZ5TG8R2r9ALR7mZHn8ifAxDjViTWF9n2
   Qfeq1wtGoBTmk2U4tQ7WMchq3EE+X/8v1H0sOUbLglOQs+gH1LZTe1tFI
   rw9aLIelfb6Pk4CJOaoZdF+4IhUiy0K/KB7NE5qfaBpzkCHW714QRBeEk
   Q+7U1kkK2AckCQsce2i90njW9G8nEXxHkKqoPxYUtVpVSotop9EE/u155
   b1Aa+BuhHplKP3brftgSYN4fRO8fdv0S49WLNBP0cF4ag6En7yfknR6NS
   A==;
X-CSE-ConnectionGUID: Xq1YKzuARa+e19SIixMJMQ==
X-CSE-MsgGUID: baOTcUmERJ+Zx4XQgK+dTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56203313"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="56203313"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 05:13:06 -0800
X-CSE-ConnectionGUID: VQdEsMXqR8qBKjmeEKbOAw==
X-CSE-MsgGUID: O+KtZNkvRJq7JgLfGnW4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113646751"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 05:12:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Jan 2025 15:12:49 +0200 (EET)
To: Easwar Hariharan <eahariha@linux.microsoft.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    James Smart <james.smart@broadcom.com>, 
    Dick Kennedy <dick.kennedy@broadcom.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
    Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
    David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
    Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
    Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
    Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
    Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Selvin Xavier <selvin.xavier@broadcom.com>, 
    Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
    linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
    linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
    linux-spi@vger.kernel.org, imx@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
    ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 14/16] platform/x86/amd/pmf: convert timeouts to
 secs_to_jiffies()
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
Message-ID: <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com> <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Jan 2025, Easwar Hariharan wrote:

> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/platform/x86/amd/pmf/acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..6b7effe80b78b7389b320ee65fa5d2373f782a2f 100644
> --- a/drivers/platform/x86/amd/pmf/acpi.c
> +++ b/drivers/platform/x86/amd/pmf/acpi.c
> @@ -220,7 +220,8 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>  	if (!info)
>  		return;
>  
> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
> +	schedule_delayed_work(&dev->heart_beat,
> +			      secs_to_jiffies(dev->hb_interval));
>  	kfree(info);
>  }

Hi,

So you made the line shorter but still added the newline char for some 
reason even if the original didn't have one?? Please don't enforce 80 
chars limit with patches like this.

-- 
 i.


