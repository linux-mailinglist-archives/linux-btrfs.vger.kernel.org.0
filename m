Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4701552C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGHQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 02:16:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:35813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgBGHQi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 02:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581059795;
        bh=waFj8KaCZnFLtD9SSSoY/g7/zzwIKC6LVbJnliYh6iU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EIYdaVVNMCCidiS6XeI/NA/0kEKLcGXoyFKnmADzAKyLMteO+2zMdVCM0+suHNPsb
         exEZ0UWtTkFnFtr0UeXOgCSgStGq+AYydX3fiQnjOqh0gDLHkZi6IujExt5jsFMx7f
         0fayzFvf3+BFoB1Gi4sFSGxOiQAaBJN+9PEy5aPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hVB-1ivJAm2IzJ-004hYg; Fri, 07
 Feb 2020 08:16:35 +0100
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
 <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com>
 <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
 <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
 <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com>
 <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
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
Message-ID: <49cc4e6d-07c0-aea0-e753-6a6262e4dedb@gmx.com>
Date:   Fri, 7 Feb 2020 15:16:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Zx5uhTZJBKjC39vgrReLd1vPYN3Bg2gGU"
X-Provags-ID: V03:K1:hzeV1j7iia4o92+pa2KNPUTBj6IYBgVGDjy1npXbOZW4umKToUF
 EASX+ZlsdHvNMrhhmjEOMUXcHM7eKU4B4jC1bTSrZVB6yFkEmds4PUiLr06Hh6j0HPS0Tq+
 N/fDcX+2nmEuea//A1CdGg2l7wcellwnYPFs8grlURseTiPpWzmiCEvPsnNeG/51AqAWgt6
 mtncnqPav9YYZGwdIwN/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/7kOK/SDaeA=:uzjzF7DHsIs511lJj3Uh9U
 lA2yt2ngVFqaKQO5iP3zaQ/ncDzVK6LctZYs0avHiYwJUgTLJd14dFJOZWW+xeHAVJZBudFq8
 IJEb+l9uh/EnAGijnuzlI9E6P0VVmporr5JeBT6l7pxmDrYZiJoYZppgm99nFNODDUiyo18iT
 KQpzMOv8NxQa2E9tTBMybtIzvw7f2TZ8MlmrWJzrVlMMq68Fh59SajR1QegcRZ8E3x/O0QgVy
 0OYHnG5/nMmytVDHKwB/CQf5s4+g3XuXMpsA3/r+mfbORTjBQXi7NBnNTZfAbmgAXmmR/8Wdc
 NWODE/u3jmAKgcI1U+oseagJQZXO4TywvWg6mHLivO6BOYhbVlQHfemZvx828ncRvbp6mvW5/
 pXQN8Z1gan1iPvCGpJu0wuM8tpnG3oMm23DU82niCYBz07T4lghdUpqmrORyC8okOqzQtlQxT
 qmfrFoCDf256hxHJDCbmqee+Sy+xxZVegvx6cu+cS2bWEA6xyqseUw/pCifE1MgYJaSzURk3v
 kO+sQyt7c3ghaLNe45nmhJ2WTw8YL/n4Mfr8K1cDizbfWJYvhBS8JuKwWjhC9yBSdUB+wuic4
 Xy1IABa1PabrN2EHQNppuKibgquoWiwuI0Ad2YfMPk2AGGUSunMBKU371+GO0j4NSlPx9oahA
 K1k5EfiY2TPBMvU/hvcAxDT7vAgRm78FbkgIdRSr0jJMPXlC9SpzY9ajwGsxOR1gXb5uJicL4
 J7XikwvgbTRr6vEQtdz7EX93MOWQT3JvQvs/QbDEBZtK56Lv2tynqPWzvr9SXw+F6rwFGpaNz
 lEOqKQ4rmElAIn/pIvox9U7tvrP5C9rP4quLpskRp/G8EfQYJS4Dd2o28C1/Vik6tmG5QQg/g
 wym9TOWtmryZ3WzfGjqd7fVb3SwfOvVtHo/5tpgiDh4jD4XWINGZBBRfJSDGzF2HleRz7tRIC
 OCEAmd06f+8qBBh/qtd9D9b8ktyEjEIHLkEcX8NPIMFCCMUCf+5zfNK2GO6UEB/Rjx/R6xNYC
 nrtY0lo/Ca+aJZFlCxDUM42bSpb3jGUfUZGMR11aCYeDXlEy/AqGXbHT3uR6rKH2OaDLyKJPa
 xFVpSF57Gzcy0w8JJQtf4nz3gbE7E32uz8gm6A+JZy9v8Lya1KuEQfhu0DowlrLkwdOI8WD43
 myuKfENDxuj7nu36/R7xLn6ML/7SYdrBzAMhiHORe4gTqvt+sL39QoBSPEou+RP7vKoyyoPxq
 eu4xSzrTp9Sy9a9/S
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zx5uhTZJBKjC39vgrReLd1vPYN3Bg2gGU
Content-Type: multipart/mixed; boundary="xbC5VKMDdvGrBXz3kcu74A0RvO24ZU9b3"

--xbC5VKMDdvGrBXz3kcu74A0RvO24ZU9b3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8B=E5=8D=882:16, Chiung-Ming Huang wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
>>
>> All these subvolumes had a missing root dir. That's not good either.
>> I guess btrfs-restore is your last chance, or RO mount with my
>> rescue=3Dskipbg patchset:
>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715=

>>
>=20
> Is it possible to use original disks to keep the restored data safely?
> I would like
> to restore the data of /dev/bcache3 to the new btrfs RAID0 at the first=
 and then
> add it to the new btrfs RAID0. Does `btrfs restore` need metadata or so=
mething
> in /dev/bcache3 to restore /dev/bcache2 and /dev/bcache4?

Devid 1 (bcache 2) seems OK to be missing, as all its data and metadata
are in RAID1.

But it's strongly recommended to test without wiping bcache2, to make
sure btrfs-restore can salvage enough data, then wipeing bcache2.

Thanks,
Qu

>=20
> /dev/bcache2, ID: 1
>    Device size:             9.09TiB
>    Device slack:              0.00B
>    Data,RAID1:              3.93TiB
>    Metadata,RAID1:          2.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             5.16TiB
>=20
> /dev/bcache3, ID: 3
>    Device size:             2.73TiB
>    Device slack:              0.00B
>    Data,single:           378.00GiB
>    Data,RAID1:            355.00GiB
>    Metadata,single:         2.00GiB
>    Metadata,RAID1:         11.00GiB
>    Unallocated:             2.00TiB
>=20
> /dev/bcache4, ID: 5
>    Device size:             9.09TiB
>    Device slack:              0.00B
>    Data,single:             2.93TiB
>    Data,RAID1:              4.15TiB
>    Metadata,single:         6.00GiB
>    Metadata,RAID1:         11.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             2.00TiB
>=20
> Regards,
> Chiung-Ming Huang
>=20


--xbC5VKMDdvGrBXz3kcu74A0RvO24ZU9b3--

--Zx5uhTZJBKjC39vgrReLd1vPYN3Bg2gGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl49Ds4ACgkQwj2R86El
/qgVoQf+MFL/3US1wl+/2WgV03pL7JyMAXWt+MINsaMqNtvnO3qAePTTg178xjOZ
jvlAnhUl2yf6QaVw+IfZldbVHhC//U1/wd8br3kE3Btg6g/4wija3b8u8O50O71B
OICLpjJb0BxJ0SPbLkOzBn7u6a0lm3JasFFW0bV3xL+CvWcHjl0hfbdFTZRGPuMS
UdQYHNpnNqJFIn9Z9fkjw8JfETR7c476XUdbRyxjN6XLM0GJBTF6hLA4m2mcUqJJ
sw1uX2k58KCGKuFNxkfN6XGkYilR3SPK8xqvDeooSlj50Tb3PuPMt5uUiC5vZceC
heY75qwDiJV+bJTTFRiv76XEc0DpCQ==
=lfGL
-----END PGP SIGNATURE-----

--Zx5uhTZJBKjC39vgrReLd1vPYN3Bg2gGU--
