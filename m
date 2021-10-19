Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E20D4335D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhJSMWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 08:22:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:41249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235653AbhJSMWf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 08:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634646020;
        bh=jLQ+57SODWdJ7ZgKXqyh9Et52JF9VQUl+n4Nr7ULU1I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WvRbsX2y/vaEkwFUcQsP1qRyS4HgToGmaYuLRbztVYCbsel68GsmKR69jDG+WHlSA
         Soeou2rR9FHiMIUfN6S3Sk9h2JHnrMozsQ9nTL/KMC+Mn5ziH+gl7f7fPQds997umq
         d0LXChYIerUQTW5M+fYlLULVCmHMJYg8Amg4PMqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1mguyO3iQl-005EZJ; Tue, 19
 Oct 2021 14:20:20 +0200
Message-ID: <5d8df74b-6094-de7d-1b47-885126cf4bc6@gmx.com>
Date:   Tue, 19 Oct 2021 20:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Errors after successful disk replace
Content-Language: en-US
To:     Emil Heimpel <broetchenrackete@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
 <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com>
 <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com>
 <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
 <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VDnTk1d4IcY8I4d4R03hxP5jEhIeBgckM5Dsw+SZ9S63PiWVhQ8
 ATeuk3dt35zs+149XXbQWjgge6Rjd3E7s68wmCuIdeSOlp8AREoOgBy5CA2EmG5qr+LpFgQ
 K4xxxcSyIT1TLsW8IuSWJiF9FV4tRuf2Ze+udBuNDZGXZpdDiBl9iHGoVeuEu3eL2ZrS1U2
 hHWCOMp44uvEccl/d49yA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+4JSkQv8UE=:bREptqDJlYNcG4Pb7yeMDM
 u/2v+OQhblkZAJPaOTheWFdcwaqJLzGXLicc+W65qp1/Y97OM9FZbxmhgIN+MvTFptCTfGmrX
 XHS3q98Ycbl5+JCMDilpGjd+qalFPBwNzhZ4B2BSM1mj0tnTQoqZkqI4tnHtzwDyDE9TRoEhd
 4Ms3zig/1dJYqhUVR68boP7wUaXJRAJIoQKXKFKjiKUsd5tuJLTw9aPwXCwlSlMdd7PHIgUdw
 AMirRN+7hEuDEBjiYI5b+IMGCUeA6nxXpnC13MlMfp1ULTkvqQ664z/d6e9dpFbEu0Dj6brQz
 jMJRjo8T/u0LCt/y5XZQ+FlBkQroZD28lPf8xC83onPJBaQOXbpawVM1V/we2qb/4ZNaaKi+K
 7SSy3WW7nq+nF9Hx1u7Ti66w72Ef7Hgz5m9z0cBUUBZi+5gsb/aQoX9Bt4neHWmWnOBoWqo6+
 n7d3A6J8hhwBn2FSKJVJK02IN3DAH731R0oqRtweSI26RCYLby3PJLw7g+6JA1eFruHn2Gtqh
 F+nmayRmymIlvqHV5jnhc7TvHyQvgK8vIMiT6uzBDit3+fpjk1j+NE3d1m0xWM4sTQxksD+AZ
 nuji23EsXUMHUv2oFMlCtvfUjDHFsKTBYzKNY2seA19GFEd7CBG0LmafUXNG56S365CRJXp/I
 So+g81+b9yL7hHN5NHZy+orR9upaHtokRep4Zd0aoGkAHNSLEvqi/P3D/qFKwCgfQ0BQpKiFG
 DJL8cyNOpHsDhTwvnCw90HZwxVI9FTctIuJl8kYHKFxSpe9Q6EgRBuBSeLEwF3HD4jPcmUAju
 e92jqYWuLzt56Rqus6hiIXv3INirV+Vi82ypvNdWy9Hss26u9DfwIGsYWVeXtjsna7He2EFTo
 m5kd7zCxJNI1kn/yqTnRFkdie8ttQT7o5xP/S9fx8VLStHoEw+r0eKEiINlefOZINKBE00d6Q
 Z/jKDSAdQspn9L6aVbLG96tUmZqTMvjRIirbs0AU96+IF6y2X23Lv0rYDFOIpEUYRp2SvxwJN
 8EVdwJv83d8uk76wQzQi2SQer2Z7GNC4uHcYWzmMs7e6fZfxiqgIHxWy8XfP//kJ81xJokmuQ
 QxbdXjx779ui2o=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/19 20:16, Emil Heimpel wrote:
> Color me suprised:
>
>
> [74713.072745] BTRFS info (device sde1): flagging fs with big metadata f=
eature
> [74713.072755] BTRFS info (device sde1): allowing degraded mounts
> [74713.072758] BTRFS info (device sde1): using free space tree
> [74713.072760] BTRFS info (device sde1): has skinny extents
> [74713.104297] BTRFS warning (device sde1): devid 1 uuid 51645efd-bf95-4=
58d-b5ae-b31623533abb is missing
> [74714.675001] BTRFS info (device sde1): bdev (efault) errs: wr 52950, r=
d 8161, flush 0, corrupt 1221, gen 0
> [74714.675015] BTRFS info (device sde1): bdev /dev/sdb1 errs: wr 0, rd 0=
, flush 0, corrupt 228, gen 0
> [74714.675025] BTRFS info (device sde1): bdev /dev/sdc1 errs: wr 0, rd 0=
, flush 0, corrupt 140, gen 0
> [74751.033383] BTRFS info (device sde1): continuing dev_replace from <mi=
ssing disk> (devid 1) to target /dev/sde1 @74%
> [bluemond@BlueQ ~]$ sudo btrfs replace status=C2=A0 -1 /mnt/btrfsrepair/
> 74.9% done, 0 write errs, 0 uncorr. read errs
>
> I guess I just wait?

Yep, wait and stay alert, better to also keep an eye on the dmesg.

But this also means, previous replace didn't really finish, which may
mean the replace ioctl is not reporting the proper status, and can be a
possible bug.

Thanks,
Qu

>
> Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>>
>>
>> On 2021/10/19 18:49, Emil Heimpel wrote:
>>>
>>> Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>>
>>>>
>>>> On 2021/10/19 11:54, Emil Heimpel wrote:
>>>>> Hi all,
>>>>>
>>>>> One of my drives of a raid 5 btrfs array failed (was dead completely=
) so I installed an identical replacement drive. The dead drive was devid =
1 and the new drive /dev/sde. I used the following to replace the missing =
drive:
>>>>>
>>>>> sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/
>>>>>
>>>>> and it completed successfully without any reported errors (took arou=
nd 2 weeks though...).
>>>>>
>>>>> I then tried to see my array with filesystem show, but it hung (or t=
ook longer than I wanted to wait), so I did a reboot.
>>>>
>>>> Any dmesg of that time?
>>>>
>>>
>>> Nothing after the replace finished:
>>>
>>> 1634463961.245751 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663044222976 for dev (efault)
>>> 1634463961.255819 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663045795840 for dev (efault)
>>> 1634463961.275815 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663046582272 for dev (efault)
>>> 1634463961.275922 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663047368704 for dev (efault)
>>> 1634463961.339074 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663048155136 for dev (efault)
>>> 1634463961.339248 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663048941568 for dev (efault)
>>
>> *failed*...
>>
>>> 1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!scmd=
(0x0000000046fead3f), outstanding for 7120 ms & timeout 7000 ms
>>> 1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA com=
mand pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
>>> 1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sas_=
address(0x4433221105000000), phy(5)
>>> 1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical id=
(0x590b11c022f3fb00), slot(6)
>>
>> And ATA commands failure.
>>
>> I don't believe the replace finished without problem, and the involved
>> device is /dev/sdd.
>>
>>> 1634475910.787911 BlueQ kernel: sd 9:0:2:0: task abort: SUCCESS scmd(0=
x0000000046fead3f)
>>> 1634475910.807083 BlueQ kernel: sd 9:0:2:0: Power-on or device reset o=
ccurred
>>> 1634475949.877998 BlueQ kernel: sd 9:0:2:0: Power-on or device reset o=
ccurred
>>> 1634525944.213931 BlueQ kernel: perf: interrupt took too long (3138 > =
3137), lowering kernel.perf_event_max_sample_rate to 63600
>>> 1634533791.168760 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 22996545634304 for dev (efault)
>>> 1634552685.203559 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 23816815706112 for dev (efault)
>>
>> You won't want to see this message at all.
>>
>> This means, you're running RAID56, as btrfs has write-hole problem,
>> which will degrade the robust of RAID56 byte by byte for each unclean
>> shutdown.
>>
>> I guess the write hole problem has already make the repair failed for
>> the replace.
>>
>> Thus after a successful mount, scrub and manually file checking is
>> almost a must.
>>
>>> 1634558977.979621 BlueQ kernel: BTRFS info (device sdb1): dev_replace =
from <missing disk> (devid 1) to /dev/sde1 finished
>>> 1634560793.132731 BlueQ kernel: zram0: detected capacity change from 3=
2610864 to 0
>>> 1634560793.169379 BlueQ kernel: zram: Removed device: zram0
>>> 1634560883.549481 BlueQ kernel: watchdog: watchdog0: watchdog did not =
stop!
>>> 1634560883.556038 BlueQ systemd-shutdown[1]: Syncing filesystems and b=
lock devices.
>>> 1634560883.572840 BlueQ systemd-shutdown[1]: Sending SIGTERM to remain=
ing processes...
>>>
>>>
>>>
>>>
>>>>>
>>>>> It showed up after a reboot as followed:
>>>>>
>>>>> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes=
 used 20.96TiB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
0 size 7.28TiB used 5.46TiB path /dev/sde1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
2 size 7.28TiB used 5.46TiB path /dev/sdb1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
3 size 2.73TiB used 2.73TiB path /dev/sdg1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
4 size 2.73TiB used 2.73TiB path /dev/sdd1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
5 size 7.28TiB used 4.81TiB path /dev/sdf1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
6 size 7.28TiB used 5.33TiB path /dev/sdc1
>>>>>
>>>>> I then tried to mount it, but it failed, so I run a readonly check a=
nd it reported the following problem:
>>>>
>>>> And dmesg for the failed mount?
>>>>
>>>
>>> Oops, I must have missed that it failed because of missing devid 1 too=
...
>>>
>>> 1634562944.145383 BlueQ kernel: BTRFS info (device sde1): flagging fs =
with big metadata feature
>>> 1634562944.145529 BlueQ kernel: BTRFS info (device sde1): force zstd c=
ompression, level 2
>>> 1634562944.145650 BlueQ kernel: BTRFS info (device sde1): using free s=
pace tree
>>> 1634562944.145697 BlueQ kernel: BTRFS info (device sde1): has skinny e=
xtents
>>> 1634562944.148709 BlueQ kernel: BTRFS error (device sde1): devid 1 uui=
d 51645efd-bf95-458d-b5ae-b31623533abb is missing
>>> 1634562944.148764 BlueQ kernel: BTRFS error (device sde1): failed to r=
ead chunk tree: -2
>>> 1634562944.185369 BlueQ kernel: BTRFS error (device sde1): open_ctree =
failed
>>
>> This doesn't sound correct.
>>
>> If a device is properly replaced, it should have the same devid number.
>>
>> I guess you have tried to add a new device before, and then tried to
>> replace the missing device, right?
>>
>>
>> Anyway, have you tried to mount it degraded and then remove the missing
>> device?
>>
>> Since you're using RAID56, I guess degrade mount should work.
>>
>> Thanks,
>> Qu
>>
>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> [...]
>>>>> [2/7] checking extents
>>>>> ERROR: super total bytes 38007432437760 smaller than real device(s) =
size 46008994590720
>>>>> ERROR: mounting this fs may fail for newer kernels
>>>>> ERROR: this can be fixed by 'btrfs rescue fix-device-size'
>>>>> [3/7] checking free space tree
>>>>> [...]
>>>>>
>>>>> So I followed that advice but got the following error:
>>>>>
>>>>> sudo btrfs rescue fix-device-size /dev/sde1
>>>>> ERROR: devid 1 is missing or not writeable
>>>>> ERROR: fixing device size needs all device(s) to be present and writ=
eable
>>>>>
>>>>> So it seems something went wrong or didn't complete fully.
>>>>> What can I do to fix this problem?
>>>>>
>>>>> uname -a
>>>>> Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16=
 +0000 x86_64 GNU/Linux
>>>>>
>>>>> btrfs --version
>>>>> btrfs-progs v5.14.2
>>>>>
>>>>> Regards,
>>>>> Emil
>>>>>
>>>>> P.S.: Yes, I know, raid5 isn't stable but it works good enough for m=
e ;)
>>>>> Metadata is raid1 btw...
>>>>>
>>>
