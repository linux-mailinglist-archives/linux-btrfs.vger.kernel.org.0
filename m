Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FB212576
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgGBN5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgGBN5s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:57:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30190C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:57:48 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so25670847qkc.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Db/apVgITb5XMHVkFRFK6BwpuZc7LhnxjP9NwOsegDI=;
        b=GUIAR0jQSuXq3tPLdHpsHxbpJq4A55DvfreTCEgV9OX2fduvcv+e00nHrLTIK+3EZ6
         Yvx1wQc685wYFb1F/Yjnd8eyMCRS/12pQo9EmfTZk/NVzyAd4bGPyAGtunqC9E7Yq+kE
         rS6fJ3voyImMx2rxvQ+SBHGOEuRLGGB/yfbofaAbsfVbfpz08eHOYZBaufGw7imw7Lxp
         kpDCYKq1rgUNCBddejkheJ1qea/gAP8ud+Pih5T2xakblp7oeKyKLlhN/TmIPEoEMehw
         qkXp4rtIwNIUWNKtbFc+5mUM+/p03qUF75qAGihIf0VTRexlHpmeEmT4GCwwd6bm32GT
         FSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Db/apVgITb5XMHVkFRFK6BwpuZc7LhnxjP9NwOsegDI=;
        b=OvXFlpCerHOeOfl8H4ApwzseaIKpy62pGxw91aCHRv8aMICZ4dSYF56ufFrTZ/oZfr
         iWZ94fNPSmubxmFXo7tNSqFxxonuBCLhjpVTsCKRKs9cIYyiPZPdEIg1F+Xd3HJDdeHu
         O4qK/glQVN5QPYZfsAiwcHYYWyVnC01wtMsxN/WKcijd/dJOIPyA6T+AadBVyDWlRHpO
         Y/WqW8VB/HqajPmYPPre7fuwlAGSOJZZb+sz2U9gwktqW3eX0YJ2fuE1JLXaSR3ecgK2
         uL/kSa6Yz7aQ6HvNDj7Rn5Y8TWVXG9bXkAagA+pPqMRId2pZZvImNaZVPx/iEhh+6zCy
         qnAg==
X-Gm-Message-State: AOAM533hs/vFri8U902xxYbs5MoXjBF8x1vyBp/NcqBpHpT0Z4BVhcVC
        TD8SFVRdf1tHPeIUxB4z9ItlZcYpCFweFg==
X-Google-Smtp-Source: ABdhPJzWtB/cSxOth5Q7u9KUhtApFdzAc5lQvsQ/GI2Mi79L3tbKwSFJB0Cj9KbACvLg7pqgbJUKVw==
X-Received: by 2002:a37:b941:: with SMTP id j62mr18820936qkf.233.1593698266837;
        Thu, 02 Jul 2020 06:57:46 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h52sm9074672qtb.88.2020.07.02.06.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:57:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] btrfs: qgroup: Try to flush qgroup space when we get
 -EDQUOT
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-3-wqu@suse.com>
 <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
 <f4f0e752-0166-538d-7376-17f7fefe44f2@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5ff3b488-d82a-fbc3-97d4-8b85cacab1c9@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:57:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f4f0e752-0166-538d-7376-17f7fefe44f2@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 9:54 AM, Qu Wenruo wrote:
> 
> 
> On 2020/7/2 下午9:43, Josef Bacik wrote:
>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>> [PROBLEM]
>>> There are known problem related to how btrfs handles qgroup reserved
>>> space.
>>> One of the most obvious case is the the test case btrfs/153, which do
>>> fallocate, then write into the preallocated range.
>>>
>>>     btrfs/153 1s ... - output mismatch (see
>>> xfstests-dev/results//btrfs/153.out.bad)
>>>         --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
>>>         +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01
>>> 20:24:40.730000089 +0800
>>>         @@ -1,2 +1,5 @@
>>>          QA output created by 153
>>>         +pwrite: Disk quota exceeded
>>>         +/mnt/scratch/testfile2: Disk quota exceeded
>>>         +/mnt/scratch/testfile2: Disk quota exceeded
>>>          Silence is golden
>>>         ...
>>>         (Run 'diff -u xfstests-dev/tests/btrfs/153.out
>>> xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
>>>
>>> [CAUSE]
>>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have
>>> to"),
>>> we always reserve space no matter if it's COW or not.
>>>
>>> Such behavior change is mostly for performance, and reverting it is not
>>> a good idea anyway.
>>>
>>> For preallcoated extent, we reserve qgroup data space for it already,
>>> and since we also reserve data space for qgroup at buffered write time,
>>> it needs twice the space for us to write into preallocated space.
>>>
>>> This leads to the -EDQUOT in buffered write routine.
>>>
>>> And we can't follow the same solution, unlike data/meta space check,
>>> qgroup reserved space is shared between data/meta.
>>> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
>>> check after qgroup reservation failure is not a solution.
>>
>> Why not?  I get that we don't know for sure how we failed, but in the
>> case of a write we're way more likely to have failed for data reasons
>> right?
> 
> Nope, mostly we failed at metadata reservation, as that would return
> EDQUOT to user space.
> 
> We may have some cases which get EDQUOT at data reservation part, but
> that's what we excepted.
> (And already what we're doing)
> 
> The problem is when the metadata reservation failed with EDQUOT.
> 
>>    So why not just fall back to the NODATACOW check and then do the
>> metadata reservation. Then if it fails again you know its a real EDQUOT
>> and your done.
>>
>> Or if you want to get super fancy you could even break up the metadata
>> and data reservations here so that we only fall through to the NODATACOW
>> check if we fail the data reservation.  Thanks,
> 
> The problem is, qgroup doesn't split metadata and data (yet).
> Currently data and meta shares the same limit.
> 
> So when we hit EDQUOT, you have no guarantee it would happen only in
> qgroup data reservation.
> 

Sure, but if you are able to do the nocow thing, then presumably your quota 
reservation is less now?  So on failure you go do the complicated nocow check, 
and if it succeeds you retry your quota reservation with just the metadata 
portion, right?  Thanks,

Josef
