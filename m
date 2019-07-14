Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA43967F09
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 14:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfGNMvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 08:51:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:33553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbfGNMvQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563108669;
        bh=Cu3252cDdxfhdCPo6xecAyiEPgRLm6vh4xr0FBdWQgo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jC9eRp63S4uu4v5oZIWa02loREZl7agKL3ppsBDUY6xijhUWu3ik1zT6LZ+LZT65N
         pg/boK63a2eR+17hNd8HnXb3pYxZ0IBto47YYjFGIWAZl3pZUedWuOlecrw01JpNQS
         ydz/5jHdFLSphXOMpAGvtv/KSKf9+bI1zLA8ndUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wlv-1iSLW12ooL-012HXy; Sun, 14
 Jul 2019 14:51:09 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Alexander Wetzel <alexander.wetzel@web.de>,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
 <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
 <e2776741-3554-e9a6-440a-4bfe8a839cbb@web.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <2b2b8201-7d15-e3e9-bb4e-83709449483a@gmx.com>
Date:   Sun, 14 Jul 2019 20:51:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e2776741-3554-e9a6-440a-4bfe8a839cbb@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ueEm1UpsmCVUUWPUAw4lp7ANGGQDSFooR"
X-Provags-ID: V03:K1:0CvawFgeDUQ+Q13Tg2i0B5KCqG+vdzf08DWU5fjtBR/nUFAl1gw
 /0ldW8qjnASZfh1vCHleFWIvGsolRbTUT0XAid3pgsdklf2JWKEBDGK43ZtZZbMIB9CVE5W
 obYOaiOX0vZ7EyRJyYhKj8Rp38qUHVFED0d8Ri44VE4x54JUrUMjEMX1yRhV0x2/oQCotgL
 l/BSeYb62ow/7asyRUkYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ocRG7F6uV9o=:9H0UslIAof6CfOGUG8MATo
 Ocr4bI8j2vENPpKSp3iYF5/6DxQ5EArBvmDNBs1CGeeKNRqj8Bb7H4B5a7c1TPhGx53ZFNkJV
 73jYZZGAiAxXQTz+F1EmZIW535FwmXWnx39oHYTutrtFhVDLeZcZKQ0FJC9LvbYIe6aI8vQ3S
 y/QlqIwn8ncdyuvcj0UYvtAueQhl8RR9DjiptrCI3AQQj/y+b/x7yRpv5WBN8EFyeBn5d3F2V
 UzQf+kG9iB4HtiuMxDFxXoyN5IUr7rw6doTbQ99Xw8EQZZcvncGAi4dwzv6Jo6Ca+ldQJa64R
 VzCRda6LXBqTpFTYwDST4Ap3mYu3Kna5F6HjCuLlWkXr5w74sqYoMEVDzNeeGFqDt/Ci+HFzY
 1pMhuCWFLT6Q54aBXTiUKGykwdR9VqscsdlMm/sAsc+JnBVT/zJCo0/17WDl/MguI7o+73efe
 Q+TdLN3w9g89IxlBupg1+TCWZj65Fkwnw9nUK+AE2vCYfnIGcHDZ4EBhacZ1iyocJ0+JntNmx
 tX2dDMF8NMR04AW7k91ey90wUdF5CgtNBM1KLSrunHrNOEPtuXbICmPCPSi0JHZYyWQLntLxf
 y/cLN0m+iOsF7UMIe7lnzuxgLQ8LPcSeBjy/XH4ga38SNH+HDiZ4s4BEp1aKBFYX78VGS3oPo
 Mq3uGBZC0dtqrl5MD4l38lh+rUoLNSRRvwxGyb6I37cUhSjbiBT54lD4jzKw5Y/gfGo50ldez
 xOzhW2JSDczofvzQKjFX/no4JeuKpSee+GxrrNTPgJHcf0joDX00UeIOf53yPQr3OX6yS8P0j
 7bB3/pnRpkJld69nwTGcDi1XvxxXlN1VUikosA8bAefu0s2yibkpdi7jbKwIPLgumGi0EjJqE
 NPBR2tZE+mwojwN3zwaGVqKFT1buvLdDSeHEyaQdsffO9D+buotrEWP0i0y4liNy4Xz6zeTYo
 m/szVsMncXmjefOtKDsGmnfTKYsXtqwTjcZb5/h3130cRyK7EIVBKjbkdftmiA+CjmVV+5ifb
 T/EyYW8+F7n+N/QIosIF4L8iWWUJvdwOGOXJUdWn8Eihf3WzfKKKWQ5xIJygjChtM0b50nF81
 F0rUrx4ajyCiR0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ueEm1UpsmCVUUWPUAw4lp7ANGGQDSFooR
Content-Type: multipart/mixed; boundary="6ODvv2QGzdAQnhkDlwuPWv8lsNv7bUGHH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Alexander Wetzel <alexander.wetzel@web.de>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
Message-ID: <2b2b8201-7d15-e3e9-bb4e-83709449483a@gmx.com>
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
 <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
 <e2776741-3554-e9a6-440a-4bfe8a839cbb@web.de>
In-Reply-To: <e2776741-3554-e9a6-440a-4bfe8a839cbb@web.de>

--6ODvv2QGzdAQnhkDlwuPWv8lsNv7bUGHH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>> I totally understand that the solution I'm going to provide sounds
>> aweful, but I'd recommend to use a newer enough kernel but without tha=
t
>> check, to copy all the data to another btrfs fs.
>> =C2=A0> It could be more safe than waiting for a btrfs check to repair=
 it.
>=20
> No problem for me. This report here was created for science only:-)

Thank you for your report!

It really reminds us how badly we did in the past, and gives me some
more hint on how to enhance the tree-checker to report more corruptions!

> I just wanted to your attention prior to destroying the broken FS and
> shredding potential useful data useful to track down what went wrong.
> With that now concluded I'll just do that!
>=20
> But maybe one additional remark: The snapshots transferred via btrfs
> send/receive to another PC are working fine on a system using a 5.2
> kernel.

Depends on how you send.
If you are sending the subvolume alone, (without -p or -c), it only
contains data (obviously), inode mode (regular, dir, block ...)
timestamps, filenames.

No internal structures like transid/sequence included, thus send/receive
will remove the corrupted internal structures, and since the destination
is 5.2 kernel, it will recreate them using correct values.

> Since the "moved" subvolume also does not have the block
> 8645398528 I assume I don't really have to copy the files but restoring=

> the subvolume with btrfs receive on a new btrfs image will also get rid=

> of the errors.

No need to bother that intermediate number at all. It's completely tree
block bytenr.
You don't need to worry about tree blocks, they're just an internal
method to restore things like filenames mentioned above.

As long as the important part is the received correctly, there is
nothing you'd ever need to bother, as they are all *internal* used data
structures, only kernel and developers need to care (and in this case,
receive side kernel will handle it, even developer don't need to care).

Thanks,
Qu

>=20
> Thanks for your time, the incredible fast feedback and your help,
>=20
> Alexander


--6ODvv2QGzdAQnhkDlwuPWv8lsNv7bUGHH--

--ueEm1UpsmCVUUWPUAw4lp7ANGGQDSFooR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0rJTgACgkQwj2R86El
/qgfWAf/cKkMIySokL4Qjk8iC6nM0eiNP8xG3iD38tx7NyfLfPEs6FT47L3Jtwni
JxtXHjGw38GULPB5Gkpz6OPafU/Dy6XVnZsRzZFfFATXBP+9rT3Mvan2CIcMfJLy
I6WMHlIdCuqJmpfanpESY7E6F8zYMEzC5237r738fqWAi3zAeSAT3Ks3Noezm8zJ
VCu8xqTvGX7aP8tCU/xVrssFbMGy0BOPAuSlqcxQGCIIFiZu3Y04yJNpuZgOD6qr
Y/RCPKgnDQTVxEIFN2BDN0ZdBULoiJHdtNubxQ96wdxj+UGvMc2KRrx9+LyEy3uT
R8AWcAWTohXa6fFU17SWiQWoBP/JrQ==
=VYoU
-----END PGP SIGNATURE-----

--ueEm1UpsmCVUUWPUAw4lp7ANGGQDSFooR--
