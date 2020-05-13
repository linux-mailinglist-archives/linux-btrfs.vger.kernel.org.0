Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF601D04B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 04:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEMCST (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgEMCSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 22:18:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F42C061A0C;
        Tue, 12 May 2020 19:18:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u35so4089007pgk.6;
        Tue, 12 May 2020 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=3SZkl24U1zyxN0dY+jw5wv6XOSvaz/jqzsK44k876lU=;
        b=dSYqea+RsMoNmdpXlYMJBUcCpBaMeZVIZYnbdXRGW8xw9ETtqGS/n5ixVxJktTx+IA
         dl1CgXwBIBqrnr9GfpE7EcUA/ca92hILSRksA0DCRMEWQFJpDafqynAh57pnPnBnlKAH
         JP4xhfebf2Fm5Wk9LLm+tL0pZrj6SBv0nxMDQkoCUig3Uo4kKSons8nqg+KVUtYbBEzX
         uzf8tjz/DoG5aUBu6DG6FDQqZrvgO2xxXrqNEhpNG3y6eb0myHPUa+fdKmNtu3VCzxvf
         fohxeV9VIYwhrgN5I+yzDvTO6BJ3VQ0s0dPjFRBDaX4kAG0g1qOpbQJiAHgyIFmEi3JO
         MV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3SZkl24U1zyxN0dY+jw5wv6XOSvaz/jqzsK44k876lU=;
        b=IEBlb1sU1nWcpcacDKYKpt688LltJtKkFS2cYs6o9wctkAJpnq6jUyfnPhk0u6Ye/k
         P3eJfc6r4BpkHa9PZxkmBMOpz0zFKHdWPvI/RoCdPJn4oav09RRCfNikTZJfa6x2M5zY
         AvXW55nkvzOewiD4T4GC77F6DkTCfz8B/1qrAeP81G+SdiQUQEpRORyzaPlK57anolWX
         MRAzuz9/ReMIIdHfkpkFkjAKzBg3nOVwnpVov5LEi52kBx5+xn6N8uvMqBKFvAyPqFzY
         PcmIGfQF8raMRNJD5R4HjFbzEy8cs4nUlieQaHIBy8J5i0DoPYadpQh5tajeNjtetG3q
         tZDg==
X-Gm-Message-State: AGi0PuZiDDrrdgyqVX5l+KgeTkKnWpZDCAM6aKzcfRD8jGGTpWyFYEup
        fGUxtnoSUwvDs0e4kML2SSemuTic114=
X-Google-Smtp-Source: APiQypJAjdVQs0QXqD9Aasoh7WoCpwROgyY31XaiPH9rcFru+B1s4/OsENSB6x9A41W8ZJODyCZTSg==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr23442985pgk.271.1589336295981;
        Tue, 12 May 2020 19:18:15 -0700 (PDT)
Received: from [166.111.139.104] ([166.111.139.104])
        by smtp.gmail.com with ESMTPSA id x10sm1363942pgr.65.2020.05.12.19.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:18:15 -0700 (PDT)
Subject: Re: [PATCH 4/4] fs: btrfs: fix a data race in
 btrfs_block_rsv_release()
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200509053431.3860-1-baijiaju1990@gmail.com>
 <20200512221820.GF18421@twin.jikos.cz>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <58d23322-d23a-0f08-b19d-fce0710823a6@gmail.com>
Date:   Wed, 13 May 2020 10:18:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200512221820.GF18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/13 6:18, David Sterba wrote:
> On Sat, May 09, 2020 at 01:34:31PM +0800, Jia-Ju Bai wrote:
>> The functions btrfs_block_rsv_release() and
>> btrfs_update_delayed_refs_rsv() are concurrently executed at runtime in
>> the following call contexts:
>>
>> Thread 1:
>>    btrfs_file_write_iter()
>>      btrfs_buffered_write()
>>        btrfs_delalloc_release_extents()
>>          btrfs_inode_rsv_release()
>>            __btrfs_block_rsv_release()
>>
>> Thread 2:
>>    finish_ordered_fn()
>>      btrfs_finish_ordered_io()
>>        insert_reserved_file_extent()
>>          __btrfs_drop_extents()
>>            btrfs_free_extent()
>>              btrfs_add_delayed_data_ref()
>>                btrfs_update_delayed_refs_rsv()
>>
>> In __btrfs_block_rsv_release():
>>    else if (... && !delayed_rsv->full)
>>
>> In btrfs_update_delayed_refs_rsv():
>>    spin_lock(&delayed_rsv->lock);
>>    delayed_rsv->size += num_bytes;
>>    delayed_rsv->full = 0;
>>    spin_unlock(&delayed_rsv->lock);
>>
>> Thus a data race for delayed_rsv->full can occur.
>> This race was found and actually reproduced by our conccurency fuzzer.
>>
>> To fix this race, the spinlock delayed_rsv->lock is used to
>> protect the access to delayed_rsv->full in btrfs_block_rsv_release().
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   fs/btrfs/block-rsv.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>> index 27efec8f7c5b..89c53a7137b4 100644
>> --- a/fs/btrfs/block-rsv.c
>> +++ b/fs/btrfs/block-rsv.c
>> @@ -277,6 +277,11 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
>>   	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
>>   	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
>>   	struct btrfs_block_rsv *target = NULL;
>> +	unsigned short full = 0;
>> +
>> +	spin_lock(&delayed_rsv->lock);
>> +	full = delayed_rsv->full;
>> +	spin_unlock(&delayed_rsv->lock);
>>   
>>   	/*
>>   	 * If we are the delayed_rsv then push to the global rsv, otherwise dump
>> @@ -284,7 +289,7 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
>>   	 */
>>   	if (block_rsv == delayed_rsv)
>>   		target = global_rsv;
>> -	else if (block_rsv != global_rsv && !delayed_rsv->full)
>> +	else if (block_rsv != global_rsv && !full)
> This has been reported as suspicous
> https://lore.kernel.org/linux-btrfs/CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com/
>
> and there's an answer that this is racy but does not cause any
> unexpected behaviour.

Okay, thanks :)


Best wishes,
Jia-Ju Bai
