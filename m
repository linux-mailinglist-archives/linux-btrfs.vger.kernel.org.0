Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA018202A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgCKR7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:59:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46701 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgCKR7R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:59:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id t13so2217090qtn.13
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sP931GahxLAWhEXG05EsZQ3AXxVBocpqaT160JRcn28=;
        b=PgSxkWbZJZlH3iDzlsmr/pu2h3kOkdfF6wJQL86Uf/AAJMT1t/FAsYw8NYO80uFWeX
         ay7fSLOSVz8HFT+fcLaDXkNZw6EBHMuyRIb7g0A2oA2war7iDvE9O+rWT6PAKHdhHSKF
         BRh1UMJlVFimO8wzNFVWI9XHFys40CAui3sLEDSx5fJCGWt8fHTbRf/4//Bzm2xW5qqx
         mlIOPa2l1Icm3LXyQQYzZ6eH/rHx2lxSyocofV69N6ZBYGdZnOFjpURXoixm3z5hXQ60
         7/QSaluZzWnpZ68A2+oFZRmYsvn7wfJAkoQxydqNWXKbeK2A2ceIIRir2Fx/5+jh8+UJ
         UXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sP931GahxLAWhEXG05EsZQ3AXxVBocpqaT160JRcn28=;
        b=WclCPOvykEA9O1j2lWXq4ONc2lErsl9JqY3hWFgDzJf1Fu0POwBefZ5SesT9hUOZpu
         g8xsm+92W56eISp9o5DgUWphFhyaAoJoLkB/WhiWQiN9Vjkibx701nu/IM4tED7FL5J5
         Q1VLZxCL30sKyFW9kfFdO6S0V2IN8W5BlUamsJfuT39EBu14NrNqPsQRKY+/bwqzfLLR
         wV37OfYthyPvxcedoLrg3gLXlP+qC8Iw3CIJQ//zMONPzQvn1SH3le9barnJLyVWRcya
         QaDv2RS4RETSkMSHz+vTVxRqMLE81r4kIhzNrZl5sOIgaRiVTaTLpEErcaCxxGaoP1B8
         eyXA==
X-Gm-Message-State: ANhLgQ0dIPDuuAgODbFN1VZ4jRHhmV0EmS3dckJZizejDiKKr7IpMO23
        8fYl1YIxqMjkyeppqwQ2Z8v5W8mypdU=
X-Google-Smtp-Source: ADFU+vspZlAkd6grmQVErLj7P39gQeVbetgsoMZbvjaia7ayjgo6PtVoV2l5ryls2Z3SRlvUfNQa7A==
X-Received: by 2002:ac8:3003:: with SMTP id f3mr3737679qte.293.1583949556321;
        Wed, 11 Mar 2020 10:59:16 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x1sm7168408qkl.128.2020.03.11.10.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:59:15 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Optimise space flushing machinery
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200310090035.16676-1-nborisov@suse.com>
 <e66667cb-7be0-9d26-f462-d6094b892cde@toxicpanda.com>
 <412a6539-66b4-1497-d9ee-d6b2d14c4a14@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b98c152e-f167-f4ee-dfa9-fc2185ab47b1@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:59:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <412a6539-66b4-1497-d9ee-d6b2d14c4a14@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/11/20 1:57 PM, Nikolay Borisov wrote:
> 
> 
> On 11.03.20 г. 19:52 ч., Josef Bacik wrote:
>> On 3/10/20 5:00 AM, Nikolay Borisov wrote:
>>> Instead of iterating all pending tickets on the normal/priority list to
>>> sum their total size the cost can be amortized across ticket addition/
>>> removal. This turns O(n) + O(m) (where n is the size of the normal list
>>> and m of the priority list) into O(1). This will mostly have effect in
>>> workloads
>>> that experience heavy flushing.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>    fs/btrfs/space-info.c | 13 ++++++++-----
>>>    fs/btrfs/space-info.h |  4 ++++
>>>    2 files changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>> index 9cb511d8cd9d..316a724dc990 100644
>>> --- a/fs/btrfs/space-info.c
>>> +++ b/fs/btrfs/space-info.c
>>> @@ -389,6 +389,8 @@ void btrfs_try_granting_tickets(struct
>>> btrfs_fs_info *fs_info,
>>>                                      space_info,
>>>                                      ticket->bytes);
>>>                list_del_init(&ticket->list);
>>> +            ASSERT(space_info->reclaim_size >= ticket->bytes);
>>> +            space_info->reclaim_size -= ticket->bytes;
>>>                ticket->bytes = 0;
>>>                space_info->tickets_id++;
>>>                wake_up(&ticket->wait);
>>> @@ -784,16 +786,15 @@ static inline u64
>>>    btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
>>>                     struct btrfs_space_info *space_info)
>>>    {
>>> -    struct reserve_ticket *ticket;
>>>        u64 used;
>>>        u64 avail;
>>>        u64 expected;
>>>        u64 to_reclaim = 0;
>>>
>>> -    list_for_each_entry(ticket, &space_info->tickets, list)
>>> -        to_reclaim += ticket->bytes;
>>> -    list_for_each_entry(ticket, &space_info->priority_tickets, list)
>>> -        to_reclaim += ticket->bytes;
>>> +    lockdep_assert_held(&space_info->lock);
>>> +
>>> +    if (space_info->reclaim_size)
>>> +        return space_info->reclaim_size;
>>
>> This undoes the fix that I put up making sure we include any space we
>> can no longer overcommit.  Thanks,
> 
> Which fix is that?

https://github.com/kdave/btrfs-devel/commit/593212a6137ff3c5674609b4233f8ecec459dc45

Thanks,

Josef
