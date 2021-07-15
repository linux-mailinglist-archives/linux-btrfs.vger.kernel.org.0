Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158B3CAF03
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhGOWQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 18:16:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:47965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhGOWQK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626387194;
        bh=wlbOYzRjipGpwsT+yPdyeEjSTm8SE7z97qfExJC4zDc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Fm/us3pdTb6PJXIiQctuLct6kBcXjI5bzW7SeN9aA2FnkYecpSqNEAk+F/djSCLzX
         AUCXz7v8L56p9hO8Wa7cQEr+/6vLmzZLKl7tVw24z8W3Ka6FgEPN9n4TtWcIUQhkTp
         uv1Wm/K9zkMxCRK4jPkm68FKMQH26i0xvQaniSEw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9yS-1lnAgV3DsI-00IGbD; Fri, 16
 Jul 2021 00:13:14 +0200
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
 <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
 <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <94f7f31a-21d6-5cc4-fd20-4641f31aa682@gmx.com>
Date:   Fri, 16 Jul 2021 06:13:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cANOrLXaex723MrYvz34FQYUx4ub3MSZEN47tIIswo3wOXbYDgv
 pZ1I0H8jtxxohgOaCmAV2HbsXiBNMGjX3ZhMNxhoV0vIJ/dgCYU8Xcpqqc8LvzL6Apcfq5d
 pheW77AEWrRBdezvIoD2bfDV/Sa/xPiCMWpRJs10KnlNt70XrsYjKtI46f+FH5e21S+Xm0Z
 XNSZbVcfRRnz6oSIYqRMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c1KpsA5GAwk=:MJfm90+WaXJU+ULim/R9Ft
 ZSjrjw83oaGfvjUId+gPxi7EXpZzkEALYF0ji8gYwFD9A+FVZY7rzB7/XpLp6D+RCe5B/Awuv
 MWkK9XbemaXDhal+QVg5dnr248sUgE6tkA78yf/V3tSVvUEfc5jtuM9HbnkgVLEHZYhR+S996
 UAYq7ghfWiJ4W2mGWnfkVsm5PxMNIYBDjvXYXrmRzrbIaR0RE/4DpqRMhNddU9QdKwScUlxsC
 gx4qdQjNTZiIWDYmYnfv+BLKZlb0U0ClxxzCUNHELQuMHzlAghPmLenijfTYbtgKD9zJjDcsE
 cyEaIOw+EJcdbQSk4MhRYQD7urKHNuxy+odHHa3sfB1wcLVI906EgKAgyY/yWdQ0CGeJ7JKD/
 StzYoas8vqKXzK9TyNJZTQnVrLchyBY+kiaRtW+gBJmiJCsnSIMOyxtSApabYgvuzv8ZruAtp
 jmpIhjngleCVkwGNazrja9h8naxsKcrf7D9gvLvaQvV1VxanntdPO0fuH5+RR/RC5qlnI7NIv
 4fuo4erUuvphdI/5GLSqK8hId9PA1UGUaIQLUgEgLOjvD2gWXFYCah/pXjYG6rj/hOwdPAQC4
 CKFSDUTz9pxOPO4vNCD4enEp3v3QJQinxmoYPLLC2RzmbY74p8eQC0jWMmixWxJrVX7wcMnDU
 APTmUT1KKMhVA1zKUCOBU6yJOJlcElw0729OB90ctUEj3fjldIiCMCLATNW0yKGtsA3yUWE8q
 dMFDy4TLAZfTQtDQ46UIpFvktOxLCiiBIKamYueGUduSmfcLhElwGQ7s6bL5pBxAeQzBFaCVe
 6zBajVRps9LDPHMBhMuQbzAIbY0HoIgBDpFJEF13LzXesZNzvWoVAPkI9vHCB+XylcbxGxegN
 MNIST6OLY84ABU2cLiioDkkCAG8nwt5OnKuuimymcA+d4ccoyQuXt1iiSvwRYwMGgggkypXr3
 SM/4wcxFO4Nu/T4jJwOrq1pWRqPxWDjKMemxODH2bfqRpBKoEXQJDNXJ2mntWpVqXE+sVOWt1
 xia8+g8elpJbfllynt6sUKw73vxGiZvI1jOR6Y5Mmt47BDRhIl2oPfOJns5XePukV1pShQIRB
 Uh4EPPmCvlHSzTiUMD11iFOejw0fAGWtqQWiNrz+tyMJiCFaXHdrGIA7A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8A=E5=8D=8812:40, DanglingPointer wrote:
> Hi Qu,
>
> Just updating here that setting the mount option "space_cache=3Dv2" and
> "noatime" completely SOLVED the performance problem!
> Basically like night and day!
>
>
> These are my full fstab mount options...
>
> btrfs defaults,autodefrag,space_cache=3Dv2,noatime 0 2
>
>
> Perhaps defaulting the space_cache=3Dv2 should be considered?

We're already considering that.

>=C2=A0 Why default
> to v1, what's the value of v1?

One of the problem in the past is the lack of write ability in btrfs-progs=
.

Now we're testing default it in mkfs.btrfs.

Thanks,
Qu

>
>
> So for conclusion, for large multi-terrabyte arrays (in my case RAID5s),
> setting space_cache=3Dv2 and noatime massively increases performance and
> eliminates the large long pauses in frequent intervals by
> "btrfs-transacti" blocking all IO.
>
> Thanks Qu for your help!
>
>
>
> On 14/7/21 5:45 pm, Qu Wenruo wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=883:18, DanglingPointer wrote:
>>> a) "echo l > /proc/sysrq-trigger"
>>>
>>> The backup finished today already unfortunately and we are unlikely to
>>> run it again until we get an outage to remount the array with the
>>> space_cache=3Dv2 and noatime mount options.
>>> Thanks for the command, we'll definitely use it if/when it happens aga=
in
>>> on the next large migration of data.
>>
>> Just to avoid confusion, after that command, "dmesg" output is still
>> needed, as that's where sysrq put its output.
>>>
>>>
>>> b) "sudo btrfs qgroup show -prce" ........
>>>
>>> $ ERROR: can't list qgroups: quotas not enabled
>>>
>>> So looks like it isn't enabled.
>>
>> One less thing to bother.
>>>
>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes (Duplicac=
y
>>> backup defaults)
>>
>> Between 1~16MiB, thus tons of small files.
>>
>> Btrfs is not really good at handling tons of small files, as they
>> generate a lot of metadata.
>>
>> That may contribute to the hang.
>>
>>>
>>> What classifies as a transaction?
>>
>> It's a little complex.
>>
>> Technically it's a check point where before the checkpoint, all you see
>> is old data, after the checkpoint, all you see is new data.
>>
>> To end users, any data and metadata write will be included into one
>> transaction (with proper dependency handled).
>>
>> One way to finish (or commit) current transaction is to sync the fs,
>> using "sync" command (sync all filesystems).
>>
>>> Any/All writes done in a 30sec
>>> interval?
>>
>> This the default commit interval. Almost all fses will try to commit it=
s
>> data/metadata to disk after a configurable interval.
>>
>> The default one is 30s. That's also one way to commit current
>> transaction.
>>
>>> =C2=A0 If 100 unique files were written in 30secs, is that 1
>>> transaction or 100 transactions?
>>
>> It depends. As things like syncfs() and subvolume/snapshot creation may
>> try to commit transaction.
>>
>> But without those special operations, just writing 100 unique files
>> using buffered write, it would only start one transaction, and when the
>> 30s interval get hit, the transaction will be committed to disk.
>>
>>> =C2=A0 Millions of files of the size range
>>> above were backed up.
>>
>> The amount of files may not force a transaction commit, if it doesn't
>> trigger enough memory pressure, or free space pressure.
>>
>> Anyway, the "echo l" sysrq would help us to locate what's taking so lon=
g
>> time.
>>
>>>
>>>
>>> c) "Just mount with "space_cache=3Dv2""
>>>
>>> Ok so no need to "clear_cache" the v1 cache, right?
>>
>> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>
>> Thus it doesn't help much.
>>
>> The only way to fully clear v1 cache is by using "btrfs check
>> --clear-space-cache v1" on a *unmounted* btrfs.
>>
>>> I wrote this in the fstab but hadn't remounted yet until I can get an
>>> outage....
>>
>> IMHO if you really want to test if v2 would help, you can just remount,
>> no need to wait for a break.
>>
>> Thanks,
>> Qu
>>>
>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=3Dv2,noatime=C2=
=A0 0=C2=A0 2 >
>>> Thanks again for your help Qu!
>>>
>>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>>>>> We're currently considering switching to "space_cache=3Dv2" with noa=
time
>>>>> mount options for my lab server-workstations running RAID5.
>>>>
>>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>>
>>>>>
>>>>> =C2=A0=C2=A0* One has 13TB of data/metadata in a bunch of 6TB and 2T=
B disks
>>>>> =C2=A0=C2=A0=C2=A0 totalling 26TB.
>>>>> =C2=A0=C2=A0* Another has about 12TB data/metadata in uniformly size=
d 6TB disks
>>>>> =C2=A0=C2=A0=C2=A0 totalling 24TB.
>>>>> =C2=A0=C2=A0* Both of the arrays are on individually luks encrypted =
disks with
>>>>> =C2=A0=C2=A0=C2=A0 btrfs on top of the luks.
>>>>> =C2=A0=C2=A0* Both have "defaults,autodefrag" turned on in fstab.
>>>>>
>>>>> We're starting to see large pauses during constant backups of millio=
ns
>>>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>>>
>>>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>>>> ~30secs of the end of the last pause.=C2=A0 "btrfs-transacti" proces=
s
>>>>> consistently shows up as the blocking process/thread locking up
>>>>> filesystem IO.=C2=A0 IO gets into the RAID5 array via nfsd. There ar=
e no
>>>>> disk
>>>>> or btrfs errors recorded.=C2=A0 scrub last finished yesterday succes=
sfully.
>>>>
>>>> Please provide the "echo l > /proc/sysrq-trigger" output when such
>>>> pause
>>>> happens.
>>>>
>>>> If you're using qgroup (may be enabled by things like snapper), it ma=
y
>>>> be the cause, as qgroup does its accounting when committing
>>>> transaction.
>>>>
>>>> If one transaction is super large, it can cause such problem.
>>>>
>>>> You can test if qgroup is enabled by:
>>>>
>>>> # btrfs qgroup show -prce <mnt>
>>>>
>>>>>
>>>>> After doing some research around the internet, we've come to the
>>>>> consideration above as described.=C2=A0 Unfortunately the official
>>>>> documentation isn't clear on the following.
>>>>>
>>>>> Official documentation URL -
>>>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>>>
>>>>> 1. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2?=
 It
>>>>> =C2=A0=C2=A0=C2=A0 talks about the reverse, from v2 to v1!
>>>>
>>>> Just mount with "space_cache=3Dv2".
>>>>
>>>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>>>> =C2=A0=C2=A0=C2=A0 "btrfs" command will NOT work with the filesystem=
?
>>>>
>>>> Why would you think "btrfs" won't work on a btrfs?
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> =C2=A0 So will our
>>>>> =C2=A0=C2=A0=C2=A0 "btrfs scrub start /mount/point/..." cron jobs FA=
IL? I'm guessing
>>>>> =C2=A0=C2=A0=C2=A0 the btrfs command comes from btrfs-progs which is=
 currently
>>>>> v5.4.1-2
>>>>> =C2=A0=C2=A0=C2=A0 amd64, is that correct?
>>>>> 3. Any other ideas on how we can get rid of those annoying pauses wi=
th
>>>>> =C2=A0=C2=A0=C2=A0 large backups into the array?
>>>>>
>>>>> Thanks in advance!
>>>>>
>>>>> DP
>>>>>
