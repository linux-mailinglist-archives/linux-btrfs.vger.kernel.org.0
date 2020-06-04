Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518541EE402
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFDMGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 08:06:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:56679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgFDMGR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jun 2020 08:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591272372;
        bh=EVRUCkW8AxsS8WEZqjHrCLPU9DQaHBdyRiPH5f52k04=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a/apqXCr337AZ7WCK/xdLHsDUgewL4IoYNVFss/I1W6AmgpDRv8tWqq597xC7cIfv
         uf3V5N95k7Tz3O3RhfDMdQighrYrkkw1mKVxgt1OH5kqeSpr2CNx09ghswoY15PP82
         0Eflu9dk9hPm04zVijVS5gS2CIz96VUcyP9aBYWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1jFynM1MQJ-00mNpa; Thu, 04
 Jun 2020 14:06:12 +0200
Subject: Re: corrupt leaf; invalid root item size
To:     Thorsten Rehm <thorsten.rehm@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
 <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com>
 <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
 <1cf994f7-3efb-67ac-d5b1-22929e8ef3fd@gmx.com>
 <CABT3_pxFv0KAjO2DfmikeeT+yN-3BiDj=Mu_a=dC-K9DyL-T3w@mail.gmail.com>
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
Message-ID: <b477b613-2190-2c2f-7fab-f9b712ece187@gmx.com>
Date:   Thu, 4 Jun 2020 20:06:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABT3_pxFv0KAjO2DfmikeeT+yN-3BiDj=Mu_a=dC-K9DyL-T3w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lBxYGmmIB7kQIALL4LNcQb9XP7aVyyzSr"
X-Provags-ID: V03:K1:ZFhQqQ25jh2EP1pKx/7GJUo+Itb8PwhwwvLQV/PjaXex6UCaROT
 s93HqJq7wUombEkSYUPGB2oyHSVsJjfWJkbNLz5aE9bVZ1DQhJQsN3txj1jYyMzZn9cMSn1
 oGGZoZ90KJACiihx9PZg+N9ApTAl6XT+Qs64Mw1Cgd+MdzaPuACCBizHoFtK3HFPSBaMNuC
 3sHNh89wVxSQsoFa4k9lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ttcr6aHMUA=:Xkqr5WM9ZZgNTHmciE8Zu2
 5HTv/iQwsjaDbLOcx07tjwGv3ivFFV1fqVu3AQR0BiXWVnuUVti0C6XKhc6ZSOZEChUbtvOu1
 R2JcN/9UkuVaKtndfPcmj/d7PlUCExRV4+Abo55HrGgZQ2USYMPBWxH+MRMu7m5R5XUgWPuh2
 XwbzPdhgpVK1Jkb3kyN9sT1ya4S+HxzSWEkgbXAZBHSGo1gx40nbWsU3hArZX3I8k/bIRKxbP
 E+Sv0JRq461v2DHEDcGtK5HIiszBQV6HmoSJGi9ECQZFEWae+PsmcXp5g4SZ+m695ohMIz9Kj
 fdzQyhrrNKpJfFQ0zP5ZrcKWEt8FDYrqEJ1I5PrXdwGrVQVq4vL+57cGs6GXWPPzSWeqHKo3F
 syiG0PXVsoWmVh/FB661fApjQL//GzE/sTSS09GFgpRomQUEtJ5PcfzmhQohYilumXnq6tg/r
 z73jPetyRMJkJ7xHEpgwoljavQX5WXZ74BArjnDc1Ikg5OkZJzPasgmYpgdHoipOMB60sDfvv
 YNc1twT/w7m5Dkcr8nPMTTcj80yBh0Jfgbyg5h3FzDoXO5b9Q83M8Z+EpkMI4qlDvpxLkfrLq
 bgBX69leoDMk32HJBoNAROmwmRGfT2mTAzdFV0TLyqiM4gk9heBbdy3kVmin5pD2k+HVRHQD8
 g4qv+6iAm4ejuY2JKiCGxzwqfNisx82aDwl687icz69d6eH/gTS+3o/8V80y6NELZ81mwInVt
 SMcXsqsJKMl8NWlTrDP/Mjw7tPXvCG7Z/UCedFrQ6LGymAWV1LV3a3UxILtUnP60ywVtQUYGN
 LNt0zMv6C5HpCk8Sxi0yVA16lWjHrPw0dv9f0XPZ0zQvgrjjM9PMrFZ4Z5HBTZPaRsakZJXyk
 oxhhMD+elA8SKrVURSCQWNuKv10muqEBGEGLuBO0d50nmp8L3e+yBKxLTiL7oCPzmtywcKMF0
 YuT/VtMHL4r5aSwQOHCGpnCqSM7ZeJLrpWYYYed3Zl13sNjeSEDs8l3TACjTXccbGeVm0vbP/
 dqnSuQiUQJ848ood09hwD9zlUAfGwOymc6UodlNdVGv+LHmfVDJslLVBWnPNN5P35Waa/OSoZ
 pdrhKubHcUXmqEG7tIrlCxtDCGr8mymsVE16ktqqnARQjqnVTkQ3CnbBWjSLLO23m/cWVmlpD
 gWDyOUsysKRY8AK8zKdnKi+J8OJFcp4oTruwfbR6q8cTwOm+mD2uAtJ3HDyPlRvF2fZcKruUR
 nYnUwnNfUocm87pqU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lBxYGmmIB7kQIALL4LNcQb9XP7aVyyzSr
Content-Type: multipart/mixed; boundary="ZbnYJYroJ6EcpVCk9QS90bw8Wklw2ufJZ"

--ZbnYJYroJ6EcpVCk9QS90bw8Wklw2ufJZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/4 =E4=B8=8B=E5=8D=886:52, Thorsten Rehm wrote:
> The disk in question is my root (/) partition. If the filesystem is
> that highly damaged, I have to reinstall my system. We will see, if
> it's come to that. Maybe we find something interesting on the way...
> I've downloaded the latest grml daily image and started my system from
> a usb stick. Here we go:
>=20
> root@grml ~ # uname -r
> 5.6.0-2-amd64
>=20
> root@grml ~ # cryptsetup open /dev/sda5 foo
>=20
>                                                                   :(
> Enter passphrase for /dev/sda5:
>=20
> root@grml ~ # file -L -s /dev/mapper/foo
> /dev/mapper/foo: BTRFS Filesystem label "slash", sectorsize 4096,
> nodesize 4096, leafsize 4096,
> UUID=3D65005d0f-f8ea-4f77-8372-eb8b53198685, 7815716864/123731968000
> bytes used, 1 devices
>=20
> root@grml ~ # btrfs check /dev/mapper/foo
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/foo
> UUID: 65005d0f-f8ea-4f77-8372-eb8b53198685
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 7815716864 bytes used, no error found
> total csum bytes: 6428260
> total tree bytes: 175968256
> total fs tree bytes: 149475328
> total extent tree bytes: 16052224
> btree space waste bytes: 43268911
> file data blocks allocated: 10453221376
>  referenced 8746053632

Errr, this is a super good news, all your fs metadata is completely fine
(at least for the first copy).
Which is completely different from the kernel dmesg.

>=20
> root@grml ~ # lsblk /dev/sda5 --fs
> NAME  FSTYPE      FSVER LABEL UUID
> FSAVAIL FSUSE% MOUNTPOINT
> sda5  crypto_LUKS 1           d2b4fa40-8afd-4e16-b207-4d106096fd22
> =E2=94=94=E2=94=80foo btrfs             slash 65005d0f-f8ea-4f77-8372-e=
b8b53198685
>=20
> root@grml ~ # mount /dev/mapper/foo /mnt
> root@grml ~ # btrfs scrub start /mnt
>=20
> root@grml ~ # journalctl -k --no-pager | grep BTRFS
> Jun 04 10:33:04 grml kernel: BTRFS: device label slash devid 1 transid
> 24750795 /dev/dm-0 scanned by systemd-udevd (3233)
> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): disk space
> caching is enabled
> Jun 04 10:45:17 grml kernel: BTRFS critical (device dm-0): corrupt
> leaf: root=3D1 block=3D54222848 slot=3D32, invalid root item size, have=
 239
> expect 439

One error line without "read time corruption" line means btrfs kernel
indeed skipped to next copy.
In this case, there is one copy (aka the first copy) corrupted.
Strangely, if it's the first copy in kernel, it should also be the first
copy in btrfs check.

And no problem reported from btrfs check, that's already super strange.

> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): enabling ssd
> optimizations
> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): checking UUID tr=
ee
> Jun 04 10:45:38 grml kernel: BTRFS info (device dm-0): scrub: started o=
n devid 1
> Jun 04 10:45:49 grml kernel: BTRFS critical (device dm-0): corrupt
> leaf: root=3D1 block=3D29552640 slot=3D32, invalid root item size, have=
 239
> expect 439
> Jun 04 10:46:25 grml kernel: BTRFS critical (device dm-0): corrupt
> leaf: root=3D1 block=3D29741056 slot=3D32, invalid root item size, have=
 239
> expect 439
> Jun 04 10:46:31 grml kernel: BTRFS info (device dm-0): scrub: finished
> on devid 1 with status: 0
> Jun 04 10:46:56 grml kernel: BTRFS critical (device dm-0): corrupt
> leaf: root=3D1 block=3D29974528 slot=3D32, invalid root item size, have=
 239
> expect 439

This means the corrupted copy are also there for several (and I guess
unrelated) tree blocks.
For scrub I guess it just try to read the good copy without bothering
the bad one it found, so no error reported in scrub.

But still, if you're using metadata without copy (aka, SINGLE, RAID0)
then it would be a completely different story.


>=20
> root@grml ~ # btrfs scrub status /mnt
> UUID:             65005d0f-f8ea-4f77-8372-eb8b53198685
> Scrub started:    Thu Jun  4 10:45:38 2020
> Status:           finished
> Duration:         0:00:53
> Total to scrub:   7.44GiB
> Rate:             143.80MiB/s
> Error summary:    no errors found
>=20
>=20
> root@grml ~ # for block in 54222848 29552640 29741056 29974528; do
> btrfs ins dump-tree -b $block /dev/dm-0; done
> btrfs-progs v5.6
> leaf 54222848 items 33 free space 1095 generation 24750795 owner ROOT_T=
REE
> leaf 54222848 flags 0x1(WRITTEN) backref revision 1
> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>     item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
>         generation 24703953 transid 24703953 size 262144 nbytes 8595701=
760
=2E..
>         cache generation 24750791 entries 139 bitmaps 8
>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239=


So it's still there. The first copy is corrupted. Just btrfs-progs can't
detect it.

>         generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
>         drop key (0 UNKNOWN.0 0) level 0
> btrfs-progs v5.6
> leaf 29552640 items 33 free space 1095 generation 24750796 owner ROOT_T=
REE
> leaf 29552640 flags 0x1(WRITTEN) backref revision 1
> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
=2E..
>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239=

>         generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
>         drop key (0 UNKNOWN.0 0) level 0

This is different from previous copy, which means it should be an CoWed
tree blocks.

> btrfs-progs v5.6
> leaf 29741056 items 33 free space 1095 generation 24750797 owner ROOT_T=
REE

Even newer one.

=2E..
> btrfs-progs v5.6
> leaf 29974528 items 33 free space 1095 generation 24750798 owner ROOT_T=
REE

Newer.

So It looks the bad copy exists for a while, but at the same time we
still have one good copy to let everything float.

To kill all the old corrupted copies, if it supports TRIM/DISCARD, I
recommend to run scrub first, then fstrim on the fs.

If it's HDD, I recommend to run a btrfs balance -m to relocate all
metadata blocks, to get rid the bad copies.

Of course, all using v5.3+ kernels.

Thanks,
Qu
>=20
> On Thu, Jun 4, 2020 at 12:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/6/4 =E4=B8=8B=E5=8D=885:45, Thorsten Rehm wrote:
>>> Thank you for you answer.
>>> I've just updated my system, did a reboot and it's running with a
>>> 5.6.0-2-amd64 now.
>>> So, this is how my kern.log looks like, just right after the start:
>>>
>>
>>>
>>> There are too many blocks. I just picked three randomly:
>>
>> Looks like we need more result, especially some result doesn't match a=
t all.
>>
>>>
>>> =3D=3D=3D Block 33017856 =3D=3D=3D
>>> $ btrfs ins dump-tree -b 33017856 /dev/dm-0
>>> btrfs-progs v5.6
>>> leaf 33017856 items 51 free space 17 generation 24749502 owner FS_TRE=
E
>>> leaf 33017856 flags 0x1(WRITTEN) backref revision 1
>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>> ...
>>>         item 31 key (4000670 EXTENT_DATA 1933312) itemoff 2299 itemsi=
ze 53
>>>                 generation 24749502 type 1 (regular)
>>>                 extent data disk byte 1126502400 nr 4096
>>>                 extent data offset 0 nr 8192 ram 8192
>>>                 extent compression 2 (lzo)
>>>         item 32 key (4000670 EXTENT_DATA 1941504) itemoff 2246 itemsi=
ze 53
>>>                 generation 24749502 type 1 (regular)
>>>                 extent data disk byte 0 nr 0
>>>                 extent data offset 1937408 nr 4096 ram 4194304
>>>                 extent compression 0 (none)
>> Not root item at all.
>> At least for this copy, it looks like kernel got one completely bad
>> copy, then discarded it and found a good copy.
>>
>> That's very strange, especially when all the other involved ones seems=

>> random and all at slot 32 is not a coincident.
>>
>>
>>> =3D=3D=3D Block 44900352  =3D=3D=3D
>>> btrfs ins dump-tree -b 44900352 /dev/dm-0
>>> btrfs-progs v5.6
>>> leaf 44900352 items 19 free space 591 generation 24749527 owner FS_TR=
EE
>>> leaf 44900352 flags 0x1(WRITTEN) backref revision 1
>>
>> This block doesn't even have slot 32... It only have 19 items, thus sl=
ot
>> 0 ~ slot 18.
>> And its owner, FS_TREE shouldn't have ROOT_ITEM.
>>
>>>
>>>
>>> =3D=3D=3D Block 55352561664 =3D=3D=3D
>>> $ btrfs ins dump-tree -b 55352561664 /dev/dm-0
>>> btrfs-progs v5.6
>>> leaf 55352561664 items 33 free space 1095 generation 24749497 owner R=
OOT_TREE
>>> leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
>> ...
>>>         item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsi=
ze 239
>>>                 generation 4 root_dirid 256 bytenr 29380608 level 0 r=
efs 1
>>>                 lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(non=
e)
>>>                 drop key (0 UNKNOWN.0 0) level 0
>>
>> This looks like the offending tree block.
>> Slot 32, item size 239, which is ROOT_ITEM, but in valid size.
>>
>> Since you're here, I guess a btrfs check without --repair on the
>> unmounted fs would help to identify the real damage.
>>
>> And again, the fs looks very damaged, it's highly recommended to backu=
p
>> your data asap.
>>
>> Thanks,
>> Qu
>>
>>> --- snap ---
>>>
>>>
>>>
>>> On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
>>>>> Hi,
>>>>>
>>>>> I've updated my system (Debian testing) [1] several months ago (~
>>>>> December) and I noticed a lot of corrupt leaf messages flooding my
>>>>> kern.log [2]. Furthermore my system had some trouble, e.g.
>>>>> applications were terminated after some uptime, due to the btrfs
>>>>> filesystem errors. This was with kernel 5.3.
>>>>> The last time I tried was with Kernel 5.6.0-1-amd64 and the problem=
 persists.
>>>>>
>>>>> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian Stable
>>>>> release and with this kernel there aren't any corrupt leaf messages=

>>>>> and the problem is gone. IMHO, it must be something coming with ker=
nel
>>>>> 5.3 (or 5.x).
>>>>
>>>> V5.3 introduced a lot of enhanced metadata sanity checks, and they c=
atch
>>>> such *obviously* wrong metadata.
>>>>>
>>>>> My harddisk is a SSD which is responsible for the root partition. I=
've
>>>>> encrypted my filesystem with LUKS and just right after I entered my=

>>>>> password at the boot, the first corrupt leaf errors appear.
>>>>>
>>>>> An error message looks like this:
>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>
>>>> Btrfs root items have fixed size. This is already something very bad=
=2E
>>>>
>>>> Furthermore, the item size is smaller than expected, which means we =
can
>>>> easily get garbage. I'm a little surprised that older kernel can eve=
n
>>>> work without crashing the whole kernel.
>>>>
>>>> Some extra info could help us to find out how badly the fs is corrup=
ted.
>>>> # btrfs ins dump-tree -b 35799040 /dev/dm-0
>>>>
>>>>>
>>>>> "root=3D1", "slot=3D32", "have 239 expect 439" is always the same a=
t every
>>>>> error line. Only the block number changes.
>>>>
>>>> And dumps for the other block numbers too.
>>>>
>>>>>
>>>>> Interestingly it's the very same as reported to the ML here [3]. I'=
ve
>>>>> contacted the reporter, but he didn't have a solution for me, becau=
se
>>>>> he changed to a different filesystem.
>>>>>
>>>>> I've already tried "btrfs scrub" and "btrfs check --readonly /" in
>>>>> rescue mode, but w/o any errors. I've also checked the S.M.A.R.T.
>>>>> values of the SSD, which are fine. Furthermore I've tested my RAM, =
but
>>>>> again, w/o any errors.
>>>>
>>>> This doesn't look like a bit flip, so not RAM problems.
>>>>
>>>> Don't have any better advice until we got the dumps, but I'd recomme=
nd
>>>> to backup your data since it's still possible.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> So, I have no more ideas what I can do. Could you please help me to=

>>>>> investigate this further? Could it be a bug?
>>>>>
>>>>> Thank you very much.
>>>>>
>>>>> Best regards,
>>>>> Thorsten
>>>>>
>>>>>
>>>>>
>>>>> 1:
>>>>> $ cat /etc/debian_version
>>>>> bullseye/sid
>>>>>
>>>>> $ uname -a
>>>>> [no problem with this kernel]
>>>>> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) x86_6=
4 GNU/Linux
>>>>>
>>>>> $ btrfs --version
>>>>> btrfs-progs v5.6
>>>>>
>>>>> $ sudo btrfs fi show
>>>>> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>>>         Total devices 1 FS bytes used 7.33GiB
>>>>>         devid    1 size 115.23GiB used 26.08GiB path /dev/mapper/sd=
a5_crypt
>>>>>
>>>>> $ btrfs fi df /
>>>>> Data, single: total=3D22.01GiB, used=3D7.16GiB
>>>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
>>>>> System, single: total=3D4.00MiB, used=3D0.00B
>>>>> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
>>>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>>>>> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
>>>>>
>>>>>
>>>>> 2:
>>>>> [several messages per second]
>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (device
>>>>> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, invalid r=
oot item
>>>>> size, have 239 expect 439
>>>>>
>>>>> 3:
>>>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c649=
6035c@web.de/
>>>>>
>>>>
>>


--ZbnYJYroJ6EcpVCk9QS90bw8Wklw2ufJZ--

--lBxYGmmIB7kQIALL4LNcQb9XP7aVyyzSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7Y468ACgkQwj2R86El
/qjaFggArswDFmYko63kd8TWPAkynGjtqz9oaFzeiK4z+Bi3ST8mU6/VlYTm8BSN
XXGz7GbWi1SqiLt9lGDZiN2Gsfr5L04zztJjvVF0HbBn2nI+m1lgUNzCX6h/FzyY
jHHVWlzYBo33cXGNB/oqQhYzi0MapD2YQDlgme0S3m9o071k7D4Fl5X8mTNCj/MS
wda8SgxrWpM33t6k46zbROi7ZfZpSP5Q0/44zoAEcWqDPyG1hiHTUirMytv7Vaiv
s4PltTDo0bKIe447gfATT40FCsS5k7lhZ9PsvA+7s5dhKU+p/uuYv1Wc9SaD0/Zs
2OCzico7VHFwXvWTQmNWJrC1OD+C2w==
=g/OM
-----END PGP SIGNATURE-----

--lBxYGmmIB7kQIALL4LNcQb9XP7aVyyzSr--
