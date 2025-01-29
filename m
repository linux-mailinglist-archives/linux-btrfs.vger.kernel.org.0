Return-Path: <linux-btrfs+bounces-11121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F2A2158E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 01:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B827A3F45
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673215B54C;
	Wed, 29 Jan 2025 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvaYBX/P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0D154BE4;
	Wed, 29 Jan 2025 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110138; cv=none; b=VRtCcN4681SXovtUmMKcXH72FsLSQx5WeZXn0DZmcqDggc0DiVfJLjiGwUsnmKvy3uSDhcNcQVLfGQfcnXsBUo5nJHrBu2cfHXdR6WkBzZiMCYT0S/JLTCZYLImFP0Ej9NEiw5hYLu4w/WlH1D6pHPRkxjcn7SN1XoiuRU81fAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110138; c=relaxed/simple;
	bh=o5hYXLrn2BSP7xY88i6vdkcwT4JSgB+EBSjp35TyIH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE8GGwT3cgx6gxW14xDKoQBqmEC/yHMcCpTgutQLF3BgExO9a9R4pIEf3jz3ojsjpJZSx1++g+esK/K2Mc8NoE/pFF5u0MeqHEayb022GHFpuNmCakX+qK+tjpg2kjx7nBGXUN+JHL5y2EVCUgRWim4DfmguBDJDpvM85XEmMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvaYBX/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED094C4CED3;
	Wed, 29 Jan 2025 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738110137;
	bh=o5hYXLrn2BSP7xY88i6vdkcwT4JSgB+EBSjp35TyIH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LvaYBX/PT4FznDpU2Sd7jAjMWT4Zhccvq1G9nSszqh/z9EeEvQMdhKwHFf7ytbKF+
	 IUR+ABOYF1Zb5ToAxGojoYFF5LcMvZK8Geqv9mvejas0wlawpm2evJ55461lpZ3/I/
	 zVKKBQPMk2YJIFo/RCbg1PW01H9enhxph87W35ORJ0IbWnkqCyucviUycj1TOFFCX5
	 tVowcKWyDXFzGw9RnW0kp5cJosqChn0Zj7syPQ+RNy64a4hU0MGfSeqeKrMrafwXVt
	 ED+vwkcJ1uDpOqa3gcUHNMFHbXgSAwCyOvMlWR1/qOlt8d2jZrQdrJy3iTMJ/IM0sX
	 QFqOs0rnLo8tg==
Message-ID: <f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org>
Date: Wed, 29 Jan 2025 09:21:11 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] libata: zpodd: convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 3:21 AM, Easwar Hariharan wrote:
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

The subject line should be:

ata: libata-zpodd: convert timeouts to secs_to_jiffies()

Other than that, looks good to me.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/libata-zpodd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> index 4b83b517caec66c82b126666f6dffd09729bf845..799531218ea2d5cc1b7e693a2b2aff7f376f7d76 100644
> --- a/drivers/ata/libata-zpodd.c
> +++ b/drivers/ata/libata-zpodd.c
> @@ -160,8 +160,7 @@ void zpodd_on_suspend(struct ata_device *dev)
>  		return;
>  	}
>  
> -	expires = zpodd->last_ready +
> -		  msecs_to_jiffies(zpodd_poweroff_delay * 1000);
> +	expires = zpodd->last_ready + secs_to_jiffies(zpodd_poweroff_delay);
>  	if (time_before(jiffies, expires))
>  		return;
>  
> 


-- 
Damien Le Moal
Western Digital Research

