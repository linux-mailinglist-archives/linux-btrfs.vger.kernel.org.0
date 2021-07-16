Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F043CB773
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 14:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhGPMpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhGPMpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 08:45:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0956C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 05:42:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c15so5245402pls.13
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y+hwvs8SJAd1L4djBW0tqYsDBgCOOMJ34MaJFGvi2HM=;
        b=uhvtxlyxNchiF5WzdMu5HCypdJVcmn32sy6ArIJB2cy0jsWdayWZIwak6B4PTxpprl
         TGb3l2QbQL97nLwiiqy9DdEdXp2Z77M+pOZVU9TM0zBop4pSRn2BrG7dP8ochNCudjvs
         4ZTVzSgPkGCLmXVIG1nEtyMmgH9P3SVIi6vuJV/rLkOgfkecmFHEjzr28WF1fWsDYJeC
         jXua/Ig+QbIVQSJHEY/qMBLTUOoZtuMpmlilGMg4CK2/5QgpvGSZcxYDxJC7Uf3nTfV8
         7D5nipKrk9FAqJp7suf3WI6/3+qmJtlpseE943mf43cRHhXenRW9faehVulQmocQ5K0W
         2Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y+hwvs8SJAd1L4djBW0tqYsDBgCOOMJ34MaJFGvi2HM=;
        b=dErC9Wla6ikrLXXulh5Y6U85b8L3I/wqOqwJhgrYUddWgBguYOkH4J5/LVRQw/LxYI
         2gGxSHTzOgSK5BWP6hjXVuQwrf3XK4ebF/7SNThtZfcMSEsMh4lyeyeJUpPbHfSm84Ld
         a/uBgE37c2ORa0G4KDcF1pM9CMuBIg8vdMYmu5LMOwyuZIbvsQIcKdIPd/atu+TBaGbN
         MEYpJx6NBj7ABMykEq9vz2+psyMAGd/hLDmtav0MVpby/344OTGqamah0ZRW058wk4Pq
         YnSlfmN/zImpKT5cDNk5VkJINZmVBDz6rCi2pL0to9qguG7sPKFIuSVUXQEs/7uCUFjm
         yDFg==
X-Gm-Message-State: AOAM533uC1Fb3CrJ1X3f5cdLb01lzisvMK9outPmkfZw4/Nntxrm1A9B
        A0k+Kovb7X43GPmUjkgg9g4=
X-Google-Smtp-Source: ABdhPJxI+f3IWBDWIJ+qmKivna71dQu0DSnHOp+OSuQ8XQAMUFJ2BspnvSWQyN+mXN/5VHtlMOip0g==
X-Received: by 2002:a17:90b:787:: with SMTP id l7mr15466206pjz.162.1626439328274;
        Fri, 16 Jul 2021 05:42:08 -0700 (PDT)
Received: from [192.168.178.53] (60-242-36-91.tpgi.com.au. [60.242.36.91])
        by smtp.gmail.com with ESMTPSA id k189sm11259739pgk.14.2021.07.16.05.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 05:42:07 -0700 (PDT)
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Joshua <joshua@mailmag.net>, linux-btrfs@vger.kernel.org
References: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
 <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
 <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
 <0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Cc:     danglingpointerexception@gmail.com
Message-ID: <1e09cc8e-7100-a084-9542-e2f734cb33fa@gmail.com>
Date:   Fri, 16 Jul 2021 22:42:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Joshua, on that system where you tried to run the 
"--clear-space-cache v1", when you gave up, did you continue using 
"space_cache=v2" on it?


Here are some more questions to add for anyone who can help educate us:...

Why would someone want to clear the space_cache v1?

What's the value of clearing the previous version space_cache before 
using the new version?

Why "clear" and not just "delete"?  Won't "deleting" the whole previous 
space_cache files, blocks, whatever in the filesystem be faster then 
doing whatever "clear" does?

Am I missing out on something by not attempting to clear the previous 
version space_cache before using the new v2 version?


On 16/7/21 3:51 am, Joshua wrote:
> Just as a point of data, I have a 96 TB array with RAID1 data, and RAID1C3 metadata.
>
> I made the switch to space_cache=v2 some time ago, and I remember it made a huge difference when I did so!
> (It was RAID1 metadata at the time, as RAID1C3 was not available at the time.)
>
>
> However, I also tried a check with '--clear-space-cache v1' at the time, and after waiting a literal whole day without it completing, I gave up, canceled it, and put it back into production.  Is a --clear-space-cache v1 operation expected to take so long on such a large file system?
>
> Thanks!
> --Joshua Villwock
>
>
>
> July 15, 2021 9:40 AM, "DanglingPointer" <danglingpointerexception@gmail.com> wrote:
>
>> Hi Qu,
>>
>> Just updating here that setting the mount option "space_cache=v2" and "noatime" completely SOLVED
>> the performance problem!
>> Basically like night and day!
>>
>> These are my full fstab mount options...
>>
>> btrfs defaults,autodefrag,space_cache=v2,noatime 0 2
>>
>> Perhaps defaulting the space_cache=v2 should be considered?  Why default to v1, what's the value of
>> v1?
>>
>> So for conclusion, for large multi-terrabyte arrays (in my case RAID5s), setting space_cache=v2 and
>> noatime massively increases performance and eliminates the large long pauses in frequent intervals
>> by "btrfs-transacti" blocking all IO.
>>
>> Thanks Qu for your help!
>>
>> On 14/7/21 5:45 pm, Qu Wenruo wrote:
>>
>>> On 2021/7/14 下午3:18, DanglingPointer wrote:
>>>> a) "echo l > /proc/sysrq-trigger"
>>>>
>>>> The backup finished today already unfortunately and we are unlikely to
>>>> run it again until we get an outage to remount the array with the
>>>> space_cache=v2 and noatime mount options.
>>>> Thanks for the command, we'll definitely use it if/when it happens again
>>>> on the next large migration of data.
>>> Just to avoid confusion, after that command, "dmesg" output is still
>>> needed, as that's where sysrq put its output.
>>>> b) "sudo btrfs qgroup show -prce" ........
>>>>
>>>> $ ERROR: can't list qgroups: quotas not enabled
>>>>
>>>> So looks like it isn't enabled.
>>> One less thing to bother.
>>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes (Duplicacy
>>>> backup defaults)
>>> Between 1~16MiB, thus tons of small files.
>>>
>>> Btrfs is not really good at handling tons of small files, as they
>>> generate a lot of metadata.
>>>
>>> That may contribute to the hang.
>>>
>>>> What classifies as a transaction?
>>> It's a little complex.
>>>
>>> Technically it's a check point where before the checkpoint, all you see
>>> is old data, after the checkpoint, all you see is new data.
>>>
>>> To end users, any data and metadata write will be included into one
>>> transaction (with proper dependency handled).
>>>
>>> One way to finish (or commit) current transaction is to sync the fs,
>>> using "sync" command (sync all filesystems).
>>>
>>>> Any/All writes done in a 30sec
>>>> interval?
>>> This the default commit interval. Almost all fses will try to commit its
>>> data/metadata to disk after a configurable interval.
>>>
>>> The default one is 30s. That's also one way to commit current > transaction.
>>>
>>>> If 100 unique files were written in 30secs, is that 1
>>>> transaction or 100 transactions?
>>> It depends. As things like syncfs() and subvolume/snapshot creation may
>>> try to commit transaction.
>>>
>>> But without those special operations, just writing 100 unique files
>>> using buffered write, it would only start one transaction, and when the
>>> 30s interval get hit, the transaction will be committed to disk.
>>>
>>>> Millions of files of the size range
>>>> above were backed up.
>>> The amount of files may not force a transaction commit, if it doesn't
>>> trigger enough memory pressure, or free space pressure.
>>>
>>> Anyway, the "echo l" sysrq would help us to locate what's taking so long
>>> time.
>>>
>>>> c) "Just mount with "space_cache=v2""
>>>>
>>>> Ok so no need to "clear_cache" the v1 cache, right?
>>> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>>
>>> Thus it doesn't help much.
>>>
>>> The only way to fully clear v1 cache is by using "btrfs check
>>> --clear-space-cache v1" on a *unmounted* btrfs.
>>>
>>>> I wrote this in the fstab but hadn't remounted yet until I can get an
>>>> outage....
>>> IMHO if you really want to test if v2 would help, you can just remount,
>>> no need to wait for a break.
>>>
>>> Thanks,
>>> Qu
>>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=v2,noatime  0  2 >
>>>> Thanks again for your help Qu!
>>>>
>>>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>> On 2021/7/13 下午11:38, DanglingPointer wrote:
>>> We're currently considering switching to "space_cache=v2" with noatime
>>> mount options for my lab server-workstations running RAID5.
>>>
>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>
>>> * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>> totalling 26TB.
>>> * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>> totalling 24TB.
>>> * Both of the arrays are on individually luks encrypted disks with
>>> btrfs on top of the luks.
>>> * Both have "defaults,autodefrag" turned on in fstab.
>>>
>>> We're starting to see large pauses during constant backups of millions
>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>
>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>>> consistently shows up as the blocking process/thread locking up
>>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no >>>> disk
>>> or btrfs errors recorded.  scrub last finished yesterday successfully.
>>>
>>> Please provide the "echo l > /proc/sysrq-trigger" output when such >>> pause
>>> happens.
>>>
>>> If you're using qgroup (may be enabled by things like snapper), it may
>>> be the cause, as qgroup does its accounting when committing >>> transaction.
>>>
>>> If one transaction is super large, it can cause such problem.
>>>
>>> You can test if qgroup is enabled by:
>>>
>>> # btrfs qgroup show -prce <mnt>
>>>
>>> After doing some research around the internet, we've come to the
>>> consideration above as described.  Unfortunately the official
>>> documentation isn't clear on the following.
>>>
>>> Official documentation URL -
>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>
>>> 1. How to migrate from default space_cache=v1 to space_cache=v2? It
>>> talks about the reverse, from v2 to v1!
>>>
>>> Just mount with "space_cache=v2".
>>>
>>> 2. If we use space_cache=v2, is it indeed still the case that the
>>> "btrfs" command will NOT work with the filesystem?
>>>
>>> Why would you think "btrfs" won't work on a btrfs?
>>>
>>> Thanks,
>>> Qu
>>>
>>> So will our
>>> "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>>> the btrfs command comes from btrfs-progs which is currently >>>> v5.4.1-2
>>> amd64, is that correct?
>>> 3. Any other ideas on how we can get rid of those annoying pauses with
>>> large backups into the array?
>>>
>>> Thanks in advance!
>>>
>>> DP
