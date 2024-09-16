Return-Path: <linux-btrfs+bounces-8056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09126979FC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3071C2143C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274861547D5;
	Mon, 16 Sep 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQQM+O+E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AC34CC4;
	Mon, 16 Sep 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484029; cv=none; b=W58y1GbmKave3HUiGUQCo+cdxBbkTApY3cHYjMUayAeBh8oRa/dFANal98D/l09x2NQ6Vudb43ZoAP4rcX0Y6ETRe2fHwbw3nYEnskIm5mItMSAeEf+z9Nme26kSf9j1fDBlmTh1DyL27RRJYzmh7eRJXsVjjWgjwHzCJTQ3dek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484029; c=relaxed/simple;
	bh=M27tFy/xv/lhL1/N8YSf0pQW80kUKOu5QV22hqDaR54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CECJkmj7P6WlCSxie7mEaf/VdO7N38JmpR3z+g5ErNHGqo9MJeYMlCLwZGRoSYiBWiBGJ+osRkiboElFG4rCfLgvUuExmrwC+NQ05G+E3TRY+jjMTtKgYVv1gMqkBu9Ubro71cHYfLBsj/uA2J6yCqJJ1qcDwfskIPDb6bkdIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQQM+O+E; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c8cef906so3369120f8f.2;
        Mon, 16 Sep 2024 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726484026; x=1727088826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkGRs00oiR9JbeMAEVVxz3k2WHxYFEfv+hngD8++RO8=;
        b=FQQM+O+Er8og8sxnHntGr1u+nLU8gwTr9e54Fyvx08UVbTMgdyF5CXksqOBWzT6HFz
         c30BlaX4Dbf8pOVigdEX1KSfJS/bppelKcmpnwlGmnK2PmfIPJx6Nr8Y/M3G7mg8bqRe
         /6OT/I4CzhQXErVY0+9Rwr+wX37bT0qkcMXa6F8j14QwvYqb5FQAbW51SjPfCG+1+EkB
         gbJxDUDKii8eW/d11xy+R4cXSQxCtAQLyoNT0Weoi9VfiZOJ5xGxBtIgQ6eh6XKjmRr0
         md7Eg5KdIrasIz0Kh1cn98YlR8GGfR08o6l4dgQBpthpAfe2qRepuK/yjnhKbCZHg9ZS
         0tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726484026; x=1727088826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkGRs00oiR9JbeMAEVVxz3k2WHxYFEfv+hngD8++RO8=;
        b=cpM1/E8inJuYiREcAjVtrbqE1XuqJ1LZGSW4hDZsQsm/pVV/0rf5rWJCpeb9UxWQSF
         UGDmtDylZA/7GDk9DplajaaZ2dQrbxYv7DwYKY5EimdagIIgPW3Gj5QRFa/sw7YyOMjV
         1b5T3UUa+OlZUBKLcsHzzfBavmGETWpfU6g9TMKPatVcOgTL9rKz/kWKWscdh8MctfDy
         8aXLmUYAfZ9PZAX44qWNeMyiG/24Xe4+OVyGcuVVandeHvIh7+D3So8k2QHlsXCKoaWe
         WZFnfzdsLPruyhrDJSoIAmMVUqj7FdyLzUg29XpSsweCCYpjmeq78mGKeNB3iOT6fhQX
         fY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUksnBkY8z7zMCGMWYy6fkZvzkJS1gqAPhU9TzggNH3o8ruH6obOQQMKv+8w4ZGaWA0GCi0Z/CU6tt73Q==@vger.kernel.org, AJvYcCWa+pyiLc99gghiy3K9hbfTP4Wa490UgWtFwkn90J4t0QEUnaxbHQoMQ4o87QE1CG5f2V8sOAb1zDG9CZnC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywame+jIixa9gH3YsjBcPf+ViRkNLUszenC3mfzqo85S781zz5E
	Ul7pRWAqLqZC6B2W99p9plcdcqvTIO4jMA1JsEscGyOi3hoXRI8W
X-Google-Smtp-Source: AGHT+IGwRpO/cnzdEcp+wf02AYfwOz65YQtdLdvBBH+Ncrth4XHsYfEeHDAW8JtirFCNytUIoAhCQw==
X-Received: by 2002:a05:6000:18a9:b0:374:c6af:165f with SMTP id ffacd0b85a97d-378c2cfec9fmr11364665f8f.12.1726484025734;
        Mon, 16 Sep 2024 03:53:45 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e62989024sm26270725e9.36.2024.09.16.03.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:53:45 -0700 (PDT)
Message-ID: <9d81c1b9-60d2-419d-ae9b-96dbb92442b9@gmail.com>
Date: Mon, 16 Sep 2024 12:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] btrfs: Don't block system suspend during fstrim
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
 <20240916101615.116164-4-luca.stefani.ge1@gmail.com>
 <44534dea-0baf-420b-a2c2-0ee15db7298a@suse.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <44534dea-0baf-420b-a2c2-0ee15db7298a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/09/24 12:41, Qu Wenruo wrote:
> 
> 
> 在 2024/9/16 19:46, Luca Stefani 写道:
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
>> ---
>>   fs/btrfs/extent-tree.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index cbe66d0acff8..ab2e5d366a3a 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/percpu_counter.h>
>>   #include <linux/lockdep.h>
>>   #include <linux/crc32c.h>
>> +#include <linux/freezer.h>
>>   #include "ctree.h"
>>   #include "extent-tree.h"
>>   #include "transaction.h"
>> @@ -1235,6 +1236,11 @@ static int remove_extent_backref(struct 
>> btrfs_trans_handle *trans,
>>       return ret;
>>   }
>> +static bool btrfs_trim_interrupted(void)
>> +{
>> +    return fatal_signal_pending(current) || freezing(current);
>> +}
>> +
>>   static int btrfs_issue_discard(struct block_device *bdev, u64 start, 
>> u64 len,
>>                      u64 *discarded_bytes)
>>   {
>> @@ -1319,6 +1325,11 @@ static int btrfs_issue_discard(struct 
>> block_device *bdev, u64 start, u64 len,
>>           start += bytes_to_discard;
>>           bytes_left -= bytes_to_discard;
>>           *discarded_bytes += bytes_to_discard;
>> +
>> +        if (btrfs_trim_interrupted()) {
>> +            ret = -ERESTARTSYS;
>> +            break;
>> +        }
>>       }
>>       return ret;
>> @@ -6473,7 +6484,7 @@ static int btrfs_trim_free_extents(struct 
>> btrfs_device *device, u64 *trimmed)
>>           start += len;
>>           *trimmed += bytes;
>> -        if (fatal_signal_pending(current)) {
>> +        if (btrfs_trim_interrupted()) {
>>               ret = -ERESTARTSYS;
>>               break;
>>           }
>> @@ -6522,6 +6533,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, 
>> struct fstrim_range *range)
>>       cache = btrfs_lookup_first_block_group(fs_info, range->start);
>>       for (; cache; cache = btrfs_next_block_group(cache)) {
>> +        if (btrfs_trim_interrupted())
>> +            break;
>> +
> 
> Please update @bg_ret return value.
Done in v5.
> 
>>           if (cache->start >= range_end) {
>>               btrfs_put_block_group(cache);
>>               break;
>> @@ -6561,6 +6575,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, 
>> struct fstrim_range *range)
>>       mutex_lock(&fs_devices->device_list_mutex);
>>       list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +        if (btrfs_trim_interrupted())
>> +            break;
>> +
> 
> The same here, please update @dev_ret.
ditto.
> 
> Thanks,
> Qu
>>           if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>>               continue;


