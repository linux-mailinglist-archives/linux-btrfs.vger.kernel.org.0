Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1791D2120DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGBKTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 06:19:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:43295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGBKS4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 06:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593685129;
        bh=v+ytrhB/F4KdRxof7BN9xHhJ/SUy3ZPqWlJN6jzE97c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GDHzI8RRludTW45p9drKn9pXBS/iGD4I6JDHd6PDrs0acu3I4EAz+naPzdEkF6omY
         Es7xYirzHYMmdN4XEHCPhabj33XhRHt6PI1rJ8EwQ8RZBRs9420L+GDukQMtbZaQPX
         /dNGwsXBsGiabR6dIn+Ljip1/88dvBFgIOVWhFm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1itkB947OF-00yR9K; Thu, 02
 Jul 2020 12:18:49 +0200
Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
To:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
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
Message-ID: <1d41a247-a4f7-124a-4842-f7d886e9aa70@gmx.com>
Date:   Thu, 2 Jul 2020 18:18:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dpr3Izv7OxGkUE0DLxFNP425tiI2xNvZj"
X-Provags-ID: V03:K1:V2Ex/3XWSxPlWrhvYtDrhxCG7IbADdvkZpT60CGLuTcc/iYOucH
 ZeBi55XMN4CQzY7TULP9KNTV8pkepryuBRnZxDSQx/pbYvTmqxMUQjE5s/CWFUWq0T6mZVg
 xezibHu8+N4sNL1lQbiwccA0n2RanD73+bIqo0gwTN2fEOHgTtdXYg3m80814c85a05C7cq
 OfHriiEhB0skahrlNx8uQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+W/IM8imSqI=:6l/xLWihosoGTb+M11/kWv
 QgCLuIxtFXf0VhasAr1idCSS1NYM7iuNvRbHD7DGaVVrm/QH6qrJOk2VFoYeJcZAT0Ck+GS3g
 9a6H1QWwiAxiXNsFUv3H6zXP+ihkfhb0Z08dNJ6wPSBRjZGfOrSsx0/tNB8KW+b0epXb716HJ
 aMdI9aToHHNY4OLkRhwmddLVjgzoMckL3BfGrfxvNJ1hLmOO9kesPh6mckQGT5N5uM4t9CPk+
 wNOPcOXawV9QG36LC8mffT6WJGcNSLdrTu14uu4022yFocmumCN4KQEh7k3eL64oPKwCfo3mT
 +5NjFtaMnxD1rL/5FM47rF2IZwRvu0hADrW0sLUT5cgUhJKuNQPEJpc14MB05+dLeWP0MrAAr
 RzE8onK6N3fJCgE2QtFRNHfo9+0+NqXxQ3Ejt9AXm2sPLtZ5zI1rTOQAC/1SJ9TaqpbMoU/Kt
 gZdab/U0EOIjTbGTBcXCsZSJYoQI2B5qG88O4DbTqXAlt4l4L6iaXjO30KnS8TJQyDSCvValL
 8nppGy7EMtuAErL9w0ePKn3WkHc2rOUUuOgGKJc8DIze4Z/iECruy2JxYSs6K1RnCMmxB32gc
 6yfVG00WxvZiDhDVXkVK/kXto0ouO3mA4dmts4zdcj3UVMoarQAE9DEfTCFsMcFH/gUEmzZw6
 d2WhgwNwqw8RuNZT3yujwlZySrVBY7swNHRefyxYAJSzJuCVqZ5GPEX6m9PUxe8azmnJxkg79
 aq+etg7y5XifpZj+fEQ6RLqvcPdeAKhlBD5G6lgOz/ARUUYTY+hFRIZDlxuWgIR3nleCHxggQ
 z3lZRLFBBKdoYwT7v3B5dN57YxB8HjauS5f/mzFVOE7NrshkFgKyU2KUNfEXWgI+OmCr3QVIM
 Yn0hVJeJ+8ncx1Kl98YdQTAZsGqSDBrj5+t4td4AZdwbPU3zKcHkraQAejzenC43OR23zrkwz
 nyVJvnlS8HhPJgqvUVtBOHnHQTOpsaKbP3cnyloL5XP97ZYAtdszYnmXLMzTQtHjPWvTl3l2J
 1kVvwe6WrmRxWyoyqAnh9HNgcB1+u2clyjL1XSwI3ir2EC4RtNNCIPqz/PdDqCMDNQpd63NVg
 RRyb7mUaHkG7aiXbgeKijpz6RPY45SaJ/ihXpWcL9+FsexS4YD36czFcfLD9LELmNIANojkGz
 aOc36qsmw3lVMSUprRJ0yvpUDHgMbV9uWppBiVTpy18hZgnTa6CJe2ti99opCH8qhezMK/noR
 963Si6pYVTmKaBxmeSO88dVpi7UZxEb+/2pNYvA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dpr3Izv7OxGkUE0DLxFNP425tiI2xNvZj
Content-Type: multipart/mixed; boundary="VzyVEMpo44swnyeg6OWkk8eQyEZjW9k7W"

--VzyVEMpo44swnyeg6OWkk8eQyEZjW9k7W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=885:11, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote:=

> Hi all,
>=20
> I'm collecting file extents for our application from BtrFs filesystem i=
mage.
> I've noticed that for some files a get the "wrong" physical offset for =
start of the extent.

First thing first, btrfs fiemap ioctl only returns btrfs logical address.=

That's an address space in [0, U64_MAX), thus it's not a physical offset
you can find in the device.

For example, for a btrfs on a 10G disk, btrfs fiemap can return address
at 128G, which you can never find on that disk.

This is not that strange, as btrfs can be a multi-device fs, thus we
must have an internal address space, and then map part of the logical
address into physical disk space.

> I verified it using hexdump of the filesystem image: when dump the cont=
ent starting from the address returned from FIEMAP ioctl, I see that the =
content is absolutely different from the content of the file itself. Also=
, the FIEMAP ioctl reports regular extent, it is not inline.

If you're using the logical address returned from disk directly, then
you won't get the correct data obviously.

What you need is to map the btrfs logical address to physical device
offset, that is done by referring to chunk tree.
And even after the conversion, it's not always the case for all profiles.=

For SINGLE/DUP/RAID0/RAID1/RAID10/RAID1C*, you can find the data
directly, but for RAID5/6, you need to bother the P/Q stripe.

And furthermore, there are compressed data extents, which on-disk data
is compressed, which also diffs from the uncompressed data.


For the chunk mapping, you can verify the mapping of <logical address>
to <physical address> using btrfs inspect dump-tree -t chunk <device>.

The details of the btrfs_chunk on-disk format can be found here:
https://btrfs.wiki.kernel.org/index.php/On-disk_Format#CHUNK_ITEM_.28e4.2=
9

Thanks,
Qu

>=20
> Environment:
> - 4.15.0-96-generic #97~16.04.1-Ubuntu SMP Wed Apr 1 03:03:31 UTC 2020 =
x86_64 x86_64 x86_64 GNU/Linux
> - btrfs-progs v4.4
>=20
> Does anyone has any idea? I would appreciate your help on this one.
> Tnx.
>=20
> Best regards,
> Dejan
>=20


--VzyVEMpo44swnyeg6OWkk8eQyEZjW9k7W--

--dpr3Izv7OxGkUE0DLxFNP425tiI2xNvZj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79tIYACgkQwj2R86El
/qgh8Af+KMhmdrel4OC7Pz7typXL/q5Ed2ZbmqWiqS/fYGLoJrNqXV2Ln0JMr1FN
nIRmoM1BkDoGV7auAA7ZL6VerjCBGj1xHj81FXUr6H9K4XYa/Y1nUYhiN1Z6v/Ao
jEBWzxB0Dish1ToNoO9hXtAl72QI49DryLnT/Uo7NvKuZ+3zYlEMhA8xdMmbW9/i
fbtMi5UcgyiI0Q9WOlYExy5tcyT/X6c9i8zUE/NkpvDYnLrsr/vfIQOLDEqI1bf3
r4/r14rjeBlxXSPK1buNWHfQYqpJgPaHMx6c+8C6FDxFhIbvmxbAIPKHzdO/FeWX
5i2eU/RBft2J82wb4/21CyjXPw0TpA==
=CLNO
-----END PGP SIGNATURE-----

--dpr3Izv7OxGkUE0DLxFNP425tiI2xNvZj--
