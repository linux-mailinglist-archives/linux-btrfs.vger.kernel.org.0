Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74021E7E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgGNGKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 02:10:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:36167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgGNGKu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 02:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594707047;
        bh=XS0B7MkdczDyOBw3Mdv8IGzY0KT0ZelnaT8ux2OhqvA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M2cLOC6MW1rH2S+0QlDHcn7erTv1Znyqfyxuxdq/eYeXVEDO6PWyq5oRFa+UfYsHD
         ppuG+vOVOdX09bPfDdPnZ5Y9Anf3+yLR+kJMhNwmlzKHGkd07jdDrdURGKObEuQx+V
         H4AdTRmNxhEt0iLt82ANxFNML7rZWBKRxRP+FdWE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MK3Rs-1k9zqa1uYw-00LTjg; Tue, 14
 Jul 2020 08:10:47 +0200
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Christian Zangl <coralllama@gmail.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
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
Message-ID: <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
Date:   Tue, 14 Jul 2020 14:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0NGKq3i4p8X5vJe4tkFibBEj9R2IdzpWY"
X-Provags-ID: V03:K1:ftjKMsHMlTEdNr7kCWBaI2gd33VUwqAmjj2yloK7fWQmd3TJlGi
 kB915qwb9M8tygCfVNYAY+42QwwpNcQfRQ69qXJNWn4VZa3NzWefgW8eWBNPfXdytoD7VZu
 1a5L0XZW5fFxs9t/80s5HAHMXC5ECjelv2mOM4tSHBijW3EGHwr/SYGEgd/1J1Ct8sZOd9p
 ZIQpMfn2aX2xJPJ2HIoXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1zG6iSjOWcc=:82sBisr3qXOcOdmE543pES
 oHlvPbCDgcpgmmZJRDKD5mAGKa3CW5G0kOneIU0G9atoQI/UlkOnrzXujERzyAyar50TJ1xB+
 fIqh33+stkTg/niNh06dGPVLjV9hK26B8n+2nbF8ntCA6mXSV7kJqBn4MHynZyfaMvhQ+a61O
 tC4fn+EdaJ5dlHmfdNrqtAfo5WQVrrCBFSyop6LA01WVDQzvRG29sOzY4fqRBfKUDVtLb+GAV
 MOVrwc1OE3WNwXtwljsaZ0yBbQJaV+C4/SCP7SX4ENAJVUjzkJKNIteZNnA+SlDl5oBuQfRLQ
 hXNkjLnb2395J7mhmMtYg+BZ8fnUJXuwDlV96Kf4aTJ1ze3QwbpSbgRWR2xaBsAXrj5yyIphc
 vEhHtDLmZxlykGCrQR8kfvAWXl8Es2YYPVJQajH0h+wb8lVlEC8SZMZ2qZwT6tPUV1mP4FRtl
 0EltkqOGCFqVsJmrptWWoeRiKpov+aLtxf1gx9Wgl7PKDcEf/zICQ2wjiXpB6aXuXFqt2sDpN
 EfSf8xS0erCtIgKsOMaEIOX6obhOhShuWVSy1qDTxLB09JKFxnDr18BKxvtoKALbEkU0slE8c
 dWqOkhZnEg8F6isutoVEzKa5gVSTiTZR+YBda6bmm6lxK84JHIOKL3a5IMxiLj4ouImIie4qB
 qhOafxKDHsUq/FJXCMLBAE7HvPbjU3ZVlpGeBm60/+dLeLcRuPD1BmI5i2hRUNy52UQHLgWIY
 qV5H8+8MyyGr60IpWur4v8AdAM8MwatSdmNpb9nioZVgzGNq11pcZG7h9fmJmFBJtp6YvrC+L
 v5VqDQ1mseUcU0q2pMguP/DqmdcBVO/m/UP3gJLhvT5lVldj8wnttiVF4ix5TsY2xdkLCgY7i
 oaS+jsI/s7LEAmgCCJ5WCKzs63VqvhIJ+LxemkKaEU3zsJSv5YJUL94iDy2YHqKJ+Ps3HWdOe
 gbKdHDAx+pW13AmWIgnmIyYfcm+aJBr2c4PR6MZoOczIkut5ieTkg2gAIkOITZXdo6QPEKAcm
 cc1hscMfaTDLGTr6GLfHqNwY462R5YwUOJHbmKSg2RzdK0mBmV/r/ey4j0eoqNqaU0N9q3kdV
 VwIgq1qtkr6WZf+bMaCHAWJM0F1yXJK8pJtxEsK8OmAfefWdyHIzZ9eToVVjPGWaP4PSJSl4i
 YXy7ENovC71yR6m3B0o4osYB8t6TSISZo+KfONW2qdE1FzR67sSh5J5EW1CkqREPmWKM0V4qJ
 pC8OR4v4RGL4ZMvxzDzkyiUyEG30y2YoOD3hByA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0NGKq3i4p8X5vJe4tkFibBEj9R2IdzpWY
Content-Type: multipart/mixed; boundary="6oaMt7KayLMMvSWZpGBLyq59FiKXcukxs"

--6oaMt7KayLMMvSWZpGBLyq59FiKXcukxs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/14 =E4=B8=8A=E5=8D=883:46, Christian Zangl wrote:
> I am on a test VM where I am trying to convert a second disk to btrfs.
>=20
> The conversion fails with the error missing data block for bytenr
> 1048576 (see below).
>=20
> I couldn't find any information about the error. What can I do to fix t=
his?
>=20
> $ fsck -f /dev/sdb1
> fsck from util-linux 2.35.2
> e2fsck 1.45.6 (20-Mar-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /dev/sdb1: 150510/4194304 files (0.5% non-contiguous), 2726652/16777216=

> blocks
>=20
> $ btrfs-convert /dev/sdb1
> create btrfs filesystem:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocksize: 4096
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodesize:=C2=A0 16384
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 features:=C2=A0 extref, skin=
ny-metadata (default)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum:=C2=A0 crc32c
> creating ext2 image file
> ERROR: missing data block for bytenr 1048576
> ERROR: failed to create ext2_saved/image: -2
> WARNING: an error occurred during conversion, filesystem is partially
> created but not finalized and not mountable

Can btrfs-convert -r rollback the fs?

If you can rollback, would you provide the ext4 fs image?

Thanks,
Qu

>=20
> $ uname -a
> Linux t-arch 5.7.7-arch1-1 #1 SMP PREEMPT Wed, 01 Jul 2020 14:53:16
> +0000 x86_64 GNU/Linux
>=20
> $ btrfs --version
> btrfs-progs v5.7


--6oaMt7KayLMMvSWZpGBLyq59FiKXcukxs--

--0NGKq3i4p8X5vJe4tkFibBEj9R2IdzpWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8NTGMACgkQwj2R86El
/qh0sQf+KsJjqnnl1Xd7cz6z23MmduofIqZ+CGyrq0iIDZojs6sMTVDSd4iZcLDz
scVpvM0M44AVG+iHmweL23PPMLErZYRQIsWjY6liAnMaxrx6K3FAJcacjGzbhrFi
TJKaMOS7vUaWo0SRk5uUMQ5V8M6Nfiyq0+wsCcaA+GNdTjE/opfJG3PM4JjrHnMN
qux5J6bBS+UGwN7XxsUIKQ4VP7dUlSe04+PoxQCFNnAVfO3XiQNqaT4s5vygo5/y
yTtsWvBWvvGmsgeeukDpETsr3+qHWVoLvdJUUdF92QUnzxJw4r5N10vGIAHXitYH
jCMJgepKs1Dh1M0/ilZodXo3GWRzsw==
=yI1Z
-----END PGP SIGNATURE-----

--0NGKq3i4p8X5vJe4tkFibBEj9R2IdzpWY--
