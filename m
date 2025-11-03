Return-Path: <linux-btrfs+bounces-18535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E4C2A50F
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 08:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B71804F0966
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74E29BD90;
	Mon,  3 Nov 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYWrRJ2D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3D298CB7;
	Mon,  3 Nov 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154644; cv=none; b=CWd5OuO55PSEg8s3yBsYQBKo+1KX/w7ORZ7/YK1MJV4T/r6TPLtt6h9EIxfdyn0vNQTXCXoWJrjMQ7Gf0flHYEzDDLA6qPBc3jyFFP0Wxwk7TrAsn0MNZEJsyULnj37lpF5XCgrGM9vgls+2x3sQYJH38obTO5G1V27RsXe3OqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154644; c=relaxed/simple;
	bh=4Z0nKMuf7VyPhF4RUcEACaMRlP3hxFLzOsnTGV5xGbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1mW15OaS19Ir/g+H32QxhAiI5O7C5FM/KuIx37W19l0thlLYs1jsmuTOp4dR5sc7cDz++bT6JpB5yASie5hdTFiERr6pCV8olZv+4C6KlnM/o9X1iz0IbAyp1z6ZLJIxJ+H2efW4Hy+IJZrLyz0Pe5NuPU9eK8ka3o96s+cBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYWrRJ2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AC9C4CEE7;
	Mon,  3 Nov 2025 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154643;
	bh=4Z0nKMuf7VyPhF4RUcEACaMRlP3hxFLzOsnTGV5xGbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pYWrRJ2DOBXKH7w6g7W9FAEECw+TQ2boNGYjR6P/XkjkWsLLYMi0hbKj/ltZ6dl51
	 9qiWL2uXI1rIo/yTXFDfBNLZolAg8aKc8/ORDAdK5RGw2yySqRFVx3m4VaRUknEEct
	 69H7EW9WnY0hPDebQro8qtcuNSr0yuJHxsT2k2K3r6JMFnUVmVkZqLYQsmZVD9nau2
	 K2a0t4YFN23Le3IuRchAJIf4KmRF8LR9yLkYxy+n0x1V1suOX5IYfEOQ52TGBRDhbm
	 sAUHD/y1tG/sn4TVpQu45XnZGB8MDM6DB0tjnA5ergwru5CYi6/cyAm5TcBd1uJV1P
	 yWLQ6qrS+p4dw==
Message-ID: <15c913fd-6c13-4b0b-8277-6d5e3ebe85c0@kernel.org>
Date: Mon, 3 Nov 2025 16:23:58 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Daniel Vacek <neelx@suse.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
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
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
 <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
 <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 16:18, Daniel Vacek wrote:
> On Mon, 3 Nov 2025 at 06:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 11/1/25 02:48, Bart Van Assche wrote:
>>> Hi Damien,
>>>
>>> disk_update_zone_resources() only has a single caller and just below the
>>> only call of this function the following code is present:
>>>
>>>       if (ret) {
>>>               unsigned int memflags = blk_mq_freeze_queue(q);
>>>
>>>               disk_free_zone_resources(disk);
>>>               blk_mq_unfreeze_queue(q, memflags);
>>>       }
>>>
>>> Shouldn't this code be moved into disk_update_zone_resources() such that
>>> error handling happens without unfreezing and refreezing the request
>>> queue?
>>
>> Check the code again. disk_free_zone_resources() if the report zones callbacks
>> return an error, and in that case disk_update_zone_resources() is not called.
>> So having this call as it is cover all cases.
> 
> I understand Bart's idea was more like below:
> 
>> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(str
> uct gendisk *disk,
>>       }
>>
>>   commit:
>> -     return queue_limits_commit_update_frozen(q, &lim);
>> +     ret = queue_limits_commit_update(q, &lim);
>> +
>> +unfreeze:
> 
> +       if (ret)
> +               disk_free_zone_resources(disk);
> 
>> +     blk_mq_unfreeze_queue(q, memflags);
>> +
>> +     return ret;
>>   }
>>
>>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
> 
> And then in blk_revalidate_disk_zones() do this:
> 
>         if (ret > 0) {
>                 ret = disk_update_zone_resources(disk, &args);
>         } else if (ret) {
>                 unsigned int memflags;
> 
>                 pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
> 
>                memflags = blk_mq_freeze_queue(q);
>                disk_free_zone_resources(disk);
>                 blk_mq_unfreeze_queue(q, memflags);
>         }
> 
> The question remains if this looks better?

Hmmm... Matter of taste maybe ?
Personally, I do like better having a single error path that cover all errors in
blk_revalidate_disk_zones().


-- 
Damien Le Moal
Western Digital Research

