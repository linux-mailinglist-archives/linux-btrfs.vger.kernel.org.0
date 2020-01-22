Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5C144BFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 07:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAVGwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 01:52:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:37797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgAVGwE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 01:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579675920;
        bh=VK+l2SqV3RomAf/JuTF7nbuBjCSD27Y+3g/FJooW9UQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TW/Imk+VgmcBvHO9l1veCK/6yEzxh/qrgjg4gpNISm9Ap4iP8Tc8jdT1WUcnjRcqk
         cv5ofISy9rGppYkjSOKiAtF1VHEcNW4aFeV44iozKOE3OeIRQiKr+DQ9OXYxI0V9//
         EHL3KMwXpapb34zYIQXllWWXNqSkLx/C0zGS2irQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ma24s-1j68r519Hw-00Vzs5; Wed, 22
 Jan 2020 07:51:59 +0100
Subject: Re: BTRFS critical / corrupt leaf
To:     =?UTF-8?B?T25kxZllaiBWw6HFiGE=?= <vana.ondrej@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAP9tsLnvnoapn_uT0Bi6_XBAAAyEyL0AirnGVxZ3AB74AQuc+w@mail.gmail.com>
 <75c522e9-88ff-0b9d-1ede-b524388d42d1@gmx.com>
 <CAP9tsLkZKOG_+NKvMHXmeQg721ydKLwvMJ2kBgEaWhG5nNfKMw@mail.gmail.com>
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
Message-ID: <b2571c66-ef99-dfa3-be5d-1d1df8e60136@gmx.com>
Date:   Wed, 22 Jan 2020 14:51:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP9tsLkZKOG_+NKvMHXmeQg721ydKLwvMJ2kBgEaWhG5nNfKMw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U76uh4mXLFOZVCzGjVtbAn6VAilh2Paz7"
X-Provags-ID: V03:K1:yclf/ltMMBQPHpDAVoA9/LpoYXWD0R9Z4cLMojOGruDNpzxKXDo
 5H+FD/g29uPBILflcC9GT32y6ARBUMLBJEnZq8m6Ft7XoVfWTdBYSZnYZglDFlXqt+1OGsB
 JreqVKi18zUTOIFIAF7iLtxwCvachl7oniU4F7EdrxKqmabKbtyoWdFiOup5jCcdIMYA+2s
 SWHOe5W+hWGz5/uLwIz6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xSuzEQa6W78=:ISHZzEXgmzsTuzvbyYWvmg
 FgpVN6ywqLnJrqpNfmuZbFd1rYo+JGuqr06tzOK0729n+zd/h+p7mlBsHGKgN9Wq85LNwNzpl
 VRNZa0MGgbkYMW2yDcN5mwQoUV99RxOcmqK070s0ser+gqm8POOb31XpX3OyWVR8llhsELmAW
 QAFe42Xjl1r/fHanw+TPYa8A7LTvIz4JWVUut1L09TW9OYAxW7DNZQZfDIWzWzkTDsxIiD8A0
 mK91LVPRdUZ2YK/Fe3S0mGMPYt5rbLKLMTSNI8H/9U33edkCoPjJL9g7QLBKUyyXXrpVNZLKY
 +I11ai3tbOGJVPpbaJYcGIZpNIHw1peiGcBnwBGOzubRf5rhV3SmUX8uEsr2JqwMjfUjZiWvN
 Jvg6gLY8l0qfE1NxoONkmQjcZzw06T8tWsINgVLPBGK46cwVEIEnwKcDUYrZP7kuOnIYKL6fH
 yHK+P3QgDh+2p9wdnq6iSa0BS5z6hRe4/TiK9UcoSYGi3JYa8u+u53bOM6F+3zUJ/kUIckr16
 9o6nAoRhh8MkG33AES+rg2UzJftKl2dfQNlfaIy3nM6+m1P6QPVuqOlPcrrEol8WsNnzvxfUf
 tCAPMZaxk1cBTV3T4T3fKrrlX0Ew8PDD6dqcSUz9nqmS8ibeWMIXAAF1+nG4+mBPLzCG+ii5w
 qb8kEZnkzGEs7IQG2aueISxumbvY8mXFrT8uqIDiL7XUfD2UV/XMd2SjAfD0APWsdjkZqvoTp
 k7E+5zouU5poJ0ZNqkcc2WF11rve2wZPYK1ybztYVT/6LTTepSvmenVJmbSexpTxiqfO/+WGI
 HhXTkBSKmvs16nDL0C3EyZsqMVHA8OA7D6GMN9KK12xaKojFBAMlTDzrWxXJe/soDm8Xe68dV
 hrr/+4qbEBBDVIeXPcdnCzPgawi/+yU0DqgosPuKwMO57DhPkBDBp6e30uvA7XLixpOo380Li
 lta3wWLvy2q9/M4Gk2MLLh8+eigg0JXlltgCfw95PmIOD2MTfAQnEroLsxNrUwipTr0CFFHuE
 +v9YCChWGHbkcMXZe9BA8RuNfF/j4HEEvhVm4APHtAMeqJHv10Gn6nnpbWeTOzns1Kc3wIP+I
 4lSTxVNpd1bKRmdik1hkWXBSciFistnPB9jYBfsDBXdmdo2Q4VMwMHc6F31WBCTuP4HCij3l7
 mbdz7S1RJJRIFpOcE+eBErk9ROlO8mCEU5KDpRwkYraMt6ASYYOM/oohdXd9IHZSCFQaartqS
 /idAf4XqNKXEPKsEbZ5PNYpk25DejeBDaluXdaPToAItfMlzYBKcyS+CCEvM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U76uh4mXLFOZVCzGjVtbAn6VAilh2Paz7
Content-Type: multipart/mixed; boundary="ZPC44Qne0wS5NIYiEVA3aF9eyp6L4DyPS"

--ZPC44Qne0wS5NIYiEVA3aF9eyp6L4DyPS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/22 =E4=B8=8B=E5=8D=881:13, Ond=C5=99ej V=C3=A1=C5=88a wrote:
> Thank you for the quick response, it has been created a few years ago
> indeed, I booted up an older installation I had around and could find a=

> single file using the 'btrfs ins logical-resolve 101613793280 </mnt>',
> removed it and all is in a good shape now.=C2=A0
> Is there something I should do to prevent this=C2=A0from happening agai=
n?
> Such as recreating the filesystem or should it be somehow "updated"?

It looks like a bug in much older kernel, so as long as that bug is
fixed, you don't need to bother any more.

Just to be extra safe, run btrfs check on the fs with v5.4.1 to ensure
there is no other similar problems, then you can call it a day.

Thanks,
Qu

>=20
> Thanks again!=C2=A0
>=20
> On Tue., Jan. 21, 2020, 19:39 Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>=20
>=20
>=20
>     On 2020/1/22 =E4=B8=8A=E5=8D=8811:29, Ond=C5=99ej V=C3=A1=C5=88a wr=
ote:
>     > Hello!
>     > I've ran into an issue mounting my /home due to this error:
>     > `[ 1567.750050] BTRFS critical (device sdb5): corrupt leaf:
>     > block=3D135314751488 slot=3D67 extent bytenr=3D101613793280 len=3D=
134217728
>     > invalid generation, have 500462508591547182 expect (0, 222245]`
>=20
>     This looks like an error caused by older kernel.
>=20
>     So I guess your fs is created some time ago right?
>=20
>     >
>     > Now before seeing the note about contacting the mailing list, I d=
id
>     > run `btrfs check --repair /dev/sdb5`, though it did not find or
>     > correct any errors.
>=20
>     You need btrfs-progs v5.4.1 to "detect" the problem.
>     But repair needs to be done using this branch:
>     https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>=20
>     >
>     > Tried booting older kernels from snapshots and the issue persists=
=2E
>     >
>     > Now some time between my restarts, the error trying to mount stop=
ped
>     > displaying the corrupt leaf error and now says there's an unclean=

>     > windows filesystem or just 'mount: /home: wrong fs type, bad opti=
on,
>     > bad superblock on /dev/sdb5, missing codepage or helper program, =
or
>     > other error.', but the partition is certainly btrfs.
>     >
>     > Here's the required output:
>     > ```
>     > kachna:/oops # uname -a
>     > Linux kachna.kachna 5.4.10-1-default #1 SMP Thu Jan 9 15:45:45 UT=
C
>     > 2020 (556a6fe) x86_64 x86_64 x86_64 GNU/Linux
>     > kachna:/oops #=C2=A0 =C2=A0btrfs --version
>     > btrfs-progs v5.4
>     > kachna:/oops #=C2=A0 =C2=A0btrfs fi show
>     > Label: none=C2=A0 uuid: 7dc4b27d-8946-418f-a790-a3eeeac213ba
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 23.54GiB=

>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 1 size 30.00GiB use=
d 27.55GiB path /dev/sdb3
>     >
>     > Label: 'Home'=C2=A0 uuid: 1c0257d6-77ea-4d0c-ad16-2b99114f4e5e
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 128.05Gi=
B
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 1 size 163.47GiB us=
ed 140.02GiB path /dev/sdb5
>     >
>     > kachna:/oops #=C2=A0 =C2=A0btrfs fi df /home
>     > ERROR: not a btrfs filesystem: /home
>     > ```
>     >
>     > I did read through some seemingly related mailing list threads, t=
ried
>     > running on individual RAM modules to see if one of them could be
>     > faulty but nothing seems to make a difference.
>     >
>     > Is there any way to recover the partition?
>=20
>     You can just mount use v5.3 kernel without problem.
>=20
>     Then locate the file owning that extent by:
>     # btrfs ins logical-resolve 101613793280 </mnt>
>=20
>     Then remove all involved files if they are not important.
>     Or just rewrite them with the same content.
>=20
>     Then the fs should be gone.
>=20
>     Alternatively, you can try that mentioned branch to repair it, but =
the
>     above logical-resolve and delete method should be safer than that
>     experimental branch.
>=20
>     Thanks,
>     Qu
>=20
>     >
>     > Cheers!
>     >
>=20


--ZPC44Qne0wS5NIYiEVA3aF9eyp6L4DyPS--

--U76uh4mXLFOZVCzGjVtbAn6VAilh2Paz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4n8QsACgkQwj2R86El
/qjv6Af/S0WiKWokpvy5sXLj1qObF4PWe81371h6XaIaVgPIrFQi9tlUlD6rH4oT
KDWbxhtsdIDBtWtlym+fZWcqwAvuSQgU+NKguVGqWWIwEAhvmXcKFH3v4fGdkcXr
S/kkJq4nKy6XG2IOypa1rlM2bOKGJ8zYRcd/dzIK1inQVgn6u8SeH/m6BlDzGYnS
dMYJR0UMSrXPjRXbU3TX/MoZgBI/UJmQWojzZbGSfdQGrPGTVVJg756gfdpMCfIh
HOYaDnlQq3dtMMXrbjPVUuPGTwp+o6BiHVlHI6d9RtHjT59OoFpvhM+9b3lLBnX5
4e3Xsmbih6d47/EZP2BaKBVsEV0Giw==
=+XrF
-----END PGP SIGNATURE-----

--U76uh4mXLFOZVCzGjVtbAn6VAilh2Paz7--
