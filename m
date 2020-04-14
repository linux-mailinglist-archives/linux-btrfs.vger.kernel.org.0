Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319A21A76FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437394AbgDNJH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 05:07:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:50681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437383AbgDNJHw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 05:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586855260;
        bh=cOTqHZQE3uoSa8lWvyhRSZ007KCeumoWEhXhnJ2iS/c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lX6kqfg3sR41bg+XpazxLvMNLH/mphiMqDOu1Q6XzonTV8qKFRjlpQ6zl+O5D0pHe
         D4lb2ROEZpeo39vOaEGVT07dCw1pWt9Zp00onJwGy7LWKvPCkM+ySC3bY9HE9zNK1d
         WVbELF3aOMvrf6jpBbKz2bEOPmqGiVmaDrmgpqYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsUC-1jX2z60gtc-008rij; Tue, 14
 Apr 2020 11:07:40 +0200
Subject: Re: balance canceling was: Re: slow single -> raid1 conversion (heavy
 write to original LVM volume)
To:     jakub nantl <jn@forever.cz>, linux-btrfs@vger.kernel.org
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <424ffd2a-2a9b-1cef-c3ac-ad2814f037a1@gmx.com>
 <ccd87fca-56f2-3fc8-81c0-bdfb2f4aa9f8@forever.cz>
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
Message-ID: <d9d65223-c1ee-afc1-dc25-158bc5e83b12@gmx.com>
Date:   Tue, 14 Apr 2020 17:07:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ccd87fca-56f2-3fc8-81c0-bdfb2f4aa9f8@forever.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JXzaQHCR8ViAPtgv9HA1u9j8JsvBONyRo"
X-Provags-ID: V03:K1:MXvvxiyERgx9TgUpaPrUB7JSrQOJgAZr5ukgh2xHlx9A/x4l5bi
 zNoGtqo+WZMaEXOMfBRywT8wAidE+k1a2JY5+8GoFz53UTp0nuq9hPvb0OYP6nY7o66BhRn
 n93DpVfnfoXVgkH8dEN+y7jPxn7jqh0mxcZ1ZA/j2xYrYf+GkXyRL4GRRKHTFwx1+DC+yAd
 CjasjQLgEFuAXa2PE04ww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TleNxkfVVQk=:ZzZAtaGIYWhDAvQHGhvRGC
 kAHzip/hLOBPX/gWXq0YURfYDJLpyS4aGWCCzJEA+SQDtfgvLwWD6G/tAEtXdGj8UvCf/5I42
 LaRKqVT5rZxnYpSwnMRl1PBLL1S7sdM+gKw78CoPtvREE+LRSrsaQ46PxCX5s21qlVJRBudfO
 fOOC5IORUV+t/imt0t2OUQbSh3BpfWAdIoYHEXErm67I3Tg6AAdaNs+NyVy56sjFrNc41GfHN
 lgSCC1FmZW21HvXyVps3JVdnueUW568J8gr2wkNsRmxiM7k18x02iYjEd89Pj1BDx5WtIqvoI
 ZUUf5fEt0VzXT7zOh8ZQe1THh/U2fmn7lFA42uKhbe08luTtNxEcpzCyAiKbksTu2vXRjbCBz
 5A6CgGyw61KV40/pqzM6OahbhRlMJzpsGbXK0x+usQwUL1Hy7QDyu+c7bj4JjcMYXSEzDPaSJ
 ++spykJhrIvW4hwrX1xm8U8NVLYHxh2tPCvksaBhahs5HPeejnA3Mp0GhrBLvjdSng59ntL/U
 wJm2bBJXxltx/5/k9BT1QN9VucVQqn/xvCL2N7WVe6/pLFbWRfHR+PMbtN+q+4V913cZUxOVC
 diOamV0MyIaNW74FEt1NgYEM4F7VKqYq51bkICaUS5BzvKpqM7n4KlOy+yuAb25BvXezGK8jT
 4VGueqNlhpnkh1kWQWhgP4fn51Kj3t/ld9YkVhB4slRn/uBK3+kJrh66hzbrv4wvOL35f+krO
 19PFmTKNWN0b+JWGZd0SLRy9zuQLm56t0oEBnLQWxq2bjJqYHp/dGzyP/jd9tkJqCBrLrAoHc
 q87AHNEExiDbwTuylc4nuyWFZIU3ndBHskZDIJJNnoSnzHz0PvHwGCsA9MnWVlh+YJu6d471H
 b2mQQaT978xSruPcZBzI8RIAVqtDYASzddG2UrvgR1fwqalsJctK9kfwhoxMAs/9+ZEXnwcUF
 T6yHgsB5KewJr+EGYu863KfewpFXwCWAcwIPkEfxJmLMgsHotONAR6gwVeKElJL+hIOO+wJYO
 86CD9Dmy04c6aGwN13H9NJlet8EdCaLPTLxqG5Jmr292YmOO7twcRDBWndauDxsIfZ+AYq5+u
 Y0ZoY14ChGRVWcCd8dkGBhKc+nx8IQgLuTPIKx5wSas/yB0+GjaLxdqwMblVgTdLpsNQhH6rC
 sdpAQHG+i8FuiXoTFinbjHc+M3KwB+hJR787u9K1ytU1aXsj4WCLHDaQqG4uLppOItlP324aq
 omSHZ9rCaviIHZu9S
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXzaQHCR8ViAPtgv9HA1u9j8JsvBONyRo
Content-Type: multipart/mixed; boundary="wQlacSIiJVruUQBOuzAWokaDwtAnexaau"

--wQlacSIiJVruUQBOuzAWokaDwtAnexaau
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/14 =E4=B8=8B=E5=8D=883:09, jakub nantl wrote:
> On 15. 01. 20 4:26,=C2=A0 Qu Wenruo wrote:
>> And due to another bug in balance canceling, we can't cancel it.
>>
>> For the unable to cancel part, there are patches to address it, and
>> would get upstream in v5.6 release.
>=20
> Hello,
>=20
> looks like balance canceling is still not 100% in 5.6.x:
>=20
>=20
> # btrfs balance status /data/
> Balance on '/data/' is running, cancel requested
> 0 out of about 16 chunks balanced (9 considered), 100% left
>=20
>=20
> Apr 13 23:30:52 sopa kernel: [ 6983.625318] BTRFS info (device dm-0):
> balance: start -dusage=3D100,limit=3D16
> Apr 13 23:30:52 sopa kernel: [ 6983.627286] BTRFS info (device dm-0):
> relocating block group 5572244013056 flags data|raid1
> Apr 13 23:31:05 sopa kernel: [ 6996.237814] BTRFS info (device dm-0):
> relocating block group 5569073119232 flags data|raid1
> Apr 13 23:31:40 sopa kernel: [ 7032.178175] BTRFS info (device dm-0):
> found 17 extents, stage: move data extents
> Apr 13 23:31:46 sopa kernel: [ 7037.711119] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> Apr 13 23:31:49 sopa kernel: [ 7040.767052] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> Apr 13 23:32:00 sopa kernel: [ 7051.885977] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> ..
>=20
> ..
>=20
> Apr 14 06:26:06 sopa kernel: [31897.468487] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> Apr 14 06:26:08 sopa kernel: [31900.034563] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> Apr 14 06:26:10 sopa kernel: [31901.719655] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> Apr 14 06:26:12 sopa kernel: [31903.334506] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
> Apr 14 06:26:12 sopa kernel: [31903.856791] BTRFS info (device dm-0):
> found 17 extents, stage: update data pointers
>=20

Thanks for the report, this means one of my original patch is still neede=
d.

And since that patch failed to pass review where I can't explain under
which case that can happen.
Now it has been proven that we still need that one.

And let me check under which condition that happened.

Thanks,
Qu
>=20
> Linux sopa 5.6.4-050604-generic #202004131234 SMP Mon Apr 13 12:36:46
> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
> # btrfs fi us /data/
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0 3.71TiB
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0 3.71TiB
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0 2.00MiB
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0 3.30TiB
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0209.16GiB=C2=A0=C2=A0=C2=A0 (min: 209.16GiB)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0512.00MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>=20
> Data,RAID1: Size:1.85TiB, Used:1.64TiB
> =C2=A0=C2=A0 /dev/mapper/sopa-data=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 1.85T=
iB
> =C2=A0=C2=A0 /dev/sdb3=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 1.85TiB
>=20
> Metadata,RAID1: Size:6.11GiB, Used:4.77GiB
> =C2=A0=C2=A0 /dev/mapper/sopa-data=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 6.11G=
iB
> =C2=A0=C2=A0 /dev/sdb3=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 6.11GiB
>=20
> System,RAID1: Size:32.00MiB, Used:304.00KiB
> =C2=A0=C2=A0 /dev/mapper/sopa-data=C2=A0=C2=A0=C2=A0 =C2=A0 32.00MiB
> =C2=A0=C2=A0 /dev/sdb3=C2=A0=C2=A0=C2=A0 =C2=A0 32.00MiB
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/mapper/sopa-data=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 1.00M=
iB
> =C2=A0=C2=A0 /dev/sdb3=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 1.00MiB
>=20
> # btrfs fi show /data/
> Label: 'SOPADATA'=C2=A0 uuid: 37b8a62c-68e8-44e4-a3b2-eb572385c3e8
> =C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes used 1.65TiB
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 1.86TiB used 1.85TiB =
path /dev/mapper/sopa-data
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size 1.86TiB used 1.85TiB =
path /dev/sdb3
>=20
> jn
>=20


--wQlacSIiJVruUQBOuzAWokaDwtAnexaau--

--JXzaQHCR8ViAPtgv9HA1u9j8JsvBONyRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6VfVgACgkQwj2R86El
/qiamwf/Wd87iMNtofhCYNMv/ruufY9+kdXBRniUtzGwLDQPg7KXRacp34x1aezW
jeZAJdV2eJz0aZZZjWeNqXena1BGw/MIhSRBllvQHFE+LhwiwQ4oTahS2xRJXx2q
VusLyyCZLKKY0A/Gjai/cYxjHLoIoVm6zsKFpVmfVq5TYSsZdy3u558lpYVk4Epe
nNEmud17Z8WpO8n2dNWbW0dheTjseQZyv04gPdRfidHWI0dneP/JkP11w7uSrtma
SnfbYDR6K4gp6VGHZmeD+u3wteZxD41VuerxiP199aEnEWppg9xqfs2L3SxS0d8P
L+VHV/sPAA5XzcRwRYgk3kdlbqRZjQ==
=oBmH
-----END PGP SIGNATURE-----

--JXzaQHCR8ViAPtgv9HA1u9j8JsvBONyRo--
