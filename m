Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED84433649
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhJSMtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 08:49:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:60201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSMtA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 08:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634647606;
        bh=oP9YD7yoSqZgGQ6PNyPyVD9wit8To3n9LyUkYEDUl8k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eGqqJIUfSZrDtWcPE0crOT2C4SjG4iCyDbRdYRPsXtU6h3ARIenTmxXTBmyV4WFw+
         VkCYNnZTMm3FdeT50UYLuUdPX79lnIrJggeulfOcnKIiuIRrVn4oAcscZbygLdlzbm
         p2gXwfo56m0rR9XscK0SlQg91pRNYSpFYJSSsbhE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnpns-1n4f8h1Tkg-00pJG9; Tue, 19
 Oct 2021 14:46:46 +0200
Message-ID: <c237d0ab-c223-eeb9-ce3f-21a27b8b88a8@gmx.com>
Date:   Tue, 19 Oct 2021 20:46:42 +0800
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
 <5d8df74b-6094-de7d-1b47-885126cf4bc6@gmx.com>
 <0e218606-5e07-4d7d-b81f-519895af2dfa@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <0e218606-5e07-4d7d-b81f-519895af2dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dJeu/9FN7Fj/IPVZSPmuvqSsA2oTPfW5mC7XnfXcrbWpf345jXw
 47ZXunwRsiGdVzc7HUPrwaGaV0tQiCwEnjnTv5jvdF5JiPeeLx5kbB9XgfS/+5xTkrGTuvD
 Dh7H30Kpqe1cQCQYapkdKldEC8RmlkoBp5R1uLnkLdIqYWTl4QJ2WCnTg3tI7FkeWVnHsAp
 RyC1PT/sNokxufma+TKCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qL50U5XL7Yw=:8kBfOZMt9RH/hotJekl83k
 vn31mP+9sHgWPgkP1hhWXOouzLPhmm3wk8nYOqNl2ulMKThREpPsOPwf5KeCjiQB+1EqsGyo3
 CKfaaktXptTsJWEWuKQxrzW+fzaEQNVmg6VG6hdr4j48SHRvYOX4JlnjGi7ckEfzNW3r3q8Ww
 oA+svfgoCrvLXZSrrnZF7uiy8VjKkT8YnuohYCdFpn3lcg62L3cMRk4Gen0eGO129IMIs73+l
 0AUcMcH8LU/em2tb1GF6As8Mfy9XLK7uuSwzSfhy9FvkTobUn5cQ+JhZDrA8kdOEQs+d+WDDF
 RXMQOmViqNI4rgC3bGrQFF2hsSKPIhpqoKdbsti4VYovSJ5N55KhjLs6ZFKMnSs1wABQnbMUa
 +fXW9/hNrw09WD+oehttfYI6XMD/53htqhPVSOpe3D9AeouR35DM4oH/Ug2aqnVD0Ork2tEXr
 RZGz5QGSPfJfZJt2kOjX/QeMEfJl4c+bJaXXZ6n5Lrq6EOXI78azWdPJUdKic7l7XvQMplkXc
 NLjUI3px3oY4GYpeb5gr7dqbP3lGfFCPp0QtvNc7iw497h5CdOzd26cMRG4GNe8uRKO/zqDp7
 5VyKymz8oYd5jIUqgxoSshbOU0+y1UOUR3el0WK+QV2YCxDYRRs7fUbwHFWtpYJ8MhMSsuX65
 Ra5mjqiraXVZzeoBL7/DH0iD1WrQilZ/QWeJY6PQFOpVwGoMl5ckKyO9mQ0KKZDRP++V0H+46
 SXQI33EQk4XXP3dwL5D6zOtcE8+TDjtBj7TNvGp+baXXkYcb7pmo7iBBpFzA4PxT570puDWzp
 tbIRJC6OC/kFfJnhn3CngesVSmw3XbmPIuvVqNFFeGDj7+suO7WSPPYPmz01dtnSNKoHJ691V
 CPPvKGRZAkhWDLU/TVU9Xozl13w4gni61ZR0OBZ8Zz6XR/P6bQ1s3b1vbGwxk9vz8XPab8wLH
 77WHo8QDqkObP8l4gGQu2zCeQNND+aH3iOMSb8zkoR7aDxssmrYe10fSRrttJ8i8AFcTV0+3g
 L2nhpeOQ7oIseNGoF3wf0IlYGVXX2pkZEEEc36xmfNvc7+QThaY07VA5Qz1HukYp4vpgOjIOh
 5sbOABWtTCo6fE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/19 20:38, Emil Heimpel wrote:
> So it finished after 2 minutes?
>
> [Tue Oct 19 14:13:51 2021] BTRFS info (device sde1): continuing dev_repl=
ace from <missing disk> (devid 1) to target /dev/sde1 @74%
> [Tue Oct 19 14:15:39 2021] BTRFS info (device sde1): dev_replace from <m=
issing disk> (devid 1) to /dev/sde1 finished

Then this means it previously only have the dev replace status not
cleaned up.

Thus it ends pretty quick.
>
>
> Now I at least have an expected filesystem show:
>
> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes use=
d 20.96TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 7.28TiB used 5.46TiB path /dev/sde1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 7.28TiB used 5.46TiB path /dev/sdb1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 2.73TiB used 2.73TiB path /dev/sdg1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 si=
ze 2.73TiB used 2.73TiB path /dev/sdd1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 si=
ze 7.28TiB used 4.81TiB path /dev/sdf1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 si=
ze 7.28TiB used 5.33TiB path /dev/sdc1
>
> And a nondegraded remount worked too.

And it's time for a full fs scrub to find out how consistent the fs is.

For btrfs RAID56, every time a unexpected shutdown is hit, a scrub is
strongly recommended.

And even routine scrub would be a plus for btrfs RAID56.

Thanks,
Qu

>
> Thanks,
> Emil
>
> Oct 19, 2021 14:20:21 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>>
>>
>> On 2021/10/19 20:16, Emil Heimpel wrote:
>>> Color me suprised:
>>>
>>>
>>> [74713.072745] BTRFS info (device sde1): flagging fs with big metadata=
 feature
>>> [74713.072755] BTRFS info (device sde1): allowing degraded mounts
>>> [74713.072758] BTRFS info (device sde1): using free space tree
>>> [74713.072760] BTRFS info (device sde1): has skinny extents
>>> [74713.104297] BTRFS warning (device sde1): devid 1 uuid 51645efd-bf95=
-458d-b5ae-b31623533abb is missing
>>> [74714.675001] BTRFS info (device sde1): bdev (efault) errs: wr 52950,=
 rd 8161, flush 0, corrupt 1221, gen 0
>>> [74714.675015] BTRFS info (device sde1): bdev /dev/sdb1 errs: wr 0, rd=
 0, flush 0, corrupt 228, gen 0
>>> [74714.675025] BTRFS info (device sde1): bdev /dev/sdc1 errs: wr 0, rd=
 0, flush 0, corrupt 140, gen 0
>>> [74751.033383] BTRFS info (device sde1): continuing dev_replace from <=
missing disk> (devid 1) to target /dev/sde1 @74%
>>> [bluemond@BlueQ ~]$ sudo btrfs replace status=C2=A0 -1 /mnt/btrfsrepai=
r/
>>> 74.9% done, 0 write errs, 0 uncorr. read errs
>>>
>>> I guess I just wait?
>>
>> Yep, wait and stay alert, better to also keep an eye on the dmesg.
>>
>> But this also means, previous replace didn't really finish, which may
>> mean the replace ioctl is not reporting the proper status, and can be a
>> possible bug.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>>
>>>>
>>>> On 2021/10/19 18:49, Emil Heimpel wrote:
>>>>>
>>>>> Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>
>>>>>>
>>>>>>
>>>>>> On 2021/10/19 11:54, Emil Heimpel wrote:
>>>>>>> =E2=80=A6
>>>>>>
>>>>>> Any dmesg of that time?
>>>>>>
>>>>>
>>>>> Nothing after the replace finished:
>>>>>
>>>>> 1634463961.245751 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 17663044222976 for dev (efault)
>>>>> 1634463961.255819 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 17663045795840 for dev (efault)
>>>>> 1634463961.275815 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 17663046582272 for dev (efault)
>>>>> 1634463961.275922 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 17663047368704 for dev (efault)
>>>>> 1634463961.339074 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 17663048155136 for dev (efault)
>>>>> 1634463961.339248 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 17663048941568 for dev (efault)
>>>>
>>>> *failed*...
>>>>
>>>>> 1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!sc=
md(0x0000000046fead3f), outstanding for 7120 ms & timeout 7000 ms
>>>>> 1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA c=
ommand pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
>>>>> 1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sa=
s_address(0x4433221105000000), phy(5)
>>>>> 1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical =
id(0x590b11c022f3fb00), slot(6)
>>>>
>>>> And ATA commands failure.
>>>>
>>>> I don't believe the replace finished without problem, and the involve=
d
>>>> device is /dev/sdd.
>>>>
>>>>> 1634475910.787911 BlueQ kernel: sd 9:0:2:0: task abort: SUCCESS scmd=
(0x0000000046fead3f)
>>>>> 1634475910.807083 BlueQ kernel: sd 9:0:2:0: Power-on or device reset=
 occurred
>>>>> 1634475949.877998 BlueQ kernel: sd 9:0:2:0: Power-on or device reset=
 occurred
>>>>> 1634525944.213931 BlueQ kernel: perf: interrupt took too long (3138 =
> 3137), lowering kernel.perf_event_max_sample_rate to 63600
>>>>> 1634533791.168760 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 22996545634304 for dev (efault)
>>>>> 1634552685.203559 BlueQ kernel: BTRFS error (device sdb1): failed to=
 rebuild valid logical 23816815706112 for dev (efault)
>>>>
>>>> You won't want to see this message at all.
>>>>
>>>> This means, you're running RAID56, as btrfs has write-hole problem,
>>>> which will degrade the robust of RAID56 byte by byte for each unclean
>>>> shutdown.
>>>>
>>>> I guess the write hole problem has already make the repair failed for
>>>> the replace.
>>>>
>>>> Thus after a successful mount, scrub and manually file checking is
>>>> almost a must.
>>>>
>>>>> 1634558977.979621 BlueQ kernel: BTRFS info (device sdb1): dev_replac=
e from <missing disk> (devid 1) to /dev/sde1 finished
>>>>> 1634560793.132731 BlueQ kernel: zram0: detected capacity change from=
 32610864 to 0
>>>>> 1634560793.169379 BlueQ kernel: zram: Removed device: zram0
>>>>> 1634560883.549481 BlueQ kernel: watchdog: watchdog0: watchdog did no=
t stop!
>>>>> 1634560883.556038 BlueQ systemd-shutdown[1]: Syncing filesystems and=
 block devices.
>>>>> 1634560883.572840 BlueQ systemd-shutdown[1]: Sending SIGTERM to rema=
ining processes...
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>> =E2=80=A6
>>>>>>
>>>>>> And dmesg for the failed mount?
>>>>>>
>>>>>
>>>>> Oops, I must have missed that it failed because of missing devid 1 t=
oo...
>>>>>
>>>>> 1634562944.145383 BlueQ kernel: BTRFS info (device sde1): flagging f=
s with big metadata feature
>>>>> 1634562944.145529 BlueQ kernel: BTRFS info (device sde1): force zstd=
 compression, level 2
>>>>> 1634562944.145650 BlueQ kernel: BTRFS info (device sde1): using free=
 space tree
>>>>> 1634562944.145697 BlueQ kernel: BTRFS info (device sde1): has skinny=
 extents
>>>>> 1634562944.148709 BlueQ kernel: BTRFS error (device sde1): devid 1 u=
uid 51645efd-bf95-458d-b5ae-b31623533abb is missing
>>>>> 1634562944.148764 BlueQ kernel: BTRFS error (device sde1): failed to=
 read chunk tree: -2
>>>>> 1634562944.185369 BlueQ kernel: BTRFS error (device sde1): open_ctre=
e failed
>>>>
>>>> This doesn't sound correct.
>>>>
>>>> If a device is properly replaced, it should have the same devid numbe=
r.
>>>>
>>>> I guess you have tried to add a new device before, and then tried to
>>>> replace the missing device, right?
>>>>
>>>>
>>>> Anyway, have you tried to mount it degraded and then remove the missi=
ng
>>>> device?
>>>>
>>>> Since you're using RAID56, I guess degrade mount should work.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> =E2=80=A6
>>>>>
