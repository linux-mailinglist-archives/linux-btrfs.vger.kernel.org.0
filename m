Return-Path: <linux-btrfs+bounces-12223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165CA5D6DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 08:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015973B7858
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107A1E9B1B;
	Wed, 12 Mar 2025 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdgfEzin"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240A18991E;
	Wed, 12 Mar 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763494; cv=none; b=LMAEjzTVEA+fke9+NnC5DxMCvjlIxgxeT+8hbLSZYOYWXz2XtAYYKIH/UAvMmvEgu3ZLHgwY+R4Yt+KA6NEAVml+7WUNbH5ImBrQzXx2fCW7mmEGVnj76Vj5wvc5dEJh+A2JgoFUQs+pym1PCBMQODaD6ir9pBGmpXN8mi224QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763494; c=relaxed/simple;
	bh=8JHQyxjn4D0uEFn/y7mOMBqDNzZLd6BmRcD8xYZnHro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDflRNCLekbuLnLEVxN0N3ahY/Aj472tJ+NMCK1+f9rqybXVoc1fVEo55u/GxhHJc1MrUygt4XbLRDntuJO8y4tCk0aCUZ/lDWRbLaKp39O5mJ54yz+Z0wT9Zx09MxS8mXTh8pmtTnw8bzod6nmGGlLlmYRJW44Vep/nLCrQnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdgfEzin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A0EC4CEE3;
	Wed, 12 Mar 2025 07:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741763493;
	bh=8JHQyxjn4D0uEFn/y7mOMBqDNzZLd6BmRcD8xYZnHro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tdgfEzinfOYmwuc/xFxswjVNNxixheLxM7q2cq3jFrHOt8hPXo2CMnRpbuXy/veMM
	 JY/UL4Jxy54ARFKahIVP9UKE9v6YsTi0JdKbkXoMT87W1mO1WzJBKL0MaTgCQhrv43
	 WBmSPZZ/py8eOWeV66c9CNzmLpxj/LZgOxYX+LxU1k7PmBmHBTCzLEmjT+0DGf9WZy
	 RMG6mMG4kkZrpirjELuMEzvGXO0r09KODElwyCZBeLruFQYrR4AivQzVzlXj8ARl4L
	 uzOvlvPNVmUWN2jAEkjyTTR48FfW/WTqygl07aO+x1KUrUb9JrYoYjV7gF9nNtOB1q
	 WEm+PofXHQuXQ==
Message-ID: <6376ed15-7265-4ead-98c5-11f204976fdd@kernel.org>
Date: Wed, 12 Mar 2025 16:11:31 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: introduce zone capacity helper
To: Christoph Hellwig <hch@infradead.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
 axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
 <Z9EbSZh-OtLGttoB@infradead.org>
 <dfa516c7-2a4f-45c5-a184-0b0e64336c38@kernel.org>
 <Z9ExGqwUZWu3oHVR@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z9ExGqwUZWu3oHVR@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 16:00, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 03:55:31PM +0900, Damien Le Moal wrote:
>> On 3/12/25 14:27, Christoph Hellwig wrote:
>>> On Wed, Mar 12, 2025 at 10:31:03AM +0900, Naohiro Aota wrote:
>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>> +static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)
>>>
>>> Overly long line.
>>>
>>>> +{
>>>> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
>>>> +
>>>> +	if (pos + zone_sectors >= get_capacity(disk))
>>>> +		return disk->last_zone_capacity;
>>>> +	return disk->zone_capacity;
>>>
>>> But I also don't understand how pos plays in here.  Maybe add a
>>> kerneldoc comment describing what the function is supposed to do?
>>
>> The last zone can be smaller than all other zones, hence we have
>> disk->zone_capacity and disk->last_zone_capacity. Pos is a sector used to
>> indicate the zone for which you want the capacity.
>>
>> But yes, agreed, a kernel doc would be nice to clarify that.
> 
> Should it be zoned_start then to make that obvious?

Well, it does not have to be the zone start. It can be any sector contained in
the zone you are interested in. With a comment, that should be clear, and also
the same as helpers such as disk_zone_no() which do not require the zone start
sector.


-- 
Damien Le Moal
Western Digital Research

