Return-Path: <linux-btrfs+bounces-11156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA79A22318
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A53A4CDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156091E1A3D;
	Wed, 29 Jan 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WdTF6heG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FD190696;
	Wed, 29 Jan 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172196; cv=none; b=pOK+GPozhmD7U/BSWHi1mTZMMK1ZG6wZluY/jloxJ8R1+YpzHYvY3hFLLseoysLkKghWhnMt9GfXc6uzj0xtpEjJrhk4PTT0Asi2Q8nZNUWN5tOvyp1iVj8i5XxcikugWN3rvFs5uvKaA0T/C0RlyeL1ubmL916xavfNiPAC7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172196; c=relaxed/simple;
	bh=aRxp+TRakpowcUaDsGSNpKX92RxnLaSoDAyix4SGDVI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X54ax7ph/P6Qfxefs+eKX1Jp5uv+v04ZAMfxzvO0ITiKfceHlftgabBY8LI2GWKWJyPzS8qDEYn3xH5TwE8CbB/14m4dxHTjwPuRRsg3olXPX0D8WJ5/eKjhro1YoNEXc7mUJI9xW4BE6bBxZdp0O+b/6qjBqXdUe7IU1wx16xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WdTF6heG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.98.224] (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3CA2205721D;
	Wed, 29 Jan 2025 09:36:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3CA2205721D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738172194;
	bh=32VWyKda36DT3SVOQLKSI+Nu4mFH6I0v9p1Ypx/s/UM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WdTF6heG9MXWg27CPpr2zs00gFmg/LzwKj0Alp7kuExME9ZkmRvd6i5RlINsUJmCj
	 gyW4AT2kMUzCtyC2BYOQAoboe3fZn9gnSQn/nvMf6cJwjiMZFtGWg0RkK4mQ7CXmnv
	 aKvKdhLh7jtgcjd5i92zHQeesuEbYFvcBS4PUXbY=
Message-ID: <f991dba7-79fb-490d-8ac5-6bd14f3209a8@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:36:35 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 eahariha@linux.microsoft.com, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 08/16] libata: zpodd: convert timeouts to
 secs_to_jiffies()
To: Damien Le Moal <dlemoal@kernel.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
 <f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/2025 4:21 PM, Damien Le Moal wrote:
> On 1/29/25 3:21 AM, Easwar Hariharan wrote:
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>>
>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>> the following Coccinelle rules:
>>
>> @depends on patch@
>> expression E;
>> @@
>>
>> -msecs_to_jiffies
>> +secs_to_jiffies
>> (E
>> - * \( 1000 \| MSEC_PER_SEC \)
>> )
>>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> The subject line should be:
> 
> ata: libata-zpodd: convert timeouts to secs_to_jiffies()
> 
> Other than that, looks good to me.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> 

Thanks for the review and ack! I'll fix the subject line in v2.

- Easwar (he/him)


