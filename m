Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C129FCB4EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJDHWV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:22:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:42685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfJDHWV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 03:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570173731;
        bh=6HQupwyzsn9QYC7kmvF2VIzlORgmBT0RUEhTi3GFO/M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G8kCaIpOBrzq0PkxVN3UTOfgyWNHqYtnwFDsiZcvMrBfZ3hjxER2jjFP3GT2KMHFV
         Vh7kY6raA90z1UwiBvTyFn20BLKA4d/OhZoQgzKS/kZQD8W0PkfkhV+3Ffz+Cfw/kY
         1k9AUsLs7534fqdYGgAl4NQ8AB3AY1AGIYzDX1kk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1hkkVs3jnu-00nCNl; Fri, 04
 Oct 2019 09:22:11 +0200
Subject: Re: BTRFS errors, and won't mount
To:     Patrick Dijkgraaf <bolderbast@duckstad.net>,
        linux-btrfs@vger.kernel.org
References: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
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
Message-ID: <293de2b3-506a-0fcc-f692-0fc03012941c@gmx.com>
Date:   Fri, 4 Oct 2019 15:22:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="338Viw10ULc6A1aziGRE640JNs56eeUtj"
X-Provags-ID: V03:K1:yXc5o6QGKNx89xE0W4W275CAZR69Sf8ZQHZYYxyCajVDh3n9eYK
 gCswQfn7voBh4Ml7DT52+VGHOe2KF9js8CQCdcAo016vbhWI+S/mKcFhNUr2/uvNkLitd7u
 58Qxj3eXVrpsoafABRrjFEx0X7bTEHmEuWmTDIU16SliRiA3pou8fpH56HlmueKCGleqif9
 sfcwhoRqKOfCvKGCXw7oQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Iv+7ops1B6M=:gCCfAsEFnOPqDPIoOqQNPj
 v1QkpBj2i3VxJMev6mJ8PwojCgow1u6V5yJaah0P73ShQIUP4o3PNJazaVKE7cT4dUE1+gnaK
 vFrAUque0MnD/jduJzz4LbcCAqODnepoJWX8NgdQG6Ni/rRlAjHq9nHFczQ7YtVbxY8ak8KMf
 w5f5MS9cubSwY2Gojf/r+0gep7lAoqe9IZl+3GYpVR6o+IqQtYsiVK13NCfxnzjZZKk7a35cK
 0Vy3/vDNRBY8mS3I4nY7R0p1fmlTKVFnvf11ynvieUtklsr0wRATay36TwqymgEDjnXx9YVhk
 aVw+iUPC0H4H/rDUzLQlJf8LNBx6+LO+esfoZsnkAXHXFZrUV1tDA12GH31FSU3t+1E4HXr6P
 7uT01QuCjXOfzCbcfFsvIV5p2wu3at7OMmMaED0AYDyqn8v20IFZIpKqE9uYOYjCzt0iy95SU
 NV3TkPcWRbz1+fUA1YGjxLYhUxKB/hpWU1Rk1nJE/35PtqdtrvJmkSs2NnkAP373Kj1xCcUW0
 MGHuJtq+5CIDbfCK4DDxNg35nIwvVdnUPiCC3HUT08PojV3u28KRNsDwsU4uSdy0QUkaDWU0g
 78He5X8/KkcU+1X3hAwf/qbDYjIMFzocGie/euB1dPO8dO4WgBu2sTP6O9eciPlO5jEFUkfDO
 mLJZaA0B5/kb8pMwwIyHOD8wBI2+FWBJoroqyh6cbXmTjwAcS4G0vKjI2ULiC3h6ioEG+Jwfw
 evy2N04T4/A/bwUJzyqUMye+t1S6LNGIzEQ/UN3lM16RIQTcTxahq782Dv/dp07tK1WKANAnT
 1IXwO9/6kCenYsZcVLcIYdtSqqNRs2q5g9JsPr7HKtWAW8l9s2V7AbIuKjTDFQvoVhxz54OBM
 5V3FQJmA8xL4WBnjMpL+QMLiz/9Vruxluc4TrBtWItGGojYR1W8U3cQj3qSWg0ixTD/VXyNv8
 WLijakoNRY6sAcOOlTJzwEmiKAtX1Y8byyO5cLrm8JOnIBQ3bacDKlTV2Jlgt9Hf6IEH5XQa+
 IWhNesfy+UxIfqGyzeJwWA7bVMcFpe/nOQuirZEW5VdBaTlKE+lQNtBTVoPaCM9V3aXIn0b5a
 gwkCuEdUYcananUpTPKDHMIM3M+AfVw8iF8BmUFxqElG/2frAU292Ma18OsFWfBTWxWsNXigJ
 aXPjHtCPhmU1+1sNBRFXILFwHWdp5jgfrUs1W85XciZ/o4hnaqZPOdknUmkPPyKDfi1x0ClHj
 Hoimw2Llv2dtf6n7huL1mEDUnDxAFPN2TF7vL3dXPNq6Oub5VUc8Maxr8tVo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--338Viw10ULc6A1aziGRE640JNs56eeUtj
Content-Type: multipart/mixed; boundary="dl57VRuItVmxKLXf8eWQcOQqeHD58LmSo"

--dl57VRuItVmxKLXf8eWQcOQqeHD58LmSo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/4 =E4=B8=8B=E5=8D=882:59, Patrick Dijkgraaf wrote:
> Hi guys,
>=20
> During the night, I started getting the following errors and data was
> no longer accessible:
>=20
> [Fri Oct  4 08:04:26 2019] btree_readpage_end_io_hook: 2522 callbacks
> suppressed
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 17686343003259060482 7808404996096

Tree block at address 7808404996096 is completely broken.

All the other messages with 7808404996096 shows btrfs is trying all
possible device combinations to rebuild that tree block, but obviously
all failed.

Not sure why the tree block is corrupted, but it's pretty possible that
RAID5/6 write hole ruined your possibility to recover.

> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 254095834002432 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 2574563607252646368 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 17873260189421384017 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 9965805624054187110 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 15108378087789580224 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 7914705769619568652 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 16752645757091223687 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 9617669583708276649 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 3384408928046898608 7808404996096
[...]
> Decided to reboot (for another reason) and tried to mount afterwards:
>=20
> [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): disk space caching=

> is enabled
> [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): has skinny extents=

> [Fri Oct  4 08:29:44 2019] BTRFS error (device sde2): parent transid
> verify failed on 5483020828672 wanted 470169 found 470108
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286352011705795888 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286318771218040112 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286363934109025584 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286229742125204784 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286353230849918256 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286246155688035632 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286321695890425136 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286384677254874416 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286386365024912688 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286284400752608560 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): failed to recover=

> balance: -5
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): open_ctree failed=


You're lucky, as the problem is from balance recovery, thus you may have
a chance to mount the RO.
As your fs can progress to btrfs_recover_relocation(), most essential
trees should be OK, thus you have a chance to mount it RO.

>=20
> The FS info is shown below. It is a RAID6.
>=20
> Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
> 	Total devices 16 FS bytes used 36.73TiB

You won't want to salvage data from a near 40T fs...

> 	devid    1 size 7.28TiB used 2.66TiB path /dev/sde2
> 	devid    2 size 3.64TiB used 2.66TiB path /dev/sdf2
> 	devid    3 size 3.64TiB used 2.66TiB path /dev/sdg2
> 	devid    4 size 7.28TiB used 2.66TiB path /dev/sdh2
> 	devid    5 size 3.64TiB used 2.66TiB path /dev/sdi2
> 	devid    6 size 7.28TiB used 2.66TiB path /dev/sdj2
> 	devid    7 size 3.64TiB used 2.66TiB path /dev/sdk2
> 	devid    8 size 3.64TiB used 2.66TiB path /dev/sdl2
> 	devid    9 size 7.28TiB used 2.66TiB path /dev/sdm2
> 	devid   10 size 3.64TiB used 2.66TiB path /dev/sdn2
> 	devid   11 size 7.28TiB used 2.66TiB path /dev/sdo2
> 	devid   12 size 3.64TiB used 2.66TiB path /dev/sdp2
> 	devid   13 size 7.28TiB used 2.66TiB path /dev/sdq2
> 	devid   14 size 7.28TiB used 2.66TiB path /dev/sdr2
> 	devid   15 size 3.64TiB used 2.66TiB path /dev/sds2
> 	devid   16 size 3.64TiB used 2.66TiB path /dev/sdt2

And you won't want to use RAID6 if you're expecting RAID6 to tolerant 2
disks malfunction.

As btrfs RAID5/6 has write-hole problem, any unexpected power loss or
disk error could reduce the error tolerance step by step, if you're not
running scrub regularly.

>=20
> The initial error refers to sdw, so possibly something happened that
> caused one or more disks in the external cabinet to disappear and
> reappear.
>=20
> Kernel is 4.18.16-arch1-1-ARCH. Very hesitant to upgrade it, because
> previously I had to downgrade the kernel to get the volume mounted
> again.
>=20
> Question: I know that running checks on BTRFS can be dangerous, what
> can you recommend me doing to get the volume back online?

"btrfs check" is not dangerous at all. In fact it's pretty safe and it's
the main tool we use to expose any problem.

It's "btrfs check --repair" dangerous, but way less dangerous in recent
years. (although in your case, --repair is completely unrelated and
won't help at all)

"btrfs check" output from latest btrfs-progs would help.

Thanks,
Qu

>=20


--dl57VRuItVmxKLXf8eWQcOQqeHD58LmSo--

--338Viw10ULc6A1aziGRE640JNs56eeUtj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2W8x8ACgkQwj2R86El
/qgrNQf9EXyxrJeh4cjmS0NIE6NAnIQvJgHHhlS4nKs4jf1CsD3A6H9qfz2mLDsv
KZeAsQDwkE5k0EjUrSrRHAK5cxMgAIhPTsBxDJbmIlK7uBLWBVGGNc+gPzmjDZnu
6EyxOSqJgvsoR2r31TepKwmzsJF2LsesnTCcDdG/0UAvmJZ9lyNujMKY2FIaIYT5
c1hjMokxoQxAzWn0TxWYoyATHBNljM0b0fN5ZnUdlfqtT30shIQZRAvuasS3fRox
uzu3GpRDuVgOM1O1z7UdeR+A3VlM243DA1HCd55EAvyJQLd3n+Z2ymXi9AZJWfRt
ASUynFZljVbrhRvcKcpOoaGdJIovxg==
=lNaB
-----END PGP SIGNATURE-----

--338Viw10ULc6A1aziGRE640JNs56eeUtj--
