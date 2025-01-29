Return-Path: <linux-btrfs+bounces-11154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33905A22298
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7896116861A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1711E0DD6;
	Wed, 29 Jan 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KF5CYJEM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A01FC8;
	Wed, 29 Jan 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170744; cv=none; b=mEZWOGTAyj7lLdqfjQsyNwYsvBWFVGuuadLWvd7pqMtQeR8z1b/a41++2w6N4P3gfK7wyJgbWPMcO6d1Ote31LobFFLgmHBKsjZmeAPjxsSM/xPZj3ZUxeoaQdhvx+OK5/QDTb+ndqOxhO6ZvN5GwcSijcSwbJZOj8HA90STGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170744; c=relaxed/simple;
	bh=oKInIs80fHAFlAQ60VYFUV3zyOcN3MDJrxPHxOZnX7U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eS6yPgc/lKnZxjbSO/d8pm9Qhs5dGvoSts7VM5CZH6YUfE5f99nt9zPpe3ORI1xdr6XhJ7MNh15/1jmNi5nfuNqiTSHpkEAeBFhSfH5CH7xXZNSRrA1rCSeTj8rReBHSYFCV7egQJdx/2Ce2b8PfgwF3HTVp10T4CmCSmbEniP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KF5CYJEM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.130.94] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id B361C203F2DF;
	Wed, 29 Jan 2025 09:12:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B361C203F2DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738170737;
	bh=dNRZE1wRPI3+cVzpq2MiJyQrXak+KjxySL05qBZwi3I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KF5CYJEMAg7wD96ahKvWhkAFA05d2EUsKiRjXm+SrhlcieyjVvtYaExuKNZLJq+g2
	 aBFGl/Q/OmH+pg7BhR5kfVvugzt2v4vFfmJ8RuG1opp/VMgS23ja3qFHYzfub/yGXl
	 hPpNsGrrOx1WOoNEIOcsOUJA+IETCxANclm3bUSY=
Message-ID: <fae29f46-2971-4cab-a54a-f1780abbadda@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:12:18 -0800
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
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
 <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/29/2025 5:12 AM, Ilpo Järvinen wrote:
> On Tue, 28 Jan 2025, Easwar Hariharan wrote:
> 
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
>> ---
>>  drivers/platform/x86/amd/pmf/acpi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
>> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..6b7effe80b78b7389b320ee65fa5d2373f782a2f 100644
>> --- a/drivers/platform/x86/amd/pmf/acpi.c
>> +++ b/drivers/platform/x86/amd/pmf/acpi.c
>> @@ -220,7 +220,8 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>>  	if (!info)
>>  		return;
>>  
>> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
>> +	schedule_delayed_work(&dev->heart_beat,
>> +			      secs_to_jiffies(dev->hb_interval));
>>  	kfree(info);
>>  }
> 
> Hi,
> 
> So you made the line shorter but still added the newline char for some 
> reason even if the original didn't have one?? Please don't enforce 80 
> chars limit with patches like this.
> 

Sorry about that, I can fix that in v2.

Thanks for the review!

- Easwar (he/him)

