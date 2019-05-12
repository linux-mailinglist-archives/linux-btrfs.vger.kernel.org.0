Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67B11ABF4
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2019 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfELMCA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 May 2019 08:02:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:59237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfELMB7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 May 2019 08:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557662516;
        bh=U7UdauAqTWWLl/NW/+J2p7MlwTmXRyTbvRg6JUgS7Qw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Bapl9MdQaBu0tw64oR2wrRf7xTHEbOJ6hegDCdwRHQJr/FgLyU5xowQcUrF8ih8e2
         Z4B7ICa4uuntYhHWdp2W7xCaYDViZ+ZJIrfYWrM5sszTJV7QtnJayxr32rK3g3QKoG
         jizYmNgzYVggSJUyz9Zs97qaUFKO/jaSxOnPcKN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1gmLkh2ejQ-00dpb5; Sun, 12
 May 2019 14:01:56 +0200
Subject: Re: Btrfs Samba and Quotas
To:     Hendrik Friedel <hendrik@friedels.name>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        samba@lists.samba.org
References: <em396f5ac4-821b-44a0-883b-2755971d90c3@ryzen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <d7fe4f26-acec-9b20-6fcb-8628205e614c@gmx.com>
Date:   Sun, 12 May 2019 20:01:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <em396f5ac4-821b-44a0-883b-2755971d90c3@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M1ODfI2WMu30lgMtynSzl96tPvSerdoOk"
X-Provags-ID: V03:K1:vLlOmkPVt4UUqf1U1JO9mCGrm92/EE5l4EkBoWSwen38oC8XwKS
 e6Wy10d7RXIjpwB0r66m7yuYO6155LhgRjikZQjSV6Qty5d3JRtYx2BqrTQiNnF9CF4X/GL
 mXYm0fyPXV1iVhy7F3HcmncOgBtgF9Y8e992Q7JlpkWKxsPQgKYXrQBOiQonz8dtB65X6b2
 ScA+erRfYAsh3NjMoQjkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLngCn3ceMs=:ItFuHnfBPMs1OLT4arAFkP
 y9uey4gocLJwh2DL4pu+YJhwBgHYdCCBBYoAJeZ2uLloI+LmLTeUBPv3fP0+/xQ6515kxVNGu
 PGas2AOjezsZjFsd2UFq/P5mdcu0EfDCQnMVWFKmRl72rHJxGgNGvbiJY9Xs2a+j1Y4F7Ktaj
 sYH+sO36kNpVE61CrFJC2cXGhX6jKPculG9a2M1tZQjanOsZ+vNezmGV8/1cP3wBDJj/GU4uW
 qWnuK9jPNlimBFltaa/8AtQsvYphfGOHV+BPB9xeLhYckfpbrYOIGNZyQQqlIOgfNat4wUX4W
 lxby4xfcF6V+FRwBt3xmYclrBTbym8PScObVuCAc56W31uaybKECsXyBkxHuPDjVcFd53Z1xv
 8y+GhiJ0VY7e724zEyTVORWVsDeh8RleZ2yjJmRIKc/oTFVPGcnfHYj12f130vTdxVe87Dhn6
 PENE5nJ8hI1TUCeNQw3fX7NgRnN6zMO1Y4GkyaPjRfO/J95c4vhyxYdAQTiqtmW+3xm9vfVDl
 1f3jfL/wjMc1D4IZg++bV/UJ+Av6b5Mk/+zqg+o7kKJ7FUB/19+ko2hV0EfnD6uMArF/JwkNA
 XAngnIev7/OiI008hhIUhxVu0hgrmUu6umXibKUhxDp3J/+5+cDXa4aQj3UrUBtvYL2YRCWx4
 +PC8jLgNjs06VbCtD/hWJ5Ga0nsP7pTyth3fM5h1UK8hPBSHn8YJ7Z/RErYXGepg5DtZ5Xn7O
 +3fQJ0UasCvRzbZBJq0kRw27w2tjWm/FSrw4fTsPywNcVlHpsW3T2dqe9bp7s4/vBjbGsDIbY
 gCKWmQjwUiS0VVgVhc289/Ov5d6FZUJs/7FKLhfupcRq1NxcovQrKfc9goewye7sflP5VQj8w
 vLqXa2uCIG7KagPzCNNqWfOwbPhaBI9+2GZBWVNohKaGsJSZgce/fCFvBtptpp
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M1ODfI2WMu30lgMtynSzl96tPvSerdoOk
Content-Type: multipart/mixed; boundary="7Tm7lJYWseM8fKPlMvkGG8mG3IktSc3XO";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Hendrik Friedel <hendrik@friedels.name>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>, samba@lists.samba.org
Message-ID: <d7fe4f26-acec-9b20-6fcb-8628205e614c@gmx.com>
Subject: Re: Btrfs Samba and Quotas
References: <em396f5ac4-821b-44a0-883b-2755971d90c3@ryzen>
In-Reply-To: <em396f5ac4-821b-44a0-883b-2755971d90c3@ryzen>

--7Tm7lJYWseM8fKPlMvkGG8mG3IktSc3XO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/12 =E4=B8=8B=E5=8D=887:27, Hendrik Friedel wrote:
> Hello,
>=20
> I was wondering, whether anyone of you has experience with this samba i=
n
> conjunction with BTRFS and quotas.
>=20
> I am using Openmediavault (debian based NAS distribution), which is not=

> actively supporting btrfs. It uses quotas by default, and I think, that=

> me using btrfs is causing troubles...
>=20
> In the logs I find:
> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [.]!
> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879166,=C2=A0=
 0]
> ../source3/lib/sysquotas.c:461(sys_get_quota)

First thing first, btrfs quota (or qgroup) is a different thing from
common Linux filesystem quota.

Thus I don't believe a lot of user space tools (including samba) have
support to utilize it.

Also, btrfs can't support Linux filesystem quota directly, due to some
features like snapshot, and the nature btrfs has (almost) unlimited
inodes but uses quite some more space for metadata (btree) compared to
other filesystems.

Not sure what quota samba is using.

But at least we can determine if samba is utilizing btrfs quota by:
# btrfs qgroup show -prce <btrfs mount point>

> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [.]!

Not sure what the sys_path_to_bdev() is, but since btrfs has
multi-device support, bdev from btrfs doesn't make much sense compared
to other single device filesystem.

> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879356,=C2=A0=
 0]
> ../source3/lib/sysquotas.c:461(sys_get_quota)
> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [.]!
> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879688,=C2=A0=
 0]
> ../source3/lib/sysquotas.c:461(sys_get_quota)
> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [Hendrik]!
> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879888,=C2=A0=
 0]
> ../source3/lib/sysquotas.c:461(sys_get_quota)
> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [Hendrik]!
> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880093,=C2=A0=
 0]
> ../source3/lib/sysquotas.c:461(sys_get_quota)
> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [Hendrik]!
> May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880287,=C2=A0=
 0]
> ../source3/lib/sysquotas.c:461(sys_get_quota)
> May 12 09:34:06 homeserver smbd[4116]:=C2=A0=C2=A0 sys_path_to_bdev() f=
ailed for
> path [Hendrik]!
>=20
> As you can see, this is quite frequent.

Would you please describe the impact of above messages?
Does it cause samba mount read/write failure or something else?


BTW, adding samba to the list, as the problem looks more like a problem
in samba.

Thanks,
Qu
>=20
> Searching for this, I find some bug-reports:
> https://bugs.launchpad.net/ubuntu/+source/samba/+bug/1735953
> https://bugzilla.samba.org/show_bug.cgi?id=3D10541
>=20
> Now, I am sure that I am not the first to use Samba with btrfs. What's
> special about me? How's your experience?
>=20
> Greetings,
> Hendrik
>=20


--7Tm7lJYWseM8fKPlMvkGG8mG3IktSc3XO--

--M1ODfI2WMu30lgMtynSzl96tPvSerdoOk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzYCy4ACgkQwj2R86El
/qg3iAf6A2aElnGpVELSgeMf+N7pfR/vKw61GwjFJVoz/KGHvay/k2tWFBYNS86A
cQ9TVAIe2Pb6qeOpX3UacxK5UsQfPgQViJeU7kQDINwuKsuPm4nrJBmdCQW/7t4n
fojGvO1hlQlyYULmSCvr5OaLMaaCBTFBIDtYFBRjVo5UTREosxcmfXfYqeB3TEAV
qclwxyr38XOjI8zahenSB226PKR2vMPZ9cUKkcr7yo/TkKddNtk0RoPeKfTSCNE+
bB4g+WxxC93g9Zq6CoRNhNaFGvo5su0gF+7uCJQNQeYaSK/xhiO4aGMHht4AniKA
1trGUZEyY4JmaZNLtP5Sg0CTsm8zKw==
=dyaL
-----END PGP SIGNATURE-----

--M1ODfI2WMu30lgMtynSzl96tPvSerdoOk--
