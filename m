Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85F3CA28F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhGOQnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhGOQnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 12:43:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD64C06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 09:40:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso4836111pjp.5
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iI5jTUuimD4hXvCpwOnWjIBZjA5qquqJ3w+NlrTPdSQ=;
        b=JVKcPFb6lPGMxIQeF1P1kz+qTr2ZFGcBcrZZw7iAcIBPdljWYN37CX0Yk3OO+7kkQ9
         2pEqdvNtrWQhZS9hBvwdF3nrJ+Xaj2K6KKNR20IQjIypNd10Lb+Nz6oChEmCO35xMD0g
         wlJfoZCm+IMoIR5BskxlMpR1lhgZU4P575+x8bihmustOLxOB67cZJUWQ1pw/2l8UFQs
         4MBGU0amw2pz6l3spqyqWJpTsKciYthbzRQcTQb+hK8k4lPGDlJ4w59qZDzKarT0lftU
         G6VjIL8KeiFiZiKG+U9niVrXtjxgipfA93XYuQ1rGpRKFv05JKtkaPvAe5/pI8m+YAuL
         Qm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iI5jTUuimD4hXvCpwOnWjIBZjA5qquqJ3w+NlrTPdSQ=;
        b=TGwa7nL63O5TSiXK3r2lo3VfbTvH6CCX6MhKlWg2NeQr0CqX48POYQHVB7IgQl/ZoQ
         Ui0+gytjvZFE/c0LjYZWnSe6RZHjVcCH0Mz3rxWxkmiYLxIjsUSvOSmf3nLdIDeanfZG
         dN4x2lNTlnwyCp6kV7ud4wK15GvpWyMlucJU2UOmPEVMHkB99DyUh0Xpz4EMI0wpAm9D
         2R6t/IRoz9YeOPLb9VVwmSr6avqooWiDQTBA9Y/nlvS4t8z772lkCWoD4mI7Q6M0i++J
         yoKGL8AHBZC7Gp0MCnctSvQhYu7GQi51oUEaMhEMdKpdxeoQxhEGAuPDEi3PnoltHLxl
         En5w==
X-Gm-Message-State: AOAM5330onaqwigs4Ha+u+8hkMtkELOFZvPSyBlsGmdnF0kBmsUZaFsD
        qbQH2SsvzUAsofRTfqoFT68=
X-Google-Smtp-Source: ABdhPJwmBwy1/W6vw7uChQqMbkDCGjVyulkB6Q2iZOmvGPjrf6LLJ2dfRezdqPpT9FjRCmc2KsQLeA==
X-Received: by 2002:a17:902:bf45:b029:129:8147:3a93 with SMTP id u5-20020a170902bf45b029012981473a93mr4187665pls.84.1626367227731;
        Thu, 15 Jul 2021 09:40:27 -0700 (PDT)
Received: from [192.168.178.53] ([61.68.235.24])
        by smtp.gmail.com with ESMTPSA id bj15sm5929171pjb.6.2021.07.15.09.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 09:40:27 -0700 (PDT)
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
 <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Cc:     danglingpointerexception@gmail.com
Message-ID: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
Date:   Fri, 16 Jul 2021 02:40:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Just updating here that setting the mount option "space_cache=v2" and 
"noatime" completely SOLVED the performance problem!
Basically like night and day!


These are my full fstab mount options...

btrfs defaults,autodefrag,space_cache=v2,noatime 0 2


Perhaps defaulting the space_cache=v2 should be considered?  Why default 
to v1, what's the value of v1?


So for conclusion, for large multi-terrabyte arrays (in my case RAID5s), 
setting space_cache=v2 and noatime massively increases performance and 
eliminates the large long pauses in frequent intervals by 
"btrfs-transacti" blocking all IO.

Thanks Qu for your help!



On 14/7/21 5:45 pm, Qu Wenruo wrote:
>
>
> On 2021/7/14 下午3:18, DanglingPointer wrote:
>> a) "echo l > /proc/sysrq-trigger"
>>
>> The backup finished today already unfortunately and we are unlikely to
>> run it again until we get an outage to remount the array with the
>> space_cache=v2 and noatime mount options.
>> Thanks for the command, we'll definitely use it if/when it happens again
>> on the next large migration of data.
>
> Just to avoid confusion, after that command, "dmesg" output is still
> needed, as that's where sysrq put its output.
>>
>>
>> b) "sudo btrfs qgroup show -prce" ........
>>
>> $ ERROR: can't list qgroups: quotas not enabled
>>
>> So looks like it isn't enabled.
>
> One less thing to bother.
>>
>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes (Duplicacy
>> backup defaults)
>
> Between 1~16MiB, thus tons of small files.
>
> Btrfs is not really good at handling tons of small files, as they
> generate a lot of metadata.
>
> That may contribute to the hang.
>
>>
>> What classifies as a transaction?
>
> It's a little complex.
>
> Technically it's a check point where before the checkpoint, all you see
> is old data, after the checkpoint, all you see is new data.
>
> To end users, any data and metadata write will be included into one
> transaction (with proper dependency handled).
>
> One way to finish (or commit) current transaction is to sync the fs,
> using "sync" command (sync all filesystems).
>
>> Any/All writes done in a 30sec
>> interval?
>
> This the default commit interval. Almost all fses will try to commit its
> data/metadata to disk after a configurable interval.
>
> The default one is 30s. That's also one way to commit current 
> transaction.
>
>>   If 100 unique files were written in 30secs, is that 1
>> transaction or 100 transactions?
>
> It depends. As things like syncfs() and subvolume/snapshot creation may
> try to commit transaction.
>
> But without those special operations, just writing 100 unique files
> using buffered write, it would only start one transaction, and when the
> 30s interval get hit, the transaction will be committed to disk.
>
>>   Millions of files of the size range
>> above were backed up.
>
> The amount of files may not force a transaction commit, if it doesn't
> trigger enough memory pressure, or free space pressure.
>
> Anyway, the "echo l" sysrq would help us to locate what's taking so long
> time.
>
>>
>>
>> c) "Just mount with "space_cache=v2""
>>
>> Ok so no need to "clear_cache" the v1 cache, right?
>
> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>
> Thus it doesn't help much.
>
> The only way to fully clear v1 cache is by using "btrfs check
> --clear-space-cache v1" on a *unmounted* btrfs.
>
>> I wrote this in the fstab but hadn't remounted yet until I can get an
>> outage....
>
> IMHO if you really want to test if v2 would help, you can just remount,
> no need to wait for a break.
>
> Thanks,
> Qu
>>
>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=v2,noatime  0  2 >
>> Thanks again for your help Qu!
>>
>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/13 下午11:38, DanglingPointer wrote:
>>>> We're currently considering switching to "space_cache=v2" with noatime
>>>> mount options for my lab server-workstations running RAID5.
>>>
>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>
>>>>
>>>>   * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>>>     totalling 26TB.
>>>>   * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>>>     totalling 24TB.
>>>>   * Both of the arrays are on individually luks encrypted disks with
>>>>     btrfs on top of the luks.
>>>>   * Both have "defaults,autodefrag" turned on in fstab.
>>>>
>>>> We're starting to see large pauses during constant backups of millions
>>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>>
>>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>>>> consistently shows up as the blocking process/thread locking up
>>>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no 
>>>> disk
>>>> or btrfs errors recorded.  scrub last finished yesterday successfully.
>>>
>>> Please provide the "echo l > /proc/sysrq-trigger" output when such 
>>> pause
>>> happens.
>>>
>>> If you're using qgroup (may be enabled by things like snapper), it may
>>> be the cause, as qgroup does its accounting when committing 
>>> transaction.
>>>
>>> If one transaction is super large, it can cause such problem.
>>>
>>> You can test if qgroup is enabled by:
>>>
>>> # btrfs qgroup show -prce <mnt>
>>>
>>>>
>>>> After doing some research around the internet, we've come to the
>>>> consideration above as described.  Unfortunately the official
>>>> documentation isn't clear on the following.
>>>>
>>>> Official documentation URL -
>>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>>
>>>> 1. How to migrate from default space_cache=v1 to space_cache=v2? It
>>>>     talks about the reverse, from v2 to v1!
>>>
>>> Just mount with "space_cache=v2".
>>>
>>>> 2. If we use space_cache=v2, is it indeed still the case that the
>>>>     "btrfs" command will NOT work with the filesystem?
>>>
>>> Why would you think "btrfs" won't work on a btrfs?
>>>
>>> Thanks,
>>> Qu
>>>
>>>>   So will our
>>>>     "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>>>>     the btrfs command comes from btrfs-progs which is currently 
>>>> v5.4.1-2
>>>>     amd64, is that correct?
>>>> 3. Any other ideas on how we can get rid of those annoying pauses with
>>>>     large backups into the array?
>>>>
>>>> Thanks in advance!
>>>>
>>>> DP
>>>>
