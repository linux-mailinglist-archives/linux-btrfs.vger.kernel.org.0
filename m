Return-Path: <linux-btrfs+bounces-1011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F368166D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 07:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F53B21DE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371C26131;
	Mon, 18 Dec 2023 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loBrPuyc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A97464;
	Mon, 18 Dec 2023 06:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCEC433C8;
	Mon, 18 Dec 2023 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702882389;
	bh=EpFEN3Jue2G6Rxerxg89hbnN15oJOVy46RhaWGQO2tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=loBrPuycmVkyYVqG8sgfHh3oEDZfWG5B8CoIyakdwRnEweatH2xsCuIZr02Fy23+s
	 NP6GBo2huii33qSC8iG8JeB8qFZasdKInhhYftE3Q8ChdHj8/tCwUsmKJl6c8YLKxy
	 cVlJTOYI8GtA3yDDTwe6nVlimJa8Rz5X2BUKqoUuQwFaMSrfaStI0bPQlO9a2rflyi
	 xT2Ps/TW6alm8uF+2a2DYLo5ROKLijEteSNVxVnWCGFPt3iup5B11HrcZF/360Z7Jf
	 zAUZNPBt9TAyJg61SfSNPXKR06JSvPTEKJqzevSpQ10Jd357eLVI5OPHS0/Yf/Iojn
	 MqyxR4tcyMymA==
Message-ID: <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org>
Date: Mon, 18 Dec 2023 15:53:06 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Content-Language: en-US
To: =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
 "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
 =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-4-hch@lst.de>
 <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/18 15:15, Ed Tsai (蔡宗軒) wrote:
> Hi Christoph,
> 
> some minor suggestions:
> 
> On Sun, 2023-12-17 at 17:53 +0100, Christoph Hellwig wrote:
>>
>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>> index 198d38b53322c1..260b5b8f2b0d7e 100644
>> --- a/drivers/md/dm-table.c
>> +++ b/drivers/md/dm-table.c
>> @@ -1579,21 +1579,18 @@ bool dm_table_has_no_data_devices(struct
>> dm_table *t)
>>  	return true;
>>  }
>>  
>> -static int device_not_zoned_model(struct dm_target *ti, struct
>> dm_dev *dev,
>> -				  sector_t start, sector_t len, void
>> *data)
>> +static int device_not_zoned(struct dm_target *ti, struct dm_dev
>> *dev,
>> +			    sector_t start, sector_t len, void *data)
>>  {
>> -	struct request_queue *q = bdev_get_queue(dev->bdev);
>> -	enum blk_zoned_model *zoned_model = data;
>> +	bool *zoned = data;
>>  
>> -	return blk_queue_zoned_model(q) != *zoned_model;
>> +	return bdev_is_zoned(dev->bdev) != *zoned;
>>  }
>>  
>>  static int device_is_zoned_model(struct dm_target *ti, struct dm_dev
>> *dev,
>>  				 sector_t start, sector_t len, void
>> *data)
> 
> Seems like the word "model" should also be remove here.
> 
>>  {
>> -	struct request_queue *q = bdev_get_queue(dev->bdev);
>> -
>> -	return blk_queue_zoned_model(q) != BLK_ZONED_NONE;
>> +	return bdev_is_zoned(dev->bdev);
>>  }
>>  
>>  /*
>> @@ -1603,8 +1600,7 @@ static int device_is_zoned_model(struct
>> dm_target *ti, struct dm_dev *dev,
>>   * has the DM_TARGET_MIXED_ZONED_MODEL feature set, the devices can
>> have any
>>   * zoned model with all zoned devices having the same zone size.
>>   */
>> -static bool dm_table_supports_zoned_model(struct dm_table *t,
>> -					  enum blk_zoned_model
>> zoned_model)
>> +static bool dm_table_supports_zoned(struct dm_table *t, bool zoned)
>>  {
>>  	for (unsigned int i = 0; i < t->num_targets; i++) {
>>  		struct dm_target *ti = dm_table_get_target(t, i);
>> @@ -1623,11 +1619,11 @@ static bool
>> dm_table_supports_zoned_model(struct dm_table *t,
>>  
>>  		if (dm_target_supports_zoned_hm(ti->type)) {
>>  			if (!ti->type->iterate_devices ||
>> -			    ti->type->iterate_devices(ti,
>> device_not_zoned_model,
>> -						      &zoned_model))
>> +			    ti->type->iterate_devices(ti,
>> device_not_zoned,
>> +						      &zoned))
>>  				return false;
>>  		} else if (!dm_target_supports_mixed_zoned_model(ti-
>>> type)) {
>> -			if (zoned_model == BLK_ZONED_HM)
>> +			if (zoned)
>>  				return false;
>>  		}
>>  	}
> 
> The parameter "bool zoned" is redundant. It should be removed from the
> above 3 functions
> 
> Additionally, because we no longer need to distinguish the zoned model
> here, DM_TARGET_MIXED_ZONED_MODEL is meaningless. We can also clean up
> its related code.

Nope. The mixed thing is for mixing up non-zoned with zoned models.
For the entire DM code, HM and HA are both treated as HM-like zoned.

-- 
Damien Le Moal
Western Digital Research


