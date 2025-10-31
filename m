Return-Path: <linux-btrfs+bounces-18492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A36C2714D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1621B257C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FED329E75;
	Fri, 31 Oct 2025 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PfpXZtvn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96729AB1D;
	Fri, 31 Oct 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947601; cv=none; b=IHzdNPSdQW+gmq+VampRnJGkWhU9Rd0WGZg3a5L58fPCpJSO0VOm/kXzrXaptS9hmY5CEH6GGV5jxHuAFXYxXEpa7CQQJwYrcXSH31Hygt+jEb3eUOoD6vCmUT6+COb9xmbZmXqD0VniRaouSUSoyiL8rTC/PxJFWearVQKPlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947601; c=relaxed/simple;
	bh=onBh5SYfjVLmM64wmn6+jzDOZVi9NhTvedAeeCiQ26o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RHMy2XPlXMf6wjvwKkz3MklXnmeSwiT93xUebRgXu+JBisA5M8t3NWmmg40xty+oL3Trxqwy7NzNDmvHZxOKkUSYt0t3dIL/hkhVFNIlHVX/OC24Y9wm7/oJRLKoxVjX6WkoqR4sQrRQsRR6yJneCpDrL2TQsyG2aewQjJaV+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PfpXZtvn; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyvqc4pZvzm0jvN;
	Fri, 31 Oct 2025 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761947593; x=1764539594; bh=uXjt1PIgL++w9J2bxSrpubLv
	4wa5nccK/nxczrMMWwo=; b=PfpXZtvnMxvGNk3lGDGVYiX6WLWep/NkMqmtYZyH
	vkuNuRQ94R4uq6xUbhMoWvBl8kmylTflWqiCZu0xphtRp5Pw33pImArdcIkmnDnL
	5gpItOnIIJECMGs980aYxr54/cG5WNvZxhKKXiYAmO1uYEjcGqJqnI7+DaAHL6ti
	PttPZMm5gptgydTYwg24heia5Q7smAe97em7jkzEcFVQll0iRGHq0jp6/0HQP2V0
	i2Uyk8OupOVZhlIdTmUrOWbtdf9aSD8GN1mKoEI9omWQO4co+ga4Tw/kr5yr/QZx
	iRfk/9U/IlSc2BAoFQrdP7d/bAKt8KdgaoScZNl3Gu0fJg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GM97819f3f7R; Fri, 31 Oct 2025 21:53:13 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyvqM48b0zm0pL4;
	Fri, 31 Oct 2025 21:53:02 +0000 (UTC)
Message-ID: <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Date: Fri, 31 Oct 2025 14:53:00 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] block: introduce blkdev_report_zones_cached()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-10-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> Introduce the function blkdev_report_zones_cached() to provide a fast
> report zone built using the blkdev_get_zone_info() function, which gets
> zone information from a disk zones_cond array or zone write plugs.
> For a large capacity SMR drive, such fast report zone can be completed
> in a few millioseconds compared to several seconds completion times
> when the report zone is obtained from the device.

millioseconds -> milliseconds

Does retrieving the cached zone information really require multiple
milliseconds instead of only a few microseconds?
> For zoned device that do not use zone write plug resources,

zoned device -> zoned devices

> +static inline bool disk_need_zone_resources(struct gendisk *disk)
> +{
> +	/*
> +	 * All mq zoned devices need zone resources so that the block layer
> +	 * can automatically handle write BIO plugging. BIO-based device drivers
> +	 * (e.g. DM devices) are normally responsible for handling zone write
> +	 * ordering and do not need zone resources, unless the driver requires
> +	 * zone append emulation.
> +	 */
> +	return queue_is_mq(disk->queue) ||
> +		queue_emulates_zone_append(disk->queue);
> +}

Today queue_is_mq() returns true for request-based queues only. Since
this is the terminology used elsewhere in the block layer, maybe change 
"mq zoned devices" into "request-based zoned block devices"?

>   static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
>   {
>   	return 1U << disk->zone_wplugs_hash_bits;
> @@ -962,6 +975,68 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
>   }
>   EXPORT_SYMBOL_GPL(blkdev_get_zone_info);
>   
> +/**
> + * blkdev_report_zones_cached - Get cached zones information
> + * @bdev:     Target block device
> + * @sector:   Sector from which to report zones
> + * @nr_zones: Maximum number of zones to report
> + * @cb:       Callback function called for each reported zone
> + * @data:     Private data for the callback function
> + *
> + * Description:
> + *    Similar to blkdev_report_zones() but instead of calling into the low level
> + *    device driver to get the zone report from the device, use
> + *    blkdev_get_zone_info() to generate the report from the disk zone write
> + *    plugs and zones condition array. Since calling this function without a
> + *    callback does not make sense, @cb must be specified.
> + */
> +int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
> +			unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> +	struct gendisk *disk = bdev->bd_disk;
> +	sector_t capacity = get_capacity(disk);
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	unsigned int idx = 0;
> +	struct blk_zone zone;
> +	int ret;
> +
> +	if (!cb || !bdev_is_zoned(bdev) ||
> +	    WARN_ON_ONCE(!disk->fops->report_zones))
> +		return -EOPNOTSUPP;
> +
> +	if (!nr_zones || sector >= capacity)
> +		return 0;
> +
> +	/*
> +	 * If we do not have any zone write plug resources, fallback to using
> +	 * the regular zone report.
> +	 */
> +	if (!disk_need_zone_resources(disk)) {
> +		struct blk_report_zones_args args = {
> +			.cb = cb,
> +			.data = data,
> +			.report_active = true,
> +		};
> +
> +		return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
> +	}
> +
> +	for (sector = ALIGN(sector, zone_sectors);
> +	     sector < capacity && idx < nr_zones;
> +	     sector += zone_sectors, idx++) {

Please change "sector = ALIGN(sector, zone_sectors)" into an something
based on bdev_offset_from_zone_start(), e.g. the following code:

	sector += zone_sectors - 1;
	sector -= bdev_offset_from_zone_start(bdev, sector);

Thanks,

Bart.

