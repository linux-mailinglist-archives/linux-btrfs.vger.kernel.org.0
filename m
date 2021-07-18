Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35373CC855
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhGRJf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 05:35:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:60959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhGRJf1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 05:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626600736;
        bh=dmW+ufCARGPgCw/1cDuqHgtyaVJLk+oI8EObramIQGo=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=hMAek9XqsdupROwOyJQ8xmNVWd5Ma5OhU6hL4eZbxrUoQgiqufrAGC0dcmrXCeiSX
         BgAxKyXlYaUgDCYn/LzGLIe5gF7KdKzTKqPcld+K7CEP2/uq1xIq63mEI4+eXG2rJB
         2zDSCHULCV0d4LWTb/yBPLvRzzsZ8mBgJKHPqhGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGz1V-1lqyXE38fz-00E5Pp; Sun, 18
 Jul 2021 11:32:16 +0200
To:     pepperpoint@mb.ardentcoding.com
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
 <162651226617.7.3584131829663375587.10186721@mb.ardentcoding.com>
 <162651674065.6.7912816287233908759.10188327@simplelogin.co>
 <162651809235.7.7061042874033963922.10188873@mb.ardentcoding.com>
 <162651892663.6.17938009695497100557.10189169@simplelogin.co>
 <CQeY09U34m7SrT6nTAlkSQrbLJtmyKF1tDfuGDtKUkwJqujMI_nZU4MpGiU4F_Q1U3Lk1aWD1mFCT5SlsOsOcILWECflIw7EhVQTQpy_1Ts=@email.ardentcoding.com>
 <162658599956.8.1295537648062034245.10216359@mb.ardentcoding.com>
 <30ece5d9-9dd0-412f-1731-eaadbedd0bb4@gmx.com>
 <162659327011.8.12718249358254503695.10218325@simplelogin.co>
 <162659797656.6.14385932343235367381.10220447@mb.ardentcoding.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Read time tree block corruption detected
Message-ID: <6c930ce6-fb2f-d86e-8614-b10ee269c792@gmx.com>
Date:   Sun, 18 Jul 2021 17:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162659797656.6.14385932343235367381.10220447@mb.ardentcoding.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HUlrc0AQZn7QJ1WFogwlZaYnk/RHrUqdacuhqBR2XGB/PCmrCIM
 G4CFmQrjen8kLQPI4I6DtSpVuRd8zv/b5v6iekvE817Tp/p9/LqlKNCiaQBFhWQ8yKj3t+8
 fYBPsYzalZBZRB0Fcl2U92iWiF0KgqJ/V7bqf+vEl2IIlIKePbqjyrMjJGiVWEVuj5TZznG
 RYQBDoJx9ix5hsgLCE7Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c7PrxGmmNbE=:RNTJGsK2ylcvLG9WU6LvCi
 aayjW8YquBJNEruJrcSe36kfhsH2CgwENDmYFYMP06JoKl+3tBMsyJ31CZp1rc6cMhTU37pV6
 RqX3cWBpQ8HNZx4qzCcEMqNhz9NG/P+kcqzO1huTsEBwP256P3XXiuRWXEAIJrc8bEXksxKdh
 iEiBrsQOgg1wVSwRHejOjiWwqAo17Z7X7gge3+IRODLXww73ALfIjHUSeXc04jlVt55ZOG10S
 v2FDi15AouBkwKddUJBCJIDLHHz9FALe5vBJoSu800te54rFli5es2vNqvZN0++lAhX7l062y
 DirwVTxt3FBINiymEjGpwEZQ4brdoIYNaQeYcwmvgKg8HaDWHhb3YM6M8K7WH1O7ER+q/aBh4
 Wt88ilhatQBV9cZKogImrGW6fBNken1EsR35MK6lmqbym5Z9x+Q3TCE7WBLhOdwLBqZCQLHiq
 obtUyl9VYRCi+uCf9XQADUtHnpJ0X5ELw37o5v8ZmeKB4r/0B+SxuW/z34obWmgOdFFQibUOn
 kG5v6txZWOn9fwOmxlmBbuSZCW8VzN5zuvPg0IO5SHaewyF+85oqxRPaFhGdF45y3ZVJLg1hc
 ZzkJ3PgoGJO/OCJLua9pSNpVuKw+FRyM6ipzk0mUwXOUdwErSLPYmto8AbbbGoAhCOTcTYTYe
 XlI90HYWrOY9VarLV2v+aS27W/M9FeUcyiVlM9KbGYLl114R1CT1EhWhB8kktu71MfL6WNUwk
 BdMGmcKc4UYOJYqbKeksRMUcwFr3K2jCu6RPj99Ufh5ts0qpM+bFubKNq9VJGhQSrczpy8PsJ
 4eFQ9VQi9SN0m+NfYRbWvd7lMkIPPdGUaOnfUoXS2oPGea03pgP56eVzpv7Zpw1u546LmYjNx
 l5mth9u0Nr6vGlpmxcfUpwSpExxQFFTw4ceu4Ttat/EyEGRK84+j3Z1rZv4Ua3mf/+2BSKoci
 MQ5oZhn42wtusRDHGUkT6nVRdidLXTeeCzlA7cdCz/QQiJgEtaD8Dbsq50r4KwzZC4vn9PNIl
 9ZYymnpnQnO8r/JGc2nE7340Rhq7J69tmm37pP+7Z7aHCGqcWLEObTeleaTBK40eAka4mfWv/
 J0cEqap76QEkcMgCg4AkrAGi/Q6VMJgoySZm2AUluFeJONA7pSqsUiVoQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/18 =E4=B8=8B=E5=8D=884:46, pepperpoint@mb.ardentcoding.com wrote=
:
> Hi Qu,
>
> When I find which directory some of the filenames are located, they are =
under /var/lib.
> I had subvolume for /var which was created probably around 2018.

Then it's possible by somehow we allowed that hardlink to directory.

Not sure if it's a bug in VFS layer or in btrfs itself.

But around 2019 (aka, v5.2 kernel), that check for refs of directory is
introduced and at the same time, write-time tree checker is introduced.

This means if the bug happens after v5.2 kernel, it will be rejected
before submitting to disk.

So the problem definitely happens before the install of v5.2 kernel.

>
> I don't remember how I created this but I probably use rsync to copy the=
 files from existing /var
> or created a snapshot of root and delete other files that is not under /=
var.

But that's still pretty weird.

>
> Around June, I tried to move the filesystem to another partition through=
 btrfs device add and btrfs device remove
> but failed due to that error and was advised to use btrfs replace instea=
d.
>
> Then at the beginning of this month, I reorganized it merging most of th=
e /var content back to root
> and created subvolume for /var/lib/mysql and /var/lib/mongodb. I encount=
ered an error when
> I copy some of the files through cp --reflink but I failed for /var/lib/=
mysql so I created a snapshot
> from /var and remove the extra files.
>
> This is also the time I saw the errors in the log. Before that, the erro=
rs was not in the log.

At least, we should prevent such problem from reaching disk.

If you reverted to older LTS kernel, using Arch Linux Archive, it would
be possible to continue deleting the subvolume and solve the problem.

After the root 363 get fully deleted, you can verify that tree block get
deleted by the following command:

# btrfs ins dump-tree -t extent <device> | grep 174113599488 -A 3

Which should show no output.

Thanks,
Qu

>
> Regards,
> Lester
>
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original=
 Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>
> On Sunday, July 18th, 2021 at 3:27 PM, Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>
>> Hi,
>>
>> BTW, it's really important for us to know how the directory is hardlink=
ed.
>>
>> Thus I salvaged the filenames found in the half-dropped root 363.
>>
>> Since it may contain confidential info, I send the filename list to you
>>
>> off-list.
>>
>> If you can remind what the root 363 is used for, and any possible
>>
>> operations which may be involved in that subvolume, it's better to repl=
y
>>
>> it to the mail list so that we can get some clue on the root cause.
>>
>> Thanks,
>>
>> Qu
>>
>> On 2021/7/18 =E4=B8=8B=E5=8D=883:15, Qu Wenruo wrote:
>>
>>> On 2021/7/18 =E4=B8=8B=E5=8D=881:26, pepperpoint@mb.ardentcoding.com w=
rote:
>>>
>>>> Hi Qu,
>>>>
>>>> May I know if there are any leads on this? What should I do for now?
>>>
>>> Sorry for the late reply.
>>>
>>> With the image dump, it's much easier to find what's going wrong.
>>>
>>> -   About root 363
>>>
>>>      =C2=A0 It's an orphan root, thus user can't access it directly.
>>>
>>> Furthermore, it's being dropped, thus "btrfs ins dump-tree -t 363"
>>>
>>>  =C2=A0 reports transid error, as part of the tree has already been dr=
opped,
>>>
>>>  =C2=A0 and this is expected.
>>>
>>> So far your fs is still OK, except that reported error.
>>>
>>> -   About the offending tree block
>>>
>>>      =C2=A0 The offending tree block only belongs to the delete subvol=
ume 363,
>>>
>>>      =C2=A0 thus it should be delete soon.
>>>
>>> But unfortunately due to the corrupted content, it's unable to be
>>>
>>>  =C2=A0 deleted.
>>>
>>> For now, if you can re-compile btrfs module, we can workaround the
>>>
>>>  =C2=A0 problem by temporarily disable read-time tree-checker so that =
the
>>>
>>>  =C2=A0 deletion can continue, and after the root 363 get fully delete=
d, the
>>>
>>>  =C2=A0 problem should be gone.
>>>
>>> Or you can use older kernel, any kernel <=3D v5.1 should not have the
>>>
>>>  =C2=A0 enhanced check, thus can continue with the subvolume deletion.
>>>
>>> If you want to go through the re-compile path, the needed diff is
>>>
>>>  =C2=A0 attached
>>>
>>> Thanks,
>>>
>>> Qu
>>>
>>>> Regards,
>>>>
>>>> Lester
>>>>
>>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origi=
nal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
>>>>
>>>> On Saturday, July 17th, 2021 at 8:51 PM,
>>>>
>>>> pepperpoint@mb.ardentcoding.com wrote:
>>>>
>>>>> Hi Qu,
>>>>>
>>>>> I run btrfs ins dump-tree -t 363 unmounted but the same error
>>>>>
>>>>> appears. Rerunning btrfs check does not show any error.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Lester
>>>>>
>>>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Orig=
inal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
>>>>>
>>>>> On Saturday, July 17th, 2021 at 6:48 PM, Qu Wenruo -
>>>>>
>>>>> quwenruo.btrfs@gmx.com wrote:
>>>>>
>>>>>> On 2021/7/17 =E4=B8=8B=E5=8D=886:34, pepperpoint@mb.ardentcoding.co=
m wrote:
>>>>>>
>>>>>>> Hi Qu,
>>>>>>>
>>>>>>> Unfortunately I cannot find subvolume 363
>>>>>>>
>>>>>>> btrfs subvolume list /run/media/root
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>
>>>>>>> ID 361 gen 1814826 top level 584 path @/live/snapshot
>>>>>>>
>>>>>>> ID 364 gen 1814414 top level 5 path @vtmp/live/snapshot
>>>>>>>
>>>>>>> ID 369 gen 1814414 top level 5 path @vlmachines/live/snapshot
>>>>>>>
>>>>>>> ID 493 gen 1814414 top level 5 path @vlportables/live/snapshot
>>>>>>>
>>>>>>> ID 579 gen 1814828 top level 5 path @vlog/live/snapshot
>>>>>>>
>>>>>>> ID 580 gen 1814414 top level 5 path @vcache/live/snapshot
>>>>>>>
>>>>>>> ID 581 gen 1814414 top level 5 path @vlmongodb/live/snapshot
>>>>>>>
>>>>>>> ID 582 gen 1814414 top level 5 path @vlmysql/live/snapshot
>>>>>>>
>>>>>>> ID 583 gen 1814414 top level 5 path @vspool/live/snapshot
>>>>>>>
>>>>>>> ID 584 gen 1814414 top level 5 path @
>>>>>>>
>>>>>>> ID 598 gen 1813420 top level 584 path @/4/snapshot
>>>>>>
>>>>>> Maybe 363 is some subvolume get deleted and later snapshot of it st=
ill
>>>>>>
>>>>>> exists.
>>>>>>
>>>>>> This will be harder to debug.
>>>>>>
>>>>>> Can you take a btrfs-image dump of your filesystem? (needs to be ta=
ken
>>>>>>
>>>>>> with the fs unmounted).
>>>>>>
>>>>>> The dumped image will contain your metadata, including file names a=
nd
>>>>>>
>>>>>> directory structures, but no data inside those files.
>>>>>>
>>>>>> Although btrfs-image has "-s" option to mask the filenames, but
>>>>>>
>>>>>> considering the filename in this case is useful to locate the inode=
, I
>>>>>>
>>>>>> guess it's better to take the image without any "-s" option.
>>>>>>
>>>>>>> btrfs ins dump-tree -t 363 /dev/dm-0 | grep -A 5 "(286 "
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>
>>>>>>> parent transid verify failed on 174170742784 wanted 1789655 found
>>>>>>>
>>>>>>> 1812621
>>>>>>>
>>>>>>> parent transid verify failed on 174170742784 wanted 1789655 found
>>>>>>>
>>>>>>> 1812621
>>>>>>>
>>>>>>> parent transid verify failed on 174170742784 wanted 1789655 found
>>>>>>>
>>>>>>> 1812621
>>>>>>>
>>>>>>> Ignoring transid failure
>>>>>>>
>>>>>>> ERROR: child eb corrupted: parent bytenr=3D174170738688 item=3D0 p=
arent
>>>>>>>
>>>>>>> level=3D2 child bytenr=3D174170742784 child level=3D0
>>>>>>
>>>>>> This transid mismatch may be a problem when running dump-tree on
>>>>>>
>>>>>> mounted
>>>>>>
>>>>>> fs, since you mentioned btrfs check reported no error, there should=
n't
>>>>>>
>>>>>> be a transid mismatch error.
>>>>>>
>>>>>> Anyway, if you can upload the btrfs-image dump, it would be much ea=
sier
>>>>>>
>>>>>> for us to debug and find out what's really going.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Qu
>>>>>>
>>>>>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Or=
iginal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=
=80=90
>>>>>>>
>>>>>>> On Saturday, July 17th, 2021 at 6:12 PM, Qu Wenruo wqu@suse.com wr=
ote:
>>>>>>>
>>>>>>>> On 2021/7/17 =E4=B8=8B=E5=8D=884:57, pepperpoint@mb.ardentcoding.=
com wrote:
>>>>>>>>
>>>>>>>>> Hi Qu,
>>>>>>>>>
>>>>>>>>> I don't know how the directory was created but last month, I use=
d
>>>>>>>>>
>>>>>>>>> btrfs device add and btrfs device remove to move the filesystem
>>>>>>>>>
>>>>>>>>> from one partition to another. It failed because of the same
>>>>>>>>>
>>>>>>>>> error and was advised to use btrfs replace instead. I don't know
>>>>>>>>>
>>>>>>>>> if the error also happened before I move the file system as I
>>>>>>>>>
>>>>>>>>> don't have any previous logs.
>>>>>>>>
>>>>>>>> It definitely happens before you moving the fs.
>>>>>>>>
>>>>>>>> As regular dev replacing/add/move only relocates the metadata, bu=
t
>>>>>>>>
>>>>>>>> not
>>>>>>>>
>>>>>>>> touching the fs trees.
>>>>>>>>
>>>>>>>>> Here is the result when I search for the inodes you mentioned if
>>>>>>>>>
>>>>>>>>> it helps:
>>>>>>>>>
>>>>>>>>> find /run/media/root -inum 260 -exec ls -ldi {} \;
>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>>>>>>
>>>>>>>>> 260 -rw-r--r-- 1 root root 36864 Jun 25 06:22
>>>>>>>>>
>>>>>>>>> /run/media/root/@vcache/live/snapshot/app-info/cache/en_US.cache
>>>>>>>>>
>>>>>>>>> 260 drwx------ 1 mongodb mongodb 136 Sep 12 2020
>>>>>>>>>
>>>>>>>>> /run/media/root/@vlmongodb/live/snapshot/diagnostic.data
>>>>>>>>>
>>>>>>>>> 260 -rw-rw---- 1 mysql mysql 50331648 Sep 13 2015
>>>>>>>>>
>>>>>>>>> /run/media/root/@vlmysql/live/snapshot/ib_logfile0
>>>>>>>>>
>>>>>>>>> 260 -rw-r----- 1 root lp 8641 Mar 5 2014
>>>>>>>>>
>>>>>>>>> /run/media/root/@vspool/live/snapshot/cups/d00001-001
>>>>>>>>>
>>>>>>>>> 260 dr-xr-xr-x 1 root root 0 Sep 13 2013
>>>>>>>>>
>>>>>>>>> /run/media/root/@/live/snapshot/sys
>>>>>>>>>
>>>>>>>>> 260 dr-xr-xr-x 1 root root 0 Sep 13 2013
>>>>>>>>>
>>>>>>>>> /run/media/root/@/4/snapshot/sys
>>>>>>>>
>>>>>>>> Since btrfs can have the same inode number inside different
>>>>>>>>
>>>>>>>> subvolumes,
>>>>>>>>
>>>>>>>> you may want to limit the search inside subvolume 363.
>>>>>>>>
>>>>>>>> "-mount" option of find can do that, you only need to locate
>>>>>>>>
>>>>>>>> subvolume
>>>>>>>>
>>>>>>>> 363 by "btrfs subv list".
>>>>>>>>
>>>>>>>> But from these output I guess above two "sys" directory are more
>>>>>>>>
>>>>>>>> possible.
>>>>>>>>
>>>>>>>> Is there any directory named "blaklight" inside those directory?
>>>>>>>>
>>>>>>>>> find /run/media/root -inum 286 -exec ls -ldi {} \;
>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>>>>>>
>>>>>>>>> 286 -rw-r--r-- 1 root root 96 Aug 16 2015
>>>>>>>>>
>>>>>>>>> /run/media/root/@vcache/live/snapshot/fontconfig/4b172ca7f111e3c=
ffadc3636415fead9-le64.cache-4
>>>>>>>>>
>>>>>>>>> 286 -rw-rw---- 1 mysql mysql 4096 Sep 15 2013
>>>>>>>>>
>>>>>>>>> /run/media/root/@vlmysql/live/snapshot/mysql/columns_priv.MYI
>>>>>>>>>
>>>>>>>>> 286 -rw-r-----+ 1 root systemd-journal 16777216 Jul 4 01:14
>>>>>>>>>
>>>>>>>>> /run/media/root/@vlog/live/snapshot/journal/5098dd7845ae46d3ba18=
26c68a809a7c/user-1000@fbd9f65d0ea349f6b996716280e6c4dd-00000000002314c5-0=
005c5cb84a3a438.journal
>>>>>>>>
>>>>>>>> This is interesting, it means the inode 286 is not accessible.
>>>>>>>>
>>>>>>>> It can be some orphan inode, but would you dump subvolume 363 the=
n
>>>>>>>>
>>>>>>>> try
>>>>>>>>
>>>>>>>> to locate the inode 286?
>>>>>>>>
>>>>>>>> One example command would be:
>>>>>>>>
>>>>>>>> btrfs ins dump-tree -t 363 <dev> | grep -A 5 "(286 "
>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>> Directories with pattern /root/@<dir>/live/snapshot/ are
>>>>>>>>>
>>>>>>>>> subvolumes and directories with pattern
>>>>>>>>>
>>>>>>>>> /root/@<dir>/<num>/snapshot/ are snapshots of live.
>>>>>>>>>
>>>>>>>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 =
Original Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=
=80=90
>>>>>>>>>
>>>>>>>>> On Saturday, July 17th, 2021 at 4:14 PM, Qu Wenruo
>>>>>>>>>
>>>>>>>>> quwenruo.btrfs@gmx.com wrote:
>>>>>>>>>
>>>>>>>>>> On 2021/7/17 =E4=B8=8B=E5=8D=883:51, pepperpoint@mb.ardentcodin=
g.com wrote:
>>>>>>>>>>
>>>>>>>>>>> Hi Qu,
>>>>>>>>>>>
>>>>>>>>>>> Please see below for the dump.
>>>>>>>>>>>
>>>>>>>>>>> btrfs-progs v5.12.1
>>>>>>>>>>>
>>>>>>>>>>> leaf 174113599488 items 18 free space 2008 generation 1330906
>>>>>>>>>>>
>>>>>>>>>>> owner 363
>>>>>>>>>>>
>>>>>>>>>>> leaf 174113599488 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>>>>
>>>>>>>>>>> fs uuid a7d327c4-8594-4116-a6f8-8aa2a4162063
>>>>>>>>>>>
>>>>>>>>>>> chunk uuid f885f49e-14a0-4c80-9c12-c2302b9a0229
>>>>>>>>>>>
>>>>>>>>>>> item 0 key (5471 INODE_ITEM 0) itemoff 3835 itemsize 160
>>>>>>>>>>>
>>>>>>>>>>> generation 2063 transid 27726 size 40 nbytes 40
>>>>>>>>>>>
>>>>>>>>>>> block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
>>>>>>>>>>>
>>>>>>>>>>> sequence 1501 flags 0x0(none)
>>>>>>>>>>>
>>>>>>>>>>> atime 1386484844.468769570 (2013-12-08 14:40:44)
>>>>>>>>>>>
>>>>>>>>>>> ctime 1386484844.468769570 (2013-12-08 14:40:44)
>>>>>>>>>>>
>>>>>>>>>>> mtime 1386484844.468769570 (2013-12-08 14:40:44)
>>>>>>>>>>>
>>>>>>>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>>>>>>>
>>>>>>>>>>> item 1 key (5471 INODE_REF 4399) itemoff 3824 itemsize 11
>>>>>>>>>>>
>>>>>>>>>>> index 12 namelen 1 name: 8
>>>>>>>>>>>
>>>>>>>>>>> item 2 key (5471 EXTENT_DATA 0) itemoff 3763 itemsize 61
>>>>>>>>>>>
>>>>>>>>>>> generation 27726 type 0 (inline)
>>>>>>>>>>>
>>>>>>>>>>> inline extent data size 40 ram_bytes 40 compression 0 (none)
>>>>>>>>>>>
>>>>>>>>>>> item 3 key (5645 INODE_ITEM 0) itemoff 3603 itemsize 160
>>>>>>>>>>>
>>>>>>>>>>> generation 2542 transid 61261 size 40 nbytes 40
>>>>>>>>>>>
>>>>>>>>>>> block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
>>>>>>>>>>>
>>>>>>>>>>> sequence 24769 flags 0x0(none)
>>>>>>>>>>>
>>>>>>>>>>> atime 1394335806.351857522 (2014-03-09 11:30:06)
>>>>>>>>>>>
>>>>>>>>>>> ctime 1394335827.344389955 (2014-03-09 11:30:27)
>>>>>>>>>>>
>>>>>>>>>>> mtime 1394335827.344389955 (2014-03-09 11:30:27)
>>>>>>>>>>>
>>>>>>>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>>>>>>>
>>>>>>>>>>> item 4 key (5645 INODE_REF 4399) itemoff 3592 itemsize 11
>>>>>>>>>>>
>>>>>>>>>>> index 13 namelen 1 name: 7
>>>>>>>>>>>
>>>>>>>>>>> item 5 key (5645 EXTENT_DATA 0) itemoff 3531 itemsize 61
>>>>>>>>>>>
>>>>>>>>>>> generation 61261 type 0 (inline)
>>>>>>>>>>>
>>>>>>>>>>> inline extent data size 40 ram_bytes 40 compression 0 (none)
>>>>>>>>>>>
>>>>>>>>>>> item 6 key (7222 INODE_ITEM 0) itemoff 3371 itemsize 160
>>>>>>>>>>>
>>>>>>>>>>> generation 5754 transid 5767 size 307 nbytes 307
>>>>>>>>>>>
>>>>>>>>>>> block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>>>>>>>>>>
>>>>>>>>>>> sequence 7 flags 0x0(none)
>>>>>>>>>>>
>>>>>>>>>>> atime 1379834835.428558020 (2013-09-22 15:27:15)
>>>>>>>>>>>
>>>>>>>>>>> ctime 1379834835.428558020 (2013-09-22 15:27:15)
>>>>>>>>>>>
>>>>>>>>>>> mtime 1379834835.428558020 (2013-09-22 15:27:15)
>>>>>>>>>>>
>>>>>>>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>>>>>>>
>>>>>>>>>>> item 7 key (7222 INODE_REF 287) itemoff 3344 itemsize 27
>>>>>>>>>>>
>>>>>>>>>>> index 6 namelen 17 name: dhcpcd-eth0.lease
>>>>>>>>>>>
>>>>>>>>>>> item 8 key (7222 EXTENT_DATA 0) itemoff 3016 itemsize 328
>>>>>>>>>>>
>>>>>>>>>>> generation 5767 type 0 (inline)
>>>>>>>>>>>
>>>>>>>>>>> inline extent data size 307 ram_bytes 307 compression 0 (none)
>>>>>>>>>>>
>>>>>>>>>>> item 9 key (7415 INODE_ITEM 0) itemoff 2856 itemsize 160
>>>>>>>>>>>
>>>>>>>>>>> generation 5904 transid 1330906 size 180 nbytes 0
>>>>>>>>>>>
>>>>>>>>>>> block group 0 mode 40755 links 2 uid 0 gid 0 rdev 0
>>>>>>>>>>>
>>>>>>>>>>> sequence 177 flags 0x0(none)
>>>>>>>>>>>
>>>>>>>>>>> atime 1483277713.141980592 (2017-01-01 21:35:13)
>>>>>>>>>>>
>>>>>>>>>>> ctime 1563162901.234656246 (2019-07-15 11:55:01)
>>>>>>>>>>>
>>>>>>>>>>> mtime 1406534032.158605559 (2014-07-28 15:53:52)
>>>>>>>>>>>
>>>>>>>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>>>>>>
>>>>>>>>>> This inode is indeed a directory.
>>>>>>>>>>
>>>>>>>>>> But it has two hard links, which is definitely something
>>>>>>>>>>
>>>>>>>>>> unexpected.
>>>>>>>>>>
>>>>>>>>>> Under Linux we shouldn't have any hardlink for directory, as it
>>>>>>>>>>
>>>>>>>>>> would
>>>>>>>>>>
>>>>>>>>>> easily lead to loops.
>>>>>>>>>>
>>>>>>>>>>> item 10 key (7415 INODE_REF 260) itemoff 2837 itemsize 19
>>>>>>>>>>>
>>>>>>>>>>> index 28 namelen 9 name: backlight
>>>>>>>>>>
>>>>>>>>>> Its parent inode is 260 in the same root, with the name backlig=
ht.
>>>>>>>>>>
>>>>>>>>>>> item 11 key (7415 INODE_REF 286) itemoff 2818 itemsize 19
>>>>>>>>>>>
>>>>>>>>>>> index 3 namelen 9 name: backlight
>>>>>>>>>>
>>>>>>>>>> Another hardlink in inode 286, which is definitely a regular th=
ing.
>>>>>>>>>>
>>>>>>>>>> Btrfs-progs lacks the ability to detect such problem, we need t=
o
>>>>>>>>>>
>>>>>>>>>> enhance
>>>>>>>>>>
>>>>>>>>>> it first.
>>>>>>>>>>
>>>>>>>>>> But do you have any idea how this directory get created?
>>>>>>>>>>
>>>>>>>>>> It looks like the content of sysfs.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>> item 12 key (7415 DIR_ITEM 3128336373) itemoff 2746 itemsize 7=
2
>>>>>>>>>>>
>>>>>>>>>>> location key (120417 INODE_ITEM 0) type FILE
>>>>>>>>>>>
>>>>>>>>>>> transid 117279 data_len 0 name_len 42
>>>>>>>>>>>
>>>>>>>>>>> name: pci-0000:00:02.0:backlight:intel_backlight
>>>>>>>>>>>
>>>>>>>>>>> item 13 key (7415 DIR_ITEM 3218198317) itemoff 2705 itemsize 4=
1
>>>>>>>>>>>
>>>>>>>>>>> location key (7487 INODE_ITEM 0) type FILE
>>>>>>>>>>>
>>>>>>>>>>> transid 5992 data_len 0 name_len 11
>>>>>>>>>>>
>>>>>>>>>>> name: acpi_video0
>>>>>>>>>>>
>>>>>>>>>>> item 14 key (7415 DIR_ITEM 3582254411) itemoff 2638 itemsize 6=
7
>>>>>>>>>>>
>>>>>>>>>>> location key (55325 INODE_ITEM 0) type FILE
>>>>>>>>>>>
>>>>>>>>>>> transid 63351 data_len 0 name_len 37
>>>>>>>>>>>
>>>>>>>>>>> name: platform-VPC2004:00:backlight:ideapad
>>>>>>>>>>>
>>>>>>>>>>> item 15 key (7415 DIR_INDEX 2) itemoff 2597 itemsize 41
>>>>>>>>>>>
>>>>>>>>>>> location key (7487 INODE_ITEM 0) type FILE
>>>>>>>>>>>
>>>>>>>>>>> transid 5992 data_len 0 name_len 11
>>>>>>>>>>>
>>>>>>>>>>> name: acpi_video0
>>>>>>>>>>>
>>>>>>>>>>> item 16 key (7415 DIR_INDEX 4) itemoff 2530 itemsize 67
>>>>>>>>>>>
>>>>>>>>>>> location key (55325 INODE_ITEM 0) type FILE
>>>>>>>>>>>
>>>>>>>>>>> transid 63351 data_len 0 name_len 37
>>>>>>>>>>>
>>>>>>>>>>> name: platform-VPC2004:00:backlight:ideapad
>>>>>>>>>>>
>>>>>>>>>>> item 17 key (7415 DIR_INDEX 5) itemoff 2458 itemsize 72
>>>>>>>>>>>
>>>>>>>>>>> location key (120417 INODE_ITEM 0) type FILE
>>>>>>>>>>>
>>>>>>>>>>> transid 117279 data_len 0 name_len 42
>>>>>>>>>>>
>>>>>>>>>>> name: pci-0000:00:02.0:backlight:intel_backlight
>>>>>>>>>>>
>>>>>>>>>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90 Original Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90=E2=80=90
>>>>>>>>>>>
>>>>>>>>>>> On Saturday, July 17th, 2021 at 3:05 PM, Qu Wenruo
>>>>>>>>>>>
>>>>>>>>>>> quwenruo.btrfs@gmx.com wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 2021/7/17 =E4=B8=8A=E5=8D=889:45, pepperpoint@mb.ardentcod=
ing.com wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>
>>>>>>>>>>>>> I see this message on dmesg:
>>>>>>>>>>>>>
>>>>>>>>>>>>> [ 2452.256756] BTRFS critical (device dm-0): corrupt leaf:
>>>>>>>>>>>>>
>>>>>>>>>>>>> root=3D363 block=3D174113599488 slot=3D9 ino=3D7415, invalid=
 nlink:
>>>>>>>>>>>>>
>>>>>>>>>>>>> has 2 expect no more than 1 for dir
>>>>>>>>>>>>>
>>>>>>>>>>>>> [ 2452.256776] BTRFS error (device dm-0): block=3D1741135994=
88
>>>>>>>>>>>>>
>>>>>>>>>>>>> read time tree block corruption detected
>>>>>>>>>>>>
>>>>>>>>>>>> Please provide the following dump:
>>>>>>>>>>>>
>>>>>>>>>>>> btrfs ins dump-tree -b 174113599488 /dev/dm-0
>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>
>>>>>>>>>>>> Qu
>>>>>>>>>>>>
>>>>>>>>>>>>> When I run btrfs scrub and btrfs check, no error was detecte=
d.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am running Linux 5.12.15-arch1-1 and btrfs-progs v5.12.1
>>>>>>>>>>>>>
>>>>>>>>>>>>> How should I fix this error?
