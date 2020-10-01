Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ABD28097B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgJAVhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVhO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:37:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB3C0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:37:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x201so7480450qkb.11
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9034QL7uPd2Qbz9D8eFYBnhjoYdeT0P4XxvNLmx587k=;
        b=BMnAa2ivankr2Jw0ujsv5sHjktf7ZiGRNR+oCrMP/IipT58BLDF3jl+YnJdy114Oq+
         dIWanPSvNC3QkwHLXpcp3XsjYiitbwUcn4SJdPwbOt64CdSnlOyBLJEvKfdqyR0DLnl1
         hAn/ycePtxnw7DqvTV4hvWes/uIxfJq+t+whjn+HWQ9x9zob7CvQs1MflEwvyZgHX1oG
         4AZ4rUCBeqE5mDyuxlOL0drXi6Gl3Ri5SB6BwY2UdRKO+n54d/Wa75dWh4j5NefatyLB
         c0aex5OOA1s/Kk7REja3Gkp+pc0uft7uid+lqO6zOMitLWsGAt3gbCJkK977ctVmMaSw
         sHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9034QL7uPd2Qbz9D8eFYBnhjoYdeT0P4XxvNLmx587k=;
        b=FpKZvDLwl78USQgp1VbXBnUgzCLEU7/ZLBKYwlK7BuIRHw/A0JHkky/z93iCRGNI7X
         qrh3wLSbkBQkyOd993+S8//QvM5RTt980hDBAJz+DuH4h2wm60bf1OewJaQOvsq2LPh9
         AMIz/2I9ZBs8UGGaNC/AL7w7/ny1mRb5fJK7JfnnBLc3hT8PqyQgi71dOpyVZEUAZFuS
         ngXWaxfrGUXJazO+kyvtih5HCwuQW+rrcz2zJspFKx4OtgdyKCsx7ET/gLSO0MdaDVl6
         CnwW0NhwQI+RTUbzaT512eGfLwrl+oF5Rrf/OU1QY9GT3XKZdNbzmbwfBNyl3gmBHaTR
         dEzA==
X-Gm-Message-State: AOAM532XE/uF6EObhGiKv8ustsx+VGEiHBoZ55kSYP6U9oJJsrCxexbj
        rD4TKTsiKhIysgEH6NSSuw2YEQ==
X-Google-Smtp-Source: ABdhPJyMJw4xCo1xXZjV5Lfnxa7bPB2AdZfLiAzn7MwYjQta0EPxRkgr36WuXhOeNDt5RZ2wiZyyhw==
X-Received: by 2002:a37:4ac9:: with SMTP id x192mr9533255qka.294.1601588232399;
        Thu, 01 Oct 2020 14:37:12 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s10sm7525201qkg.61.2020.10.01.14.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:37:11 -0700 (PDT)
Subject: Re: [PATCH 3/9] btrfs: rename need_do_async_reclaim
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <0a1d66e4cc97d705ec58980f5883cf2a763a44f6.1601495426.git.josef@toxicpanda.com>
 <37a2cbe4-5b00-6c81-1896-7df409e25c28@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0ea42d76-a0ea-fa67-b159-c8ad82cdc04a@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:37:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <37a2cbe4-5b00-6c81-1896-7df409e25c28@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 9:24 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
>> All of our normal flushing is asynchronous reclaim, so this helper is
>> poorly named.  This is more checking if we need to preemptively flush
>> space, so rename it to need_preemptive_reclaim.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/space-info.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 024daa843c56..98207ea57a3d 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -795,9 +795,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
>>   	return to_reclaim;
>>   }
>>   
>> -static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
>> -					struct btrfs_space_info *space_info,
>> -					u64 used)
>> +static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>> +					  struct btrfs_space_info *space_info,
>> +					  u64 used)
> 
> nit: oops I forgot to mention but while at it, why don't you switch the
> function to bool return type.
> 

Can do, thanks,

Josef
