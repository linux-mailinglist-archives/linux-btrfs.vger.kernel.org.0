Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464B73CB7D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbhGPN0x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 09:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhGPN0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 09:26:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD4C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 06:23:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d12so9942426pgd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=pzykDFDXhX1CJpJ40BzzZYn9yMsa2SBdjpNQhmsrBvk=;
        b=GMZiqok8Xl9K4YWxXeWI3V8rmz2Ly13l+RiGMz/qAh83H3YkzqvXHDeFoB9MWVfrlL
         mMp2PdDB2cBoGIJiB2Aw0KGhNER3scRHm2wxUN6tUKlfKLr0dRzKQCfJnsuLVIHtTpkX
         5PVpDyPONv1o7EFxP8LxsCUWa8aGvgdJ0uf1DlY2x32maLpFv4K5ax1gl2J19okwPhwv
         CalDHqhIV6SuAl63Y8LwwbbnKqLq6Dk3cMo+Pj3wOUmMCHeqU8YQqJoeha4lrFD7aXZY
         ro27guOwmtOPnHdz7O3S6rw4DaV6qvoNGWwOBN8ZrZ9FRqrPgn/YHPKyuM/t+vVJxntf
         2UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pzykDFDXhX1CJpJ40BzzZYn9yMsa2SBdjpNQhmsrBvk=;
        b=rpeGcNSTCz7V9M6RH/HLehNRej4xDV0vf+kVh3TFPOV2NDkpvmq+s8nyPpvScE9el/
         7/S91Hy1Mwn0L7vihFFfDRBkGvcJHkYjO97/mtSpV7XyvSfBRejkx2aYSM5P/K7CLHho
         NwqLBCeQv8k8YSDuGP427EmKZeaIyEGlzzhj480Yqn/6elkngzgUbQ0/gRrUoJRfW4Rq
         rFkbaABZM4BSnEg00r2jaBCS01zGEhCrEwTEZtV6BZ4e/yi1zTCy4B0o/Hkra96VMur+
         sT5UIHHCIGYu9F0OCcE0JNAF7pEE2Q8drqcbHEqtU7mcCpXgtp4RlQNVBsjGk5NN+S/9
         6PfQ==
X-Gm-Message-State: AOAM531glWg5DKJx0SuHzWJZvwIqdhI1M6Ohxw9V8teqGVR6HtrEHTgA
        q1KW6tG3aZ6J5+d2rofnZy5k9UftAYk=
X-Google-Smtp-Source: ABdhPJyoPV3m8U6D0GJSG+Pgt792Yjf+mHkmA/BiM5UdpJSaEysm7CIAZjmJ3ddnIcZsQkMR+0z+XQ==
X-Received: by 2002:a65:40c3:: with SMTP id u3mr10096258pgp.401.1626441835601;
        Fri, 16 Jul 2021 06:23:55 -0700 (PDT)
Received: from [192.168.178.53] (60-242-36-91.tpgi.com.au. [60.242.36.91])
        by smtp.gmail.com with ESMTPSA id e4sm12273723pgi.94.2021.07.16.06.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 06:23:55 -0700 (PDT)
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Joshua <joshua@mailmag.net>,
        linux-btrfs@vger.kernel.org
References: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
 <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
 <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
 <0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net>
 <1e09cc8e-7100-a084-9542-e2f734cb33fa@gmail.com>
 <40c94987-936f-e6ac-bcec-2051284e1821@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <2bf147f3-a27d-e62d-861e-c0bfdc15eb9b@gmail.com>
Date:   Fri, 16 Jul 2021 23:23:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <40c94987-936f-e6ac-bcec-2051284e1821@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks Qu for the comprehensive response!


On 16/7/21 10:59 pm, Qu Wenruo wrote:
>
>
> On 2021/7/16 下午8:42, DanglingPointer wrote:
>> Hi Joshua, on that system where you tried to run the
>> "--clear-space-cache v1", when you gave up, did you continue using
>> "space_cache=v2" on it?
>>
>>
>> Here are some more questions to add for anyone who can help educate 
>> us:...
>>
>> Why would someone want to clear the space_cache v1?
>
> Because it takes up space and we won't be able to delete them.
>
>>
>> What's the value of clearing the previous version space_cache before
>> using the new version?
>
> AFAIK, just save some space and reduce the root tree size.
>
> The v1 cache exists as special files inside root tree (not accessible by
> end users).
>
> Their existence takes up space and fragments the file system (one file
> is normally around 64K, and we have one such v1 file for each block
> group, you can see how many small files it has now)
>
>>
>> Why "clear" and not just "delete"?  Won't "deleting" the whole previous
>> space_cache files, blocks, whatever in the filesystem be faster then
>> doing whatever "clear" does?
>
> Just bad naming, and properly from me.
>
> Indeed "delete" would be more proper here.
>
> And we're indeed deleting them in "btrfs check --clear-space-cache v1",
> that's also why it's so slow.
>
> If you have 20T used space, then the it would be around 20,000 block
> groups, meaning 20,000 64K files inside root tree, and deleting them one
> by one, and each deletion will cause a new transaction, no wonder it
> will be slow to hell.
>
>>
>> Am I missing out on something by not attempting to clear the previous
>> version space_cache before using the new v2 version?
>
> Except some wasted space, you're completely fine to skip the slow 
> deletion.
>
> This also means, I should enhance the deletion process to avoid too many
> transactions...
>
> Thanks,
> Qu
>
>>
>>
>> On 16/7/21 3:51 am, Joshua wrote:
>>> Just as a point of data, I have a 96 TB array with RAID1 data, and
>>> RAID1C3 metadata.
>>>
>>> I made the switch to space_cache=v2 some time ago, and I remember it
>>> made a huge difference when I did so!
>>> (It was RAID1 metadata at the time, as RAID1C3 was not available at
>>> the time.)
>>>
>>>
>>> However, I also tried a check with '--clear-space-cache v1' at the
>>> time, and after waiting a literal whole day without it completing, I
>>> gave up, canceled it, and put it back into production.  Is a
>>> --clear-space-cache v1 operation expected to take so long on such a
>>> large file system?
>>>
>>> Thanks!
>>> --Joshua Villwock
>>>
>>>
>>>
>>> July 15, 2021 9:40 AM, "DanglingPointer"
>>> <danglingpointerexception@gmail.com> wrote:
>>>
>>>> Hi Qu,
>>>>
>>>> Just updating here that setting the mount option "space_cache=v2" and
>>>> "noatime" completely SOLVED
>>>> the performance problem!
>>>> Basically like night and day!
>>>>
>>>> These are my full fstab mount options...
>>>>
>>>> btrfs defaults,autodefrag,space_cache=v2,noatime 0 2
>>>>
>>>> Perhaps defaulting the space_cache=v2 should be considered? Why
>>>> default to v1, what's the value of
>>>> v1?
>>>>
>>>> So for conclusion, for large multi-terrabyte arrays (in my case
>>>> RAID5s), setting space_cache=v2 and
>>>> noatime massively increases performance and eliminates the large long
>>>> pauses in frequent intervals
>>>> by "btrfs-transacti" blocking all IO.
>>>>
>>>> Thanks Qu for your help!
>>>>
>>>> On 14/7/21 5:45 pm, Qu Wenruo wrote:
>>>>
>>>>> On 2021/7/14 下午3:18, DanglingPointer wrote:
>>>>>> a) "echo l > /proc/sysrq-trigger"
>>>>>>
>>>>>> The backup finished today already unfortunately and we are 
>>>>>> unlikely to
>>>>>> run it again until we get an outage to remount the array with the
>>>>>> space_cache=v2 and noatime mount options.
>>>>>> Thanks for the command, we'll definitely use it if/when it happens
>>>>>> again
>>>>>> on the next large migration of data.
>>>>> Just to avoid confusion, after that command, "dmesg" output is still
>>>>> needed, as that's where sysrq put its output.
>>>>>> b) "sudo btrfs qgroup show -prce" ........
>>>>>>
>>>>>> $ ERROR: can't list qgroups: quotas not enabled
>>>>>>
>>>>>> So looks like it isn't enabled.
>>>>> One less thing to bother.
>>>>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes
>>>>>> (Duplicacy
>>>>>> backup defaults)
>>>>> Between 1~16MiB, thus tons of small files.
>>>>>
>>>>> Btrfs is not really good at handling tons of small files, as they
>>>>> generate a lot of metadata.
>>>>>
>>>>> That may contribute to the hang.
>>>>>
>>>>>> What classifies as a transaction?
>>>>> It's a little complex.
>>>>>
>>>>> Technically it's a check point where before the checkpoint, all 
>>>>> you see
>>>>> is old data, after the checkpoint, all you see is new data.
>>>>>
>>>>> To end users, any data and metadata write will be included into one
>>>>> transaction (with proper dependency handled).
>>>>>
>>>>> One way to finish (or commit) current transaction is to sync the fs,
>>>>> using "sync" command (sync all filesystems).
>>>>>
>>>>>> Any/All writes done in a 30sec
>>>>>> interval?
>>>>> This the default commit interval. Almost all fses will try to commit
>>>>> its
>>>>> data/metadata to disk after a configurable interval.
>>>>>
>>>>> The default one is 30s. That's also one way to commit current >
>>>>> transaction.
>>>>>
>>>>>> If 100 unique files were written in 30secs, is that 1
>>>>>> transaction or 100 transactions?
>>>>> It depends. As things like syncfs() and subvolume/snapshot 
>>>>> creation may
>>>>> try to commit transaction.
>>>>>
>>>>> But without those special operations, just writing 100 unique files
>>>>> using buffered write, it would only start one transaction, and 
>>>>> when the
>>>>> 30s interval get hit, the transaction will be committed to disk.
>>>>>
>>>>>> Millions of files of the size range
>>>>>> above were backed up.
>>>>> The amount of files may not force a transaction commit, if it doesn't
>>>>> trigger enough memory pressure, or free space pressure.
>>>>>
>>>>> Anyway, the "echo l" sysrq would help us to locate what's taking so
>>>>> long
>>>>> time.
>>>>>
>>>>>> c) "Just mount with "space_cache=v2""
>>>>>>
>>>>>> Ok so no need to "clear_cache" the v1 cache, right?
>>>>> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>>>>
>>>>> Thus it doesn't help much.
>>>>>
>>>>> The only way to fully clear v1 cache is by using "btrfs check
>>>>> --clear-space-cache v1" on a *unmounted* btrfs.
>>>>>
>>>>>> I wrote this in the fstab but hadn't remounted yet until I can 
>>>>>> get an
>>>>>> outage....
>>>>> IMHO if you really want to test if v2 would help, you can just 
>>>>> remount,
>>>>> no need to wait for a break.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=v2,noatime
>>>>>> 0  2 >
>>>>>> Thanks again for your help Qu!
>>>>>>
>>>>>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>>>> On 2021/7/13 下午11:38, DanglingPointer wrote:
>>>>> We're currently considering switching to "space_cache=v2" with 
>>>>> noatime
>>>>> mount options for my lab server-workstations running RAID5.
>>>>>
>>>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>>>
>>>>> * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>>>> totalling 26TB.
>>>>> * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>>>> totalling 24TB.
>>>>> * Both of the arrays are on individually luks encrypted disks with
>>>>> btrfs on top of the luks.
>>>>> * Both have "defaults,autodefrag" turned on in fstab.
>>>>>
>>>>> We're starting to see large pauses during constant backups of 
>>>>> millions
>>>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>>>
>>>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>>>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>>>>> consistently shows up as the blocking process/thread locking up
>>>>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no
>>>>> >>>> disk
>>>>> or btrfs errors recorded.  scrub last finished yesterday 
>>>>> successfully.
>>>>>
>>>>> Please provide the "echo l > /proc/sysrq-trigger" output when such
>>>>> >>> pause
>>>>> happens.
>>>>>
>>>>> If you're using qgroup (may be enabled by things like snapper), it 
>>>>> may
>>>>> be the cause, as qgroup does its accounting when committing >>>
>>>>> transaction.
>>>>>
>>>>> If one transaction is super large, it can cause such problem.
>>>>>
>>>>> You can test if qgroup is enabled by:
>>>>>
>>>>> # btrfs qgroup show -prce <mnt>
>>>>>
>>>>> After doing some research around the internet, we've come to the
>>>>> consideration above as described.  Unfortunately the official
>>>>> documentation isn't clear on the following.
>>>>>
>>>>> Official documentation URL -
>>>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>>>
>>>>> 1. How to migrate from default space_cache=v1 to space_cache=v2? It
>>>>> talks about the reverse, from v2 to v1!
>>>>>
>>>>> Just mount with "space_cache=v2".
>>>>>
>>>>> 2. If we use space_cache=v2, is it indeed still the case that the
>>>>> "btrfs" command will NOT work with the filesystem?
>>>>>
>>>>> Why would you think "btrfs" won't work on a btrfs?
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>> So will our
>>>>> "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>>>>> the btrfs command comes from btrfs-progs which is currently >>>>
>>>>> v5.4.1-2
>>>>> amd64, is that correct?
>>>>> 3. Any other ideas on how we can get rid of those annoying pauses 
>>>>> with
>>>>> large backups into the array?
>>>>>
>>>>> Thanks in advance!
>>>>>
>>>>> DP
