Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E6235175
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHAJbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 05:31:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:53293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgHAJbM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 05:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596274268;
        bh=ImYcNym0nS+53PlCWild/0rG1sCW3KLJS3WURWFVaiA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N31x8EkDXGRTstnelRJS+zypJSGM1QteFZvBVWoMJchEY5NuF7ja1plp/yucB8hhs
         0Kzbi7n/QOgE8Qiiv2NnMYvpkt8rQCiOHWnhZW3TPtGVrCiMwfFvcDM4Cp7k2oGeoO
         tOmU3UYKptXeyGqCVWvDFbqrhnlNfG/LhzJwsVxs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1k7I1t0tHY-007mVR; Sat, 01
 Aug 2020 11:31:07 +0200
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     Justin Brown <Justin.Brown@fandingo.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
 <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com>
 <4f21b4c4-430e-59eb-068c-231cf3bc492d@gmx.com>
 <CAKZK7uzmg19NDjGPPAxXKu7LJ-7ZdHu2cad22csj_chr2qxMJg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <2061ec67-a5a4-07c6-fe5e-8464feb272aa@gmx.com>
Date:   Sat, 1 Aug 2020 17:31:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKZK7uzmg19NDjGPPAxXKu7LJ-7ZdHu2cad22csj_chr2qxMJg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DvcG3FsvbWQF6yjdATMlIMcrsVDvd6OEe"
X-Provags-ID: V03:K1:NbzozNXU+y4+fKVAMUVyIQQadDIF/fFOhf9LBDOsqnGpq2f8ZvW
 a6CXod15D/bVZC1BLgX6Zx54EsYEWmzytSxgjLd3IX1J/O2m8ffK3ok8qhXYg7Oi1RacWc4
 lI6T+HHkoL+bllUmxRLTZBgup1FPRnMVhuv+m5FoU1utW0WFEZ71Pt0f41FjT3CiBNn9zns
 Hdur7rdBszcwtWD8rwq2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1y3EqyazS0=:SZT+oJsTUqfGoy/MxbwHVU
 EyLIN+pJGz1pReV+OHwIiuxkBI7v9xAlQ8b6xb51W63RLnRrPK/S2IyP1/8RS1xkR144xTPk0
 uNsmxyI8qmgmSQxb7qXwSq71uuq/Zwqs8l5FkdF7qRdQz2TUTVS0Q/7NBJea12kQ/Ga14UMBT
 ka5pT8Sm42RolAvnVkuy/xq/nsITe7C7b2OPEV+vItJOtIIO0CjuXdeuLOoKMZJbXBXbjBM0T
 1/LQYq2sTJ4uJfmAwOh485CS9US9zZJ2wOD/ATklMn+dDLUzvjTFUxCY7IRcEMGYuYvZrtZYA
 uqXGDec5WeyzvVEAcWeQX77VVqYKXBq/9KlgnH8F4Ed3FIfLRMwRH1HTDBZlQaML0fxkmLYed
 dexBkK4n/66vSAJEceq9cHFvw+F9c1rMJYXNChpZJB6lglwGrGwXMKieOTsGGRoAA7IkbmtCg
 b2hZaKhP4WAjWwLofG6x9XFDDm9Y5iC/lPVw2d+gbNw9MugyM7HUrPhX+dNzLJ0aXxNcaBYmH
 wyaJWKFBW4ZYUN7826yHlOSd5418JK0hZFuZsVh6nbnFTArZTDHozwHRMxWo35e7x84u/r8vI
 /jMvzIXko3QuUOvEfcotsDjiR/T1EHqqDkRo9s1TYibjrhhYoB5bH+4SjekzafVA91qJmysFT
 MUv7/yR5Ric8AoOngLqQtXGxcKhGtlDT1PQs/KiycmQPUU8WAnsKo0Meo+51Iml1nl5YIaT3l
 FwGSicEOP+LSBgl8eRaIKAc/tkSWA/G2qURhZN7zzrC6WuSiEM4xQGmNYipOxr3dWcWzw2X8T
 sXv9oIdUP/5kWMMVsGXWyHHSiqKjRAM7LdmuMBMSUSnfOGEqCKljA94GtzGmgeOGFRMjLzjPg
 fwrvrGdeWouuog6BqymeD041lmDAYdCRxENScGJk75LlGS5l4jPm+u4gfRd7UAnglPVi8La7P
 WhZKszvBHYx1fN0HZNO8LhqrYe64ii1G3g3Ld4lb6Wy2bvcRKW0lJJgiOXzA24CwTsbNaEE5r
 x6n/wTrwnLl01WjUNPORgQ0in8mDZ80vwsVPYi1fFrBOdbRxrngg8XbIWq+VQKeZAA4BOClOl
 BidyAbkepNN4Kpqfdl9PpYFhSCxZbzmU/JK7XY+DauPUQ9qfyzCp7Yu6FVueUX16gvhBLEnH/
 uO6HLH9Yp/34CtyQhjEE1fAcbEHBW4kdZZoKT80JO/oQdFyxu1vr8lqsWYdduf/+shJtuzcIb
 HFItlJbB12K0g0TFs6qaTPguAa4r2OnNp9UPWww==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DvcG3FsvbWQF6yjdATMlIMcrsVDvd6OEe
Content-Type: multipart/mixed; boundary="Hvtz8rfPAke8bt6jE8Fcq7gv74d0kG5Xb"

--Hvtz8rfPAke8bt6jE8Fcq7gv74d0kG5Xb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/1 =E4=B8=8B=E5=8D=884:30, Justin Brown wrote:
> Hi Qu,
>=20
> Thanks for the help.
>=20
> Here's is the lsblk -b:
>=20
> NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> sda 8:0 0 2000398934016 0 disk
> =E2=94=94=E2=94=80sda1 8:1 0 2000397868544 0 part
> sdb 8:16 0 8001563222016 0 disk
> =E2=94=94=E2=94=80sdb1 8:17 0 8001562156544 0 part
> sdc 8:32 0 120034123776 0 disk
> =E2=94=9C=E2=94=80sdc1 8:33 0 1048576 0 part
> =E2=94=9C=E2=94=80sdc2 8:34 0 524288000 0 part /boot
> =E2=94=94=E2=94=80sdc3 8:35 0 119507255296 0 part /home
> sdd 8:48 0 8001563222016 0 disk
> =E2=94=94=E2=94=80sdd1 8:49 0 8001562156544 0 part
> sde 8:64 0 2000398934016 0 disk
> =E2=94=94=E2=94=80sde1 8:65 0 2000397868544 0 part
> sdf 8:80 0 2000398934016 0 disk
> =E2=94=94=E2=94=80sdf1 8:81 0 2000397868544 0 part /var/media
> sdg 8:96 1 2000398934016 0 disk
> =E2=94=94=E2=94=80sdg1 8:97 1 2000397868544 0 part
>=20
> The `btrfs ins...` output is quite long. I've attached it as a txt and
> also uploaded it at
> https://gist.github.com/fandingo/aa345d6c6fa97162f810e86c9ab20d6a


Thanks, this already shows some device size difference.

But all of them are in fact just a little smaller than device size, thus
it should be fine.

Another problem I found is, it looks like either size or start of some
partitions are not aligned to 4K.

It may be a problem for 4K aligned hard disks, so it may worthy some
concern after solving the btrfs problem.

Would you please also provide some extra dump?
- btrfs check /dev/sda1
  It should detect any problems I missed

- btrfs ins dump-super <device> | grep dev_item.uuid
  It's a little hard to find which device owns to which device id.
  So we need this dump of each btrfs device to make sure.

Thanks,
Qu


>=20
> Thanks,
> Justin
>=20
> On Sat, Aug 1, 2020 at 2:02 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/8/1 =E4=B8=8B=E5=8D=882:58, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/8/1 =E4=B8=8B=E5=8D=882:51, Justin Brown wrote:
>>>> Hello,
>>>>
>>>> I've run into a strange problem that I haven't seen before, and I ne=
ed
>>>> some help. I started getting generic "input/output" errors on a coup=
le
>>>> of files, and when I looked deeper, the kernel logs are full of
>>>> messages like:
>>>>
>>>>     sd 5:0:0:0: [sdf] tag#29 access beyond end of device
>>>
>>> We had a new fix for trim. But according to your kernel message, it
>>> doesn't look like the case.
>>>
>>> (No obvious tag showing it's trim/discard)
>>>
>>>>
>>>> I've never seen anything like this before with any FS, so I figured =
it
>>>> was worth asking before I consider running the standard btrfs tools.=

>>>> (I briefly started a scrub, but it was going crazy with uncorrectabl=
e
>>>> errors, so I cancelled it.)
>>>>
>>>> Here's my system info:
>>>>
>>>> Fedora 32, kernel 5.7.7-200.fc32.x86_64
>>>> btrfs-progs v5.7
>>>>
>>>> /etc/fstab entry:
>>>> LABEL=3Dmedia /var/media btrfs subvol=3Dmedia,discard 0 2
>>>>
>>>> btrfs fi show /var/media/
>>>> Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
>>>> Total devices 6 FS bytes used 4.68TiB
>>>> devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
>>>> devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
>>>> devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
>>>> devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
>>>> devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
>>>> devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1
>>>>
>>>> btrfs fi df /var/media/
>>>> Data, RAID5: total=3D4.69TiB, used=3D4.68TiB
>>>> System, RAID1C3: total=3D32.00MiB, used=3D304.00KiB
>>>> Metadata, RAID1C3: total=3D6.00GiB, used=3D4.94GiB
>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>
>>>> I can only mount -o degraded now. Here are the logs when mounting:
>>>>
>>>> Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=3Dp=
ts/0
>>>> ; PWD=3D/home/justin ; USER=3Droot ; COMMAND=3D/usr/bin/mount -t btr=
fs -o
>>>> degraded /dev/sda1 /var/media/
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
30
>>>> access beyond end of device
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: I/=
O
>>>> error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 prio
>>>> class 0
>>>
>>> OK, it's read, not DISCARD, thus a completely different problem.
>>>
>>>
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on de=
v
>>>> sdf1, logical block 16, async page read
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>>>> sde1): allowing degraded mounts
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>>>> sde1): disk space caching is enabled
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing
>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>>>> sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt 0=
,
>>>> gen 0
>>>>
>>>> It seems like only relatively recently written files are encounterin=
g
>>>> I/O errors. If I `cat` one of the problematic files when the FS is
>>>> mounted normally, I see a ton of this:
>>>>
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
26
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
27
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
28
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
29
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
30
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
0
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
1
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
13
>>>> access beyond end of device
>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#=
2
>>>> access beyond end of device
>>>>
>>>> Now that I'm remounted in -o degraded, I'm getting more comprehensib=
le
>>>> warnings, but it still results in I/O read failures:
>>>>
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f998=

>>>> expected csum 0xbe3f80a4 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f998=

>>>> expected csum 0x9c36a6b4 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f998=

>>>> expected csum 0x44d30ca2 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f998=

>>>> expected csum 0xc0f08acc mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f998=

>>>> expected csum 0xcb11db59 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f998=

>>>> expected csum 0x8a4ee0aa mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f998=

>>>> expected csum 0xdfb79e85 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f998=

>>>> expected csum 0xc14921a0 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f998=

>>>> expected csum 0xf2fe8774 mirror 2
>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
>>>> sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f998=

>>>> expected csum 0xae1cafd6 mirror 2
>>>>
>>>> Why trying to research this problem, I came across a Github issue
>>>> https://github.com/kdave/btrfs-progs/issues/282 and a patch from Qu
>>>> from yesterday ([PATCH] btrfs: trim: fix underflow in trim length to=

>>>> prevent access beyond device boundary). I do use the discard mount
>>>> option, and I have a weekly fstrim.timer enabled. I did replace 2x2T=
B
>>>> drives with the 2x8TB drives about 1 month ago, which involved a
>>>> conversion to -d raid5 -m raid1c3, which I suppose could hit the sam=
e
>>>> code paths that resize2fs would?
>>>
>>> The problem doesn't look like a trim one, but more likely some device=

>>> boundary bug.
>>>
>>> Would you please provide the following info?
>>> - btrfs ins dump-tree -t chunk /dev/sde1
>>>   This contains the device info and chunk tree dump. Doesn't contain
>>>   any confidential info.
>>>   We can use this info to determine if there is some chunk really bey=
ond
>>>   device boundary.
>>>   I guess some chunks are already beyond device boundary by somehow.
>>
>> And `lsblk -b` output.
>>
>> It may be possible that device size in btrfs doesn't match with the re=
al
>> device...
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Any advice on how to proceed would be greatly appreciated.
>>>>
>>>> Thanks,
>>>> Justin
>>>>
>>>
>>


--Hvtz8rfPAke8bt6jE8Fcq7gv74d0kG5Xb--

--DvcG3FsvbWQF6yjdATMlIMcrsVDvd6OEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8lNlQACgkQwj2R86El
/qhbwQf/UMME9GEDX0LL76WAzqPcl2t1yCzVPL/5s9j+VKOf/PpVgcXv5CnvkQL4
2d/kzXlF+uhgAUwR1Vn5NJ2rZL2JUfbfY67j6ncFeonrxkzekD2gxiFffoVAAbD3
yamcBxiA7Vsis0SFiByZshanMFx+8IhF4XbSDmsvkyTLGZ/O2xyUtNiguxSzzbgn
nh9e+quumGPIaPOVI8Y5kKPyWc9lQcjlDE5T05bCghhC/Ms6TPmgQOrHqBQN9kcw
PWdme4hTiPA+HFuUMpxeoI1a5VezoDRKPvD+3zqUeGo67Ot/7cdUopXBMsDbLGtw
GrqEmBs8kWtsr1yW9pcMxX8k4Mpb1g==
=gyOh
-----END PGP SIGNATURE-----

--DvcG3FsvbWQF6yjdATMlIMcrsVDvd6OEe--
