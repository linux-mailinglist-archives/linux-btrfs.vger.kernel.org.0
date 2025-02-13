Return-Path: <linux-btrfs+bounces-11449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6BBA34C4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DD47A3424
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8BE24292A;
	Thu, 13 Feb 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MqwOKrlM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADA2040B7;
	Thu, 13 Feb 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468744; cv=none; b=aLlTLwJHmY8nKXGKm/AlylExHNrctWj8TBzeVGJBy/8pl14xSdKhaDvVPHx3ceO6t6UkzGCgI+UPTMGBuj022y5G87uaEEaBstv7Tjjfw6umvNHfe25VRrs7Mvk+mvA4xFH6yg9jjcdlsSovncX6mtKmglc5WGcWmfGc8Jf2z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468744; c=relaxed/simple;
	bh=9g9XvpJ4vTHZRdoVn0NNOAe0M9fMrmh7qRY4E5RBo5I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JaRg7IidlKAQiBO4hGtq62ejHDNeya3befkWh7RYalf+92TzzDR2PJFtN6D3BKgVriWc/QsnRwtmnQLNK0gKn0wLnbvi/aHzIh+06UuPRUEPj1t96ZRi2b9Xbh6ZWGsb79MRdTILvmmMji50gKfCVYe8c/Ic2c+52AHMy5M/UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MqwOKrlM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.1.94] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7186203D61D;
	Thu, 13 Feb 2025 09:45:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7186203D61D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739468742;
	bh=CjdDB9uvZBBF3c03e9VylpCG5WkQPsjk1qSKlO3MQtE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MqwOKrlM0wNKTlUgCtpn9gJKIpfGiwVh9dHGNNF4ycPmXa/idcQ30iiksOd4FJJaH
	 jrqNCD9r00CbzdjGOPFOZ+MnFU6woy29/+YEkOfP14iTKCcgK64o8pGQaLxlVNUpHe
	 bIb4sXQD9rr6g8CsvFcC34/zgx+kxX5/LItW+SLg=
Message-ID: <8f80b65e-724c-439c-a094-4bfbb1e296f1@linux.microsoft.com>
Date: Thu, 13 Feb 2025 09:45:41 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Yaron Avizrat <yaron.avizrat@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
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
 linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/16] Converge on using secs_to_jiffies() part two
To: Andrew Morton <akpm@linux-foundation.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/2025 4:16 PM, Andrew Morton wrote:
> On Tue, 28 Jan 2025 18:21:45 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:
> 
>> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
>> either use the multiply pattern of either of:
>> - msecs_to_jiffies(N*1000) or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>
>> where N is a constant or an expression, to avoid the multiplication.
>>
>> The conversion is made with Coccinelle with the secs_to_jiffies() script
>> in scripts/coccinelle/misc. Attention is paid to what the best change
>> can be rather than restricting to what the tool provides.
>>
>> Andrew has kindly agreed to take the series through mm.git modulo the
>> patches maintainers want to pick through their own trees.
> 
> I added patches 2-16 to mm.git.  If any of these later get merged into
> a subsystem tree, Stephen will tell us and I'll drop the mm.git copy.

Hi Andrew, I don't see these in mm-nonmm-unstable. Did these get dropped in the confusion around
casting secs_to_jiffies() to unsigned long[1]? That has since been merged in 6.14-rc2 via tglx' tree,
and I have a v2 for just the ceph patches that needed some fixups at [2].

[1] https://lore.kernel.org/all/20250130192701.99626-1-eahariha@linux.microsoft.com/
[2] https://lore.kernel.org/all/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com/

Thanks,
Easwar (he/him)

