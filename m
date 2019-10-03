Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D793BC968D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 04:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJCCAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 22:00:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:57395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfJCCAl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 22:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570068038;
        bh=IAEGxfJIK/12cGH4nxKKpkmCVmBzcSU2FgynYwx9mT0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gnoFCDs7xjMUAHWNWVHdAl/6y2WtjDDmhK9/umlkIy/qjMFw11q0VvHamzPPFHlVW
         Fmw0T6un6GAS401StSu2B/38Xh03Vms9LCfpVktMGES3EdgCFIngk+q8nBewx5qS7y
         DX819KYxcgvoWlT5Lmp/3ZJ1OGCzTJR58zqZN3oM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbFs-1hxl4N1wSU-00saR8; Thu, 03
 Oct 2019 04:00:38 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
 <54a2e030-3b8f-6680-a1b6-826c2f5c0928@gmx.com>
 <d7a9650c-db8f-34db-fb7c-c1ba55159c93@yandex.ru>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <a6f68cf9-20b9-f1bf-379a-a361c4387dc7@gmx.com>
Date:   Thu, 3 Oct 2019 10:00:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d7a9650c-db8f-34db-fb7c-c1ba55159c93@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TAjVt7LVnCiZXsuXIBumR0DgYGcNyBVm3"
X-Provags-ID: V03:K1:Bt1NOLPTNwGcG+TvAiJ+bRVf5XjvL6v8VjMi1D3CGgmi68kkBZB
 hHHC+J7PqLkJBrYwnsN5MJjHeQxio/JEcS0up+QMPvV+1+eSTLlofGJvc3DcBEnsLZR4LYP
 Y76hZVwXSYgc7zrpTIS0o9cKtTRr/Sa/X4lcTeI0tP1Lvx5esb43WgfcOYeGfOwzHrR8X4Q
 cWIqhKGeP4UeVlAelkxpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:drIuotGW9xA=:jN7900bpaFXTa+QMY7iia0
 sWxB95wVd8R5netqTImJmXYok6UPVF1Na/tr7L+9j7IE4K0bSw6blxQJL3a0LeUjSuBdl8Bh7
 85mA42duqqbYDKyxaperq/GoxEfwdjx9hnTE5pZHrh2mzmlA+pNexr1aXT7cH5mSrceffyx7p
 VhYn5mnIixMStQlrSiq/ZAr3PKzX3snIwbvIqO7FjZD6q+hDcybdQ0ocIHHAMuHU/y7RHn2oO
 5nrsE67BjNVzom0FBGveesJJF4OE/9NZ/yvlm4IVLy6jcI2vFU0CWXaTY+8GeZvi4PimKcpqI
 CFENtenforaHyQFw3JzoM3hqMdekZVM7Favqrgt/XZp/nyDJ67+OJEui/9zd2t08EGqnCuVak
 YAVtn20AZQ4tton+oESADjr+pfpM6iKupM6a+FGFON++md3EwKF4++aw4xkMCdOKk7bQZxP8G
 0FNqok6Ip1oPU14dVg+uIN3WpVMT43VpiwW9HPsg44DTkCAA+OS93rsROMut5hoHqQPU+olR+
 RtJxrZugVeew8iQ8C9MPlGILNW8hH2g3zxhFpqmWi9RBUL5tv4efgyiY0HyDZ0lkhsG5BfQXo
 Bhe6pxz2pbQcaIdPP0U8Kg+GBp1j+F/sb/yoBPD/bwKsv9Mcf13TUwgG6PNgLcayEx+maZWy5
 GJpPwk78o8ZXmy6FFgDTFpMx5JuQe82zgjAwGXOCjX+AWopNdsuqG3RXxdSHcTuugDX8Eh9RX
 l8oOHIisI6lEsTieayYFLBvVmp0MrgHYzDk2nVnRjyQijgzPMhPtOXI1YJAdehFSB7RkE+5Et
 EAxQct0PC+zKTSR+XL88d0JTeWTSDCxx5Y2xA27saQ8cag2QI4hV5GuMxeT+Ou3UQNGVcugPY
 hJk/38UIVO3AgkI9BJ3MF3adPSt2zQdw0LfzRgGVF6gmoKa/Pt/5DOoDMn+hAZ6dtxIN7rhIW
 tPAIYpcD/FtrLiz+cazFfx8StAtUto6ieVSuGwxxCXPqzdtwUhRD5j0P9kClBEHBQzuWpntmj
 IwtuGFuZWnVCs72iJhlryZR71hPKvWJEsKHQhOSrqT+ANyOmal9Nh4GYMq8gQ6sovNBlh0rGB
 5cwDyRlM2tj7uoZWZu2qfxY+4VCiczNo9qhoiqVh1ZrsMYT2hqcC4CAGYrz0wmYEezkuBiwSF
 NwL4vWqlZTURuxJ/Jvt/H+g06vN1oB+xAYTxZ5Mp4j5Z0ptaJcpPJ05d++sCrH2pAXGKXD/OD
 f9F1G8GKAUBqlzKEshH0hqq4dMknuUA/nZxi1+gQC7az31HDc+3RUOu0v0+8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TAjVt7LVnCiZXsuXIBumR0DgYGcNyBVm3
Content-Type: multipart/mixed; boundary="SeFqTW3kQerSACmV1XJh6TlUkmikDrPKW"

--SeFqTW3kQerSACmV1XJh6TlUkmikDrPKW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/3 =E4=B8=8A=E5=8D=889:47, Andrey Ivanov wrote:
> On 01.10.2019 8:35, Qu Wenruo wrote:
>>>> I recommend to do a "btrfs check" on all fses.
>>>
>>> I had done "btrfs check" on /dev/sda4:
>>>
>>> attached btrfs-check-sda4.output
>>>
>>> There are some errors. How to fix them?
>>
>> It looks like "btrfs check --repair" can handle most of these bugs.
>>
>> Please do a backup and try repair.
>=20
> I ran "btrfs check --repair":
>=20
> $ btrfs check -p --repair sda4.image.copy
> enabling repair mode
> Opening filesystem to check...
> Checking filesystem on sda4.image.copy
> UUID: a942b8da-e92d-4348-8de9-ded1e5e095ad
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (0:00:07 elapsed, 509893
> items checked)
> Fixed 0 roots.
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
>=20
> After 27 hours of work, I interrupted it:
>=20
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> backref bytes do not match extent backref, bytenr=3D1985052672, ref
> bytes=3D20480, backref bytes=3D86016
> backpointer mismatch on [1985052672 20480]
> attempting to repair backref discrepency for bytenr 1985052672
> checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (27:48:52 elapsed, 3363526296
> items checked)
>=20
> I think "btrfs check" is looped somewhere. Or not?

You can try "btrfs check --mode=3Dlowmem --repair" as an alternative.

But please ensure your memory is properly replaced, or some random
problem could just happen.

Thanks,
Qu


--SeFqTW3kQerSACmV1XJh6TlUkmikDrPKW--

--TAjVt7LVnCiZXsuXIBumR0DgYGcNyBVm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2VVkAACgkQwj2R86El
/qhbkgf/a1Zxkux71uPrxaF5GOxY9rkOnxiowunnPLNJJQkGAw0kxZpvQXxbbJT4
rNs9THg4OvnRqOkpygQ34jze0XqAieeSylEtNJ2eMOSjYxZxkw5j4SmHk6zEaRy0
xtafOLMI/2Z63vGaIFaAC4UOMX89+H8Y0jvx12C80/YJjtbS+OmzPMZ+fPaNYCjk
Iu1nRqXde9m5Y4kNeKJPFwpta7f7/MK/+/YX+PJUPw5V+wLeczPBa/U9CrL+irE6
hdWRGgja7X2rKjTTBDdeM2AeuRKCEMi7nGF9KwJqdSUY3r1jkkxDlic1kQWte0fu
f1CksT4uCg7czigCC03PByo9Yd4MKg==
=iwzK
-----END PGP SIGNATURE-----

--TAjVt7LVnCiZXsuXIBumR0DgYGcNyBVm3--
