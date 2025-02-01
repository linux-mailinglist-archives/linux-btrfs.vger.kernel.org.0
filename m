Return-Path: <linux-btrfs+bounces-11205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A15A245E0
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2025 01:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624493A8D7C
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2025 00:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982715AF6;
	Sat,  1 Feb 2025 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VAieKTRU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958B629;
	Sat,  1 Feb 2025 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738368706; cv=none; b=EfOr2AueiKCrE6e6bafHX50hGrP0LkZtd+TWaPBNY3T+DdgnGhpIlQ6bQmJPg8/5x8oBHp8pwzYivwK8i4FeDtfKCyN0Mhcq8lhuaQTiO8JJXJsp179qzJwlRBV65oG/w6BYx8TPtDXrY2QP24S4BttdvH9MQcOPvR/CHmUJRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738368706; c=relaxed/simple;
	bh=MYKomRfEqunKF+5LDSAdQtifzb1Zt5hNQibIdFjJ+s8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ien2NZeGrw1V2KBJmjzy20S23UL2MD2y8OH1JJCfbdPJimvNplJvMxT3OuOSgxkDub5wrR+Qe9ZUAPheNwCzr2PPh1WeeUh6yEQFcZ+glIwbXsAfgCFs2noD8Zj47Wv5kYd6SXiOFOmCJdM4HBNvYUMfwx1CnrD8PQ/zBgoTLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VAieKTRU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.234.206] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E312210C329;
	Fri, 31 Jan 2025 16:11:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E312210C329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738368698;
	bh=URcW5d1wFUuTsZZ61zIwPjo02bqd3Xwwrj5siI/ejR4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VAieKTRUQduuqC4WMWksNFGAWFpl7wH2vcfIqWTtocImegfQz7yg09xx/uVhF84+8
	 X7djRP48uKGESU6HAg1NDd667oKEWQCkly+4NL3U6jOR2q4YvgMKiwE4cdu5TQF7bE
	 8JEcr4WkbAHOc5PABGxI8dv7PLkq6NUdzzexdebM=
Message-ID: <632be2db-78d2-4249-92f0-3f60e0373172@linux.microsoft.com>
Date: Fri, 31 Jan 2025 16:11:37 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 eahariha@linux.microsoft.com, LKML <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>,
 Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
To: Markus Elfring <Markus.Elfring@web.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/2025 3:01 AM, Markus Elfring wrote:
>> Teach the script to suggest conversions for timeout patterns where the
>> arguments to msecs_to_jiffies() are expressions as well.
> 
> Does anything hinder to benefit any more from a source code analysis approach
> (like the following by the extended means of the semantic patch language)?
> 

Thank you, this is much more useful feedback, specifically due to the
suggested patch below. I did intend to learn about the other modes and
progressively upgrade secs_to_jiffies.cocci with them in the future once
the existing instances were resolved, to help with future code
submissions. The patch below will be super helpful in that.

As it stands, I'll fix up the current rules in v2 following your
suggestion to keep the multiplication in each line to allow Coccinelle
to use the commutativity properties and find more instances.

I'll refrain from implementing the report mode until current instances
have been fixed because of the issue we have already seen[1] with CI
builds being broken. I would not want to break a strict CI build that is
looking for coccicheck REPORT to return 0 results.

[1]:
https://lore.kernel.org/all/20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org/

<snip>

Thanks,
Easwar (he/him)

