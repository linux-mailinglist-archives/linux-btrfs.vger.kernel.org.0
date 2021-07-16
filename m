Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9FE3CB7A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhGPNC1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 09:02:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:52253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239524AbhGPNC1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 09:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626440369;
        bh=Yy75jLkddU07R7EnRVbAIcowG8+eCUfEIyO3sUnpoig=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=bhJFIy+h2S7HQsYZGMk8aGTBND/rDfsCGOfYGsQXrdQrOrXIaQO1xuNrj1LA624nU
         yK4WMn6yo8g7TdW3BxHFXp4Kb83EpxtZJiTB4rR8tpcBI6FcPvvt+2zO551rbgNYP2
         0R2lTyzw6pfyX07aOidUdCm+5ndkjTJcFDKW9OWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSt8Q-1lhwUw1q6o-00UIsQ; Fri, 16
 Jul 2021 14:59:29 +0200
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        Joshua <joshua@mailmag.net>, linux-btrfs@vger.kernel.org
References: <a4ef513e-c7a4-99e0-c957-206a3763d9d1@gmail.com>
 <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
 <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
 <0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net>
 <1e09cc8e-7100-a084-9542-e2f734cb33fa@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
Message-ID: <40c94987-936f-e6ac-bcec-2051284e1821@gmx.com>
Date:   Fri, 16 Jul 2021 20:59:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1e09cc8e-7100-a084-9542-e2f734cb33fa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kWtKf6daPrnoYVsrQWRay2uNNyBzm24ooCK3YyPirHq2MeinfFD
 rj0yrKXyu8em50UVr0/BeJJAzeu9XpV+CQ6dUnrAwbNn8cX/AtnsBPoImoeLwBl91mb1Bbe
 uJXY1r77oPR2JHy5HEnX2WcCPG0ThGbK4VTRhf3YnbBNV5LwTtuV+jAb36YG0Qz7jAx10oy
 W3+HrLH5uNmp1Xg9fU8nQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JtWqh+zcpiI=:ZCB3lFtUR6TYNIf1DOEZDO
 YbjnwyJXf/yb2IH9Abz2Pecn4xqGc/l8WceUw02Q8HscIQ8dnoP88N3m+fEYSalvM+ytn0hid
 V/m1kws9V4WJkPmWxKqi2IBaCVTrNLyjOqKj5x31nBGzc7si2oDEo9dB3pizY5oc6z+NZpmt5
 jQZR98G9Y2LfDgmBl3bz3uvQsKNz1ruq2JDWD32t3rLHuu+6y4axMYH3WVFUxuaGTsWaL6Gra
 nj9hMgY4LY9QOSc5EcHqxcLPwrpHT3nn43wTFM1MpDaACz4N294YfiKhH6dJQuMos2jG9JQdx
 x7EjHNz5e5in4Ggot+xdleUHte/xZWKqUKPtuL2MY7urgpkOAtYF5ASEN0vv6CtU0TK5kvIOO
 w9kvX0666jS49ESG3ACZx3ms7pu5MofHBVfXmYzPxZcdND4r+HnuDDIdf3112RNJxVD8tjW4j
 HIq0fm0q1rD9cGWHDrwiZg2SUwJ9a2jWKuIA1a4fBTU3BDbhg8sUZCNEtKM7BvtnwQGNoGJXk
 Kt8Ld6YA38diuQX+sP1cMRHVC3zhSYqIaYCmCfVngGwGtJb9bLeKsrTLm96/7c8AWdZmK1ItN
 ZWUTsZI2gn1A2xo4RD9z+TQGCGZzsRUskoc+jrIgeoC2CWQUfQlQXIHoISfjZYhhvLfog3Vjd
 xyzjPzu2DGz0AFohnkGCZ4v1hJM1dDIEKH87RqFsTzSNfoOR3cS90lIawW8gEq3nybI566Ozw
 Avx2nbj6mcKOUbV24xAdMcxJEq21cRwK4wg1OX6SUlzhB3DvXC9w7fMzFebrHesoVdt+KznPG
 HN/kIWTcQIKslyhLP7UBqr4uue4aRkZVi5XJna5fbYgKLEo2XslqqGoQ0gBqBR+6ygbhjpK5k
 1s+hNElI1bpZRI1I+Uo9GEAbwZeFTMdiQZskR7ueNvRqfi3+/4BekQ46TavQbOb9Su5KkH/v+
 9rvhIPtuApB0XIgGY7etZ9dgGRD/MLYCIx2VC74XD+knkn2HQ9u1aUvvux5gelUoUUS6bp99e
 xTHF/g4oEBZXT9iiuYDxab+MWtQHWY19Ir06TwOZDfHd0vOYYfdGRfuthlgnAjrEoybm8MCYG
 +8ZyWMMT/+L5k+rK8s/cH/HAVYX+iTAsDuTZq/YvM8ryIbOIRAKX02oCg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8B=E5=8D=888:42, DanglingPointer wrote:
> Hi Joshua, on that system where you tried to run the
> "--clear-space-cache v1", when you gave up, did you continue using
> "space_cache=3Dv2" on it?
>
>
> Here are some more questions to add for anyone who can help educate us:.=
..
>
> Why would someone want to clear the space_cache v1?

Because it takes up space and we won't be able to delete them.

>
> What's the value of clearing the previous version space_cache before
> using the new version?

AFAIK, just save some space and reduce the root tree size.

The v1 cache exists as special files inside root tree (not accessible by
end users).

Their existence takes up space and fragments the file system (one file
is normally around 64K, and we have one such v1 file for each block
group, you can see how many small files it has now)

>
> Why "clear" and not just "delete"?=C2=A0 Won't "deleting" the whole prev=
ious
> space_cache files, blocks, whatever in the filesystem be faster then
> doing whatever "clear" does?

Just bad naming, and properly from me.

Indeed "delete" would be more proper here.

And we're indeed deleting them in "btrfs check --clear-space-cache v1",
that's also why it's so slow.

If you have 20T used space, then the it would be around 20,000 block
groups, meaning 20,000 64K files inside root tree, and deleting them one
by one, and each deletion will cause a new transaction, no wonder it
will be slow to hell.

>
> Am I missing out on something by not attempting to clear the previous
> version space_cache before using the new v2 version?

Except some wasted space, you're completely fine to skip the slow deletion=
.

This also means, I should enhance the deletion process to avoid too many
transactions...

Thanks,
Qu

>
>
> On 16/7/21 3:51 am, Joshua wrote:
>> Just as a point of data, I have a 96 TB array with RAID1 data, and
>> RAID1C3 metadata.
>>
>> I made the switch to space_cache=3Dv2 some time ago, and I remember it
>> made a huge difference when I did so!
>> (It was RAID1 metadata at the time, as RAID1C3 was not available at
>> the time.)
>>
>>
>> However, I also tried a check with '--clear-space-cache v1' at the
>> time, and after waiting a literal whole day without it completing, I
>> gave up, canceled it, and put it back into production.=C2=A0 Is a
>> --clear-space-cache v1 operation expected to take so long on such a
>> large file system?
>>
>> Thanks!
>> --Joshua Villwock
>>
>>
>>
>> July 15, 2021 9:40 AM, "DanglingPointer"
>> <danglingpointerexception@gmail.com> wrote:
>>
>>> Hi Qu,
>>>
>>> Just updating here that setting the mount option "space_cache=3Dv2" an=
d
>>> "noatime" completely SOLVED
>>> the performance problem!
>>> Basically like night and day!
>>>
>>> These are my full fstab mount options...
>>>
>>> btrfs defaults,autodefrag,space_cache=3Dv2,noatime 0 2
>>>
>>> Perhaps defaulting the space_cache=3Dv2 should be considered?=C2=A0 Wh=
y
>>> default to v1, what's the value of
>>> v1?
>>>
>>> So for conclusion, for large multi-terrabyte arrays (in my case
>>> RAID5s), setting space_cache=3Dv2 and
>>> noatime massively increases performance and eliminates the large long
>>> pauses in frequent intervals
>>> by "btrfs-transacti" blocking all IO.
>>>
>>> Thanks Qu for your help!
>>>
>>> On 14/7/21 5:45 pm, Qu Wenruo wrote:
>>>
>>>> On 2021/7/14 =E4=B8=8B=E5=8D=883:18, DanglingPointer wrote:
>>>>> a) "echo l > /proc/sysrq-trigger"
>>>>>
>>>>> The backup finished today already unfortunately and we are unlikely =
to
>>>>> run it again until we get an outage to remount the array with the
>>>>> space_cache=3Dv2 and noatime mount options.
>>>>> Thanks for the command, we'll definitely use it if/when it happens
>>>>> again
>>>>> on the next large migration of data.
>>>> Just to avoid confusion, after that command, "dmesg" output is still
>>>> needed, as that's where sysrq put its output.
>>>>> b) "sudo btrfs qgroup show -prce" ........
>>>>>
>>>>> $ ERROR: can't list qgroups: quotas not enabled
>>>>>
>>>>> So looks like it isn't enabled.
>>>> One less thing to bother.
>>>>> File sizes are between: 1,048,576 bytes and 16,777,216 bytes
>>>>> (Duplicacy
>>>>> backup defaults)
>>>> Between 1~16MiB, thus tons of small files.
>>>>
>>>> Btrfs is not really good at handling tons of small files, as they
>>>> generate a lot of metadata.
>>>>
>>>> That may contribute to the hang.
>>>>
>>>>> What classifies as a transaction?
>>>> It's a little complex.
>>>>
>>>> Technically it's a check point where before the checkpoint, all you s=
ee
>>>> is old data, after the checkpoint, all you see is new data.
>>>>
>>>> To end users, any data and metadata write will be included into one
>>>> transaction (with proper dependency handled).
>>>>
>>>> One way to finish (or commit) current transaction is to sync the fs,
>>>> using "sync" command (sync all filesystems).
>>>>
>>>>> Any/All writes done in a 30sec
>>>>> interval?
>>>> This the default commit interval. Almost all fses will try to commit
>>>> its
>>>> data/metadata to disk after a configurable interval.
>>>>
>>>> The default one is 30s. That's also one way to commit current >
>>>> transaction.
>>>>
>>>>> If 100 unique files were written in 30secs, is that 1
>>>>> transaction or 100 transactions?
>>>> It depends. As things like syncfs() and subvolume/snapshot creation m=
ay
>>>> try to commit transaction.
>>>>
>>>> But without those special operations, just writing 100 unique files
>>>> using buffered write, it would only start one transaction, and when t=
he
>>>> 30s interval get hit, the transaction will be committed to disk.
>>>>
>>>>> Millions of files of the size range
>>>>> above were backed up.
>>>> The amount of files may not force a transaction commit, if it doesn't
>>>> trigger enough memory pressure, or free space pressure.
>>>>
>>>> Anyway, the "echo l" sysrq would help us to locate what's taking so
>>>> long
>>>> time.
>>>>
>>>>> c) "Just mount with "space_cache=3Dv2""
>>>>>
>>>>> Ok so no need to "clear_cache" the v1 cache, right?
>>>> Yes, and "clear_cache" won't really remove all the v1 cache anyway.
>>>>
>>>> Thus it doesn't help much.
>>>>
>>>> The only way to fully clear v1 cache is by using "btrfs check
>>>> --clear-space-cache v1" on a *unmounted* btrfs.
>>>>
>>>>> I wrote this in the fstab but hadn't remounted yet until I can get a=
n
>>>>> outage....
>>>> IMHO if you really want to test if v2 would help, you can just remoun=
t,
>>>> no need to wait for a break.
>>>>
>>>> Thanks,
>>>> Qu
>>>>> ..."btrfs defaults,autodefrag,clear_cache,space_cache=3Dv2,noatime
>>>>> 0=C2=A0 2 >
>>>>> Thanks again for your help Qu!
>>>>>
>>>>> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>>>> We're currently considering switching to "space_cache=3Dv2" with noat=
ime
>>>> mount options for my lab server-workstations running RAID5.
>>>>
>>>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>>>
>>>> * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
>>>> totalling 26TB.
>>>> * Another has about 12TB data/metadata in uniformly sized 6TB disks
>>>> totalling 24TB.
>>>> * Both of the arrays are on individually luks encrypted disks with
>>>> btrfs on top of the luks.
>>>> * Both have "defaults,autodefrag" turned on in fstab.
>>>>
>>>> We're starting to see large pauses during constant backups of million=
s
>>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>>
>>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>>> ~30secs of the end of the last pause.=C2=A0 "btrfs-transacti" process
>>>> consistently shows up as the blocking process/thread locking up
>>>> filesystem IO.=C2=A0 IO gets into the RAID5 array via nfsd. There are=
 no
>>>> >>>> disk
>>>> or btrfs errors recorded.=C2=A0 scrub last finished yesterday success=
fully.
>>>>
>>>> Please provide the "echo l > /proc/sysrq-trigger" output when such
>>>> >>> pause
>>>> happens.
>>>>
>>>> If you're using qgroup (may be enabled by things like snapper), it ma=
y
>>>> be the cause, as qgroup does its accounting when committing >>>
>>>> transaction.
>>>>
>>>> If one transaction is super large, it can cause such problem.
>>>>
>>>> You can test if qgroup is enabled by:
>>>>
>>>> # btrfs qgroup show -prce <mnt>
>>>>
>>>> After doing some research around the internet, we've come to the
>>>> consideration above as described.=C2=A0 Unfortunately the official
>>>> documentation isn't clear on the following.
>>>>
>>>> Official documentation URL -
>>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>>
>>>> 1. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2? =
It
>>>> talks about the reverse, from v2 to v1!
>>>>
>>>> Just mount with "space_cache=3Dv2".
>>>>
>>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>>> "btrfs" command will NOT work with the filesystem?
>>>>
>>>> Why would you think "btrfs" won't work on a btrfs?
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>> So will our
>>>> "btrfs scrub start /mount/point/..." cron jobs FAIL? I'm guessing
>>>> the btrfs command comes from btrfs-progs which is currently >>>>
>>>> v5.4.1-2
>>>> amd64, is that correct?
>>>> 3. Any other ideas on how we can get rid of those annoying pauses wit=
h
>>>> large backups into the array?
>>>>
>>>> Thanks in advance!
>>>>
>>>> DP
