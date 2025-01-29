Return-Path: <linux-btrfs+bounces-11163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E1A2257C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 22:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289853A1805
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6AE1E3DF9;
	Wed, 29 Jan 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mY3mAkZd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0C194AD1;
	Wed, 29 Jan 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184639; cv=none; b=iqXScunONgiNMwtPXJWqFWoxCswuc+i9MaH4v1tStpQ7FRKjUmm0Pxm8+U0+ppKCy923BhxnqT2at2r8BTKxdEqTp1bnp79htTRKvMKxG0f5Pd9/3HGUdm1M4D+RSYuAe8SpA+q2ieCPeLbAelkrvCXgTjFnHvlwdParb8RwLIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184639; c=relaxed/simple;
	bh=EsYz53Al9cDMt+LJZ12iOWeqRoB03Is/uiVHJBAKxPs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BZc+/O8yiOc62L9cJbuootJUxhPyNTgFd8JuyYdOU0kXvBEsPhylS2xqlxrwkK+4po+Mc276fW+Vqjl7EnjgIY/ItpdPJZFNsUU2m9K5C10fK1KQikJ+HXLZ4hN8MQvKkQi8IK0gTmoD6Q+LOesDIcZ7a9qHN4OqiLw6/mhH/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mY3mAkZd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.161.47] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FFDA2109A5E;
	Wed, 29 Jan 2025 13:03:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FFDA2109A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738184637;
	bh=O+JFGGFluQhzEspwlwz6aXkZ7QKW4DjxL6knEN3myoo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mY3mAkZdBwX5JW6v0rHOcPwixnNpeCwrI5i6lioeivoGl5PeSwTfMHOmjED6AV41/
	 5wIYfQa9MecJKhXc6T7//bDDoOB4BG1MPO3Miu2pGAWJwBcdsKKFOS1hzy+NN34ovy
	 jA6uxIox2R9YzB3PKnfuI/uqwUCqDlg2DifBsbMw=
Message-ID: <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
Date: Wed, 29 Jan 2025 13:03:57 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 eahariha@linux.microsoft.com, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Andrew Morton <akpm@linux-foundation.org>,
 Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/2025 10:21 AM, Easwar Hariharan wrote:
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
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

<snip>

> @@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *param,
>  		break;
>  	case Opt_lock_timeout:
>  		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 > INT_MAX)
>  			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>  		break;
>  	case Opt_pool_ns:
>  		kfree(pctx->spec->pool_ns);
> 

Hi Ilya, Dongsheng, Jens, others,

Could you please review this hunk and confirm the correct range check
here? I figure this is here because of the multiplier to
msecs_to_jiffies() and therefore unneeded after the conversion. If so, I
noticed patch 07 has similar range checks that I neglected to fix and
can do in a v2.

Thanks,
Easwar (he/him)

