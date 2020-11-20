Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC62BAB81
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 14:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgKTNrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 08:47:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:34285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgKTNrg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 08:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605880048;
        bh=Js/Hyq0eYOQV1aaBB3SmnXWoLg+kYtoRiW8hxtRBAhM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aXYTk3nuGUwZBzlxjJ5OucEE1eHYvnKyR92yTjCJIsU0xsj3jmSnBrEpwDjCsA5FL
         w+DpU03D9npsumM05VpY5UU0+wsAWm1yVIzeO9gh5kj8ML521hmzkV/c62uFBlRwkA
         YxnHFdYdq4fzjulHHbehvhokPsCS49fCdZXLQdOw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6Zq-1k2wBn2lKQ-00hgZT; Fri, 20
 Nov 2020 14:47:28 +0100
Subject: Re: corrupt leaf; invalid root item size
To:     Thorsten Rehm <thorsten.rehm@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
 <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com>
 <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
 <1cf994f7-3efb-67ac-d5b1-22929e8ef3fd@gmx.com>
 <CABT3_pxFv0KAjO2DfmikeeT+yN-3BiDj=Mu_a=dC-K9DyL-T3w@mail.gmail.com>
 <b477b613-2190-2c2f-7fab-f9b712ece187@gmx.com>
 <CABT3_pycYRemohAVAbczjre0ruHL_k+pSMBP+ax0Rzcfq2B=BA@mail.gmail.com>
 <CABT3_pxz3hvCx3aKh5vibro1GX3t42kCV5pd=CsL5n+uJSW13w@mail.gmail.com>
 <d88f134b-2728-efb3-5be6-9ed114c27cd8@gmx.com>
 <CABT3_pyOs0G8D5uqJAQXxvQHFanEbniH0fAhntLvf8_hUEY5aw@mail.gmail.com>
 <3235a46e-a3ec-88ba-8343-ef9731194231@gmx.com>
 <CABT3_pzPwxmEeOBDD5OSaCu_qTEN+rTObJmUcsEaPcw3nGUH2Q@mail.gmail.com>
 <CABT3_pwACpykHdL1x9OHN1Zcyc-DiFffN71LJYDWpWUWfGDHRg@mail.gmail.com>
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
Message-ID: <676d0bf2-f7a7-6838-2131-7cc5a3d1517a@gmx.com>
Date:   Fri, 20 Nov 2020 21:47:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABT3_pwACpykHdL1x9OHN1Zcyc-DiFffN71LJYDWpWUWfGDHRg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6iN8QMizvkgKasuyK7tK5HlsDHyM0fDEg"
X-Provags-ID: V03:K1:LiRnAsP00evLYq+hGiLROrjiooC/Ve8Y85IIPxbclPAhWE9Pc29
 ibDFFPyHhSXTHtrcDV1Yc9EGbDpOFj7Ex5nlZvtP73q8e536tltKgLH6NghZMSOFn6itZVM
 FUA8FkWJcTOecxSiPdq5LWW6otKhQ8cu/H73bmZQLhD4Gx2q/q5Vixnl9r6v1bHUfn7AXiq
 4IwbtGQuq/3eNOluULWYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVQbFkeX94k=:tYxayCXwMi3xWdcTgdKT21
 kTDLq25E65IhxOXniZzjx5ZYbk+RmXqhLDWq/GmMMly4ICkz8ViPVp+n8PmUJCsXbO8tNLMTg
 wU2zqLeE+PrkM+vVzYEHb8ECeQI1Cb5picdGwFF52S5qvkUusnocfXxd6LlVf32TLHedJLAfd
 c4V9O0FyEvhtNib1O0Xz9EP02jXfmi9r1+kqEBM42DNLNZkzat1/GILVI8sBfqQmbPXa/+bPB
 p6Ltw68MTccMSZdOuhh/7Ywy702pNkDykSbGWnu7phh1LpUSQ6zuFWyvgGQX/ubPTgbnT3KSW
 jvSm6oLH34wJdgeSQExDLLTMcGW0nukjAl6xMQU1EEtJkFyCkQotOTMEOIk4OPG1JAoaJAIgs
 0pVzzXsV6jPrLgUBEpSTFs/nCpEKPtSn7eLsTS/81CWgDXek87f0/x+kzrtzRaHq+FuW+UE9T
 FFV4sJyTCl4VM+A01dl9fEj/wx1/5Q7YmTlObC26mZbLTjj8Sqn+/EEL/EMKniLtJdxNZ3Ccu
 rP2d+46Rcd8dXmh/VwnXy7o9N1J6gmCFT0gERN03XXTi6Os/MkgsC1javworvSg7vX3Ge/qD/
 ymIFG22CuGxhrPBf0dA1pJLXz13CO4bDkP+CUvN4uBXeKAYsnyOq6angKSzweendHFN39aajW
 YXFGGSvwuvf+IyYIabNsy4NXoKdCC7eOSb4YE+zx2HNSm8W7zTNcY1GIV9xM3tgOuG5HfUkN7
 kL7aXjh8YXenS64b2jAzPNF1tUsbCjwoU8IxRrLb+n4pc4D4v5fAMGjUaXqfpDgfVxFlEfxti
 rf6Q8O9ghnEsYEOn+3Lyw7aIDCjxkSeP2FcUYrsYqgTabJINucrf9xz0CWjdp1x0DLNQw42iN
 KHn2JBoHa6w4533pRVdA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6iN8QMizvkgKasuyK7tK5HlsDHyM0fDEg
Content-Type: multipart/mixed; boundary="2ztkq31Oh7usq600SqCCYAUMpBqohZET5"

--2ztkq31Oh7usq600SqCCYAUMpBqohZET5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/20 =E4=B8=8B=E5=8D=889:17, Thorsten Rehm wrote:
> Hi,
>=20
> I'm very sorry, but I didn't have the time to do the btrfs-image dump.
> I was just about to go back to work on the problem, but first I've
> updated my system and now the problem is gone.
> My system (Debian testing) is running with the latest available kernel
> 5.9.0-2 and btrfs-progs 5.9.
> The last time I updated my system was 60 days ago and at this point
> the problem still existed.
> So, for now, no more corrupt leaf; invalid root item size erros.

Oh, that's because we have located the cause and fixed the false alert.

The fix is this one:
1465af12e254 ("btrfs: tree-checker: fix false alert caused by legacy
btrfs root item")

Some legacy root item can have smaller size than what we have now.
Thanks for another reporter's dump, we fixed it and existing kernels
should receive the backport already.

Thanks,
Qu
>=20
> I just wanted you and others to know.
> Thanks again!
>=20
>=20
> On Tue, 16 Jun 2020 at 07:41, Thorsten Rehm <thorsten.rehm@gmail.com> w=
rote:
>>
>> Yepp, sure.
>> I will do that in the next few days.
>>
>>
>> On Fri, Jun 12, 2020 at 8:50 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>
>>> Would you mind to create a btrfs-image dump?
>>>
>>> It would greatly help us to pin down the cause.
>>>
>>> # btrfs-image -c9 <device> <file>
>>>
>>> Although it may leak sensitive data like file and dir names, you can =
try
>>> -s options to fuzz them since it's not important in this particular
>>> case, but it would cause more time and may cause some extra problems.=

>>>
>>> After looking into related code, and your SINGLE metadata profile, I
>>> can't find any clues yet.
>>>
>>> Thanks,
>>> Qu
>>>
>>>
>>> On 2020/6/8 =E4=B8=8B=E5=8D=8810:41, Thorsten Rehm wrote:
>>>> I just have to start my system with kernel 5.6. After that, the
>>>> slot=3D32 error lines will be written. And only these lines:
>>>>
>>>> $ grep 'BTRFS critical' kern.log.1 | wc -l
>>>> 1191
>>>>
>>>> $ grep 'slot=3D32' kern.log.1 | wc -l
>>>> 1191
>>>>
>>>> $ grep 'corruption' kern.log.1 | wc -l
>>>> 0
>>>>
>>>> Period: 10 Minutes (~1200 lines in 10 minutes).
>>>>
>>>> On Mon, Jun 8, 2020 at 3:29 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>
>>>>>
>>>>>
>>>>> On 2020/6/8 =E4=B8=8B=E5=8D=889:25, Thorsten Rehm wrote:
>>>>>> Hi,
>>>>>>
>>>>>> any more ideas to investigate this?
>>>>>
>>>>> If you can still hit the same bug, and the fs is still completely f=
ine,
>>>>> I could craft some test patches for you tomorrow.
>>>>>
>>>>> The idea behind it is to zero out all the memory for any bad eb.
>>>>> Thus bad eb cache won't affect other read.
>>>>> If that hugely reduced the frequency, I guess that would be the cas=
e.
>>>>>
>>>>>
>>>>> But I'm still very interested in, have you hit "read time tree bloc=
k
>>>>> corruption detected" lines? Or just such slot=3D32 error lines?
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> On Thu, Jun 4, 2020 at 7:57 PM Thorsten Rehm <thorsten.rehm@gmail.=
com> wrote:
>>>>>>>
>>>>>>> Hmm, ok wait a minute:
>>>>>>>
>>>>>>> "But still, if you're using metadata without copy (aka, SINGLE, R=
AID0)
>>>>>>> then it would be a completely different story."
>>>>>>>
>>>>>>> It's a single disk (SSD):
>>>>>>>
>>>>>>> root@grml ~ # btrfs filesystem usage /mnt
>>>>>>> Overall:
>>>>>>>     Device size:         115.23GiB
>>>>>>>     Device allocated:          26.08GiB
>>>>>>>     Device unallocated:          89.15GiB
>>>>>>>     Device missing:             0.00B
>>>>>>>     Used:               7.44GiB
>>>>>>>     Free (estimated):         104.04GiB    (min: 59.47GiB)
>>>>>>>     Data ratio:                  1.00
>>>>>>>     Metadata ratio:              2.00
>>>>>>>     Global reserve:          25.25MiB    (used: 0.00B)
>>>>>>>
>>>>>>> Data,single: Size:22.01GiB, Used:7.11GiB (32.33%)
>>>>>>>    /dev/mapper/foo      22.01GiB
>>>>>>>
>>>>>>> Metadata,single: Size:8.00MiB, Used:0.00B (0.00%)
>>>>>>>    /dev/mapper/foo       8.00MiB
>>>>>>>
>>>>>>> Metadata,DUP: Size:2.00GiB, Used:167.81MiB (8.19%)
>>>>>>>    /dev/mapper/foo       4.00GiB
>>>>>>>
>>>>>>> System,single: Size:4.00MiB, Used:0.00B (0.00%)
>>>>>>>    /dev/mapper/foo       4.00MiB
>>>>>>>
>>>>>>> System,DUP: Size:32.00MiB, Used:4.00KiB (0.01%)
>>>>>>>    /dev/mapper/foo      64.00MiB
>>>>>>>
>>>>>>> Unallocated:
>>>>>>>    /dev/mapper/foo      89.15GiB
>>>>>>>
>>>>>>>
>>>>>>> root@grml ~ # btrfs filesystem df /mnt
>>>>>>> Data, single: total=3D22.01GiB, used=3D7.11GiB
>>>>>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
>>>>>>> System, single: total=3D4.00MiB, used=3D0.00B
>>>>>>> Metadata, DUP: total=3D2.00GiB, used=3D167.81MiB
>>>>>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>>>>>>> GlobalReserve, single: total=3D25.25MiB, used=3D0.00B
>>>>>>>
>>>>>>> I did also a fstrim:
>>>>>>>
>>>>>>> root@grml ~ # cryptsetup --allow-discards open /dev/sda5 foo
>>>>>>> Enter passphrase for /dev/sda5:
>>>>>>> root@grml ~ # mount -o discard /dev/mapper/foo /mnt
>>>>>>> root@grml ~ # fstrim -v /mnt/
>>>>>>> /mnt/: 105.8 GiB (113600049152 bytes) trimmed
>>>>>>> fstrim -v /mnt/  0.00s user 5.34s system 0% cpu 10:28.70 total
>>>>>>>
>>>>>>> The kern.log in the runtime of fstrim:
>>>>>>> --- snip ---
>>>>>>> Jun 04 12:32:02 grml kernel: BTRFS critical (device dm-0): corrup=
t
>>>>>>> leaf: root=3D1 block=3D32505856 slot=3D32, invalid root item size=
, have 239
>>>>>>> expect 439
>>>>>>> Jun 04 12:32:02 grml kernel: BTRFS critical (device dm-0): corrup=
t
>>>>>>> leaf: root=3D1 block=3D32813056 slot=3D32, invalid root item size=
, have 239
>>>>>>> expect 439
>>>>>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): turning on=
 sync discard
>>>>>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): disk space=

>>>>>>> caching is enabled
>>>>>>> Jun 04 12:32:37 grml kernel: BTRFS critical (device dm-0): corrup=
t
>>>>>>> leaf: root=3D1 block=3D32813056 slot=3D32, invalid root item size=
, have 239
>>>>>>> expect 439
>>>>>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): enabling s=
sd
>>>>>>> optimizations
>>>>>>> Jun 04 12:34:35 grml kernel: BTRFS critical (device dm-0): corrup=
t
>>>>>>> leaf: root=3D1 block=3D32382976 slot=3D32, invalid root item size=
, have 239
>>>>>>> expect 439
>>>>>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): turning on=
 sync discard
>>>>>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): disk space=

>>>>>>> caching is enabled
>>>>>>> Jun 04 12:36:50 grml kernel: BTRFS critical (device dm-0): corrup=
t
>>>>>>> leaf: root=3D1 block=3D32382976 slot=3D32, invalid root item size=
, have 239
>>>>>>> expect 439
>>>>>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): enabling s=
sd
>>>>>>> optimizations
>>>>>>> --- snap ---
>>>>>>>
>>>>>>> Furthermore the system runs for years now. I can't remember exact=
ly,
>>>>>>> but think for 4-5 years. I've started with Debian Testing and jus=
t
>>>>>>> upgraded my system on a regular basis. And and I started with btr=
fs of
>>>>>>> course, but I can't remember with which version...
>>>>>>>
>>>>>>> The problem is still there after the fstrim. Any further suggesti=
ons?
>>>>>>>
>>>>>>> And isn't it a little bit strange, that someone had a very simili=
ar problem?
>>>>>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c6=
496035c@web.de/
>>>>>>>
>>>>>>> root=3D1, slot=3D32, and "invalid root item size, have 239 expect=
 439" are
>>>>>>> identical to my errors.
>>>>>>>
>>>>>>> Thx so far!
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Thu, Jun 4, 2020 at 2:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2020/6/4 =E4=B8=8B=E5=8D=886:52, Thorsten Rehm wrote:
>>>>>>>>> The disk in question is my root (/) partition. If the filesyste=
m is
>>>>>>>>> that highly damaged, I have to reinstall my system. We will see=
, if
>>>>>>>>> it's come to that. Maybe we find something interesting on the w=
ay...
>>>>>>>>> I've downloaded the latest grml daily image and started my syst=
em from
>>>>>>>>> a usb stick. Here we go:
>>>>>>>>>
>>>>>>>>> root@grml ~ # uname -r
>>>>>>>>> 5.6.0-2-amd64
>>>>>>>>>
>>>>>>>>> root@grml ~ # cryptsetup open /dev/sda5 foo
>>>>>>>>>
>>>>>>>>>                                                                =
   :(
>>>>>>>>> Enter passphrase for /dev/sda5:
>>>>>>>>>
>>>>>>>>> root@grml ~ # file -L -s /dev/mapper/foo
>>>>>>>>> /dev/mapper/foo: BTRFS Filesystem label "slash", sectorsize 409=
6,
>>>>>>>>> nodesize 4096, leafsize 4096,
>>>>>>>>> UUID=3D65005d0f-f8ea-4f77-8372-eb8b53198685, 7815716864/1237319=
68000
>>>>>>>>> bytes used, 1 devices
>>>>>>>>>
>>>>>>>>> root@grml ~ # btrfs check /dev/mapper/foo
>>>>>>>>> Opening filesystem to check...
>>>>>>>>> Checking filesystem on /dev/mapper/foo
>>>>>>>>> UUID: 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>> [1/7] checking root items
>>>>>>>>> [2/7] checking extents
>>>>>>>>> [3/7] checking free space cache
>>>>>>>>> [4/7] checking fs roots
>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>> [6/7] checking root refs
>>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>>> found 7815716864 bytes used, no error found
>>>>>>>>> total csum bytes: 6428260
>>>>>>>>> total tree bytes: 175968256
>>>>>>>>> total fs tree bytes: 149475328
>>>>>>>>> total extent tree bytes: 16052224
>>>>>>>>> btree space waste bytes: 43268911
>>>>>>>>> file data blocks allocated: 10453221376
>>>>>>>>>  referenced 8746053632
>>>>>>>>
>>>>>>>> Errr, this is a super good news, all your fs metadata is complet=
ely fine
>>>>>>>> (at least for the first copy).
>>>>>>>> Which is completely different from the kernel dmesg.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> root@grml ~ # lsblk /dev/sda5 --fs
>>>>>>>>> NAME  FSTYPE      FSVER LABEL UUID
>>>>>>>>> FSAVAIL FSUSE% MOUNTPOINT
>>>>>>>>> sda5  crypto_LUKS 1           d2b4fa40-8afd-4e16-b207-4d106096f=
d22
>>>>>>>>> =E2=94=94=E2=94=80foo btrfs             slash 65005d0f-f8ea-4f7=
7-8372-eb8b53198685
>>>>>>>>>
>>>>>>>>> root@grml ~ # mount /dev/mapper/foo /mnt
>>>>>>>>> root@grml ~ # btrfs scrub start /mnt
>>>>>>>>>
>>>>>>>>> root@grml ~ # journalctl -k --no-pager | grep BTRFS
>>>>>>>>> Jun 04 10:33:04 grml kernel: BTRFS: device label slash devid 1 =
transid
>>>>>>>>> 24750795 /dev/dm-0 scanned by systemd-udevd (3233)
>>>>>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): disk spa=
ce
>>>>>>>>> caching is enabled
>>>>>>>>> Jun 04 10:45:17 grml kernel: BTRFS critical (device dm-0): corr=
upt
>>>>>>>>> leaf: root=3D1 block=3D54222848 slot=3D32, invalid root item si=
ze, have 239
>>>>>>>>> expect 439
>>>>>>>>
>>>>>>>> One error line without "read time corruption" line means btrfs k=
ernel
>>>>>>>> indeed skipped to next copy.
>>>>>>>> In this case, there is one copy (aka the first copy) corrupted.
>>>>>>>> Strangely, if it's the first copy in kernel, it should also be t=
he first
>>>>>>>> copy in btrfs check.
>>>>>>>>
>>>>>>>> And no problem reported from btrfs check, that's already super s=
trange.
>>>>>>>>
>>>>>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): enabling=
 ssd
>>>>>>>>> optimizations
>>>>>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): checking=
 UUID tree
>>>>>>>>> Jun 04 10:45:38 grml kernel: BTRFS info (device dm-0): scrub: s=
tarted on devid 1
>>>>>>>>> Jun 04 10:45:49 grml kernel: BTRFS critical (device dm-0): corr=
upt
>>>>>>>>> leaf: root=3D1 block=3D29552640 slot=3D32, invalid root item si=
ze, have 239
>>>>>>>>> expect 439
>>>>>>>>> Jun 04 10:46:25 grml kernel: BTRFS critical (device dm-0): corr=
upt
>>>>>>>>> leaf: root=3D1 block=3D29741056 slot=3D32, invalid root item si=
ze, have 239
>>>>>>>>> expect 439
>>>>>>>>> Jun 04 10:46:31 grml kernel: BTRFS info (device dm-0): scrub: f=
inished
>>>>>>>>> on devid 1 with status: 0
>>>>>>>>> Jun 04 10:46:56 grml kernel: BTRFS critical (device dm-0): corr=
upt
>>>>>>>>> leaf: root=3D1 block=3D29974528 slot=3D32, invalid root item si=
ze, have 239
>>>>>>>>> expect 439
>>>>>>>>
>>>>>>>> This means the corrupted copy are also there for several (and I =
guess
>>>>>>>> unrelated) tree blocks.
>>>>>>>> For scrub I guess it just try to read the good copy without both=
ering
>>>>>>>> the bad one it found, so no error reported in scrub.
>>>>>>>>
>>>>>>>> But still, if you're using metadata without copy (aka, SINGLE, R=
AID0)
>>>>>>>> then it would be a completely different story.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> root@grml ~ # btrfs scrub status /mnt
>>>>>>>>> UUID:             65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>> Scrub started:    Thu Jun  4 10:45:38 2020
>>>>>>>>> Status:           finished
>>>>>>>>> Duration:         0:00:53
>>>>>>>>> Total to scrub:   7.44GiB
>>>>>>>>> Rate:             143.80MiB/s
>>>>>>>>> Error summary:    no errors found
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> root@grml ~ # for block in 54222848 29552640 29741056 29974528;=
 do
>>>>>>>>> btrfs ins dump-tree -b $block /dev/dm-0; done
>>>>>>>>> btrfs-progs v5.6
>>>>>>>>> leaf 54222848 items 33 free space 1095 generation 24750795 owne=
r ROOT_TREE
>>>>>>>>> leaf 54222848 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>>>>     item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
>>>>>>>>>         generation 24703953 transid 24703953 size 262144 nbytes=
 8595701760
>>>>>>>> ...
>>>>>>>>>         cache generation 24750791 entries 139 bitmaps 8
>>>>>>>>>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 item=
size 239
>>>>>>>>
>>>>>>>> So it's still there. The first copy is corrupted. Just btrfs-pro=
gs can't
>>>>>>>> detect it.
>>>>>>>>
>>>>>>>>>         generation 4 root_dirid 256 bytenr 29380608 level 0 ref=
s 1
>>>>>>>>>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)=

>>>>>>>>>         drop key (0 UNKNOWN.0 0) level 0
>>>>>>>>> btrfs-progs v5.6
>>>>>>>>> leaf 29552640 items 33 free space 1095 generation 24750796 owne=
r ROOT_TREE
>>>>>>>>> leaf 29552640 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>>> ...
>>>>>>>>>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 item=
size 239
>>>>>>>>>         generation 4 root_dirid 256 bytenr 29380608 level 0 ref=
s 1
>>>>>>>>>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)=

>>>>>>>>>         drop key (0 UNKNOWN.0 0) level 0
>>>>>>>>
>>>>>>>> This is different from previous copy, which means it should be a=
n CoWed
>>>>>>>> tree blocks.
>>>>>>>>
>>>>>>>>> btrfs-progs v5.6
>>>>>>>>> leaf 29741056 items 33 free space 1095 generation 24750797 owne=
r ROOT_TREE
>>>>>>>>
>>>>>>>> Even newer one.
>>>>>>>>
>>>>>>>> ...
>>>>>>>>> btrfs-progs v5.6
>>>>>>>>> leaf 29974528 items 33 free space 1095 generation 24750798 owne=
r ROOT_TREE
>>>>>>>>
>>>>>>>> Newer.
>>>>>>>>
>>>>>>>> So It looks the bad copy exists for a while, but at the same tim=
e we
>>>>>>>> still have one good copy to let everything float.
>>>>>>>>
>>>>>>>> To kill all the old corrupted copies, if it supports TRIM/DISCAR=
D, I
>>>>>>>> recommend to run scrub first, then fstrim on the fs.
>>>>>>>>
>>>>>>>> If it's HDD, I recommend to run a btrfs balance -m to relocate a=
ll
>>>>>>>> metadata blocks, to get rid the bad copies.
>>>>>>>>
>>>>>>>> Of course, all using v5.3+ kernels.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> On Thu, Jun 4, 2020 at 12:00 PM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2020/6/4 =E4=B8=8B=E5=8D=885:45, Thorsten Rehm wrote:
>>>>>>>>>>> Thank you for you answer.
>>>>>>>>>>> I've just updated my system, did a reboot and it's running wi=
th a
>>>>>>>>>>> 5.6.0-2-amd64 now.
>>>>>>>>>>> So, this is how my kern.log looks like, just right after the =
start:
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> There are too many blocks. I just picked three randomly:
>>>>>>>>>>
>>>>>>>>>> Looks like we need more result, especially some result doesn't=
 match at all.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> =3D=3D=3D Block 33017856 =3D=3D=3D
>>>>>>>>>>> $ btrfs ins dump-tree -b 33017856 /dev/dm-0
>>>>>>>>>>> btrfs-progs v5.6
>>>>>>>>>>> leaf 33017856 items 51 free space 17 generation 24749502 owne=
r FS_TREE
>>>>>>>>>>> leaf 33017856 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>>>>> ...
>>>>>>>>>>>         item 31 key (4000670 EXTENT_DATA 1933312) itemoff 229=
9 itemsize 53
>>>>>>>>>>>                 generation 24749502 type 1 (regular)
>>>>>>>>>>>                 extent data disk byte 1126502400 nr 4096
>>>>>>>>>>>                 extent data offset 0 nr 8192 ram 8192
>>>>>>>>>>>                 extent compression 2 (lzo)
>>>>>>>>>>>         item 32 key (4000670 EXTENT_DATA 1941504) itemoff 224=
6 itemsize 53
>>>>>>>>>>>                 generation 24749502 type 1 (regular)
>>>>>>>>>>>                 extent data disk byte 0 nr 0
>>>>>>>>>>>                 extent data offset 1937408 nr 4096 ram 419430=
4
>>>>>>>>>>>                 extent compression 0 (none)
>>>>>>>>>> Not root item at all.
>>>>>>>>>> At least for this copy, it looks like kernel got one completel=
y bad
>>>>>>>>>> copy, then discarded it and found a good copy.
>>>>>>>>>>
>>>>>>>>>> That's very strange, especially when all the other involved on=
es seems
>>>>>>>>>> random and all at slot 32 is not a coincident.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> =3D=3D=3D Block 44900352  =3D=3D=3D
>>>>>>>>>>> btrfs ins dump-tree -b 44900352 /dev/dm-0
>>>>>>>>>>> btrfs-progs v5.6
>>>>>>>>>>> leaf 44900352 items 19 free space 591 generation 24749527 own=
er FS_TREE
>>>>>>>>>>> leaf 44900352 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>>>
>>>>>>>>>> This block doesn't even have slot 32... It only have 19 items,=
 thus slot
>>>>>>>>>> 0 ~ slot 18.
>>>>>>>>>> And its owner, FS_TREE shouldn't have ROOT_ITEM.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> =3D=3D=3D Block 55352561664 =3D=3D=3D
>>>>>>>>>>> $ btrfs ins dump-tree -b 55352561664 /dev/dm-0
>>>>>>>>>>> btrfs-progs v5.6
>>>>>>>>>>> leaf 55352561664 items 33 free space 1095 generation 24749497=
 owner ROOT_TREE
>>>>>>>>>>> leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>>>>> ...
>>>>>>>>>>>         item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 192=
0 itemsize 239
>>>>>>>>>>>                 generation 4 root_dirid 256 bytenr 29380608 l=
evel 0 refs 1
>>>>>>>>>>>                 lastsnap 0 byte_limit 0 bytes_used 4096 flags=
 0x0(none)
>>>>>>>>>>>                 drop key (0 UNKNOWN.0 0) level 0
>>>>>>>>>>
>>>>>>>>>> This looks like the offending tree block.
>>>>>>>>>> Slot 32, item size 239, which is ROOT_ITEM, but in valid size.=

>>>>>>>>>>
>>>>>>>>>> Since you're here, I guess a btrfs check without --repair on t=
he
>>>>>>>>>> unmounted fs would help to identify the real damage.
>>>>>>>>>>
>>>>>>>>>> And again, the fs looks very damaged, it's highly recommended =
to backup
>>>>>>>>>> your data asap.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>> --- snap ---
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've updated my system (Debian testing) [1] several months =
ago (~
>>>>>>>>>>>>> December) and I noticed a lot of corrupt leaf messages floo=
ding my
>>>>>>>>>>>>> kern.log [2]. Furthermore my system had some trouble, e.g.
>>>>>>>>>>>>> applications were terminated after some uptime, due to the =
btrfs
>>>>>>>>>>>>> filesystem errors. This was with kernel 5.3.
>>>>>>>>>>>>> The last time I tried was with Kernel 5.6.0-1-amd64 and the=
 problem persists.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian=
 Stable
>>>>>>>>>>>>> release and with this kernel there aren't any corrupt leaf =
messages
>>>>>>>>>>>>> and the problem is gone. IMHO, it must be something coming =
with kernel
>>>>>>>>>>>>> 5.3 (or 5.x).
>>>>>>>>>>>>
>>>>>>>>>>>> V5.3 introduced a lot of enhanced metadata sanity checks, an=
d they catch
>>>>>>>>>>>> such *obviously* wrong metadata.
>>>>>>>>>>>>>
>>>>>>>>>>>>> My harddisk is a SSD which is responsible for the root part=
ition. I've
>>>>>>>>>>>>> encrypted my filesystem with LUKS and just right after I en=
tered my
>>>>>>>>>>>>> password at the boot, the first corrupt leaf errors appear.=

>>>>>>>>>>>>>
>>>>>>>>>>>>> An error message looks like this:
>>>>>>>>>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>
>>>>>>>>>>>> Btrfs root items have fixed size. This is already something =
very bad.
>>>>>>>>>>>>
>>>>>>>>>>>> Furthermore, the item size is smaller than expected, which m=
eans we can
>>>>>>>>>>>> easily get garbage. I'm a little surprised that older kernel=
 can even
>>>>>>>>>>>> work without crashing the whole kernel.
>>>>>>>>>>>>
>>>>>>>>>>>> Some extra info could help us to find out how badly the fs i=
s corrupted.
>>>>>>>>>>>> # btrfs ins dump-tree -b 35799040 /dev/dm-0
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> "root=3D1", "slot=3D32", "have 239 expect 439" is always th=
e same at every
>>>>>>>>>>>>> error line. Only the block number changes.
>>>>>>>>>>>>
>>>>>>>>>>>> And dumps for the other block numbers too.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Interestingly it's the very same as reported to the ML here=
 [3]. I've
>>>>>>>>>>>>> contacted the reporter, but he didn't have a solution for m=
e, because
>>>>>>>>>>>>> he changed to a different filesystem.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've already tried "btrfs scrub" and "btrfs check --readonl=
y /" in
>>>>>>>>>>>>> rescue mode, but w/o any errors. I've also checked the S.M.=
A.R.T.
>>>>>>>>>>>>> values of the SSD, which are fine. Furthermore I've tested =
my RAM, but
>>>>>>>>>>>>> again, w/o any errors.
>>>>>>>>>>>>
>>>>>>>>>>>> This doesn't look like a bit flip, so not RAM problems.
>>>>>>>>>>>>
>>>>>>>>>>>> Don't have any better advice until we got the dumps, but I'd=
 recommend
>>>>>>>>>>>> to backup your data since it's still possible.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> So, I have no more ideas what I can do. Could you please he=
lp me to
>>>>>>>>>>>>> investigate this further? Could it be a bug?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thank you very much.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>> Thorsten
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1:
>>>>>>>>>>>>> $ cat /etc/debian_version
>>>>>>>>>>>>> bullseye/sid
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ uname -a
>>>>>>>>>>>>> [no problem with this kernel]
>>>>>>>>>>>>> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-2=
6) x86_64 GNU/Linux
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ btrfs --version
>>>>>>>>>>>>> btrfs-progs v5.6
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ sudo btrfs fi show
>>>>>>>>>>>>> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>>>>>>         Total devices 1 FS bytes used 7.33GiB
>>>>>>>>>>>>>         devid    1 size 115.23GiB used 26.08GiB path /dev/m=
apper/sda5_crypt
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ btrfs fi df /
>>>>>>>>>>>>> Data, single: total=3D22.01GiB, used=3D7.16GiB
>>>>>>>>>>>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
>>>>>>>>>>>>> System, single: total=3D4.00MiB, used=3D0.00B
>>>>>>>>>>>>> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
>>>>>>>>>>>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>>>>>>>>>>>>> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> 2:
>>>>>>>>>>>>> [several messages per second]
>>>>>>>>>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (=
device
>>>>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, i=
nvalid root item
>>>>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>>>>
>>>>>>>>>>>>> 3:
>>>>>>>>>>>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280=
-5f6c6496035c@web.de/
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>
>>>


--2ztkq31Oh7usq600SqCCYAUMpBqohZET5--

--6iN8QMizvkgKasuyK7tK5HlsDHyM0fDEg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+3yOgACgkQwj2R86El
/qhqXAf+Lwx87ILIcR0Vh5XHlWN5s3GpRdxoEOM1LlraKSZ123WEIay/+s5MoUmf
QZp9z+R3qRhF6piqCLBQZGUlTpDRyHdcvPWblB1FYqdZp0p93xgcT6JWx7mTJFbT
Wf5dgADg29jZitCnZFQxwPvbcf3nv8rGME8F1QLJ23ySYt6ceDrjgMWvQ8maZLto
f94EuUWC5rN1ebXFvktFC8ix4qvFMyKGnZ0Yb7xNVze4m/EsdM9MuF7YhmJHZdGG
vhDfeR8RjxLJtyvpflVnk1hqQS1u381GvUGTHh230DUM5JLD4JUoGuxrjekhR7TY
GqvlJiiOomXNp0x0iDeI8RdZg0tNKA==
=6Y+Q
-----END PGP SIGNATURE-----

--6iN8QMizvkgKasuyK7tK5HlsDHyM0fDEg--
