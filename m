Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE72676A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 01:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIKX7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 19:59:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:53549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgIKX7T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 19:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599868756;
        bh=HJpDDq5T3MEEdud8Z3KWrnTjYLujGYhrdnNggo9RD8U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QHw0lVsH5McBeQudzktEZGqSjXKt1ldfAf8wuHS4ns5B+Hforrs3wjG13qOBLzx1g
         Rnz/PLS3XDZ2FbQ7XyxGpMDHSUiSyhz9W9H4zi+5Jc5BNrW7Tif8jJKFcCiqjLNwS9
         tnTH7EeMrHo/mJVFEgu5/9mQPBFpTXiUlYJHFcR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH9Y-1kmuNj1hvQ-00cffW; Sat, 12
 Sep 2020 01:59:16 +0200
Subject: Re: Not all deduped disk space freed?
To:     Zhang Boyang <zhangboyang.id@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <66ea94f5-ba6b-da68-7d6b-c422b66f058d@gmail.com>
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
Message-ID: <afc12c24-5d2c-3d97-fa25-3dddfd3421ff@gmx.com>
Date:   Sat, 12 Sep 2020 07:59:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <66ea94f5-ba6b-da68-7d6b-c422b66f058d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G21QwbtjPKsRAbyUky4TMO8NEFAhr9qCQ"
X-Provags-ID: V03:K1:sn1kqXzD3qoNMwwDaO2Fvjhj2HWX5lEpBpK2q+BmlmAUbsT/IE+
 z8LBglJpf94ZKK7mBa21KHeAXdF52LFxwKlhq52hxdOGnCPS7kl2O5X6IODFMzS/moIP998
 XXZmqL3gu+/CGSwAc+A+GDsrsZ6Vzq3UMrIsdtq0xSpUiTsYSJxpe6WnhdNtBSdvlGjtNSp
 K6AxXlriHkqVJ4bdbEvnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0tRjo+Lpjc=:Tzx1tauOAEOjZ0Wz6QzVWo
 K2igrjRZhWvv8mk3IdK60v7/U6Shw/iGPITv7k6nSlqKddG0qRk0Nal5ru6W/c24jYl/sKTEP
 6Q1NgD/fm7rhXztZXhPZUmnL+4k91/OV8AHtZOYuD0W71YgdVOunf8gG81QVWk+KyoG3Z1nAD
 nk6gsCY7AICt2Nqi6B7WySt8zhq2W+kyTabdgLFf/noPsNEz1h6tr+3JzqVWlPBs48TUlkKS/
 pwhkyp8HR0nhlymadFNJawarPOsOtFOwQLqEYGav1pEe3AZE1vxzMlzTmjE0Vp46frAZbUUaT
 NaRl4N37t5lrzzlHs44MzDwbG7CWLECFvWEVxJB7e2fV5nzxbo2HrL3+h1XGru0iCztH1Vgme
 RIS5ZAR568QmG6wH/OMVLzeCNw3DAkHxgKk+3SlBHc7Ibb9TYy5HOM1FkOKIH4ELmg6KYQBlZ
 K6rihp4L8mf4vRdpPQOM0s4lWmBibVrR7dYtKQatUgdZG5hI1TkDxeE7Sm4EmzG4L3sZWWFkD
 7W3mFnPl88Y2xU0f4cnuj9qliIQ7TKTazS9RzZZk7FkfTzfsXgc2L3kteKsloIiPi66ifsPYM
 zBw9G8B6voQBbh9cc/ZLlxaprwBQ342wnRsTqd4NXSqZtP6RWQ4yBUzCyH/1uXiCVxNw6KTqG
 k6AZR5SfuCCZbE/31w+E44X279231AIN+ZEcS6VSacJdgCX4rpGG//XJVlo+WVzTU4+FChScZ
 WTvJgHjzK4jHwGH39Fx0VeryE5U9PQclK+lcgyeP9NbowhKeyUMSqs7iGsfS3h4fJOI3mSYh2
 +j++A8mhPtjqANwGPbcV6SXhf45B8X8PKHZNdyNQIKaczdKXw/g7tNqI7B9ZZ4CeOWSEQGsu+
 ZqTERrNOiys9j5WP97kt6cr/s9c05Pyo9Xz6DsKNpAZnFXE82S6ALX9JHi9imHZjXaljwzBH8
 OlQ+02Kg7nKh3lfSrLSu7KEVh3IJOeEapAGBEUNxE8YSLObPcDwAjrxuNPikatTGNuDb9eSEG
 3iFOsOPrmhvTXC/ReGCGhZQmhaWeP9xJ0hddfnCq/ueJ8AEht3Hm1IT/W2i862uW5SicGlc7Z
 gIstI9xauGw+jg1OvQI/0zL5tyZ5WBIB92uDOaDJmyYTayjwBzkbUIyoVzJFptP3R1bNpjGnG
 n5iBlAtHyax0ixXC9QcTWjl386oI0DQch5LCQV+bsipiI8KwZxr7GeGQZULgSvhfdSbWOX8bg
 EEH7h7Pxd++z34N3xQ0YEjmG5MqqRX315cn+UJA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G21QwbtjPKsRAbyUky4TMO8NEFAhr9qCQ
Content-Type: multipart/mixed; boundary="pBOqtrlE8wRY5iMvhTlkAyD8ROseNeaay"

--pBOqtrlE8wRY5iMvhTlkAyD8ROseNeaay
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/12 =E4=B8=8A=E5=8D=881:51, Zhang Boyang wrote:
> Hello all,
>=20
> The background was I developed a btrfs deduplication tool recently,
> which was opensourced at github.com/zhangboyang/simplededup
>=20
> The dedup algorithm is very simple: hash & find dupe blocks (4K) and
> ioctl(FIDEDUPERANGE) to eliminate them.
>=20
> However, after I run my tool, I found not all deduped blocks turned int=
o
> free space, and `btrfs fi du' [Exclusive+Set shared] !=3D `btrfs fi usa=
ge'
> [Used], as below: 2932206698496+945128120320 is far lower than
> 4119389741056

This is mostly caused by btrfs extent booking.

Btrfs will only release the space if all of the extent get de-referred.

So the most simple case would look like this:

# mkfs.btrfs -f -b 128M $dev
# mount $dev $mnt
# xfs_io -f -c "pwrite -S 0xff 0 8M" $mnt/file1
# xfs_io -f -c "pwrite -S 0xff 0 16M" $mnt/file2
# sync
# btrfs fi df $mnt
Data, single: total=3D24.00MiB, used=3D24.00MiB
=2E..
# xfs_io -f -c "reflink $mnt/file1 0 0 8M" $mnt/file2

Above reflink would be the same as dedupe range 0~8M of file1 and file2.

# sync
# btrfs fi df $mnt
Data, single: total=3D24.00MiB, used=3D24.00MiB

So that saved 8M won't be freed until that all of that 16M extent get fre=
ed.

This also applies to hole punching and other writes.

Thanks,
Qu

>=20
>=20
> root@athlon:/media/datahdd# btrfs fi du --raw -s /media/datahdd
> =C2=A0=C2=A0=C2=A0=C2=A0 Total=C2=A0=C2=A0 Exclusive=C2=A0 Set shared=C2=
=A0 Filename
> 4369431683072=C2=A0 2932206698496=C2=A0 945128120320=C2=A0 /media/datah=
dd
>=20
> root@athlon:/media/datahdd# btrfs fi usage --raw=C2=A0 /media/datahdd
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8999528280064
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4144710549504
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4854817730560
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4138705166336
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4856449110016=C2=A0=C2=A0=C2=A0 (min=
: 2429040244736)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.00
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 75546624=C2=
=A0=C2=A0=C2=A0 (used: 0)
>=20
> Data,single: Size:4121021120512, Used:4119389741056 (99.96%)
> =C2=A0=C2=A0 /dev/sdc1=C2=A0=C2=A0=C2=A0 2559800508416
> =C2=A0=C2=A0 /dev/sdb1=C2=A0=C2=A0=C2=A0 1561220612096
>=20
> Metadata,RAID1: Size:11811160064, Used:9657270272 (81.76%)
> =C2=A0=C2=A0 /dev/sdc1=C2=A0=C2=A0=C2=A0 11811160064
> =C2=A0=C2=A0 /dev/sdb1=C2=A0=C2=A0=C2=A0 11811160064
>=20
> System,RAID1: Size:33554432, Used:442368 (1.32%)
> =C2=A0=C2=A0 /dev/sdc1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33554432
> =C2=A0=C2=A0 /dev/sdb1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33554432
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/sdc1=C2=A0=C2=A0=C2=A0 2429196152832
> =C2=A0=C2=A0 /dev/sdb1=C2=A0=C2=A0=C2=A0 2425621577728
> root@athlon:/media/datahdd#
>=20
>=20
> That's quite strange. Is this an expected behaviour?
>=20
> Thank you all!
>=20
>=20
> ZBY
>=20


--pBOqtrlE8wRY5iMvhTlkAyD8ROseNeaay--

--G21QwbtjPKsRAbyUky4TMO8NEFAhr9qCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9cD1AACgkQwj2R86El
/qj24Qf/b+rzgpARwM9ZrKeDjSXfFYOe1tXLFKBvEJOWu7z4aLbU1A6trdl1/8Eo
6fnMD7Cta3Qc3JAsWR4u4HJMoFy7JpJdXbFd6o+7+yQm3WaiJh2xTx9K+szhfIs3
smnWiNXGZqksozc2gZ3yzXtlgBxEwJ6gOIPAHb3YeP1TAmnWr/bSc+/uLVVJ8F3g
/KYXluWAvdJq+BzwJlc57KUSjh9lpZcOYoou9hAohiLmqyjjrW9inEfY7UI1yad1
5lQT5JGWEjRukVZpkD8fh9uGTProHkzSRNiA9QuAZ/ZRoNFxPzBQlb787oCMxigd
B5769qH37e+hWmsNJva/E+rky0e+dQ==
=wT6f
-----END PGP SIGNATURE-----

--G21QwbtjPKsRAbyUky4TMO8NEFAhr9qCQ--
