Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72A32A6C7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 19:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgKDSJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 13:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgKDSJt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 13:09:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5DC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 10:09:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so12276821wrl.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D4Ucewew/YQR3KqUdqE49B0xybd2O+sztbow7iMC+Vg=;
        b=q90S+089RDSXSTrb+kigp7pvzVUWYzrCLgEE0jb9EqkxwPBtDms808Y3+p0+grWqo3
         We2X+N/huFXPRr+KtUdomQktWiX7Cgg40U32u8ewLk9t7BdpJHsxa9PHgA0hujbf2sD9
         ywTM2sEhgBFyGGztvbXXCWO9cNGm9UNtlqBgCxMGLkPKY7wH0awL6OEhEiFE4OhbsQtc
         cXm69pBST8qMmjLDQ73mxXp112HQ7capLYLI+hIPjuhfEmBd9ugDDEG8aZoxHpFL7KhH
         6G6MdPZWTqxm+b/CSS4iO2ijkXDDuV1L5mIDICf4ZSDM8nETVrn+DY2TW9xygg/FGZad
         n6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D4Ucewew/YQR3KqUdqE49B0xybd2O+sztbow7iMC+Vg=;
        b=QQIkyJQbT9d3mQMGUrXjNpwxmTMCEluILPbXpfYnAIixK09SP/AfmZEUIVH4OEpTm6
         W4ezj64O8/jE4/VAV4pSqm8ThO7mLRkjOtDCeE07pKD2SZ6in9lHDspbTHB5iTHB8Tyt
         aYWyhMbyRg+airrO5fsVSL+yYvCYnUzLMKt9sF9RTbjpRMQMprFsfP4rYNhrSzCknOLE
         qNsp7cCGWQEtevFjaJJQ6TeXD983PFFljrdcpycXj1RoTbs2cp1zsVQhT/yh4Xu6KdB5
         mNKvY5Yg7ASgEva6eQFC3eEHUOd1PHmiqg6e0ijDR/KqttdydZjcmJoAVa9DA99GSNGk
         AtIQ==
X-Gm-Message-State: AOAM531U6yVOXqnfubjif1Usv25hOBrV3bM++6c1rQUeItryihTOrch9
        LKSk0DZtkanZDaI6gEWxitb1z7hk7qKZjg==
X-Google-Smtp-Source: ABdhPJzDMmhnEezalm4UdWrDfeQJJDip70kOvl4J2wU8fdurVdzjQiv12hXkbyz5X9w5aMRwVzV74w==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr1462539wrq.292.1604513387333;
        Wed, 04 Nov 2020 10:09:47 -0800 (PST)
Received: from [192.168.1.121] (host109-152-100-164.range109-152.btcentralplus.com. [109.152.100.164])
        by smtp.gmail.com with ESMTPSA id 15sm3176236wmg.1.2020.11.04.10.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:09:46 -0800 (PST)
Subject: Re: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1604444952.git.asml.silence@gmail.com>
 <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
 <CAE1WUT5+3xLHe54Mk0wEmp1GtbRhkMkdSi=QPERZegphk=ecLw@mail.gmail.com>
 <2be31971-da4f-1a39-cb01-0c13b35cf2aa@gmail.com>
 <CAE1WUT4HtRLs+-7T825akYVBwCtugcnXZ3J4XvaL0_b5F9G18Q@mail.gmail.com>
 <4484059b-1e9a-995c-1632-b0ee81eaf605@gmail.com>
 <CAE1WUT6WudydeAyXLKaJBQeaouFb3Sx42euekDHGR9tD61nm3Q@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <36897f55-26cf-4814-8549-9392a6e9e4b1@gmail.com>
Date:   Wed, 4 Nov 2020 18:06:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT6WudydeAyXLKaJBQeaouFb3Sx42euekDHGR9tD61nm3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/11/2020 17:55, Amy Parker wrote:
> On Wed, Nov 4, 2020 at 9:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 04/11/2020 17:33, Amy Parker wrote:
>>> On Wed, Nov 4, 2020 at 9:22 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> On 04/11/2020 15:29, Amy Parker wrote:
>>>>> On Wed, Nov 4, 2020 at 1:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>>
>>>>>> Instead of using iops_limit only for cutting off extremes, calculate the
>>>>>> discard delay directly from it, so it closely follows iops_limit and
>>>>>> doesn't under-discarding even though quotas are not saturated.
>>>>>
>>>>> This sounds like it potentially be a great performance boost, do you
>>>>> have any performance metrics regarding this patch?
>>>>
>>>> Boosting the discard rate and so reaping stalling blocks may be nice, but
>>>> unless it holds too much memory creating lack of space it shouldn't affect
>>>> throughput. Though, it's better to ask people with deeper understanding
>>>> of the fs.
>>>
>>> Alright, thanks for the clarification.
>>>
>>>> What I've seen is that in some cases there are extents staying queued for
>>>> discarding for _too_ long. E.g. reaping a small number of very fat extents
>>>> keeps delay at max and doesn't allow to reap them effectively. That could
>>>> be a problem with fast drives.
>>>
>>> Ah, yep. Seen this personally to a smaller extent.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>>> ---
>>>>>>  fs/btrfs/discard.c | 10 +++++-----
>>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
>>>>>> index 741c7e19c32f..76796a90e88d 100644
>>>>>> --- a/fs/btrfs/discard.c
>>>>>> +++ b/fs/btrfs/discard.c
>>>>>> @@ -519,7 +519,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>>>>>>         s64 discardable_bytes;
>>>>>>         u32 iops_limit;
>>>>>>         unsigned long delay;
>>>>>> -       unsigned long lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
>>>>>>
>>>>>>         discardable_extents = atomic_read(&discard_ctl->discardable_extents);
>>>>>>         if (!discardable_extents)
>>>>>> @@ -550,11 +549,12 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>>>>>>
>>>>>>         iops_limit = READ_ONCE(discard_ctl->iops_limit);
>>>>>>         if (iops_limit)
>>>>>> -               lower_limit = max_t(unsigned long, lower_limit,
>>>>>> -                                   MSEC_PER_SEC / iops_limit);
>>>>>> +               delay = MSEC_PER_SEC / iops_limit;
>>>>>> +       else
>>>>>> +               delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
>>>>>
>>>>> Looks good to me. I wonder why there wasn't handling of if iops_limit
>>>>> was unfindable
>>>>> before?
>>>>
>>>> Not sure what you mean by unfindable, but async discard is relatively new,
>>>> might be that everyone just have their hands full.
>>>
>>> By unfindable I mean if iops_limit turned up as null when reading it
>>> from discard_ctl.
>>
>> Ahh, ok. It's handled and I left it as it was, that BTW is still a problem.
> 
> How often is iops_limit unfindable?

I don't know, but the default is 10, so shouldn't be too ubiquitous.
Maybe someone here knows statistics.

> 
>>
>> First it calculates a delay based on number of queued extents and than clamps
>> it to (BTRFS_DISCARD_MIN_DELAY_MSEC, BTRFS_DISCARD_MAX_DELAY_MSEC). Without
>> this patch it did the same but the lower bound was calculated from iops_limit.
> 
> Thanks for clarifying.
> 
>>
>>> Async discard was added in 5.6, correct? So yeah, makes sense then that people
>>> just had their hands full. Thanks for adding it.
>>
>> b0643e59cfa609c4b5f ("btrfs: add the beginning of async discard, discard
>> workqueue"). Dec 2019, so less than a year
> 
> Thanks for finding the commit.
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> -       delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
>>>>>> -       delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
>>>>>> +       delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
>>>>>> +                     BTRFS_DISCARD_MAX_DELAY_MSEC);
>>>>>>         discard_ctl->delay = msecs_to_jiffies(delay);
>>>>>>
>>>>>>         spin_unlock(&discard_ctl->lock);
>>>>>> --
>>>>>> 2.24.0
>>>>>>
>>>>>
>>>>> This patch looks all great to me.
>>
>> --
>> Pavel Begunkov
> 
> Best regards,
> Amy Parker
> (they/them)
> 

-- 
Pavel Begunkov
