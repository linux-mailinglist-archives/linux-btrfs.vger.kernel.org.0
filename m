Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7949A15079A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 14:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBCNoP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 08:44:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:52567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgBCNoP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 08:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580737452;
        bh=LQY3d8nwgUHNnEahza0d+RqPgOIHr8chbTExzgXltrw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZTg2efsaB2wsyXbo4yfCDDL3fJLW2QzFVML+Q1gd2x+T4YmmbbvZimwL2Ej2MkhJd
         BxdX0zekPSijCmvaGn+AUPMlyZdtnUsInB/d9LQmbLvcS2yPATG0+/7pFbnkep/oP5
         HV7FXT5XwUoTgkaQSVU3KH1MvRqm0Acfblnj1hYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs0R-1jL0Kz0qen-00mpXO; Mon, 03
 Feb 2020 14:44:12 +0100
Subject: Re: Root FS damaged
To:     Robert Klemme <shortcutter@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
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
Message-ID: <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com>
Date:   Mon, 3 Feb 2020 21:44:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dcXYATzG39vapIb5W8TDUnGgdICTpR7fO"
X-Provags-ID: V03:K1:0vxUXqBHFVS9c6jdnA4MadRUcYnv4qihrEN7QGf4bkm2Ut2aOql
 9gx1z6RUhXa8zbS661iKzTZ+KeM0Y7HxNkUtLTqUCGDonrcyZb+N3L2ygqh6GaCESjx5d0r
 1u56kJ+giAD1e7RFOviCDQGA+FODUVTOtaAf6o60fi1McAHiKgzA0VHPqYOGX1SWT4oc5j2
 kxKB68+hDYbp6nnZCOIiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FJPXPLs8IA=:RP8YwzfioL3YNavP1pG42i
 6XtTQEJU5RkH0L+PTb4fZmllSt27dHm1ZsNZ+UwjxA/dbAtHHQJHgUyOlbwdQdmRmHjA4rw3Y
 o+SHcOrUFFdHdpJhxwWyqOtd6JvA5payBQp5Y5y5UYD9XOOnrBOPO0MMqcSOpHX3KP2vYk6q3
 1cyzdTt78tPd+AAO87yKdeVt2rLQUVJZSJ3WiIX0ipdJAM7RoIsooOXuZSiHah0sP+6wjzaqI
 vbXciYBp7we38lTsh6tmWjO/lNtxT2HelnIaAz3B86j5bKHl63w1qRZjzmSSILdK1N92HMwag
 q3X4rRCYQ7YvivrHiQbCi/A8fVJiYFKLP3cSaQ21t1U41EpDaVGaibdmFbfMF9UQiNI5fSss+
 d6zIBMBuDFKSGtqExUF41yuCbxwgYoFosONen2DzZbnr0Har4n+XBNxmH+arYsczrAt6R6YJH
 h47my6fv83e6M8HnI0EGVeDCCQgnKv/6UamZypWHJFRK03QMCs4tuu0H6g5gBihU2KDT2sXxd
 R5MCfHwv3+3Q0r5oXbTLxdSD+FM6auQJ9JdRzM5THjy5Rp3e+/YeZ81tHwth1+K3nn0Z5WbI1
 XjuI7IQPQqHeFbyRH4f3re1sroLl56cCfvG0dYn7D2ei21T+pI6/wy2DYSwKQ1+i3/euLJTpI
 nFuI5GzBZaOYD7mVHKBfhWJ4FwhgkMG+88Ug/gUeJIrWTwrg/ney7oehnzMLLnMJtto/EtVn6
 9AD0l7HfNZU0ZFDUAtxlTpN3bYRlIO6jEJ3RpzRk0kJ8nHX5BengW7Afd+uviczR28J5EAFgG
 LlBHFg1yG4idr6B9irx38rexur7jEgtQodsm9LxG9xVTTOFT2yIkJCnvwytZ/1I2v/kzIlDeA
 d6veAaTKIjxcOnUb0pZ/EMNOl1lGcIGOD8AEPAhlRxlkO4tB2Faq3y41f3IoqbJpxhwuHfgmg
 SbmpuWSHNJYP2CZeWHJdigXZu5SihNigk8u20H2d/4Wwz3rgTiNDlY+8jyqWplP5pxXnzKFwT
 zVn+n7buYoYUhHdBS4d4gqnNFrqmOyA4XcbsPVCROsWNRsmeCMTQQxMqcPkBWdKmqFa+6Tna/
 dp5M2kdrWZ5qvZkiD0CfTElQpo/K3ieuIEV6YmHxK/iKgczv4vc4OWFwo+yynNh3mchCdVozm
 nTwUHYRcOOsL/eDLMPsApOtqNM8OnSaYg7rzGOjgkyTfBVMZ3JlRmxfKpOdUi0y6atuJ3pwvE
 nDM1dqijCVmUHK0wt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dcXYATzG39vapIb5W8TDUnGgdICTpR7fO
Content-Type: multipart/mixed; boundary="ANPgmjCj0nN0GpsUaTvOLgc26HK8DAj4j"

--ANPgmjCj0nN0GpsUaTvOLgc26HK8DAj4j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/3 =E4=B8=8B=E5=8D=889:33, Robert Klemme wrote:
> Hi folks,
>=20
> I have an issue with one of my desktop systems. Besides the usual
> information below I have attached output of btrfsck and dmesg. The
> system did not crash but was up for about a week.
>=20
> My questions:
> 1. And ideas what is wrong?

One data extent lost its backref in extent tree.
So btrfs is unable to delete it, and will fallback to RO, to avoid
further corruption.

I have no idea how this happened, but I'm pretty confident it's caused
by btrfs itself, not some hardware nor disk problems.

Any history about the fs? It may be caused by some older btrfs bug.

> 2. Should I file a bug

If you have an idea how to reproduce such problem.
Or we can only help you to fix the fs, not really to locate the cause.

> 3. can I safely repair with --repair or what else do I have to do to re=
pair?

Btrfs check --repair should be able to repair that, but not recommended
for your btrfs-progs version.

There is a bug that any power loss or transaction abort in btrfs-progs
can further screw up your fs.
That bug is solved in v5.1 btrfs-progs.
I doubt it's backported for any btrfs-progs at all.

So please use latest btrfs-progs to fix it.
A liveiso from some rolling distro would help.

Thanks,
Qu

>=20
> Thank you!
>=20
> Kind regards
>=20
> robert
>=20
> This is a Xubuntu and I am using btrfs on top of lvm on top of LUKS.
>=20
> $ lsb_release -a
> No LSB modules are available.
> Distributor ID: Ubuntu
> Description:    Ubuntu 18.04.3 LTS
> Release:        18.04
> Codename:       bionic
> $ uname -a
> Linux robunt-01 4.15.0-76-generic #86-Ubuntu SMP Fri Jan 17 17:24:28
> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v4.15.1
> $ sudo btrfs fi show
> Label: none  uuid: 0da6c6f7-d42e-4096-8690-97daf14d70e7
>         Total devices 1 FS bytes used 12.64GiB
>         devid    1 size 30.00GiB used 15.54GiB path
> /dev/mapper/main--vg-main--root
>=20
> Label: 'home'  uuid: cfb8c776-0dab-4596-af5b-276f0db46f79
>         Total devices 1 FS bytes used 50.73GiB
>         devid    1 size 161.57GiB used 53.07GiB path
> /dev/mapper/main--vg-main--home
>=20
> $ sudo btrfs fi df /
> Data, single: total=3D14.01GiB, used=3D11.83GiB
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, single: total=3D1.50GiB, used=3D820.30MiB
> GlobalReserve, single: total=3D39.19MiB, used=3D0.00B
>=20


--ANPgmjCj0nN0GpsUaTvOLgc26HK8DAj4j--

--dcXYATzG39vapIb5W8TDUnGgdICTpR7fO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl44I6cACgkQwj2R86El
/qg6oAgAn4UvRVkQSO0KOg2igYVGMf/NHQO1ckM0qlz/g+8JhRgvmAC7rLHuMaJh
YT1wGr9NEt8qgEMnZes6HERpvCk33Hz5EL9j5xUmGG1zxiMwCBYYFH2WW+6SKKP3
GqDTc1YdDH8fSrvATYz9uJAPgll9FIdpHXigNZVarLWrVe6yEqDOkU3EAI0blbFO
xiMJgP4n7WRj8nR6vCOfgY551xVgQMQcRXrQbxsFASZGEONMoCUod33KoEwgSmbS
H5TFA3lpq6Tbqey2x2ZQIA5iy1IZ6znM2YP7LWpNFUknIIG5NbtVwvwuDDs1t9jm
1FLDl/pqm19vQbOvK6qHzVVc4q2K2A==
=TvaV
-----END PGP SIGNATURE-----

--dcXYATzG39vapIb5W8TDUnGgdICTpR7fO--
