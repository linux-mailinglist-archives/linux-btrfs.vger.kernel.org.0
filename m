Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DB73898A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfFGL5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 07:57:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:40207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfFGL5d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 07:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559908643;
        bh=4ejKNyooNnJyTtfL5kpJ9xEQc5MGlLYN1mznBMXIO0s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iaAfYuva5kOvXiY8IFQRvd+EF5ZbrOp5hCL7rzqrXpP5c9VruJmze6FEOZot4cjN5
         7rY/jDPnI8ZDgi0+8tz6RmD6vUC8shJFAQZ6rNyE8mkY/iXK8KcDWDxk1vv834iilF
         ozDrDAdKH8C+wLT8JZzUaftgNtEX5Hx0GH6t5vgY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Db0-1hSbnO3S36-006c2A; Fri, 07
 Jun 2019 13:57:23 +0200
Subject: Re: btrfs progs v5.1: tree block bytenr 0 is not aligned to
 sectorsize 4096
To:     "marcos k." <Marcos.Ka@posteo.net>, linux-btrfs@vger.kernel.org
References: <3057842.IWvHFmXsFP@ernsv0>
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
Message-ID: <bef76760-2376-d6c4-4808-ac4e9d7bd361@gmx.com>
Date:   Fri, 7 Jun 2019 19:57:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3057842.IWvHFmXsFP@ernsv0>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q1w6Vgv9viQQgr3OfCg8dSe33dMy7R7Xt"
X-Provags-ID: V03:K1:9PGlDRiZxJBaIIeN99Q6iM+C66ezMb0ceL8Eqp8NOGvULjEoPNM
 bIHFvKYK/VxL8NjpTFT7woQzMkyLZ6qOQ3UIOXpoznYjoc6FIsUlgePpfD1PmDNL9uMUWrS
 Sw+doCl2KpRZlF6Pwn67S8psPzK0LKld1D/ANxR8TESzEuDl+mUvNLXD+A6Qkn0qSgRQFD0
 iwxPu/sBrEOuUqM/Tha7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jp5ZPwZYYSk=:UbmnktkWP3VGQxWS5JJ6RX
 5uaiwsIKwXkQEiclAQUfsQq9hUmeZkds9aM4K4Gd0x9XiVUmo6UuisveOT+6e6q4ZDYXS3Yxm
 kpphkw8BoRhFownDzV04tdhrIfn4pupirjw2nV/BHINCzcw0fudZNdhTasqWJruLWhY/HZ/Qz
 fAK0NJamaOIzUjo+LUAOuHdDrjAVqXQe+KhetsgcnOt2c3tYfhLLp4uEkZjdFL7xL4XU95ZNt
 fxN/v4Pfo0Xf4fwzZ8jS50YnMuMC+nJBbGI23lbDlqCQOCbrYRCKcomQoRwDsyJg0YzZZG2zc
 8wnANR9aAL25g0FiOI8dgSg4f2Fk9TSGdpELdy4PRW2UI1+aptFw2VY7vFteN28BURpB9xnoP
 ikGDVmue+6/VSolaFvJpFVrjwd47T4QutEUiop1WPcdJryeu3aDlpn2QsSw8JNwXcezJ1HBxf
 qAj5WBRXZiFQUSzi+MwSgy7BMkT06hFLRzjUeY/eflvGKUxopigwqYGPkJYq8J0xQlNUIC2LM
 y/P7+H7x2+TTiuu8GED7nianlNoQiU2xjFhpzH9z7N9BQzWWAQs1wADvSPzo0pW5G4H3YZH2Q
 F9e39Hy8L64HuM5GIMIhayq8KSQRCk0noFAdHraeBTSUrjGCLp5iMgL3U7T6Zm7TNgGJrb8PR
 OIldIpseiYUF7Ionc2xcfZrIBx0KNG4hn5CW0ySQmR/G3yVnHne3BRmbA1z5nCEJJLkOaDB1t
 Z7mV/hPYKrpEig890tgqFv+RIU88jRO35XLLv38qquP5498WwZLEj1yKsRcj7PgJyvyQwJMmi
 yZFiybmdFq7uEqq99A6KDHskYrJzEUrp06EOpvuq+fIpoDKPVk+7VFPW3+TI9z4wq7oOdCQqE
 uMe3YGhHONURJLh29eq5QYXoL6r1agmmB8mb36cU4Sps6Q4b9Iq38qiQIvJ1lwx8Z8FD4Qlll
 xx9inr/Jwrhc/k3dKv/+zAOXU0puRkLA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q1w6Vgv9viQQgr3OfCg8dSe33dMy7R7Xt
Content-Type: multipart/mixed; boundary="hqugwkVZBBASK4e6YiNKx7npnQG2Db9sc";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "marcos k." <Marcos.Ka@posteo.net>, linux-btrfs@vger.kernel.org
Message-ID: <bef76760-2376-d6c4-4808-ac4e9d7bd361@gmx.com>
Subject: Re: btrfs progs v5.1: tree block bytenr 0 is not aligned to
 sectorsize 4096
References: <3057842.IWvHFmXsFP@ernsv0>
In-Reply-To: <3057842.IWvHFmXsFP@ernsv0>

--hqugwkVZBBASK4e6YiNKx7npnQG2Db9sc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/7 =E4=B8=8B=E5=8D=886:40, marcos k. wrote:
> Hallo to all of you,
> and sorry for asking the very specialists directly,=20
> but I found no useful answer to my problem.
>=20
> my btrfs-filesystem is corrupt and can not be mounted=3D=3D>
> btrfsprogs v5.1 and btrfsprogs v4.15.1
> # btrfs check /dev/dm-2
> ERROR: tree block bytenr 0 is not aligned to sectorsize 4096

Although the error message is not good for human to read, the tree block
bytenr 0 means some tree block is definitely corrupted.

>=20
> BUT btrfsprogs v4.4 can at least check the filesystem and I have (limit=
ed)
> access to it. Still can not mount ...
>=20
> I would appreciate it very much, if someone could give me a hint,
> marcos k.
>=20
> =3D=3D=3D=3D=3D=3D=3D output =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ou=
tput =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> lap13:~ # uname -a=20
> Linux ernnb113 5.1.5-1-default #1 SMP Mon May 27 07:14:33 UTC 2019 (6ad=
4f79) x86_64 x86_64 x86_64 GNU/Linux
>=20
> lap13:~ # btrfs --version=20
> btrfs-progs v5.1=20
>=20
> lap13:~ # btrfs fi show=20
> Label: 'rootfs'  uuid: 0fe9bec5-fd4e-4a4b-a855-b0412d9916a4
>         Total devices 1 FS bytes used 134.48GiB
>         devid    1 size 310.13GiB used 143.06GiB path /dev/mapper/linux=
vg-rootlv
>=20
> Label: 'homefs'  uuid: d3659317-3d28-42f0-beb3-2480fb2b0900
>         Total devices 1 FS bytes used 406.77GiB
>         devid    1 size 590.00GiB used 577.00GiB path /dev/mapper/linux=
vg-homelv
>=20
> lap13:~ # btrfs fi df /dev/dm-2=20
> ERROR: not a btrfs filesystem: /dev/dm-2
>=20
> lap13:~ # dmesg | grep -i btrfs
> [    7.485437] Btrfs loaded, crc32c=3Dcrc32c-intel, assert=3Don
> [    7.487711] BTRFS: device label rootfs devid 1 transid 3190209 /dev/=
dm-1
> [    7.616145] BTRFS info (device dm-1): disk space caching is enabled
> [    7.616148] BTRFS info (device dm-1): has skinny extents
> [    7.662371] BTRFS info (device dm-1): enabling ssd optimizations
> [    8.263761] BTRFS info (device dm-1): turning on discard
> [    8.263763] BTRFS info (device dm-1): disk space caching is enabled
> [    8.998829] BTRFS info (device dm-1): device fsid 0fe9bec5-fd4e-4a4b=
-a855-b0412d9916a4 devid 1 moved old:/dev/mapper/linuxvg-rootlv new:/dev/=
dm-1
> [    8.999507] BTRFS info (device dm-1): device fsid 0fe9bec5-fd4e-4a4b=
-a855-b0412d9916a4 devid 1 moved old:/dev/dm-1 new:/dev/mapper/linuxvg-ro=
otlv
> [   10.484594] BTRFS: device label homefs devid 1 transid 2087298 /dev/=
dm-2
> [   10.520725] BTRFS info (device dm-2): turning on discard
> [   10.520728] BTRFS info (device dm-2): disk space caching is enabled
> [   10.520730] BTRFS info (device dm-2): has skinny extents
> [   10.522139] BTRFS critical (device dm-2): corrupt node: root=3D3 blo=
ck=3D16384 slot=3D0, invalid NULL node pointer

Kernel tree checker also detects such problem.
Your chunk tree is corrupted, with one node slot pointing to bytenr 0.

Normally we shouldn't have a system chunk at logical bytenr 0, but it's
also possible that all those existing check is too strict.

Would you please provide the following info?

# btrfs ins dump-super -fa /dev/dm-2

If there is no system chunk at bytenr 0, then it must be some strange
thing happened in your fs.

Thanks,
Qu

> [   10.523238] BTRFS error (device dm-2): failed to read chunk root
> [   10.545271] BTRFS error (device dm-2): open_ctree failed
>=20
> lap13:~ # btrfs check /dev/dm-2
> ERROR: tree block bytenr 0 is not aligned to sectorsize 4096
> Couldn't read chunk tree
> ERROR: cannot open file system
> Opening filesystem to check...
>=20
> lap13:~ # btrfs rescue super-recover /dev/dm-2
> All supers are valid, no need to recover
>=20
> lap13 :~ # btrfs rescue chunk-recovery /dev/dm-2
> Scanning: DONE in dev0
> Check chunks successfully with no orphans
> Chunk tree recovered successfully
>=20
> lap13:~ # btrfs check /dev/dm-2
> ERROR: tree block bytenr 0 is not aligned to sectorsize 4096
> Couldn't read chunk tree
> ERROR: cannot open file system
> Opening filesystem to check...
>=20
>=20
>=20


--hqugwkVZBBASK4e6YiNKx7npnQG2Db9sc--

--q1w6Vgv9viQQgr3OfCg8dSe33dMy7R7Xt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz6URoACgkQwj2R86El
/qjFlQf+MAYV6Nvf8evlTxItH/xQpEhaXDebG8JfM9WNKLDzLXuSqbMX9r2YJyqf
+rXGIs1fo+E7HrbDRvz+KLcbrqnOdU7r41/eWI3SKd0gZpD/Wkn5KAIdpocIEyKi
hsA+oSyb0nq2bnPL9RgAMmx8x2t8SGmYEZaiyXrDHUdlXrI3dPoWakozkVX6N8Vc
CCndLXi/78yIcshAK6GANMysw5/3dqCIqIeG0+pVvYjDZOqzw8MkXoZKV4HBU+n1
tznriOY0m0BHx7dQyWm002wV7bFSq5W87Yza1Fbx2BYiOIkJ6y+5idF1SF4qq/HR
hjh14T5HRPeFBqblassJietx86nlHg==
=KE2b
-----END PGP SIGNATURE-----

--q1w6Vgv9viQQgr3OfCg8dSe33dMy7R7Xt--
