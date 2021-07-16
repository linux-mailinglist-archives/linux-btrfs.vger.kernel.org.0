Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F19B3CBDD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhGPUgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 16:36:35 -0400
Received: from mail.mailmag.net ([5.135.159.181]:54650 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhGPUgf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 16:36:35 -0400
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 885FCEC0377;
        Fri, 16 Jul 2021 12:33:37 -0800 (AKDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1626467618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOWNWLPzXH4nAFF0cOVN5ZyRDLg2TM51ZNXeQ0vpEbo=;
        b=cOvtlTUGML62mNSPXU7VawH3/DoUPdxEc1Ka/gMuXHORyx6u396+gszoQwZ3LfY/hEuOuo
        j5DrCUxQ9XbZWN8J8ZlIreLZlMnemtpmCPqDCypUjnY04P2TExVj9+wsWHP194SwWXf569
        dqEmRwV7aJK/PcJ/1P5rN5gNzHjeF5g=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joshua Villwock <joshua@mailmag.net>
Mime-Version: 1.0
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
Date:   Fri, 16 Jul 2021 13:33:24 -0700
Message-Id: <4C74CCF4-95CD-446D-A01B-F61AB61550A4@mailmag.net>
References: <40c94987-936f-e6ac-bcec-2051284e1821@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <40c94987-936f-e6ac-bcec-2051284e1821@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1626467618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOWNWLPzXH4nAFF0cOVN5ZyRDLg2TM51ZNXeQ0vpEbo=;
        b=Y0NjBc6dT8jwYMm0g/sNaG5mP20tUFta+gDySnZu3geXcClnr3NRfLMOCEGKZELqMrR707
        AIh+K797Ul3LxmVglVfNA9FMP/bjioi1xMNUgJvL9eHHVRDFte3Iex7nZouDfKtqcX1bka
        VXOYXJZcThLczvJy9Oap7E37rv1gVA0=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1626467618; a=rsa-sha256; cv=none;
        b=M2IOVkDU3TG87kMoqonn0M3DGDSJM5NP+4SbO1R3VrjaqK4np+tr6ehtpflQhPNJtDq56C
        lxitpaIOFrtpRhq70yrVGlJsHbBAjIWF6TXc1/jgZAIjMyo57QmjdVptSXi/Ht1LoWAWRy
        ppzTg3Ej076oZOJI7AfwZ5VsXdaDX84=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu, thanks indeed for your responses!

> On Jul 16, 2021, at 5:59 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2021/7/16 =E4=B8=8B=E5=8D=888:42, DanglingPointer wrote:
>> Hi Joshua, on that system where you tried to run the
>> "--clear-space-cache v1", when you gave up, did you continue using
>> "space_cache=3Dv2" on it?
>>=20
>>=20
>> Here are some more questions to add for anyone who can help educate us:..=
.
>>=20
>> Why would someone want to clear the space_cache v1?
>=20
> Because it takes up space and we won't be able to delete them.
>=20
>>=20
>> What's the value of clearing the previous version space_cache before
>> using the new version?
>=20
> AFAIK, just save some space and reduce the root tree size.
>=20
> The v1 cache exists as special files inside root tree (not accessible by
> end users).
>=20
> Their existence takes up space and fragments the file system (one file
> is normally around 64K, and we have one such v1 file for each block
> group, you can see how many small files it has now)
>=20
>>=20
>> Why "clear" and not just "delete"?  Won't "deleting" the whole previous
>> space_cache files, blocks, whatever in the filesystem be faster then
>> doing whatever "clear" does?
>=20
> Just bad naming, and properly from me.
>=20
> Indeed "delete" would be more proper here.
>=20
> And we're indeed deleting them in "btrfs check --clear-space-cache v1",
> that's also why it's so slow.
>=20
> If you have 20T used space, then the it would be around 20,000 block
> groups, meaning 20,000 64K files inside root tree, and deleting them one
> by one, and each deletion will cause a new transaction, no wonder it
> will be slow to hell.

If v1 space cache exists as special files in the root tree, could those be a=
 contributing factor to the issue I was having in the past with mounts takin=
g too long and dropping to recovery mode?

I discovered running btrfs fi defrag on each of my subvolumes (for the subvo=
lume tree/extent tree, not the files) every couple weeks has reduced the mou=
nt time enough I don=E2=80=99t run into that issue on my massive FS anymore.=


Could actually getting rid of those thousands of now-useless v1 entries help=
 reduce mount times on such a massive FS, or would that be completely unrela=
ted?

Thanks,
-Joshua

>>=20
>> Am I missing out on something by not attempting to clear the previous
>> version space_cache before using the new v2 version?
>=20
> Except some wasted space, you're completely fine to skip the slow deletion=
.
>=20
> This also means, I should enhance the deletion process to avoid too many
> transactions...
>=20
> Thanks,
> Qu
>=20
>>=20
>>=20
>>> On 16/7/21 3:51 am, Joshua wrote:
>>> Just as a point of data, I have a 96 TB array with RAID1 data, and
>>> RAID1C3 metadata.
>>>=20
>>> I made the switch to space_cache=3Dv2 some time ago, and I remember it
>>> made a huge difference when I did so!
>>> (It was RAID1 metadata at the time, as RAID1C3 was not available at
>>> the time.)
>>>=20
>>>=20
>>> However, I also tried a check with '--clear-space-cache v1' at the
>>> time, and after waiting a literal whole day without it completing, I
>>> gave up, canceled it, and put it back into production.  Is a
>>> --clear-space-cache v1 operation expected to take so long on such a
>>> large file system?
>>>=20
>>> Thanks!
>>> --Joshua Villwock
>>>=20
>>>=20
>>>=20
>>> July 15, 2021 9:40 AM, "DanglingPointer"
>>> <danglingpointerexception@gmail.com> wrote:
>>>=20
>>>> Hi Qu,
>>>>=20
>>>> Just updating here that setting the mount option "space_cache=3Dv2" and=

>>>> "noatime" completely SOLVED
>>>> the performance problem!
>>>> Basically like night and day!
>>>>=20
>>>> These are my full fstab mount options...
>>>>=20
>>>> btrfs defaults,autodefrag,space_cache=3Dv2,noatime 0 2
>>>>=20
>>>> Perhaps defaulting the space_cache=3Dv2 should be considered?  Why
>>>> default to v1, what's the value of
>>>> v1?
>>>>=20
>>>> So for conclusion, for large multi-terrabyte arrays (in my case
>>>> RAID5s), setting space_cache=3Dv2 and
>>>> noatime massively increases performance and eliminates the large long
>>>> pauses in frequent intervals
>>>> by "btrfs-transacti" blocking all IO.
>>>>=20
>>>> Thanks Qu for your help!
>>>>=20
>>>> On 14/7/21 5:45 pm, Qu Wenruo wrote:
>>>>=20
>>>>> On 2021/7/14 =E4=B8=8B=E5=8D=883:18, DanglingPointer wrote:
>>>>>> a) "echo l > /proc/sysrq-trigger"
>>>>>>=20
>>>>>> The backup finished today already unfortunately and we are unlikely t=
o
>>>>>> run it again until we get an outage to remount the array with the
>>>>>> space_cache=3Dv2 and noatime mount options.
>>>>>> Thanks for the command, we'll definitely use it if/when it happens
>>>>>> again
>>>>>> on the next large migration of data.
>>>>> Just to avoid confusion, after that command, "dmesg" output is still
>>>>> needed, as that's where sysrq put its output.
>>>>>> b) "sudo btrfs qgroup show -prce" ........
>>>>>>=20
>>>>>> $ ERROR: can't list qgroups: quotas not enabled
>>>>>>=20
>>>>>> So looks like it isn't enabled.
>>>>> One less thing to bother.
>>>>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes
>>>>>> (Duplicacy
>>>>>> backup defaults)
>>>>> Between 1~16MiB, thus tons of small files.
>>>>>=20
>>>>> Btrfs is not really good at handling tons of small files, as they
>>>>> generate a lot of metadata.
>>>>>=20
>>>>> That may contribute to the hang.
>>>>>=20
>>>>>> What classifies as a transaction?
>>>>> It's a little complex.
>>>>>=20
>>>>> Technically it's a check point where before the checkpoint, all you se=
e
>>>>> is old data, after the checkpoint, all you see is new data.
>>>>>=20
>>>>> To end users, any data and metadata write will be included into one
>>>>> transaction (with proper dependency handled).
>>>>>=20
>>>>> One way to finish (or commit) current transaction is to sync the fs,
>>>>> using "sync" command (sync all filesystems).
>>>>>=20
>>>>>> Any/All writes done in a 30sec
>>>>>> interval?
>>>>> This the default commit interval. Almost all fses will try to commit
>>>>> its
>>>>> data/metadata to disk after a configurable interval.
>>>>>=20
>>>>> The default one is 30s. That's also one way to commit current >
>>>>> transaction.
>>>>>=20
>>>>>> If 100 unique files were written in 30secs, is that 1
>>>>>> transaction or 100 transactions?
>>>>> It depends. As things like syncfs() and subvolume/snapshot creation ma=
y
>>>>> try to commit transaction.
>>>>>=20
>>>>> But without those special operations, just writing 100 unique files
>>>>> using buffered write, it would only start one transaction, and when th=
e
>>>>> 30s interval get hit, the transaction will be committed to disk.
>>>>>=20
>>>>>> Millions of files of the size range
>>>>>> above were backed up.
>>>>> The amount of files may not force a transaction commit, if it doesn't
>>>>> trigger enough memory pressure, or free space pressure.
>>>>>=20
>>>>> Anyway, the "echo l" sysrq would help us to locate what's taking so
>>>>> long
>>>>> time.
>>>>>=20
>>>>>> c) "Just mount with "space_cache=3Dv2""
>>>>>>=20
>>>>>> Ok so no need to "clear_cache" the v1 cache, right?
>>>>> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>>>>=20
>>>>> Thus it doesn't help much.
>>>>>=20
>>>>> The only way to fully clear v1 cache is by using "btrfs check
>>>>> --clear-space-cache v1" on a *unmounted* btrfs.
>>>>>=20
>>>>>> I wrote this in the fstab but hadn't remounted yet until I can get an=

>>>>>> outage....
>>>>> IMHO if you really want to test if v2 would help, you can just remount=
,
>>>>> no need to wait for a break.
>>>>>=20
>>>>> Thanks,
>>>>> Qu
>>>>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=3Dv2,noatime
>>>>>> 0  2 >
>>>>>> Thanks again for your help Qu!
>>>>>>=20
>>>>>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>>>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>>>>> We're currently considering switching to "space_cache=3Dv2" with noati=
me
>>>>> mount options for my lab server-workstations running RAID5.
>>>>>=20
>>>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>>>=20
>>>>> * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>>>> totalling 26TB.
>>>>> * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>>>> totalling 24TB.
>>>>> * Both of the arrays are on individually luks encrypted disks with
>>>>> btrfs on top of the luks.
>>>>> * Both have "defaults,autodefrag" turned on in fstab.
>>>>>=20
>>>>> We're starting to see large pauses during constant backups of millions=

>>>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>>>=20
>>>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>>>> ~30secs of the end of the last pause.  "btrfs-transacti" process
>>>>> consistently shows up as the blocking process/thread locking up
>>>>> filesystem IO.  IO gets into the RAID5 array via nfsd. There are no
>>>>> >>>> disk
>>>>> or btrfs errors recorded.  scrub last finished yesterday successfully.=

>>>>>=20
>>>>> Please provide the "echo l > /proc/sysrq-trigger" output when such
>>>>> >>> pause
>>>>> happens.
>>>>>=20
>>>>> If you're using qgroup (may be enabled by things like snapper), it may=

>>>>> be the cause, as qgroup does its accounting when committing >>>
>>>>> transaction.
>>>>>=20
>>>>> If one transaction is super large, it can cause such problem.
>>>>>=20
>>>>> You can test if qgroup is enabled by:
>>>>>=20
>>>>> # btrfs qgroup show -prce <mnt>
>>>>>=20
>>>>> After doing some research around the internet, we've come to the
>>>>> consideration above as described.  Unfortunately the official
>>>>> documentation isn't clear on the following.
>>>>>=20
>>>>> Official documentation URL -
>>>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>>>=20
>>>>> 1. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2? I=
t
>>>>> talks about the reverse, from v2 to v1!
>>>>>=20
>>>>> Just mount with "space_cache=3Dv2".
>>>>>=20
>>>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>>>> "btrfs" command will NOT work with the filesystem?
>>>>>=20
>>>>> Why would you think "btrfs" won't work on a btrfs?
>>>>>=20
>>>>> Thanks,
>>>>> Qu
>>>>>=20
>>>>> So will our
>>>>> "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>>>>> the btrfs command comes from btrfs-progs which is currently >>>>
>>>>> v5.4.1-2
>>>>> amd64, is that correct?
>>>>> 3. Any other ideas on how we can get rid of those annoying pauses with=

>>>>> large backups into the array?
>>>>>=20
>>>>> Thanks in advance!
>>>>>=20
>>>>> DP
