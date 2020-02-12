Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CED159E2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 01:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBLAlS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 19:41:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:48311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgBLAlS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 19:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581468075;
        bh=9IbiQ45JKV7UoDF9Ip/BG7gg+uiaPZh6WIBDHX7GyCU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Yqs5s+y8iQvPVJRTMs6Vb9t6ASVTa2vvchDPJ+muODNtTo7RM07NLhLbb8nZLnM21
         VKXzxlF/q958jGdvCBUVsqjwLFKtR/+pOgrjFz9s6Rcb6heVDBrbFruxNo7yvgvmkF
         vBYHbYjal3fqDKmVfGwY/R6hzZY0JFPG6+u2sysk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel3n-1jbqBj3Rbx-00amoJ; Wed, 12
 Feb 2020 01:41:15 +0100
Subject: Re: tree-checker read time corruption
To:     telsch <telsch@gmx.de>, linux-btrfs@vger.kernel.org
References: <5b974158-4691-c33e-71a7-1e5417eb258a@gmx.de>
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
Message-ID: <e35d0318-4d3e-50ce-55b1-178e235e89d7@gmx.com>
Date:   Wed, 12 Feb 2020 08:41:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5b974158-4691-c33e-71a7-1e5417eb258a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lldkIf5sZ1Y0OYW8Uvi2Z0Xcgut0RBpe6"
X-Provags-ID: V03:K1:jo7P1zqA4dO7yaV1DbRiahdh7POoMJIzcmPd3TCgq0LcVcYADeu
 P6H7lTALyYoURqd+3Bc41dWdMiEGdO5qJLAkgYrnOhMKE6vM/K/DkwrnWBPAtOBT3BZhYex
 AGIWTObdlqu72y7pajodOorwmtRvEiEDPKPXFXlamDC2fl+hWxy22xkJ+Nt/web2VCYGTgS
 ai7itIFMbcNCTCLX9S+UA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ra5/owq3cGs=:jELEKeZWvm8v1w0rFuY9JH
 r2EBGrO2DPti7c92sMt5kM0QeHpIY/MQTnV+KQfqScoF6m5XF3t+de/Yj0l3D968fMwC70MMg
 VIdj/9n/NBgNRsuTW0dhYxY+8IZnxEW0SxrEXGV13q3dnW5dw6DoYwNzEQXHBxVBjiSlx9AdP
 XFt8jgBXfcGjYKAbd0pYtNRzVsOMh7ubdNfNvn6QIej+hz5xtbDH1nne041oNXgW5CRx15yEu
 CghYk3JsZGdha7S7XmBfgVlifQ9T6rYN/uObJQnYGeZGg7HZEAScGUsbJo1uarjSFIqq17am8
 pRp1ENgdMtnxVQtiJ1+9G1YqLitHySS/vloT+dtIvIpvmkrFdV0xd2ZPnA3QFKQyw/0FR7abW
 bbdnhExWIgEzNqTP4UyoqFKQIiGbdaYC1s0EDDr9DrPEDjw10dqen0keV+HYY2+K0khsHs6t6
 mBZUqa7ei37T++0hme+GldmK+SVeNbGiGy4i5gt4xjUBmEF43Oo4sXKsFhdJiS2Hu5QBY0YJq
 4ibRys5yuqHQYEjvqfWPZ+JSsge/6v3SrQB8EsDD4ihCJ8jvte0eu15eM/FO3EA/WteFHdFHW
 aEj+5gHIyxfsolNyh45QB9rAGwONeZK5dzbkiBfT83tcrc94iC3nNYEBnoHv3RegiUM3jcB9V
 obBRewRVK3Gb1yazYpV2w7Qm02W/k4uev+d90HGFNHShwAdFOsHnjeblz0EuO5bOv2+M7leSd
 b4u2pDUzFIGKfyYPEQSsyWLXRk5ZcV9lainfJ3KTvsCDqod0VmLM8PrJXVWD/iAKgl0yIVGts
 nrNNPD0N5yotR0m+JoUH4bIOyNDxkTz5WhGK8KWb+vAScxOGaWK1XOessh4ef1sM8P9bWxC2S
 vW0kYdTWu34kGHoqFkWaaF/tvw9uQfI3uCjXYF4CR57etUKKzgccD67sH6ZQ2Rb84ZHV2jnU0
 FxjXcEXvJTHgWUVXiRXH/ivq9++Hne0jBMH1bBYu9IimQnXSlCnU2VjRI4SNn9ftXQ8PmZ38E
 EXRWcBYlN64JL3U8DOsq0iuREBjuAWgNFwZ+3GQgRNGFJAjr/szunubNZl/Nyirk5dfUaH2qE
 mtTBbH9cgJMr0XtAal03jlcRc2PKQUzM75PQukl58V4as81FJthOaBunF6O2s3OUcvThZ9ArM
 /U24jWJ6PZGYN+yeAyy0UVnFX2v4U5Ptku7+hosomvv6nuFCzJM3M/2NuUJ8xv8Iy5g6GCG11
 FOPTOxoCT6alozGfW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lldkIf5sZ1Y0OYW8Uvi2Z0Xcgut0RBpe6
Content-Type: multipart/mixed; boundary="qLqpMdnMcwAOfaqst2ZZsAGCNoSKs8W3T"

--qLqpMdnMcwAOfaqst2ZZsAGCNoSKs8W3T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/11 =E4=B8=8B=E5=8D=8810:17, telsch wrote:
> Dear devs,
>=20
>=20
>=20
> after upgrading from kernel 4.19.101 to 5.5.2 i got read time tree bloc=
k
> error as
>=20
> described here:
>=20
> =C2=A0=C2=A0=C2=A0 https://btrfs.wiki.kernel.org/index.php/Tree-checker=
#For_end_users
>=20
>=20
>=20
> Working with kernel 4.19.101:
>=20
>=20
>=20
> Linux Arch 4.19.101-1-lts #1 SMP Sat, 01 Feb 2020 16:35:36 +0000 x86_64=

> GNU/Linux
>=20
>=20
>=20
> btrfs --version
>=20
> btrfs-progs v5.4
>=20
>=20
>=20
> btrfs fi show
>=20
> Label: none=C2=A0 uuid: 56e753f4-1346-49ad-a34f-e93a0235b82a
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 92.54GiB
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 95.14GiB used 95.14GiB path /dev/mapper/home
>=20
>=20
>=20
> btrfs fi df /home
>=20
> Data, single: total=3D94.11GiB, used=3D91.95GiB
>=20
> System, single: total=3D31.00MiB, used=3D12.00KiB
>=20
> Metadata, single: total=3D1.00GiB, used=3D599.74MiB
>=20
> GlobalReserve, single: total=3D199.32MiB, used=3D0.00B
>=20
>=20
>=20
> After upgrading to kernel 5.5.2:
>=20
>=20
>=20
> [=C2=A0=C2=A0 13.413025] BTRFS: device fsid 56e753f4-1346-49ad-a34f-e93=
a0235b82a
> devid 1 transid 468295 /dev/dm-1 scanned by systemd-udevd (417)
>=20
> [=C2=A0=C2=A0 13.589952] BTRFS info (device dm-1): force zstd compressi=
on, level 3
>=20
> [=C2=A0=C2=A0 13.589956] BTRFS info (device dm-1): disk space caching i=
s enabled
>=20
> [=C2=A0=C2=A0 13.594707] BTRFS info (device dm-1): bdev /dev/mapper/hom=
e errs: wr
> 0, rd 47, flush 0, corrupt 0, gen 0
>=20
> [=C2=A0=C2=A0 13.622912] BTRFS info (device dm-1): enabling ssd optimiz=
ations
>=20
> [=C2=A0=C2=A0 13.624300] BTRFS critical (device dm-1): corrupt leaf: ro=
ot=3D5
> block=3D122395779072 slot=3D10 ino=3D265, invalid inode generation: has=

> 18446744073709551492 expect [0, 468296]

An older kernel caused underflow/garbage generation.
Much strict tree checker is detecting it and rejecting the tree block to
prevent further corruption.

It can be fixed in by btrfs-progs v5.4 and later, by using 'btrfs check
--repair'

Early btrfs-progs can't detect nor fix it.

Thanks,
Qu

>=20
> [=C2=A0=C2=A0 13.624381] BTRFS error (device dm-1): block=3D12239577907=
2 read time
> tree block corruption detected
>=20
>=20
>=20
>=20
>=20
> Booting from 4.19 kernel can mount fs again.


--qLqpMdnMcwAOfaqst2ZZsAGCNoSKs8W3T--

--lldkIf5sZ1Y0OYW8Uvi2Z0Xcgut0RBpe6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5DSagACgkQwj2R86El
/qj1OQgAsLQC8PWXi001tV5xYsI7Dp4J3blcZc7BcmlCla09Cx96cUID+0b/mIU6
jMW3VKlqCyg8SkslVAvkOZEgFEDPWuU8p3NtBjtMr3vs+zitn+eV+tpafqi2ghiP
TY39AV7gXY9bNeBgKXAs2fz8BjRhA7qiIgaUNFjbjUFYG6GCxfJF7oclVETY7WoT
lRBOJjixcQO3xx4ruv7Qx7V+tm0Q3RevhxZkAmU8MtNmRJvgqZM63mrF1L3q0W9z
FI5+7zq9gXLO7zlXZLDDTs1bMPx02n8QhtDkYnhSvFnmW+0SSEnFb06dr3xWCGdV
2J5ubsrE+xVizDdIz3ZaecgUrlN7Kg==
=crT7
-----END PGP SIGNATURE-----

--lldkIf5sZ1Y0OYW8Uvi2Z0Xcgut0RBpe6--
