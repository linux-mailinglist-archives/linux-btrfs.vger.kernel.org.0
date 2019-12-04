Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2696A1122CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 07:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfLDGIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 01:08:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:54535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfLDGIS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 01:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575439697;
        bh=RyCjTMsz7cyayiZ17QIGzBd62+7BluWxiIDYUeJSNzg=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=VZoRi7JTJwuKp1v4/hIAc9Um7iFJXAgLMzkqdrXTnYsQITy2l90khhGuldnn17Fd5
         pJ9mOmVadSaEcQNGFpynYYBN8GCUcHt+1E9d1fJkYFSBRCXWuW1HEQVy0ziIqZ5j6B
         1cxJ5tGJ8sHNkr6HAmurP6BIEqqduu9R4iKx27Q4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbFs-1hk0IQ3Cdy-00sbnq for
 <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 07:08:17 +0100
Subject: Re: btrfs-progs: misc/016 hangs at ioctl
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <3b8f824f-0c55-b54b-e23d-257ad1b2f239@gmx.com>
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
Message-ID: <0a3fa957-b551-022b-8f6a-129e117626a7@gmx.com>
Date:   Wed, 4 Dec 2019 14:08:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3b8f824f-0c55-b54b-e23d-257ad1b2f239@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2881cRPyEvPtKgBeDFSPwMbT6cf9kW1Zu"
X-Provags-ID: V03:K1:79FnLzqpwXKY44qoHoyJCeWq+TuwGISh5pDpTTykTfHkmqY7CyE
 QJbJ9xP5IJEbbjHbDObi3WwfHOP0DRYO0ef6BUgyJabviURdMPMzzJ4ex3cWf50qySqky4r
 Ev3Sw/BuOysHDJYRbnF+0AW1geza7cwIekkQq+XUg6eVdKCBdFWGmFHIfCy7v33kRdK20Ir
 03T+ZdQaONiVMoVRJI/Iw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sjArKcHZjU=:SBzVUndVU5mJ3Sj6E3SsTe
 INx5WxGFTOrrR6350NFAZts9enXyp7EEilbE/lHpjzTiB7me73IBhtwwgPyx/zC+dRSoeGOgx
 FRnio5v5vuTKoG3F1UH8fVaTjzCrv3VDNVNDLdzj/Icm252ItG6/CRMIT7vvUDVMGvNJhgtP3
 6zCbc/QDmHwUcth32pe794ZtjNR2Tw4z5AoYD0m+s8o36AGB5j97Gm636+N38aIHP6D0IZAxo
 6gqPdQ7ubjRgdVkrxCXQAmVJ0G9fZ9gyfS0zj/pOJTSyi0kcIUgmPLw5hs1/Zk77O8+3qxtVL
 sFVn1Tc5cwmOL1B+aJySKL0d8KTF4uBQg9J/mpsevy3LQWJ9kqwco8bJ4IpfKmJ/UCm1Cq5cr
 1ujxSmB7sj0MVleenxsGUgfVkNuIIE318wEs9EHp54qiVhdtHF/5QchyVWsdmqdE5I5eFLJdS
 VW8x3vAL+bbTH/c1A/MPWRymdP3LcjXcHF2TunLkaKEtd/4OtPIpDM6OEhAkOlfsfvT4hTMEz
 zGENaR4BP7/CQqJamJnLJ+gYAgZpbqnH14cVd0X9cbvwHyI2MjSC/mr0PVGBrVJVRhxXuBZrP
 7sSg7BG+maLZwHXzLnLDwQGANME80cRH7EuBtLHWwUYV8oeT3owKf2OOeOcPR53Rw4csXqCZT
 w0quC+xBn9kYlYCWrOG4RU73AuFS7McqegBYXMB8C/wgZ9dDWgv46MZyzAiCD0DTg4qd8EKZi
 vwMAHNG+BrH1DMSe09YpEtje7pYe//qIAYvBRDhYyY8v9piqUu4cuOhEL5NybD5NecJkDSgJO
 8U8oYNAQIu6dMYAug8xiXsoQdQsKuBnaluPB3pxaBGM2/J44fmxsS2ZQIyku/H0E1LoKhSVX2
 /uDAzOCsxRu1Q2CbLT9eIjYmHAeUtiA+FAKIh5Z1o3V7waP9cHJbPeZyj4SRJS1/p+6o7YOkM
 ggyS3mm/Rk5R8cjLNfLttKRa1ZC6J3hmTjg9HUZrbA5ROLwhBHjvqlQn9x/02FJmqKqxe1RR4
 y8XLsnsd26MtjiVBjwLufpypaFyYkWHOt05h40q9jMrGRZmphjMwv+vOZiJfr7GseWk9AaNhm
 bcnAj7gIpB9RgxsNS7A7Pl5pTNPmaf7rv8ToblrqCk5spfpzmVtGrsjhbjIR1HxTSd7d1VEhf
 Ni7XiP4qPHZlroH5TfZUgRa5xpsCqKx7x6Dl4Pd/eRFpds2x54V1ZKst5264sTUFokCXEkt7N
 D2nlehV4bCTmJhsaYwcJ1X09AyNPy4Lha8KwrgtxbHyrkQdItYRaUs7zIbu0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2881cRPyEvPtKgBeDFSPwMbT6cf9kW1Zu
Content-Type: multipart/mixed; boundary="PxR2eSai3TgkeikqzFmSHuZGoWKYPtUgG"

--PxR2eSai3TgkeikqzFmSHuZGoWKYPtUgG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/4 =E4=B8=8B=E5=8D=882:06, Qu Wenruo wrote:
> Hi,
>=20
> Found a strange failure at btrfs-progs selftest misc/016.
>=20
> It hangs at current master 63de37476ebd ("Merge tag
> 'tag-chrome-platform-for-v5.5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux").
>=20
> What makes it even more mysterious is, misc-5.5 passes.
>=20
> Since there is no other btrfs pull, it's caused by some upstream
> non-btrfs commits.

BTW, no blocked kernel thread, no CPU usage.

And the hang can be canceled with a signal.

>=20
> Doing bisecting, but any clue will be appreciated.
>=20
> Thanks,
> Qu
>=20


--PxR2eSai3TgkeikqzFmSHuZGoWKYPtUgG--

--2881cRPyEvPtKgBeDFSPwMbT6cf9kW1Zu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3nTU4ACgkQwj2R86El
/qhxnAf9FzqaC9TFdmp1NCHRIqdYst91eX35W9u1Yx43QB+oMkUU66fUJYABim1p
zTyudpOlbl7AJc/7qjKPBCQEtLvt8mYHeDMRwp3WOheRe+z+lsD0Ta0i/7HNgC40
21HiwDyQMoV0hvIhx7JaeriGqGCKneraiyF8p+lX/KASY+8qk7DtWa6Ceu16VTcz
Cv4ApmAttv6eK1yBrLaaqfuZ90IElQZe4YaOn4801HTcuGn/P6H/oYEfZaBvJ5Fg
Yg26IDkh9FwXw48ahmRY9FXb/puvTbJENCjZdAImhDtBCbL/ooZXzwqmc3b8kY34
kA6WxpqPr4Zgs4de3Mx3P7p0VNCPdg==
=shsG
-----END PGP SIGNATURE-----

--2881cRPyEvPtKgBeDFSPwMbT6cf9kW1Zu--
