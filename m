Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC314CF2BD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiCGHk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiCGHkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:40:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360D11C1C
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646638762;
        bh=Lf7GCmpvg83jDo7QeHgBVL+EnR0pJ2r7TAhC8xiUjjA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UX3gcbIVh+yYoNkemsJKBeEz9v+pKvFq1970fNlE9S2yl0sXsWXXSh/NoXYXXoP8n
         Ys7M1axNHnejofzzPHn9pHvM/EyzvUFcfVc/x4c6fEdiFcnFV/qTnI3VbrF7T8rouz
         L7vWfNNWB4LIiIs2a66NZm8kgpHwLS5Z1rALPKQg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1nOKP60GfG-00H5Lb; Mon, 07
 Mar 2022 08:39:22 +0100
Message-ID: <b3011d7e-46e8-cc97-d57c-fec9a7be5510@gmx.com>
Date:   Mon, 7 Mar 2022 15:39:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: AW: AW: How to (attempt to) repair these btrfs errors
Content-Language: en-US
To:     Carsten Grommel <c.grommel@profihost.ag>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <YiQQOFQO7G4NZTKS@hungrycats.org>
 <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <5379ca8e-0384-b447-52c1-a41ef0ded7e7@gmx.com>
 <AM0PR08MB3265B4FA65082A7FDEB942248E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB32650EE051D9A01316C6525F8E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <AM0PR08MB32650EE051D9A01316C6525F8E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QpdHdLt2zOEJ11uhrWHf9GwUjl6TUBsd0gxiKThHamy52rHpS/I
 V3maW5Zapbfcjxzh7W7LYN3oovLlOLVRgPqnghq+L1bu2TvnqEXwn3zO9pIGjtpjmO+3/Wp
 oVIqytb49gvX/NCqpkx1f2PbuBoMHuYGwiGSB7vZJoxfyEnyGg4w3Fj54HjFweAOU2oUtY+
 /5rIZ9R/CCx3zT8viqJdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y9olB0SH+vI=:UuFOc/8icoyyBBLBFExALh
 65dMYMG1oBtNEavkBSq7/q8nQhAFNnzHuTv5dLhLLlsgNNkudA1D+3VYW8qfWZgzKbBLTc0TM
 6mRgsPXa+SWtcjD8+5UBJ8EQ4wHWdJga0xnSM0APQaeOGj4ZHWNHlpBUOV2RUnerE+7oG24FH
 IH6i1Nfbeya0ULn+6zQBUrzux0Xop5WGutn1QLvlY+a0wFZHYvoxILwUgZpOw5p6uxPa96FuZ
 iApjYxwku3V5qEBtJ86pIZw9YFs+K8pkMohyAcZox+lwaBID2WV8yNBU56iN3Njj0YNnSjTEC
 iZLOxy9c4t8lnKEAZ1HQU9wlfwBm9qffag6BTG+IV/Gy15ytVRLV+MUFOhzSnKGKFI6JzlUO8
 4BVUfFlIRbDCNpB3sJCh8vhd1qTKZD/+jJW7mI/Mq0Eeb0rrZ20z9RGviw+YvBYwFshgoMKGr
 BbJmUAIwdSXNVooDEWrdXv2OyVZ1jAAA1e2S/h9fieKxGeSgjWGYdRFHP7VwjapVY5UbmEODb
 4y8KIrJzNWzpQlWSOfGL84aXcOsD45E6dbJUyIa8uKXYsGbeF0fa27OUxsMROKxXNF1hQFOmh
 2NengfbS/Dqc7CBGauiIPVDLtg0z3w/CenI1o7OTNBt7f2i2cPbAWapgzwxnc08GzTVsJxjwU
 VP26MFq7dcxxUPqeuOfwsaUosbAPzYdPoWYmxFfaCAtq9ci1tgoo+ATnZjnehV4gEppJPxinX
 mIFzOBpAdSLVGO+b1V3MC3vx4GGOTXPvJXFumkogroBKueIT4Bu/T23mmpQV1BxbNUqFsuu/q
 CUcL3q2bFfg0+51ku4SqKKPZWoin2RANKY5xa7cWcI3g31VFPg8Ik55uchcYAeD+ghFpEdgB2
 VKkRXp/CJHuqIwQ0Kh14Fh2mbHIFht88P7gESi2T3vvfVO/R4R2aKoFJ/Tlh2X83OeDt8oKb/
 pCRkwLeyKZzLj2HJm1KGnWqHyL7Iu+tV++ps9pjE8dEy0k0pSbXcPEES4i/2YDI+H8O8p0LuA
 t4plOrj55o4+FvMtSMmg91xNyjXoDZFRH/JgzcsUAWS/qDWFZEwMZ8c7xB4qpM9V0tuETKBD0
 X6r63v1dnCj4Ao=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/7 15:27, Carsten Grommel wrote:
> These seems to be the most critical afaic:
>
> Mar  4 01:25:51 cloud8-1550 kernel: [44623.523395] BTRFS critical (devic=
e sdc1): corrupt leaf: root=3D111550 block=3D849874468864 slot=3D0 ino=3D3=
2633089 file_offset=3D7805042688, invalid compression for file extent, hav=
e 15 expect range [0, 3]

OK, this would explain the problem much better than the repairable
metadata read.

There should be no way we have compression type 0xf.

> Mar  4 01:25:51 cloud8-1550 kernel: [44623.527109] BTRFS error (device s=
dc1): block=3D849874468864 read time tree block corruption detected
> Mar  4 01:25:52 cloud8-1550 kernel: [44623.643308] BTRFS critical (devic=
e sdc1): corrupt leaf: root=3D50979 block=3D849880268800 slot=3D2, bad key=
 order, prev (18446744073709551606 128 1269917216768) current (18446744073=
709551606 128 1269916291
> 072)

And bad tree key order, even more serious.

hex(1269917216768) =3D 0x127acf6f000
hex(1269916291072) =3D 0x127ace8d000

Doesn't look like a simple bitflip, nor does the preivous 0xf
compression type.

I have no idea how things can be so terribly wrong...

Thanks,
Qu

> Mar  4 01:25:52 cloud8-1550 kernel: [44623.648078] BTRFS error (device s=
dc1): block=3D849880268800 read time tree block corruption detected
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.087943] BTRFS critical (devic=
e sdc1): corrupt leaf: root=3D7 block=3D83188697202688 slot=3D0, unexpecte=
d item end, have 16139 expect 16283
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.092173] BTRFS error (device s=
dc1): block=3D83188697202688 read time tree block corruption detected
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.094775] repair_io_failure: 17=
0 callbacks suppressed
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.094779] BTRFS info (device sd=
c1): read error corrected: ino 0 off 83188697202688 (dev /dev/sde1 sector =
380092288)
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.144525] BTRFS info (device sd=
c1): read error corrected: ino 0 off 83188697206784 (dev /dev/sde1 sector =
380092296)
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.147691] BTRFS info (device sd=
c1): read error corrected: ino 0 off 83188697210880 (dev /dev/sde1 sector =
380092304)
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.149705] BTRFS info (device sd=
c1): read error corrected: ino 0 off 83188697214976 (dev /dev/sde1 sector =
380092312)
> Mar  4 01:26:30 cloud8-1550 kernel: [44662.156236] BTRFS critical (devic=
e sdc1): corrupt leaf: root=3D96207 block=3D83188697219072 slot=3D0, unexp=
ected item end, have 16395 expect 16283
>
> ________________________________________
> Von: Carsten Grommel <c.grommel@profihost.ag>
> Gesendet: Montag, 7. M=C3=A4rz 2022 08:25
> An: Qu Wenruo; Zygo Blaxell
> Cc: linux-btrfs@vger.kernel.org
> Betreff: AW: AW: How to (attempt to) repair these btrfs errors
>
> Hi Qu,
>
>> Mind to share a dmesg just after the RO fallback?
>
> the most recent crash:
>
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.191649] BTRFS error (device s=
dc1): parent transid verify failed on 16155500953600 wanted 126097 found 9=
4652
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.194011] BTRFS error (device s=
dc1): parent transid verify failed on 16155500953600 wanted 126097 found 9=
4652
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.195395] BTRFS error (device s=
dc1): parent transid verify failed on 16155500953600 wanted 126097 found 1=
26097
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.196620] BTRFS error (device s=
dc1): parent transid verify failed on 16155500953600 wanted 126097 found 1=
26097
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.197920] BTRFS error (device s=
dc1): parent transid verify failed on 16155500953600 wanted 126097 found 1=
26097
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.212980] BTRFS info (device sd=
c1): read error corrected: ino 0 off 16155500953600 (dev /dev/sde1 sector =
10546500256)
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.214413] BTRFS info (device sd=
c1): read error corrected: ino 0 off 16155500957696 (dev /dev/sde1 sector =
10546500264)
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.215204] BTRFS error (device s=
dc1): parent transid verify failed on 16155500953600 wanted 126097 found 9=
4652
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.215656] BTRFS info (device sd=
c1): read error corrected: ino 0 off 16155500961792 (dev /dev/sde1 sector =
10546500272)
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.230156] BTRFS: error (device =
sdc1) in btrfs_finish_ordered_io:2736: errno=3D-5 IO failure
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.233127] BTRFS info (device sd=
c1): read error corrected: ino 0 off 16155500965888 (dev /dev/sde1 sector =
10546500280)
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.247096] BTRFS info (device sd=
c1): forced readonly
>
> ________________________________________
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Gesendet: Montag, 7. M=C3=A4rz 2022 08:11
> An: Carsten Grommel; Zygo Blaxell
> Cc: linux-btrfs@vger.kernel.org
> Betreff: Re: AW: How to (attempt to) repair these btrfs errors
>
>
>
> On 2022/3/7 15:03, Carsten Grommel wrote:
>> Thank you for the answer. We are using space_cache v2:
>>
>> /dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=
=3Dzlib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subv=
ol=3D/,x-systemd.mount-timeout=3D4h)
>>
>>> Data is raid0, so data repair is not possible.  Delete all the files
>>> that contain corrupt data.
>>
>> I tried but as soon as I access the broken blocks btrfs fails into read=
only so I am kind of in a deadlock there.
>
> Btrfs only falls back to RO for very critical errors (which could affect
> on-disk metadata consistency).
>
> Thus plain data corruption should not cause the RO.
>
> Mind to share a dmesg just after the RO fallback?
>
> Thanks,
> Qu
>
>>
>>> I don't see any errors in these logs that would indicate a metadata is=
sue,
>>> but huge numbers of messages are suppressed.  Perhaps a log closer
>>> to the moment when the filesystem goes read-only will be more useful.
>>
>>> I would expect that if there are no problems on sda1 or sdb1 then it
>>> should be possible to repair the metadata errors on sdd1 by scrubbing
>> that device.
>>
>> I ran a number of scrubs now, at some point it always fails and btrfs r=
emounts into readonly.
>> I did not yet try to scrub specifically on sdd though, gonna try that.
>>
>> Should it remount again i will provide the most recent dmesg's right be=
fore it crashes.
>>
>> ________________________________________
>> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>> Gesendet: Sonntag, 6. M=C3=A4rz 2022 02:36
>> An: Carsten Grommel
>> Cc: linux-btrfs@vger.kernel.org
>> Betreff: Re: How to (attempt to) repair these btrfs errors
>>
>> On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:
>>> Follow-up pastebin with the most recent errors in dmesg:
>>>
>>> https://pastebin.com/4yJJdQPJ
>>
>> This seems to have expired.
>>
>>> ________________________________________
>>> Von: Carsten Grommel
>>> Gesendet: Montag, 28. Februar 2022 19:41
>>> An: linux-btrfs@vger.kernel.org
>>> Betreff: How to (attempt to) repair these btrfs errors
>>>
>>> Hi,
>>>
>>> short buildup: btrfs filesystem used for storing ceph rbd backups with=
in subvolumes got corrupted.
>>> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Ra=
ids for performance ( we have to store massive Data)
>>>
>>> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86=
_64 GNU/Linux
>>>
>>> But it was Kernel 5.4.121 before
>>>
>>> btrfs --version
>>> btrfs-progs v4.20.1
>>>
>>> btrfs fi show
>>> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0
>>>                   Total devices 3 FS bytes used 56.74TiB
>>>                   devid    1 size 25.46TiB used 22.70TiB path /dev/sda=
1
>>>                   devid    2 size 25.46TiB used 22.69TiB path /dev/sdb=
1
>>>                   devid    3 size 25.46TiB used 22.70TiB path /dev/sdd=
1
>>>
>>> btrfs fi df /vmbackup/
>>> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB
>>> System, RAID1: total=3D8.00MiB, used=3D4.36MiB
>>> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB
>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>
>>> Attached the dmesg.log, a few dmesg messages following regarding the d=
ifferent errors (some informations redacted):
>>>
>>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 e=
rrs: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286
>>>
>>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 e=
rrs: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286
>>>
>>> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup =
(regular) error at logical 776693776384 on dev /dev/sdd1
>>>
>>> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks=
 suppressed
>>>
>>> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error=
 at logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 108=
747, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_=
vm-XXX-disk-X-base.img_1645337735)
>>>
>>> I am able to mount the filesystem in read-write mode but accessing spe=
cific blocks seems to crash btrfs to remount into read-only
>>> I am currently running a scrub over the filesystem.
>>>
>>> The system got rebooted and the fs got remounted 2-3 times. I made the=
 experience that usually btrfs would and could fix these kinds of errors a=
fter a remount, not this time though.
>>>
>>> Before I ran =E2=80=9Cbtrfs check =E2=80=93repair=E2=80=9D I would lik=
e some advice at how to tackle theses errors.
>>
>> The corruption and generation event counts indicate sdd1 (or one of its
>> component devices) was offline for a long time or suffered corruption
>> on a large scale.
>>
>> Data is raid0, so data repair is not possible.  Delete all the files
>> that contain corrupt data.
>>
>> If you are using space_cache=3Dv1, now is a good time to upgrade to
>> space_cache=3Dv2.  v1 space cache is stored in the data profile, and it=
 has
>> likely been corrupted.  btrfs will usually detect and repair corruption
>> in space_cache=3Dv1, but there is no need to take any such risk here
>> when you can easily use v2 instead (or at least clear the v1 cache).
>>
>> I don't see any errors in these logs that would indicate a metadata iss=
ue,
>> but huge numbers of messages are suppressed.  Perhaps a log closer
>> to the moment when the filesystem goes read-only will be more useful.
>>
>> I would expect that if there are no problems on sda1 or sdb1 then it
>> should be possible to repair the metadata errors on sdd1 by scrubbing
>> that device.
>>
>>> Kind regards
>>> Carsten Grommel
>>>
