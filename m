Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36A271FB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 12:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIUKJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 06:09:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:50539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUKJJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 06:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600682946;
        bh=kjONB+8RlIsGLERQlARytpiNUom/uEitPU4yGyN/Jl0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kACt5k5FGUO4YGJF9tpY+2uNcbiaBXxUJ6KqQhvobHCTiGrbr84IJrxCBOdvd2m1h
         RNZQcgSYT0zAvP1PmNBb1pAnnOURarEG2jNzMfJ3KcmpEXe3wocP8AlPjMnBgd7OII
         k/NBlLjifHQg17VQVS6iltnvO8tWBSPaKNKahOss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1kzOfk0MoX-00f7U0; Mon, 21
 Sep 2020 12:09:06 +0200
Subject: Re: external harddisk: bogus corrupt leaf error?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <1978673.BsW9qxMyvF@merkaba>
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
Message-ID: <111a2551-98c1-61f4-8981-3f7de4b9084a@gmx.com>
Date:   Mon, 21 Sep 2020 18:09:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1978673.BsW9qxMyvF@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ehlZJHnDGq9M41E1Ig5fNUhga0FA6AjkR"
X-Provags-ID: V03:K1:EuZYsVX/HRrlu8xSa6UOQ+JGIXoyVVGYuNfutV+eBm4+nksZdvj
 BTy9LBq14JkUIcRW5ePdFtG7glZXNVpKWl9Z4CaGPnZ/V87/IrpNZrTomHe5ZMd5iMFXNPk
 zpHLT03LZK+L462R99yk70ps52E+XtcHtxVlRARmsfW7Jh/sxfsftFoc4wRyWb8Ml5/oUhY
 9JfGA95USnkqDCES8eegQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IjiZBsV8ANo=:VRUi71+zet3FyHa3MU1tIr
 6Rsvw/m3Qc66/r51zbnlqTUze9+GbusQUvDGbIRPmt+EMr4/7rNPma8Jx8tHcke2VkQZf7iqP
 khEk7dySTQEuEMElMhoAaObI20dSb+U7UyLnT8iKqLj7z1qRJFnAQTvq4tPVVt2s9o8FfZ6js
 G5tKKV0LmKESTFFXf171Oimk6B3hAus5KltxEDsEO2LgOhgN7JLED0cuxLY26HHkosJOL87uJ
 SHeAYrNK7MkGMP+PEZdNruRZwT7c2nSl6mpm6zBjNlYymk4fef3bNtkaE6GlZcMJ1zYbAOHW1
 L+ddZ1ZALhHMs9MVaZb3kSgIYlKzr00Wd7NwvSekfduqC1Cwb7+mNTLggfX1RUE7hkwVnxcOx
 JeU6nIL5DAmYmy/huy/oDzHZ2PFvqXuQdYnxSQxhXQ8Uh7akYSq+nr570u3aGFcY0iqRTtmf5
 n8F4Iz1jfTIoAY13PvcIY9+sjGRUFxi4ZxiyDOKrd9txW2/3uvy8CGCPXyVjKEItC6REJEUXm
 GNowPsU0lC69sKvEnSeDZcArgosqezQnowS6yUlD6Sxj/QMlFOhX9u1Qjwu5gplV2vyvlC7GM
 bltHRv08yHzc4PIkfCkXYPanhtPTES7nH+ORKc4jReHAyZczfAibAUt9iMGUUXq0KA5uJI/gJ
 NU0kFhxBZbztJj22bAC3bbWWI1bO7aozA61bCDqO+pqX2adMWowPllXaON45jNE1r6L+wtu6Y
 BJOMwS24JvdwMxTlVH1G/DgLHfXUkC/EjX1GkpmTzFmDL5QLeLa2B7qqmDDaBoox0w0XKHpTv
 s7UvrrNZ1xKRrb6VS5I1oqbO2zMWIgeWauclOImBV/p/OV3mxJaVRHnujCC8xIiaGJCUcuaZ1
 wvphvIXMg0dVnFVn6BeRx4srSpF+gicf9mEcyniqofKUiJUoklcAwD0eyQ8C3YO+nxLSTk2ko
 hXElWfUNYGRhrZcJ0kDScxmbI90qDJr9HXrdHJOQIBQ6wCsuMganAUDKqnzfNSVRg/tsgaz6N
 UCnvKGClk7yUkmDMJDhDItT2A24QTzF9GBz56q1MdLsTQ5sJB8/iF896hPEqZbp2YcwQ3bemM
 hG6zq9Al5lPYQNO+9wrHNlIWEQntfTgXH2uY406cie/KEkFiW7nDpH7+ed6o5L9WK0kH0Huqn
 LnZYanWqy/obHICHEs1FjS10G+aP+5S9/eSUxwxDTVZrYWO2otPUySVN/xUj6y3i234/vnE+8
 l4jns/ULLXfj+1he8ihSvsHGzpxR2snezOXVOyw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ehlZJHnDGq9M41E1Ig5fNUhga0FA6AjkR
Content-Type: multipart/mixed; boundary="8luWwhzSePTIYZR3MHGN7SD5MSsIGRbhO"

--8luWwhzSePTIYZR3MHGN7SD5MSsIGRbhO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/21 =E4=B8=8B=E5=8D=885:29, Martin Steigerwald wrote:
> Hi!
>=20
> I have an external 500 GB harddisk with BTRFS. On mounting it the kerne=
l=20
> (5.9-rc5, vanilla, self compiled) reports:
>=20
> [282409.344208] BTRFS info (device sdc1): enabling auto defrag
> [282409.344222] BTRFS info (device sdc1): use zstd compression, level 3=

> [282409.344225] BTRFS info (device sdc1): disk space caching is enabled=

> [282409.465837] BTRFS critical (device sdc1): corrupt leaf: root=3D1=20
> block=3D906756096 slot=3D204, invalid root item size, have 239 expect 4=
39

This one can only be detected by kernel, not btrfs check yet.

Recently kernel has much more strict checks than btrfs-check, sometimes
it can be too strict, as some error is not really going to cause
problems, but just against on-disk format.

And this is the case.

In theory, you can mount the fs with older kernel, any kernel older than
commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check") should
still be able to mount the fs.

For workaround, you can dump the tree block 906756096, locate the slot
204, see what tree root it is.
If it's a subvolume/snapshot, deleting it should solve the problem, even
for the latest kernel.


For the root cause, it should be some older kernel creating the wrong
root item size.
I can't find the commit but it should be pretty old, as after v5.4 we
have mandatory write time tree checks, which will reject such write
directly.

Thanks,
Qu
>=20
> Note: It has used LZO compression before, but I switched mount option t=
o=20
> zstd meanwhile.
>=20
> However, btrfs-progds 5.7 gives:
>=20
> % btrfs check /dev/sdc1
> Opening filesystem to check...
> Checking filesystem on /dev/sdc1
> UUID: [=E2=80=A6]
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 249031409664 bytes used, no error found
> total csum bytes: 242738928
> total tree bytes: 352387072
> total fs tree bytes: 67747840
> total extent tree bytes: 14565376
> btree space waste bytes: 37691414
> file data blocks allocated: 1067158315008
>  referenced 247077785600
>=20
>=20
> Is this kernel message in error? Or does 'btrfs check' not check for=20
> this error yet?
>=20
> Here some more information:
>=20
> % btrfs filesystem df /mnt/[=E2=80=A6]
> Data, single: total=3D444.67GiB, used=3D231.60GiB
> System, DUP: total=3D64.00MiB, used=3D80.00KiB
> System, single: total=3D4.00MiB, used=3D0.00B
> Metadata, DUP: total=3D3.00GiB, used=3D335.98MiB
> Metadata, single: total=3D8.00MiB, used=3D0.00B
> GlobalReserve, single: total=3D271.09MiB, used=3D0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> WARNING:   Metadata: single, dup
> WARNING:   System: single, dup
>=20
> Ah, there is something old I can clean up, it seems:
>=20
>=20
> % merkaba:~> btrfs filesystem usage -T /mnt/amazon
> Overall:
>     Device size:                 465.76GiB
>     Device allocated:            450.81GiB
>     Device unallocated:           14.95GiB
>     Device missing:                  0.00B
>     Used:                        232.26GiB
>     Free (estimated):            228.02GiB      (min: 220.55GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              271.09MiB      (used: 0.00B)
>     Multiple profiles:                 yes      (metadata, system)
>=20
>              Data      Metadata Metadata  System  System               =

> Id Path      single    single   DUP       single  DUP       Unallocated=

> -- --------- --------- -------- --------- ------- --------- -----------=

>  1 /dev/sdc1 444.67GiB  8.00MiB   6.00GiB 4.00MiB 128.00MiB    14.95GiB=

> -- --------- --------- -------- --------- ------- --------- -----------=

>    Total     444.67GiB  8.00MiB   3.00GiB 4.00MiB  64.00MiB    14.95GiB=

>    Used      231.60GiB    0.00B 335.98MiB   0.00B  80.00KiB =20
>=20
> Will run a scrub next to see whether all data can be read.
>=20
> Device stats are okay:
>=20
> % btrfs device stats /mnt/amazon
> [/dev/sdc1].write_io_errs    0
> [/dev/sdc1].read_io_errs     0
> [/dev/sdc1].flush_io_errs    0
> [/dev/sdc1].corruption_errs  0
> [/dev/sdc1].generation_errs  0
>=20
> Device reports SMART status as: passed.
>=20
> There are some "Error: ICRC, ABRT 24 sectors at LBA" like errors in=20
> SMART error log, but they are from a very early time about 290 to 310=20
> hours of disk power-on lifetime. I believe this may have been me=20
> disconnecting the device while it was still being written to or=20
> something, but I will run a long SMART test as well.
>=20
> Best,
>=20


--8luWwhzSePTIYZR3MHGN7SD5MSsIGRbhO--

--ehlZJHnDGq9M41E1Ig5fNUhga0FA6AjkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9oe70ACgkQwj2R86El
/qi6ngf+Pd5OPNvKkusmNht2vNaez5q1sjZ/XjZC08DR8XrZoe2MhlYMg0yzW+NO
i0O4gthRrDhop1AGa9b2OTQveHvd9wNBpiXXEsE3iYNKw+yqkYMu84YitYnONd6b
5q1/IGaY9uPqHBORf0267KmgW4HLmsbuD8TpITKe4c98isgWpSiYy3Y7mlxWn6wf
7jovKiK2/5/qluOSXw5EoIj0tuLtq4e+LdETynxdb9GACzJJRGCUKigXLjI8npWW
OG1PkIESlm2rIJ6yDo/AX3AuHgtbaXrujZkI4wlmUtrNcluJofXZYijjAQ4yMcG7
UH71ijINgLLcXmVTnif/Uw7gMGWx/g==
=rJ6d
-----END PGP SIGNATURE-----

--ehlZJHnDGq9M41E1Ig5fNUhga0FA6AjkR--
