Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45104334CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhJSLjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 07:39:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:47679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLjX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 07:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634643429;
        bh=R5jYebjfK2dObs1yde9UIErOrZPW8OqHaA9kE6Andvk=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=gHTxfjaOyM/grGhqXoyNK/jM+Wh6YwPHwQyHF7rR+zyIetjGSvLoxTEe163hYF94h
         C5/YEMZY5ib6oUuGM+qQm+Ujo84Sm4MKEEEycjU9yjNxcv69cGxKbApoYht+7xZNp2
         ihQsvBaqkf1+SWxA3CxtNf37FLUd/137+SK7RNpc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKFu-1mTPl80p1O-009ObZ; Tue, 19
 Oct 2021 13:37:08 +0200
Message-ID: <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
Date:   Tue, 19 Oct 2021 19:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Emil Heimpel <broetchenrackete@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
 <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com>
 <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Errors after successful disk replace
In-Reply-To: <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XMj5s4Qy4zgNZr3vnAXDq6rG2HeN+PpavqkuX+4G5U3vulIFYr9
 g44WfPAWuUwYZdpe68IuuLjL0HqlTxlf1d1rWa/w3Dm0SgNQVJYnHe3zOc6ZrpOkJvRdpOs
 MOA9J4Kz9viuMqmduHi6EAWKIVCac7LXgura82JzE9OpeOSfzyTJPZXxSUDizDxl4/Fp0I2
 mcTUNUeY9IBGgLttGf7qQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kL037ABxopo=:50kXwW2wuhVzH2o7mz+j0R
 retKWfcyNicApzICU1iJU7TZmREnOCi/oMBGQKemE7O9urzSdkqjgeuYSGmN6uycRTDqWyiez
 mU78cWEXRSmBJWcjGokUYmEmJhJsFqX9nhbjaybYdjWcj7HmDrWz7Pnuv7Lh17atZf7pPjuKT
 O7vh7jqabFTLG8hxwB0o0+HPLipdg3yAaf0uNVfAQVZsmcDUdRT0jegdGkwO7DWjIXCn1ti7P
 ZdWFkMHEliAaDU+/Pm+5cRX5JwK+9MBj4M6ujmnsqAVW6bIK/KfsMQi5oUha03Z5H95Ri2u3n
 k5ZbLpRxiC4pyBOj002NflNtIA9Vezyojal2F+/W1Nsn3afK+qYySWgKbzdAHoNmNYa0A3Vbk
 QhXrplbHhKZPCu6KbkYdo7q7lZdZKJztDElh0ZVGc43SoDol7GJn1g97T280+RdmI9eqHUl3Q
 ARgQJsuIH4DZKUqjLOGMjZLrghggDGPMs4OYQw3PFIrcWa4fOIfjtDu3j7k5gyXNv/k652kti
 Cr6NprfUMTBzfzFmfh9btp75bV6rPAZVkZP9bF7gCsrURLeLaUf4uTtKoFV+JtylKRJEpynwo
 DPzLJMLbeqmmSizJdiuohyi25M6fkI23I6ILr5RBwPajm5LKxoXcjVWueFd+V1xL1h86RQU6I
 5VOej28UXbyiGik+JQayXcSwr7sr+XN5WgHdyJ10sgXE8YqMCkJWzNWL+KLGwEsCDrcH6suuy
 Cx8/6GFCKjp7FBX8diq2EODMK0P1F9f+sGN/sMSqnVCQ9ZoRm60Vfo/cXnBKLc9IotQAV67N3
 6xomCjE+NfM59a+cHPWtmY69E6zqOkZ7y+NUy0Wk2fmhHmOjGUhS6900BqyFS/LxxOLV492Hl
 eY9AcPShEcbVGQ/OJjNXF3BIqYPO7u9NLH18iproISzzw6NG5LanIxjeeIz+3wb91E9ArPuTC
 tXBSUEX0wu3fGbnjNZtwq1K5H3zUzjzZoTV6ueLXtBF8jUhe0hr2/FDDAcJCg9N75tMNUFqbr
 TdPoFzCrS2ZbU8Suw/qlce1kW19It+OPGb4M3Etw3OEC12GgNIEwJ22yBrHleAIft4QWYZVZa
 xMErfKoLX+570Y=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/19 18:49, Emil Heimpel wrote:
>
> Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>>
>>
>> On 2021/10/19 11:54, Emil Heimpel wrote:
>>> Hi all,
>>>
>>> One of my drives of a raid 5 btrfs array failed (was dead completely) =
so I installed an identical replacement drive. The dead drive was devid 1 =
and the new drive /dev/sde. I used the following to replace the missing dr=
ive:
>>>
>>> sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/
>>>
>>> and it completed successfully without any reported errors (took around=
 2 weeks though...).
>>>
>>> I then tried to see my array with filesystem show, but it hung (or too=
k longer than I wanted to wait), so I did a reboot.
>>
>> Any dmesg of that time?
>>
>
> Nothing after the replace finished:
>
> 1634463961.245751 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663044222976 for dev (efault)
> 1634463961.255819 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663045795840 for dev (efault)
> 1634463961.275815 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663046582272 for dev (efault)
> 1634463961.275922 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663047368704 for dev (efault)
> 1634463961.339074 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663048155136 for dev (efault)
> 1634463961.339248 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663048941568 for dev (efault)

*failed*...

> 1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!scmd(0=
x0000000046fead3f), outstanding for 7120 ms & timeout 7000 ms
> 1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA comma=
nd pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
> 1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sas_ad=
dress(0x4433221105000000), phy(5)
> 1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical id(0=
x590b11c022f3fb00), slot(6)

And ATA commands failure.

I don't believe the replace finished without problem, and the involved
device is /dev/sdd.

> 1634475910.787911 BlueQ kernel: sd 9:0:2:0: task abort: SUCCESS scmd(0x0=
000000046fead3f)
> 1634475910.807083 BlueQ kernel: sd 9:0:2:0: Power-on or device reset occ=
urred
> 1634475949.877998 BlueQ kernel: sd 9:0:2:0: Power-on or device reset occ=
urred
> 1634525944.213931 BlueQ kernel: perf: interrupt took too long (3138 > 31=
37), lowering kernel.perf_event_max_sample_rate to 63600
> 1634533791.168760 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 22996545634304 for dev (efault)
> 1634552685.203559 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 23816815706112 for dev (efault)

You won't want to see this message at all.

This means, you're running RAID56, as btrfs has write-hole problem,
which will degrade the robust of RAID56 byte by byte for each unclean
shutdown.

I guess the write hole problem has already make the repair failed for
the replace.

Thus after a successful mount, scrub and manually file checking is
almost a must.

> 1634558977.979621 BlueQ kernel: BTRFS info (device sdb1): dev_replace fr=
om <missing disk> (devid 1) to /dev/sde1 finished
> 1634560793.132731 BlueQ kernel: zram0: detected capacity change from 326=
10864 to 0
> 1634560793.169379 BlueQ kernel: zram: Removed device: zram0
> 1634560883.549481 BlueQ kernel: watchdog: watchdog0: watchdog did not st=
op!
> 1634560883.556038 BlueQ systemd-shutdown[1]: Syncing filesystems and blo=
ck devices.
> 1634560883.572840 BlueQ systemd-shutdown[1]: Sending SIGTERM to remainin=
g processes...
>
>
>
>
>>>
>>> It showed up after a reboot as followed:
>>>
>>> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes u=
sed 20.96TiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 0 =
size 7.28TiB used 5.46TiB path /dev/sde1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 =
size 7.28TiB used 5.46TiB path /dev/sdb1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 =
size 2.73TiB used 2.73TiB path /dev/sdg1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 =
size 2.73TiB used 2.73TiB path /dev/sdd1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 =
size 7.28TiB used 4.81TiB path /dev/sdf1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 =
size 7.28TiB used 5.33TiB path /dev/sdc1
>>>
>>> I then tried to mount it, but it failed, so I run a readonly check and=
 it reported the following problem:
>>
>> And dmesg for the failed mount?
>>
>
> Oops, I must have missed that it failed because of missing devid 1 too..=
.
>
> 1634562944.145383 BlueQ kernel: BTRFS info (device sde1): flagging fs wi=
th big metadata feature
> 1634562944.145529 BlueQ kernel: BTRFS info (device sde1): force zstd com=
pression, level 2
> 1634562944.145650 BlueQ kernel: BTRFS info (device sde1): using free spa=
ce tree
> 1634562944.145697 BlueQ kernel: BTRFS info (device sde1): has skinny ext=
ents
> 1634562944.148709 BlueQ kernel: BTRFS error (device sde1): devid 1 uuid =
51645efd-bf95-458d-b5ae-b31623533abb is missing
> 1634562944.148764 BlueQ kernel: BTRFS error (device sde1): failed to rea=
d chunk tree: -2
> 1634562944.185369 BlueQ kernel: BTRFS error (device sde1): open_ctree fa=
iled

This doesn't sound correct.

If a device is properly replaced, it should have the same devid number.

I guess you have tried to add a new device before, and then tried to
replace the missing device, right?


Anyway, have you tried to mount it degraded and then remove the missing
device?

Since you're using RAID56, I guess degrade mount should work.

Thanks,
Qu

>
>> Thanks,
>> Qu
>>>
>>> [...]
>>> [2/7] checking extents
>>> ERROR: super total bytes 38007432437760 smaller than real device(s) si=
ze 46008994590720
>>> ERROR: mounting this fs may fail for newer kernels
>>> ERROR: this can be fixed by 'btrfs rescue fix-device-size'
>>> [3/7] checking free space tree
>>> [...]
>>>
>>> So I followed that advice but got the following error:
>>>
>>> sudo btrfs rescue fix-device-size /dev/sde1
>>> ERROR: devid 1 is missing or not writeable
>>> ERROR: fixing device size needs all device(s) to be present and writea=
ble
>>>
>>> So it seems something went wrong or didn't complete fully.
>>> What can I do to fix this problem?
>>>
>>> uname -a
>>> Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16 +=
0000 x86_64 GNU/Linux
>>>
>>> btrfs --version
>>> btrfs-progs v5.14.2
>>>
>>> Regards,
>>> Emil
>>>
>>> P.S.: Yes, I know, raid5 isn't stable but it works good enough for me =
;)
>>> Metadata is raid1 btw...
>>>
>
