Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1400151E07
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgBDQQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:16:17 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33174 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDQQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:16:17 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so8831141qvn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IWIyBDiH3/GKBK67FGs+JTRQ7t3Z7UAMAFLRvIu7BX0=;
        b=trN5McTIWlGxt90d+MGeJNmmvj1/6B065rGtEgvEespls+ZMuqm/JthvCjK8YYLdop
         7swwsaJZgbIR05WbKSzL0xTO/StGrq6gC75/XY/xXkeT1VJ7xTJEaGAQmWa9EaD3grWB
         ez17nJ6OrXDu6ynOA1osKQ2pgxwWZLxPOPi40itrT5j/hQh9K7h2Zc/Tr/Jav/Ch7UR2
         iWKMMZNYW8HuqLYdbIicj8k9KnW0P2Dm3oCLwKV153khzZZ2gZ8f92KUqWGlKGyDl2UG
         M8w7R70zx+p+TU2mmEfN3d8ctYfS1DuskyV6NWC0+Ggo8v7QtNRFhBtsjMOmsGGzKLgY
         Yxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWIyBDiH3/GKBK67FGs+JTRQ7t3Z7UAMAFLRvIu7BX0=;
        b=DCahU4gEds6eBshIk5HjzY1IyjoRN7XgJ7Rd2sTolHr37BBF2+56IaOOu65r+OstA5
         VgZD7isPAmhwzXvhfTB1KCnB2WlvwVR91m33xq4fnet0tXKL/yxL1WpdEQqBRT7wFI1r
         pcpIHH9v74xK/vqeEks6/CzhO7OTTm6NJqRGjE814hIKnwLGIOmCaNVuC90NmOAOi6EV
         2E8rz8nXoTrom/aQZOwMTFSjXs6J2K91xS81rwXRacyTu3Qum8IqdNXYAg1LoabIM/l5
         XVlDDh9s9W4pxCgeAwM3Iua4PZCihQ6eLgruEqHMhkBjVd8k//MtN0WqlYVPfP+By/+7
         O2dg==
X-Gm-Message-State: APjAAAWX4CXFv8GcVVrJQA8Bh/vB7SXUiCDkN8HxJYRcPPFkmnljF5r/
        JyXP2+pXqqZ6ara4rsj3xygodg==
X-Google-Smtp-Source: APXvYqyw4EZef0fkj8bpsg2eNcTszMSLTUREnx0T+rzyXFj+g1gJ3X4usHx5cANRbTIbkE9bloePzw==
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr27690825qvo.20.1580832974666;
        Tue, 04 Feb 2020 08:16:14 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s11sm11192652qkg.99.2020.02.04.08.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 08:16:13 -0800 (PST)
Subject: Re: [PATCH 24/24] btrfs: add a comment explaining the data flush
 steps
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204951.517751-1-josef@toxicpanda.com>
 <20200203204951.517751-25-josef@toxicpanda.com>
 <593bda62-3f25-28d6-bb5c-efaa677872c6@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6ed7b1f6-dd06-9d6e-874e-475e3cb4d350@toxicpanda.com>
Date:   Tue, 4 Feb 2020 11:16:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <593bda62-3f25-28d6-bb5c-efaa677872c6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/4/20 4:47 AM, Nikolay Borisov wrote:
> 
> 
> On 3.02.20 г. 22:49 ч., Josef Bacik wrote:
>> The data flushing steps are not obvious to people other than myself and
>> Chris.  Write a giant comment explaining the reasoning behind each flush
>> step for data as well as why it is in that particular order.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/space-info.c | 46 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 18a31d96bbbd..d3befc536a7f 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -780,6 +780,52 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
>>   	} while (flush_state <= COMMIT_TRANS);
>>   }
>>   
>> +/*
>> + * FLUSH_DELALLOC_WAIT:
>> + *   Space is free'd from flushing delalloc in one of two ways.
>> + *
>> + *   1) compression is on and we allocate less space than we reserved.
>> + *   2) We are overwriting existing space.
>> + *
>> + *   For #1 that extra space is reclaimed as soon as the delalloc pages are
>> + *   cow'ed, by way of btrfs_add_reserved_bytes() which adds the actual extent
>> + *   length to ->bytes_reserved, and subtracts the reserved space from
>> + *   ->bytes_may_use.
>> + *
>> + *   For #2 this is trickier.  Once the ordered extent runs we will drop the
>> + *   extent in the range we are overwriting, which creates a delayed ref for
>> + *   that freed extent.  This however is not reclaimed until the transaction
>> + *   commits, thus the next stages.
>> + *
>> + * RUN_DELAYED_IPUTS
>> + *   If we are freeing inodes, we want to make sure all delayed iputs have
>> + *   completed, because they could have been on an inode with i_nlink == 0, and
>> + *   thus have been trunated and free'd up space.  But again this space is not
>> + *   immediately re-usable, it comes in the form of a delayed ref, which must be
>> + *   run and then the transaction must be committed.
>> + *
>> + * FLUSH_DELAYED_REFS
>> + *   The above two cases generate delayed refs that will affect
>> + *   ->total_bytes_pinned.  However this counter can be inconsistent with
>> + *   reality if there are outstanding delayed refs.  This is because we adjust
>> + *   the counter based on the other delayed refs that exist.  So for example, if
> 
> IMO this sentence would be clearer if it simply says something along the
> lines of " This is because we adjust the counter based solely on the
> current set of delayed refs and disregard any on-disk state which might
> include more refs".
> 
>> + *   we have an extent with 2 references, but we only drop 1, we'll see that
>> + *   there is a negative delayed ref count for the extent and assume that the
>> + *   space will be free'd, and thus increase ->total_bytes_pinned.
>> + *
>> + *   Running the delayed refs gives us the actual real view of what will be
>> + *   freed at the transaction commit time.  This stage will not actually free
>> + *   space for us, it just makes sure that may_commit_transaction() has all of
>> + *   the information it needs to make the right decision.
> 
> Is there any particular reason why total_bytes_pinned is sort of double
> accounted. I.e first add_pinned_bytes is called when a DROP del ref is
> added with negative ref. Then during processing of that delref
> __btrfs_free_extent either:
> 
> a) Removes the ref but doesn't free the extent if there were other,
> non-del refs for this extent
> 
> b) Removes the extent and calls btrfs_update_block_group to account it
> again as pinned (this time also setting the respective ranges as pinned)
> 
> This double accounting doesn't really happen because after the
> processing of the DROP del ref is finished
> cleanup_ref_head->btrfs_cleanup_ref_head_accounting will actually clean
> the pinned bytes added at creation time of the DROP del ref. Can we
> avoid this and simply rely on the update of total_bytes_pinned when an
> extent is freed.
> 

We discussed this offline, just replying here for those playing along at home.

Now that everything is unified we no longer need this extra total_bytes_pinned 
accounting.  Before this is what we were relying on in the data path to account 
for any data that may be freed once delayed refs run, as we didn't run delayed 
refs in the data reservation path.

Now that we are in fact doing this, we do not need this extra accounting.  In 
fact at the point we check in may_commit_transaction() our 
space_info->bytes_pinned will be uptodate, and thus we don't need this percpu 
counter at all.  Nikolay is going to follow up after these patches are merged 
and remove the counter altogether.  Thanks,

Josef
