Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765871E3F47
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgE0KmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:42:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:52707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgE0KmG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590576120;
        bh=l3oPI2FpBLFlz0S4jM1NfqkYgjPdrl1JWuBILDi7gl4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NlkUKuxJ1vBZjbI+auXYorwDFEik6xPdgIN3bolngqVtCyraE7hUAxFFxGHsWjlEU
         fejlHNzDzhz/PoZduyM1cyJ0e/S2/ybDP4mgR7UdVx+9fko1Su7tdk3UaMS31rpgma
         ZfZxcl++q1ZyY0+7HEw+usXND3VFL4QJP3NOb3M8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1jnrFj2JGW-00GbpZ; Wed, 27
 May 2020 12:42:00 +0200
Subject: Re: Trying to mount hangs
To:     Pierre Abbat <phma@bezitopo.org>, linux-btrfs@vger.kernel.org
References: <2549429.Qys7a5ZjRC@puma>
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
Message-ID: <ec5b61f1-a46c-393a-d152-7f9a2ca743d3@gmx.com>
Date:   Wed, 27 May 2020 18:41:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2549429.Qys7a5ZjRC@puma>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XJqLOKYez3CSU7SWoNRTh2Iljg5GTnIzK"
X-Provags-ID: V03:K1:dKe6YjG8fzZppzYcypYyR/jjmSOHA6ky4IHM5HnX5ckLOqRnEg8
 b53XZkSUFDB1wzQkpUqLSvkWyoingFUhvc4+aDxN1d+FwsdVIcyjZXAmfE69uxVqQogo1q6
 BCqnXnCdRQ17v7AVgs3bDmfQhXa12K8mMcZUJod83+YQF7E1Z9J4ycacPr5LkIJC/77TPCb
 7/2RzMKYrRqEv1CMVD5Tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9HlLWJmhp+g=:lU5ADIr3Xd5V2GHV2GrNrC
 cEsodQ4ydtvFR+cGTck+5UnvnpHJLrI7KF8/k1wckFS3AOHFyJQbY27V60cXR8cX0Q4LPDbXW
 NpktK3s8t3XcuTdjoD/qrm5zUsVfG1Pn/9xeLZZdwfUh41sJHN6NsEdf1GY4fdV3OWdPahtPf
 i99YH5sUh4a0uPSc45Iu64mkjB0Iip0a3MM8AOlu0QOZUDfbkIpSIPRV+tlY0EMlJHwnKAxev
 jKxfCtT3KcA34sRbhBz5F9N0crbDp61/o2DxhJGFharRFiF2v6CNP/SuEEHL85U/LDK0csnXy
 ZHP8bmrMdzSFaH5DFxwydo8Y3OJsH4UKyRiOhUuq/BmtVOf9eAo66PtcT8KoFEYFPovFUnHRS
 7iKGfVTDH3mzJQzk6X6Y/MiW+qAWOqRoxvaK7Ial/LcqRCeS9yIcyYfINz7y4ziG2/0eb53eo
 E/a7GPQ4tQUAx4H8AMkq/VcxdCHdz1Ifd1Rc+CWrwcFUXOy/cftiPJiIG50QD12HtyFdcMx40
 LaGUAGoReFuTPWWn6+pZbNHnjvFMWoK5ljF86cAHQJO5sVPAj7R+sQYOkkik5iFNZc6QS8iHN
 uhjErDoDYMVpqVfl37np+H4W+NPWkohtRMIL11+ioQlTZ3QjBDSj6y+4S9BAFmgrT1jUrQ7Gh
 6jQjQdS+3PiPjhqPlbBOG1p7Pb0zSVjfvzHxa0FaF6BklLi5Izz8MX5aNMJUm3z9CJBeT+vEw
 Pp9ch2ZnicGGE+hqVNXrwPRm/QBo3jp1Ss/ZXUPoLuS0KtLp8FHgSKcJHDOmxpM52GIaZL9Z/
 IEwrufqsjUa5w2Siv/rnK0NmMj4JtCmsdAziITJDXoZfwKKkVCyE5UYjZEjZ3zhsKYqZx2mTa
 5AW71WsKwRBhXUVxEv6grxHm+KDBvnkwmBhBI0LDd1gN/U3j7EspThE+PjbEzDxdgIbAuPqj7
 UXYOIH+g2+o8DCmNArCKQsU9Iy5SnlhgzfISZlDhpLKJzvD7TpbHfWyqRVAzjOk++A6ZdIjbX
 hhi2RBgEcFKx7IQdlbn0nPMbhGc+ULmj84IoxClXwqZXkNnYEdJCOKNMqm0jcw37QmA8SfANk
 phIEOKeG4llhVu6FoO27508x3N5CtKc5xznEUtYVNvY9klnGBcT5/3+Jt2nW5o2gvOg0A7SA4
 FVBUjrCByKt5ia/L5Uk8vRVJiwLSD8ge+AElwi8Hzi5Y9JgM0JziOAuXCgfNYPBEZH7+Vfn5J
 HkbBedA9S9jfNoqT9
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XJqLOKYez3CSU7SWoNRTh2Iljg5GTnIzK
Content-Type: multipart/mixed; boundary="P7veg7XjeujAK2kmRCOMx5t4svd8LBgfr"

--P7veg7XjeujAK2kmRCOMx5t4svd8LBgfr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/21 =E4=B8=8A=E5=8D=889:34, Pierre Abbat wrote:
> I am not on the list, so please copy me.

Sorry for the late reply, as it takes me extra time handling the
btrfs-image bug which delayed me quite a lot.

The good news is, the bug of dead looping is already fixed (or at least
can be rejected gracefully) in latest upstream kernel.

>=20
> What does "looping too much" mean?

This is caused by corrupted extent tree. As I mentioned, there is a bit
flip in extent tree, making reference count of one extent jumped from
0x1 to 0x200001.

And then since your fs has dirty log tree, during log replay btrfs is
trying to locate the non-existing 0x200000 extents refs, leading to the
dead loop.

>=20
> phma@puma:~$ uname -a
> Linux puma 5.3.0-7625-generic #27~1576774560~19.10~f432cd8-Ubuntu SMP T=
hu Dec=20

In v5.4, we introduced new extent item check, f82d1c7ca8ae ("btrfs:
tree-checker: Add EXTENT_ITEM and METADATA_ITEM check"), which will
rejects such obviously bad extent item, and avoid falling into the dead
loop.

So you're just one version short to avoid the bug.

Thanks,
Qu

> 19 20:35:37 UTC  x86_64 x86_64 x86_64 GNU/Linux
> phma@puma:~$ btrfs --version
> btrfs-progs v5.2.1=20
> phma@puma:~$ sudo su
> [sudo] password for phma:=20
> root@puma:/home/phma# btrfs fi show
> Label: none  uuid: 155a20c7-2264-4923-b082-288a3c146384
>         Total devices 1 FS bytes used 67.60GiB
>         devid    1 size 158.00GiB used 70.02GiB path /dev/mapper/concol=
or-
> cougar
>=20
> Label: none  uuid: 10c61748-efe7-4b9c-b1f7-041dc45d894b
>         Total devices 1 FS bytes used 53.36GiB
>         devid    1 size 127.98GiB used 56.02GiB path /dev/mapper/cougar=
-crypt
>=20
> Label: none  uuid: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
>         Total devices 1 FS bytes used 92.58GiB
>         devid    1 size 158.00GiB used 131.00GiB path /dev/mapper/puma-=
cougar
>=20
> root@puma:/home/phma# btrfs check /dev/mapper/puma-cougar=20
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/puma-cougar
> UUID: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
> [1/7] checking root items
> [2/7] checking extents
> incorrect local backref count on 4186230784 root 257 owner 99013 offset=
=20
> 5033684992 found 1 wanted 2097153 back 0x5589817e5ef0
> backpointer mismatch on [4186230784 188416]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 257 inode 30648207 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648208 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648209 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648210 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648211 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648212 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648213 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648214 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648215 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648216 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648217 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648218 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648219 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648220 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> ERROR: errors found in fs roots
> found 99403300864 bytes used, error(s) found
> total csum bytes: 96230456
> total tree bytes: 737820672
> total fs tree bytes: 534069248
> total extent tree bytes: 75481088
> btree space waste bytes: 129276390
> file data blocks allocated: 10627425239040
>  referenced 68243042304
>=20
> Pierre
>=20


--P7veg7XjeujAK2kmRCOMx5t4svd8LBgfr--

--XJqLOKYez3CSU7SWoNRTh2Iljg5GTnIzK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7OQ/QACgkQwj2R86El
/qi3YAf7BVPyu//7p5f+VtXdOy/OZhETEyeT9ynjb2vAtE4QOAT6qRnEBUxQHaeG
48r3eNQNSqfRoNd9FOgNbdNL3wzRGzsacmrK9lGN3e16YUluwTtEh/28SG7tnWpC
rMl/x2jw6i6NtStt5HkuQ7wsJOo2TkAB0ES9ua+sPBMxUOHXau2yvSgB1pf44cdJ
H9WA3OsqrCf/5wRg8WvSHaMRDY9EI2iYKkk5QobZxVuJsHB1aAVmceQcFsjZlYFP
aaJIBqordwx7QXfXeoYnPVH3EZtsAH5dMQmbR8bOasPjYjZm19+YlE/QVkz6OwiL
9sZgJPu0VN3BuGlq0wJJHf7tBB1gQQ==
=f2oW
-----END PGP SIGNATURE-----

--XJqLOKYez3CSU7SWoNRTh2Iljg5GTnIzK--
