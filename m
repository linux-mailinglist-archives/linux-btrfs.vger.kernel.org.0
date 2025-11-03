Return-Path: <linux-btrfs+bounces-18528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CAC2A210
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 07:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2964E2BC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073228DF07;
	Mon,  3 Nov 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS1HFYsj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239342AE70;
	Mon,  3 Nov 2025 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149622; cv=none; b=W2JxzC1j6+7MtGrTV5KnBuLw2kXIP44Jd91ypx4TA3oF2AKRFfO4VL7+xLNpG7aa3PwQeBxtkZQqr3bQFZOmXwGhK5ksrW8GyaFq0AU7cTXhIFKTwH7dF50b68QwXW3RSYbJspGwS1nduSdQhqK5Pe2j/6AU1Nhqh26phQNUc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149622; c=relaxed/simple;
	bh=p2Qn4po+ucZZpdF+4sraqP/e42fkPU8F3JmWnvC9xhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Muy/LYb8OfLVCRa/arewkBRpHx1KaO0LrkAfDh8wn9ynU6vRIiOvX7CEFuBf/8j8y9Zlpv4NbsWvqVpeW2b0vXu/ClTFYZhhu3TSqHurY1+Ixqt15EmSIMUgACmTWz7tpFMcRrgFG7ufq1S4TgCfVuZUE6nPpjG9NYc2j/0wzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS1HFYsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C97C4CEFD;
	Mon,  3 Nov 2025 06:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149619;
	bh=p2Qn4po+ucZZpdF+4sraqP/e42fkPU8F3JmWnvC9xhE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cS1HFYsjpa1jSq5E899UEJI+QpjsxEPIS/p8PgTl5xhMRcfHXoVoGRgo08hFcggFZ
	 H3XF6d8yT2xLdjp6aUPAOIFS7brVlkAbJEnwUoT+vcPUWIRIcQscYaS3xczCy5dMQp
	 C9D87r7q59xQrjFrdziFaIhSjTajj2ngyBAJ0MRiALGeN+XMdA+GTrMFJXOOzHKseN
	 jERIRt/6sOFEB+jHsEjEe4z2Mwn4IF0UR3cvf9B76a8REvXl4w3jUgteZN0aIJ+7ZQ
	 +qbaNN+9OfoqyTvG1+4v+zQ0VMKgp0r6EQsY6rPRzGuNcSIpQayoORPVkJC8lxycX4
	 p7o/RjFCVs00Q==
Message-ID: <e899d483-200a-4900-b272-497ccf3be3bb@kernel.org>
Date: Mon, 3 Nov 2025 15:00:15 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] block: use zone condition to determine conventional
 zones
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
 <20251031061307.185513-7-dlemoal@kernel.org>
 <86891fd3-b850-4835-8a53-d1a2425c70e7@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <86891fd3-b850-4835-8a53-d1a2425c70e7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 06:04, Bart Van Assche wrote:
>>   static int disk_revalidate_zone_resources(struct gendisk *disk,
>> -					  unsigned int nr_zones)
>> +				struct blk_revalidate_zone_args *args)
>>   {
>>   	struct queue_limits *lim = &disk->queue->limits;
>>   	unsigned int pool_size;
>>   
>> +	args->disk = disk;
>> +	args->nr_zones =
>> +		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
>> +
>> +	/* Cached zone conditions: 1 byte per zone */
>> +	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
>> +	if (!args->zones_cond)
>> +		return -ENOMEM;
> 
> Why args->nr_zones as array size instead of args->nr_conv_zones? The
> patch description says that this array is only used for conventional
> zones.

The bitmap before was of nr_zones bits, because conventional zones can be
anywhere in the LBA space. The same is still true using zone conditions. We need
one condition per zone for all zones.

-- 
Damien Le Moal
Western Digital Research

