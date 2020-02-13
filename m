Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E768415BFEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 15:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgBMOBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 09:01:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:37895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgBMOBb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 09:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581602482;
        bh=uoBkfmD6LxZRjFhLfqogUVCLvgUFxDyd/fzXrp4bqns=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=Q9Qf9EQdLJCq4r7Is87C7lcSL/vhr8jMKdWe1bjPSa9y9sTn4s4juRHCVfr0+51yb
         Elry9Oefal9efyJIH99PH64lfIG91YUoDdHQAqA84Mo+HokHZf1kVymUaGqmz+DWd/
         r7CgVeoTM/Ytgpx75+xr9ZIqzlq2V/DtsDtnt6Mg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeMj-1iy43u26Ud-00VgLL; Thu, 13
 Feb 2020 15:01:22 +0100
Subject: Re: read time tree block corruption detected
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Samir Benmendil <me@rmz.io>, linux-btrfs@vger.kernel.org
References: <20200212215822.bcditmpiwuun6nxt@hactar>
 <94cb47d7-625c-ab36-0087-504fd6efd7ef@gmx.com>
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
Message-ID: <da987d5b-630f-bf41-8c5c-bb222d09e5a4@gmx.com>
Date:   Thu, 13 Feb 2020 22:01:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <94cb47d7-625c-ab36-0087-504fd6efd7ef@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4ExBr4VyfUm6q0BfAL9c7UAnJW7pE9wXq"
X-Provags-ID: V03:K1:erizKUiYeanBOlQlnGcz1m0VJOkiTri8ID0iticFHYtRpJ9pxqU
 mMaJTK3D73LFkXx91SasYKkEN9vQQq9qTN/5jrZ1iHTeCMscoPHY83Xk5SMDIbJrrRv4uKJ
 LO1rsjUvINCZwG0K0qCT8T9H8aYJaaKdSWph8S9oe0FoD2VUQuSyXy5of3s15QU6QBeMqNe
 QqlgI9j5lZXt6+vjU+yEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5faRvd8eKVw=:sTYmTojo4w+WRaVo4QHd3Q
 XAibqzaBCRSfXPs2ZmWRVoUVjqAmdUBjLJnqi8wryAW/WMm/r24YqLdibEewUUld3oYl+wC+c
 +d5MzCogb+o2DJ76V8zHw0miokQlgvp+TcpnddJ0r10ZuX6D18WQ8cqHyKXRmR8S4xSxr1OBH
 voq3w08oTDFtWdE+mooYm3cqCwMoqrzE+2TG8a+FhWQebo3R10dxGTtFIWwaqPSsEB5nsYu+W
 xBMrUCZ+NVxd+xC1AmGZ+3bDjHYGo/GYl7X1kyy0LTkoW2duXT40pHir+ck4gXwlueiH/DwhN
 4U+OTJbUD/4meRvBGzf17v3kLQEwRJhzkVINZLcIMm44iDIc3qYdFh1045qdwPT2OPJIn+e/l
 zI0KJGnsYzURwrO2e2trXF58xNarvWn4G3XSV9FXefXti952/YRY2y4dWkP6V0vOnTFI1oVQE
 FjUvQ0NtePot1QxRmhw1joQEgJPyBAxBe0bDgTFvKii31+u1t/8XHR2DWTmoC3chWQHzSZNAq
 EDrlNUKzvlBeNNwL7DBpgqopiWEg2ej1Ttu9O7AHsFGTxAw5Lt37DHSYdNMo50rrZGERXO3OP
 3W6PJemtSLVistPH9E9eBwwlW8DlRyfzX0isqErpBE1fcF2Dz0bNb/m46CuNBLSpIQs8trsqC
 DZizgEjaISAs2A4qQFJyBaCW0tURBzSpGKWx0FPKOipqRJ4kxiHwajcEM6WGQQ1ntJ5czvhY2
 WuSo5DYC3OR1qmRL39KUIbhecJ4sztymUZ1gBt+VkFmf0bcMsLa2vkieqlZtUpA7eB4QrXLEa
 bAkQyITLB2ss9a7d8DOfk+BxoxCC4IbH9NvIaqRfTbBfLWnn3i0wGzCcY0hsZC5g8ChQsRK70
 ijQgTQjSp1oawwRaN0j0tyXaPy7FAsRDKo1Qn6FcAZDaeIxBtP0NU/kW6KpHoTYH4c9MFOYxP
 fMMLsQpeC6E+YYHYWCNCqyAjqcVSA9sh6m8r6FK3enDzywUhROKL/Kl7TiYmYM9pSQ0ppdISB
 +KtKfJizAFaja8B8rJhA9D4+BnUlhjL9Chew6hgwAwdSLzVqOmcXsHVMtr6gLE/Hp8M6qbxvd
 9qoRFHnXuSrM5FZDVqkZlUUDKC02fxkSnAKUKM32ldjMDojcEVmiA6cVAGS/9WSc0Up8cvKlc
 PpffVzCuyiQxXPNNGPf+BIoJStIj9RMw0qAxao0jO6oQ8S4pqTQaWTdrACvHS6AOE6XtaiYi3
 cxDu/4H/vmVzxuWfk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4ExBr4VyfUm6q0BfAL9c7UAnJW7pE9wXq
Content-Type: multipart/mixed; boundary="Faz2I20iB5naBfZ3GgecSkUbJaTGfogJb"

--Faz2I20iB5naBfZ3GgecSkUbJaTGfogJb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/13 =E4=B8=8A=E5=8D=888:26, Qu Wenruo wrote:
>=20
>=20
> On 2020/2/13 =E4=B8=8A=E5=8D=885:58, Samir Benmendil wrote:
>> Hello,
>>
>> I've been getting the following "BTRFS errors" for a while now, the wi=
ki
>> [0] advises to report such occurrences to this list.
>=20
> Please provide the following dump:
>=20
> # btrfs ins dump-tree -b 194756837376 /dev/sda2
> # btrfs ins dump-tree -b 194347958272 /dev/sda2
>=20
> Thanks,
> Qu
>>
>> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D1947568=
37376
>> slot=3D72 ino=3D1359622 file_offset=3D475136, extent end overflow, hav=
e file
>> offset 475136 extent num bytes 18446744073709486080

	item 72 key (1359622 EXTENT_DATA 475136) itemoff 11140 itemsize 53
		generation 954719 type 1 (regular)
		extent data disk byte 0 nr 0
		extent data offset 0 nr 18446744073709486080 ram 18446744073709486080
		extent compression 0 (none)

Also obvious underflow.

>> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D1943479=
58272
>> slot=3D131 ino=3D1357455 file_offset=3D1044480, extent end overflow, h=
ave file
>> offset 1044480 extent num bytes 18446744073708908544

	item 131 key (1357455 EXTENT_DATA 1044480) itemoff 6497 itemsize 53
		generation 952602 type 1 (regular)
		extent data disk byte 0 nr 0
		extent data offset 0 nr 18446744073708908544 ram 18446744073708908544
		extent compression 0 (none)

As you can see, 18446744073708908544 =3D -653072, which means it overflow=
s.

Both look like a bug in older kernels.

Since currently btrfsprogs can't detect nor fix it yet, the only way is
to delete the offending files.

You can use the inode number 1357455, and root id 466 to locate the
offending files, and delete it using older kernels.
(root id is your subvolume id, which is shown in `btrfs subv list`.
 inode number can be passed to `find` command using `-inum` option)

The btrfs-progs fix will come soon.

Thanks,
Qu

>> BTRFS error (device sda2): block=3D194347958272 read time tree block
>> corruption detected
>>
>> I can reproduce these errors consistently by running `updatedb`, I
>> suppose some tree block in one of the file it reads is corrupted.
>>
>> Thanks in advance for your help,
>> Regards,
>> Samir
>>
>> [0]
>> https://btrfs.wiki.kernel.org/index.php/Tree-checker#How_to_handle_suc=
h_error
>>
>=20


--Faz2I20iB5naBfZ3GgecSkUbJaTGfogJb--

--4ExBr4VyfUm6q0BfAL9c7UAnJW7pE9wXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5FVq4ACgkQwj2R86El
/qixPwf9GE6GYg1l8YyX7M8QLxEJhqzSwsff8rSLM+ApS6+YPvyGZExwnWubazPl
jN923uFlpH9gt6HMbVTLp8aY/i5ZUu1/l1uTYnsVwqGrxwGq/w49SKJD8cIyCcwk
TbDCvf8p8eaGossLoLcw/QcT6W6Bp+f+qFrLSYNb1mBJbP9l8jjved/VWy9GTqVo
tY9UtKe3mLbOe7EkM9IBz0wdoJr04FgQz07lzwOjQrBbzRX510hOrLKXGxgzKUMb
LPldHIFgUqCR47TdnkFS/j+mfVmivw16NooeFFl4CMsg32jTI4irqMG+f14MVbon
bl3V6d09UYnKjdllePtO/7M1QYs1Cg==
=u9JE
-----END PGP SIGNATURE-----

--4ExBr4VyfUm6q0BfAL9c7UAnJW7pE9wXq--
