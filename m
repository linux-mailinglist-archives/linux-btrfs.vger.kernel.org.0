Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B627E2AC9ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 01:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgKJA4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 19:56:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:47459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbgKJA4a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604969785;
        bh=uzsYrKS4pIL/L8OerQ4AOwEYG+XjFyvRLnfqOmG2K4Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eviPuz/pZAgh4r1zrqlu2T1uqwiTFM4IsVJKv2HVEsjuwHRjjq/P/xwbks+HVlKkD
         5cldW5+izzBC7wB948Xair8tCSXTyWJN09XgijPIWfds6+4jOwijHExF+1w4MtMIuk
         BKGUW3ER7AoXb3//kleCFRNaZS74poGgxKHPu/nw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1kaNDH11bP-0037vA; Tue, 10
 Nov 2020 01:56:24 +0100
Subject: Re: [PATCH 29/32] btrfs: scrub: introduce scrub_page::page_len for
 subpage support
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-30-wqu@suse.com> <20201109182541.GB6756@twin.jikos.cz>
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
Message-ID: <4164e848-bd32-644b-feb5-0bb29ab84353@gmx.com>
Date:   Tue, 10 Nov 2020 08:56:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109182541.GB6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CEAagrQyDRdETv1vvEKQ7coXQWjhBJHRu"
X-Provags-ID: V03:K1:i6p/wo8JpfNnheSaMNVbbU2dyG+qHbyZPDPWtKAFrDoLsO1AfwM
 rO9M/BG84ET5QfiJSD9AcmcnbYmLfWDuWm0vmwbu4hXbc1s4R65H02ypw2xSWZEZ0saCrRF
 paRHzdwGeNejRaI5FzGNfPIgqyugf9PHjDdLubvuqqsLRbVL9frdjwEphfNBD5yybvma2tl
 Wj64/OSLJrPgkA3YfaS5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F32i5olMe+M=:3HJMXHgsn3w/D1bz0FHd8E
 C+/w//FmroAzj53anznmFZo54Q8gPVVrPALPd8BqArqs3/zPZIkirZeaHK9SuEVrXCgh1L/8g
 vo62PSvNVrCeF4bowfUqunZTwlCoNQvwaPh2LDz/zQtneZsc+rQpQfXPZs7GdrMhwNPshdxtQ
 g2LpesQmlc2QUQFfT+TRhWaXGWD2CjCXrBD0FQ3x/cYwQYzTLGYLVg09qHB9i41lDTKnz0LEQ
 mwN4htVQtSLYLzE8gD10PEJReagah6gy4GZD8GN+cGXu2iI5CxpqlOJwTSkpfiAElF0kMZKL6
 jj8hK7AmsG5TB/49/0c1PdzjNmP50U6/pI1BdP1Pb93SMUSQv0etbe9BB2u9cxuW04e56MnC6
 oI8dNZ8nrt+GTCUs0Y7bN7+1KsVxL67qr5drSzh1PFTL9OAyCODhEzSg+dAjBbGun1bKBDBio
 9zA8OrkqBBUcVhFj6EgqEQPoYG3cJm3/YfMVNX57OKVB5OZ7QMW/77ZatrjdTR5DacWMLhZms
 tze8NiuA/hU4+cYfmQUwMQNqqdlZkBGa2R/DddZly5hZhyfDURe6YwWTFlEsCZhjiUc9oaQ3E
 OcS/SpH7A/ov2DJ5JMSiZL65oi2nyF++lXxzHjTwlzguagPSU/1Fz92gOv/lLAc0dgEsb8PIM
 i4KmfFJXssjt1ruPS7CVy30wlqwwyBQlq9uPHOUUETc3EyPLNLnUUzn89xIr6UaFi310SWU25
 rXRTEgGUCrWaqobPrDFvZLYMd1/Sm1d/TQY7WtPCGUDIGrzO0C9qSvQ2U/rnwo5H8+69V3x5G
 GRN309IydQ4GJVlbkY2+OGJKtRwmJdzSz+Mf0HeR30ucGW6XuOjqajVfILxFtI7913zyfP9xU
 dVEVIv44k1lzt03kbqGQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CEAagrQyDRdETv1vvEKQ7coXQWjhBJHRu
Content-Type: multipart/mixed; boundary="aTy013OmxPDmRQD2E7fHoqf5lPxwenmUw"

--aTy013OmxPDmRQD2E7fHoqf5lPxwenmUw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/10 =E4=B8=8A=E5=8D=882:25, David Sterba wrote:
> On Tue, Nov 03, 2020 at 09:31:05PM +0800, Qu Wenruo wrote:
>> Currently scrub_page only has one csum for each page, this is fine if
>> page size =3D=3D sector size, then each page has one csum for it.
>>
>> But for subpage support, we could have cases where only part of the pa=
ge
>> is utilized. E.g one 4K sector is read into a 64K page.
>> In that case, we need a way to determine which range is really utilize=
d.
>>
>> This patch will introduce scrub_page::page_len so that we can know
>> where the utilized range ends.
>=20
> Actually, this should be sectorsize or nodesize? Ie. is it necessary to=

> track the length inside scrub_page at all? It might make sense for
> convenience though.
>=20
In the end, no need to track page_len for current implement.
It's always sector size.

But that conflicts with the name "scrub_page", making it more
"scrub_sector".

Anyway, I need to update the scrub support patchset to follow the one
sector one scrub_page policy.

Thanks,
Qu


--aTy013OmxPDmRQD2E7fHoqf5lPxwenmUw--

--CEAagrQyDRdETv1vvEKQ7coXQWjhBJHRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+p5TUACgkQwj2R86El
/qjIlAgAlQ+Ji8DQ9iZI4TpGtYyxKVhnQCCBq3IAMKegxa+6+XhRDYraL54a43mu
n0NNgVOcZRLhvDaXta7ZQQgPiEQrX89dYYWslgUgTTbUZvg+OtRiYY/UhzuZ51VW
haxzGOcxFzw4qsyfYdQ6aIoRFiYA9e7gUMZLmZ6LZZ3MtAhD0TkuF1ZSHuIQMUK5
bkmActvo8pL4xdZWyW7H4BDbQjgeYf9kHVVJkhEs3PAicFcJ/6b2CXNnIr40LlME
nOy6nW80YSNDRe9sfeTUvO4ZGnMUqJV0skVBXARMfXiHoxPgmzTFc9oT4NknsI5W
c8TpMx9dBRBg6Nui4135FcdGP8wbOg==
=sfyA
-----END PGP SIGNATURE-----

--CEAagrQyDRdETv1vvEKQ7coXQWjhBJHRu--
