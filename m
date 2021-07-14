Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627FB3C8162
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhGNJWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhGNJWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 05:22:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C53C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 02:19:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 37so1819792pgq.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Br7N5lqS0vEa8sk90uYU7tnnWBdNKVaRiKeDV4IFKKw=;
        b=KL6ob4fWw/OmhrlS9losAaHPayAaEEVGIbtxMfl+LCFCdH4PT92OHKrBtJaJ8SDU2+
         RhOeK7dGTv3trsNANaHvgkpL/0OrEU6c48L5vOSYB5tNM/jdIKgH2zybX5PBkAlsXbkG
         pEhfF9FyqueziDi3zLgCQceEbE5K/G47N062zXF21/D1XGdH9/kn2Chz5VuqfvOjEWSI
         eMeCfnUdSidcq7j0J7rd6IR2cIjb3S/hNUw9m8+EA4yJ21SkRW1knC0caVROdSSdPAr8
         x5MpnljEKK2jitoZo6hKhGN22ER2OYP1gsnJphc9UDyjbvmo1zOSrYtx543BTxPk6thZ
         vaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Br7N5lqS0vEa8sk90uYU7tnnWBdNKVaRiKeDV4IFKKw=;
        b=KdJF/BrkxriWbKCYOapZaBbeFbeVrzNWNU734CTIvyuVAH068AUOIMNHCaG4a6C/9L
         iVBISP3TtsIkszMtZnDDs0fMBvxtqn7KiQinbsK0QDjZoBPqMlibgrsvArVV0UhVPx3M
         GS7cAwGm3f/2cUasBpAgPYwGnpEpUHbWayMrIJY/DO6SRDkU3nh1YCmQddxlEIw/yY5t
         bSrXvshkz4nDGxNcNowibkqcpMtzB9/YuKh0xyABgTdOa54PcA7L4NY1pQlHMdB6i7dF
         PIyLXpmuutAUO94hlbnmBxxXwdQiW+GpnB+GwPRbmoBPHo76/qx5nh6qSXftyi3M58wx
         GdLg==
X-Gm-Message-State: AOAM533CHw3uCz6ZOJlQem8//uF3kaYKvhidmJjH37AzOQzOgVbVixT1
        rPmAGGuaPsP2Sbd3tGDzmerLOeKS+Uw=
X-Google-Smtp-Source: ABdhPJzbuBmbCFiZvJ0A/sssEOWuHuS2CWpncYfnScHHuTFEMSOQfgU9T5TziBl7xCYs7GAIqDstaQ==
X-Received: by 2002:a63:e214:: with SMTP id q20mr8581105pgh.437.1626254396361;
        Wed, 14 Jul 2021 02:19:56 -0700 (PDT)
Received: from [192.168.178.53] (14-203-78-180.tpgi.com.au. [14.203.78.180])
        by smtp.gmail.com with ESMTPSA id f5sm1979389pfn.134.2021.07.14.02.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:19:55 -0700 (PDT)
Subject: Re: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
 <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com>
 <db80b801-9e7d-ce2b-15dd-84b30faf19cd@gmail.com>
 <2a29adba-8451-7550-a6f1-835be431953b@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <762a5060-e38d-ccef-293d-c05389d5b0af@gmail.com>
Date:   Wed, 14 Jul 2021 19:19:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2a29adba-8451-7550-a6f1-835be431953b@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes noted.

We're aware of the write hole risk.  We have battery backup for both 
workstations and automation to shut it down in the event of power-outage.

Also they are lab workstations. Not production.  Data is backed up to 
two locations.

The primary reason for RAID5 (or 6) is economics.  Money goes way 
further with RAID5 compared to other RAIDs (1,/10,etc) for the amount of 
data store-able in an array with the reliability of being able to loose 
a disk.  I'm sure there are thousands of others out there in a similar 
situation to me where economics are tight.

Would be good if at some point RAID56 can be looked on and fixed and 
further optimised so it can be declared stable.  Thousands of people 
would further flock to btrfs, especially small medium enterprises, orgs, 
charities, home users, schools and labs.


On 14/7/21 5:57 pm, Qu Wenruo wrote:
>
>
> On 2021/7/14 下午3:34, DanglingPointer wrote:
>> "Why would you think btrfs-progs is the one needs to optimization?"
>>
>> Perhaps I should have written more context.  When the data migration was
>> taking a very long time (days); and the pauses due to "btrfs-transacti"
>> blocking all IO including nfsd.  We thought, "should we '$ btrfs scrub
>> <mount>' to make sure nothing had gone wrong?"
>>
>> Problem is, scrubbing on the whole RAID5 takes ages!
>
> First thing first, if your system may hit unexpected power loss, or disk
> corruption, it's highly recommended not to use btrfs RAID5.
>
> (It's OK if you build btrfs upon soft/hard RAID5).
>
> Btrfs raid5 has its write-hole problem, meaning each power loss/disk
> corruption will slightly degrade the robustness of RAID5.
>
> Without enough such small degradation, some corruption will no longer be
> repairable.
> Scrub is the way to rebuild the robustness, so great you're already
> doing that, but I still won't recommend btrfs RAID5 for now, just as the
> btrfs(5) man page shows.
>
>
>
> Another reason why btrfs RAID5 scrub takes so long is, how we do full fs
> scrub.
>
> We initiate scrub for *each* device.
>
> That means, if we have 4 disks, we will scrub all 4 disks separately.
>
> For each device scrub, we need to read all the 4 stripes to also make
> sure the parity stripe is also fine.
>
> But in theory, we only need to read such RAID5 stripe once, then all
> devices are covered.
>
> So you see we waste quite some disk IO to do some duplicated check.
>
> That's also another reason we recommend RAID1/RAID10.
> During scrubbing of each device, we really only need to read from that
> device, and only when its data is corrupted, we will try to read the
> other copy.
>
> This has no extra IO wasted.
>
> Thanks,
> Qu
>
>>   If we did one disk
>> of the array only it would at least sample a quarter of the array with a
>> quarter chance of detecting if something/anything had gone wrong and
>> hopefully won't massively slow down the on-going migration.
>>
>> We tried it for a while on the single drive and it did indeed have 2x
>> the scrubbing throughput but it was still very slow since we're talking
>> multi-terrabytes on the single disk!  I believe the ETA forecast was ~3
>> days.
>>
>> Interestingly scrubbing the whole lot (whole RAID5 array) in one go by
>> just scrubbing the mount point is a 4day ETA which we do regularly every
>> 3 months.  So even though it is slower on each disk, it finishes the
>> whole lot faster than doing one disk at a time sequentially.
>>
>> Anyways, thanks for informing us on what btrfs-progs does and how 'scrub
>> speed' is independent of btrfs-progs and done by the kernel ioctls (on
>> the other email thread).
>>
>> regards,
>>
>> DP
>>
>> I thought btrfs scrub was part of btrfs-progs.  Pardon my ignorance if
>> it isn't.
>>
>>
>> On 14/7/21 3:00 pm, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/14 上午10:51, DanglingPointer wrote:
>>>> Recently we have been impacted by some performance issues with the
>>>> workstations in my lab with large multi-terabyte arrays in btrfs.  I
>>>> have detailed this on a separate thread.  It got me thinking however,
>>>> why not have an optional configure option for btrfs-progs to use PGO
>>>> against the entire suite of regression tests?
>>>>
>>>> Idea is:
>>>>
>>>> 1. configure with optional "-pgo" or "-fdo" option which will 
>>>> configure
>>>>     a relative path from source root where instrumentation files 
>>>> will go
>>>>     (let's start with gcc only for now, so *.gcda files into a 
>>>> folder).
>>>>     We then add the instrumentation compiler option
>>>> 2. build btrfs-progs
>>>> 3. run every single tests available ( make test && make test-fsck &&
>>>>     make test-convert)
>>>> 4. clean-up except for instrumentation files
>>>> 5. re-build without the instrumentation flag from point 1; and use the
>>>>     instrumentation files for feedback directed optimisation (FDO) 
>>>> (for
>>>>     gcc add additional partial-training flag); add LTO.
>>>
>>> Why would you think btrfs-progs is the one needs to optimization?
>>>
>>> From your original report, there is nothing btrfs-progs related at all.
>>>
>>> All your work, from scrub to IO, it's all handled by kernel btrfs 
>>> module.
>>>
>>> Thus optimization of btrfs-progs would bring no impact.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> I know btrfs is primarily IO bound and not cpu.  But just thinking of
>>>> squeezing every last efficiency out of whatever is running in the cpu,
>>>> cache and memory.
>>>>
>>>> I suppose people can do the above on their own, but was thinking if it
>>>> was provided as a configuration optional option then it would make it
>>>> easier for people to do without more hacking.  Just need to add 
>>>> warnings
>>>> that it will take a long time, have a coffee.
>>>>
>>>> The python3 configure process has the process above as an optional
>>>> option but caters for gcc and clang (might even cater for icc).
>>>>
>>>> Anyways, that's my idea for an enhancement above.
>>>>
>>>> Would like to know your thoughts.  cheers...
>>>>
