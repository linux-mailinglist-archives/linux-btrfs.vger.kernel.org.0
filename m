Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2B4CF318
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 09:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiCGIBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 03:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiCGIBT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 03:01:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A471BE84
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 00:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646640013;
        bh=65UrsISTWdWmphrlQ4Ht1f5hmPywvzdaTElp8NvApMk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XiSRrxZZfWx5xS8JN8/VZGvNIeFEiJLL9KEvTxIn7dDOXpOHDQJY66U9XS0J5zLka
         t3I180tJa9wMY0wfo//q1u138K2i39/sXMv0GQXkEQKYOJYoIApa9cbd39rg2tcZL8
         CanAsfjKLlMvxplmJJPe6N8mK4MlsyzVHQDixyeY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1nYs4u0ytY-00RcIV; Mon, 07
 Mar 2022 09:00:12 +0100
Message-ID: <b5cdc870-e016-3825-198c-db46a7de7d38@gmx.com>
Date:   Mon, 7 Mar 2022 16:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: AW: AW: AW: How to (attempt to) repair these btrfs errors
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
 <f64a230c-19cb-e842-4569-0828a4d8bd16@gmx.com>
 <AM0PR08MB3265FD23EA7AC3A8BFBC2F968E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <AM0PR08MB3265FD23EA7AC3A8BFBC2F968E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n1voIA4TbstF3s3nqaBTXX5D/nfgGv+K2i1ZWSAMKfcepvm5p+u
 n3Ovm+TgQS+rKPAtLqu730waj4T+K3lpFclgTup0H5g1DheB0rTxbMGp0vlvotdxMSDs/fS
 RkcR7A2YZhcYcR85T5m0ejlUkljrn9p82EHS4bI4LO3flL5OTlrXoFwQws2ZDh7LCKYOXO6
 FLSuEUGpE2T+XU+NCTmoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4jkOp2aga7M=:YdOX8hybL0rcJbU6BtZk5C
 Kvq3figKqyWhhUen2K7GdYKRzwVPhP3C9Z3K+ZVI3ad/iboztMCLvpRElBoERNvIw1W10Sclr
 nERiCVCvK9bPsy6Z3t5aB7LbgDqvuKluhhdk71Qaj9CEMMeQ0/2B8yyxr/hPaUaATpWd3AhUL
 LRfyaV9yl0QXWZWFXLvcZT4vmDVQg6hOYTwopBO0/+XLwUgPtVqYrdVpPpvH4FM9Vxo1Y8XIe
 bBCBqWeqgltMJ/LHh7lDjbDlKyvpW+DL0TEx2bKL2jvYW4pbP6WmSEI+kSSq9fa7WUqkElavW
 o/EaByZ64r+SVw+1R3F8uhZ8z8ce3UoWlJbjdMH1LvFkA9nGOOuVpYcrnnDQBXR0TNQVDj2ki
 Lk7pSvbGWfqzr3hZrIGt7t13ZDMvlfgbftO1O20ejrDm2LwsJRBXdJlRnobZbU3N3ErfbeAeO
 JFRbv+L9D7D+O0MXQx/5uw4Du44n1i3vmb5VGZUHq2Krjhs2VZ9SBhbo1ZJv0BvFifB4UR1XO
 Esq58Nzp9+ADhwObbxAo+rM1yWE3nqDfpdh2zUF0XDo8R/Py2hA+sQ0J5lP1indeNSMHvrF5J
 aEX2rohsfGIixDiHxB50Ae2bIKgzAeFupuFCAYSy5oZgFssuibK/tvaJz4b2BoOJBcLt8owTC
 Rg7NcWYeNdbe/pPOASXHJn4tAUbQHa75jAUXiGSJ/U5q1fwjpp8jsmc5o43ajUAN5Rf5SZroS
 8uLYcL5GdFkGGxzmXwl6QGuULnnmx9pnXL8GbextLvs0qnCbgu/z1JoR2b4wq7BqODxmNUawq
 FQ6tZYkQ5nLytqWqdlZc9NIj+srbZvd4lHtoEP8ycPsHbYGuzwQmBhjfWrAZdJ18Kb+uxD82T
 HH07YCAZdGUM9Jfs35LKXXsRDIGGyDMEcpXrJXK78sxqLWX9g5D2pksjVtUN4tMaJvTv3EDgI
 ibU3Sk5DU9OeKko1nAhSwPrmQ95wlbJFUZlvFlNFRSKii0t/ALTIhFQBjs6jeOV7MobcSTH4r
 0IDFhSenNepoXAL2wk0BDBiTi6o9KCB89otxNKbri23k/myt1Kfw2glKZJ8ogxTuMOHEjZWFk
 dPNxorZ/PPA1W8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/7 15:48, Carsten Grommel wrote:
>
>
>> OK, this explains the reason.
>
>> Some tree blocks in subvolume trees are corrupted, and by the worst
>> possible way, metadata transid mismatch.
>>
>> Although it looks like some metadata read can be repaired, but I guess
>> since btrfs_finish_ordered_io() still failed, it means some can not be
>> repaired.
>>
>> Did the fs go through some split-brain cases? E.g. some devices got
>> degraded mount, then the missing device come back?
>
> Indeed something like this seems to have happened.
> One of the raid6 had two disks failures with one disk being able to rejo=
in the raid.
> This concerned me because in a raid6 there should be no problem with two=
 devices leaving the raid.

Oh, RAID56, it won't end up well due to write hole.

Thus we may have some weird corruption due to write hole then.

> At this point there seemed to be some corruption happening. I suspect th=
at this resonated in some kind of
> corruption loop causing garbage writes during the heavy write io the bac=
kups are causing on the filesystem.
>
>> These seems to be the most critical afaic:
>>
>> Mar  4 01:25:51 cloud8-1550 kernel: [44623.523395] BTRFS critical (devi=
ce sdc1): corrupt leaf: root=3D111550 >block=3D849874468864 slot=3D0 ino=
=3D32633089 file_offset=3D7805042688, invalid compression for file extent,=
 have 15 expect range [0, 3]
>>
>> OK, this would explain the problem much better than the repairable
>> metadata read.
>>
>> There should be no way we have compression type 0xf.
>
>> Mar  4 01:25:51 cloud8-1550 kernel: [44623.527109] BTRFS error (device =
sdc1): block=3D849874468864 read time tree block corruption detected
>> Mar  4 01:25:52 cloud8-1550 kernel: [44623.643308] BTRFS critical (devi=
ce sdc1): corrupt leaf: root=3D50979 block=3D849880268800 slot=3D2, bad ke=
y order, prev (18446744073709551606 128 1269917216768) current (1844674407=
3709551606 128 1269916291
>> 072)
>>
>> And bad tree key order, even more serious.
>>
>> hex(1269917216768) =3D 0x127acf6f000
>> hex(1269916291072) =3D 0x127ace8d000
>>
>> Doesn't look like a simple bitflip, nor does the preivous 0xf
>> compression type.
>>
>> I have no idea how things can be so terribly wrong...
>
> This is where i try to wrap my head around, i just can not explain how t=
his cascade of errors happened
> Do you see a problem in trying to restore as much data as possible with =
btrfs restore / btrfs send | recieve?
> I fear that the corruption could wander, any experiences on this?

For data salvage, the new rescue=3Dall mount option would become pretty
handy I guess.

Thanks,
Qu

>
> Thanks!
>
> ________________________________________
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Gesendet: Montag, 7. M=C3=A4rz 2022 08:34
> An: Carsten Grommel; Zygo Blaxell
> Cc: linux-btrfs@vger.kernel.org
> Betreff: Re: AW: AW: How to (attempt to) repair these btrfs errors
>
>
>
> On 2022/3/7 15:25, Carsten Grommel wrote:
>> Hi Qu,
>>
>>> Mind to share a dmesg just after the RO fallback?
>>
>> the most recent crash:
>>
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.191649] BTRFS error (device =
sdc1): parent transid verify failed on 16155500953600 wanted 126097 found =
94652
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.194011] BTRFS error (device =
sdc1): parent transid verify failed on 16155500953600 wanted 126097 found =
94652
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.195395] BTRFS error (device =
sdc1): parent transid verify failed on 16155500953600 wanted 126097 found =
126097
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.196620] BTRFS error (device =
sdc1): parent transid verify failed on 16155500953600 wanted 126097 found =
126097
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.197920] BTRFS error (device =
sdc1): parent transid verify failed on 16155500953600 wanted 126097 found =
126097
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.212980] BTRFS info (device s=
dc1): read error corrected: ino 0 off 16155500953600 (dev /dev/sde1 sector=
 10546500256)
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.214413] BTRFS info (device s=
dc1): read error corrected: ino 0 off 16155500957696 (dev /dev/sde1 sector=
 10546500264)
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.215204] BTRFS error (device =
sdc1): parent transid verify failed on 16155500953600 wanted 126097 found =
94652
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.215656] BTRFS info (device s=
dc1): read error corrected: ino 0 off 16155500961792 (dev /dev/sde1 sector=
 10546500272)
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.230156] BTRFS: error (device=
 sdc1) in btrfs_finish_ordered_io:2736: errno=3D-5 IO failure
>
> OK, this explains the reason.
>
> Some tree blocks in subvolume trees are corrupted, and by the worst
> possible way, metadata transid mismatch.
>
> Although it looks like some metadata read can be repaired, but I guess
> since btrfs_finish_ordered_io() still failed, it means some can not be
> repaired.
>
> Did the fs go through some split-brain cases? E.g. some devices got
> degraded mount, then the missing device come back?
>
> Thanks,
> Qu
>
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.233127] BTRFS info (device s=
dc1): read error corrected: ino 0 off 16155500965888 (dev /dev/sde1 sector=
 10546500280)
>> Mar  4 01:43:15 cloud8-1550 kernel: [45667.247096] BTRFS info (device s=
dc1): forced readonly
>>
>> ________________________________________
>> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Gesendet: Montag, 7. M=C3=A4rz 2022 08:11
>> An: Carsten Grommel; Zygo Blaxell
>> Cc: linux-btrfs@vger.kernel.org
>> Betreff: Re: AW: How to (attempt to) repair these btrfs errors
>>
>>
>>
>> On 2022/3/7 15:03, Carsten Grommel wrote:
>>> Thank you for the answer. We are using space_cache v2:
>>>
>>> /dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=
=3Dzlib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subv=
ol=3D/,x-systemd.mount-timeout=3D4h)
>>>
>>>> Data is raid0, so data repair is not possible.  Delete all the files
>>>> that contain corrupt data.
>>>
>>> I tried but as soon as I access the broken blocks btrfs fails into rea=
donly so I am kind of in a deadlock there.
>>
>> Btrfs only falls back to RO for very critical errors (which could affec=
t
>> on-disk metadata consistency).
>>
>> Thus plain data corruption should not cause the RO.
>>
>> Mind to share a dmesg just after the RO fallback?
>>
>> Thanks,
>> Qu
>>
>>>
>>>> I don't see any errors in these logs that would indicate a metadata i=
ssue,
>>>> but huge numbers of messages are suppressed.  Perhaps a log closer
>>>> to the moment when the filesystem goes read-only will be more useful.
>>>
>>>> I would expect that if there are no problems on sda1 or sdb1 then it
>>>> should be possible to repair the metadata errors on sdd1 by scrubbing
>>> that device.
>>>
>>> I ran a number of scrubs now, at some point it always fails and btrfs =
remounts into readonly.
>>> I did not yet try to scrub specifically on sdd though, gonna try that.
>>>
>>> Should it remount again i will provide the most recent dmesg's right b=
efore it crashes.
>>>
>>> ________________________________________
>>> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>>> Gesendet: Sonntag, 6. M=C3=A4rz 2022 02:36
>>> An: Carsten Grommel
>>> Cc: linux-btrfs@vger.kernel.org
>>> Betreff: Re: How to (attempt to) repair these btrfs errors
>>>
>>> On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:
>>>> Follow-up pastebin with the most recent errors in dmesg:
>>>>
>>>> https://pastebin.com/4yJJdQPJ
>>>
>>> This seems to have expired.
>>>
>>>> ________________________________________
>>>> Von: Carsten Grommel
>>>> Gesendet: Montag, 28. Februar 2022 19:41
>>>> An: linux-btrfs@vger.kernel.org
>>>> Betreff: How to (attempt to) repair these btrfs errors
>>>>
>>>> Hi,
>>>>
>>>> short buildup: btrfs filesystem used for storing ceph rbd backups wit=
hin subvolumes got corrupted.
>>>> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these R=
aids for performance ( we have to store massive Data)
>>>>
>>>> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x8=
6_64 GNU/Linux
>>>>
>>>> But it was Kernel 5.4.121 before
>>>>
>>>> btrfs --version
>>>> btrfs-progs v4.20.1
>>>>
>>>> btrfs fi show
>>>> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0
>>>>                    Total devices 3 FS bytes used 56.74TiB
>>>>                    devid    1 size 25.46TiB used 22.70TiB path /dev/s=
da1
>>>>                    devid    2 size 25.46TiB used 22.69TiB path /dev/s=
db1
>>>>                    devid    3 size 25.46TiB used 22.70TiB path /dev/s=
dd1
>>>>
>>>> btrfs fi df /vmbackup/
>>>> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB
>>>> System, RAID1: total=3D8.00MiB, used=3D4.36MiB
>>>> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB
>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>
>>>> Attached the dmesg.log, a few dmesg messages following regarding the =
different errors (some informations redacted):
>>>>
>>>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 =
errs: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286
>>>>
>>>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 =
errs: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286
>>>>
>>>> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup=
 (regular) error at logical 776693776384 on dev /dev/sdd1
>>>>
>>>> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callback=
s suppressed
>>>>
>>>> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum erro=
r at logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 10=
8747, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX=
_vm-XXX-disk-X-base.img_1645337735)
>>>>
>>>> I am able to mount the filesystem in read-write mode but accessing sp=
ecific blocks seems to crash btrfs to remount into read-only
>>>> I am currently running a scrub over the filesystem.
>>>>
>>>> The system got rebooted and the fs got remounted 2-3 times. I made th=
e experience that usually btrfs would and could fix these kinds of errors =
after a remount, not this time though.
>>>>
>>>> Before I ran =E2=80=9Cbtrfs check =E2=80=93repair=E2=80=9D I would li=
ke some advice at how to tackle theses errors.
>>>
>>> The corruption and generation event counts indicate sdd1 (or one of it=
s
>>> component devices) was offline for a long time or suffered corruption
>>> on a large scale.
>>>
>>> Data is raid0, so data repair is not possible.  Delete all the files
>>> that contain corrupt data.
>>>
>>> If you are using space_cache=3Dv1, now is a good time to upgrade to
>>> space_cache=3Dv2.  v1 space cache is stored in the data profile, and i=
t has
>>> likely been corrupted.  btrfs will usually detect and repair corruptio=
n
>>> in space_cache=3Dv1, but there is no need to take any such risk here
>>> when you can easily use v2 instead (or at least clear the v1 cache).
>>>
>>> I don't see any errors in these logs that would indicate a metadata is=
sue,
>>> but huge numbers of messages are suppressed.  Perhaps a log closer
>>> to the moment when the filesystem goes read-only will be more useful.
>>>
>>> I would expect that if there are no problems on sda1 or sdb1 then it
>>> should be possible to repair the metadata errors on sdd1 by scrubbing
>>> that device.
>>>
>>>> Kind regards
>>>> Carsten Grommel
>>>>
