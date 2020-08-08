Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7939B23F787
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Aug 2020 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgHHMRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Aug 2020 08:17:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:50937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgHHMRV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Aug 2020 08:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596889039;
        bh=IhqdJrIfw+jyhat4x9K2eBgbsOYtuDZKtEJptrJvkFs=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=d4TAc2iaVJ7PAuz5LSDhxCoo2WJyYcxIXHM6xCYMtymNYcM3plDEMvMeznHR7jXoM
         dUU7omBHPPVEB9YIaF2A3E00CXX/h22waZjuDfEEu7oQnoPPNUNKAJQRAZ0oFqGAxD
         A/PECMYiEIc9PlC/vzzS9W87lI6R8SjQlbhS3mHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1kR6UT3pnT-00mO5W; Sat, 08
 Aug 2020 14:17:19 +0200
Subject: Re: fails to boot with "BTRFS critical (device sda2): corrupt leaf:
 ..."
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Lu Pi <lp.contact2@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAEYyJDyMkOBjhhVFbX_CCG0bnWC1i7OGLvPj8tFhntgxYjkRGg@mail.gmail.com>
 <e194deb8-4126-0ac6-becd-890939c99275@gmx.com>
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
Message-ID: <f388baf8-9cd2-73b2-021c-25338b97d07e@gmx.com>
Date:   Sat, 8 Aug 2020 20:17:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e194deb8-4126-0ac6-becd-890939c99275@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C5HZt5GtJ9GhCzH8SnKfSINAobYUOQgef"
X-Provags-ID: V03:K1:T/U5bZUHYYrcH8vCANJHmYLtBK9UzAu5uya+iLR1vsGtpXSmgS5
 nmnytliVpmlM3gliwse1ZmMqoBvQzBSnQKU2RuxEB0cBNikWNRqfV7BNpsxxaxl8HqYVyoy
 j4QDfeBaFdDs/NyF1KqZln7PBa/AZqNENJO6T0vaMIJ9KZmh21tZtg/S/3hZVtJK/MrYbvz
 eMo5FBZmLN9ukhp8Ls+tA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RN3xLgS/xmw=:2tXhF2osu1x/sALfcTNnLB
 4nL5b7A0ZXC2QKvOdqFPOZ2shDwQGRVr+UkQUHnsxyNjrPLUtcPIJGQt8qInGBkCKDquHRDxE
 OlXDOnjBUWQTWIyKIx1vrKHh48vngV/NUHf4rhMrfO6pSA1ZJUXwpsvyHpa46Z+z8Z64aQglz
 oU+db41x90OvsPdYYAlGDieimGc1vPRqLIrgzItplWMjgOYtJzSNJeRRwUIqnl7/o+pUrv/Ep
 rma7jk7dWIgd78+xXAJTv32jYjWGDLt9ZaJOb/cX7fUhXzbQYE0yHEa/TpaHffihoNuyVQYoQ
 lwee9DwGXsFm6grFXletdEGmRsTRMlG3WnRopkRlzsVm0Lz1obuliBU1sp22Ru7SDNVdogucR
 Go++ROx5pIVF05rVei8D9hwj98D5vd+3ERcM39sIPUT10a+6uDebVlOcV/iKYJJegrlw1kGzk
 XfKlR7WcyJUQGx/GWAkqwehiwIjxZ94FwIRrbWhP7TaihsiXgk35MU2cZnyFp8m2MW4O+wCvd
 1Jg0Kt7mVY128tjzjGwb7mijTRk/pDXLxx0z9chY/lmphGas2oOocY5H/9xStWNxLmyzE7RxS
 GSlJ0EiJ4/PImhx98FHsEWqwLVEuxi47dwfarXOsKBaGR6BPqQvfuq1mtQwG+BQqYJNAL8LEa
 d0sGbZZTBXaf1VzGebn3old7CO0is9g3GenW7Z/pP3kUGy3mA0StLTeoi5Fm3cdixfc7j17YH
 oyLyAheAo64SoBQKZ6IORUF7z1/INYZVjfQ7T5H1DRG44pZadgYto/N0LyZu2m0gFJ7gQPenW
 6Lrgh7qkLiq0dCMIexsmOTyBZIjUx6mGFH68qet2zTY8I6DLFBL1vBNsVdzJiszB748zlsuD9
 pLrJlRdgSa52H1W3W04sNQFl427E5QxrAR0vXNifziVRSbxcSuYPpUCtNNgMvAf6c3ANiQfin
 FDleJA5CRDnjy6HXrn6OevRNb+73fz0FSP2foGu+GTpbna5YHQ1zrJNIRl3ZpFCAIlj7+JiWW
 uIh6tfW9oLnVBw4peKSI+QHz9jmnOD3Leh1DXM839JQqyR/FwF/TNJjuZwumVKL9DMLsLEC5L
 1h0j+9BpWNnnSORd06hhjUSGS8jm5CTw5Q2O5pesUuQbJdJfhUQt2BWCHPuSHtk5hfTqz5eXy
 bVVOHnVNz2HhHq/Mgb3ATVlCyQMhsMFQNHoasIVpuV+sXKfOjoZnJIehgFi2iRX6yYGd58GUZ
 6LRfFFVvsSqFQxAEA7PC/q7DiHwjhxiqiPBR/aw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C5HZt5GtJ9GhCzH8SnKfSINAobYUOQgef
Content-Type: multipart/mixed; boundary="HoMG6sZkYjz2dveVJXzMFFeV0ARQowavc"

--HoMG6sZkYjz2dveVJXzMFFeV0ARQowavc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/8 =E4=B8=8B=E5=8D=887:45, Qu Wenruo wrote:
> This can be detected by "btrfs check --repair" after btrfs-progs v5.4.1=
,
> but not yet repairable. (Haven't got a real world report before this on=
e)

Typoe here, just "btrfs check" no --repair.

Thanks,
Qu


--HoMG6sZkYjz2dveVJXzMFFeV0ARQowavc--

--C5HZt5GtJ9GhCzH8SnKfSINAobYUOQgef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8ul8gACgkQwj2R86El
/qgWzgf8CpO7/5xR4UgNobsJ4Ya0giz7WfiD0Ps/xp8UOOuLNKhCqJNOyRu0K33n
oz4SYOTGAhgT1Nur/Yph6IEnYoWZMGnB5oY1ZuRaaRIuvrUsbJ9D1tlGjrRU1Sye
rN71lm8675dlCPG0aaL6/hSsOr4u7vA44HRxGeyQJvTKisROx0dQRr9lWGA2ew5f
1JAZ0QuHn0zZmJBMl8EyW3HfqhsrX8kDWyw3Yl8/x87b3Ka2tw2732wbXwkRaj5V
7DnlmUpqp83XgbbrevulTcszOCGHB8kYtRunIRCe0GDnT6wXlUrvvei2pAeK4K4i
7ReG2SiM6+XoqyjZbfurasw7Zvzovg==
=Uqp8
-----END PGP SIGNATURE-----

--C5HZt5GtJ9GhCzH8SnKfSINAobYUOQgef--
