Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F041E28098A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgJAVlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbgJAVlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:41:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B21C0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:41:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so405147qtn.9
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=enTN6LZScrIBTY+0fh8E6N6Rqyz6pWDIf3m/gs1BuTU=;
        b=BGsAjqZ/+eXNAjQLau6yPgllP3VK4LBN3D6tzKip57HloRuIlNIrKnCDL73zpb8IdR
         gcv8NkOWAG30O+U8OXc3DaQBmOblE6et0uLz4QkuTq9gpB3QmWAbbrCvOtmfgFN3m/VB
         li0CrsBXTijJuTOPT5JsX9HBSiK3j79j6x/RtuGgrp/eK5rksqA/SbjKvqD3wjQSKnGE
         /yuabnqdHdN5tBLKIXF0tLPBY5p5BW/Lq7W+TXjLO3rJ84pSiwLNO+FtSJvmBvfxVtmc
         NgE8UoG0Rtgv4BrMW9kl4KuDXQTsugC/OPzN0ji5w3oYb9+nb0xjVJOprqA0+QxT/0gj
         3P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=enTN6LZScrIBTY+0fh8E6N6Rqyz6pWDIf3m/gs1BuTU=;
        b=hdwW2G0EVYwTNzkQJEtcr1WASyl51Pc4hj9mnpsHVdbvAhRNN7NajEw2dqvnFTs4P6
         1YY2QkbXLkzJLYk4YiPub8cuUZnC8mggj0bjygy56ZmhA4aH8XVQ3wENgl+br8KFhfUv
         LCMZGKQS11XvxwQQrn4eQzAtBO79Yaj2vJGuvRGM8Grg8eZAfhz0/AIyBjCDmNdaLurh
         D8HK+dJKbQAkjV4k5YcdYcY7vGgOQOyTg+5Ts5ZV33/K8y7zRmPdKxDs0tcH/Q1rWCM0
         85ijHWoUfcnOVlYS9l3eaTytR8XnyAiBtkZy7nQIhMWLtPdy85emWiOzSLiem02nEaND
         +PhQ==
X-Gm-Message-State: AOAM531n6Lf35QvJzZgwl3l5fGMu1n7mHObI6jg4aFs+cbc0Y5Zu/xFD
        jVNQzop+3jClQqaCCsXMUbii9g==
X-Google-Smtp-Source: ABdhPJyT6TYxkZBKw/H/gcPaMFtKc0pMZRmdYVFN9hBWZHJ9zULieMSht/6ZxAstOXKGaGqxGs+GyA==
X-Received: by 2002:ac8:4e4e:: with SMTP id e14mr9895854qtw.49.1601588461079;
        Thu, 01 Oct 2020 14:41:01 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 205sm6917182qki.118.2020.10.01.14.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:41:00 -0700 (PDT)
Subject: Re: [PATCH 6/9] btrfs: simplify the logic in need_preemptive_flushing
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <8f5cc79f377c0358c3ad40188bf5917b4bc07924.1601495426.git.josef@toxicpanda.com>
 <96d536af-71f3-e69d-15f6-a5ab78cc1251@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f6e87b9a-0486-614e-c8fa-f94651614676@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:40:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <96d536af-71f3-e69d-15f6-a5ab78cc1251@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 10:09 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
>> A lot of this was added all in one go with no explanation, and is a bit
>> unwieldy and confusing.  Simplify the logic to start preemptive flushing
>> if we've reserved more than half of our available free space.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> <snip>
> 
>> +	 * If we have over half of the free space occupied by reservations or
>> +	 * pinned then we want to start flushing.
>> +	 *
>> +	 * We do not do the traditional thing here, which is to say
>> +	 *
>> +	 *   if (used >= ((total_bytes + avail) >> 1))
>> +	 *     return 1;
>> +	 *
>> +	 * because this doesn't quite work how we want.  If we had more than 50%
>> +	 * of the space_info used by bytes_used and we had 0 available we'd just
>> +	 * constantly run the background flusher.  Instead we want it to kick in
>> +	 * if our reclaimable space exceeds 50% of our available free space.
>> +	 */
>> +	thresh = calc_available_free_space(fs_info, space_info,
>> +					   BTRFS_RESERVE_FLUSH_ALL);
>> +	thresh += (space_info->total_bytes - space_info->bytes_used -
>> +		   space_info->bytes_reserved - space_info->bytes_readonly);
> 
> Isn't the freespace in space_info calculated by subtracting every
> bytes_* from total_bytes ? I.e why aren't you subtracting bytes_may_use
> and bytes_pinned ? Shouldn't this be
> 
> thresh += space_info->total_bytes - btrfs_space_info_used(space_info, true)
> 

Because I'm using the reservation in `used` below.  What I want is to see how my 
free space we have for all of our reservations, and then use that as the 
threshold for when to start preemptive flushing.  Then below we use 
bytes_may_use and bytes_pinned as the used.  If I subtracted it from here it 
would appear that we had less free space when I then went and did

return (used >= thresh);

Thanks,

Josef
