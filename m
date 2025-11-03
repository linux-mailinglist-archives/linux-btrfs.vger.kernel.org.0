Return-Path: <linux-btrfs+bounces-18530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F6C2A25B
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 07:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EAC3ABF3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6C52900A8;
	Mon,  3 Nov 2025 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnH+orpr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC622A1C7;
	Mon,  3 Nov 2025 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150114; cv=none; b=AqqrnBt2aQO6P0AltADJzbWZGAoTfrNHddPLPXdQYqBH4FF/oaggM59kq/ffWYAcH4L/VyCDpfuKUCrNoLvTE+7dT0jWZjVQgp50cNL0BtO0OFHutf/+c1EHcCXClAwTC/go63ldzUGPKwkvYImGSCs+XfhYjCOfbldayxQ0o+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150114; c=relaxed/simple;
	bh=pwdbBk5k6Lzn4gzAg9HIGXVXZpoWqAAGoLj3pg2fCKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mmddnule5jtGowr9VpGmhWgXBAH84e0Yrn3ubyO+lKUahOQPsKREHilYVWJVuefzm23WMck/KWgthw+o+PVkOb540B2I78+PNyPCLVqORb0x9ELzE8cgNt/2ZY9oKUjW4kunAJViax1Z44RncubBFPmyjhLyFprTxPfXl/moFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnH+orpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E569C4CEE7;
	Mon,  3 Nov 2025 06:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762150114;
	bh=pwdbBk5k6Lzn4gzAg9HIGXVXZpoWqAAGoLj3pg2fCKc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CnH+orprqbruxwZuHf+EdM///THhXFUjdY+3st0QXD0POAUkza82UIhHSxkhGOn1A
	 MDBFzp33Mt5Lt5eiyfDmgXPKxZD6saSS+JArEMye7byAS+T/0avuF7xvz+0HwYP7WN
	 Z8RYya7sYXwHBiFIMtoo4LRp4VqTzxKQbxloxmkYJCTJbLe7vDA1y6HUumTyOk/dr9
	 4SMWtXXBOzTYPAWQPN9LvYK7f0vvP15GIZA/+zcDTbrdHBnzgCIAc7YhRKHcP5qaPA
	 yLEK2OqPmWoYeDTUnerb12eG+ANqAy8Q4KLOjapOp4/FCoS0JQwg5e4v5ma9YqiBLd
	 xh3s9LB0ePHgA==
Message-ID: <1276e2be-4d8b-4c59-822c-3af4490de24e@kernel.org>
Date: Mon, 3 Nov 2025 15:08:30 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
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
 <20251031061307.185513-9-dlemoal@kernel.org>
 <42dc640b-28e9-4706-91dc-dd075e736065@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <42dc640b-28e9-4706-91dc-dd075e736065@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 06:40, Bart Van Assche wrote:
>> +/**
>> + * blkdev_get_zone_info - Get a zone information from cached data
> 
> "Get a zone information" -> "Get zone information"
> 
>> +	sector = sector & (~(zone_sectors - 1));
> 
> Please consider changing the above assignment into:
> 
> 	sector -= bdev_offset_from_zone_start(bdev, sector);

That is a lot more arithmetic for the same thing.
If anything, I think this should be:

	sector = ALIGN(sector, zone_sectors);

>> +	/*
>> +	 * If the zone does not have a zone write plug, it is either full or
>> +	 * empty, as we otherwise would have a zone write plug for it. In this
>> +	 * case, set the write pointer accordingly and report the zone.
>> +	 * Otherwise, if we have a zone write plug, use it.
>> +	 */
>> +	zwplug = disk_get_zone_wplug(disk, sector);
>> +	if (!zwplug) {
>> +		if (zone->cond == BLK_ZONE_COND_FULL)
>> +			zone->wp = sector + zone_sectors;
>> +		else
>> +			zone->wp = sector;
>> +		return 0;
>> +	}
> 
> According to ZBC-2 the write pointer is invalid for full zones.

Sure, meaning that the user should not look at the value. That does not make the
above wrong in any way. But sure, I can chnage that the ULLONG_MAX if you really
prefer.



-- 
Damien Le Moal
Western Digital Research

