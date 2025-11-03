Return-Path: <linux-btrfs+bounces-18531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4501C2A273
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 07:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8421C3A43E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 06:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC60A294A10;
	Mon,  3 Nov 2025 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKSXU+2K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC528D84F;
	Mon,  3 Nov 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150382; cv=none; b=ahCEZuOLsh+Mftn0pe467++1U95+g3QB93O1p9+i+U8s/XOSMVuLG1Zjj/KhRv2dSwl89xjzYzvMr670WCAOdJz26xZZb/WlJeJMMPqBHYX9x39wop/cKG7NdTbJXoGbNIBQSRFj9/8dZeZBn91xiyJmr14igIvqIHYXYnJZcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150382; c=relaxed/simple;
	bh=n6EN2P2gP5X9cBVibE23fs0PdgP3/6dDNF9i/yYXrDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=skSz73KZes1H52WO4IxTTYXvIKoGiMyH5OFq0wih3nWMRmS1CBM4ijaDjELEQhcHkNNCzfgCNKhtutNHc5nr13pQoXhP42N8Py/VJmGzIyeK09MK0c51sY7ZRp29BE6bAV2eGxX1rqoamS8bRtdoG8warWa51Ut4L2cVXp/gw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKSXU+2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C8C4CEFD;
	Mon,  3 Nov 2025 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762150380;
	bh=n6EN2P2gP5X9cBVibE23fs0PdgP3/6dDNF9i/yYXrDU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZKSXU+2KlmgkRvdjhyKMf91LpddVvRgJbcftB10f8mk2CYDCx1MwZG0Q7KJrBq7nB
	 gjo80h0H9U8U/gXeiMAoHddLhgD44D53a25UU3gg1ovFXZ0qSvvXaAtbWCmV00eR1n
	 jhVEQHGazUPtk998upWx+xW/DzK0uHNzaHeecj45g8gGS3TN9vp4YcA/VZxeyoO+7o
	 p/9aV7KduLZeNnf07QwACpqeq+Zvb534q4xsqRYPBAqIWMcwdmJRXXOlj+SZ35ohp0
	 IgL+DCCNg6RimK/WOvNedKg8AQdbodMqmKJ7CVNh5hHJRNHJczweBCEcy1pjbe226p
	 g2ZLsG9OgUN/A==
Message-ID: <02990d98-060e-44b9-8800-b6787449855d@kernel.org>
Date: Mon, 3 Nov 2025 15:12:56 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] block: introduce blkdev_report_zones_cached()
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
 <20251031061307.185513-10-dlemoal@kernel.org>
 <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 06:53, Bart Van Assche wrote:
>> +	for (sector = ALIGN(sector, zone_sectors);
>> +	     sector < capacity && idx < nr_zones;
>> +	     sector += zone_sectors, idx++) {
> 
> Please change "sector = ALIGN(sector, zone_sectors)" into an something
> based on bdev_offset_from_zone_start(), e.g. the following code:
> 
> 	sector += zone_sectors - 1;
> 	sector -= bdev_offset_from_zone_start(bdev, sector);

Why ? That is a lot harder to understand that what we are doing is align to the
zone start. And your proposed code is not correct anyway as we would miss one
zone (the zone containing sector) if sector is not already aligned to the zone
start.

-- 
Damien Le Moal
Western Digital Research

