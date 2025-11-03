Return-Path: <linux-btrfs+bounces-18599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B1C2E4CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310003B6E34
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105D30B50C;
	Mon,  3 Nov 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikWSm7nD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12B1DED63;
	Mon,  3 Nov 2025 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209652; cv=none; b=BB1uCdiWj/kEJChbSSM48q23wB1ikBGY1T6GbIMm1chI0wwwXPvrHXb4SDNwniXG0XmcGDR0IzBZ40wnkfX5Ck2d4UqgB0bhITiVWU5es6YwANI+EyhkAtBA8ZoN5Y76gL7KeJ1OxgcyUd3HBj/+Hbyt4EdCLQTl6rl8uPJy4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209652; c=relaxed/simple;
	bh=vhsUlqZUcbc9ggOr4fP8rMWtQqZ9jTiCAAhbl0qoWF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GE3jQW4wGiLR+mg7oXbNZFmZHdV2Sf+FkgMysk4G6tb/8YhrK+/EXMYYoRUriyO5LAwf3JhKpioGmSAqnvsFp8TgR7FMVDtJiL/VtTW155Mz/VRH0V/0397KmIHExiCcoqiyYy6mLI8xLRl19rViVmEcmItR+wd+aY/OiQ/TvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikWSm7nD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1DAC4CEE7;
	Mon,  3 Nov 2025 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762209652;
	bh=vhsUlqZUcbc9ggOr4fP8rMWtQqZ9jTiCAAhbl0qoWF8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ikWSm7nDLDS50DwwubTD0wbH/ZE3gx+A2PLCwPYZThP/WXEqqo5urSGNyCm9Id00o
	 xt6bM3z78YD7mf+zDnNhwxSFj9BKkdQESTmDvWHVCglsbYl4pnbeicODszII9pwMen
	 AJ3gP20NiZE0EsxYo4cdWluY8eaaETwal+3SaG73iiK3NdEYYr7NU9QrqNPVzLj3mt
	 IklHBeH+q4vop8dhtlI8Xjzmsh7B6UwjFVHmUwt463aTMqATD3Ko0tpQevaVdjL9Hr
	 LoV1eDxgJdvqP5lCpiC+jsaafuW7tJqcOMMAgZx4nEbPTteqUhPaOf+WwbqE1GGhg4
	 pAKT+ciSxxVEQ==
Message-ID: <88b37ced-cb7b-46c8-958e-778bde7baa0d@kernel.org>
Date: Tue, 4 Nov 2025 07:40:49 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
 <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 00:48, Bart Van Assche wrote:
> On 11/2/25 10:05 PM, Damien Le Moal wrote:
>> On 11/1/25 06:17, Bart Van Assche wrote:
>>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>>> Implement tracking of the runtime changes to zone conditions using
>>>> the new cond field in struct blk_zone_wplug. The size of this structure
>>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>>> end of the structure. For zones that do not have a zone write plug, the
>>>> zones_cond array of a disk is used to track changes to zone conditions,
>>>> e.g. when a zone reset, reset all or finish operation is executed.
>>>
>>> Why is it necessary to track the condition of sequential zones that do
>>> not have a zone write plug? Please explain what the use cases are.
>>
>> Because zones that do not have a zone write plug can be empty OR full.
> 
> Why does the block layer have to track this information? Filesystems can
> easily derive this information from the filesystem metadata information,
> isn't it?

The title of this patch series is: Introduce cached report zones.
For that, the answer to your question is I think obvious. Otherwise, how do you
exactly propose to report correctly the condition of a zone without have that
condition tracked and cached in memory ?

The point here is to provide as much information (almost) as a device generated
report zone, but much fasterer, using cached information only, thus avoiding any
(much slower) command execution on the device. And as these patches show, that
is not that hard to do, with the trade-off of a slightly higher memory usage per
device.

See the numbers for XFS and BTRFS mount speedup in patch 14 and 15. The gains
are even higher when mounting a large BTRFS RAID volume with many SMR drives.


-- 
Damien Le Moal
Western Digital Research

