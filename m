Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9D216F72
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGGO4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgGGO4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 10:56:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5DC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 07:56:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u12so31908131qth.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V0fhyTs3BHSPg8I/GnwlpekX9/kAQcA4FDgZJA3C2zs=;
        b=ZgmMug+3snWaANXTQGd+q0Tj/+dZrH7RSBqmtnRzbHt675pssO1vLso2jnDUBRlnls
         2gJ6ns7BoyYmRh8JgWZHh4mmw6tJtzqnrKjKjVfZwEeTyy6sMrPkZPNROITxu2tYTgbA
         AHmbwD4hUOfxESoUZwtlG8mYjzWWNSucQGdlyO+xWeMYn2grU1fwx+LSk0pH2FBNkEPn
         lXggvx2vWyAN4vCf5tia1eIYqsu1C74Fpkrsp/FL2uyufrH62DNC7DGQNhoLPAGFVS17
         KoOGGr4D0j3BUyNgTWBIGZpbQqup9EflCFqEWU8CLMVdi5xcRArX6TuoFvGxy8ZcudqS
         dkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0fhyTs3BHSPg8I/GnwlpekX9/kAQcA4FDgZJA3C2zs=;
        b=Wa8ZBxmqKIDMgojJxeUfCqZvdDPek7/SPgLQAwCK4qXwobWSZuGY4aXyD5dAalLOVF
         NXSGQRJ88DO9CP3SQdS/pyMPvqqUJqFyjdrpggOXUr/mY8bWx4CfGSp32DE7lDV66EOI
         p2dr7+XakD2JwQH5l5on0TYvJ9n2FFLIB0Re65fYd5/5dehLpa7bdc1E/z5V8Vf8eqx0
         RCIZeuiVyPkALCiNPK5fmdlLVucLE7Q6cWAh1VyZRV6q/qCtj3sm4/znnJEVsmYN6LPE
         XOrlA3CCGUGKk/KWbMP4PvVwncw4mzm0qVycZsaRmxD0ZDZNV4CSyFG6vFCNBCrK0ov6
         13cw==
X-Gm-Message-State: AOAM531bB6w2H9zvS1ZUcMiufma++XWk7vjFlj3aqkiokvWe9nDSm3+A
        K3CzMzBZIZeH+cRLAQshFdLY1g==
X-Google-Smtp-Source: ABdhPJyqIQdo1HZT51lSYhwXy299Hr8l3sCk4ZI1v/ksD/vCGfhQeLSgB1Q/Ayz2cVtQmM/CatqdPw==
X-Received: by 2002:ac8:2256:: with SMTP id p22mr53745833qtp.75.1594133762115;
        Tue, 07 Jul 2020 07:56:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p36sm15563278qta.0.2020.07.07.07.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:56:01 -0700 (PDT)
Subject: Re: [PATCH 15/23] btrfs: use ticketing for data space reservations
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200630135921.745612-1-josef@toxicpanda.com>
 <20200630135921.745612-16-josef@toxicpanda.com>
 <63ed5861-0728-662a-20c1-03e60a59ee25@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f3c41fe8-ee2a-40c2-3dbf-48b5fe9f9cda@toxicpanda.com>
Date:   Tue, 7 Jul 2020 10:56:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <63ed5861-0728-662a-20c1-03e60a59ee25@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/7/20 10:46 AM, Nikolay Borisov wrote:
> 
> 
> On 30.06.20 г. 16:59 ч., Josef Bacik wrote:
>> Now that we have all the infrastructure in place, use the ticketing
>> infrastructure to make data allocations.  This still maintains the exact
>> same flushing behavior, but now we're using tickets to get our
>> reservations satisfied.
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> Tested-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/space-info.c | 125 ++++++++++++++++++++++--------------------
>>   1 file changed, 67 insertions(+), 58 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 799ee6090693..ee4747917b81 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -1068,6 +1068,54 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
>>   	} while (flush_state < states_nr);
>>   }
>>   
>> +static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
>> +					struct btrfs_space_info *space_info,
>> +					struct reserve_ticket *ticket,
>> +					const enum btrfs_flush_state *states,
>> +					int states_nr)
>> +{
>> +	int flush_state = 0;
>> +	int commit_cycles = 2;
>> +
>> +	while (!space_info->full) {
>> +		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
>> +		spin_lock(&space_info->lock);
>> +		if (ticket->bytes == 0) {
>> +			spin_unlock(&space_info->lock);
>> +			return;
>> +		}
>> +		spin_unlock(&space_info->lock);
>> +	}
>> +again:
>> +	while (flush_state < states_nr) {
>> +		u64 flush_bytes = U64_MAX;
>> +
>> +		if (!commit_cycles) {
>> +			if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
>> +				flush_state++;
>> +				continue;
>> +			}
>> +			if (states[flush_state] == COMMIT_TRANS)
>> +				flush_bytes = ticket->bytes;
>> +		}
>> +
>> +		flush_space(fs_info, space_info, flush_bytes,
>> +			    states[flush_state]);
>> +		spin_lock(&space_info->lock);
>> +		if (ticket->bytes == 0) {
>> +			spin_unlock(&space_info->lock);
>> +			return;
>> +		}
>> +		spin_unlock(&space_info->lock);
>> +		flush_state++;
>> +	}
>> +	if (commit_cycles) {
>> +		commit_cycles--;
>> +		flush_state = 0;
>> +		goto again;
>> +	}
>> +}
>> +
>>   static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
>>   				struct btrfs_space_info *space_info,
>>   				struct reserve_ticket *ticket)
>> @@ -1134,6 +1182,15 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>>   						evict_flush_states,
>>   						ARRAY_SIZE(evict_flush_states));
>>   		break;
>> +	case BTRFS_RESERVE_FLUSH_DATA:
>> +		priority_reclaim_data_space(fs_info, space_info, ticket,
>> +					data_flush_states,
>> +					ARRAY_SIZE(data_flush_states));
>> +		break;
>> +	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
>> +		priority_reclaim_data_space(fs_info, space_info, ticket,
>> +					    NULL, 0);
>> +		break;
>>   	default:
>>   		ASSERT(0);
>>   		break;
>> @@ -1341,78 +1398,30 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
>>   			     enum btrfs_reserve_flush_enum flush)
>>   {
>>   	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
>> -	const enum btrfs_flush_state *states = NULL;
>>   	u64 used;
>> -	int states_nr = 0;
>> -	int commit_cycles = 2;
>>   	int ret = -ENOSPC;
>>   
>>   	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
>>   
>> -	if (flush == BTRFS_RESERVE_FLUSH_DATA) {
>> -		states = data_flush_states;
>> -		states_nr = ARRAY_SIZE(data_flush_states);
>> -	}
>> -
>>   	spin_lock(&data_sinfo->lock);
>> -again:
>>   	used = btrfs_space_info_used(data_sinfo, true);
>>   
>>   	if (used + bytes > data_sinfo->total_bytes) {
>> -		u64 prev_total_bytes = data_sinfo->total_bytes;
>> -		int flush_state = 0;
>> +		struct reserve_ticket ticket;
>>   
>> +		init_waitqueue_head(&ticket.wait);
>> +		ticket.bytes = bytes;
>> +		ticket.error = 0;
>> +		list_add_tail(&ticket.list, &data_sinfo->priority_tickets);
> 
> nit: Shouldn't adding the ticket also be recorded in
> spac_info->reclaim_size?
> I see later that you are removing this code and relying on the existing
> logic in __reserve_metadata_bytes( renamed to reserve_bytes) which
> correctly modifies reclaim_size, but this just means this particular
> patch is slightly broken.

Yup I'll fix this up, thanks.  Thanks,

Josef

