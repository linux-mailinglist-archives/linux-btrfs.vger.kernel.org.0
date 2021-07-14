Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710B3C7F8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhGNHsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 03:48:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:37281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238139AbhGNHsj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 03:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626248747;
        bh=NxHul6Eaom5X+HELRdOAkhp+l7zdAgxbiH/n6D5Qfw4=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=HFFPflyHyx6hzG+RrD/ZESRLha25bao8vNL/chw0vT94g7AG+OIVghvMOs5Q8XHRG
         OHaVhlJJjS1/KG33RvZpzZmJOFfzp8bgfVnkhK14NRgFVceyGLWaiGN7AaaBGU+tXU
         gyOUgBfeCR+D/VFw+I5DRc8RIxVEfVfJV1oFYDHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvmO-1lSa8n2lvC-00b5G9; Wed, 14
 Jul 2021 09:45:46 +0200
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
Message-ID: <ec9e92d8-ddfd-a103-6175-5176827ce9aa@gmx.com>
Date:   Wed, 14 Jul 2021 15:45:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c81f758f-c452-d30c-75a2-a6cdcf2f9a8e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y2pNxz4yiJGokyw+jHSvES4/LSqw6GPsLp1KuZdGh9BYYhbGmTm
 82ICShrjUNBoWqW41nn+VicZdg+vhE4qPpdML0lSRrzkG0RW3lU5UxrOFdxqGOFX8aEhY/D
 Jqf7zoOMs2EadGaJLePPrqXqmHaiUOFD9Wfmr6DFqsn36IO2a3/KS8rtY5UtW+qxnL+b6/s
 zjq1sgwSa4UvyuFQV3pGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SLExYyZOxBA=:1dXvLpxrEJrL5EYtEg7NLF
 6n+3AaTCucuvgno4rwTVRyzUyV2xCjrhEjRL9mvVTPfkOpbMZJoCRTFdVrmVyBSXgVVcANMu2
 0AjS9MS8jd0fCY5OqlvRH0lVxFD19f4psV2MHYMkWQHisvsJKriL+v5TK2kDm2SfTlgRxOuA5
 KafjTXDkU/VWH4MR5eulR36Cnk9cM7v3VBIcdTZVNog2DBxnMITO0AHrW9+Dhg3NB191OcKhK
 5pTwabXembXWe84wX2LWyBFcOmEzwD/M4PMTOVLDQs4tfWroqm/Xs6Ti/pktziVV/5OCyUKxY
 9er4rE3PS2M/JGNFtPGgNWPP9u18J0/NJOIhoP2KCm6H5R4FrGML7rmOXgkuJbYliwdQmNq8x
 54uEwts1sqIM6vQcGSzwZ7e9/xP1ji2viJgni7IcWXMcrx3E+aj5HUTWXECo2FndXBPFEYESL
 gbpBKUB9vnembkeu5D0sGMdPTG/z1j73ooReRH4XjbSEFcRwLu5+q+IjueHqaQGeQJsaHtsYK
 eJOQ/suuyCFzhIPUxxBRaHVCfGxEC2NQox2AzSaL5GNXEz8quambSLzV58wseSNc60L91dPiF
 ex6WYGsgGqH2k1OuEg9KostNFoIEYZ+BCTyImaAgPf50m3P9umTXHMQ0gIVSPGKWRDbDd2fX4
 M0J9S9AOsbkNLk4LQEeL5YTjF2ImcHfKnRm/Pn4FnOnn+eElGaacwoaF0UA7UaV7rDXYzEjnq
 WWLnmcHWakqIUgUsfOkfryCgeo05wVaV0Exgx6OXTLAk5eUuBnNtTtrRnIrbwuPcT0BMXXu0a
 GyGVJd6DtYobo0HFLsb2VAC3hEAs3fLMnIk2MUh+c7C1CvpXSjel9wf+oAlNH07zjX7Zhvv6y
 f8C7npiEHO/2pzA9Yj8p2IAAFtDegrpm54mfYSfhA/XPkcSRlyjRioWB+u/9gh+sVHJh3vdgG
 KI4s9a45wHuR6hf5P7tTk0KgPNGp4hcOZBQuKfm+WtMZqkNofTDlb/qBPhkt4VPpalomVl//B
 28xqEKsBzQmnOXrRtxwlGXuMobEkPYE+duPagug2prOJ9MpxYUbGO0QuSe/dDcGBiLPbWFtOn
 RaHnUbJGlfYcvajGD0sdy91cqCTWFsREZbjvOdOAxALnXfVDp+qfjhCfg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=883:18, DanglingPointer wrote:
> a) "echo l > /proc/sysrq-trigger"
>
> The backup finished today already unfortunately and we are unlikely to
> run it again until we get an outage to remount the array with the
> space_cache=3Dv2 and noatime mount options.
> Thanks for the command, we'll definitely use it if/when it happens again
> on the next large migration of data.

Just to avoid confusion, after that command, "dmesg" output is still
needed, as that's where sysrq put its output.
>
>
> b) "sudo btrfs qgroup show -prce" ........
>
> $ ERROR: can't list qgroups: quotas not enabled
>
> So looks like it isn't enabled.

One less thing to bother.
>
> File sizes are between: 1,048,576 bytes and 16,777,216 bytes (Duplicacy
> backup defaults)

Between 1~16MiB, thus tons of small files.

Btrfs is not really good at handling tons of small files, as they
generate a lot of metadata.

That may contribute to the hang.

>
> What classifies as a transaction?

It's a little complex.

Technically it's a check point where before the checkpoint, all you see
is old data, after the checkpoint, all you see is new data.

To end users, any data and metadata write will be included into one
transaction (with proper dependency handled).

One way to finish (or commit) current transaction is to sync the fs,
using "sync" command (sync all filesystems).

> Any/All writes done in a 30sec
> interval?

This the default commit interval. Almost all fses will try to commit its
data/metadata to disk after a configurable interval.

The default one is 30s. That's also one way to commit current transaction.

>=C2=A0 If 100 unique files were written in 30secs, is that 1
> transaction or 100 transactions?

It depends. As things like syncfs() and subvolume/snapshot creation may
try to commit transaction.

But without those special operations, just writing 100 unique files
using buffered write, it would only start one transaction, and when the
30s interval get hit, the transaction will be committed to disk.

>=C2=A0 Millions of files of the size range
> above were backed up.

The amount of files may not force a transaction commit, if it doesn't
trigger enough memory pressure, or free space pressure.

Anyway, the "echo l" sysrq would help us to locate what's taking so long
time.

>
>
> c) "Just mount with "space_cache=3Dv2""
>
> Ok so no need to "clear_cache" the v1 cache, right?

Yes, and "clear_cache" won't really remove all the v1 cache anyway.

Thus it doesn't help much.

The only way to fully clear v1 cache is by using "btrfs check
=2D-clear-space-cache v1" on a *unmounted* btrfs.

> I wrote this in the fstab but hadn't remounted yet until I can get an
> outage....

IMHO if you really want to test if v2 would help, you can just remount,
no need to wait for a break.

Thanks,
Qu
>
> ..."btrfs defaults,autodefrag,clear_cache,space_cache=3Dv2,noatime=C2=A0=
 0=C2=A0 2 >
> Thanks again for your help Qu!
>
> On 14/7/21 2:59 pm, Qu Wenruo wrote:
>>
>>
>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>>> We're currently considering switching to "space_cache=3Dv2" with noati=
me
>>> mount options for my lab server-workstations running RAID5.
>>
>> Btrfs RAID5 is unsafe due to its write-hole problem.
>>
>>>
>>> =C2=A0=C2=A0* One has 13TB of data/metadata in a bunch of 6TB and 2TB =
disks
>>> =C2=A0=C2=A0=C2=A0 totalling 26TB.
>>> =C2=A0=C2=A0* Another has about 12TB data/metadata in uniformly sized =
6TB disks
>>> =C2=A0=C2=A0=C2=A0 totalling 24TB.
>>> =C2=A0=C2=A0* Both of the arrays are on individually luks encrypted di=
sks with
>>> =C2=A0=C2=A0=C2=A0 btrfs on top of the luks.
>>> =C2=A0=C2=A0* Both have "defaults,autodefrag" turned on in fstab.
>>>
>>> We're starting to see large pauses during constant backups of millions
>>> of chunk files (using duplicacy backup) in the 24TB array.
>>>
>>> Pauses sometimes take up to 20+ seconds in frequencies after every
>>> ~30secs of the end of the last pause.=C2=A0 "btrfs-transacti" process
>>> consistently shows up as the blocking process/thread locking up
>>> filesystem IO.=C2=A0 IO gets into the RAID5 array via nfsd. There are =
no disk
>>> or btrfs errors recorded.=C2=A0 scrub last finished yesterday successf=
ully.
>>
>> Please provide the "echo l > /proc/sysrq-trigger" output when such paus=
e
>> happens.
>>
>> If you're using qgroup (may be enabled by things like snapper), it may
>> be the cause, as qgroup does its accounting when committing transaction=
.
>>
>> If one transaction is super large, it can cause such problem.
>>
>> You can test if qgroup is enabled by:
>>
>> # btrfs qgroup show -prce <mnt>
>>
>>>
>>> After doing some research around the internet, we've come to the
>>> consideration above as described.=C2=A0 Unfortunately the official
>>> documentation isn't clear on the following.
>>>
>>> Official documentation URL -
>>> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>>>
>>> 1. How to migrate from default space_cache=3Dv1 to space_cache=3Dv2? I=
t
>>> =C2=A0=C2=A0=C2=A0 talks about the reverse, from v2 to v1!
>>
>> Just mount with "space_cache=3Dv2".
>>
>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>> =C2=A0=C2=A0=C2=A0 "btrfs" command will NOT work with the filesystem?
>>
>> Why would you think "btrfs" won't work on a btrfs?
>>
>> Thanks,
>> Qu
>>
>>> =C2=A0 So will our
>>> =C2=A0=C2=A0=C2=A0 "btrfs scrub start /mount/point/..." cron jobs FAIL=
?=C2=A0 I'm guessing
>>> =C2=A0=C2=A0=C2=A0 the btrfs command comes from btrfs-progs which is c=
urrently v5.4.1-2
>>> =C2=A0=C2=A0=C2=A0 amd64, is that correct?
>>> 3. Any other ideas on how we can get rid of those annoying pauses with
>>> =C2=A0=C2=A0=C2=A0 large backups into the array?
>>>
>>> Thanks in advance!
>>>
>>> DP
>>>
