Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E915144A80
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 04:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAVDjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 22:39:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:52623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgAVDjY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 22:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579664362;
        bh=NJxA2uB7zfMt8p34plD9Z4zTORhqVSReQ/VllQNQPY8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JRHZ1bJ3RduuVb9I3yVBCgj+wYSLdUejRSU5kT9gg7qPgtgg+dfZ/yQGB98wH1dYe
         MnrU9lk1GvhBzrQqCQMVWtACEhhmO4JfxagXyNiz964OkdcPD7ageTg+5g1cBMkaLs
         s/vzENX8ys7BLH6tjuIDKPWTIY8SKxZSabYHnTk4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKYx-1jBvMM2M4F-00LkUz; Wed, 22
 Jan 2020 04:39:22 +0100
Subject: Re: BTRFS critical / corrupt leaf
To:     =?UTF-8?B?T25kxZllaiBWw6HFiGE=?= <vana.ondrej@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAP9tsLnvnoapn_uT0Bi6_XBAAAyEyL0AirnGVxZ3AB74AQuc+w@mail.gmail.com>
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
Message-ID: <75c522e9-88ff-0b9d-1ede-b524388d42d1@gmx.com>
Date:   Wed, 22 Jan 2020 11:39:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP9tsLnvnoapn_uT0Bi6_XBAAAyEyL0AirnGVxZ3AB74AQuc+w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qJmpVbeXtI3bFpaCmVCALFKFB4IQkM1JC"
X-Provags-ID: V03:K1:xgZuPt9aUre+06CYtTk6E/7239j4gFqFbASsWa6HLHUcw+AUatk
 QvBVb+l4Pa3sB+LZX4i3oeM4FBIwflB513UIB+eOPfV4A1MM6VhVhMHtfeEpYq3vJ9m6Ql7
 kC+os5oSFGq0wtkEJrYG7zu0txV8S6hkbFwbRgNiY+gG/T4qkogWzgJ4ah+GG6Qrmr7ysk0
 zrNVqRKkMMcc7ihriSl/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yqZQB4HiYe4=:AiDWnhCTHvAhuCvfh3EmTs
 CkLQfzZk/bDCf+SQc0gpGNV008vxxjvnTwvhgG5Ogrqp1e7BWC0UoKmo5UtOb7AOo0cjAvUXR
 DinXi5E9EKCNOlg4EzXesGoIBUsyZgi0JKASZwdff9326ZYGE5dxT+xR4sX3Ru5P+wlo6opE6
 zxKh2XuROvPrCVMamGjm0ZXtRWDAW1cMX1jkSosn/AHlzw6AzDp0C90u+kNQGxtBIVnkaJuUG
 rNXsXiODuDYNOLe55ATyTeV9s0w3eN16IISFJsT3Rzu14WWk/bEFdSPG4CRgmMsLEfuz5IpPU
 senfQ4nR6D1/dK9fYbN5G1S0A0/pwk59FbsylJ4bTJXKhC3XnR0/hZTsLVdbZGSrm/xdbqu8X
 7sdfRX2w/4f4Q0y3fvtJ2MuKr4FlAX4ihS7s/wXs4ByEg8I68ygZC/DkmJR/T2LuIqu6ILgdq
 P8btt3us2ZXiOdCUVEXbrj1TIrpxWDil8350RgMq0YWVQYPl97BkW8zMsvbShc+8SXlJ4K02I
 scYLVhSRQLOlUwq3dhjkox5oTZDHT5l/gn+KGmEixn3SyjiDybYM+ChCFtkhyNQsmPKztvcJw
 pM6xFJdJ0NDu7Z/zNDGk0PNCepN7Fo+lRKGQ/DvuG9w6ljm86o8ZvdtlrKR+GQPQu6sOrEnaI
 hkZVwaFAUQU0zP+rZrzP8pjUgm8mabEQgaGwTseeFnp6UT6TXLm97D6PqVQ9oA9zSpYyFzfjV
 SZXemTBMY4iR/OHja/DyT2j7HcNxfvZvEftp4CM1OsYWmZGk9V2QS3vvAU+AkYYvlY5VB6+dZ
 rAqJG2nQsc7PSZhah5tMBs9jgOUoA4D6hqiRxxcltuZCDs4be9VCFYfPj6JaSGTAqLiMgHIQ3
 d561Q9dNF1psul0FzjYO9onfbX9/zkqsfNh/+/FjPsMWMMQufsaXqq+rmm/sJX5IF6BZgBla9
 iQAfAZGRwR7e/xynbJSskma8BQzYIYxVcY9t9ZQ+W4M4P9HP+2/ZaogcMzq9uTbZKzlQXCltt
 cGolFNPiZV8F130zmrQ5PYm5j3j1DJvIeFDdKMibvtNgtVz3ztK+LdyP5QhwBGsdXiwvwGTLQ
 yYVmGRgVKyKNnnyXvEGKR5w4gRu1gJvhVxBd++3SNHE1Arl3EeZg/RcLceKmCaqW7pKIcz9bS
 inGRdUv7XXidOxqotQcI+N2kPtmdDQtjSaeha+TxVDs1q1dSe65jooW0ywHaCGXD5mLG3Bmay
 m+GdEiZQHLGa0garXQkHu2eCHV6lots2ts9cDADOC5JKRL6R6XD75m+ja5ME=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qJmpVbeXtI3bFpaCmVCALFKFB4IQkM1JC
Content-Type: multipart/mixed; boundary="IaBTooikCBsTvL4TBNvkNdAJJTeoDxTlB"

--IaBTooikCBsTvL4TBNvkNdAJJTeoDxTlB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/22 =E4=B8=8A=E5=8D=8811:29, Ond=C5=99ej V=C3=A1=C5=88a wrote:
> Hello!
> I've ran into an issue mounting my /home due to this error:
> `[ 1567.750050] BTRFS critical (device sdb5): corrupt leaf:
> block=3D135314751488 slot=3D67 extent bytenr=3D101613793280 len=3D13421=
7728
> invalid generation, have 500462508591547182 expect (0, 222245]`

This looks like an error caused by older kernel.

So I guess your fs is created some time ago right?

>=20
> Now before seeing the note about contacting the mailing list, I did
> run `btrfs check --repair /dev/sdb5`, though it did not find or
> correct any errors.

You need btrfs-progs v5.4.1 to "detect" the problem.
But repair needs to be done using this branch:
https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair

>=20
> Tried booting older kernels from snapshots and the issue persists.
>=20
> Now some time between my restarts, the error trying to mount stopped
> displaying the corrupt leaf error and now says there's an unclean
> windows filesystem or just 'mount: /home: wrong fs type, bad option,
> bad superblock on /dev/sdb5, missing codepage or helper program, or
> other error.', but the partition is certainly btrfs.
>=20
> Here's the required output:
> ```
> kachna:/oops # uname -a
> Linux kachna.kachna 5.4.10-1-default #1 SMP Thu Jan 9 15:45:45 UTC
> 2020 (556a6fe) x86_64 x86_64 x86_64 GNU/Linux
> kachna:/oops #   btrfs --version
> btrfs-progs v5.4
> kachna:/oops #   btrfs fi show
> Label: none  uuid: 7dc4b27d-8946-418f-a790-a3eeeac213ba
>        Total devices 1 FS bytes used 23.54GiB
>        devid    1 size 30.00GiB used 27.55GiB path /dev/sdb3
>=20
> Label: 'Home'  uuid: 1c0257d6-77ea-4d0c-ad16-2b99114f4e5e
>        Total devices 1 FS bytes used 128.05GiB
>        devid    1 size 163.47GiB used 140.02GiB path /dev/sdb5
>=20
> kachna:/oops #   btrfs fi df /home
> ERROR: not a btrfs filesystem: /home
> ```
>=20
> I did read through some seemingly related mailing list threads, tried
> running on individual RAM modules to see if one of them could be
> faulty but nothing seems to make a difference.
>=20
> Is there any way to recover the partition?

You can just mount use v5.3 kernel without problem.

Then locate the file owning that extent by:
# btrfs ins logical-resolve 101613793280 </mnt>

Then remove all involved files if they are not important.
Or just rewrite them with the same content.

Then the fs should be gone.

Alternatively, you can try that mentioned branch to repair it, but the
above logical-resolve and delete method should be safer than that
experimental branch.

Thanks,
Qu

>=20
> Cheers!
>=20


--IaBTooikCBsTvL4TBNvkNdAJJTeoDxTlB--

--qJmpVbeXtI3bFpaCmVCALFKFB4IQkM1JC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4nw+YACgkQwj2R86El
/qgrCQgAqpeMrOMah6D9JTkjNhBsVZYL9sv/xWRs3nkNS+diWGqwkXVKf/jMFDG9
MRqcDkA8p/ydSKdbharYoYEx5+rOXzmcmegHfeqet6TKT8RRf2X4fMHeu4xZf2l4
KhFwolB8BLKVfySFrbkIDBeBXs/dX1XRhi0SqqOQpG0DEimA0xYJ5G6uON5sFR1+
gp3HzhKTbYs9ehyN8F6MdSZegISEacIViaL3ldC5ZXhWZG0MPv+v/qhCfO8cF/Kp
nhZnwMq1RgM7ck8bcso7qAiMHPm9zGkYMEfm9kVtJcp/1jZ/h72Pml0esBiWZZeo
S5dh6vMkfm85JFVticmt/ryzFOASjg==
=47bf
-----END PGP SIGNATURE-----

--qJmpVbeXtI3bFpaCmVCALFKFB4IQkM1JC--
