Return-Path: <linux-btrfs+bounces-12490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A4EA6BF1B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245523AAFAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7722B8D5;
	Fri, 21 Mar 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvGalA/i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331401DE4C2;
	Fri, 21 Mar 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573186; cv=none; b=gEnUNae3wa4xi6f2ces2Q61CkdgJfoBVGrp8eaJ07S9AmZeEBlffta5pnP0YnUfio8TVYtzenehObOREp8JWk5GUcKuTjDKXnD83sslP/EeCBK4EX2Rmf88aT1oerMHfb4iF92GOJrhOW3i49wsrgjSeZLFY69ddisAKj+nIN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573186; c=relaxed/simple;
	bh=WgBVYTr0URRl3zJspKTAryBSC/YiYErKzgv7WS4Rg/s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fJoKGR3W3Q57YTby4gOkViWWAZYQGgRP4WXCGkwxoW+qEM2Rmq1yRYL39BRFUe+ENF1cwAmveTDwcwGla6fcZOfrUPwSbuLA/z+sBYL/NW8AAS4AMucvLZ8iG6BOUJPwdcwyUMywYtLi/9JPlxZNX7EHjQT8Mq/1ejneVX5+MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvGalA/i; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742573184; x=1774109184;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WgBVYTr0URRl3zJspKTAryBSC/YiYErKzgv7WS4Rg/s=;
  b=NvGalA/ikOrL5oPJYs+QnTxjGygBeYWWOIvfFHc3OkbJX2AwHpopTwqS
   OrJ7JGqvsLvcwKeP1prZM7mVJTOfER54Pu75l/Fxr9j8e/jK3wFjwN7qC
   SK/5ji+VMYsX0/5AhSQhmE9n8DiGMEF7b+LjyblXx5blGM0B6v0DiKpB9
   7qQZ9t3oQhCYinN742ZwcgN+X4JUGCey/94l/s0aWmz+DeK3rMLdvIdAr
   VOz0V9xhnp8gPVoJI15e8EZBeavaDkLOepeFPGKjHBbFPdNQ3UOf5upEx
   k4Kt0Ju3dJwZMJUlGC8aC6kaTxjBeWUEXBcxhuhtx35JSY0kXfzmt0vxz
   A==;
X-CSE-ConnectionGUID: uCVdhp/3So2cYbOJXCtPug==
X-CSE-MsgGUID: onEv0mKKQBKLcJNtxbhz7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43726622"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43726622"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:06:23 -0700
X-CSE-ConnectionGUID: g7UgcbV4QTih6n+cWYD8tQ==
X-CSE-MsgGUID: 1EcrVXRMQNGo+fC3Vk/4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123417648"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:06:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 18:06:02 +0200 (EET)
To: Easwar Hariharan <eahariha@linux.microsoft.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
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
Subject: Re: [PATCH v3 15/16] platform/x86: thinkpad_acpi: convert timeouts
 to secs_to_jiffies()
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
Message-ID: <9e761e10-eb4d-0a34-79b5-ef4507f002c5@linux.intel.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com> <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Feb 2025, Easwar Hariharan wrote:

> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
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

Applied to the review-ilpo-next branch.

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index ab1cade5ef231e9a9a520bc0cca82384c911a331..d269e791f7fbc2a8ccf96f28cb476beccb57c9a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8512,7 +8512,7 @@ static void fan_watchdog_reset(void)
>  	if (fan_watchdog_maxinterval > 0 &&
>  	    tpacpi_lifecycle != TPACPI_LIFE_EXITING)
>  		mod_delayed_work(tpacpi_wq, &fan_watchdog_task,
> -			msecs_to_jiffies(fan_watchdog_maxinterval * 1000));
> +			secs_to_jiffies(fan_watchdog_maxinterval));
>  	else
>  		cancel_delayed_work(&fan_watchdog_task);
>  }

-- 
 i.


