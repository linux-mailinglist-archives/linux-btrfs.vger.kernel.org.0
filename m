Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4CD7670
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfJOMYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:24:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:35939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfJOMYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571142260;
        bh=9RY5eaTjmmKz8UvEoICIAmP/v6T4nIKJPmrBNMtp6/I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WNycNLjZ9RkxmN1YZItiXZSmnWyOm27u+UaTAkDNfHPgn6fW9ypgTFVU22QuvaoAm
         zj6q1H5zDa2C/Lmjr1EHPxh/bxt6zjOhUIt88UvG7fPCyDyli1lC75DgEPVrpXsD8R
         Kl34wmSYcQZ+6P1fb2m7C8/m10TMALvUcwTiIgb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1hu7mB09iN-010cIE; Tue, 15
 Oct 2019 14:24:20 +0200
Subject: Re: kernel 5.2 read time tree block corruption
To:     =?UTF-8?Q?Jos=c3=a9_Luis?= <parajoseluis@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
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
Message-ID: <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
Date:   Tue, 15 Oct 2019 20:24:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c7oq5XDvwN8x33hgGy0lgDHvIfkTYWaBK"
X-Provags-ID: V03:K1:ni4ydVjjvYKml1rfEmm4r5aBNn5qDtt6YQrDXqBS6AB2FrUNeAy
 ggRGJNEwvVX+3oDEaCWaikz2swxrbbNDqmVLAZkMAWLl72IL9ni6ljCAGXrCcj4ItyvUk+Y
 SGFeiYJUZ8YAtljPFnvwD4k8muLCAMRNAw1YJmMRpDX28Io/37dam8vJ7ynqq2uiBEbiNni
 Ul03e1k9E2cTVIQBsYYaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fvoveJE7WPQ=:Ns+A61KUZdj65IamvItgiA
 tgsemTUrl7lbtURfNmuNbiMzIEjy/T7i5odMzfYMtUfXz7hylW4ddyhSbba4sQk+GOvJ0RMPx
 HojkA9hzM4WZJQtoalTKa2YIImgcQ9obZsIFMNk8+Bntt2BiynSyAlVhb1V55XhfGpMP5j1Sy
 wKTLFrd5TAQiRoQkyTe7HvFTdDP2fP9fLYrTi34FBggtvPBRmMUSFH+Bxb/7PzWHRcnJQkI6A
 XkZo5fV72EoOenVFw/ouDisMhmN4Stj+XL8EzTC8hp2METVYrvcos0F6oTWGPF1WuVHsDUDAU
 2JZx5EkixMXPHkrSzEsmEHombjtkLSTAVrZ+fbJXrWMR8DJjHs/HQOfHcKENE4CkhH4eLnyOC
 ZN+XSk2914d/3DFA8L4g/J9kBUmPIhuHy0T8JhckpvbArvvUL2CjIFaesvNhFJ3Wemc3ubMsG
 Fv8wPW8qQqv8gj57qCpSYDaNbuw+Z1+o+N5BB9oBq5aCh/9tG1kcVOGU49erOGiPv27U5olXk
 GSIObAdYhI+Fw0Oopog2cvjaqp0TqmCTlcofZVyUoErhCYBdyxm+O5R3mQYEubZHGHLRH8Rmt
 wOBzWYsgJeoapg9OHpoXA8GiZK0xRZqiWbtk0DyIIqoiH2uhf9LoLu3mBHo/pdzZr4arDgTjC
 lUN/Af5HLV1LHAcLzhdr+m5ep9onsOQpvjULbym7BGJP2f3G7vrS8O0UfiHHo0q7kRkttrSZ4
 oJh/UbrYFq8mNgtsEYxFXFBEtuT0/zMu9mDGDCUcvmCAtCrliDjL6ZoPgCw3Fb6kZDdR5FsR+
 k/GpT7ejNsSO45okJf3Wt7ix/Ew6wG6J0aApP33jCGiF98TDHoqGpewxrP3PTg6OBMEnGQUcq
 VXK7RK4gKBIBIY2sMYPidDrxh6ywDaNNaB7sKdrIkb+vShaL21xMZIQznC+PWTA3yanwEt90O
 7scmerc1f+9svKkGfH4esH/Ao0sLgwmI8JJsmKtuGECxuZkbAjGFLdgbGvlmbH4p+HGrZqt/2
 s0OnwpQKujeaX4gc+UDaEMrkHbppsVx0BuSfEG9BlWpG4WSzN/PYMckXJOGH+vgmdpo0igoQl
 tOc6LsFHZH7XKjaXnNCgQKfk9ot7fHsEY4VYDkTHtklm28izooSdjIKdbv+KWnD8+XDSOp+Tf
 vy7Zxz/LIK4aIzpLHiFzA10o0gs0+Ws2wYPXoYR9vviH8y4XBwbOLeM9tHxREblCCZl6pC4Ro
 jd6YqC/YOLu4K8FqTEQ6e+xAIu6LHJ+OSxs/LaJp2McTpwfJzZj6kyHIYTN0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c7oq5XDvwN8x33hgGy0lgDHvIfkTYWaBK
Content-Type: multipart/mixed; boundary="wkBbh7EJ77JLGYin2Kj8a5uiMohFOIytR"

--wkBbh7EJ77JLGYin2Kj8a5uiMohFOIytR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/15 =E4=B8=8B=E5=8D=886:15, Jos=C3=A9 Luis wrote:
> Dear devs,
>=20
> I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both btrfs=

> filesystems. I can work as intended on 4.19 which is an LTS version,
> previously using 5.1 but Manjaro removed it from their repositories.
>=20
> More info:
> =C2=B7 dmesg:
>> [oct15 13:47] BTRFS info (device sdb2): disk space caching is enabled
>> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimizations
>> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D5 blo=
ck=3D30622793728 slot=3D115, invalid key objectid: has 184467440737095516=
05 expect 6 or [256, 18446744073709551360] or 18446744073709551604

In fs tree, you are hitting a free space cache inode?
That doesn't sound good.

Please provide the following dump:

# btrfs ins dump-tree -b 30622793728 /dev/sdb2

The output may contain filename, feel free to remove filenames.

>> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read time=
 tree block corruption detected
>> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree: -5
>> [  +0,044643] BTRFS error (device sdb2): open_ctree failed
>=20
>=20
>=20
> =C2=B7 sudo mount  /dev/sdb2 /mnt/
>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
>=20
> (cannot read superblock on /dev...)
>=20
> =C2=B7 sudo btrfs rescue super-recover /dev/sdb2
>> All supers are valid, no need to recover
>=20
>=20
> =C2=B7 sudo btrfs check /dev/sdb2
>> Opening filesystem to check...
>> Checking filesystem on /dev/sdb2
>> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> cache and super generation don't match, space cache will be invalidate=
d
>> [4/7] checking fs roots
>> root 5 inode 431 errors 1040, bad file extent, some csum missing
>> root 5 inode 755 errors 1040, bad file extent, some csum missing
>> root 5 inode 2379 errors 1040, bad file extent, some csum missing
>> root 5 inode 11721 errors 1040, bad file extent, some csum missing
>> root 5 inode 12211 errors 1040, bad file extent, some csum missing
>> root 5 inode 15368 errors 1040, bad file extent, some csum missing
>> root 5 inode 35329 errors 1040, bad file extent, some csum missing
>> root 5 inode 960427 errors 1040, bad file extent, some csum missing
>> root 5 inode 18446744073709551605 errors 2001, no inode item, link cou=
nt wrong
>>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.BIN fi=
letype 2 errors 6, no dir index, no inode ref

Check is reporting the same problem of the inode.

We need to make sure what's going wrong on that leaf, based on the
mentioned dump.

For the csum missing error and bad file extent, it should be a big proble=
m.
if you want to make sure what's going wrong, please provide the
following dump:

# btrfs ins dump-tree -t 5 /dev/sdb2 | grep -A 7

Also feel free the censor the filenames.

Thanks,
Qu

>> root 388 inode 1245 errors 1040, bad file extent, some csum missing
>> root 388 inode 1288 errors 1040, bad file extent, some csum missing
>> root 388 inode 1292 errors 1040, bad file extent, some csum missing
>> root 388 inode 1313 errors 1040, bad file extent, some csum missing
>> root 388 inode 11870 errors 1040, bad file extent, some csum missing
>> root 388 inode 68126 errors 1040, bad file extent, some csum missing
>> root 388 inode 88051 errors 1040, bad file extent, some csum missing
>> root 388 inode 88255 errors 1040, bad file extent, some csum missing
>> root 388 inode 88455 errors 1040, bad file extent, some csum missing
>> root 388 inode 88588 errors 1040, bad file extent, some csum missing
>> root 388 inode 88784 errors 1040, bad file extent, some csum missing
>> root 388 inode 88916 errors 1040, bad file extent, some csum missing
>> ERROR: errors found in fs roots
>> found 37167415296 bytes used, error(s) found
>> total csum bytes: 33793568
>> total tree bytes: 1676722176
>> total fs tree bytes: 1540243456
>> total extent tree bytes: 81510400
>> btree space waste bytes: 306327457
>> file data blocks allocated: 42200928256
>>  referenced 52868354048
>=20
>=20
>=20
>=20
> ---
>=20
> Regards,
> Jos=C3=A9 Luis.
>=20


--wkBbh7EJ77JLGYin2Kj8a5uiMohFOIytR--

--c7oq5XDvwN8x33hgGy0lgDHvIfkTYWaBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2lum8ACgkQwj2R86El
/qirZAf/RDCBsCLHyiKUsLnPhMArmQmx60h3YLKdtwvMgs4d2j+Yw7tnRmdhKzpG
1E/mdIX2hMQuj/RQYkzoqAS4yH5+ZT24U7FFG3BL8V4XfIsCKmUUQ2aI1s9sWQqo
XiGocylnZgX/43irMEln68LCu3Y/EFNRuRIzJ0j1LkcVlgthjHbPljNBy89FCJB/
7QRUFs/YVT7guz+auvnZsRONsOyMxuAWm+quYAl6+djHs0Q3GXgKglZ9OdaHwVw0
1GCXWvcTYsvF7tYah2nGpgxixbGG0bMqrZ+vXmGqsrGaMluCg/nBKjSqLQlLpSlw
tF/5lKs68xtmfJUTrY829+3DJewQng==
=iwcg
-----END PGP SIGNATURE-----

--c7oq5XDvwN8x33hgGy0lgDHvIfkTYWaBK--
