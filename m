Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7013B1CC0DC
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgEILVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728318AbgEILVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 07:21:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF0C061A0C;
        Sat,  9 May 2020 04:21:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so2363240pfc.0;
        Sat, 09 May 2020 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yzuOQHdhVHihQi0h5xL8aCO4T4yf1MKXSB1rafT+J6s=;
        b=FvxOe+PyTOEwk27zK/6HEiUy8Qd8++HiTUMpo9fG42tYl8q0QyBIU9hAHByd7pSW3T
         JJ2+tn6D5EpGP2VZEUwZdM7s5ZmLjLOzBl7BJQS2JRHzIUkUIotNK5Ppd1RQ6HPFklS1
         V5/48nHJ4f/3IHa8L4DgfDditgvRlAhFXDxyoC8OPMrBqjrLWfEKIX52KuWDGSzUUrZm
         uXEhH60KxDm2W7rBIGmR6R2cEXCNxwWXdpc9qkn1+p+8bS1VDWJvurLoGhyWdKvEPf/v
         Bhm6cxsL/k/tl/YmKCJiIhDT2o+HwjiWQU7mzr3J7au6+la833PUE2+ttl41b2EIkoIP
         6YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yzuOQHdhVHihQi0h5xL8aCO4T4yf1MKXSB1rafT+J6s=;
        b=ccfZGxjMb2uSR19lRByc16zqbKYNLl7N90MJY2Y6hlK6nnw9zSskoWK4imWi/C9uxv
         pHwZ5yXCQUMrgN7s39Xnw446cdvaIYj6jvQKpaHD/RXISKYHYQVP9jJLy3vEgLYFJaQt
         sHbgerA90CVFzPz0f58gPsMB/twzAbn5I6cEaYgYVJIfxfrEGlKywGjTU2VTm22ExOrJ
         od63oMBLTFQ6xoI4p3B4PoqRWv665EXbuTji5UT+pKsndCJonudtONMllY0qYyIaac55
         zZiOEkoarKn+iwdyGc2O5oqFPKJuooV1KxEAV+S1kaNhTXQfo+GSYCxa8bXVDkikZU0h
         /X9Q==
X-Gm-Message-State: AGi0PubgdEz8LEVcU2Kyq1xCVvYm0zTXDgbDY5Z/sDzEtKxf9CJWybiy
        C0BGEyfg2yiZjmGpeo1eehQzhSW3M48=
X-Google-Smtp-Source: APiQypJ5vN5L/NTAHyN4apNpjuyAloxRAMKHW4M0GwJgCFoLvojLrV8fMX5WEBivU7sjwSxRz6NCiQ==
X-Received: by 2002:a63:4f45:: with SMTP id p5mr5956850pgl.41.1589023282497;
        Sat, 09 May 2020 04:21:22 -0700 (PDT)
Received: from [192.168.1.7] ([223.72.62.216])
        by smtp.gmail.com with ESMTPSA id 13sm4438035pfv.95.2020.05.09.04.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 04:21:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] fs: btrfs: fix a data race in
 btrfs_block_group_done()
To:     Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200509052001.2298-1-baijiaju1990@gmail.com>
 <21982360-ee20-edfd-bee9-cbea04b3893f@suse.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <d991d28c-986a-0efc-e10e-62fe516dd7c6@gmail.com>
Date:   Sat, 9 May 2020 19:20:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <21982360-ee20-edfd-bee9-cbea04b3893f@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/9 18:53, Nikolay Borisov wrote:
>
> On 9.05.20 г. 8:20 ч., Jia-Ju Bai wrote:
>> The functions btrfs_block_group_done() and caching_thread() are
>> concurrently executed at runtime in the following call contexts:
>>
>> Thread 1:
>>    btrfs_sync_file()
>>      start_ordered_ops()
>>        btrfs_fdatawrite_range()
>>          btrfs_writepages() [via function pointer]
>>            extent_writepages()
>>              extent_write_cache_pages()
>>                __extent_writepage()
>>                  writepage_delalloc()
>>                    btrfs_run_delalloc_range()
>>                      cow_file_range()
>>                        btrfs_reserve_extent()
>>                          find_free_extent()
>>                            btrfs_block_group_done()
>>
>> Thread 2:
>>    caching_thread()
>>
>> In btrfs_block_group_done():
>>    smp_mb();
>>    return cache->cached == BTRFS_CACHE_FINISHED ||
>>        cache->cached == BTRFS_CACHE_ERROR;
>>
>> In caching_thread():
>>    spin_lock(&block_group->lock);
>>    block_group->caching_ctl = NULL;
>>    block_group->cached = ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FINISHED;
>>    spin_unlock(&block_group->lock);
>>
>> The values cache->cached and block_group->cached access the same memory,
>> and thus a data race can occur.
>> This data race was found and actually reproduced by our concurrency
>> fuzzer.
>>
>> To fix this race, the spinlock cache->lock is used to protect the
>> access to cache->cached in btrfs_block_group_done().
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   fs/btrfs/block-group.h | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 107bb557ca8d..fb5f12acea40 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -278,9 +278,13 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
>>   
>>   static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
>>   {
>> +	int flag;
>>   	smp_mb();
>> -	return cache->cached == BTRFS_CACHE_FINISHED ||
>> -		cache->cached == BTRFS_CACHE_ERROR;
>> +	spin_lock(&cache->lock);
>> +	flag = (cache->cached == BTRFS_CACHE_FINISHED ||
>> +		cache->cached == BTRFS_CACHE_ERROR);
>> +	spin_unlock(&cache->lock);
>> +	return flag;
> Using the lock also obviates the need for the memory barrier.
> Furthermore this race is benign because even if it occurs and we call
> into btrfs_cache_block_group we do check cache->cached under
> btrfs_block_group::lock and do the right thing, though we would have
> done a bit more unnecessary wor if that's the case. So have you actually
> measured the effect of adding the the spinlock? This is likely done so
> as to make the fastpath lock-free. Perhaps a better approach would be to
> annotate the access of cached with READ/WRITE once so that it's fetched
> from memory and not optimized out by the compiler and leave the more
> heavy work in the unlikely path.
>
> Please exercise some critical thinking when looking into such issues as
> there might be a good reason why something has been coded in a
> particular way and it might look wrong on a first look but in fact is not.

Okay, thanks a lot for your explanation and advice :)


Best wishes,
Jia-Ju Bai
