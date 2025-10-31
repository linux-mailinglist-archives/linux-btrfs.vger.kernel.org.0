Return-Path: <linux-btrfs+bounces-18469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 936ABC267A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593F01897B4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916E28505A;
	Fri, 31 Oct 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mvnNsEhs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDB306B0D;
	Fri, 31 Oct 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932905; cv=none; b=K+pP0Cwy1lV1W7BvjAU/Zc2syUltwMTrBnpBAsTBe2cagGpiFstwLOeYp8d7ICRVE967tqWVNPpDwZ1rVZJhGt0oO689TZCgeYU8H5TBe4R45Q2NjIVK2P9OXEC974zpAadsO1reIikoxMoA+WZ17bS5RdpLvg6t/jzgys0Xhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932905; c=relaxed/simple;
	bh=TirghRST3T97Ek6HMrDXmUxlQBdHwkN3Ro2bVMgzjlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XziBdy3Lx3gPhccaefTgecyV9qilo1jQMh+GrmTE2t2zriPIJ/YVu3s6z4dqzDDc1o7F6rmmpE0beQ5hBs1BW7j6RAHd8XxQV6NBqZ7lscf8Fjj7XdTYm3sHP3LISPfysAPyWO2cWLV6LfBkJOx2Fc1xlkEecFtWt0ekhOj0fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mvnNsEhs; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cypNw6qsGzlvq50;
	Fri, 31 Oct 2025 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761932894; x=1764524895; bh=nL551B3V05vqyW+XimcHYYij
	1ibWq2M2wbELFVqT4RY=; b=mvnNsEhs1PPWUDvDh1SX4Y+85yPIV55ftsmKpUtx
	KVnPMtra7jXYM48vO8spgPf8PYvKVtDKtRs/W2vjRpaI3tPBqSwDA8sg0mU5GLoP
	+A2WlsZJ0L3olpHgjZY+hi8m/r9bfFHbBC6cmaaK57KjkKDXHGqnTpox8N0j3f2w
	Kv7FROAYchc9W4NAXiiRex4Tp4aFI38ASM4HaiuDVE6YQVnmc3YfBEfvbgFLLYyt
	nNIe18PmEAOOot6mCPZXgnniKmDOCwFblrpa/9FPFORTQXwBN/H6S6CqtDRHqieF
	/aM4eDxaxKcoyaz2Yt7riOOV4J4R1Cn3DmQ/3Gz/8gabtg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id taZA1Dyqq5Qm; Fri, 31 Oct 2025 17:48:14 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cypNg6Wm3zltP0b;
	Fri, 31 Oct 2025 17:48:02 +0000 (UTC)
Message-ID: <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
Date: Fri, 31 Oct 2025 10:48:01 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
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
 <20251031061307.185513-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> Modify disk_update_zone_resources() to freeze the device queue before
> updating the number of zones, zone capacity and other zone related
> resources. The locking order resulting from the call to
> queue_limits_commit_update_frozen() is preserved, that is, the queue
> limits lock is first taken by calling queue_limits_start_update() before
> freezing the queue, and the queue is unfrozen after executing
> queue_limits_commit_update(), which replaces the call to
> queue_limits_commit_update_frozen().
> 
> This change ensures that there are no in-flights I/Os when the zone
> resources are updated due to a zone revalidation.
> 
> Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 5e2a5788dc3b..f3b371056df4 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1516,8 +1516,13 @@ static int disk_update_zone_resources(struct gendisk *disk,
>   {
>   	struct request_queue *q = disk->queue;
>   	unsigned int nr_seq_zones, nr_conv_zones;
> -	unsigned int pool_size;
> +	unsigned int pool_size, memflags;
>   	struct queue_limits lim;
> +	int ret;
> +
> +	lim = queue_limits_start_update(q);
> +
> +	memflags = blk_mq_freeze_queue(q);
>   
>   	disk->nr_zones = args->nr_zones;
>   	disk->zone_capacity = args->zone_capacity;
> @@ -1527,11 +1532,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
>   	if (nr_conv_zones >= disk->nr_zones) {
>   		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
>   			disk->disk_name, nr_conv_zones, disk->nr_zones);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto unfreeze;
>   	}
>   
> -	lim = queue_limits_start_update(q);
> -
>   	/*
>   	 * Some devices can advertize zone resource limits that are larger than
>   	 * the number of sequential zones of the zoned block device, e.g. a
> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(struct gendisk *disk,
>   	}
>   
>   commit:
> -	return queue_limits_commit_update_frozen(q, &lim);
> +	ret = queue_limits_commit_update(q, &lim);
> +
> +unfreeze:
> +	blk_mq_unfreeze_queue(q, memflags);
> +
> +	return ret;
>   }
>   
>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,

Hi Damien,

disk_update_zone_resources() only has a single caller and just below the
only call of this function the following code is present:

	if (ret) {
		unsigned int memflags = blk_mq_freeze_queue(q);

		disk_free_zone_resources(disk);
		blk_mq_unfreeze_queue(q, memflags);
	}

Shouldn't this code be moved into disk_update_zone_resources() such that
error handling happens without unfreezing and refreezing the request
queue?

Thanks,

Bart.

