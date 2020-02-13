Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9BF15BFF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 15:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgBMOCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 09:02:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:52083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgBMOCZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 09:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581602543;
        bh=TtEj4rw6sldN9tXNhxMrTQrcxZS1RTnRLMGUrHrjs/M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UpGso3Y5cflNbWZoyX9QOOAfgk0VVTSkDwv4VtfBNCJg/2z70PpwLP/raK4WBgnXO
         pczCFeGuqIZ17loydSByWid8i9aW33vzdShPjG1iEE1kbkOfXd1+PsYNiHKpJ0xjzd
         OXTfys958TK5RlTbD309Vy4dfHzhs0beKeNk7IoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.19.20] ([77.191.236.84]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1il7cr0aqQ-00I9RE; Thu, 13
 Feb 2020 15:02:23 +0100
Subject: Re: tree-checker read time corruption
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <5b974158-4691-c33e-71a7-1e5417eb258a@gmx.de>
 <e35d0318-4d3e-50ce-55b1-178e235e89d7@gmx.com>
 <14db7da5-dc42-90e6-0743-b656ff42a976@gmx.de>
 <5037cdd7-8d10-bc2b-195d-59c5929c0c50@gmx.com>
From:   telsch <telsch@gmx.de>
Message-ID: <d250e7c2-76d4-1369-e440-c72370035842@gmx.de>
Date:   Thu, 13 Feb 2020 15:02:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5037cdd7-8d10-bc2b-195d-59c5929c0c50@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HDCNS0M0klchgyrAnDQCu96HuE18aesVXtq5pnEv15e8va1WeUo
 M4s6lgVYMynO/sIvu4ms+4Mh1FNAWiKpY6TD2xWnUi2/Xy1DlNREtLirlyYxeIEdwBFvV/O
 nrDVksW+dhaq5A/Wk/pxUHYI5EReeZfNIlAU2hwm+wk8glwc3eLsRmpo1IxhlqbFzaEnln8
 u0yX2MGMXWVS9fRJ6NXlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cqGt2Cc6o7M=:2QBiws2Qrlo1mipOrTWdOS
 rs00MPWq0cbQoXJ8SrVaB/ZRcZRN+bYgQywvDLYbo5GxQuptZ9mP952j8ZT1JlRZzSHcw2z0X
 MvaMsMmFWt9enwkr5MnKEM5Mc/e0EYsPto74woqHn+fXbBYCBpkJxN3bwNGV4P5j9BwQ4Etuz
 v/zULGtFjbnIIQ0C1OejbsRQczGol4KDHEH8hEJM8YJD3paHc2n8fUmNrSG8mXUkMfZ1mCz3+
 hGKu+VWbgfq4Lz0dpkj0bfJu+ra3OMhTbghYnZM2YqwB8ZKiHnjFInWOBrXtYiaicdml83ulM
 TD7CQe2wfS6X4LZfgkVH53Ra6qUDBCNSkB9zxOJuBYKEVOJTTLlyNpH1m/vxd6yGWseImsL3n
 GzzplFnfq+HjcqSY3uDX1cffjh5in6IGaOk1rXDIcWNiGVUY8mNnT8UUthvUe32RaKRjLY9jy
 o7Jhr6gDHPddWkszoqnK/bP//NdGwRhcwHMSlz5NZ86L8DKaFTDmuWo85rurdIJjexFRVHQpE
 SzoxD9cI/RSfaOp8makbTNC8mTPOxRIAoE++B1tyga56KzxIo9CF92td0rvdGempVXBUG/jvA
 rsZ45IGQ/kaLlnp74YiYU1eIUZ12Twg3ULfiPJv+7ebSMrdvnbXQ3wkRfVJFUcDqRw9STGCGr
 KjnlSEAZKiXIOGipgy+Wrku7EjqJQOKdj4bdbuOi0rLOt8jU0cWLt8FunA2SAJJo1hKp9qPYW
 v28nEpC1baOz8fyePq/G/DToB1xNnlE0JQpDbokQ1yWuzfS7z5iV36SHsJrYML/8VakBDI817
 QFCuO110IBc7YwJ4x1D7EbYh9uoc7Pg5GKs9hQZDkYUvtTbEmomRlbF+j4QyTkztztP5+CEgo
 eEqHYtJ2rWewajF37Rxdjbe8kfxHTSrJ3+z2D4VinDvydG4baUS6tuWl2Lzho4If8yL9V/q+Z
 g8LVn16aAuBQEZdjty0B1ZUPGBdz9pRWCqoATaIRy8HnXJQ/iY7/XW7B6KchmoS/hxDlJidYe
 ucBHx0CRIK9zns6bDnqJnhiKBUz0ggJcrRCdG9/sd9YF617Pe3qxmdifMbE9+PQU1RGXCmNyX
 Y9RyjdCXFS0vG+Db6UkMpRnC/RFSDMYnx04zcmfR8mABKI8ufisgu/8bIu2Sk51Brp0EosN4m
 AF7g/ug/JMu+v/2gm1P3UfPhrULwOTzN4H1uq/4Xy+HNckLXNVyPGJ36YqNl4aX42Nw3ynCXj
 NLDOltFprk/q1M/+D
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/13/20 1:24 AM, Qu Wenruo wrote:
>
>
> On 2020/2/12 =E4=B8=8B=E5=8D=8810:20, telsch wrote:
>>
>>
>> On 2/12/20 1:41 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/2/11 =E4=B8=8B=E5=8D=8810:17, telsch wrote:
>>>> Dear devs,
>>>>
>>>>
>>>>
>>>> after upgrading from kernel 4.19.101 to 5.5.2 i got read time tree bl=
ock
>>>> error as
>>>>
>>>> described here:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 https://btrfs.wiki.kernel.org/index.php/Tre=
e-checker#For_end_users
>>>>
>>>>
>>>>
>>>> Working with kernel 4.19.101:
>>>>
>>>>
>>>>
>>>> Linux Arch 4.19.101-1-lts #1 SMP Sat, 01 Feb 2020 16:35:36 +0000 x86_=
64
>>>> GNU/Linux
>>>>
>>>>
>>>>
>>>> btrfs --version
>>>>
>>>> btrfs-progs v5.4
>>>>
>>>>
>>>>
>>>> btrfs fi show
>>>>
>>>> Label: none=C2=A0 uuid: 56e753f4-1346-49ad-a34f-e93a0235b82a
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS =
bytes used 92.54GiB
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=
=C2=A0 1 size 95.14GiB used 95.14GiB path /dev/mapper/home
>>>>
>>>>
>>>>
>>>> btrfs fi df /home
>>>>
>>>> Data, single: total=3D94.11GiB, used=3D91.95GiB
>>>>
>>>> System, single: total=3D31.00MiB, used=3D12.00KiB
>>>>
>>>> Metadata, single: total=3D1.00GiB, used=3D599.74MiB
>>>>
>>>> GlobalReserve, single: total=3D199.32MiB, used=3D0.00B
>>>>
>>>>
>>>>
>>>> After upgrading to kernel 5.5.2:
>>>>
>>>>
>>>>
>>>> [=C2=A0=C2=A0 13.413025] BTRFS: device fsid 56e753f4-1346-49ad-a34f-e=
93a0235b82a
>>>> devid 1 transid 468295 /dev/dm-1 scanned by systemd-udevd (417)
>>>>
>>>> [=C2=A0=C2=A0 13.589952] BTRFS info (device dm-1): force zstd compres=
sion, level 3
>>>>
>>>> [=C2=A0=C2=A0 13.589956] BTRFS info (device dm-1): disk space caching=
 is enabled
>>>>
>>>> [=C2=A0=C2=A0 13.594707] BTRFS info (device dm-1): bdev /dev/mapper/h=
ome errs: wr
>>>> 0, rd 47, flush 0, corrupt 0, gen 0
>>>>
>>>> [=C2=A0=C2=A0 13.622912] BTRFS info (device dm-1): enabling ssd optim=
izations
>>>>
>>>> [=C2=A0=C2=A0 13.624300] BTRFS critical (device dm-1): corrupt leaf: =
root=3D5
>>>> block=3D122395779072 slot=3D10 ino=3D265, invalid inode generation: h=
as
>>>> 18446744073709551492 expect [0, 468296]
>>>
>>> An older kernel caused underflow/garbage generation.
>>> Much strict tree checker is detecting it and rejecting the tree block =
to
>>> prevent further corruption.
>>>
>>> It can be fixed in by btrfs-progs v5.4 and later, by using 'btrfs chec=
k
>>> --repair'
>>>
>>> Early btrfs-progs can't detect nor fix it.
>>>
>>> Thanks,
>>> Qu
>>>
>>
>> As you suggest booting to kernel 5.5.3 with btrfs-progs v5.4 and run
>> 'btrfs check --repair'. But didn't fix this error.
>>
>> mount: /home: can't read superblock on /dev/mapper/home.
>> [=C2=A0 325.121475] BTRFS info (device dm-1): force zstd compression, l=
evel 3
>> [=C2=A0 325.121482] BTRFS info (device dm-1): disk space caching is ena=
bled
>> [=C2=A0 325.126234] BTRFS info (device dm-1): bdev /dev/mapper/home err=
s: wr
>> 0, rd 47, flush 0, corrupt 0, gen 0
>> [=C2=A0 325.143521] BTRFS info (device dm-1): enabling ssd optimization=
s
>> [=C2=A0 325.146138] BTRFS critical (device dm-1): corrupt leaf: root=3D=
5
>> block=3D122395779072 slot=3D10 ino=3D265, invalid inode generation: has
>> 18446744073709551492 expect [0, 469820]
>> [=C2=A0 325.148637] BTRFS error (device dm-1): block=3D122395779072 rea=
d time
>> tree block corruption detected
>
> According to the repair log, btrfs-progs doesn't detect it at all.
> Thus I'm not sure if it's a bug in btrfs-progs or it's just not newer
> enough.
>
> Anyway, you can delete inode 265 manually using older kernel.
>
> Thanks,
> Qu

Thanks for support. Deleting inode 265 manually fixed this mount issue
with kernel >=3D 5.2 for me.

>>
>>>>
>>>> [=C2=A0=C2=A0 13.624381] BTRFS error (device dm-1): block=3D122395779=
072 read time
>>>> tree block corruption detected
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> Booting from 4.19 kernel can mount fs again.
>>>
>
