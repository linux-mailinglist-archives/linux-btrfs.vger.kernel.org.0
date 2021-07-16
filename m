Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7A3CBF8C
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 01:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhGPXDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 19:03:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:47797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhGPXD0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 19:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626476427;
        bh=kximOJCgoKt6ypuVeH5ewkByVTEBFxDeZc30cfKAaaw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cRb4+XkBAgieHJD8IFz73L74LdwYweTFI/AB858DH0HUIlQXVr8KCVaN88dtYvXh9
         IVFLIigSkgz1YtzJETf7VcZzqxiSNAdE0RGsdxqUx2lerPXRJnHzQzU02wIvU5X+c+
         gDiix+amgjwPZTYmMNxv2xWA3/FTTgo5OrSiZzz0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzk3-1lcJfP48Yz-00XObg; Sat, 17
 Jul 2021 01:00:27 +0200
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     Joshua Villwock <joshua@mailmag.net>
Cc:     linux-btrfs@vger.kernel.org
References: <40c94987-936f-e6ac-bcec-2051284e1821@gmx.com>
 <4C74CCF4-95CD-446D-A01B-F61AB61550A4@mailmag.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bf93658c-996b-9a60-7ca1-0587a34f259a@gmx.com>
Date:   Sat, 17 Jul 2021 07:00:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4C74CCF4-95CD-446D-A01B-F61AB61550A4@mailmag.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fW3c96Iy9JbgIAksY7bl8rKLggtGawTEE68zcyODMGbXk9ZjZs/
 KVIAbm+Osr65UguQHvKGOu0+Qry85iqP8cm4j9XUsQ8NclqxFTgPu0nfXbRds+Sl/DfpJ9K
 /pPBeRLx+SQ6GSZWnWPKJ9jrFuRtgDQz0qUr/JP2pUDyt7zh5mro/B6K8r0DadBBPToUdG5
 A4hHu1RphiJIon/a27dog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:czvpCq+qVRo=:1gihZvmK6flCJKL4X3X4Db
 B7uFQ90myMawXLnDcCedlaUXRt5/UdG/L4YQVcTorf88TMPq9xlWDuZ28nwIUcLmNQIwdtNnC
 u2Co8rragdRrxOcZPSftUO9+k/CXs4BlO2cIv/A8qzesfr6NCsh6hNGojjkYQQ6OB8ZMzVYLE
 bmwnAtxbLTGiVZL2Zx5mK2xdpaNtmoKe88GyJeCJX0ueHzRkmbFcpK/GcbFif2niXRHyq1zn0
 6GE8iWmoHzHeK5jeFuLATecsGQSpi6scEhPKhwhtvwtA4lcZ6h356s7n10AIF7bVWPU/GNfH8
 1FwlQ1XF1rMcXqVEHNnf3KeQKiK5efbZJGzlfwzWXRcoeWExMEkVQf26fC3gG40pzduN2wzZI
 8IaVld6Uh1tytvMygK4vR+lit80jMngxTv7iS44cg0kbTNND/beeuLMLZCdac23B5ZtKYSaSV
 /SyH/Wfk/Hm4rbF0Zqa5ZC4aUOa4J1KxLYY0AmPAw0Vx0AllgFoLcHQ+tm4shJ+PGO/S+e8le
 ToVp2ICC98grNTwPVZXCXB/KKErEwnSuEiT4dP+7pxN14zn9Q3QbVefFthRO1seFtPJNORdzt
 wjFhchdi6dFpukzXetudLS/7nLmhNQkw1RXzkl6FbQsjAAs5u3IxSSPLgxq3hkIKnxp26XEPC
 88ng+EJ7pUaucRtdF0BQOobFXl23ifvwMp3Oa6ZVLIRCGa/XkTy29m9831vWMNg8TFNFbLflA
 6q7s7Hgavuj0KxC7z8Uj3aQzbWGDFVrUQLELlrslBwdcDXBElcI29ZKZddxjgliXnEN1XmBf0
 v2RPCUou4ZWtsMzKBHd5Iy3sHgn+K4IcN49SWT1tA1GfqWoDcZJw8DrQ2Z6Q0d74gZPZmnaUm
 TUsGONmZjuAg5kpGgn1h4GxibY3zOLrh6hNRK6c5qISCB7kClyGqn9iJiCEpOj/70SBqlPbm2
 I3Ltge1VQIfdBlqO2vlbaukV6Rhq6YaSYjSpzyTgMrREH7m0FjSF+JAJMiMXCrpxjaeONzkhT
 B9L8Efra1osmqgDwa561ALe1zh7OAACLLBOOqCnx5WJbQ5+q5Ij12eXy/5VmrpFtv43a85RTs
 ZXtdpZHww/oliJrk2Od4VFEBvG9CLL+BdtgNmBbQE0p90P4nwgMl/DY0A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8A=E5=8D=884:33, Joshua Villwock wrote:
> Qu, thanks indeed for your responses!
>
>> On Jul 16, 2021, at 5:59 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> =EF=BB=BF
>>
>>> On 2021/7/16 =E4=B8=8B=E5=8D=888:42, DanglingPointer wrote:
>>> Hi Joshua, on that system where you tried to run the
>>> "--clear-space-cache v1", when you gave up, did you continue using
>>> "space_cache=3Dv2" on it?
>>>
>>>
>>> Here are some more questions to add for anyone who can help educate us=
:...
>>>
>>> Why would someone want to clear the space_cache v1?
>>
>> Because it takes up space and we won't be able to delete them.
>>
>>>
>>> What's the value of clearing the previous version space_cache before
>>> using the new version?
>>
>> AFAIK, just save some space and reduce the root tree size.
>>
>> The v1 cache exists as special files inside root tree (not accessible b=
y
>> end users).
>>
>> Their existence takes up space and fragments the file system (one file
>> is normally around 64K, and we have one such v1 file for each block
>> group, you can see how many small files it has now)
>>
>>>
>>> Why "clear" and not just "delete"?  Won't "deleting" the whole previou=
s
>>> space_cache files, blocks, whatever in the filesystem be faster then
>>> doing whatever "clear" does?
>>
>> Just bad naming, and properly from me.
>>
>> Indeed "delete" would be more proper here.
>>
>> And we're indeed deleting them in "btrfs check --clear-space-cache v1",
>> that's also why it's so slow.
>>
>> If you have 20T used space, then the it would be around 20,000 block
>> groups, meaning 20,000 64K files inside root tree, and deleting them on=
e
>> by one, and each deletion will cause a new transaction, no wonder it
>> will be slow to hell.
>
> If v1 space cache exists as special files in the root tree, could those =
be a contributing factor to the issue I was having in the past with mounts=
 taking too long and dropping to recovery mode?

That's another known thing.

It's block group items in extent tree.

I have proposed skinny block group tree to greatly reduce the time
needed to mount large fs.

But unfortunately it's not yet merged, and even merged, you will still
need to do a lengthy convert to the new format.

>
> I discovered running btrfs fi defrag on each of my subvolumes (for the s=
ubvolume tree/extent tree, not the files) every couple weeks has reduced t=
he mount time enough I don=E2=80=99t run into that issue on my massive FS =
anymore.

Yes, defrag reduce the size of extent tree, but not good enough,
especially when you have hundreds of thousands block groups, and every
time mount needs to find the block group items scattering around the
large extent tree, it will take quite some time.

>
> Could actually getting rid of those thousands of now-useless v1 entries =
help reduce mount times on such a massive FS, or would that be completely =
unrelated?

It can help, but not a root cause.

Thanks,
Qu

>
> Thanks,
> -Joshua
>
>>>
>>> Am I missing out on something by not attempting to clear the previous
>>> version space_cache before using the new v2 version?
>>
>> Except some wasted space, you're completely fine to skip the slow delet=
ion.
>>
>> This also means, I should enhance the deletion process to avoid too man=
y
>> transactions...
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>>> On 16/7/21 3:51 am, Joshua wrote:
>>>> Just as a point of data, I have a 96 TB array with RAID1 data, and
>>>> RAID1C3 metadata.
>>>>
>>>> I made the switch to space_cache=3Dv2 some time ago, and I remember i=
t
>>>> made a huge difference when I did so!
>>>> (It was RAID1 metadata at the time, as RAID1C3 was not available at
>>>> the time.)
>>>>
>>>>
>>>> However, I also tried a check with '--clear-space-cache v1' at the
>>>> time, and after waiting a literal whole day without it completing, I
>>>> gave up, canceled it, and put it back into production.  Is a
>>>> --clear-space-cache v1 operation expected to take so long on such a
>>>> large file system?
>>>>
>>>> Thanks!
>>>> --Joshua Villwock
>>>>
>>>>
>>>>
>>>> July 15, 2021 9:40 AM, "DanglingPointer"
>>>> <danglingpointerexception@gmail.com> wrote:
>>>>
>>>>> Hi Qu,
>>>>>
>>>>> Just updating here that setting the mount option "space_cache=3Dv2" =
and
>>>>> "noatime" completely SOLVED
>>>>> the performance problem!
>>>>> Basically like night and day!
>>>>>
>>>>> These are my full fstab mount options...
>>>>>
>>>>> btrfs defaults,autodefrag,space_cache=3Dv2,noatime 0 2
>>>>>
>>>>> Perhaps defaulting the space_cache=3Dv2 should be considered?  Why
>>>>> default to v1, what's the value of
>>>>> v1?
>>>>>
>>>>> So for conclusion, for large multi-terrabyte arrays (in my case
>>>>> RAID5s), setting space_cache=3Dv2 and
>>>>> noatime massively increases performance and eliminates the large lon=
g
>>>>> pauses in frequent intervals
>>>>> by "btrfs-transacti" blocking all IO.
>>>>>
>>>>> Thanks Qu for your help!
>>>>>
>>>>> On 14/7/21 5:45 pm, Qu Wenruo wrote:
>>>>>
>>>>>> On 2021/7/14 =E4=B8=8B=E5=8D=883:18, DanglingPointer wrote:
>>>>>>> a) "echo l > /proc/sysrq-trigger"
>>>>>>>
>>>>>>> The backup finished today already unfortunately and we are unlikel=
y to
>>>>>>> run it again until we get an outage to remount the array with the
>>>>>>> space_cache=3Dv2 and noatime mount options.
>>>>>>> Thanks for the command, we'll definitely use it if/when it happens
>>>>>>> again
>>>>>>> on the next large migration of data.
>>>>>> Just to avoid confusion, after that command, "dmesg" output is stil=
l
>>>>>> needed, as that's where sysrq put its output.
>>>>>>> b) "sudo btrfs qgroup show -prce" ........
>>>>>>>
>>>>>>> $ ERROR: can't list qgroups: quotas not enabled
>>>>>>>
>>>>>>> So looks like it isn't enabled.
>>>>>> One less thing to bother.
>>>>>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes
>>>>>>> (Duplicacy
>>>>>>> backup defaults)
>>>>>> Between 1~16MiB, thus tons of small files.
>>>>>>
>>>>>> Btrfs is not really good at handling tons of small files, as they
>>>>>> generate a lot of metadata.
>>>>>>
>>>>>> That may contribute to the hang.
>>>>>>
>>>>>>> What classifies as a transaction?
>>>>>> It's a little complex.
>>>>>>
>>>>>> Technically it's a check point where before the checkpoint, all you=
 see
>>>>>> is old data, after the checkpoint, all you see is new data.
>>>>>>
>>>>>> To end users, any data and metadata write will be included into one
>>>>>> transaction (with proper dependency handled).
>>>>>>
>>>>>> One way to finish (or commit) current transaction is to sync the fs=
,
>>>>>> using "sync" command (sync all filesystems).
>>>>>>
>>>>>>> Any/All writes done in a 30sec
>>>>>>> interval?
>>>>>> This the default commit interval. Almost all fses will try to commi=
t
>>>>>> its
>>>>>> data/metadata to disk after a configurable interval.
>>>>>>
>>>>>> The default one is 30s. That's also one way to commit current >
>>>>>> transaction.
>>>>>>
>>>>>>> If 100 unique files were written in 30secs, is that 1
>>>>>>> transaction or 100 transactions?
>>>>>> It depends. As things like syncfs() and subvolume/snapshot creation=
 may
>>>>>> try to commit transaction.
>>>>>>
>>>>>> But without those special operations, just writing 100 unique files
>>>>>> using buffered write, it would only start one transaction, and when=
 the
>>>>>> 30s interval get hit, the transaction will be committed to disk.
>>>>>>
>>>>>>> Millions of files of the size range
>>>>>>> above were backed up.
>>>>>> The amount of files may not force a transaction commit, if it doesn=
't
>>>>>> trigger enough memory pressure, or free space pressure.
>>>>>>
>>>>>> Anyway, the "echo l" sysrq would help us to locate what's taking so
>>>>>> long
>>>>>> time.
>>>>>>
>>>>>>> c) "Just mount with "space_cache=3Dv2""
>>>>>>>
>>>>>>> Ok so no need to "clear_cache" the v1 cache, right?
>>>>>> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>>>>>
>>>>>> Thus it doesn't help much.
>>>>>>
>>>>>> The only way to fully clear v1 cache is by using "btrfs check
>>>>>> --clear-space-cache v1" on a *unmounted* btrfs.
>>>>>>
>>>>>>> I wrote this in the fstab but hadn't remounted yet until I can get=
 an
>>>>>>> outage....
>>>>>> IMHO if you really want to test if v2 would help, you can just remo=
unt,
>>>>>> no need to wait for a break.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=3Dv2,noatime
>>>>>>> 0  2 >
>>>>>>> Thanks again for your help Qu!
>>>>>>>
>>>>>>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>>>>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>>>>>> We're currently considering switching to "space_cache=3Dv2" with no=
atime
>>>>>> mount options for my lab server-workstations running RAID5.
>>>>>>
>>>>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>>>>
>>>>>> * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>>>>> totalling 26TB.
>>>>>> * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>>>>> totalling 24TB.
>>>>>> * Both of the arrays are on individually luks encrypted disks with
>>>>>> btrfs on top of the luks.
>>>>>> * Both have "defaults,autodefrag" turned on in fstab.
>>>>>>
>>>>>> We're starting to see large pauses during constant backups of milli=
ons
>>>>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>>>>
>>>>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>>>>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>>>>>> consistently shows up as the blocking process/thread locking up
>>>>>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no
>>>>>>>>>> disk
>>>>>> or btrfs errors recorded.  scrub last finished yesterday successful=
ly.
>>>>>>
>>>>>> Please provide the "echo l > /proc/sysrq-trigger" output when such
>>>>>>>>> pause
>>>>>> happens.
>>>>>>
>>>>>> If you're using qgroup (may be enabled by things like snapper), it =
may
>>>>>> be the cause, as qgroup does its accounting when committing >>>
>>>>>> transaction.
>>>>>>
>>>>>> If one transaction is super large, it can cause such problem.
>>>>>>
>>>>>> You can test if qgroup is enabled by:
>>>>>>
>>>>>> # btrfs qgroup show -prce <mnt>
>>>>>>
>>>>>> After doing some research around the internet, we've come to the
>>>>>> consideration above as described.  Unfortunately the official
>>>>>> documentation isn't clear on the following.
>>>>>>
>>>>>> Official documentation URL -
>>>>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>>>>
>>>>>> 1. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2=
? It
>>>>>> talks about the reverse, from v2 to v1!
>>>>>>
>>>>>> Just mount with "space_cache=3Dv2".
>>>>>>
>>>>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>>>>> "btrfs" command will NOT work with the filesystem?
>>>>>>
>>>>>> Why would you think "btrfs" won't work on a btrfs?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>> So will our
>>>>>> "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>>>>>> the btrfs command comes from btrfs-progs which is currently >>>>
>>>>>> v5.4.1-2
>>>>>> amd64, is that correct?
>>>>>> 3. Any other ideas on how we can get rid of those annoying pauses w=
ith
>>>>>> large backups into the array?
>>>>>>
>>>>>> Thanks in advance!
>>>>>>
>>>>>> DP
