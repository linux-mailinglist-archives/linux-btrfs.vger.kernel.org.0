Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78A115B5CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 01:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgBMAYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 19:24:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:50495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgBMAYp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 19:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581553483;
        bh=EBjNmcKm9DBZSsQCbzrH5u3UJq1kRT3RNQPGsnHN6E0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gu+bDu5Og9N9HyTxHX6r9dUpZfVfWgZYrpnjpT7si0wQY1amG4q3BM++mcDoTDq2e
         MljqtqklM60mxj9c6ZZdDJ0a2gLdn0OlnMYVFX+9NvQZ3Sm3Z/2T6KpxrdRPjeQ3W9
         kfAWf7mCztJrJPLzOoUCtVgcEW15t1gNevmGJvCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDEg-1jjvmR36dk-00iDIY; Thu, 13
 Feb 2020 01:24:43 +0100
Subject: Re: tree-checker read time corruption
To:     telsch <telsch@gmx.de>, linux-btrfs@vger.kernel.org
References: <5b974158-4691-c33e-71a7-1e5417eb258a@gmx.de>
 <e35d0318-4d3e-50ce-55b1-178e235e89d7@gmx.com>
 <14db7da5-dc42-90e6-0743-b656ff42a976@gmx.de>
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
Message-ID: <5037cdd7-8d10-bc2b-195d-59c5929c0c50@gmx.com>
Date:   Thu, 13 Feb 2020 08:24:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <14db7da5-dc42-90e6-0743-b656ff42a976@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MddOv4zuJLigWFc08xuWF5oAzKlCa9eZ2"
X-Provags-ID: V03:K1:9SE9dGKd3LSKwjmtFDMvl8fhDyyd4c95BrlgOJFrSXLR3e8ZRkg
 y30+ATdLB1qifV2/GPYXs/kmzrQKddv3YC5/WTQI8B2yXS7XTHXVNxVYtlmzY4L3YEOK4da
 mGuRSgOJg6uqv/kE2iAQaImS23S3n5k5FYVvjK0feQ75S5xeDphMxGf/++Lc3gUOmQIMprP
 BF6zwRuQ9NR/xmPPV1k/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEXUHFkTd7Q=:cvRcU01OJR1U4Jmq7sVW1d
 dqhaEb/rAz1FeCBX8fDxCZBr+E1ujtSkDb/cijGvQOKI3Ou61N39tdOhh57my2B0BH4vMBzNs
 /VuMFRXFkDFGutCamKodxvkjhuMyCNIXfkyz03FqpxprFluMerO7aeLEsJIzPkNMaSxOsb3VX
 +gFLu4d+u+UEUXGE30KP03Gyb/oXOatnDCzUdseEL/OTgAzz95vzleJ6ZmyFHSHMHdjdn2+C6
 O08QRdS19+R+rdfXqM1SSKlL3RxlgVWW6LsioIdz7Lz7EjPgq+zSoop44qoIqXsFRO9wPWZEC
 MZPelMW/btCnjxHFHyWqWQiiULYbW8rv/8rKVxp8V8O50xQNOYS6rRRT/BX28dzXeHb/3+S9h
 Y+PxWjr7xWtDf7Y5PxiIAYbdQqdLeBvGyyuMZlvgIuhqjkCjxVaekJrp3ErI+IoTkGPHmJEVB
 fU2z80PkYjHlU1ffSwBCH8sITJ2s/VSI0xOd3TzWoDeSvSIw3Yam/7mcIXBPzDXvKqOyTTrj/
 q/jFrsWXrAHpynS5KFCwZmf9oEk45mXdXy6LTrdckbRXVhIPCtftdR/DATA4gMJa9DFDQYoD4
 IjCslev0qUsI4ZNPSEaSojlO3TeDcNBJACez/30H8W+LhuQ7jUDiBHfkcRBwJhehj3uc0239j
 snE4/1taQFA5HBBJnKkBz8CMQk+iVdD7fF2zBv3isZYlqjJTivJV04YmM/RfaQ+Z5AEzjxTBM
 uftgn/evQEUiyNYyRGwVZRJhyM21m9iziQg0+Q48AbyN2GH0XooydduZ3vxBKQoaF2KOiEDsh
 yV650a9WVjYCzmS/mHWHCjb1Cuw6Ee+ffvCvAWMbrtbA8o7iXnlo1np0nCFijiTD/XasD/aKf
 ewswOM2Dy/4FOihKr6MRWZPsBn1prU+flcGio8pIQUmkMJ9EWEwwqDzVQqKGPWXKN776YbmKm
 EzPyXWWBwXZdhUVYZwm2w9jePwuv4CWEXN5I3lbFWrSHshljq8AMZSp5Rs4AP7mSY/0riIRsa
 yD+jDi7Ztx/l1g1nU901ENteJYTNBWiyvHC1UmrGkOIddFI0hLfi80g2z38U3Uv/AeWnXFnX+
 RBiHJ1vZfTmd2QIs4N6gNTQDU3151QOw0LcmKO+yNAWCh9M70LBkSeXjlomc43x4mQB4gW7/I
 f5Ie/oWYGR2tNZjnHfffZIWeF7Je+qOsmR+xtUNc3UHX1uaY7dvqcZ6nRRai0UaRYJuOp+SJH
 HSMLECZ/MyntLWP/r
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MddOv4zuJLigWFc08xuWF5oAzKlCa9eZ2
Content-Type: multipart/mixed; boundary="IVAuvGxMURdogj5KCIdKWtuyXDld1tzgm"

--IVAuvGxMURdogj5KCIdKWtuyXDld1tzgm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8B=E5=8D=8810:20, telsch wrote:
>=20
>=20
> On 2/12/20 1:41 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/11 =E4=B8=8B=E5=8D=8810:17, telsch wrote:
>>> Dear devs,
>>>
>>>
>>>
>>> after upgrading from kernel 4.19.101 to 5.5.2 i got read time tree bl=
ock
>>> error as
>>>
>>> described here:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 https://btrfs.wiki.kernel.org/index.php/Tree=
-checker#For_end_users
>>>
>>>
>>>
>>> Working with kernel 4.19.101:
>>>
>>>
>>>
>>> Linux Arch 4.19.101-1-lts #1 SMP Sat, 01 Feb 2020 16:35:36 +0000 x86_=
64
>>> GNU/Linux
>>>
>>>
>>>
>>> btrfs --version
>>>
>>> btrfs-progs v5.4
>>>
>>>
>>>
>>> btrfs fi show
>>>
>>> Label: none=C2=A0 uuid: 56e753f4-1346-49ad-a34f-e93a0235b82a
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS b=
ytes used 92.54GiB
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=
=A0 1 size 95.14GiB used 95.14GiB path /dev/mapper/home
>>>
>>>
>>>
>>> btrfs fi df /home
>>>
>>> Data, single: total=3D94.11GiB, used=3D91.95GiB
>>>
>>> System, single: total=3D31.00MiB, used=3D12.00KiB
>>>
>>> Metadata, single: total=3D1.00GiB, used=3D599.74MiB
>>>
>>> GlobalReserve, single: total=3D199.32MiB, used=3D0.00B
>>>
>>>
>>>
>>> After upgrading to kernel 5.5.2:
>>>
>>>
>>>
>>> [=C2=A0=C2=A0 13.413025] BTRFS: device fsid 56e753f4-1346-49ad-a34f-e=
93a0235b82a
>>> devid 1 transid 468295 /dev/dm-1 scanned by systemd-udevd (417)
>>>
>>> [=C2=A0=C2=A0 13.589952] BTRFS info (device dm-1): force zstd compres=
sion, level 3
>>>
>>> [=C2=A0=C2=A0 13.589956] BTRFS info (device dm-1): disk space caching=
 is enabled
>>>
>>> [=C2=A0=C2=A0 13.594707] BTRFS info (device dm-1): bdev /dev/mapper/h=
ome errs: wr
>>> 0, rd 47, flush 0, corrupt 0, gen 0
>>>
>>> [=C2=A0=C2=A0 13.622912] BTRFS info (device dm-1): enabling ssd optim=
izations
>>>
>>> [=C2=A0=C2=A0 13.624300] BTRFS critical (device dm-1): corrupt leaf: =
root=3D5
>>> block=3D122395779072 slot=3D10 ino=3D265, invalid inode generation: h=
as
>>> 18446744073709551492 expect [0, 468296]
>>
>> An older kernel caused underflow/garbage generation.
>> Much strict tree checker is detecting it and rejecting the tree block =
to
>> prevent further corruption.
>>
>> It can be fixed in by btrfs-progs v5.4 and later, by using 'btrfs chec=
k
>> --repair'
>>
>> Early btrfs-progs can't detect nor fix it.
>>
>> Thanks,
>> Qu
>>
>=20
> As you suggest booting to kernel 5.5.3 with btrfs-progs v5.4 and run
> 'btrfs check --repair'. But didn't fix this error.
>=20
> mount: /home: can't read superblock on /dev/mapper/home.
> [=C2=A0 325.121475] BTRFS info (device dm-1): force zstd compression, l=
evel 3
> [=C2=A0 325.121482] BTRFS info (device dm-1): disk space caching is ena=
bled
> [=C2=A0 325.126234] BTRFS info (device dm-1): bdev /dev/mapper/home err=
s: wr
> 0, rd 47, flush 0, corrupt 0, gen 0
> [=C2=A0 325.143521] BTRFS info (device dm-1): enabling ssd optimization=
s
> [=C2=A0 325.146138] BTRFS critical (device dm-1): corrupt leaf: root=3D=
5
> block=3D122395779072 slot=3D10 ino=3D265, invalid inode generation: has=

> 18446744073709551492 expect [0, 469820]
> [=C2=A0 325.148637] BTRFS error (device dm-1): block=3D122395779072 rea=
d time
> tree block corruption detected

According to the repair log, btrfs-progs doesn't detect it at all.
Thus I'm not sure if it's a bug in btrfs-progs or it's just not newer
enough.

Anyway, you can delete inode 265 manually using older kernel.

Thanks,
Qu
>=20
>>>
>>> [=C2=A0=C2=A0 13.624381] BTRFS error (device dm-1): block=3D122395779=
072 read time
>>> tree block corruption detected
>>>
>>>
>>>
>>>
>>>
>>> Booting from 4.19 kernel can mount fs again.
>>


--IVAuvGxMURdogj5KCIdKWtuyXDld1tzgm--

--MddOv4zuJLigWFc08xuWF5oAzKlCa9eZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5El0QACgkQwj2R86El
/qh77Qf/b+KyZ7SE/8lpsiSYYD7w/LJrNJqckwSUYcHAXuhqKR53gOyAl3RVRFok
x8qIjjsogIFkLsRqFNRuNodEWGOd1MG8VDep7dAsaMUSlyepGZ+rQkvd6xqcQa9N
RsQxroZb4PGKMLWc0qcZkxO1UVZJnejWqPGOjlfpYE55eQqX7lSdyTUPLZj5ciZD
Y1il7c8jmnIULLGphBsBBOzqcLjUOjLAlW4lyw+b67L/arkJG6VO+iukYj0aF4qx
vW3kGUUN73gD12Ks0eSeYVrtY8D1pvQlQuSxZTW+S4+iOIrzLC6KItwEi3eUKdPz
gmASAvqRom1O79+k+ducW78nc7xjAg==
=AzLq
-----END PGP SIGNATURE-----

--MddOv4zuJLigWFc08xuWF5oAzKlCa9eZ2--
