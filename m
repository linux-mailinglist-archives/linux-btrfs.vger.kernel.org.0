Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE5C1FD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 13:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfI3LLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 07:11:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:56315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfI3LLO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 07:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569841873;
        bh=lEHDCRQATH7CcUzf4Z57X6vB9vV5Um4jzL5NASXoJMk=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=WP0AAZuqxa+Z+s8epgz7HholEN58GbsWOPZLnCsuHNYxOySzJyWU6rEi7sboVGRED
         /RCoilZrsDehZApsxERyOy36lxGvdBF4dK+eh5+BVbIB9EWbQEDgXWraPKT7qfqAEb
         q6Of6ifKaAvTeiTb4c7kriIn6Y30kVmIQ7uNZthk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wLZ-1iCzlr16nj-007WYc; Mon, 30
 Sep 2019 13:11:12 +0200
Subject: Re: Btrfs partition mount error
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
 <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
 <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
 <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
 <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
 <bf5265b7-96a1-5f98-07f8-947b981ac364@gmx.com>
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
Message-ID: <245b13f7-20c9-3ab4-6e9f-0ed32f4d1c79@gmx.com>
Date:   Mon, 30 Sep 2019 19:11:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <bf5265b7-96a1-5f98-07f8-947b981ac364@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vDpXiJJDP0S5I6zA4mkgD2JVrNjDcaRcb"
X-Provags-ID: V03:K1:tpklia9oLiWBObm3GSgPifHvnw3e6iaKwIP5zzbAMalr5svC3+n
 SCzyDSVX1SeBj0ptLtWQxgEMVCHVW/xXBEw+udD2QCn8+7apCt0o/gCvMEZqmTGcSQ3IH/3
 OtpA091aKDyzkI0kS+2KwzK6w552P/TweK2ZGJP2zjx5CKvAKH0vgQtSy/8emAXgQUwjYpY
 miCUFPieMu2TpiMnOVdZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2LM/X26GZj0=:UG9YUx5lzIDni22Drq/hXH
 fm1NAfwhi3sYo/VN79bzCjW9V3UkPas1NTocWRmnv49NkKKbTDocyKZrL4JYtbpsYZQIfZNoF
 uz83laq8Cn0ICBI00SqnzRb9zEpW53bXPQ2KaU6qw4oBszgCLjqatqgl3TOIIzoarlZa6M+D/
 XaZz9c9M/rfLhGapinV7YfLwF8Ob3GLvHmjsb6Z5gw9rHYJw/HmWAaUseio2ia0kGCUh+Klqe
 y4m/a6BRIk4JdbvhJ8Gkb6HBKGx8+dJ/jZCMDuNEWXSQ3bDKxSRa23l0wIvA6Mbhqh1oDqtZj
 tWkzWknbtCKlokkHHwKxL82KLHasHiAkH+Y12LFF3F8/BDr+vjHrVzhn9aSgzCEd8u/ym49mH
 dPzOCPYhsnUuZ8y4L9Sxp54D8pR43PLhN3Em1jZB/MMzW/xgzKz0jGZHnnn3bsOncBYFw/uEC
 ZHIO9ZYg0k5HlhLe/sCYbbkfOVgqJd6y+jHe+Soq1Crq0tmpNCImzTNaHv/GRzqYwYKkxfkH+
 L03tJKV1OQqjXdRXsxnarOwT4tAcd5rNE7jIMVurqi+IW9atdZ4gbHuiH8uxAu0joVvfIoJeo
 K+0xnwM2V3Md8ZkdezjLC7fNRc0gqr6vC8iVF0I0Zrl7EbXswQoGhtJVeex/rpetgZ2RnnHB5
 h81EqY566VcllsrSRuuhBOdpxJqMFAZMBkX/swqm6IuRfoN53N2JU4XB0ilP9ax7F8Vj7fDom
 Nl62dvlRbLTFtMY/hSU9wK3+NyT5TkkM/FHRI0bLiXTuktI8hboDrcWwdUw7gkM28uxGcdi5l
 f1OCMyLKPVV/CIwNJOdzyJkM/AeQ4/rQCveI6GFJV82NJIqH3KwCY0ZBDcIsBhsgcSojWSzAH
 nlsd5z9qCn7ZhmkOZecPzqwlPiMaQhoxq0tQpPygxDOk+0yTEhwrPN/WDUamGskXEkwAgLMMz
 JzxM27nfu2gKbqhJv61jhGop+7iySmMjU/Wy6m6nfa1NHjMO4TIX8r5l/AQiW8KO5o7Yr3Xyt
 vUPeDDN38vCSqYQE3huWgsSurIYuDbklR/sN++7iJcny185ruJJjorccEACi2LsB5e6SsEvdR
 574hkPxgscgQIK6Wcu87Uu3nhU8HamMbwItIvUm57LdkUXZsezKIScjW3Rh8g+77S9D+EAtMU
 QYSkvLSEe7QN9CdkDo4go262mDGdq7H5dVHFs1KtfZPkYtdxCG7+mt0rQaGdqIaYLdcYGAWn1
 Us9KEw2LW9noJ64SByNsIA4ClRKWmk3NVyJmVm0ULpxNX7fxv6IfZC4l38TA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vDpXiJJDP0S5I6zA4mkgD2JVrNjDcaRcb
Content-Type: multipart/mixed; boundary="UocReTP5iIu6W1RDuEgaruHgf4dXciDSA"

--UocReTP5iIu6W1RDuEgaruHgf4dXciDSA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=886:57, Qu Wenruo wrote:
>=20
>=20
> On 2019/9/30 =E4=B8=8B=E5=8D=886:23, Andrey Ivanov wrote:
>> On 30.09.2019 13:10, Qu Wenruo wrote:
>>>> I had built and run it:
>>>>
>>>> # /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-b=
lock
>>>> -X /dev/sdc1
>>>> incorrect offsets 15223 15287
>>>> Open ctree failed
>>>
>>> That branch updated to skip the item offset check completely.
>>>
>>> But please keep in mind that, that check itself still makes sense, so=

>>> please use the original "btrfs check" to check the fs.
>>
>> # /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-blo=
ck
>> -X /dev/sdc1
>> key (613019873280 EXTENT_ITEM 1048576)slot end outside of leaf
>> 1073755934 > 16283
>> Open ctree failed
>=20
> This means there are more corruptions in just that one leaf.
>=20
> It's really hard to fix them one by one manually.
>=20
> I'd recommend to go btrfs-restore or use this patchset:
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715
>=20
> Then mount with ro,rescue=3Dskipbg.
>=20
> Either way, the bitflip is way beyond my imagination.

One strange thing hit me, not sure if it's just a coincident.


We have another report internally about a similar corruption (multiple
bit flips in a single fs), and they are also using VMware, along with
VMware guest kernel modules.

Would you mind to migrate to KVM based hypervisor to see if the
corruption happens again?

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> # btrfs check /dev/sdc1
>> Opening filesystem to check...
>> incorrect offsets 15223 15287
>> ERROR: cannot open file system
>=20


--UocReTP5iIu6W1RDuEgaruHgf4dXciDSA--

--vDpXiJJDP0S5I6zA4mkgD2JVrNjDcaRcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2R4swACgkQwj2R86El
/qiqaQgAgY4IfU7AcRSkz9zEt9I1AJ4eixxM3mI0mGaau4TMtUHZoxYjZrHxHu2a
dSzLtAU08Klt2y9qpt2vo/PI/k2VLTe/DHRUW+zltDJtDlnKplIW0WKvfUnXH2Lo
66G2Qo1bIGqAOzcJ2b6TqPjYZ/UE/QUo4Upr6mPl+s/89Wplpc44us554Qem42V5
rIGzElUWdIV4rQ2ddqRfl56uxKh4mNcuU/kibHlw359sIdAE4oEUSqgyTPBMQ8f7
Qo9SMe98NOFflpUbVFJndxfX6Zqy2z8FExLxxS3zT6GSvuvFDgoHVZ4hUmk589G3
z1loV5yJ6wqs5YZYIsmyzOirXM8Hwg==
=D825
-----END PGP SIGNATURE-----

--vDpXiJJDP0S5I6zA4mkgD2JVrNjDcaRcb--
