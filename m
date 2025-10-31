Return-Path: <linux-btrfs+bounces-18486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0182EC26F9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F111B27FE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FC2E6105;
	Fri, 31 Oct 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lPApnpsV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8717C211;
	Fri, 31 Oct 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944681; cv=none; b=orjmDS8+bSE1yVDJmf9/YQizIAD4mmV2FGGMP3cLRpamsSnaNpzQohTZllm7ka1+4dlyo5W45bluNFQNhU68y3zznV9Mu2DFoyYWugUifa/qvGI+SIyF46OlR9xALrLcNvHe96j3az4+Rl5JvZSZhluvM/WaI7v1p2qTWsmsZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944681; c=relaxed/simple;
	bh=gfe6RoFhh46V3gf8J46LpHyAzsUw8u6XsuHiPmnI9QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IYRrJZ+m+y1VdIKmqBDwy4tBYQs6E/6w5MNp5CPmz0GvNP9WkX6GgX8oI+SOH0avl/nL2j2zce17b8kU9Xb+RFfMJ2kbbVutSLpiaQC7xuKQ3xXFdpSsEKXo8Ebl89lNLTWAXiY9aDaZRCmIxhEey0eeqXe+kP/0pRSBsnT70AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lPApnpsV; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cytlV600FzlvRxT;
	Fri, 31 Oct 2025 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761944676; x=1764536677; bh=/c16dfflmy6RT66JO+WNLJvb
	pbI4XJjSz2VckP1AEkA=; b=lPApnpsVizIyhtRM8VRTmGlURuDIpT+Gac5CISyG
	wM1+kvE6tEcQUSuBFEcV/3mxhBEKErljRSh8C1J8uH/UM5x3+braVwiZi9DTet4f
	P5oocPTKp5xtxUWzA/sDBeJrEUbAbDWetZWYOMkRZwyiZpNDYNT2MNue8H3txL8h
	jZb51wqP2UDMyeD/f8XB9l5kx2pJUXAPDxY2nQwXOJrB0GHhMDqAsOMITXYrUwjD
	b0qJDRA5xY/Z1e6LDNWbrXiJqvX5t3HZ3WFjmnFzY8AN2dgfthK8OBuT82tYOJ/5
	gQ0IyyIafjPgpIBp+EcrP7yCj1X5Jk0TXA45BnZDyPFGeA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AEPnnxVFG9zL; Fri, 31 Oct 2025 21:04:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cytlF0jSlzlvm7K;
	Fri, 31 Oct 2025 21:04:24 +0000 (UTC)
Message-ID: <86891fd3-b850-4835-8a53-d1a2425c70e7@acm.org>
Date: Fri, 31 Oct 2025 14:04:23 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] block: use zone condition to determine conventional
 zones
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
 <20251031061307.185513-7-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> zone. This increases the memory usage from 1 bit per zone to 1 bytes per

1 bytes -> 1 byte

> +bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
> +{
> +	struct gendisk *disk = bdev->bd_disk;
> +	unsigned int zno = disk_zone_no(disk, sector);
> +	bool is_seq = false;
> +	u8 *zones_cond;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return false;
> +
> +	rcu_read_lock();
> +	zones_cond = rcu_dereference(disk->zones_cond);
> +	if (zones_cond)
> +		is_seq = zones_cond[zno] != BLK_ZONE_COND_NOT_WP;
> +	rcu_read_unlock();
> +
> +	return is_seq;
> +}
> +EXPORT_SYMBOL_GPL(bdev_zone_is_seq);

'zno' should be compared to the size of the zones_cond[] array before
using 'zno' as an array index.

>   static int disk_revalidate_zone_resources(struct gendisk *disk,
> -					  unsigned int nr_zones)
> +				struct blk_revalidate_zone_args *args)
>   {
>   	struct queue_limits *lim = &disk->queue->limits;
>   	unsigned int pool_size;
>   
> +	args->disk = disk;
> +	args->nr_zones =
> +		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
> +
> +	/* Cached zone conditions: 1 byte per zone */
> +	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
> +	if (!args->zones_cond)
> +		return -ENOMEM;

Why args->nr_zones as array size instead of args->nr_conv_zones? The
patch description says that this array is only used for conventional
zones.

>   	/*
>   	 * Some devices can advertize zone resource limits that are larger than

advertize -> advertise

Thanks,

Bart.

