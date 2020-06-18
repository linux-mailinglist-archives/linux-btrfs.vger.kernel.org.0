Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B451FFE52
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgFRWtL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 18:49:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:57837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731370AbgFRWtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 18:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592520543;
        bh=1AHL9xk/BR7/zBVtNIcasaKF+B5agMIfUMFG6RsZaZg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U7wBNIAgP5UWpycxM7g17ZxQ44+1yOLdVF/rkgVlzEZrnVXUIokYsklKKpSiblDVS
         dVs/LjGrGuTvZXDCr2tFH0JZ7exwlvaZ+6nw3YRwdRzg4WI8kZBvSNPqUxQlFlUTcl
         Bmsl2s9uRdEKiS0GhlnoD+hDdn+jkN9XzpQD4/MY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnakX-1j4hiM0QgH-00jdqd; Fri, 19
 Jun 2020 00:49:03 +0200
Subject: Re: Physical address offset of the inline extent
To:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <31850f19929b40e4ade80a264c1af97d@rs.bosch.com>
 <02fcfb22-6b2b-6f99-99c8-b132ee511530@gmx.com>
 <db80cbe323fd4114962f7dee1dfc3ad5@rs.bosch.com>
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
Message-ID: <d0a0d1fa-4f77-6f94-b82e-72f44a3e2a80@gmx.com>
Date:   Fri, 19 Jun 2020 06:49:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <db80cbe323fd4114962f7dee1dfc3ad5@rs.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qHxYTcF24GUYUPsL3Y8zC4SK9BJUiJ1LG"
X-Provags-ID: V03:K1:9AB67zsUCuUwaMnnI9ZVtNgtJePg76eg2+VCz5WbhUFHOeDUSIl
 LBRjRMvRW9ol5kKOEvjzprFXEqBY1JMSZv7wQxkfq53cU+Pz+wxhsG73LcBUZzhC+sswbfz
 6u6emITaryb33A5/nuu/sZP6DQCNt0m3Uq89NEpTE6x8fvfhvUo6v01Pk3g69sbio0DmYcM
 acPji2QRbb4hZ+H1G2zDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b0Zq8CY04EE=:qRyW+BV4e1GTWPEqRJbQQ4
 FA/E9DJtqVYCziGj9Ezh00ryXRBEILK6RjUr8uPUDG8iZ632+SkiRxfyogd1uQ4U7dFHuRilv
 PjcQWfBbAeTGnM9BMzfgkslCKjJtEG1BtBt7JiXicKrTjAtPQjA4Yor0K1vyiFIbJzaJPjceB
 Z4/+Ilf91Pyqff5l/iqI7mcRYpxDrwZ/FWYxNaDhw3HdOpRVm8sgd9fiyLS483zNp8vAeMmeb
 M6I/c+rQkZ3vdUJY7NqQ7RlDhiYO/6SgRbN+semkG2I/YQCCsxAPVuGOkvwOptumDxx29qJIo
 ItOP2kAzwLBiXo3A9Ue0YgLjhR0GrR4FZr7qJ2ooHiIEWRAMjzEB69K3i3nI98Ds6iMri/5P4
 JAarkv7sjHfBUbifhpvqU0bk7oClz88jdkl71Sobvvz5Qch20zwGXto1XLVczf6yFjIm3ifoc
 UZdtCFtqUfYFsncXYtWzN7EtSW0KvtVsCu+habd8PaX5Hl8v8rfWsxBZMenEw6RkSJ+ujoqzk
 8qp/qlgfXbiS/I6ASGhkj9n3XbgMeIN8Q7fHheOGd22DvyMbfnjjhjf0+urqVI+F97VWNkLQr
 eAFlr6kU2i+5AtNf2qrGbFrtQJkBi4Ko76HFrV146KO7u1aKw1zqXI8nrLvyIBNUNCJYT7yS6
 Vv+3fvuqY7rdI9VsGfR4RssC906w5BCVj/jFKdkFt91nFPlCYPZ9e9vaFa65QNhkxOjuqCv/6
 n2aCMOcu2nu+6XfblJjk1gGQ9ISrmOrAtCFTOn7nMoh3cYOnST4Bxjua9D7gqHf4OOkH5VMw2
 +HrMJtlfpfoUek/hs+EhKTyJi5JjI902VCXKqIUUHXX0H3A4/tZc3sXFtVrSp2RS3wvedJ4VD
 xmtF/88/3Zq07KvecE3o2cnlbM2BDb1MrAlLDqkwQif4hjgKRKHyado+Z9lybhBvKTxQtMOtv
 TtYgkrpJct60SAjNcdEzqGJYunpPtNGjbqfWOTn4y3j4Iw4EMYpsZUUJW0fnbdwWXvmqfcpME
 +38FaNKpn56GBVF1+jpZcFiQNQ3zMQk1iGtlIQ3PRmm+gRFL04lH9al6OS34truv6FhZHN6Fv
 TlB96OEZet8FO0IDIgQ07pnYmDLj2iUeAbX2MWJy3DjzD5kWDOj35LO49Hozd2c19/fTSGjEi
 FDd/gFGma6VRmLhDRcy3cAN2pnbjQj40pSTD4tyr1VSd83segMX6sEFXDx0mb6Ty8CDkZrQHK
 q2cyr3YWfDpkTn7jZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qHxYTcF24GUYUPsL3Y8zC4SK9BJUiJ1LG
Content-Type: multipart/mixed; boundary="3uiNroEhMMg5jSwX2GX3oScL3sbDaMMyH"

--3uiNroEhMMg5jSwX2GX3oScL3sbDaMMyH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/18 =E4=B8=8B=E5=8D=8810:53, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrot=
e:
> Hi Qu,
>=20
> I've read this:
> https://btrfs.wiki.kernel.org/index.php/Data_Structures#btrfs_key_.2F_b=
trfs_disk_key
> where key.objectid of EXTENT_ITEM contains the starting byte offset of =
the extent it describes and key.offset of EXTENT_ITEM stores the size of =
the extent the item describes.
>=20
> From your dump:
> item 6 key (257 EXTENT_DATA 0) itemoff 13794 itemsize 2069
>=20
> itremoff =3D 13794
> This is the offset relative to tree block or tree leaf, right?

Right, but you still need to consider the offset inside
btrfs_file_extent_item for inline data, that's why I'm using
btrfs_file_extent_inline_start() to find out the real offset.

Thanks,
Qu

>=20
> Thanks,
> Dejan
>=20
>=20
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Sent: =C4=8Detvrtak, 18. jun 2020. 15:46
> To: Rebraca Dejan (BSOT/PJ-ES1-Bg) <Dejan.Rebraca@rs.bosch.com>; linux-=
btrfs@vger.kernel.org
> Subject: Re: Physical address offset of the inline extent
>=20
>=20
>=20
> On 2020/6/18 =E4=B8=8B=E5=8D=889:21, Rebraca Dejan (BSOT/PJ-ES1-Bg) wro=
te:
>> Hi,
>>
>> Does anybody know how to get an address offset of the file data inline=
 extent?
>=20
> Since it's inline, it's inlined into metadata (tree block), thus makes =
no sense to get the "address".
>=20
> The address will be inside a tree block anyway.
>=20
> If you really want the address, you can check it with dump-tree.
>=20
> $ btrfs ins dump-tree -t 5 /dev/nvme/btrfs fs tree key (FS_TREE ROOT_IT=
EM 0) leaf 5324800 items 7 free space 13619 generation 6 owner FS_TREE le=
af 5324800 flags 0x1(WRITTEN) backref revision 1
>      ^^^^^^^ Tree block bytenr
> ...
>         item 6 key (257 EXTENT_DATA 0) itemoff 13794 itemsize 2069
>                 generation 6 type 0 (inline)
>                 inline extent data size 2048 ram_bytes 2048 compression=

> 0 (none)
>=20
> You need to use extent_buffer to grab the inline file extent item, and =
use the btrfs_file_extent_inline_start() to get the inline file extent of=
fset inside the leaf.
>=20
> Anyway, you need a solid understanding of btrfs on-disk format to grasp=
 the above dump.
>=20
>> Kernel returns 0 trough FS_IOC_FIEMAP ioctl, but I would really like t=
o get real physical offset if possible, most probably meaning:
>>
>> In FS tree - on-disk address of the extent data item for the relevant =
file object + the offset within that item (0x15).
>>
>> I was hoping that the key.objectid of key.type =3D EXTENT_ITEM would g=
ive me such an information, but apparently this is not the case.
>=20
> Key.objectid of EXTENT_ITEM only means the inode number.
> Key.offset of EXTENT_ITEM means the file offset, for inline file extent=
 it's always 0.
>=20
> So it looks like you're not familiar with btrfs on-disk format, thus I =
doubt the usefulness of known the inline file extent offset inside the tr=
ee block.
>=20
> Thanks,
> Qu
>=20
>>
>> Thanks very much,
>>
>> Dejan
>>
>>
>>
>=20


--3uiNroEhMMg5jSwX2GX3oScL3sbDaMMyH--

--qHxYTcF24GUYUPsL3Y8zC4SK9BJUiJ1LG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7r71wACgkQwj2R86El
/qgH+Af/SKicfOr7pT99vMfx5BfZ6xiz/NIWP4pN22CCvk9KDauaBYai+ThrY+j+
8y8EEX9JFyMaB1m8KuCU9hX5emaZvV9KZgs6yCyFX4Dv6Sfa+Mcd4kQn8AHNqD9g
HtcS+PvCPf+OzsjVbBB5Gm778H619zLSEhJ2isbWqKGbd5SYQy6P8sc2aO0v+k+a
Zf5QPmM53kuTel2HC/8H585AOamB1RfQLuBOaMVfDzvwoy4KJxODi42I3K5foHzi
+9EXGANLrdhUWhOimLfmQCaUzq3u77vdk3PW8nGMXq6dvxe3YRDYZy5w8jwsA95j
dKr/oYMR6Bezs15XmxQYDEJ+atBCrg==
=Z7hm
-----END PGP SIGNATURE-----

--qHxYTcF24GUYUPsL3Y8zC4SK9BJUiJ1LG--
