Return-Path: <linux-btrfs+bounces-18525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C7AC2A179
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 06:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C00188DDA2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 05:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D628BA95;
	Mon,  3 Nov 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTVi7sYX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B8286D60;
	Mon,  3 Nov 2025 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149122; cv=none; b=OiYo/olNFVK4TxDnFJHKDPplvktAmdoOQ+RV3CQ5wzmoIxqdGQsa4ZcAoBsWsawvEkfC4V/hw2kkAn+ABF9yHlr7l0ZRv3wpewk/1j8KWxZfegPboaD5DVoma9We4YbKxfWi2yQrS8NkMORp1CPMsYo9TuSTwSTFU5/LQP4sEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149122; c=relaxed/simple;
	bh=oxQXBcHnc/6qR2epkavIMIgHRy691/rhW8NxiXt8CoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0wgU8srqBB0wfYMhgjpU3xpYywXQ/aM+jSKwNgokW8TWR27SYHALZqdHY/E1PK68mmGKbT85Tb8zkWye/hSaDqmNNWdVZpsvlx7WGaO7NkUu7ZKw6wckrZLVEvfiVJmqQ/XJsW+X5wcOSeHlrWoXHSNJ24i+eNTnZ87zmB8yNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTVi7sYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADD5C4CEE7;
	Mon,  3 Nov 2025 05:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149120;
	bh=oxQXBcHnc/6qR2epkavIMIgHRy691/rhW8NxiXt8CoI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jTVi7sYXkcHQhPjE/Buo3fxpB19O1VbODJ3EXpO8SGXi/OITbcTFvdjtKMvrtbm1O
	 4Ssd2IXFKo8l1cV3gMTphDB8noMJnfpi+6sN3XtuUYq5HqTVDuT/zB9/d5xj5EsHvT
	 omCSwnuC+7Vi0+/vLKfRUJhDnCxme3xxOwe3NgiQgy3NH+Zg5IOrITnIYZ36w37A7+
	 DlVr7F0lKNI1oDIB7AMFkkiqnYC6a+5V6txUA1NFnWtUZ0jg66PIyqB0zUHsFgD0pj
	 8aE8Ua1HS57b3aBY1JkluR7H7PgSvwANVrjTO/zkqg6rtBNKMbOlR+Nl/D8Nwfmlv8
	 hsKYmwhLwhShA==
Message-ID: <b675e291-c369-4c7e-8fa2-1470ce90f001@kernel.org>
Date: Mon, 3 Nov 2025 14:51:57 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] block: introduce BLKREPORTZONESV2 ioctl
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
 <20251031061307.185513-11-dlemoal@kernel.org>
 <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 01:52, Bart Van Assche wrote:
>> +	case BLKREPORTZONEV2:
>> +		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
>> +			return -EINVAL;
> 
> -EINVAL probably should be changed into something that indicates "not
> supported" rather than "invalid argument"?

Not supported could be confused with the cached report zones not being
supported. It is, but the user cannot specify input flags that are not defined.
This is to ensure that undefined flags are always 0 and that we can use these
going forward when we need to define a new flag.
So EINVAL seems appropriate to me.

> 
>> index dab5d9700898..1441d79a6173 100644
>> --- a/include/uapi/linux/blkzoned.h
>> +++ b/include/uapi/linux/blkzoned.h
>> @@ -82,10 +82,20 @@ enum blk_zone_cond {
>>   /**
>>    * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>>    *
>> - * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
>> + * @BLK_ZONE_REP_CAPACITY: Output only. Indicates that zone descriptors in a
>> + *			   zone report have a valid capacity field.
>> + * @BLK_ZONE_REP_CACHED: Input only. Indicates that the zone report should be
>> + *			 generated using cached zone information. In this case,
>> + *			 the implicit open, explicit open and closed zone
>> + *			 conditions are all reported with the
>> + *			 BLK_ZONE_COND_ACTIVE condition.
>>    */
>>   enum blk_zone_report_flags {
>> +	/* Output flags */
>>   	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>> +
>> +	/* Input flags */
>> +	BLK_ZONE_REP_CACHED	= (1 << 31),
>>   };
> 
> Why 1 << 31 instead of 1 << 1?

Why not ? That separates input and output flags instead of mixing them in
tighter definition.



-- 
Damien Le Moal
Western Digital Research

