Return-Path: <linux-btrfs+bounces-18489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444DC270FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC3A4E1EB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913431D39F;
	Fri, 31 Oct 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Vefe9pMP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFF303C8D;
	Fri, 31 Oct 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946841; cv=none; b=G9egusk+TMuS2OuXlHgPmJbtjK53Z1ibSg8Nfdd/mHyAddCWfhDJn5GU2fDbl7wwZ1gZASab3NwPvQOaWlpvRMelACMQUMpZGM9m5oSWho3F4X+FhLIY6LfinK2oBYH6ob48KzgKCHLcERsK4sSyvqKSBtWCuPK3KKyn17GtNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946841; c=relaxed/simple;
	bh=pkLepUgc/ycKjXUaLXzFouEk/r88Urrm91h0FmQ8G8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MNpki+/tK5ITmD4l2xJ/XjgLZIZh13Xb1UJRYRI9Zhcb5UGFjvtBy4hVEGD+wAMvTEET2U58GId/XxKXsefwNJwHoq9tBAN4dKI6wmwIEwyVU+8Ppa3IXnhrPSevH8xVZBrbx+og72tc9crzg1XU9nfztRC9LAgw/tOR4nDyRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Vefe9pMP; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyvY32462zm0pJx;
	Fri, 31 Oct 2025 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761946836; x=1764538837; bh=sQ+JoXonPizc19GDbFjJt0OI
	nnLWi/x4ES7NDAgMyic=; b=Vefe9pMPLaf3cmzjAH8pQ4CEf7qWKKRJGSzxD4yb
	qkGJJyx+P5Vud2/vVVpBjamhCdhJg2cRUH5C7xenYLyF3sl/gG7qMBYPTS6MKtzW
	2SQJFTEMI8mO/rPXhYA6a4gvDHaAX1uRj+8nBQKXO8sU6nbegJS41qE5CYDiGSTL
	04oz0BePVLgb1TOHJ2h2asum0kugCc8M0llXcD4vRc09CL6wxiZ7OCA9MDFSokEI
	Ujuymz3aYlWIpkgZ/MRWSuj4UAMaRwl9dWQTbC/n2jndrV9zVyoE9N+oZEgdK4oO
	phoSid1sl1QWgz8lrZbKwtewKRpSWzrVNRFgVvIe7oh05Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xEmyZrhwTdbZ; Fri, 31 Oct 2025 21:40:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyvXp0TXLzm0pL4;
	Fri, 31 Oct 2025 21:40:24 +0000 (UTC)
Message-ID: <42dc640b-28e9-4706-91dc-dd075e736065@acm.org>
Date: Fri, 31 Oct 2025 14:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
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
 <20251031061307.185513-9-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> +static int blkdev_do_report_zones(struct block_device *bdev, sector_t sector,
> +				  unsigned int nr_zones,
> +				  struct blk_report_zones_args *args)
> +{
> +	struct gendisk *disk = bdev->bd_disk;
> +
> +	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
> +		return -EOPNOTSUPP;
> +
> +	if (!nr_zones || sector >= get_capacity(disk))
> +		return 0;
> +
> +	return disk->fops->report_zones(disk, sector, nr_zones, args);
> +}
> +
>   /**
>    * blkdev_report_zones - Get zones information
>    * @bdev:	Target block device
> @@ -226,19 +242,12 @@ struct blk_report_zones_args {
>   int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>   			unsigned int nr_zones, report_zones_cb cb, void *data)
>   {
> -	struct gendisk *disk = bdev->bd_disk;
>   	struct blk_report_zones_args args = {
>   		.cb = cb,
>   		.data = data,
>   	};
>   
> -	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
> -		return -EOPNOTSUPP;
> -
> -	if (!nr_zones || sector >= get_capacity(disk))
> -		return 0;
> -
> -	return disk->fops->report_zones(disk, sector, nr_zones, &args);
> +	return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
>   }
>   EXPORT_SYMBOL_GPL(blkdev_report_zones);

One change per patch please. Please split this patch into one patch that
introduces the blkdev_do_report_zones() function and another patch with
the remaining changes from this patch.
> +/**
> + * blkdev_get_zone_info - Get a zone information from cached data

"Get a zone information" -> "Get zone information"

> +	sector = sector & (~(zone_sectors - 1));

Please consider changing the above assignment into:

	sector -= bdev_offset_from_zone_start(bdev, sector);

> +	/*
> +	 * If the zone does not have a zone write plug, it is either full or
> +	 * empty, as we otherwise would have a zone write plug for it. In this
> +	 * case, set the write pointer accordingly and report the zone.
> +	 * Otherwise, if we have a zone write plug, use it.
> +	 */
> +	zwplug = disk_get_zone_wplug(disk, sector);
> +	if (!zwplug) {
> +		if (zone->cond == BLK_ZONE_COND_FULL)
> +			zone->wp = sector + zone_sectors;
> +		else
> +			zone->wp = sector;
> +		return 0;
> +	}

According to ZBC-2 the write pointer is invalid for full zones.

Thanks,

Bart.

