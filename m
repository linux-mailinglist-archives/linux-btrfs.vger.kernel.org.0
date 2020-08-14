Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9824429B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHNA4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:56:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:37545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHNA4y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597366610;
        bh=OQMvZAImMKfs4Vfp8+H6ADfJsuZ3JmAOn4e5uBCvyJ0=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=JFnmCMp6uclFFO8kYiHHGiHMW38SrhlhX7dGWkBkY331f+w2LtjiubQD8G10WlhTq
         E2RTb7qvIFeSQm5W0FrSoHektKWOtTrtKXd5BViaUBLbZmx8sa4JElPbzuwwn6gE5r
         2i2DHSTSaPMARjW36s3LiFoLrBrDp5cyMqzD3+DI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAONd-1k02NW3mpf-00BqZn; Fri, 14
 Aug 2020 02:56:50 +0200
Subject: Re: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net
References: <004201d670c9$c69b9230$53d2b690$@gmx.net>
 <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
 <000801d670fd$bb2f62d0$318e2870$@gmx.net>
 <940c43d7-b7e0-82fa-d5a5-b81e672b85a9@gmx.com>
 <000301d671b4$fc4a0650$f4de12f0$@gmx.net>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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
Message-ID: <0839617b-8d4b-c252-1c74-4a3ff941ba6f@gmx.com>
Date:   Fri, 14 Aug 2020 08:56:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000301d671b4$fc4a0650$f4de12f0$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="shLliXoj2gOVBSN688O0kaW8YzIcfRron"
X-Provags-ID: V03:K1:pluFFJ7yYSVjdjMdYAlvX/FxBf1tbBDBzwAsQYmmwK52vJVGhHn
 LsXzfSdWKRQPr4cKxgte2GbiXj7Vgc3Cbw6reny7TDvn5iHaLGo1U7AES62KA45K/2CHJZq
 qhK/IoXYziji1Aod4u7ds76YMEU1VU27itxNiWWe4CWu2EwmHFLdY+UrNP2ECQoOs75BdBm
 zs9OUm+JvghpnUYZZu2Rw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:umS5dSo8fK4=:PW4ZAaSA4AgqmbgsAPwsop
 I20FsrJ4uToGS5Uko5IXfznivSE0SYpOuz024DSSGGiAqEC9teFG+Y1oz0hAkbZ/eAo1/JGS0
 gA4Ktqk1X4Alpm5nNx4w8tqKUylRm83v86maq9b4sA67baEG/25HKgiOSWkSZ7MTfK6ly9tW8
 ck1f30CCDDJMF4VSzRfEebKMhlKJOjy9chHAaBmvp8OUKjbRyF1kvudmlaoMRpra1oWugv1mo
 eQN5RWaFD/KBkWmj1pV5gKZtBvAkgtaq2847jJari7ElUVl/Vhipwgmg+zpOWZW33JMAp6Olw
 JhvbbZ6IA3MQoJj/dr1t1leO0NC82sGpovsH1w2kqpUV4Ub4yI/4gfZd3aCRdxUsLoFX/yh2W
 aLVVlETtwKy+ufLhOlETefv0cPOAk073urTgurd5u1iTd6Es37RoseJRAfXFaSnONSujxaZFZ
 lrJGOeSxBQQ0uSiNZTvqVNmTz3UaYsdXIyG5yabIprBRUVR8idvunyfNNZxNlIAz6TLEQE1zv
 iWUxsQdeq8T5PPOSBr5/lNFx5z7HMpXdWBYlpvYR6dExQ5Y+RaIPN6CR3HPr834TFVzBfHojl
 l1zQcJkgj6xVJSyAmwErm0341QvG+fuBV0VbVwAg2YJni1FXJwUdNuz+nnLBKexxGDHt+CZZE
 0fDEtKgnAa6V1t0Oj20QCZ2ohJonbtu6gahVbcAwGHxfoBV7+QgFyOSLfE7T4DtZnZMSePcfd
 kKp5gP5I7pxt4oukMZNgJ8k0PRilnxQb7WiMg9mQywpwjTCX1HfzySRMkXSyEXS+HRzlqraiS
 Jh3pK2dPWGSa39RGeQwbKOPsfFTBviA0VAwG29FLGAF7jYkztgqbAkrxpg9r19Qin1pKI+5FP
 Xf4Rz/3NMjqBoYueIHC3dCucufSO0Hm+8ZcofANXHkBQxAqsdf1UPEeDAQe7qZiZmWrBrv1Jc
 hXWehLvqp2sGRpNelHkktKMEJQPL80quQFzT/SIbJ6UT0TIehERZE22VdHccKwuJa510Ef7nO
 5UwIkkLmj1dNSjw/0oEH6z8gPibnIx165rxMUTLew2WcKqey6qplGhkheN84sK/uVC4XCFMGj
 qarCVm/x7Vjb1BWSnechOrYN48kq86rXBmO3bm3MqFTfQPu3YTkQE36VzpcXcSqFb+DKS/q6K
 esm8r51/9hMrj006GQMSc0oS4NNmqrx4jktnQGkeZmljId5trMUOIcsLxl3+vFm9fV764Wm3O
 mlNuYPVrCOBpyp9JX1vV324AOo/g9Vu9UAMxuJw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--shLliXoj2gOVBSN688O0kaW8YzIcfRron
Content-Type: multipart/mixed; boundary="rYub8vFop7DqBtyI6UknklBlNXpm1VlWI"

--rYub8vFop7DqBtyI6UknklBlNXpm1VlWI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/14 =E4=B8=8A=E5=8D=885:01, benjamin.haendel@gmx.net wrote:
> Hi Qu,
>=20
> i downloaded the code, compiled and installed it.

You still need to run "btrfs check --repair".

Considering you haven't post that output, I guess you didn't run that.

> Still could not mount the FS with error:
> mount: /media/Storage: wrong fs type, bad option, bad superblock on /de=
v/mapper/Crypto, missing codepage or helper program, or other error.
>=20
> Dmesg is telling me:
> [  174.061205] Btrfs loaded, crc32c=3Dcrc32c-intel
> [  174.081002] BTRFS: device label Storage devid 1 transid 207602 /dev/=
dm-0
> [  192.175157] BTRFS info (device dm-0): disk space caching is enabled
> [  204.025699] BTRFS critical (device dm-0): corrupt leaf: block=3D2275=
1711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D4096 invalid gene=
ration, have 22795412619264 expect (0, 207603]
> [  204.025703] BTRFS error (device dm-0): block=3D22751711027200 read t=
ime tree block corruption detected
> [  204.025731] BTRFS error (device dm-0): failed to read block groups: =
-5
> [  204.076709] BTRFS error (device dm-0): open_ctree failed
>=20
> I am unsure of what to do now. Did i have to run a btrfs check --repair=
 with the compiled btrfs branch ?

Yes.

> I also removed all other versions of btrfs now to see if an old version=
 could read it, it now says:
> root@Userv:~# btrfs --version
> btrfs-progs v4.1

Nope, you're not using the correct version.

>=20
> Still i can not mount the drive. How can i at least get read access to =
my data ?

Just go using your older kernel, and wait for your distro to provide
newer enough btrfs-progs.

Thanks,
Qu

>=20
> Best Regards,
> Ben
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Gesendet: Donnerstag, 13. August 2020 01:30
> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
> Betreff: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>=20
>=20
>=20
> On 2020/8/13 =E4=B8=8A=E5=8D=887:10, benjamin.haendel@gmx.net wrote:
>> Hi Qu,
>>
>> thanks for your reply, i am not sure what to do from here on.
>> What do i have to download from here or compile/make/install etc. ?
>=20
> You need to compile that branch.
>=20
> For how to compile, please check the README.md.
>=20
>=20
>>
>> I'm no total idiot but i still don't understand what i have to get And=
=20
>> how to apply it...sorry :(
>=20
> Or you can use btrfs-send to send out the content of your fs with older=
 kernel, and create a new fs using newer kernel, then receive the stream.=

>=20
> The uninitialized data is only in extent tree, which won't be sent with=
 the stream, by receiving it with newer kernel, you won't lose anything.
>=20
> Thanks,
> Qu
>=20
>>
>> Best Regards,
>> Ben
>>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Gesendet: Donnerstag, 13. August 2020 00:51
>> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
>> Betreff: Re: Tree-checker Issue / Corrupt FS after upgrade ?
>>
>>
>>
>> On 2020/8/13 =E4=B8=8A=E5=8D=8812:58, benjamin.haendel@gmx.net wrote:
>>> Hi,
>>>
>>> i have been running my little Storage (32TB) on a Ubuntu 18.04 LTS=20
>>> Machine with btrfs-progs 4.17. I then did my monthly upgrade (apt
>>> dist-upgrade) and after a reboot my Partition could not mount with th=
e error message:
>>> "root@Userv:/home/benjamin# mount -r ro btrfs /dev/mapper/Crypto=20
>>> /media/Storage
>>> mount: bad usage"
>>>
>>> I then proceeded to run a btrfs check which gave thousands of errors =

>>> and then also a super-recover:
>>> root@Userv:/home/benjamin# btrfs rescue super-recover -v=20
>>> /dev/mapper/Crypto All Devices:
>>> Device: id =3D 1, name =3D /dev/mapper/Crypto
>>>
>>> Before Recovering:
>>> [All good supers]:
>>> device name =3D /dev/mapper/Crypto
>>> superblock bytenr =3D 65536
>>>
>>> device name =3D /dev/mapper/Crypto
>>> superblock bytenr =3D 67108864
>>>
>>> device name =3D /dev/mapper/Crypto
>>> superblock bytenr =3D 274877906944
>>>
>>> [All bad supers]:
>>>
>>> All supers are valid, no need to recover
>>>
>>> I now checked my dmesg log:
>>> [45907.451840] BTRFS critical (device dm-0): corrupt leaf:
>>> block=3D22751711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D4=
096=20
>>> invalid generation, have 22795412619264 expect (0, 207589]
>>
>> This is caused by older kernel, which writes some uninitialized value =
onto disk.
>>
>> You can try to fix it with this branch:
>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>
>> Or you can use older kernel to delete the offending extents.
>>
>> Thanks,
>> Qu
>>
>>> [45907.451848] BTRFS error (device dm-0): block=3D22751711027200 read=
=20
>>> time tree block corruption detected [45907.451892] BTRFS error=20
>>> (device
>>> dm-0): failed to read block groups: -5 [45907.510712] BTRFS error=20
>>> (device dm-0): open_ctree failed
>>>
>>> Google inquiries to this topic led me to this link:
>>> https://btrfs.wiki.kernel.org/index.php/Tree-checker
>>> It tells me to mail here first so thats what i am doing. I kind of=20
>>> suspect since everything worked perfect (Memtest also no errors)=20
>>> before the update, it has to do something with that update. I am=20
>>> wondering if it would help if i deleted my OS Disk and reinstalled an=
=20
>>> older Version of Ubuntu, like
>>> 16.04.6 LTS ?
>>>
>>> Since then i upgraded to 20.04 LTS with BTRFS-PROGS 5.7 as a lot of=20
>>> forum entries said it would be wise to use the newer versions as olde=
r were buggy.
>>> That brought no help as well.
>>>
>>> Since i am no Linux/Unix Expert i thought it might be better to ask=20
>>> now first as advised in the link above before proceeding with any oth=
er plans.
>>>
>>> I find it hard to believe that all data is gone, i feel its buggy=20
>>> behavior as the partition and everything is still there:
>>> root@Userv:/home/benjamin# btrfs fi show
>>> Label: 'Storage'  uuid: 46c7d04a-d6ac-45be-94cc-724919faca2b
>>> Total devices 1 FS bytes used 28.23TiB
>>> devid    1 size 29.10TiB used 29.04TiB path /dev/mapper/Crypto
>>>
>>> Best Regards,
>>> Benjamin H=C3=A4ndel
>>>
>>
>>
>=20
>=20


--rYub8vFop7DqBtyI6UknklBlNXpm1VlWI--

--shLliXoj2gOVBSN688O0kaW8YzIcfRron
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl814U8ACgkQwj2R86El
/qgoCggAoW2ZhY72opCiAtCuzd0uh5ud0vYbrG3Mft2EvDYmGDllJltxZv/sOM1v
84Bl1sM+iz8yycQZA0HAbypZUDWkAqq7pc6UeqfovZ8z2E6nJBSqCTzmK2wmAKjC
J77/8TFLBQlKtXd/CE/QR3b2VL1dZvI3r0fab2uwxsX3RgTs8KNg0+HossAJAoSd
sMG6g824iObiDH2b0OVTJNcIv0hMrsdxes6Avm39PvpqOnpiiT0W3GGnEgRh+uhs
ymJ92ANIcPzMqedWz0dhhXq/kP4deY0QzTPxWBoYlxo+IQ+i6RCoZzsXuLWG1rsV
3SqDRGdPfpUrKy704ExceB+FhwwEJA==
=fAIa
-----END PGP SIGNATURE-----

--shLliXoj2gOVBSN688O0kaW8YzIcfRron--
