Return-Path: <linux-btrfs+bounces-8092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651997B3B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F31C23AFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B5185E6E;
	Tue, 17 Sep 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W664uhKa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B996186298;
	Tue, 17 Sep 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594696; cv=none; b=dbmtQIgxBjhj373xrxyfIayoKT/K7JcSQhkCd8cAC5QUsldh9836BYvKhfRFByl8nDOuPAgPRvLrchH7ja0xAket3BCbr11k4YWxub288fAu0s2IYrCbVGBDnafQPEFt8wAy8lm+khuDwzQRUNENEq3EFNcuPAAtv3eVifmIbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594696; c=relaxed/simple;
	bh=PpSt5bi7zgx6n42erMIO++zOiEguil8UeQx1geZDx+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtcSVngpg4oNsfTZ6aOOlvFBeBkyzFcVbpnVTXsVCA/GhCqzzyz3sVFJQbKOMbDs2hZOPH+mEEP3PEQ83wiZSt2zEZbdgVGNc+JxcpJrvD0mkpLZWUF7Qq1QArdvkr1XYbgKrd8PrFztDRTQNz5sWicl5xtbvET8AAn1UdBRmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W664uhKa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso58476015e9.0;
        Tue, 17 Sep 2024 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726594692; x=1727199492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJR6KsPb+sMwPPa8GP9YpHwKRtIubZIdAh4KhDCN8B0=;
        b=W664uhKa6jdjpB+K7dNX1uZEa7Q3rfhQ6dhCzjVp0n3RgYZoS96dfHkuIe2OsUi7We
         xSM/PKvvlYJC2vaVtX6sRH68dG2f8NEdBuK9RrAPvubTIRdAD4lVfsIP14q5wTtNcyRu
         pvFoW6BMokBvaryBqtvq/C+/7ZRzG7IT5t8zrGn8pFB4QrRly1GWy9CKz3woneDnBt6F
         ROdsx3tpDzzLKdhYy3/4cWrWXj449ImxAFqugThurzp8FLTM4rOB5bKxHbRG2QKxHuNh
         X87NSl4rpjqmypNpKwFYqojmMY4FVOxkzMDGjx2kJzJnzQYBI1jYhstF5P9VBQiend+Z
         iWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726594692; x=1727199492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJR6KsPb+sMwPPa8GP9YpHwKRtIubZIdAh4KhDCN8B0=;
        b=sjem018yRCEX+Th/cS3RD8MEeW5dTDs2XjMMtZTX4+pZfzoLUne7y9ABZgW7GQfSUZ
         RVo3l744dBbYZM6Re9FtNhMr9WR06ape9/y+XbHES5jo53+6J2aM0RsNuAJgGwuMskDc
         og2ix6uhujV53QYYKtDV2g9WM2NaCQE7lh0D0F07WzgQ9/cgkmEaQeLa8yV7gDPXfu2Y
         vg+HWs8LJzYhL/nFt83UXW2tFBZA58FK9wbkbUAcu2y0YYP20wStj1bw/D5lb1W/W53j
         DFPXcIRNmJgbyzAntfJX5mlkJi5zLc7gnCkI6ioN+rw1lnEsV/TYb12NJykWQlzLnIlN
         3M4A==
X-Forwarded-Encrypted: i=1; AJvYcCUP/lS1HZ9Zkn4aCiFev40BvQ4hFix1ZonKwql52sdVKibi2iftw5QuknzjJ/zmDmbSikItFmraOybQUoHC@vger.kernel.org, AJvYcCX2tF970wh5k5F59c3GZls4rGfesBngOQN3D6ftacnZwkK8ZTt83xOjC12fnJB4ltnZhQn/0TY/fr0BXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99aXHeMxXJ1sfcxYd/Lom3x0ozqbgrZoAZbadagY0t9qEDSw4
	OdfKTc2yvtfgHwYlaZWlB6os1bPV1CvST/8IcBFBDbKBhVBCJCrX
X-Google-Smtp-Source: AGHT+IF3iclvo0qq6Xp+vK+h6Irojon6mIFMlmZ9JKYzrketr6QNBqBYOHtPtHVMW0H6fbpD4mOv2A==
X-Received: by 2002:adf:f943:0:b0:374:ca1f:e0bb with SMTP id ffacd0b85a97d-378c2d072e9mr10279394f8f.24.1726594692133;
        Tue, 17 Sep 2024 10:38:12 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22e6540sm110919955e9.21.2024.09.17.10.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 10:38:11 -0700 (PDT)
Message-ID: <fc2adaec-adaa-4b96-a558-17a968a10f7c@gmail.com>
Date: Tue, 17 Sep 2024 19:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] btrfs: Don't block system suspend during fstrim
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
 <20240916125707.127118-3-luca.stefani.ge1@gmail.com>
 <20240917162431.GC2920@twin.jikos.cz>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20240917162431.GC2920@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/09/24 18:24, David Sterba wrote:
> On Mon, Sep 16, 2024 at 02:56:15PM +0200, Luca Stefani wrote:
>> Sometimes the system isn't able to suspend because the task
>> responsible for trimming the device isn't able to finish in
>> time, especially since we have a free extent discarding phase,
>> which can trim a lot of unallocated space, and there is no
>> limits on the trim size (unlike the block group part).
>>
>> Since discard isn't a critical call it can be interrupted
>> at any time, in such cases we stop the trim, report the amount
>> of discarded bytes and return failure.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
>> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> 
> I went through the cancellation points, some of them don't seem to be
> necessary, eg. in a big loop when some function is called to do trim
> (extents, bitmaps) and then again does the signal and freezing check.
> 
> Next, some of the functions are called from async discard and errors are
> not checked: btrfs_trim_block_group_bitmaps() called from
> btrfs_discard_workfn().
Both btrfs_trim_block_group_bitmaps and btrfs_trim_block_group_extents 
ret codes are never checked indeed in btrfs_discard_workfn. I'll fix 
that up in another CL.
> 
> Ther's also check for signals pending in trim_bitmaps() in
> free-space-cache.c. Given that the space cache code is on the way out we
> don't necesssarily need to fix it but if the patch gets backported to
> older kernels it still makes sense.
Ah I missed this one, will fix it.
There's a few more instances of fatal_signal_pending but I don't know if 
they should be translated or not, will focus on the one you mentioned 
and trim_no_bitmap which seems to do similar checks for fatal signals.
> 
>> ---
>>   fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 79b9243c9cd6..cef368a30731 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/percpu_counter.h>
>>   #include <linux/lockdep.h>
>>   #include <linux/crc32c.h>
>> +#include <linux/freezer.h>
>>   #include "ctree.h"
>>   #include "extent-tree.h"
>>   #include "transaction.h"
>> @@ -1235,6 +1236,11 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
>>   	return ret;
>>   }
>>   
>> +static bool btrfs_trim_interrupted(void)
>> +{
>> +	return fatal_signal_pending(current) || freezing(current);
>> +}
>> +
>>   static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>>   			       u64 *discarded_bytes)
>>   {
>> @@ -1316,6 +1322,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>>   		start += bytes_to_discard;
>>   		bytes_left -= bytes_to_discard;
>>   		*discarded_bytes += bytes_to_discard;
>> +
>> +		if (btrfs_trim_interrupted()) {
>> +			ret = -ERESTARTSYS;
>> +			break;
>> +		}
>>   	}
>>   
>>   	return ret;
>> @@ -6470,7 +6481,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>>   		start += len;
>>   		*trimmed += bytes;
>>   
>> -		if (fatal_signal_pending(current)) {
>> +		if (btrfs_trim_interrupted()) {
>>   			ret = -ERESTARTSYS;
>>   			break;
>>   		}
>> @@ -6519,6 +6530,11 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>>   
>>   	cache = btrfs_lookup_first_block_group(fs_info, range->start);
>>   	for (; cache; cache = btrfs_next_block_group(cache)) {
>> +		if (btrfs_trim_interrupted()) {
>> +			bg_ret = -ERESTARTSYS;
>> +			break;
>> +		}
>> +
>>   		if (cache->start >= range_end) {
>>   			btrfs_put_block_group(cache);
>>   			break;
>> @@ -6558,6 +6574,11 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>>   
>>   	mutex_lock(&fs_devices->device_list_mutex);
>>   	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +		if (btrfs_trim_interrupted()) {
>> +			dev_ret = -ERESTARTSYS;
> 
> This one seems redundant.
> 
>> +			break;
>> +		}
>> +
>>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>>   			continue;
>>   
>> -- 
>> 2.46.0
>>


