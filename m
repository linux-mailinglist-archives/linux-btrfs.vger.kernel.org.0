Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C372419D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgHKKil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 06:38:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:33335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgHKKih (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 06:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597142312;
        bh=END/xOABefdS2wxVXiDsO8KVvCfC1IrZDQZq9YzOXJU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ABvPuQZyHzsfA+ZqlWnohFM3I7TqVj+amVbePfnT6KewBzAg8CPAGwzx9GH8fpfF8
         JgYHYdcp2WCuCr6TdXiOXqt9BUjWGXnNJbZ25e+jvD9OvZF/Yg0dORNhkDGBghxhbP
         p1sxnh8769vtKTWwTfq7R4x22WvC0Y/h1BxrFgGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1kCTtp1T8Y-00Yh7e; Tue, 11
 Aug 2020 12:38:31 +0200
Subject: Re: BTRFS suddenly moving to read-only
To:     Thommandra Gowtham <trgowtham123@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+XNQ=iupWN6ck5M0hUQ-+470F9PKdoKKUUt+tmQOWoC=zterg@mail.gmail.com>
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
Message-ID: <f8742974-69b2-a0e9-ff99-4c61dc4f9ff0@gmx.com>
Date:   Tue, 11 Aug 2020 18:38:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+XNQ=iupWN6ck5M0hUQ-+470F9PKdoKKUUt+tmQOWoC=zterg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Yt5C4gewvBZ4vl0heQCtQAq5Gkmqz7ljs"
X-Provags-ID: V03:K1:HQnXJI5JB4bRO+9ANmXeE9evSiho1eit5EAhPh+iI+fe58oFLok
 bzt6a0Y+/x1a6aWaAwf0MwvK9O+VyC5m+4w6aLU9WHHlE6LYqivMh2P6Wux9Pov25O92Iqk
 kwXbzuX94PXrdkOI7Aoo6BQ3D/N3tuFkxrzzYnQWZ6hXHpEF4vVCkRwTSyxETX/CGsRa3n+
 cwtOteTkzuoeK24xEmTJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H6UpUVNmHYg=:evkZfxvP9DfbdVxKHLa2rC
 k8213Jtr641lUTaYzUkHalCxJzdy+FIna4IanpPCKifg24l69BsSSOw5ApMVVEHGZsAvJykuP
 w99XazL9xrK/5rYrN9Wvt2pOEEfKGeoHHniTIl0aowQQMrBi/PYYp7IllW6SpoT/YasREdwne
 YujQzviozY/Dtq/uWIMTtQMcz1GQdybxsw8O17jxBrcvLpGo8TVnWsg03BWISqxaRx0/1GN9k
 SkjKlsu/Yu28JT7/fZvzfVSTHigcBHf/xfdAlFqnsiSmEkzvvEZ1xgRCCEUXSBBQzgQTl6PLr
 C2R3nHF6iO+qCD3tHr+0osD0e/oh+0lkfu/7wBsq4pr96vFdc1NhjeoHlzp5hQRat2hwi8+7G
 R7DAqUz84PZcVYxMkzZaI9EgEE/l/GvW2Cb6lAGzX1FmyawhCYKd8QJQOMaD9kHuyYwMh3JEO
 TwvuuQ2j4AIWnINNtsrgG2JigT43J1CDVxoGDJYxe8sRxlcs4NxSqqS7dXw4DSVeoEkHR/e82
 DvqZJo7neW96Hw4NYrhkJ0VKvslR50wq0vFmZXif9wFKAs9vp/zc3wm63yLvxpdX3OT2t7bhV
 nQxxMijWR0pbOn2Y7dZofjln24VUAONxy7QvTNGvwfbZZYyA3/jHzZ26JMQ1XYhahVvDXUrNk
 WT+XigIwjr6scuO0pPtzRoN91Us1CSHJLeRCz9eMFD94xdQo55hnZlW8zzJJz9eaJKrykKGBO
 X2Am/Lm1GmybHI/X/hwwTz/nVPFPx/0zCj1xiJOj48KiX72VB95JzRmf31gFCN+qgT6X7unPb
 Ax3M/sY45KV9WZimmuS5LPaDFMhOJTYYwZBh2AqnCuFVEtSZHt5iZ0j1cDyItMtwTZ6e4qn95
 T1M6BZFle9qNtWJhtf1O9C6YsrM+NbclAuWlOLelHin6oQX2QhKNhsDXWMch7hjVbR/xn64wp
 xGearZslXMEfm7jfl/mIGDLwkuT9zvrQH8oABHw6iDAU8OKPFjE82+JbURUGdk3vzVBnjwsLk
 Fau3ifKKXbphRj87HfXuUDFU0Qy7VdNG7uHXP28fUZfRMuJBVUwaJnARdeREgRBVdsM6cSmPV
 jLWgxvfjOggQIGD21W9yBMSI0HZmBvooAlzzQ/Pg7Wc6BgSzUYQV9MMrp+CivzWVtEZ5grPI9
 Rkg2fuCS0V9rpSw0zSZjv1qsmPNKvg8K39dd0ZjFdOy50DJ9XwjY+t5fjg3pVRd3gLlSBWWHx
 U9bx413LSGbkY0GF0MLvHy6nWI+5u5FeQ4S6XEQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yt5C4gewvBZ4vl0heQCtQAq5Gkmqz7ljs
Content-Type: multipart/mixed; boundary="qs4pxg1veXf9hnnxma5uW3qU54tY1HFcY"

--qs4pxg1veXf9hnnxma5uW3qU54tY1HFcY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/11 =E4=B8=8B=E5=8D=885:39, Thommandra Gowtham wrote:
> Hi,
>=20
> Need some help to understand if there are any issues in BTRFS/Linux Ker=
nel.
>=20
> Running BTRFS as root filesystem and we see that suddenly the entire
> disk is moved to read-only due to errors.
>=20
> Did the SSD run out of life? If yes, then
> - What are the best BTRFS options for frequent small amount of
> writes(log files) on low quality SSD? If we want to increase the life
> of the Disk.

If using systemd, you can config systemd to go memory only journal, so
that the life of the ssd can be expanded.

> - How do we determine the Disk health apart from SMART attributes? Can
> we do a Disk write/read test to figure it out?

AFAIK SMART is the only thing we can rely on now.

>=20
> mount options used:
> rw,noatime,compress=3Dlzo,ssd,space_cache,commit=3D60,subvolid=3D263
>=20
> #   btrfs --version
> btrfs-progs v4.4
>=20
> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
> x86_64 x86_64 x86_64 GNU/Linux
>=20
> mkstemp: Read-only file system
> [35816007.175210] print_req_error: I/O error, dev sda, sector 4472632
> [35816007.182192] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> 66, rd 725, flush 0, corrupt 0, gen 0

This means some read error happened.

Do you have extra log context?

> [35816007.192913] print_req_error: I/O error, dev sda, sector 4472632
> [35816007.199855] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> 66, rd 726, flush 0, corrupt 0, gen 0
> [35816007.210675] print_req_error: I/O error, dev sda, sector 10180680
> [35816007.217748] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> 66, rd 727, flush 0, corrupt 0, gen 0
> [35816007.461941] print_req_error: I/O error, dev sda, sector 4472048
> [35816007.468903] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> 66, rd 728, flush 0, corrupt 0, gen 0
> [35816007.479611] systemd[7035]: serial-getty@ttyS0.service: Failed at
> step EXEC spawning /sbin/agetty: Input/output error
> [35816007.712006] print_req_error: I/O error, dev sda, sector 4472048

This means, we failed to read some data from sda.

It's not the error from btrfs checksum verification, but directly read
error from the device driver.

So the command, agetty can't be executed due to we failed to read the
content of that executable file.

>=20
> # dmesg | tail
> bash: /bin/dmesg: Input/output error
>=20
> Doesn't Input/output error mean the disk is inaccessible?

This means, we can't even access /bin/dmesg the file itself.

>=20
> # btrfs fi show
> Label: 'rpool'  uuid: 42d39990-e4eb-414b-8b17-0c4a2f76cc76
>     Total devices 1 FS bytes used 11.80GiB
>     devid    1 size 27.20GiB used 19.01GiB path /dev/sda4
>=20
> # smartctl -a /dev/sda
> smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-36-generic] (local b=
uild)
> Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools=
=2Eorg
>=20
> Short INQUIRY response, skip product id
> A mandatory SMART command failed: exiting. To continue, add one or
> more '-T permissive' options.
>=20
>=20
> We were able to get smartctl o/p after a power-cycle

Did you get dmesg/agetty run after a power-cycle?

Or it still triggers the same -EIO error?

BTW, if the smartctl doesn't record above read error as error, maybe
it's some unstable cables causing temporary errors?

Thanks,
Qu

>=20
> # smartctl -a /dev/sda
> smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-36-generic] (local b=
uild)
> Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools=
=2Eorg
>=20
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Device Model:     FS032GM242I-AC
> Serial Number:    AA010520170000000489
> Firmware Version: O1026A
> User Capacity:    31,488,000,000 bytes [31.4 GB]
> Sector Size:      512 bytes logical/physical
> Rotation Rate:    Solid State Device
> Device is:        Not in smartctl database [for details use: -P showall=
]
> ATA Version is:   ACS-2 (minor revision not indicated)
> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Sun Aug  9 04:26:10 2020 EDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> ...
> SMART Attributes Data Structure revision number: 1
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
> UPDATED  WHEN_FAILED RAW_VALUE
>   1 Raw_Read_Error_Rate     0x0000   100   100   000    Old_age
> Offline      -       0
>   5 Reallocated_Sector_Ct   0x0000   100   100   000    Old_age
> Offline      -       0
>   9 Power_On_Hours          0x0000   100   100   000    Old_age
> Offline      -       735
>  12 Power_Cycle_Count       0x0000   100   100   000    Old_age
> Offline      -       20
> 160 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       0
> 161 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       58
> 163 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       2
> 164 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       1045371
> 165 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       1075
> 166 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       972
> 167 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       1030
> 168 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       3000
> 169 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       66
> 175 Program_Fail_Count_Chip 0x0000   100   100   000    Old_age
> Offline      -       0
> 176 Erase_Fail_Count_Chip   0x0000   100   100   000    Old_age
> Offline      -       0
> 177 Wear_Leveling_Count     0x0000   100   100   050    Old_age
> Offline      -       3733
> 178 Used_Rsvd_Blk_Cnt_Chip  0x0000   100   100   000    Old_age
> Offline      -       0
> 181 Program_Fail_Cnt_Total  0x0000   100   100   000    Old_age
> Offline      -       0
> 182 Erase_Fail_Count_Total  0x0000   100   100   000    Old_age
> Offline      -       0
> 192 Power-Off_Retract_Count 0x0000   100   100   000    Old_age
> Offline      -       5
> 194 Temperature_Celsius     0x0000   100   100   000    Old_age
> Offline      -       40
> 195 Hardware_ECC_Recovered  0x0000   100   100   000    Old_age
> Offline      -       0
> 196 Reallocated_Event_Count 0x0000   100   100   016    Old_age
> Offline      -       0
> 197 Current_Pending_Sector  0x0000   100   100   000    Old_age
> Offline      -       0
> 198 Offline_Uncorrectable   0x0000   100   100   000    Old_age
> Offline      -       0
> 199 UDMA_CRC_Error_Count    0x0000   100   100   050    Old_age
> Offline      -       0
> 232 Available_Reservd_Space 0x0000   100   100   000    Old_age
> Offline      -       100
> 241 Total_LBAs_Written      0x0000   100   100   000    Old_age
> Offline      -       766189
> 242 Total_LBAs_Read         0x0000   100   100   000    Old_age
> Offline      -       11847
> 245 Unknown_Attribute       0x0000   100   100   000    Old_age
> Offline      -       1045371
>=20
> Regards,
> Gowtham
>=20


--qs4pxg1veXf9hnnxma5uW3qU54tY1HFcY--

--Yt5C4gewvBZ4vl0heQCtQAq5Gkmqz7ljs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8ydSQACgkQwj2R86El
/qhiPgf+Lfg9JLCncIRlCxGp2pZPiuRxHEUIocGgfwCpwwYxG60zHpdqlkf0Br0X
ycnaukTlraU2JO1JmkFIyAZ9CrWcj2wNKqNr6inTdXo/SXePBkIvQroD61xkFvv+
Xk4nZzh2QC0vgIN1uQ0ic8wc5KaV9FGQaGzekZL49cUgJZS06tTaKB7Q2oF7MsTi
pRdvO3Nq0SibMy9EUmMqk/trjMaiYcqTA8Vy1pw0x+Hp3R/rqAuhtk7x2h5fcL8P
AbQL5Oi8z5TfpBbyvTlQpCEqCJW0FZ3gHIIFSIyFuXu/lnn7tEquxnmQPFyld3I/
09TRwRk5nBb3gHIpTET5rTgtMBcaCg==
=MC5w
-----END PGP SIGNATURE-----

--Yt5C4gewvBZ4vl0heQCtQAq5Gkmqz7ljs--
