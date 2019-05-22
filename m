Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65DA2727B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEVWo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 18:44:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:36341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfEVWo0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 18:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558565063;
        bh=Ko+ZzrgwwVqkMg53IAecZAHG6lSSE+5jAuBW6BH5MW0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U5vJOfW4GOhBA5H4TEBoQ4nBaBD3+0Z3My2QTwK9j7AfuUy5T0Fvoya1q/mc0owxr
         Aaarn5u1Fxsay4x5zjyw8o9u65WYxHaKDZStodIzQcXn1WdmXbs4gU0DgmmDq0LypE
         OXjk/2vUr6Ev2W6MVoS3eHUuTGldOGPEow9ivgpU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Le69A-1gqyRW1cHE-00pxaJ; Thu, 23
 May 2019 00:44:23 +0200
Subject: Re: btrfs-convert with --no-datasum and --no-inline. How can I enable
 those features now?
To:     Daniel Martinez <danielsmartinez@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>
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
Message-ID: <7c75acac-428e-40b2-ac0e-7f89d6dcd2e9@gmx.com>
Date:   Thu, 23 May 2019 06:44:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c0KBKVZArNVfDLuVGypLlre6Voqy7z2sl"
X-Provags-ID: V03:K1:KUkfDYaqawMam6nkDe+Gc/0NoUrNPVumZHyfq7xJpEFkQUQZK7D
 jnl8UKyOmqM3SvNGbzL+lyg565larfy2y+3DAjjc81NvTq/3TqlWcjEar6vIQiSA8/5ySK5
 ZsLmZ09wh89lPJaxtjisjI5IVyZ7AQmSZDDVF6WnXSvvfWxo7lQb1z3HbhWI+lKZpGUkNf6
 hqOt6oMfelMmPshwUKoDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZcRb5ifwdKk=:tAKfk2AHu2nZahejrOO0h+
 wVCSMitNlw+puGPz5GJibc/bRu7JDjhx15aiAE0kLLdzYNazVvzkFXyrfhGgIZh06ZNl/YaJJ
 JdjC+chbvBwyY3QoQC5VI1eC0e1Xv7PQEJbGJuZpu0Wc+zKOtE3MUJNeno71/WCro7IDMpMA8
 IGIXAtJ9l0nFysHVWEvYZuftzIU8/BpLoo6Ey2F5Es/BsmWRTMJhOuWChPVnl7IvFWa+++Q0o
 CiTkcbusZc4/1viBhO9Jl1o+5eotC0e4LNrx90z3hDGPmAiApeAIhTorBwvHb7bLvdh6v07dK
 6HE7V+kR5lwKOFnun4IFtcR6wk2Bsju14/XSyS6AvwETa5W47BlnQLyWGxe/ceY0JtRq+pZ0H
 3qPtsEOIkNJ7shCWZHkd9NyDGNgsxdI0rivrOLuIHEoLTCf/zMbxoQ/3VjyE6T1DBQki+a9M8
 AnDQeagAAndQ8MtDHoKP/6jxdClTg/P5eoFYrGfOHe+C4bUeI89q04V1xRjktm9i3XTA04eTl
 hx6dSDyQk6Uz6rbGsVgtjdS9xDNSLampEblvLQhw8XTWlfwbvB3j6I80u6o6zMTft0jm35cAW
 AKHa6q/1O0+KTPjW+HgYIZan404CGYKVBj1iyEImUUTdTPoDzEU/9fNgape10y5MW91Y6VnWU
 uEa6jvEqNh66Bx3d+Zr/JujGf+r8pOZr/KumEUYjd2g+oBdmbGAwOYmgIaRonUPdZEcE1Sd6V
 NbQ8KQT1iWDV5S0nj5l2UsXRlJcBiFYEbDPpUqCcOTNATI3SA7g0FFznyBYiR2KvxjjFCoq0H
 bwGq7ddLQFh/h/PLdonuDqhtcUlJ2MUY3X7evAgQpBNgVht2nOUUUIKKJYiQXQhXMZi7B64PR
 PxIPXy14FeLZdfjjVuxMpQx5whK+7vy2MpmT2rUGHHoXZ7CeCJaMugplRuHIcYp3VDjP35cWp
 rZ3Uae+qz7uwijirvQW9gDLHRDFs8QJc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c0KBKVZArNVfDLuVGypLlre6Voqy7z2sl
Content-Type: multipart/mixed; boundary="4A72pwC5SBN4e7TKF4LmOTxVRC5fFdwP0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Daniel Martinez <danielsmartinez@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <7c75acac-428e-40b2-ac0e-7f89d6dcd2e9@gmx.com>
Subject: Re: btrfs-convert with --no-datasum and --no-inline. How can I enable
 those features now?
References: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>
In-Reply-To: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>

--4A72pwC5SBN4e7TKF4LmOTxVRC5fFdwP0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/22 =E4=B8=8B=E5=8D=8810:37, Daniel Martinez wrote:
> Hello,
>=20
> I've converted an ext4 filesystem (after a few attempts, and after
> rolling back to a system running both the kernel and btrfs-progs 4.12)
> to a single disk btrfs filesystem, but to do so I needed to disable
> data checksums and small file inlining, otherwise I would get ENOSPC.

We need extra debugging info and output in btrfs-progs to make it clear
what's the root cause of the ENOSPC during convert.

If you have a small enough image, would you please upload the image for
us to analyse?

>=20
> Now that I've defragged everything,

Defrag in ext4 may not help much for btrfs-convert.

The ext4 block group design makes it fragmented in nature, each block
group will have some space used in its beginning, which fragments the
usable space of btrfs.

IIRC there is a feature for ext4 to make unused block group completely
blank, not sure what the feature is.

> I want to enable those features
> back for all the existing files (datasums mainly). How can I go about
> doing that?

You can manually remove the NOCOW attr by "chattr -C"
And then re-write all existing files, you'll get back the csum.

For inlined file, as long as you're not using "max_inline=3D0", any new
file smaller than 2K should already be inlined.

>=20
> I assume `--init-csum-tree` would recreate the checksums, but will it
> also set the appropriate flags so that all new files in all
> subdirectories have checksums aswell?

Don't use that, unless you know what you're doing.

It's for heavily corrupted fs to rebuild its csum tree, not for your use
case.

Thanks,
Qu

>=20
> When I tried to run it (back on 4.19 kernel and btrfs-progs 4.20), it
> ran for a few hours and then gave me this error:
>=20
> Creating a new CRC tree
> Opening filesystem to check...
> Checking filesystem on /dev/sdb2
> UUID: eb930a78-f6f7-4552-8200-6ebdd6c56b93
> Reinitialize checksum tree
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> ctree.c:2245: split_leaf: BUG_ON `1` triggered, value 1
> btrfs(+0x141e9)[0x55d3c529d1e9]
> btrfs(+0x14284)[0x55d3c529d284]
> btrfs(+0x169ad)[0x55d3c529f9ad]
> btrfs(btrfs_search_slot+0xf24)[0x55d3c52a0f9f]
> btrfs(btrfs_csum_file_block+0x25f)[0x55d3c52ae888]
> btrfs(+0x4aa30)[0x55d3c52d3a30]
> btrfs(cmd_check+0x10b1)[0x55d3c52dfc9e]
> btrfs(main+0x1f3)[0x55d3c529ce63]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xeb)[0x7f2eb872309b]=

> btrfs(_start+0x2a)[0x55d3c529ceaa]
> Aborted
>=20
> Did this actually generate checksums for some files and then stop, or
> was nothing written at all? How can I verify checksums are calculated
> and enabled, or otherwise make sure its working as intended?
>=20


--4A72pwC5SBN4e7TKF4LmOTxVRC5fFdwP0--

--c0KBKVZArNVfDLuVGypLlre6Voqy7z2sl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzl0MMACgkQwj2R86El
/qhctAf+P29HN8KBw28cdVdy1O8so9bceppzjNjF8D0wPEd91IBFB350EnC3idW9
1jh0yzYHM9UDJVl9GTjWnVYmFO/Ye5ai4BCCwjcKRY7Vj/OzCEmblZp4FjOaKIRm
4Iy7mJueh0Zdvm4hhKsmkADXpqv2r8wWC9+vO/hEVPLv3KPjE2qx2CuvK6HIbJt3
O3iOLUpRBK7zJe86x0+Y1UNdejhAF1oP0NYvr6aTXPmhflZ91mEgzsuZlABrqaPU
qQ1K/MvFftgnKxz1WwgK0SQHrbcrSCMZmlOC9zXpeO6okTThuvPbzYGlUPRr82KO
w6I9+XJZY5XSYes6gEZjuhdBxaToGQ==
=rDLJ
-----END PGP SIGNATURE-----

--c0KBKVZArNVfDLuVGypLlre6Voqy7z2sl--
