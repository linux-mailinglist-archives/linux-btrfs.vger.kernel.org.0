Return-Path: <linux-btrfs+bounces-11158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A909A223B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B353D1887967
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26E1E25FF;
	Wed, 29 Jan 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aAf9IIr/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F61DE2DF;
	Wed, 29 Jan 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174481; cv=none; b=jPrJqsHa5qkfCuM2ysIpBmWpw0sqkajgsg6rK9Zj5csipyTNvkkEYVQVGK5b9eKCOW03rlztihYANQx8Zy58u0pJxPVZS7rHokqNG7r+WPSfXVfyketJgmP72xcZk+hz5Ecyc+nmzOQHAjeqGTMIaTbqFdw0azUsuH65kNgfLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174481; c=relaxed/simple;
	bh=RUlBLbu2dRvKVCN3bBJhGTTBjAhlfapqs+U8UGJ1e6Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eeVWYFe65Fih8wiNU2SrsWRG+lGtixKgeCxE7Aa589yUcLoUrLF24jZYw73KPDQgdj9llHEGEkDKNwVbVwSA9OSmd3euNib7bfdL5e5K5deoo4mBm8IuyQd/hr6kcc6TtaasMZqjcjUCcCiZtB3g7Gc2U0NrGT1Wmh3YuYbWXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aAf9IIr/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.98.224] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28F3F2066C1F;
	Wed, 29 Jan 2025 10:14:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28F3F2066C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738174479;
	bh=tZu7Aqdcq4BHW7QoklKujtbGCaxot/XApiLegvlW9Cg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aAf9IIr/I90cgqgEBczLilZ7bdtCYRLZiEJHEhBdKJpSoOCumeMDEGeLf0xioaxnU
	 Cxs0rQCB+cTOuTBJEpsGVDSTUnsyW+Sqnpdni5YRWUzescyOcAANxe89dy6cL7UnK5
	 9o+lRZL0v3hO8jHtI+YxGsr5kQTHif7tO+OZbuMk=
Message-ID: <670dbe5b-cf5b-4994-9a47-53b0b52a4b20@linux.microsoft.com>
Date: Wed, 29 Jan 2025 10:14:40 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Andrew Morton <akpm@linux-foundation.org>,
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
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
 cocci@inria.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH 09/16] xfs: convert timeouts to secs_to_jiffies()
To: Christoph Hellwig <hch@lst.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
 <20250129052108.GB28513@lst.de>
 <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <3e4a8a44-483b-457a-b193-4119e4adfa85@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/2025 9:12 AM, Easwar Hariharan wrote:
> On 1/28/2025 9:21 PM, Christoph Hellwig wrote:
>> On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
>>>  		else
>>> -			cfg->retry_timeout = msecs_to_jiffies(
>>> -					init[i].retry_timeout * MSEC_PER_SEC);
>>> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
>>
>> This messes up the formatting by introducing an overly long line.
>>
>> Otherwise the change looks fine.
> 
> I'll fix this in v2. Thanks for the review!
> 
> - Easwar (he/him)

Andrew seems to have fixed it up in his copy, so I'll skip this change
in v2. Thanks Andrew!

- Easwar

