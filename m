Return-Path: <linux-btrfs+bounces-4245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4088A45F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D72C281A87
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74613775C;
	Sun, 14 Apr 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LT9bVmNe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A11EB31
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713133156; cv=none; b=HlgOwrmHDVxWVaDSCtoSl792KwyClYJFxlytlXyeRm8m5UFCi30qaMmSSObgF6i6ZiONdABXxn4XNdDgD82bwuPj0Ldal1RamwSKuxtW4AD05T9LphzmQgdIi150UZTiAwPbs4zQC6U+Iv4BuWs4pXjLoQTafBxn65xVgD9MubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713133156; c=relaxed/simple;
	bh=JjvLO65NhGF2Y04/QgtgsuYxw+z3IxLfP56MyaFFHZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maLgqIbUs/ibcEMFyNgww/fsBgXov26kFcIaRtkyNYBIKcq+nxBaExiwPv4T4enBb2BWYF3VnllTuTJjWFDQAi6MRJN/jl38ohMnAbFUbTBKF8n2vQQQfWp5wmcn7sm/WYMtN0jLt1JH4+Iibt5F/J5YaNqdJIC7KvXRbXShB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LT9bVmNe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-347aa00e3c8so230113f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713133152; x=1713737952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg4jxys1pgCCWSJr0A5Ftug8HsGIzbPRcwFmRwd6Lck=;
        b=LT9bVmNep5QOmyfg3V+xf8+UDP8ePBPM8iHd72EJypacEUpM4bMjSDpnBAcSSauuvo
         Hxx3Tkc3FmhQcNz/RnQbos3dab6wyhMozixPCZmFXVO0pqPLJ0EjnXeXeW69lyscvMe8
         LG9Xd1eCFC4yeu3hvBg0gL1FqWh1gEtoWSx55rw3kYAmsca752uBXRQ0Hy/u1N1fS3ib
         QKncadEx4y9Qm85NqPlgtyAZjzoI1MLqW/FSUNnXrtYBb8BHb92/Od5uWm5VNy+ULwE5
         dKdgivxrPKF+dy3ynnse4F+WcnusnUEy3ymbhH4yncloPu8WZ0Q8WnvdWoHbXByn+7Xo
         NJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713133152; x=1713737952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg4jxys1pgCCWSJr0A5Ftug8HsGIzbPRcwFmRwd6Lck=;
        b=vQFAnXd2Se6CEmcI/LBgrBqnO2kz8TrmBollM9uXWhPYhdkL5YOwu++Q+XWprv5wq5
         HsMT4EoJUovpDV5gBHHo+Zs4PCoyoOdKvzMlUJfDKy1oGcacOJphVLwqAdPXJ5wFo2w5
         B0JvKi0gfcLeD9VhOTYau5LM4sBBkvPi+6mSBnY/qqvaFr6CvePjPPFIJ/YzZTKUx5D9
         D9WA8f7j2mSok0GVsM+GyUDn7Oz/ZF8XnhBhsvNhqcBlAdUpdApfcwso9Gp6qvDeh66R
         DnSldG70LfDPHyLtqfUUKBWgUoLA7FM92FWKiw74ZhhsKrJrVkiAhSoVsTTBV/A//OvM
         D5Vg==
X-Gm-Message-State: AOJu0YxEwvNyPkhrgu8rVYNs7IiENVU/Y+XSyzLlM+ZUW26ddwG1AxGG
	2AVTWW9XOb1ZWkb26TOFBJ7nOeSXFmXc+PT/79MKrZ4MqwvSThK8HQ6FFqCu/vc=
X-Google-Smtp-Source: AGHT+IHbzzZdMj0LMZhACOZmHnYrtBkUNDFEpZ4MNwkk5Eu+7uqxGXgWOF5Bv941diQkUCLb8oOxkw==
X-Received: by 2002:adf:a386:0:b0:33e:c0f0:c159 with SMTP id l6-20020adfa386000000b0033ec0f0c159mr9667101wrb.10.1713133152487;
        Sun, 14 Apr 2024 15:19:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b005f43a5c4e7dsm5982304pgl.41.2024.04.14.15.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 15:19:11 -0700 (PDT)
Message-ID: <4ad8e412-1a37-42b1-8cc4-2ffec664b035@suse.com>
Date: Mon, 15 Apr 2024 07:49:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-btrfs@vger.kernel.org, Julian Taylor <julian.taylor@1und1.de>,
 Filipe Manana <fdmanana@suse.com>
References: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
 <20240414202622.B092.409509F4@e16-tech.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240414202622.B092.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/14 21:56, Wang Yugui 写道:
> Hi,
> 
>> [BUG]
>> There is a recent report that when memory pressure is high (including
>> cached pages), btrfs can spend most of its time on memory allocation in
>> btrfs_alloc_page_array() for compressed read/write.
>>
>> [CAUSE]
>> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
>> even if the bulk allocation failed (fell back to single page
>> allocation) we still retry but with extra memalloc_retry_wait().
>>
>> If the bulk alloc only returned one page a time, we would spend a lot of
>> time on the retry wait.
>>
>> The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
>> incomplete batch memory allocations").
>>
>> [FIX]
>> Although the commit mentioned that other filesystems do the wait, it's
>> not the case at least nowadays.
>>
>> All the mainlined filesystems only call memalloc_retry_wait() if they
>> failed to allocate any page (not only for bulk allocation).
>> If there is any progress, they won't call memalloc_retry_wait() at all.
>>
>> For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
>> if there is no allocation progress at all, and the call is not for
>> metadata readahead.
>>
>> So I don't believe we should call memalloc_retry_wait() unconditionally
>> for short allocation.
>>
>> This patch would only call memalloc_retry_wait() if failed to allocate
>> any page for tree block allocation (which goes with __GFP_NOFAIL and may
>> not need the special handling anyway), and reduce the latency for
>> btrfs_alloc_page_array().
>>
>> Reported-by: Julian Taylor <julian.taylor@1und1.de>
>> Tested-by: Julian Taylor <julian.taylor@1und1.de>
>> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
>> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
> 
> It seems this patch remove all the logic of
> 	395cb57e8560 ("btrfs: wait between incomplete batch memory allocations"),
> 
> so we should revert this part too?

Oh, right.

Feel free to submit a patch to cleanup the headers here.

Thanks,
Qu
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c140dd0..df4675e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6,7 +6,6 @@
>   #include <linux/mm.h>
>   #include <linux/pagemap.h>
>   #include <linux/page-flags.h>
> -#include <linux/sched/mm.h>
>   #include <linux/spinlock.h>
>   #include <linux/blkdev.h>
>   #include <linux/swap.h>
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/04/14
> 
> 
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Still use bulk allocation function
>>    Since alloc_pages_bulk_array() would fall back to single page
>>    allocation by itself, there is no need to go alloc_page() manually.
>>
>> - Update the commit message to indicate other fses do not call
>>    memalloc_retry_wait() unconditionally
>>    In fact, they only call it when they need to retry hard and can not
>>    really fail.
>> ---
>>   fs/btrfs/extent_io.c | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 7441245b1ceb..c96089b6f388 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>>   int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>>   			   gfp_t extra_gfp)
>>   {
>> +	const gfp_t gfp = GFP_NOFS | extra_gfp;
>>   	unsigned int allocated;
>>   
>>   	for (allocated = 0; allocated < nr_pages;) {
>>   		unsigned int last = allocated;
>>   
>> -		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
>> -						   nr_pages, page_array);
>> +		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
>> +		if (unlikely(allocated == last)) {
>> +			/* Can not fail, wait and retry. */
>> +			if (extra_gfp & __GFP_NOFAIL) {
>> +				memalloc_retry_wait(GFP_NOFS);
>> +				continue;
>> +			}
>>   
>> -		if (allocated == nr_pages)
>> -			return 0;
>> -
>> -		/*
>> -		 * During this iteration, no page could be allocated, even
>> -		 * though alloc_pages_bulk_array() falls back to alloc_page()
>> -		 * if  it could not bulk-allocate. So we must be out of memory.
>> -		 */
>> -		if (allocated == last) {
>> +			/* Allowed to fail, error out. */
>>   			for (int i = 0; i < allocated; i++) {
>>   				__free_page(page_array[i]);
>>   				page_array[i] = NULL;
>>   			}
>>   			return -ENOMEM;
>>   		}
>> -
>> -		memalloc_retry_wait(GFP_NOFS);
>>   	}
>>   	return 0;
>>   }
>> -- 
>> 2.44.0
>>
> 
> 

