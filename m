Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFB1D04B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 04:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgEMCRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 22:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgEMCRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 22:17:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B6C061A0C;
        Tue, 12 May 2020 19:17:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so6589235pgv.8;
        Tue, 12 May 2020 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=JRWxfr+EW40kX4Agu+1l82z17qUHjFXPdayrxGvmJ+Q=;
        b=c0D3m4VVXZrgug2OYKWOfk6sdj784+BdvMaa3veIqAwxEvv6R1Jxyk4q7F0MdlRnZA
         3RE4VPi5G2Z2vrtjCsp8WLSqR90Otd4B/DxdtVKWp1070JS4TzWf+lRogF8jXJS9WLan
         UamLr2ar5vfrDgDcO47Sap72TeOx94LRhgsTmyVQxeQzsgTWhvTs5Ps22rcZLjj6fxF7
         uem5I12T10Va013vCwAka1DT0EDgQ+4X3103jz46V8uRbvjYszxYNonOm1+GHCpZeguh
         4q/zFbmG1jz6HvSHi0kcg7WUW8vzbGwJE4G7byP48eU0YA9Cw7/t8xs3NCakGIUqj2Wi
         yQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JRWxfr+EW40kX4Agu+1l82z17qUHjFXPdayrxGvmJ+Q=;
        b=ZbK2mSxQ/opK0koqfj8faLxmF9D542INEFZrsjZ4JsXWocKZ1H47AmtG2wNpCF4s1I
         rR5sPaMoJNXhG+9K3doJDuWdtRp/UYt6vumlUVaQmCMyaLCpFyTPrMAb287MbPHnyWmQ
         C/Xkt7o8/kNG90hnm0wEBidvpkn78nSXfSewtL+ZZHbvG/Knm464ABrG6eV5UHx5EWAA
         5RpXwb97dgg4o9m+sFkm4dPS15NxPsCwRyDgXxXm6dXvCIy2opSqW0Zer4w/gWAt6ABT
         HSFgQ+iBb8gaOW5HEiI0C7ARAKNvn4VWJ7Xl2V1/qq4oofaBkVDvZoy/Ks+p1aFGkI5j
         6wMg==
X-Gm-Message-State: AGi0PubobGhALhx599HmA6KLtcihDx239fc3dzNWGEEfLrb9y9YB6TNc
        lnDTabzO5K3nV9gybzXOZMMMMiGx/k0=
X-Google-Smtp-Source: APiQypL2MERQvSippzGtbxcVPDbip1nv3WCoVEG2sGmI1f5RdXollB+tLi0j9QCDynQdSD8XcDd9wQ==
X-Received: by 2002:a65:6208:: with SMTP id d8mr21872658pgv.225.1589336235380;
        Tue, 12 May 2020 19:17:15 -0700 (PDT)
Received: from [166.111.139.104] ([166.111.139.104])
        by smtp.gmail.com with ESMTPSA id t14sm11696117pgr.61.2020.05.12.19.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:17:14 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: btrfs: fix data races in
 extent_write_cache_pages()
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200509052701.3156-1-baijiaju1990@gmail.com>
 <20200512215625.GE18421@twin.jikos.cz>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <06d64482-a263-668d-7ab1-9f411eb1c794@gmail.com>
Date:   Wed, 13 May 2020 10:17:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200512215625.GE18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/13 5:56, David Sterba wrote:
> On Sat, May 09, 2020 at 01:27:01PM +0800, Jia-Ju Bai wrote:
>> The function extent_write_cache_pages is concurrently executed with
>> itself at runtime in the following call contexts:
>>
>> Thread 1:
>>    btrfs_sync_file()
>>      start_ordered_ops()
>>        btrfs_fdatawrite_range()
>>          btrfs_writepages() [via function pointer]
>>            extent_writepages()
>>              extent_write_cache_pages()
>>
>> Thread 2:
>>    btrfs_writepages()
>>      extent_writepages()
>>        extent_write_cache_pages()
>>
>> In extent_write_cache_pages():
>>    index = mapping->writeback_index;
>>    ...
>>    mapping->writeback_index = done_index;
>>
>> The accesses to mapping->writeback_index are not synchronized, and thus
>> data races for this value can occur.
>> These data races were found and actually reproduced by our concurrency
>> fuzzer.
>>
>> To fix these races, the spinlock mapping->private_lock is used to
>> protect the accesses to mapping->writeback_index.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   fs/btrfs/extent_io.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 39e45b8a5031..8c33a60bde1d 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4160,7 +4160,9 @@ static int extent_write_cache_pages(struct address_space *mapping,
>>   
>>   	pagevec_init(&pvec);
>>   	if (wbc->range_cyclic) {
>> +		spin_lock(&mapping->private_lock);
>>   		index = mapping->writeback_index; /* Start from prev offset */
>> +		spin_unlock(&mapping->private_lock);
>>   		end = -1;
>>   		/*
>>   		 * Start from the beginning does not need to cycle over the
>> @@ -4271,8 +4273,11 @@ static int extent_write_cache_pages(struct address_space *mapping,
>>   			goto retry;
>>   	}
>>   
>> -	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
>> +	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole)) {
>> +		spin_lock(&mapping->private_lock);
>>   		mapping->writeback_index = done_index;
>> +		spin_unlock(&mapping->private_lock);
> I'm more and more curious what exactly is your fuzzer tool actualy
> reporting. Because adding the locks around the writeback index does not
> make any sense.
>
> The variable is of type unsigned long, this is written atomically so the
> only theoretical problem is on an achritecture that is not capable of
> storing that in one go, which means a lot more problems eg. because
> pointers are assumed to be the same width as unsigned long.
>
> So torn write is not possible and the lock leads to the same result as
> if it wasn't there and the read and write would happen not serialized by
> the spinlock but somewhere on the way from CPU caches to memory.
>
> CPU1                                   CPU2
>
> lock
> index = mapping->writeback_index
> unlock
>                                         lock
> 				       m->writeback_index = index;
> 				       unlock
>
> Is the same as
>
> CPU1                                   CPU2
>
>
> index = mapping->writeback_index
> 				       m->writeback_index = index;
>
> So maybe this makes your tool happy but there's no change from the
> correctness point of view, only added overhead from the lock/unlock
> calls.
>
> Lockless synchronization is a thing, using memory barriers etc., this
> was the case of some other patch, I think your tool needs to take that
> into account to give sensible results.

Thanks for the reply and explanation :)
I agree that only adding locks here makes no sense, because "index = 
mapping->writeback_index" can be still executed before or after 
"m->writeback_index = index" is executed.
So what is the expected order of the two statements? Read after write or 
write after read?


Best wishes,
Jia-Ju Bai
