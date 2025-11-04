Return-Path: <linux-btrfs+bounces-18643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2655C2FB24
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 08:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A1394F7181
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512C30BB8F;
	Tue,  4 Nov 2025 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Axyt6UGg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C23016E4;
	Tue,  4 Nov 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241928; cv=none; b=qIlHnQxH2COx4/jRYs/b5oNSeAz4LWfuJPtx4mP+1rJWuRoJMRgz6yKGKOlMwH7/6tYl+yMSmXycqYY6YSnZwYWQEZoxF0MakDADpDlQ4+YCCzLWTrex8PW4JD2XBJvQYcPpoayilK0N7JNj/uUGMTbZlWHq4GD1mS3BU7eW65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241928; c=relaxed/simple;
	bh=POLqaQ94dh/t6J0gDfAv8qWZd1iCMjPLAZedaVguceE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hR9GqG917mNfyt0zGao/UBS16IBijlqmPwfu3BtIhEa1Iag425N2NX3+hKEp7H/FvtQBIUWWLx7zXJCkbeK3R0f6Dm2MU+CjvG6YK7amGPaHwJkL2ebwbEZcZhhVS6abNBDxc/y6ShivsSvz55hQSrSvnTCoAuDIEieRbs6P320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Axyt6UGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CFC4CEF7;
	Tue,  4 Nov 2025 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762241926;
	bh=POLqaQ94dh/t6J0gDfAv8qWZd1iCMjPLAZedaVguceE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Axyt6UGg5x6PGMQG7ZOVMKFrpxvXwFDDylFW2fjveB6lK7jF1SA/pmq//ghwx4V1d
	 W1MCAkzVn0rQ41EblL1QQxkn5+tLuzehDAFs9yjy+QCjPxTpaBS3/lRZpJb/YrxKJ/
	 ky4P4XTsqB7OK7fnjDBLIhm5ebHBh5NdYyVAeryN6v3BIuKhWR//b363O5C596bvGr
	 BldM+8IDv/ETGFZ2RRmsJ2x/aq68EvWGAdYHOa93bboU1FvQJ3mKk7kGv4bIQY375a
	 8ZJwn9MSvin17zPZzwAL0mtluwI5ehmY1zeInEjpM2wvpUPgKctfV5LsFS+uSGA9Fs
	 9yjPorGvg8NJQ==
Message-ID: <de15eadd-98fc-4456-8263-712e9d519adf@kernel.org>
Date: Tue, 4 Nov 2025 16:38:43 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
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
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
 <f7025e4f-3205-4bae-93c0-68e02dd11ca9@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f7025e4f-3205-4bae-93c0-68e02dd11ca9@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 16:23, Johannes Thumshirn wrote:
> On 11/4/25 1:15 AM, Damien Le Moal wrote:
>> On 11/4/25 00:17, Johannes Thumshirn wrote:
>>> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>>>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>>>> applications access to the fast zone report implemented by
>>>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>>>> and is documented in include/uapi/linux/fs.h.
>>>>
>>>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>>>> field of struct blk_zone_report also as an input. If the user sets the
>>>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>>>> is used to generate the zone report using cached zone information. If
>>>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>>>> as BLKREPORTZONES and the zone report is generated by accessing the
>>>> zoned device.
>>>
>>> Is there a downside to always do the caching? A.k.a do we need the new
>>> ioctl or can we keep using the old one and cache the report zones reply?
>> The old one is needed to allow getting the precise imp open, exp open, closed
>> conditions, if the user cares about these. E.g. Zonefs does because of the
>> (optional) explicit zone open done on file open.
>>
>> And we cannot break existing user space anyway (e.g. sysutils blkzone), so we
>> must return the "legacy" report unless asked otherwise.
> 
> 
> OK, let me read the patches again, but why can't we do a "write-through" 
> style caching? I.e. something in the system is executing
> 
> blkdev_report_zones(), the cache will be populated as well.

The cache is initialized with zone revalidation and maintained as IOs and zone
management operations are executeds. No need to involve blkdev_report_zones()
for maintaining the zone information. Not to mention that it would be impossible
to correctly do it without guaranteeing that report zones is the *only* command
being executed. Otherwise, by the time you process a zone report,
write/reset/finish IOs to that zone may already have changed it.

-- 
Damien Le Moal
Western Digital Research

