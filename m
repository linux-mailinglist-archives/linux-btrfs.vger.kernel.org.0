Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DDC252A7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgHZJjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 05:39:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:33807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgHZJju (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 05:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598434787;
        bh=PfC3qHJYn5tSN65qeY92tfygeWOM/GO06FGHkkO3zBs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MzGFVwJRJ96mvqMJk/+nt8HP5M5b1xYalsgPCEI8jy6yxeZBH/RNd7w2ghP9jnN5F
         469K4G/eg1HQ0AOuLSErKAkvdWoC+s1Gn5ERvuOs3Ci9CcIk40P7mRt738TzP7Klfp
         zOYKu8Z4fFF6SSCwIpaXNL77Ojw3EHpDwJyejJAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTABT-1k2urd1q6p-00Ub2q; Wed, 26
 Aug 2020 11:39:47 +0200
Subject: Re: btrfs-transacti -- change from be/4 to idle (?)
To:     Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
References: <806a0681-6a1b-30d0-de28-8f18019913ad@dubiel.pl>
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
Message-ID: <c4359a4d-ae86-1b12-1a33-9372fd81e84e@gmx.com>
Date:   Wed, 26 Aug 2020 17:39:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <806a0681-6a1b-30d0-de28-8f18019913ad@dubiel.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1mI2amp7UDVxrnHuGoyJe7eOy9QISuJST"
X-Provags-ID: V03:K1:ehX58gzD8otNdoAi5+Y4+pUuLHgZrYX5x+YCamS+AyBXPESfoBj
 0tqDvgVW+G3Cjt4vtqSaQDhxwYh2/xSr1B+8kRvi1opZr3FiweFk2czDfjt2A9l4I8vK79o
 e50cQFJ+6w4el6ZSBYFqkqXkT93kmsGeQ4AQKXAQmLYm4cyL2SNSbOX7DC+g6ZdxSjj4RnX
 Uk1j7/5p7J4izxDWDM/+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GJFwKgNDesc=:hvuIV1DqE+eLfL8FZeetuw
 eOTeUackq4nEUl1fY6IXo/thI7AISMGCNKsLcEMJIN+GIrO+1xU5QrOAHhzPEAWWxFtjCp/aJ
 8zN6GKY3TC84pBhmIuiYk05hs1r33hW2msQO5C4MovqmlDR0lXoMQ+SpELipo4rBP944GzV0x
 3rJ2RmvnHKJU8hje2HVIXYbnQtLsmKd12mSdasLYkO58HXl00uy9/AN2xkH+rKnm3C8VBXU65
 yVcav+HXIvKkAD4y57CNjwNfKxGnlyHQ00p10CM65FfDoH8LvLAhhIitLDCvtLhYM1/wGvRNk
 uvCOyfFv1lDXJCfw+LLDBCjnzt/GH/RLswy9z7l49G1IkyDHRh9gAd5dKduhuYFlm2WxUMyGy
 73Ug3ajniAz66CxYmpqjNWGfB8wf/8NHlsrF7nb3sR9zxwJ+dHeIIuuyJ9yAR2gMHpoeAxUNr
 giGPA8vpO+adIlLtUWduCpLPkG64FVG+fVxV6vFKks4MNGMgZp02eHv0BEJhteQjXMbSiCrKi
 YJfX/06aCgo2LDfojSDxprvhHiKOL3feWAx56b8JbG25/KTMmVli06vw6YzcEla3MTrnbmizA
 s9QYFEKk0V++1wkFhK1I4lveebODejGMMOsThzNBcoN3TdjWgulTiNSJjfopzI0a1eQQHgV6D
 rlGp8f6I1Wc3ZJ0cdeemZ36CqSHoD4ec0fzWcQwmHRKAoK/SPV2Tc2iXQGarqPTemWn6E2ea6
 oaYpDPUuUGgXQhv3K1iK8VeNX/UYi5uv+sXhHBuE0QwweuekYDeag9MDRndYXVHs+w7hofAhR
 pxnB7dsxQr7ne2UvW2lDDbsh0Li2X4+5P2DDRsIglJcoCswaXZxje9DMtP1z0G5r+NFZxMJv7
 yERJl99WlYSp2M67v/WL5VeQJ+Op8uJEgs+Hf1HratyHKmuBFXvBqcxSfCd65NuNdzHrl1QLQ
 Cj7jVcUbm3jnWiKr3XNoFQCA5Sj4vCGgKChKMRaAdDnqqj+sEySc4rptjaKW4LAMt73yeyFjV
 0wuqcIEjcbCwXCohJq/jWHY1PnvjicE5qvxKivrgnBzwehFYJCus1cOph/B57j1/VJWV9+DRm
 CALyQ9EFV2eGIbzHsbYo+oQjyzaLAHBong25SkAjAzYOhjlFzu+9ETSZ7lssXZjBOOWjykor/
 Ht+/JRa7LZmhh4YIwpgMiX2x7cYF8Ff18hRVUBsIcuJZcTEqdhtlQVoEuaU56HPx3g4NKL/er
 xyTfX2A3hhmVg+rXgnRMIJvqTE/M+swy0sDoJ6Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1mI2amp7UDVxrnHuGoyJe7eOy9QISuJST
Content-Type: multipart/mixed; boundary="0caGGanB0rlXa0zlEydPzzDwmiwA5O9Sx"

--0caGGanB0rlXa0zlEydPzzDwmiwA5O9Sx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/26 =E4=B8=8B=E5=8D=884:58, Leszek Dubiel wrote:
>=20
>=20
> Hello!
>=20
> Process btrfs-transacti takes 100% CPU time and server get very slow.

What's the workload and kernel version?

Workload can tell us if it's really a bug, and different kernel has
quite different perf characteristic, especially if you're using qgroup.
(If you're using qgroup, recent v5.x kernel should have it fixed already)=


Thanks,
Qu
>=20
> It runs with priority "best effort be/4".
>=20
> Is it a good idea to change priority to "idle"?
>=20
>=20
>=20
>=20
>=20
> root@wawel:/var/log# df -h=C2=A0 /
>=20
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% Mou=
nted on
> /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20T=C2=A0=C2=A0 11T=
=C2=A0 7.7T=C2=A0 58% /
>=20
>=20
>=20
> root@wawel:/var/log# btrfs sub list / | wc -l
>=20
> 367
>=20
>=20
>=20
> root@wawel:/var/log# btrfs dev usag /
>=20
> /dev/sda2, ID: 2
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.45TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0 Data,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.97TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 79.00GiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1.41TiB
>=20
> /dev/sdb3, ID: 5
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 9.06TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 3.50KiB
> =C2=A0=C2=A0 Data,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.26TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 18.00GiB
> =C2=A0=C2=A0 System,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 32.00MiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 6.79TiB
>=20
> /dev/sdc2, ID: 3
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.45TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0 Data,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.00TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 77.00GiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1.38TiB
>=20
> /dev/sdd3, ID: 6
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.43TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 3.50KiB
> =C2=A0=C2=A0 Data,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.03TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 18.00GiB
> =C2=A0=C2=A0 System,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 32.00MiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3.38TiB
>=20
> /dev/sde3, ID: 4
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 10.90TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 3.50KiB
> =C2=A0=C2=A0 Data,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.96TiB
> =C2=A0=C2=A0 Metadata,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
146.00GiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2.79TiB
>=20
> /dev/sdf3, ID: 7
> =C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3.61TiB
> =C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 3.50KiB
> =C2=A0=C2=A0 Data,RAID1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 235.00GiB
> =C2=A0=C2=A0 Unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3.38TiB
>=20


--0caGGanB0rlXa0zlEydPzzDwmiwA5O9Sx--

--1mI2amp7UDVxrnHuGoyJe7eOy9QISuJST
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9GLd4ACgkQwj2R86El
/qjZ+Qf/Qizel0/7idDmnKHffZzlZjfVMyyIS5KX7a8fnYm59CNf/L0XABS8mVzM
zJ8qJfeztcBSHAYTPi/j/mMpU50Hv1O7zaP0gju0HgML1Z3p9pNTFLQ4CVXK9Kt2
NmtzR+l8f+OhbOI3Bbk6CHhg3KtXOyQ/eyezWBlqJI5WiwMudPHoT8rmq8oYPlPg
WYYp4xbr0iSknlC2pAc8a5pQdH59QN6H7uQ7AHntGGIrmjSYGdciCoYTtpVRCjLY
gsnCsn8vdwOeCDZkuhX5wwHkEbbmi9IgkPNzJx8LnWGlqHJRuwNv4s2ukHmkT9tk
5umlanidL8mcXrhxh7BFt+1AW/3VdQ==
=3qXg
-----END PGP SIGNATURE-----

--1mI2amp7UDVxrnHuGoyJe7eOy9QISuJST--
