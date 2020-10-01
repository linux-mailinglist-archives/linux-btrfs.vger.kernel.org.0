Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F29280975
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgJAVd4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVd4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:33:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DAEC0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:33:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so399983qtj.7
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TtSPza9aUNHtWumgXJsUuQ+jnQ56nQoLegUEQwmWO8w=;
        b=tP4R8Gi2YqIS+MdKwYPI9puTz4jek0KOxsPf7rrkeQzkBUULnkABMM/Z9crRfBRU6J
         2sYVeKiZnE7Foas/eNHecLKdTbsHFZgLR4JkU4j7NzzWFBMIQqXSGyMycjTy3rymlz1Z
         oFuebvywE3Fjlximbki8cKCXVKCWDt4MPbtrnM0qDRzdqOfR8+zYsEMQsiaVJDqjOH+E
         zEwefPIghJ4/Ky1A0gfDO1QsKP5JzMulkXcUBT6a1oC226nKZrjhbmL6oQpYV0M4ypbp
         Ta1eIRTBGO6UOY1is4qZAIW2alLlibdOvMzrM6Jxu74GvLKxKVqQuUwoWw678sEAME9O
         MSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TtSPza9aUNHtWumgXJsUuQ+jnQ56nQoLegUEQwmWO8w=;
        b=IdKCIkduNHMGeHXZJHOw8OQp33uz9fDoZXj+soIIfLbVu7k6kxmi2RyRuL/n1skkPd
         MTpi/B3VmgS2ksgMwmOk1A8RKGpo7AlGHMq6gR0ot+Wt3ihYRYVyrMn8ijZzkllmgIqo
         keVi9j6YH+9jqk2Jordop6/GBxEXkvyenuB4obhvKedYnNzAqPH+goP/qQEXP365MZUE
         feY+V2XhrwiOek51R+qbns+ckcXPy+HJESbs0uDWUtCP2NpmB/Qz90bRg0UEs8HcDJr6
         EqNHuK2ToyquBokZa+spRTmVm4lcdjIPvtWrlhIBYPrXjJz8Z0iW9Sivv2kECs8aR1F0
         XkPw==
X-Gm-Message-State: AOAM533QQ0HAt7CPSM9kXr4XhwrezDpos1aa0WZN6+l6PhTxfYqqBlws
        6mSb+UsRlAhmgXrOekWCUHtRJA==
X-Google-Smtp-Source: ABdhPJzm2cCcO0u4i8hOJVkt4TjDUcWFs1N1zfBcOn/4zKXS4V/Z5gurlRsi7gZOluyqmPyqUK3fPA==
X-Received: by 2002:ac8:6945:: with SMTP id n5mr9546327qtr.202.1601588034984;
        Thu, 01 Oct 2020 14:33:54 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r195sm7312186qke.74.2020.10.01.14.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:33:54 -0700 (PDT)
Subject: Re: [PATCH 1/9] btrfs: add a trace point for reserve tickets
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <35017faea237f88452785b208e4fe36002b46fc9.1601495426.git.josef@toxicpanda.com>
 <8808e629-06c6-5015-9ef3-ac9783078526@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <52edaa20-4b98-92b3-b239-11a2ccbe230c@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:33:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8808e629-06c6-5015-9ef3-ac9783078526@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 1:54 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
>> While debugging a ENOSPC related performance problem I needed to see the
>> time difference between start and end of a reserve ticket, so add a
>> tracepoint where we add the ticket, and where we end the ticket.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I wonder can't we get away with a single tracepoint - simply record the
> queue time when we create the ticket in __reserve_bytes and then have a
> single tracepoint in handle_reserve_ticket which calculates the
> difference between curr_time and the written one while the ticket was
> queued? IMO it will be more user friendly for manual inspection, I
> assume you have analyzed the duration with a bpf script rather than
> looking at every pair of start/end events manually? Also won't it be
> useful to also have the flush type printed in the end event so that at
> least we know what is the type of the ticket ? Let's not forget
> tracepoint from the POV of Linus are more or less ABI so it's preferable
> if we get them right from the beginning.

I'm kind of opposed to tracking time for tracepoints.  Yes I used bpf, but it's 
not hard to do, you can just do something like

bpftrace -e 'tracepoint:btrfs:btrfs_add_reserve_ticket {@start[pid] = time();} \
	tracepoint:btrfs:btrfs_end_reserve_ticket { \
		@times = hist(time() - @start[pid]); }'

nothing overly complicated, and leaves all the computation work to the thing 
doing the tracing, not in the kernel itself.

I didn't want to bring the flush type into the end one because I have to store 
it in the ticket, and you can get it from the start trace point.  However it 
probably would be useful if we want to just catch error events, so I'll add 
that.  Thanks,

Josef
