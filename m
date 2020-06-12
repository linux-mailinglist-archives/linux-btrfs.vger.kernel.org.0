Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F511F7427
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 08:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgFLGuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 02:50:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:36597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgFLGuL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 02:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591944604;
        bh=vvUe11oR0M3zS82nLvaHNJ9PLZzJbdMxFsumszOpLys=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HdvgV5BvDUJRf/ZlVMSWil8eqPCVL7SMCrv8iU1T3dHLeVpE1az9DtHXNV2qUo8Yy
         Er/6A6SjanB//gEv0G1WvzLq/4YuMJH/MiD2quYjXXf3r57oBgfAyMPqsMcrwzDAWN
         JmxcfszWYwWj5PY/UULx2er73jlkY6Oov1pl474o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTRH-1jXLJu2XrB-00NUQr; Fri, 12
 Jun 2020 08:50:04 +0200
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
Message-ID: <3235a46e-a3ec-88ba-8343-ef9731194231@gmx.com>
Date:   Fri, 12 Jun 2020 14:50:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABT3_pyOs0G8D5uqJAQXxvQHFanEbniH0fAhntLvf8_hUEY5aw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XWwujdeiFEvkys9unz5aL23bLACJgEbHK"
X-Provags-ID: V03:K1:2GCMzvh1D6CwDSdlbbTP5CxOTynZr5JmlPLmxFWIQenQUkwHzkv
 94gbnS8iyh4gNDZFH7lYOY5dhNFtbLh4XUN6jFQth1cZ2/PO29t/VCQX3qS3i458CjM7jEp
 5aaSauGF/X7RgsPCmpC5pyLbDJz+bcI9Ux+NEC06LNpuI5o0EqRRsCS96KNjYvpmZvQQMKn
 MIZV/Cto0FJv9jd+xiJJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7L+hi1V3aEc=:wzmdyw2qekMZc3UnIVNNs3
 gvdw+uTPiW0Rt3uSNdnAZHM7RZf48z8X9kwgVQoRvxh0heC5vh97HvQUMK/RgcpbfGAObig3y
 WwlBMWGsQuyoyyhlVKbAHPHwaWbUvgH6g7GJ8mH2+OXLRdxPkaWuwbeGZflR8KxGZF23ByHpP
 yrcBwmZQio3MpYG+TdCn7tKeUFTv1SQ/JF14a666wx2WchbY2mEUuLYsAWHCWGRxno7NFSCeg
 hgFEa2dQXCzkMDUs1nH+5exNi5HbqAiF+s0l4QqpzMq1NfRGqFS5nJUdJovC6BQjwwxjoTF4q
 qB833crdxPRW7Rar6h3W5j2jQaPVq7+Yvxr2aixT9U/iRM3Yu+w1o9h+kmjCTsNviLf3NHLxH
 LHlIyoUlZKbX5J5IqovTV6QA8cj53Nml22MPX/6E2uocQ7cUh+hY7+rQR6J0JFy5zellA928N
 C4vGGECJ4z8xug5MT9fSYOKX1+Hkp/Iz/pE4dLED0hCyNEFpUUWogVcH71R6uUCKge3LtG/xL
 XuaCgKFp5mQ91qZfLlMh8aCNUIFir2t+LngMeKYSqdUe+BmKN0sAhAzfqQRcLmQZpK1uKQs6o
 PdhRvh51BNxLyeUyvAJGdvOl8VMmuFI0kXBmb35L2S9IAjP0Kqa2sDorhmmCp4blPc0s84QGS
 an0AD1iu+WhMc7ZzKbpbCj8vKs0MqhHAKKYSWIVn46aksYwZyKkJ1HwBSkXsznVA9Tj4+Nn19
 ko4qVT95xr8dMtFG5yZC3Miv5zBlvXmhoLyRzuHW1DDT0BZ8iuLvojBpWJP1DI5ewslkKxpaA
 hKeR6EJQvbFP6ZRCe1GWLTmgm2JjgLBRM9sn5X5avak/u5oUHnSx9G8Mo0XnMKI4fdnUk4ehP
 0mgVvidmDR6GE6Rdr4onPJowZeYnCXooSjP3Pqxk4ZCKrbEdRU3D6/4p6UkD/i8n+8wCq8F35
 vkmbm4U5Nlo2q9enQ/Ldk/hKzbkcC3StQ7PbPUq+uuZQRo/KNRB5HxkXQ573J7pUHqu/WHhJn
 i2Yy3stCwjaHGveQHbsP6iZbzNC5m54KxB/nDX5M7AS848aGzJSuipQ9GqOVmH9T+jkk0oU1o
 uWWuAcR70hnFdumgg5xQCTzBhtCBaD/T7KUDbLyjzUKYj238sZXbueIfAHmzk009PfIacBr0u
 K1PsTfy1qB2Z58vKGjDb5rn0jStbw+CWJz48IrU6EbR/v4AwL3AsOOrOD3AsFuY7iBUx+QPaf
 RCj5KPqf/8qu35zAB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XWwujdeiFEvkys9unz5aL23bLACJgEbHK
Content-Type: multipart/mixed; boundary="qGno4nPMVZg4g2qMbZa14W1HMju1Ox60I"

--qGno4nPMVZg4g2qMbZa14W1HMju1Ox60I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Would you mind to create a btrfs-image dump?

It would greatly help us to pin down the cause.

# btrfs-image -c9 <device> <file>

Although it may leak sensitive data like file and dir names, you can try
-s options to fuzz them since it's not important in this particular
case, but it would cause more time and may cause some extra problems.

After looking into related code, and your SINGLE metadata profile, I
can't find any clues yet.

Thanks,
Qu


On 2020/6/8 =E4=B8=8B=E5=8D=8810:41, Thorsten Rehm wrote:
> I just have to start my system with kernel 5.6. After that, the
> slot=3D32 error lines will be written. And only these lines:
>=20
> $ grep 'BTRFS critical' kern.log.1 | wc -l
> 1191
>=20
> $ grep 'slot=3D32' kern.log.1 | wc -l
> 1191
>=20
> $ grep 'corruption' kern.log.1 | wc -l
> 0
>=20
> Period: 10 Minutes (~1200 lines in 10 minutes).
>=20
> On Mon, Jun 8, 2020 at 3:29 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/6/8 =E4=B8=8B=E5=8D=889:25, Thorsten Rehm wrote:
>>> Hi,
>>>
>>> any more ideas to investigate this?
>>
>> If you can still hit the same bug, and the fs is still completely fine=
,
>> I could craft some test patches for you tomorrow.
>>
>> The idea behind it is to zero out all the memory for any bad eb.
>> Thus bad eb cache won't affect other read.
>> If that hugely reduced the frequency, I guess that would be the case.
>>
>>
>> But I'm still very interested in, have you hit "read time tree block
>> corruption detected" lines? Or just such slot=3D32 error lines?
>>
>> Thanks,
>> Qu
>>
>>>
>>> On Thu, Jun 4, 2020 at 7:57 PM Thorsten Rehm <thorsten.rehm@gmail.com=
> wrote:
>>>>
>>>> Hmm, ok wait a minute:
>>>>
>>>> "But still, if you're using metadata without copy (aka, SINGLE, RAID=
0)
>>>> then it would be a completely different story."
>>>>
>>>> It's a single disk (SSD):
>>>>
>>>> root@grml ~ # btrfs filesystem usage /mnt
>>>> Overall:
>>>>     Device size:         115.23GiB
>>>>     Device allocated:          26.08GiB
>>>>     Device unallocated:          89.15GiB
>>>>     Device missing:             0.00B
>>>>     Used:               7.44GiB
>>>>     Free (estimated):         104.04GiB    (min: 59.47GiB)
>>>>     Data ratio:                  1.00
>>>>     Metadata ratio:              2.00
>>>>     Global reserve:          25.25MiB    (used: 0.00B)
>>>>
>>>> Data,single: Size:22.01GiB, Used:7.11GiB (32.33%)
>>>>    /dev/mapper/foo      22.01GiB
>>>>
>>>> Metadata,single: Size:8.00MiB, Used:0.00B (0.00%)
>>>>    /dev/mapper/foo       8.00MiB
>>>>
>>>> Metadata,DUP: Size:2.00GiB, Used:167.81MiB (8.19%)
>>>>    /dev/mapper/foo       4.00GiB
>>>>
>>>> System,single: Size:4.00MiB, Used:0.00B (0.00%)
>>>>    /dev/mapper/foo       4.00MiB
>>>>
>>>> System,DUP: Size:32.00MiB, Used:4.00KiB (0.01%)
>>>>    /dev/mapper/foo      64.00MiB
>>>>
>>>> Unallocated:
>>>>    /dev/mapper/foo      89.15GiB
>>>>
>>>>
>>>> root@grml ~ # btrfs filesystem df /mnt
>>>> Data, single: total=3D22.01GiB, used=3D7.11GiB
>>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
>>>> System, single: total=3D4.00MiB, used=3D0.00B
>>>> Metadata, DUP: total=3D2.00GiB, used=3D167.81MiB
>>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>>>> GlobalReserve, single: total=3D25.25MiB, used=3D0.00B
>>>>
>>>> I did also a fstrim:
>>>>
>>>> root@grml ~ # cryptsetup --allow-discards open /dev/sda5 foo
>>>> Enter passphrase for /dev/sda5:
>>>> root@grml ~ # mount -o discard /dev/mapper/foo /mnt
>>>> root@grml ~ # fstrim -v /mnt/
>>>> /mnt/: 105.8 GiB (113600049152 bytes) trimmed
>>>> fstrim -v /mnt/  0.00s user 5.34s system 0% cpu 10:28.70 total
>>>>
>>>> The kern.log in the runtime of fstrim:
>>>> --- snip ---
>>>> Jun 04 12:32:02 grml kernel: BTRFS critical (device dm-0): corrupt
>>>> leaf: root=3D1 block=3D32505856 slot=3D32, invalid root item size, h=
ave 239
>>>> expect 439
>>>> Jun 04 12:32:02 grml kernel: BTRFS critical (device dm-0): corrupt
>>>> leaf: root=3D1 block=3D32813056 slot=3D32, invalid root item size, h=
ave 239
>>>> expect 439
>>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): turning on sy=
nc discard
>>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): disk space
>>>> caching is enabled
>>>> Jun 04 12:32:37 grml kernel: BTRFS critical (device dm-0): corrupt
>>>> leaf: root=3D1 block=3D32813056 slot=3D32, invalid root item size, h=
ave 239
>>>> expect 439
>>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): enabling ssd
>>>> optimizations
>>>> Jun 04 12:34:35 grml kernel: BTRFS critical (device dm-0): corrupt
>>>> leaf: root=3D1 block=3D32382976 slot=3D32, invalid root item size, h=
ave 239
>>>> expect 439
>>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): turning on sy=
nc discard
>>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): disk space
>>>> caching is enabled
>>>> Jun 04 12:36:50 grml kernel: BTRFS critical (device dm-0): corrupt
>>>> leaf: root=3D1 block=3D32382976 slot=3D32, invalid root item size, h=
ave 239
>>>> expect 439
>>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): enabling ssd
>>>> optimizations
>>>> --- snap ---
>>>>
>>>> Furthermore the system runs for years now. I can't remember exactly,=

>>>> but think for 4-5 years. I've started with Debian Testing and just
>>>> upgraded my system on a regular basis. And and I started with btrfs =
of
>>>> course, but I can't remember with which version...
>>>>
>>>> The problem is still there after the fstrim. Any further suggestions=
?
>>>>
>>>> And isn't it a little bit strange, that someone had a very similiar =
problem?
>>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c6496=
035c@web.de/
>>>>
>>>> root=3D1, slot=3D32, and "invalid root item size, have 239 expect 43=
9" are
>>>> identical to my errors.
>>>>
>>>> Thx so far!
>>>>
>>>>
>>>>
>>>> On Thu, Jun 4, 2020 at 2:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>
>>>>>
>>>>>
>>>>> On 2020/6/4 =E4=B8=8B=E5=8D=886:52, Thorsten Rehm wrote:
>>>>>> The disk in question is my root (/) partition. If the filesystem i=
s
>>>>>> that highly damaged, I have to reinstall my system. We will see, i=
f
>>>>>> it's come to that. Maybe we find something interesting on the way.=
=2E.
>>>>>> I've downloaded the latest grml daily image and started my system =
from
>>>>>> a usb stick. Here we go:
>>>>>>
>>>>>> root@grml ~ # uname -r
>>>>>> 5.6.0-2-amd64
>>>>>>
>>>>>> root@grml ~ # cryptsetup open /dev/sda5 foo
>>>>>>
>>>>>>                                                                   =
:(
>>>>>> Enter passphrase for /dev/sda5:
>>>>>>
>>>>>> root@grml ~ # file -L -s /dev/mapper/foo
>>>>>> /dev/mapper/foo: BTRFS Filesystem label "slash", sectorsize 4096,
>>>>>> nodesize 4096, leafsize 4096,
>>>>>> UUID=3D65005d0f-f8ea-4f77-8372-eb8b53198685, 7815716864/1237319680=
00
>>>>>> bytes used, 1 devices
>>>>>>
>>>>>> root@grml ~ # btrfs check /dev/mapper/foo
>>>>>> Opening filesystem to check...
>>>>>> Checking filesystem on /dev/mapper/foo
>>>>>> UUID: 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>> [1/7] checking root items
>>>>>> [2/7] checking extents
>>>>>> [3/7] checking free space cache
>>>>>> [4/7] checking fs roots
>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>> [6/7] checking root refs
>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>> found 7815716864 bytes used, no error found
>>>>>> total csum bytes: 6428260
>>>>>> total tree bytes: 175968256
>>>>>> total fs tree bytes: 149475328
>>>>>> total extent tree bytes: 16052224
>>>>>> btree space waste bytes: 43268911
>>>>>> file data blocks allocated: 10453221376
>>>>>>  referenced 8746053632
>>>>>
>>>>> Errr, this is a super good news, all your fs metadata is completely=
 fine
>>>>> (at least for the first copy).
>>>>> Which is completely different from the kernel dmesg.
>>>>>
>>>>>>
>>>>>> root@grml ~ # lsblk /dev/sda5 --fs
>>>>>> NAME  FSTYPE      FSVER LABEL UUID
>>>>>> FSAVAIL FSUSE% MOUNTPOINT
>>>>>> sda5  crypto_LUKS 1           d2b4fa40-8afd-4e16-b207-4d106096fd22=

>>>>>> =E2=94=94=E2=94=80foo btrfs             slash 65005d0f-f8ea-4f77-8=
372-eb8b53198685
>>>>>>
>>>>>> root@grml ~ # mount /dev/mapper/foo /mnt
>>>>>> root@grml ~ # btrfs scrub start /mnt
>>>>>>
>>>>>> root@grml ~ # journalctl -k --no-pager | grep BTRFS
>>>>>> Jun 04 10:33:04 grml kernel: BTRFS: device label slash devid 1 tra=
nsid
>>>>>> 24750795 /dev/dm-0 scanned by systemd-udevd (3233)
>>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): disk space
>>>>>> caching is enabled
>>>>>> Jun 04 10:45:17 grml kernel: BTRFS critical (device dm-0): corrupt=

>>>>>> leaf: root=3D1 block=3D54222848 slot=3D32, invalid root item size,=
 have 239
>>>>>> expect 439
>>>>>
>>>>> One error line without "read time corruption" line means btrfs kern=
el
>>>>> indeed skipped to next copy.
>>>>> In this case, there is one copy (aka the first copy) corrupted.
>>>>> Strangely, if it's the first copy in kernel, it should also be the =
first
>>>>> copy in btrfs check.
>>>>>
>>>>> And no problem reported from btrfs check, that's already super stra=
nge.
>>>>>
>>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): enabling ss=
d
>>>>>> optimizations
>>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): checking UU=
ID tree
>>>>>> Jun 04 10:45:38 grml kernel: BTRFS info (device dm-0): scrub: star=
ted on devid 1
>>>>>> Jun 04 10:45:49 grml kernel: BTRFS critical (device dm-0): corrupt=

>>>>>> leaf: root=3D1 block=3D29552640 slot=3D32, invalid root item size,=
 have 239
>>>>>> expect 439
>>>>>> Jun 04 10:46:25 grml kernel: BTRFS critical (device dm-0): corrupt=

>>>>>> leaf: root=3D1 block=3D29741056 slot=3D32, invalid root item size,=
 have 239
>>>>>> expect 439
>>>>>> Jun 04 10:46:31 grml kernel: BTRFS info (device dm-0): scrub: fini=
shed
>>>>>> on devid 1 with status: 0
>>>>>> Jun 04 10:46:56 grml kernel: BTRFS critical (device dm-0): corrupt=

>>>>>> leaf: root=3D1 block=3D29974528 slot=3D32, invalid root item size,=
 have 239
>>>>>> expect 439
>>>>>
>>>>> This means the corrupted copy are also there for several (and I gue=
ss
>>>>> unrelated) tree blocks.
>>>>> For scrub I guess it just try to read the good copy without botheri=
ng
>>>>> the bad one it found, so no error reported in scrub.
>>>>>
>>>>> But still, if you're using metadata without copy (aka, SINGLE, RAID=
0)
>>>>> then it would be a completely different story.
>>>>>
>>>>>
>>>>>>
>>>>>> root@grml ~ # btrfs scrub status /mnt
>>>>>> UUID:             65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>> Scrub started:    Thu Jun  4 10:45:38 2020
>>>>>> Status:           finished
>>>>>> Duration:         0:00:53
>>>>>> Total to scrub:   7.44GiB
>>>>>> Rate:             143.80MiB/s
>>>>>> Error summary:    no errors found
>>>>>>
>>>>>>
>>>>>> root@grml ~ # for block in 54222848 29552640 29741056 29974528; do=

>>>>>> btrfs ins dump-tree -b $block /dev/dm-0; done
>>>>>> btrfs-progs v5.6
>>>>>> leaf 54222848 items 33 free space 1095 generation 24750795 owner R=
OOT_TREE
>>>>>> leaf 54222848 flags 0x1(WRITTEN) backref revision 1
>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>     item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
>>>>>>         generation 24703953 transid 24703953 size 262144 nbytes 85=
95701760
>>>>> ...
>>>>>>         cache generation 24750791 entries 139 bitmaps 8
>>>>>>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsiz=
e 239
>>>>>
>>>>> So it's still there. The first copy is corrupted. Just btrfs-progs =
can't
>>>>> detect it.
>>>>>
>>>>>>         generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1=

>>>>>>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
>>>>>>         drop key (0 UNKNOWN.0 0) level 0
>>>>>> btrfs-progs v5.6
>>>>>> leaf 29552640 items 33 free space 1095 generation 24750796 owner R=
OOT_TREE
>>>>>> leaf 29552640 flags 0x1(WRITTEN) backref revision 1
>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>> ...
>>>>>>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsiz=
e 239
>>>>>>         generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1=

>>>>>>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
>>>>>>         drop key (0 UNKNOWN.0 0) level 0
>>>>>
>>>>> This is different from previous copy, which means it should be an C=
oWed
>>>>> tree blocks.
>>>>>
>>>>>> btrfs-progs v5.6
>>>>>> leaf 29741056 items 33 free space 1095 generation 24750797 owner R=
OOT_TREE
>>>>>
>>>>> Even newer one.
>>>>>
>>>>> ...
>>>>>> btrfs-progs v5.6
>>>>>> leaf 29974528 items 33 free space 1095 generation 24750798 owner R=
OOT_TREE
>>>>>
>>>>> Newer.
>>>>>
>>>>> So It looks the bad copy exists for a while, but at the same time w=
e
>>>>> still have one good copy to let everything float.
>>>>>
>>>>> To kill all the old corrupted copies, if it supports TRIM/DISCARD, =
I
>>>>> recommend to run scrub first, then fstrim on the fs.
>>>>>
>>>>> If it's HDD, I recommend to run a btrfs balance -m to relocate all
>>>>> metadata blocks, to get rid the bad copies.
>>>>>
>>>>> Of course, all using v5.3+ kernels.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> On Thu, Jun 4, 2020 at 12:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2020/6/4 =E4=B8=8B=E5=8D=885:45, Thorsten Rehm wrote:
>>>>>>>> Thank you for you answer.
>>>>>>>> I've just updated my system, did a reboot and it's running with =
a
>>>>>>>> 5.6.0-2-amd64 now.
>>>>>>>> So, this is how my kern.log looks like, just right after the sta=
rt:
>>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> There are too many blocks. I just picked three randomly:
>>>>>>>
>>>>>>> Looks like we need more result, especially some result doesn't ma=
tch at all.
>>>>>>>
>>>>>>>>
>>>>>>>> =3D=3D=3D Block 33017856 =3D=3D=3D
>>>>>>>> $ btrfs ins dump-tree -b 33017856 /dev/dm-0
>>>>>>>> btrfs-progs v5.6
>>>>>>>> leaf 33017856 items 51 free space 17 generation 24749502 owner F=
S_TREE
>>>>>>>> leaf 33017856 flags 0x1(WRITTEN) backref revision 1
>>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>> ...
>>>>>>>>         item 31 key (4000670 EXTENT_DATA 1933312) itemoff 2299 i=
temsize 53
>>>>>>>>                 generation 24749502 type 1 (regular)
>>>>>>>>                 extent data disk byte 1126502400 nr 4096
>>>>>>>>                 extent data offset 0 nr 8192 ram 8192
>>>>>>>>                 extent compression 2 (lzo)
>>>>>>>>         item 32 key (4000670 EXTENT_DATA 1941504) itemoff 2246 i=
temsize 53
>>>>>>>>                 generation 24749502 type 1 (regular)
>>>>>>>>                 extent data disk byte 0 nr 0
>>>>>>>>                 extent data offset 1937408 nr 4096 ram 4194304
>>>>>>>>                 extent compression 0 (none)
>>>>>>> Not root item at all.
>>>>>>> At least for this copy, it looks like kernel got one completely b=
ad
>>>>>>> copy, then discarded it and found a good copy.
>>>>>>>
>>>>>>> That's very strange, especially when all the other involved ones =
seems
>>>>>>> random and all at slot 32 is not a coincident.
>>>>>>>
>>>>>>>
>>>>>>>> =3D=3D=3D Block 44900352  =3D=3D=3D
>>>>>>>> btrfs ins dump-tree -b 44900352 /dev/dm-0
>>>>>>>> btrfs-progs v5.6
>>>>>>>> leaf 44900352 items 19 free space 591 generation 24749527 owner =
FS_TREE
>>>>>>>> leaf 44900352 flags 0x1(WRITTEN) backref revision 1
>>>>>>>
>>>>>>> This block doesn't even have slot 32... It only have 19 items, th=
us slot
>>>>>>> 0 ~ slot 18.
>>>>>>> And its owner, FS_TREE shouldn't have ROOT_ITEM.
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> =3D=3D=3D Block 55352561664 =3D=3D=3D
>>>>>>>> $ btrfs ins dump-tree -b 55352561664 /dev/dm-0
>>>>>>>> btrfs-progs v5.6
>>>>>>>> leaf 55352561664 items 33 free space 1095 generation 24749497 ow=
ner ROOT_TREE
>>>>>>>> leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
>>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>>>>>>> ...
>>>>>>>>         item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 i=
temsize 239
>>>>>>>>                 generation 4 root_dirid 256 bytenr 29380608 leve=
l 0 refs 1
>>>>>>>>                 lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x=
0(none)
>>>>>>>>                 drop key (0 UNKNOWN.0 0) level 0
>>>>>>>
>>>>>>> This looks like the offending tree block.
>>>>>>> Slot 32, item size 239, which is ROOT_ITEM, but in valid size.
>>>>>>>
>>>>>>> Since you're here, I guess a btrfs check without --repair on the
>>>>>>> unmounted fs would help to identify the real damage.
>>>>>>>
>>>>>>> And again, the fs looks very damaged, it's highly recommended to =
backup
>>>>>>> your data asap.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>> --- snap ---
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I've updated my system (Debian testing) [1] several months ago=
 (~
>>>>>>>>>> December) and I noticed a lot of corrupt leaf messages floodin=
g my
>>>>>>>>>> kern.log [2]. Furthermore my system had some trouble, e.g.
>>>>>>>>>> applications were terminated after some uptime, due to the btr=
fs
>>>>>>>>>> filesystem errors. This was with kernel 5.3.
>>>>>>>>>> The last time I tried was with Kernel 5.6.0-1-amd64 and the pr=
oblem persists.
>>>>>>>>>>
>>>>>>>>>> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian St=
able
>>>>>>>>>> release and with this kernel there aren't any corrupt leaf mes=
sages
>>>>>>>>>> and the problem is gone. IMHO, it must be something coming wit=
h kernel
>>>>>>>>>> 5.3 (or 5.x).
>>>>>>>>>
>>>>>>>>> V5.3 introduced a lot of enhanced metadata sanity checks, and t=
hey catch
>>>>>>>>> such *obviously* wrong metadata.
>>>>>>>>>>
>>>>>>>>>> My harddisk is a SSD which is responsible for the root partiti=
on. I've
>>>>>>>>>> encrypted my filesystem with LUKS and just right after I enter=
ed my
>>>>>>>>>> password at the boot, the first corrupt leaf errors appear.
>>>>>>>>>>
>>>>>>>>>> An error message looks like this:
>>>>>>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>
>>>>>>>>> Btrfs root items have fixed size. This is already something ver=
y bad.
>>>>>>>>>
>>>>>>>>> Furthermore, the item size is smaller than expected, which mean=
s we can
>>>>>>>>> easily get garbage. I'm a little surprised that older kernel ca=
n even
>>>>>>>>> work without crashing the whole kernel.
>>>>>>>>>
>>>>>>>>> Some extra info could help us to find out how badly the fs is c=
orrupted.
>>>>>>>>> # btrfs ins dump-tree -b 35799040 /dev/dm-0
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> "root=3D1", "slot=3D32", "have 239 expect 439" is always the s=
ame at every
>>>>>>>>>> error line. Only the block number changes.
>>>>>>>>>
>>>>>>>>> And dumps for the other block numbers too.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Interestingly it's the very same as reported to the ML here [3=
]. I've
>>>>>>>>>> contacted the reporter, but he didn't have a solution for me, =
because
>>>>>>>>>> he changed to a different filesystem.
>>>>>>>>>>
>>>>>>>>>> I've already tried "btrfs scrub" and "btrfs check --readonly /=
" in
>>>>>>>>>> rescue mode, but w/o any errors. I've also checked the S.M.A.R=
=2ET.
>>>>>>>>>> values of the SSD, which are fine. Furthermore I've tested my =
RAM, but
>>>>>>>>>> again, w/o any errors.
>>>>>>>>>
>>>>>>>>> This doesn't look like a bit flip, so not RAM problems.
>>>>>>>>>
>>>>>>>>> Don't have any better advice until we got the dumps, but I'd re=
commend
>>>>>>>>> to backup your data since it's still possible.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So, I have no more ideas what I can do. Could you please help =
me to
>>>>>>>>>> investigate this further? Could it be a bug?
>>>>>>>>>>
>>>>>>>>>> Thank you very much.
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> Thorsten
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 1:
>>>>>>>>>> $ cat /etc/debian_version
>>>>>>>>>> bullseye/sid
>>>>>>>>>>
>>>>>>>>>> $ uname -a
>>>>>>>>>> [no problem with this kernel]
>>>>>>>>>> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) =
x86_64 GNU/Linux
>>>>>>>>>>
>>>>>>>>>> $ btrfs --version
>>>>>>>>>> btrfs-progs v5.6
>>>>>>>>>>
>>>>>>>>>> $ sudo btrfs fi show
>>>>>>>>>> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>>>>>>         Total devices 1 FS bytes used 7.33GiB
>>>>>>>>>>         devid    1 size 115.23GiB used 26.08GiB path /dev/mapp=
er/sda5_crypt
>>>>>>>>>>
>>>>>>>>>> $ btrfs fi df /
>>>>>>>>>> Data, single: total=3D22.01GiB, used=3D7.16GiB
>>>>>>>>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
>>>>>>>>>> System, single: total=3D4.00MiB, used=3D0.00B
>>>>>>>>>> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
>>>>>>>>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>>>>>>>>>> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 2:
>>>>>>>>>> [several messages per second]
>>>>>>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (dev=
ice
>>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, inva=
lid root item
>>>>>>>>>> size, have 239 expect 439
>>>>>>>>>>
>>>>>>>>>> 3:
>>>>>>>>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f=
6c6496035c@web.de/
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>


--qGno4nPMVZg4g2qMbZa14W1HMju1Ox60I--

--XWwujdeiFEvkys9unz5aL23bLACJgEbHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7jJZgACgkQwj2R86El
/qh3TQgAovr/Hne3O7NAkqZhuYybts2I8rbuTdamrFiU3r4vLjR8GF3sJiOonLou
lSTejefB9njs0SSzJiYLoSzhdCAp0Mv5/Od+6URIctz4PVjgVGXGl3Fc6D6lGWQE
NGMN9oO2viK9dok5mpkhxOiRSuuA76qJbEXy0jgTUWybqLDmzeg4d48Tj4G0tebA
rtGg/EvzMnSJNmT8zVjZlOPAMwsYibJFe2UgAYJvbAB01wdqHQHs/sNZdogWH2mq
7BiLJoksHteugE3wQWrqM8eZ6eqF9SRgAqMcO8jAdYJooAqa1beTSp77MFGn5NIu
BDqF9pV0aPSXIo3MzemaFUred/rSNQ==
=WJh0
-----END PGP SIGNATURE-----

--XWwujdeiFEvkys9unz5aL23bLACJgEbHK--
