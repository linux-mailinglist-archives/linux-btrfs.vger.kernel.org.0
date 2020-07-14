Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9621EDAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNKK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 06:10:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:42177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNKKZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 06:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594721422;
        bh=za6sdt9PSglue1uEORVEevwMBsSYyVlkG3ni/XG72k8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OibpgivgRVujx4lF9dtHtlNZ00F1hL1SKW1UZND8QJfI3WVYhOvd/M2Q7EYafp0DR
         iZtv38/IOTp7xiNebYeT22DCeK/XInp7ET1SfwDsr0eT3GpAbMsDnMp6eZeOD8qLN6
         GdWUSgMJMKwu0ChEPTs5sQ3LMXxcMrgT336Y+RXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH5Q-1kR3Gj3Ybc-00cfRe; Tue, 14
 Jul 2020 12:10:22 +0200
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Christian Zangl <coralllama@gmail.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
 <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
 <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
 <b49c8f68-5897-7bc1-21d5-03125e798a76@gmx.com>
 <409fb0aa-7c7f-db52-6442-d746b9944fa3@gmail.com>
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
Message-ID: <46ea54ea-3ed3-f1b7-7314-a69f4195c8f9@gmx.com>
Date:   Tue, 14 Jul 2020 18:10:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <409fb0aa-7c7f-db52-6442-d746b9944fa3@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9KYuauesFlZmh1W95cZ4f80f6XMa8xGoT"
X-Provags-ID: V03:K1:vNfaVjtafRGNuazXGBnH/oIu6fqUVv3XLaxbgu0AefPStwMyYZ+
 /6FGUz0h5rtGXNnqQ8lR/xzgyipl885Ho5GM5L0GLmGnC+hGqs0UcUu6AfjXKGVzjQEWeYV
 nIUJyDbREW3YPBL+YNB8SYOE1Z6gVYi18IIF8Zj0gtQ11nFMKeC6XasUE9fw/5DN3V+hR5t
 op550/2/MELxbZJ2bbpkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bgh+JiEb4uY=:ACNgIrGSdiM/9h0EtOVUEp
 EJ5Hj0+g/6hAddYri1wObh6bRF+aRofLuxFhoyqPMH3+zLFfIMVEmOAKeuMwhkGuHwqkagX28
 QzT4r49ArjHi7Cicb5so0h4feNgNNWY2WNLzvX8edVsydCAmjR8mrlpRytID86EYYFcD5+2ks
 FSMJrWQIijoWz+012SH04M3SzMaGe+bMZUyOwpUboLj0Typ6eI0A15Z6qQy0MKICttowkK9Ow
 Pfltk1rCBLlrjhgcJAEIFpveRxLxsQoRmouEijUQFCrMZXzOymZwoOUrgfT0BUf1YNgmY0K3r
 U/26BdWSVzP4Yt2pLmXNW5USOpNrIUhlA6gD4OMJ6HhueAOBqjd2KFpmOn0izevdgy0Pzj2G/
 lJWV3yUj7T3Q7I0A8PEzERe2rl8mfgvXNU9ui+7vY7LCML9l/k7L9cviJK8Hjsv8SoqkqkbqL
 aERo/2Ic9BiwdGmO2VENfQOifGqqe3UJC0B5ABg7OdO6o4cfOwBgXGjq494GUnGuVSPTsW0fd
 dLjduso5Gj1M8Q6Nf7qd/WhJ0hXB0is1p0V3RvMrDkusioAWwTphXMHQ3th9TfTdrrfQMAqWz
 QJVeQu7otENoyX+POE/wPUDz/xpgwdUn3b5BsVzTZiaxMYdLMWiPLGhh6fXaYr4rjr5kshDBT
 +PiiDxnv+AWNKrnxMHyQktLTs+meNDFQMyyBCTxJF6LsV8qMW2i5ESFzYs2OQ8uVhdsgPb8Jp
 OJBhkRW7xTYY11bo306Mj4KmdjfNNRX6e1gIni35dlUAmGhCFTKUBKFYjw4J43V8fhdYob0zt
 nG5Y6ZziJd5X2Gzld1492J36BfDI7fX8q8+RPW/c1t2+IamGPJglCH8cr9gOsVJ9DANwVPxSH
 vaPf2mUcYYm810WfCIgtVNYfvqoON7tvm/oTG28KTXpLYcVJphw9wKdzkXRRAxVngbBcWXqMM
 AVcNJmEtV3WYMc45BEveaFsOqyTPT4Wf+QIP123cLu0gWZyIpUR9Ajh4bSFlIvnh9z0JHCgIR
 KmQ3c1J2MBFHgQBxkGCYz8H0LLrjJarKsOCOpq8KweqKMuY74h7eQKoMPiE6MqzdO8KcO8VmW
 uxqBpAs7kEP4b/2j6akU3T4RR6px9RloKhs4Ai5dSJqpElWOvGbvPNUlp4hWTEEyI9fOw0rLJ
 yMW+1H5sq6qtgpK8zP0yKhtWUNTNMldaKB1XawizPNqmNpv6deEReqBnxfdBT69/U9cORjr6J
 pHlTeabuR5iiJbVjmYXjDMhjvqxcx47X+KaIdjA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9KYuauesFlZmh1W95cZ4f80f6XMa8xGoT
Content-Type: multipart/mixed; boundary="fdbjdWV86WfkjE3hszfVud01g1pEniJ5G"

--fdbjdWV86WfkjE3hszfVud01g1pEniJ5G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/14 =E4=B8=8B=E5=8D=885:33, Christian Zangl wrote:
> On 2020-07-14 10:09, Qu Wenruo wrote:
>>
>>
>> On 2020/7/14 =E4=B8=8B=E5=8D=883:58, Christian Zangl wrote:
>>> On 2020-07-14 08:10, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/7/14 =E4=B8=8A=E5=8D=883:46, Christian Zangl wrote:
>>>>> I am on a test VM where I am trying to convert a second disk to btr=
fs.
>>>>>
>>>>> The conversion fails with the error missing data block for bytenr
>>>>> 1048576 (see below).
>>>>>
>>>>> I couldn't find any information about the error. What can I do to f=
ix
>>>>> this?
>>>>>
>>>>> $ fsck -f /dev/sdb1
>>>>> fsck from util-linux 2.35.2
>>>>> e2fsck 1.45.6 (20-Mar-2020)
>>>>> Pass 1: Checking inodes, blocks, and sizes
>>>>> Pass 2: Checking directory structure
>>>>> Pass 3: Checking directory connectivity
>>>>> Pass 4: Checking reference counts
>>>>> Pass 5: Checking group summary information
>>>>> /dev/sdb1: 150510/4194304 files (0.5% non-contiguous),
>>>>> 2726652/16777216
>>>>> blocks
>>>>>
>>>>> $ btrfs-convert /dev/sdb1
>>>>> create btrfs filesystem:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocksize: 4=
096
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodesize:=C2=
=A0 16384
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 features:=C2=
=A0 extref, skinny-metadata (default)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum:=C2=
=A0 crc32c
>>>>> creating ext2 image file
>>>>> ERROR: missing data block for bytenr 1048576
>>>>> ERROR: failed to create ext2_saved/image: -2
>>>>> WARNING: an error occurred during conversion, filesystem is partial=
ly
>>>>> created but not finalized and not mountable
>>>>
>>>> Can btrfs-convert -r rollback the fs?
>>>
>>> No:
>>>
>>> $ sudo btrfs-convert -r /dev/sdb1
>>> No valid Btrfs found on /dev/sdb1
>>> ERROR: unable to open ctree
>>> ERROR: rollback failed
>>>
>>> If I do `fsck -f /dev/sdb1` I get lots of errors:
>>>
>>> t-arch:~$ sudo fsck -f /dev/sdb1
>>> fsck from util-linux 2.35.2
>>> e2fsck 1.45.6 (20-Mar-2020)
>>> Resize inode not valid.=C2=A0 Recreate<y>? yes
>>> Pass 1: Checking inodes, blocks, and sizes
>>> Deleted inode 3681 has zero dtime.=C2=A0 Fix<y>? yes
>>> Inodes that were part of a corrupted orphan linked list found.=C2=A0
>>> Fix<y>? yes
>>> Inode 3744 was part of the orphaned inode list.=C2=A0 FIXED.
>>> Deleted inode 3745 has zero dtime.=C2=A0 Fix<y>? yes
>>> Inode 3747 has INLINE_DATA_FL flag on filesystem without inline data
>>> support.
>>> Clear<y>? yes
>>> Inode 3748 was part of the orphaned inode list.=C2=A0 FIXED.
>>> Inode 3748 has a extra size (6144) which is invalid
>>> Fix<y>? yes
>>> Inode 3751 is in use, but has dtime set.=C2=A0 Fix<y>? yes
>>> Inode 3751 has imagic flag set.=C2=A0 Clear<y>? yes
>>> Inode 3752 was part of the orphaned inode list.=C2=A0 FIXED.
>>> Inode 3753 was part of the orphaned inode list.=C2=A0 FIXED.
>>> Inode 3754 is in use, but has dtime set.=C2=A0 Fix<y>? yes
>>> Inode 3755 was part of the orphaned inode list.=C2=A0 FIXED.
>>> Inode 3755 has imagic flag set.=C2=A0 Clear ('a' enables 'yes' to all=
)
>>> <y>? yes
>>> Deleted inode 3801 has zero dtime.=C2=A0 Fix ('a' enables 'yes' to al=
l) <y>?
>>> ...
>>
>> This sounds like the cause.
>>
>> As btrfs completely rely on the used space reported from ext*, and if
>> the fs is corrupted, then a lot of things can go wrong.
>=20
> No, maybe you missed it but I did a fsck before the convert (see above)=
=2E
> It reported no errors.
>=20
> Only after the failed btrfs-convert I get the errors.
>=20
>=20
>>>
>>>> If you can rollback, would you provide the ext4 fs image?
>>>
>>> You mean the vmdk from VMware? I do have a backup.
>>
>> Would you mind to run e2fsck on the backup first to see if that's the
>> problem?
>=20
> The backup has no fsck issues.
>=20
>> If the fixed fs can not pass btrfs-convert still, would you mind to se=
nd
>> the fs image?
>=20
> How/where would you like me to send it?

Does Google driver work for you?

Thanks,
Qu
>=20
> Thanks, Christian
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks!
>>>
>>> Christian
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> $ uname -a
>>>>> Linux t-arch 5.7.7-arch1-1 #1 SMP PREEMPT Wed, 01 Jul 2020 14:53:16=

>>>>> +0000 x86_64 GNU/Linux
>>>>>
>>>>> $ btrfs --version
>>>>> btrfs-progs v5.7
>>>>
>>>
>>
>=20


--fdbjdWV86WfkjE3hszfVud01g1pEniJ5G--

--9KYuauesFlZmh1W95cZ4f80f6XMa8xGoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8NhIsACgkQwj2R86El
/qgjugf/fJv0ajySH0mG4AWZ8n9B89ZC/IsBFJegccniyGHZuX4QU6yaGz+Bjfta
LicAF55o2RBQEi/E1r7s844eimkoantZ1Lz+0lsGR1xkmODh5TiN31UJQvh31YzR
NC/b91FQOsTDqutzNn96dvZVYYtDnulX3PDTrAd0FaGzGTBAdo6wQNOrLOBQhF8c
nx2YtNfepwvWhoIColtqPEJ2d1+dXxpl4JNghHvnlLawZGqk2Ky9d0JHsbiSqk8O
33KkolXQ9sfKMcwSUrcqf45cejRxK9hhzDNAzWc0TB5Lo6PfJuMDodXqekQzs+IU
XpgdbSRzqi8vNm3dpzrGrco4PtbU7w==
=NE45
-----END PGP SIGNATURE-----

--9KYuauesFlZmh1W95cZ4f80f6XMa8xGoT--
