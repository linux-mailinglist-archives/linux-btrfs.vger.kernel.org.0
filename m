Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A37212734
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgGBO7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGBO7B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:59:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DEDC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 07:59:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h18so12787862qvl.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1qcnweC8moBnJ/3UikOmyV5FUI8MVN7N/NAzeZydIBM=;
        b=q2xhtLy0GPj+DgcBTnH+A0K8Ro65RCEI/qTi/PjOWyM895JulxCRJR89A2ln5xNMfJ
         gjbHCTMdU1nDqXT6vIENI8pRX7rhfoQ8QuzFwk0qFIpMdRFcY2WhovN/c4oDkA2ghd4g
         GT+p1WiOq974vxueGzFqHau1J701067Ol1gyyFWP3+JV3raJmJs9VkX8/9umojOfhKvb
         uvhsArycryTZoyC4PXr79ISY/7vqiDm+etuyTnXKIpnmfr1E0zjClIxQQ8EbM/twvfMs
         SN0uDG4KFTrLw3rRwoAMVQPvXvTGDHkz/mxbFDyhW4mHw89QTotGmjjUeDAq0lfNjFIT
         C89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qcnweC8moBnJ/3UikOmyV5FUI8MVN7N/NAzeZydIBM=;
        b=bxbxWsdMyPrvk6fCTSzTg7xjhvpjuKnkSvCGKrwI8wr93gJM43r2vXJV0GZYinyq+l
         ayFI+qEF9iWLS2VIGNDnXrR9EMO1ljOTGcsglxnn17Nk2nqyL5lU4j9gCunUGIvVVM3v
         un5RAhd95XgqXZHP/LI7ekIIR2gP10VPnEE3NuogDwJQHXYKnJXyPUBhCcXc9vajgNxx
         hIJorJS4kC1kLtb3AOhcQl2Jxd0ud4xF06R8R/tlsYk0ooVtHz0qGhhrw84Cctek+Vja
         cZtr5DEBbRRnb50TaGdBqfvq6q1g23CT0LuucIrbfA+VcAmQmv/iiciT6OiuSvhF9BM7
         hJcw==
X-Gm-Message-State: AOAM532dL8qgJuZc//julaJKfDwhcwiM02yoow+GXDuOYuPjby7ys3c/
        GfToiGpVbKNRwOA2yV7FTeLmiNz0tkQmHg==
X-Google-Smtp-Source: ABdhPJzYFcGiI3di1gH5Mq4nUzZ85RvQ698ZPwFGZg3bIKMfPTMpvqTJ0325TJ0+llQ4YznpodMjOA==
X-Received: by 2002:ad4:4b62:: with SMTP id m2mr31460185qvx.68.1593701939376;
        Thu, 02 Jul 2020 07:58:59 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s46sm9514275qts.85.2020.07.02.07.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:58:58 -0700 (PDT)
Subject: Re: [PATCH 2/3] btrfs: qgroup: Try to flush qgroup space when we get
 -EDQUOT
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-3-wqu@suse.com>
 <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
 <f4f0e752-0166-538d-7376-17f7fefe44f2@gmx.com>
 <5ff3b488-d82a-fbc3-97d4-8b85cacab1c9@toxicpanda.com>
 <16eb0345-6469-de3e-e091-43c75bc918bb@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a32444a5-f965-c2d5-ca4b-c2365fba106c@toxicpanda.com>
Date:   Thu, 2 Jul 2020 10:58:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <16eb0345-6469-de3e-e091-43c75bc918bb@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 10:19 AM, Qu Wenruo wrote:
> 
> 
> On 2020/7/2 下午9:57, Josef Bacik wrote:
>> On 7/2/20 9:54 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/7/2 下午9:43, Josef Bacik wrote:
>>>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>>>> [PROBLEM]
>>>>> There are known problem related to how btrfs handles qgroup reserved
>>>>> space.
>>>>> One of the most obvious case is the the test case btrfs/153, which do
>>>>> fallocate, then write into the preallocated range.
>>>>>
>>>>>      btrfs/153 1s ... - output mismatch (see
>>>>> xfstests-dev/results//btrfs/153.out.bad)
>>>>>          --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
>>>>>          +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01
>>>>> 20:24:40.730000089 +0800
>>>>>          @@ -1,2 +1,5 @@
>>>>>           QA output created by 153
>>>>>          +pwrite: Disk quota exceeded
>>>>>          +/mnt/scratch/testfile2: Disk quota exceeded
>>>>>          +/mnt/scratch/testfile2: Disk quota exceeded
>>>>>           Silence is golden
>>>>>          ...
>>>>>          (Run 'diff -u xfstests-dev/tests/btrfs/153.out
>>>>> xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
>>>>>
>>>>> [CAUSE]
>>>>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have
>>>>> to"),
>>>>> we always reserve space no matter if it's COW or not.
>>>>>
>>>>> Such behavior change is mostly for performance, and reverting it is not
>>>>> a good idea anyway.
>>>>>
>>>>> For preallcoated extent, we reserve qgroup data space for it already,
>>>>> and since we also reserve data space for qgroup at buffered write time,
>>>>> it needs twice the space for us to write into preallocated space.
>>>>>
>>>>> This leads to the -EDQUOT in buffered write routine.
>>>>>
>>>>> And we can't follow the same solution, unlike data/meta space check,
>>>>> qgroup reserved space is shared between data/meta.
>>>>> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
>>>>> check after qgroup reservation failure is not a solution.
>>>>
>>>> Why not?  I get that we don't know for sure how we failed, but in the
>>>> case of a write we're way more likely to have failed for data reasons
>>>> right?
>>>
>>> Nope, mostly we failed at metadata reservation, as that would return
>>> EDQUOT to user space.
>>>
>>> We may have some cases which get EDQUOT at data reservation part, but
>>> that's what we excepted.
>>> (And already what we're doing)
>>>
>>> The problem is when the metadata reservation failed with EDQUOT.
>>>
>>>>     So why not just fall back to the NODATACOW check and then do the
>>>> metadata reservation. Then if it fails again you know its a real EDQUOT
>>>> and your done.
>>>>
>>>> Or if you want to get super fancy you could even break up the metadata
>>>> and data reservations here so that we only fall through to the NODATACOW
>>>> check if we fail the data reservation.  Thanks,
>>>
>>> The problem is, qgroup doesn't split metadata and data (yet).
>>> Currently data and meta shares the same limit.
>>>
>>> So when we hit EDQUOT, you have no guarantee it would happen only in
>>> qgroup data reservation.
>>>
>>
>> Sure, but if you are able to do the nocow thing, then presumably your
>> quota reservation is less now?  So on failure you go do the complicated
>> nocow check, and if it succeeds you retry your quota reservation with
>> just the metadata portion, right?  Thanks,
> 
> Then metadata portion can still fail, even we skipped the data reserv.
> 
> The metadata portion still needs some space, while the data rsv skip
> only happens after we're already near the qgroup limit, which means
> there are ready not much space left.
> 
> Consider this case, we have 128M limit, we fallocated 120M, then we have
> dirtied 7M data, plus several kilo for metadata reserved.
> 
> Then at the next 1M, we run out of qgroup limit, at whatever position.
> Even we skip current 4K for data, the next metadata reserve may still
> not be met, and still got EDQUOT at metadata reserve.
> 
> Or some other open() calls to create a new file would just get EDQUOT,
> without any way to free any extra space.
> 
> 
> Instead of try to skip just several 4K for qgroup data rsv, we should
> flush the existing 7M, to free at least 7M data + several kilo meta space.
> 

Right so I'm not against flushing in general, I just think that we can greatly 
improve on this particular problem without flushing.  Changing how we do the 
NOCOW check with quota could be faster than doing the flushing.

Now as for the flushing part itself, I'd rather hook into the existing flushing 
infrastructure we have.  Obviously the ticketing is going to be different, but 
the flushing part is still the same, and with data reservations now moved over 
to that infrastructure we finally have it all in the same place.  Thanks,

Josef
