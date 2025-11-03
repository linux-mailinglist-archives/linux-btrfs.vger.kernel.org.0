Return-Path: <linux-btrfs+bounces-18597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE03C2E3B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA563B4DF1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913C2EFDB4;
	Mon,  3 Nov 2025 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yAjIwPpj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84D34D3B1;
	Mon,  3 Nov 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207967; cv=none; b=aqBeI7osLXuqOCQs4wN2TpAJrgRFCPKaCz1PQQrONT7SN9LknlxYYS/O6uea6RbGwX8WzS95uwYkSmkyyX9CCl96S1L4Oo4kgGCFjJa0VX5N9olxBLnGI7/4fULMGAXR57pDxnbUrIoo+iJw5gIGZX68f/gLrTLetOEjbAmL+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207967; c=relaxed/simple;
	bh=2BO337p6zx5RJ4/MA1lP9PMwUox81sZZJfW2V6a8TOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q5ACT14okRVxUZi13lMd3nI8/9FT5QCOFrgGk8C/xtBpnYGvz4d+ObPowIq8OQKIojxQ+/mE4JG1a69VydJ8hxcJCsKR7K33xDJpZzyWfNeZPypLDu50yWzRY+E7WekIB0DrCaHWM0WNxEe04l8KzMadx7dRYSqgLRJNh2Zw0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yAjIwPpj; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d0m6b1dVxzlvX7g;
	Mon,  3 Nov 2025 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762207956; x=1764799957; bh=HnnZgAPAgJrK4pb5dGDR1MuE
	mQZFMeB1v9SVf6KhEpY=; b=yAjIwPpj9bZJsEd6nCLsn1vFmOuUd8C6N1+X0HuR
	SVOl+Ku+ZGox/IsWKujTc9h5km3d3m9xM1E91QdHuC12HOyAaZerg9NMH3/lTUGJ
	MzY0AaV8C/BCYSVIKe6bWe/tSejrXxFaVi3iicynvKOglHP1sCOodEAgL/XiwJr0
	f4AGqOaEZni7XcL6O3kkJfVQHxd2zRnsADzluIKmDeXE11zHq4BWtc2vjzBOzxKj
	otqETyxe0ET5Z1j5pFXMMrhzC7cjut8xzfojZgRudNFu3tloBLQ5FcHPKeT+zmfp
	QFu2yABRl4/r1PVMawmPdrqmEXmW5dlZapd17eZHkLpVog==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4bFOvLTEpaKB; Mon,  3 Nov 2025 22:12:36 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d0m676MgFzlvPx7;
	Mon,  3 Nov 2025 22:12:13 +0000 (UTC)
Message-ID: <3c634060-494b-4319-8298-caa940e92f48@acm.org>
Date: Mon, 3 Nov 2025 14:12:12 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 7:17 AM, Johannes Thumshirn wrote:
> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>> applications access to the fast zone report implemented by
>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>> and is documented in include/uapi/linux/fs.h.
>>
>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>> field of struct blk_zone_report also as an input. If the user sets the
>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>> is used to generate the zone report using cached zone information. If
>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>> as BLKREPORTZONES and the zone report is generated by accessing the
>> zoned device. 
> 
> Is there a downside to always do the caching? A.k.a do we need the new
> ioctl or can we keep using the old one and cache the report zones reply?

Hi Damien and Johannes,

I have a different proposal, namely not to introduce BLKREPORTZONEV2 at
all. If we keep the BLKREPORTZONE ioctl and do not introduce the
BLKREPORTZONEV2 ioctl then in the kernel we only have to cache zone
information that will be used by filesystems. Information that won't be
used by filesystems doesn't have to be cached. With this approach the
existing data structures are sufficient (struct blk_zone_wplug and
conv_zones_bitmap) and we don't need to introduce new data structures
for tracking zone information.

Thanks,

Bart.

