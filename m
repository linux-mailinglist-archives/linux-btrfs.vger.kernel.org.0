Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1131C7FC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 03:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgEGBNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 21:13:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:45429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgEGBNq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 21:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588814023;
        bh=izLRpPzIc5Qw9YN5NN5SC9d6+EjJPx+3behmmiweWbs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WmpqkpWU2KhZbjUBQZ4EKH44sH5KxJUJ/wgTjvFzKifX11iDVPdbFr3dRxjClyjjm
         0mkwjQJeScuvMlBP72iRO/XW8Do8uZNAZmF1xUHluXlMq06bcRO8AarRSQTKpfAa12
         TkZ0ujdzKSKb71oA4BR+r+wT69ercl3y4AxSZhC4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2W5-1iotA92GYx-00k5pg; Thu, 07
 May 2020 03:13:43 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
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
Message-ID: <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
Date:   Thu, 7 May 2020 09:13:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7f7jTY2UoCMLv3h1qVFOLlW5pxreurhQm"
X-Provags-ID: V03:K1:mC/IjPsHA/wJK7XbLjVLsk3BfXSDqxbG/B9Nj8cLHMEgp4p4jx6
 jVVER+nIDeIKYzbaqjUuclsCGO7lfr1R/MVfU6JDDPwEY+lc4i8YJIeWvaTiHmWppElD8VL
 Uywob4BFunGon9oIAozZVfmYZj1tXZ0JxgJTJfCrjiTD1onhbsr/9/Vm9H17P08bqNwRrU1
 EEk1YX0XZpXhhoozIjfNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9hxwsfqmo0=:5SLzQz5gVLSOplFncPmR7N
 0ZJtaEZv2XVt+0Eg+UblhA7bGcfan13wf5Ui+xj3uv950wBbIOI57fGxLG4i3Ab8297Q1cX6o
 ivs4dJ+0BgX8rmzdivEoBwUL6vAT7r85CYgwwkQ+VJP9zf4lzmZqfx9gcgXF3YrrIJjd5Zy3f
 4gxxixaANj0pxYlAXcrtz1Dd0kKn2FG4jwJAHQie92+AvS1153+8mrnzV3lRZf1+lQgfrKNg+
 s7YSs5ugamScLOf1TqnnJHg/VTaHXMO3u5EwwsIx4m9DKrJaeutCy4O0oUnoVFVV/TtkMCKps
 tTawESqEExT8neMMUlzlrDcmXu89JcEUo6O4f2xUU9aTl6sqSDH8QAhgfC4tlYIH5scGjjbCP
 B//xhDZQrRpbdZb+imT86q0jvI/LQdkrhMevDxWKJ1Gtg91DFHGry9HeRJo4SNX/vEV5d/Sso
 5GkvWnqAoa7C+ofoCpmKsRD6jEKwAG5SgwcI9fYakv6A/ypB+b8VG8qqG6sO5gHDxJZ6woByp
 7Kkz9xU1h5TdPHMHyukMl+E+hEqDn1PY1SWmkkz6EusLRRjlTqqa0Z+AHYi69hFYVZULMz1bq
 CvPgq9+if0ejRa2FXQwJLOO3MimYgvwQWq9iudXd5he+o5ILP3dTJF0Ud/f8EDtcJu+dqYMet
 DiCCfw973K2WY7fi4VzYgUQNqofDU/T1CIntQoCtj+dU+zcThvYgalV9KOsr1qpkIqDkIxkZY
 bDL10fiC+Oo7+KAZjaFPbLbrUAf1dBcDqKW62LwVGKzT1UG0ppfiiOyXhpqvZ9TmTz003Iyod
 xSUpENB4a9WLcRu4HBaAOmk71NtxRbzEqYBZ7RJJU+wYOutBkGmUGtIVyoW5zLFWiieKFQxJD
 9uv5Qz6A0VQ4mI9OMyN9IQJIcav/Mk5E8Qti/83PG2z2lrJsYDZBQs9vo5V1xWymnYqGhv1kR
 PKzYYNS1kIpdEFJnI1Zl+9V3YtF09oc3SIj/c2L0lvVZ0raDe/tRlKYrqbiBt9aM8vEn0fp/a
 UHi6E2riRaIcr5IjoN8hsOdsK/T7+bGbJc37InAJBkqwEl4l4V/CfVFEqxxDH/SCiAyTO+Rzm
 80t3tisCsGKk4apVeJ9G61tiaSVgj2TeZwB6cCTKYV9sLv9HsvpmfWx424PcCaafEaZlXF+Z4
 BeUm5QUnyTOp/iqkb3k0dwgaaPbzDQ4eyNePjMlzgFd1htzGa2H6uEEDybfVRmSviORtYpDzg
 z+faJpzhwJADm2h06
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7f7jTY2UoCMLv3h1qVFOLlW5pxreurhQm
Content-Type: multipart/mixed; boundary="ePkylwHKvyTCBiht6c2oVKE4sj6r37N9I"

--ePkylwHKvyTCBiht6c2oVKE4sj6r37N9I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> Hello,
>=20
> I looked up this error and it basically says ask a developer to
> determine if it's a false error or not. I just started getting some
> slow response times, and looked at the dmesg log to find a ton of
> these errors.
>=20
> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D5
> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generatio=
n:
> has 18446744073709551492 expect [0, 6875827]
> [192088.449823] BTRFS error (device sdh): block=3D203510940835840 read
> time tree block corruption detected
> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D5
> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generatio=
n:
> has 18446744073709551492 expect [0, 6875827]
> [192088.462773] BTRFS error (device sdh): block=3D203510940835840 read
> time tree block corruption detected
> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D5
> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generatio=
n:
> has 18446744073709551492 expect [0, 6875827]
> [192088.468457] BTRFS error (device sdh): block=3D203510940835840 read
> time tree block corruption detected
>=20
> btrfs device stats, however, doesn't show any errors.
>=20
> Is there anything I should do about this, or should I just continue
> using my array as normal?

This is caused by older kernel underflow inode generation.

Latest btrfs-progs can fix it, using btrfs check --repair.

Or you can go safer, by manually locating the inode using its inode
number (1311670), and copy it to some new location using previous
working kernel, then delete the old file, copy the new one back to fix it=
=2E

Thanks,
Qu

>=20
> Thank you!
>=20


--ePkylwHKvyTCBiht6c2oVKE4sj6r37N9I--

--7f7jTY2UoCMLv3h1qVFOLlW5pxreurhQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6zYMMACgkQwj2R86El
/qj3Wgf+NiJw7E7IpN/7PK7NqhnkIqvaMzTGp5NvKtoWOO3ywA3bnf34Axi4gK+O
ogtNozcwpGbROp5dxxPeBTi1GHuZqwRMbmKn22/GF7Zw1jIWM0OexecqWWbIQaLe
cu6szoB68y+j6Xj/XHIqL4YSkLeK7cdn4HJpM9zXdB/1vNdx19+LyRITiIxjfhx1
K03HgDFY16wndAErWxwwX9/nEgo1kOYXWn0Emdgl0OkHd8dDeVEDknDVmrZddUSU
mV0TdkDuPBhIe2dedkQKLAQZqzDurZJqkKXK7Kyjt6W4bNzpy9/Uk9kQe6FlktKx
bpJGz6ualx9Si5fuYuphUyy6VoKAzw==
=N7YS
-----END PGP SIGNATURE-----

--7f7jTY2UoCMLv3h1qVFOLlW5pxreurhQm--
