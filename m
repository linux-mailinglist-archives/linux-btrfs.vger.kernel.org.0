Return-Path: <linux-btrfs+bounces-8055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBA979FC4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF357281152
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D91547E8;
	Mon, 16 Sep 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2uvM/ul"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FB34CC4;
	Mon, 16 Sep 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483879; cv=none; b=r7qKF2Dl6xRQnivp1lbxuBdngnwhLwyMhu0qogoCa9tSKTkDS31wd6XREwoJAFoatZErzRZ+1Tu7GWSJ+0NjZLgOmROOvwLYDsbYVWbd+Kb98hxDxAXkTMFQ6iiEu3Ci923jO6QALPCt8znZO9ZibcTdDSkdcR81EKuXhhQb2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483879; c=relaxed/simple;
	bh=0lRSPxsT9IzVJy7fyz17j7cnS4eIGCPkad4z5jh6uY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKCulTjKu0Te1ZJt7ca7QnUyfL8V2uSEJ0a7C7ZanHdM0NRNv7LYLUbY+T2KS3yKS4H4FxlsHIk5rX/MzwoXx5eapqMkuOinHHKD3FEoeE+wkiJ7KtUpJXXRfijS09SBYWGSCCL+XtLRQnDbACKwaJbGK7GSnXtN8cKjE6/L9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2uvM/ul; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1963cb6so2949197f8f.3;
        Mon, 16 Sep 2024 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726483876; x=1727088676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xhyzobQT8oY8lvw8wg2epKpXu0kbMbMHlKQEvlRZmM=;
        b=Q2uvM/ulOGL2VKfUSB8UqAB06IpGsW+/8Not1VymRrAT8QGV4mzz8ArIWRUD3jPRvg
         RX0OBH039sO6vvDgvIbOyYkc3c4CpJ2wiAHxnQfyy48LkX8oo7p+JbWc6/kY+A3r56r9
         BubhL096i8b84lZ2vaU+8ObzjI47M0U+Qg8aMDcbuXXPg+4BRtDdI/VksSA06H8DnoRT
         4GLBmQo/8ks6EQONQsEWVUKaAROIKvxyKW8WY7aGpOFy8layquO4AxXFCrs9UK6JRAfR
         EqKmD4qPYDADv7Tp2SaebPV4LOC4CbgI0QNyBGF238qK1594dgnBFhRLyQIO1GatJFMV
         vXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483876; x=1727088676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xhyzobQT8oY8lvw8wg2epKpXu0kbMbMHlKQEvlRZmM=;
        b=Kh+8OPh8h/Go3XHuDTziawqdCf7RxlCrn3KLdTzXSTv41GtdrYDQ4gm5/zHwPaxODi
         j9jfGr3wtg/Kvmr6uqcWTWvEBWp7R5IXq/9HeAp3ObT+CO8eXcVila0M9E66906AjrWT
         mno4oqcJS1SpKqjP96XVPvbV6mxQyRBj8fSl+nQLzIOj131qHVKn/rd5VguvfEskPlP7
         +19H2bE3PLZ+r+WF0wvNBevLvb9o6EyeL2kXbvmGyj8nLJNH0GZZQuJSuApZztFFVPqc
         AriR8Pa8uf6/Tv/oAIDgQ1Gn1DIUVPP3w9f0QKt+2uNEOQWv6E6qCeW0ghuUSt41PyHg
         Z6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVi/F1S0hhbKOPnULNAdUYaMUB3d/pj/x8FskxO7lAHHVkk2RBo416ey8f86X9Z/5YECOPZs2Nh95d7MQ==@vger.kernel.org, AJvYcCW8ve8hpE8nbekKE5CPqquEVzlw9ShRSTp5s7KJKEEd5tMocxtKWqSm/kUyTluztofoUugbBp73OBky9f4p@vger.kernel.org
X-Gm-Message-State: AOJu0YwANuyROx60Cc3JtH99pTdQnwrSDvnb85XYTdKtmDR9TFnnhlPp
	3aDOwKpTjIfHdvy9pXgr5FuBz+8xydFUc07Fm/WnJOyw93MkOedM
X-Google-Smtp-Source: AGHT+IH7QxzHW89rg/kQB35L3ZwlK2RGhGIdw3qzSwFe6sx6n3jdVH2YXu/gJ91HKnVgqif6YV/AwA==
X-Received: by 2002:adf:fb85:0:b0:374:ba73:a90b with SMTP id ffacd0b85a97d-378c2cfed2bmr8333094f8f.3.1726483876230;
        Mon, 16 Sep 2024 03:51:16 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9999sm6870236f8f.58.2024.09.16.03.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:51:15 -0700 (PDT)
Message-ID: <cf8647d2-aa92-466d-8f79-494f9bd3e114@gmail.com>
Date: Mon, 16 Sep 2024 12:51:14 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] btrfs: Split remaining space to discard in chunks
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
 <20240916101615.116164-3-luca.stefani.ge1@gmail.com>
 <98991e9d-cce0-48ad-b77c-b7d3eff71dca@suse.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <98991e9d-cce0-48ad-b77c-b7d3eff71dca@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/09/24 12:39, Qu Wenruo wrote:
> 
> 
> 在 2024/9/16 19:46, Luca Stefani 写道:
>> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
>> mostly empty although we will do the split according to our super block
>> locations, the last super block ends at 256G, we can submit a huge
>> discard for the range [256G, 8T), causing a super large delay.
>>
>> We now split the space left to discard based on BTRFS_MAX_DATA_CHUNK_SIZE
>> in preparation of introduction of cancellation signals handling.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
>> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
>> ---
>>   fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index a5966324607d..cbe66d0acff8 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -1239,7 +1239,7 @@ static int btrfs_issue_discard(struct 
>> block_device *bdev, u64 start, u64 len,
>>                      u64 *discarded_bytes)
>>   {
>>       int j, ret = 0;
>> -    u64 bytes_left, end;
>> +    u64 bytes_left, bytes_to_discard, end;
>>       u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
>>       /* Adjust the range to be aligned to 512B sectors if necessary. */
>> @@ -1300,13 +1300,27 @@ static int btrfs_issue_discard(struct 
>> block_device *bdev, u64 start, u64 len,
>>           bytes_left = end - start;
>>       }
>> -    if (bytes_left) {
>> +    while (bytes_left) {
>> +        if (bytes_left > BTRFS_MAX_DATA_CHUNK_SIZE)
>> +            bytes_to_discard = BTRFS_MAX_DATA_CHUNK_SIZE;
> 
> That MAX_DATA_CHUNK_SIZE is only possible for RAID0/RAID10/RAID5/RAID6, 
> by spanning the device extents across multiple devices.
> 
> For each device, the maximum size is limited to 1G (check 
> init_alloc_chunk_ctl_policy_regular()).
> 
> So you can just limit it to 1G instead.
> (If you want, you can also extract that into a macro as a cleanup).
I think SZ_1G is enough for now.
> 
> Furthermore, you can use min() instead of a if ().
> 
> So you only need:
> 
>          bytes_to_discard = min(SZ_1G, bytes_left);
> 
> Otherwise this looks good enough to me.
> If the 1G size is not good enough, we can later tune it to smaller values.
> 
> Personally speaking I think 1G would be enough.
> 
> Thanks,
> Qu
Ack, done in v5
>> +        else
>> +            bytes_to_discard = bytes_left;
>> +
>>           ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
>> -                       bytes_left >> SECTOR_SHIFT,
>> +                       bytes_to_discard >> SECTOR_SHIFT,
>>                          GFP_NOFS);
>> -        if (!ret)
>> -            *discarded_bytes += bytes_left;
>> +
>> +        if (ret) {
>> +            if (ret != -EOPNOTSUPP)
>> +                break;
>> +            continue;
>> +        }
>> +
>> +        start += bytes_to_discard;
>> +        bytes_left -= bytes_to_discard;
>> +        *discarded_bytes += bytes_to_discard;
>>       }
>> +
>>       return ret;
>>   }


