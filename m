Return-Path: <linux-btrfs+bounces-20480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A598CD1C4AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 04:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D208330184F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 03:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3112DEA87;
	Wed, 14 Jan 2026 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7DH0poN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85A944F
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362296; cv=none; b=nr6fpkM58WNn2mnXK6GwJT8j+T0Wr8EXMTWDVMgqmYRUEQkUhnmratc35XtoMtHH0o1HCHRmUdmSY3h+7AAVQS/Ik1yz15aWIfMzP+0yyLUGhDqw/dAe5LpietrNry7s6ukQcJ8GMuyFM6l1i0CjgYE2FtPlKII5x2SgfNiVVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362296; c=relaxed/simple;
	bh=mwJPOedgouBXRnIPcmIeQhjI2m6gWku/P9hoXzOmhGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjMTpV2/rVljgXrJVLcNLX/TfGJcvuE/QXlC3bx9OdzR/+AfUzg1iJKbjBOz06+ios24QgeuDs8DFTranbW2oMIqFymNIVm01ufXc1dCg2U8CaSpdQw5KrdXYRUBiHtv3lMhnrtC/GYbZUJ9WSdsGW+Su5gUepkgTs7qUJtX7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7DH0poN; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-790b12998beso3889607b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768362294; x=1768967094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlGJmR99c0s/yv+Y4foIQWntcWkq5cfejAvdCCNyLts=;
        b=M7DH0poNzHr/8K1F2LYOyL1fhbQI4YAvG88XiwvQWJ/CnifBakjvbY13/tAmPjhO4D
         ktRjUSywnBgZfXl0srnpwpDGUbQaE1o1IpcbVa4EBLwd1r3lLYxw99AtGpGZrrQROf58
         wZ8tCay/i/fwyMHbHmL0Qjn6SuVTlIrBDBTdlly8w1rr83tBzWbWBGtGYQUXxHr7jEuG
         ZDF3+5zinPk1T6H/q/yNEc8i68GkKLxI5vvFTr5vc4F/jEWpDBKLGqYw60/8NA9usOv1
         dXH/WtGb/RA7qAHtReZzprmaQlCJTiB867x/hMILsRDPqsJ18FDMlmq8GeH9V8t782MX
         SP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768362294; x=1768967094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlGJmR99c0s/yv+Y4foIQWntcWkq5cfejAvdCCNyLts=;
        b=jhYV0YMfq8yCUKuBlpT51RmXlXF09lGT5MJ7rvaX+TdyivJqC2q4Mw6G0TufdV8idg
         m5pZqfm1NCKJ8CpKlJUakrgmoyU7kTERYT1TZzjxl0tYpZBmRJW2systxy7k/HT7d4L1
         XPijPD1AlAKF+p3ShLTxFm0KyWvfNZN2nlS9uaYz1DTh9b1iL/Rx84xHuCZo4Odq3H6S
         biYbCUfTL/W/buf7ulza5FHRR6apPq2b/GSIfWcjH6hDAZ7zCPsu5NjNcNWN+p8KWrRf
         TiUz027wUQIygbkMG1gljP0JfpEVrrN0PajprVm7KhRvx3HpvhQIQagYaSNQvmnQ1sPM
         zmuw==
X-Gm-Message-State: AOJu0YzCSqzz1GJC0GHaP/IRlnoKhasB3sgVycZuDZ/5EcR4eHlaxc6h
	Iy57gONlpN73XnmMsqCcyUKZMCju1rQOZ3SeRQSdqyRMEZrRfMDJ2MDet3XzENndm5EKFg==
X-Gm-Gg: AY/fxX7/f65pO0wtcC70Z1lNqUTmuB6iutS70aWhX7meQB9LcTEI+riUZMZX0N7HsXY
	BfwI5eHxz+5/Kz4rWu13xVlRZDjr+AuZAT1QahqXoADyR4Ah9zb5+eJ4CwFl+7xMCCcX7CO2Ygj
	TdODHvK3HDPiyJ1PqBTZcuJi1ra4+cG0FKo8ecgfMGxeI9G4L7PGX1ycJM04CW0fyWFUS8q0Rb6
	03aMqm3tHoA4DbjqThOZSLufj92pS+IGp45NLVpJsaMrEGZdLutUuow87fCM0TCr7b1FREVEd4B
	P+ZzDGAZv5G3leCO2wWVA7Yul3PYHW6Pnbpe85z7g9dRxWQgK0G4VdHonOZKw+0hrjm/fCRjuoO
	w3DUND0+rjhC18dUd/dVGVaAopafNRxFTYc8M2VTidkPUL+lsewZT5fvKyW4EsLAX+ZI1slk3W2
	dvypVpEwhvHikKFw3FsaYtS47ZXA==
X-Received: by 2002:a05:690c:f03:b0:78f:dbdd:6546 with SMTP id 00721157ae682-793a1d6f591mr9688637b3.5.1768362294267;
        Tue, 13 Jan 2026 19:44:54 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dcd4asm87165167b3.52.2026.01.13.19.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 19:44:53 -0800 (PST)
Message-ID: <e4b8626d-160f-4f28-a4dc-c803e2d5823f@gmail.com>
Date: Wed, 14 Jan 2026 11:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] btrfs: fix periodic reclaim condition
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260113060935.21814-2-sunk67188@gmail.com>
 <20260113060935.21814-3-sunk67188@gmail.com>
 <20260113183204.GD972704@zen.localdomain>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20260113183204.GD972704@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/14 02:32, Boris Burkov 写道:
> On Tue, Jan 13, 2026 at 12:07:04PM +0800, Sun YangKai wrote:
>> Problems with current implementation:
>> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>>    negative reclaimable_bytes to trigger reclaim unexpectedly
>> 2. The "space must be freed between scans" assumption breaks the
>>    two-scan requirement: first scan marks block groups, second scan
>>    reclaims them. Without the second scan, no reclamation occurs.
>>
>> Instead, track actual reclaim progress: pause reclaim when block groups
>> will be reclaimed, and resume only when progress is made. This ensures
>> reclaim continues until no further progress can be made. And resume
>> perioidc reclaim  when there's enough free space.
>>
>> Suggested-by: Boris Burkov <boris@bur.io>
>> Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
> 
> Made a small inline suggestion, but you can add
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>> ---
>>  fs/btrfs/block-group.c |  6 +++++-
>>  fs/btrfs/space-info.c  | 21 ++++++++++++---------
>>  2 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index e417aba4c4c7..f0945a799aed 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>>  		u64 used;
>>  		u64 reserved;
>> +		u64 old_total;
>>  		int ret = 0;
>>  
>>  		bg = list_first_entry(&fs_info->reclaim_bgs,
>> @@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>  		}
>>  
>>  		spin_unlock(&bg->lock);
>> +		old_total = space_info->total_bytes;
>>  		spin_unlock(&space_info->lock);
>>  
>>  		/*
>> @@ -1989,13 +1991,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>  			spin_lock(&space_info->lock);
>>  			space_info->reclaim_errors++;
>>  			if (READ_ONCE(space_info->periodic_reclaim))
>> -				space_info->periodic_reclaim_ready = false;
>> +				btrfs_set_periodic_reclaim_ready(space_info, false);
> 
> I think it probably makes more sense to remove this one entirely, since
> it's already false from the sweep, then only set it true if we succeed
> and the total_bytes goes down.

Yes, that makes a lot of sense. Thanks a lot.

>>  			spin_unlock(&space_info->lock);
>>  		}
>>  		spin_lock(&space_info->lock);
>>  		space_info->reclaim_count++;
>>  		space_info->reclaim_bytes += used;
>>  		space_info->reclaim_bytes += reserved;
>> +		if (space_info->total_bytes < old_total)
>> +			btrfs_set_periodic_reclaim_ready(space_info, true);
>>  		spin_unlock(&space_info->lock);
>>  
>>  next:
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 7b7b7255f7d8..7d2386ea86c5 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -2079,11 +2079,11 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
>>  	return unalloc < data_chunk_size;
>>  }
>>  
>> -static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>> +static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>  {
>>  	struct btrfs_block_group *bg;
>>  	int thresh_pct;
>> -	bool try_again = true;
>> +	bool will_reclaim = false;
>>  	bool urgent;
>>  
>>  	spin_lock(&space_info->lock);
>> @@ -2101,7 +2101,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>  		spin_lock(&bg->lock);
>>  		thresh = mult_perc(bg->length, thresh_pct);
>>  		if (bg->used < thresh && bg->reclaim_mark) {
>> -			try_again = false;
>> +			will_reclaim = true;
>>  			reclaim = true;
>>  		}
>>  		bg->reclaim_mark++;
>> @@ -2118,12 +2118,13 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>  	 * If we have any staler groups, we don't touch the fresher ones, but if we
>>  	 * really need a block group, do take a fresh one.
>>  	 */
>> -	if (try_again && urgent) {
>> -		try_again = false;
>> +	if (!will_reclaim && urgent) {
>> +		urgent = false;
>>  		goto again;
>>  	}
>>  
>>  	up_read(&space_info->groups_sem);
>> +	return will_reclaim;
>>  }
>>  
>>  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
>> @@ -2133,7 +2134,8 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
>>  	lockdep_assert_held(&space_info->lock);
>>  	space_info->reclaimable_bytes += bytes;
>>  
>> -	if (space_info->reclaimable_bytes >= chunk_sz)
>> +	if (space_info->reclaimable_bytes > 0 &&
>> +	    space_info->reclaimable_bytes >= chunk_sz)
>>  		btrfs_set_periodic_reclaim_ready(space_info, true);
>>  }
>>  
>> @@ -2160,7 +2162,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>>  
>>  	spin_lock(&space_info->lock);
>>  	ret = space_info->periodic_reclaim_ready;
>> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>>  	spin_unlock(&space_info->lock);
>>  
>>  	return ret;
>> @@ -2174,8 +2175,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>>  	list_for_each_entry(space_info, &fs_info->space_info, list) {
>>  		if (!btrfs_should_periodic_reclaim(space_info))
>>  			continue;
>> -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
>> -			do_reclaim_sweep(space_info, raid);
>> +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
>> +			if (do_reclaim_sweep(space_info, raid))
>> +				btrfs_set_periodic_reclaim_ready(space_info, false);
>> +		}
>>  	}
>>  }
>>  
>> -- 
>> 2.52.0
>>


