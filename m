Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C62422AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 00:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgHKW6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 18:58:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:41919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgHKW63 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 18:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597186706;
        bh=1mmK1wxjrtA+coIpH/DY6DbUK4yhsXmyT8bQWScPRsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VKRtz2HSkGcDdHD2YuFbfm62QWI8EusGlf07LksYSQBOukLRkWmJZzzFLXlM0i30P
         7LwoYjXntaDtyPeSHAA1fIrAB0cfNQayAE/oOHXdprqxMZ95RYvfkM1tocSDU2frQm
         Pb6kPjbYSg0hcYfEp2b6aI7DnPwNLLwmUf1d0Q6g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdefD-1kegzY46AT-00ZclG; Wed, 12
 Aug 2020 00:58:26 +0200
Subject: Re: BTRFS suddenly moving to read-only
To:     Thommandra Gowtham <trgowtham123@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CA+XNQ=iupWN6ck5M0hUQ-+470F9PKdoKKUUt+tmQOWoC=zterg@mail.gmail.com>
 <f8742974-69b2-a0e9-ff99-4c61dc4f9ff0@gmx.com>
 <CA+XNQ=g1WzZ6h+MGETbK34iUyHno_vUcufXiaJ3dKfVva+b=cQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bbaffb9c-8aaf-1f21-d2a3-2b89bf37c248@gmx.com>
Date:   Wed, 12 Aug 2020 06:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+XNQ=g1WzZ6h+MGETbK34iUyHno_vUcufXiaJ3dKfVva+b=cQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IgPrpk2Yi7k8TrRkN0hBeZzdUrLl0wlFZ"
X-Provags-ID: V03:K1:yE/b1v4WdtP4gliPOSjvDZo9F0OtLziMq8pn7WH20GxHE5zYUK8
 Uuo+4//rWvCPgNzTpLl5rI+Vk2z5AdOeJEkRnJYChZGZaSEJZysRh5N+GMzhcL1h7q51tFv
 NtWKT5NwFUdZsfrRWPxxU+te2rbExaSLg1NVk7yP3x0OfIxOktCs810viB1UH0lkCcGvrzw
 BTSEMbD92+JtEufnt5XAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ALSFSjeyTBE=:3iY6AyZZAoaE0mmICvBAIr
 LiXfOlrFQ4DXFmGWHbBKlHQyBIGg8jOj97KXD+pJr3wuic5wdMcsKwKm32E/VPfCa5T6UkjUS
 rKwVp1VECgw102DI3Hkl0s5nFHy7AIc4HVUMdJkmZf3KbHsG0tKF7iqEuTQhwVSSJYwdcxmGt
 sfnELNrOj1TmEPQjNdMNoZfcc9ofIvqNSxJ3mUIAvcpR++kBIPj7tePuy6uqj/siFv5E0S9/I
 VNopuEyqf4bOkGRI3sh1UWDCOcoY4QtbxIKMpzMd3vXGykLtrwuF7VyK3tZ0k3OOfB225KGSF
 pot4bgdO2Qdtc2FtP7aN+pE4yCz2VAt3/SZ88m483E3sBhDp/Dv3FK005m7CQNncgKL5GjwU6
 PZobuD0pIPoFK809VQDsLPvEySx667wIsjUyOoeB4yTyMrsi/wVWS0/pEs/XoaMGKbbiCfUYQ
 MRHwFouEFm1zoJuazepURrvPVTQvxuarYJTJvNZxlvywXOOe3FM7fEvRB/+gOS3C8Akot7loo
 tEaXN336Ad+mTFhaDMja3npr0mqn/t+Gi1uLHKbPeg73d98ONGXNvf+UXN73g6zgE04AM0WD4
 Nn/uAU8nso8mCFqSuMjUG5JitKoB39VfbnVc16Nc/qTxKO7tTd7EdqXBmXFct2dOr2vY+SE3l
 jl0NA7EXpJyexmMbaOFwNb9jBAkOPZflsmYiAK0tDYdvMXOIST64z6ikaW42vUz/anZ5XXOYN
 tmZB48EiW18U1b0SVB/CmRyCT45H3kqv9R7pdJ1dLrnxTDG7CkdsO59ppHavvIHGuiIuXYw4M
 7UUiQMqeNnj8i1diVjyl1nb4iANv25KjAoS0W/YjMEaiVorKYBgoIZxDoi+R6Bm4Bvp9TdLfZ
 qqxn2RT0NW6WkNXv8gqbUt4+RD/MYC+5g0uCJhfCIRattCIXb+5QNjtwXcFrZcUrYYfLqgHuJ
 X7ymUQNwfC6TcCG7O/+NVUFLtKgjNbNuIY6LwKmuk2Dv7vqIM7KNuZsANgQGNeffaodhA7cCU
 QqGb3tqvQKMz5987Qqiabh0f2LoUf1RU9BuhDLKFGF+svE/XioDSg3EIoHyw12tHlGuUFTj/k
 bD4CHNDU2zyIQI7scrdoY37OXHsc98oCl0waH9ybOe4cwy46l+IirhyvMw3FIwPgAIXzd/5RX
 iwJQmUR4WfeG2Vb8oGy2opiqfFQd3KdF7zNnBc1OCi2YuG1ZLoz7FnicKynbeAimuQ6ueZjVY
 fJmvVeT2ZzWxnFJJLBEFQgQdqOqqlawMFJwVJvw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IgPrpk2Yi7k8TrRkN0hBeZzdUrLl0wlFZ
Content-Type: multipart/mixed; boundary="Dczern81InrAHsiHquHKv0YUd0AQCrTXd"

--Dczern81InrAHsiHquHKv0YUd0AQCrTXd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/11 =E4=B8=8B=E5=8D=8811:12, Thommandra Gowtham wrote:
> Thank you for the response.
>=20
>>
>>> - How do we determine the Disk health apart from SMART attributes? Ca=
n
>>> we do a Disk write/read test to figure it out?
>>
>> AFAIK SMART is the only thing we can rely on now.
>=20
> Thank you. The reason I asked the question is sometimes, though SMART
> reports the Percent Life remaining as > 80, we see issues with the
> disk.
> So I was looking if we can use dd or other tools to determine disk
> write speed and compare with the new SSD's. Like below.
>=20
> # dd if=3D/dev/zero of=3D/var/tmp/test1.img bs=3D1G count=3D1 oflag=3Dd=
sync
> 1+0 records in
> 1+0 records out
> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.90537 s, 564 MB/s
>=20
>>
>>>
>>> mount options used:
>>> rw,noatime,compress=3Dlzo,ssd,space_cache,commit=3D60,subvolid=3D263
>>>
>>> #   btrfs --version
>>> btrfs-progs v4.4
>>>
>>> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
>>> x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> mkstemp: Read-only file system
>>> [35816007.175210] print_req_error: I/O error, dev sda, sector 4472632=

>>> [35816007.182192] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
>>> 66, rd 725, flush 0, corrupt 0, gen 0
>>
>> This means some read error happened.
>=20
> Yes. The errors started to occur when we were upgrading the packages.
> Eventually the upgrade failed with read-only filesystem errors.
>=20
>>
>> Do you have extra log context?
>=20
> Not much on this system as we couldn't get anything from syslog after
> power-cycle.
>=20
> But on other instances, we see errors like below
>=20
> # cat syslog | grep error
> Jun 25 13:12:13   kernel: [154559.788764]          res
> 41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154559.821041]          res
> 41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154559.900810]          res
> 41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154559.933070]          res
> 41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154560.016591]          res
> 41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154560.048882]          res
> 41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154560.114361] ata2.00: NCQ disabled due to
> excessive errors
> Jun 25 13:12:13   kernel: [154560.132361]          res
> 41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:13   kernel: [154560.154507] ata2.00: error: { ABRT }

This means the disk has some command failed to be executed.

Full context would help to locate the problem.

> Jun 25 13:12:13   kernel: [154560.164580]          res
> 41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:14   kernel: [154560.339129] ata2.00: error: { ABRT }
> Jun 25 13:12:14   kernel: [154560.346548] print_req_error: I/O error,
> dev sdb, sector 67111040
> Jun 25 13:12:14   kernel: [154560.360192] BTRFS error (device sdb3):
> bdev /dev/sdb3 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Jun 25 13:12:14   kernel: [154560.417322]          res
> 51/04:00:00:08:02/00:00:04:00:00/60 Emask 0x1 (device error)
> Jun 25 13:12:14   kernel: [154560.511036] ata2.00: error: { ABRT }
> Jun 25 13:12:14   kernel: [154560.518434] print_req_error: I/O error,
> dev sdb, sector 67241984
> Jun 25 13:12:14   kernel: [154560.525291] BTRFS error (device sdb3):
> bdev /dev/sdb3 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
>=20
>>
>>> [35816007.192913] print_req_error: I/O error, dev sda, sector 4472632=

>>> [35816007.199855] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
>>> 66, rd 726, flush 0, corrupt 0, gen 0
>>> [35816007.210675] print_req_error: I/O error, dev sda, sector 1018068=
0
>>> [35816007.217748] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
>>> 66, rd 727, flush 0, corrupt 0, gen 0
>>> [35816007.461941] print_req_error: I/O error, dev sda, sector 4472048=

>>> [35816007.468903] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
>>> 66, rd 728, flush 0, corrupt 0, gen 0
>>> [35816007.479611] systemd[7035]: serial-getty@ttyS0.service: Failed a=
t
>>> step EXEC spawning /sbin/agetty: Input/output error
>>> [35816007.712006] print_req_error: I/O error, dev sda, sector 4472048=

>>
>> This means, we failed to read some data from sda.
>>
>> It's not the error from btrfs checksum verification, but directly read=

>> error from the device driver.
>>
>> So the command, agetty can't be executed due to we failed to read the
>> content of that executable file.
>>
>>>
>>> # dmesg | tail
>>> bash: /bin/dmesg: Input/output error
>>>
>>> Doesn't Input/output error mean the disk is inaccessible?
>>
>> This means, we can't even access /bin/dmesg the file itself.
>=20
> Yes. That would technically mean that the Disk is not accessible
> though it is being reported as read-only by 'mount -t btrfs'.
>=20
> If a disk is missing or offline, is it done by kernel (bug) or
> something related to hardware. This is being seen on multiple systems.
> So there has to be some commonality among them and as the disk moves
> to sudden read-only, we are unable to get much logs on all cases.
>=20
> How can we debug these instances? Can you please give some pointers?

I would recommend to setup a netconsole environment to catch all logs.

Then next time you can provide full context about the problem.

>=20
>>
>>>
>>> # btrfs fi show
>>> Label: 'rpool'  uuid: 42d39990-e4eb-414b-8b17-0c4a2f76cc76
>>>     Total devices 1 FS bytes used 11.80GiB
>>>     devid    1 size 27.20GiB used 19.01GiB path /dev/sda4
>>>
>>> # smartctl -a /dev/sda
>>> smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-36-generic] (local=
 build)
>>> Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontoo=
ls.org
>>>
>>> Short INQUIRY response, skip product id
>>> A mandatory SMART command failed: exiting. To continue, add one or
>>> more '-T permissive' options.
>>>
>>>
>>> We were able to get smartctl o/p after a power-cycle
>>
>> Did you get dmesg/agetty run after a power-cycle?
>>
>> Or it still triggers the same -EIO error?
>=20
> No. After power-cycle everything is back to normal(rw mounted) with
> logs not showing any abnormalities.
> Subsequent IO activity(upgrading the packages) was successful as well.

That's tricky, now looks more like a bug in block layer.
Thus netconsole setup is strongly recommended.

>=20
>>
>> BTW, if the smartctl doesn't record above read error as error, maybe
>> it's some unstable cables causing temporary errors?
>=20
>>> 169 Unknown_Attribute       0x0000   100   100   000    Old_age
>>> Offline      -       66
>=20
> The Disk Percent life remaining is at '66' for this system which is
> low in my opinion. Can a disk go offline suddenly when the health
> drops low?

Not sure for the hardware, needs better context to determine though.

Thanks,
Qu

>=20
> Regards,
> Gowtham
>=20
>>
>> Thanks,
>> Qu
>>


--Dczern81InrAHsiHquHKv0YUd0AQCrTXd--

--IgPrpk2Yi7k8TrRkN0hBeZzdUrLl0wlFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8zIo4ACgkQwj2R86El
/qhC5QgAipxBggaitYzVoGLo9ILgKDr/MRAtirUjXTNQJgl/EuwogJR6lG8cndwH
IqIkbFajDwEouUwM2NWU5Mq3gjf2E50PvIg7Kg7cvChU0LNwRhsgHTgB86jiQpP1
HFHwzAaALvkaqg2cHpSU0lvOJXUa9EqCA9nTa9ESnBp6EbH6Ta5tnIAEhpdXbOHy
v6TdrnQ1pqUZxuWJZMNwYKQ0XxXzzkUK+b21kLGjQkMfQjMHfIfWN7oNu/ZyslqU
qwZnfzBaXRGMZL/txbV8bStRGX4W3hogZXBiQKyDOpwGhMTzd9Ovki1RuisITFp0
DOILJOCz1PFLQc2SUFFdHKSWp0p9UQ==
=Cg6q
-----END PGP SIGNATURE-----

--IgPrpk2Yi7k8TrRkN0hBeZzdUrLl0wlFZ--
