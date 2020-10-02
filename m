Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C1281467
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbgJBNpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbgJBNpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 09:45:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5336C0613D0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Oct 2020 06:45:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 19so1219463qtp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Oct 2020 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eqKBrwU0CK03MGkMkVzCsiibWkSZIzrrKL2TVmrnYRU=;
        b=HomwjVux2F9T07qCPxeVAy0+93BLI4Jhdpybr1u2NS0qatuT/Bf8HqM6O5FVB4/hGr
         c/zA9jnTinV8ltI8jFqULHvFJe3GDOOKzFh1bNsYxbpJTFbl3pNQH9vXvVnJPzhqW9dw
         2vi9Mf/nP3rzuI/qWx+p8QZC2ggDQlRpnI9GFfOnPTrf+BZOLBMXvocQ8Faa/s+EK1wI
         HdkIfxoyRfP5eUwFglw4p09+4sUK14HUY1XJy86ByRFawvZ6tZcyt3uAEWIYIqaq6aY9
         oHDNsTQS8gnN8L9qMOsT8/PUPTP2+px7FZsjEbA3x0uDYm0SUS9Ekwi9AMRkTLDR4pA1
         FoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eqKBrwU0CK03MGkMkVzCsiibWkSZIzrrKL2TVmrnYRU=;
        b=pVbJpJo0cJkZ7F3zGdtg1ob9M0XSisd88XbCSj6Rq4m5dZS5HfzVN0C66vNPgL3T23
         aMO4FkFmRzvCj9Gw7vwu3QoXBwULWozKx+NAjHj5+doV5wfVleyMK9daL8lMGzDr4VdV
         5BakIEMIP7+2nFzOQx5a07bVbR//CTgmtVk0MTzgSAfH1SSd7hxwPSzErzsIxys7VWSa
         SK9mMwiPuFCjyxDFmS5460MG8M5MDXpGmSQNy6dyoLiTJp4a7sjGL28OA4rHXGrjb0Ud
         /kMP8ZMZmvz4oNuuJTwbbUo3WF3uu2ThsKPRdjEoRa/nRHWB0vLt7dt06Ncu8YG/F7AW
         LQaA==
X-Gm-Message-State: AOAM532FI8WMXCkVHkAR6+HJNw+msO/qHHCQ4UsLx7dcOItDZJHxZwuL
        MfFq9r2MeqHGOTaAkatuVD0McA==
X-Google-Smtp-Source: ABdhPJyKSZNXVIenn3gPB+rKfBadHj7CvNqLqkx+n7jvO/p5KddvfWuBFaiRsQ1C7/EIl6SKjZNzeg==
X-Received: by 2002:aed:2434:: with SMTP id r49mr2278176qtc.370.1601646304893;
        Fri, 02 Oct 2020 06:45:04 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e9sm1098288qkb.8.2020.10.02.06.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 06:45:04 -0700 (PDT)
Subject: Re: [PATCH 9/9] btrfs: add a trace class for dumping the current
 ENOSPC state
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <bf8f40699e24ea12b405a580262d99016ce7ffa0.1601495426.git.josef@toxicpanda.com>
 <777f67b3-8c6a-4bb1-1a0b-32b866018efc@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <425b82a1-7fd7-3fcc-374f-7f950482823e@toxicpanda.com>
Date:   Fri, 2 Oct 2020 09:45:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <777f67b3-8c6a-4bb1-1a0b-32b866018efc@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/2/20 4:30 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
>> Often when I'm debugging ENOSPC related issues I have to resort to
>> printing the entire ENOSPC state with trace_printk() in different spots.
>> This gets pretty annoying, so add a trace state that does this for us.
>> Then add a trace point at the end of preemptive flushing so you can see
>> the state of the space_info when we decide to exit preemptive flushing.
>> This helped me figure out we weren't kicking in the preemptive flushing
>> soon enough.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/space-info.c        |  1 +
>>   include/trace/events/btrfs.h | 62 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 63 insertions(+)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index b9735e7de480..6f569a7d2df4 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -1109,6 +1109,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
>>   	/* We only went through once, back off our clamping. */
>>   	if (loops == 1 && !space_info->reclaim_size)
>>   		space_info->clamp = max(1, space_info->clamp - 1);
>> +	trace_btrfs_done_preemptive_reclaim(fs_info, space_info);
>>   	spin_unlock(&space_info->lock);
>>   }
>>   
>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
>> index c340bff65450..651ac47a6945 100644
>> --- a/include/trace/events/btrfs.h
>> +++ b/include/trace/events/btrfs.h
>> @@ -2027,6 +2027,68 @@ TRACE_EVENT(btrfs_convert_extent_bit,
>>   		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
>>   );
>>   
>> +DECLARE_EVENT_CLASS(btrfs_dump_space_info,
>> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
>> +		 const struct btrfs_space_info *sinfo),
>> +
>> +	TP_ARGS(fs_info, sinfo),
>> +
>> +	TP_STRUCT__entry_btrfs(
>> +		__field(	u64,	flags			)
>> +		__field(	u64,	total_bytes		)
>> +		__field(	u64,	bytes_used		)
>> +		__field(	u64,	bytes_pinned		)
>> +		__field(	u64,	bytes_reserved		)
>> +		__field(	u64,	bytes_may_use		)
>> +		__field(	u64,	bytes_readonly		)
>> +		__field(	u64,	reclaim_size		)
>> +		__field(	int,	clamp			)
>> +		__field(	u64,	global_reserved		)
>> +		__field(	u64,	trans_reserved		)
>> +		__field(	u64,	delayed_refs_reserved	)
>> +		__field(	u64,	delayed_reserved	)
>> +		__field(	u64,	free_chunk_space	)
>> +	),
>> +
>> +	TP_fast_assign_btrfs(fs_info,
>> +		__entry->flags			=	sinfo->flags;
>> +		__entry->total_bytes		=	sinfo->total_bytes;
>> +		__entry->bytes_used		=	sinfo->bytes_used;
>> +		__entry->bytes_pinned		=	sinfo->bytes_pinned;
>> +		__entry->bytes_reserved		=	sinfo->bytes_reserved;
>> +		__entry->bytes_may_use		=	sinfo->bytes_may_use;
>> +		__entry->bytes_readonly		=	sinfo->bytes_readonly;
>> +		__entry->reclaim_size		=	sinfo->reclaim_size;
>> +		__entry->clamp			=	sinfo->clamp;
>> +		__entry->global_reserved	=	fs_info->global_block_rsv.reserved;
>> +		__entry->trans_reserved		=	fs_info->trans_block_rsv.reserved;
>> +		__entry->delayed_refs_reserved	=	fs_info->delayed_refs_rsv.reserved;
>> +		__entry->delayed_reserved	=	fs_info->delayed_block_rsv.reserved;
>> +		__entry->free_chunk_space	=	atomic64_read(&fs_info->free_chunk_space);
>> +	),
>> +
>> +	TP_printk_btrfs("flags=%s total_bytes=%llu bytes_used=%llu "
>> +			"bytes_pinned=%llu bytes_reserved=%llu "
>> +			"bytes_may_use=%llu bytes_readonly=%llu "
>> +			"reclaim_size=%llu clamp=%d global_reserved=%llu "
>> +			"trans_reserved=%llu delayed_refs_reserved=%llu "
>> +			"delayed_reserved=%llu chunk_free_space=%llu",
>> +			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
>> +			__entry->total_bytes, __entry->bytes_used,
>> +			__entry->bytes_pinned, __entry->bytes_reserved,
>> +			__entry->bytes_may_use, __entry->bytes_readonly,
>> +			__entry->reclaim_size, __entry->clamp,
>> +			__entry->global_reserved, __entry->trans_reserved,
>> +			__entry->delayed_refs_reserved,
>> +			__entry->delayed_reserved, __entry->free_chunk_space)
>> +);
>> +
>> +DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
>> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
>> +		 const struct btrfs_space_info *sinfo),
>> +	TP_ARGS(fs_info, sinfo)
>> +);
> 
> 
> I think this could be just a TRACE_EVENT, do you expect to define
> further events based on the same class ?

Yes, the idea is that the next time I'm doing something I can add a new event 
where I need it.  I had thoughts of where I'd add ones right now, but I'd rather 
wait until I have real need of another tracepoint before I go adding them 
randomly in our code.  Thanks,

Josef
