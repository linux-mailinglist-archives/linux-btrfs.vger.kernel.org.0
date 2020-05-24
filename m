Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821FF1DFDF3
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 May 2020 11:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgEXJYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 May 2020 05:24:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:39661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgEXJYh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 May 2020 05:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590312263;
        bh=V9iwm8lWP1r4dvpCtxXscRFk/SksgwE0w5oMYc8aV00=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HtQLe2kxzmXR4sYJkotNDzPh9fvX7Zd8Ey8zD1yUZ/xk4urWu9fE3CydAM89brrEu
         nqWjayrnl7d7QE+2nPadw+0bE3MJnedYJCXYHthTyN0eB7gcYFPA5wAySQBf4RfuuW
         rZUhxbSY8aVx92exZlehu8dQtTOkJz7kr1FT3q+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQnP-1jp61C0pIL-00GpC8; Sun, 24
 May 2020 11:24:23 +0200
Subject: Re: Trying to mount hangs
To:     Pierre Abbat <phma@bezitopo.org>, linux-btrfs@vger.kernel.org
References: <2549429.Qys7a5ZjRC@puma> <2582603.WkyslYimHe@puma>
 <f49ceced-fcbf-5be7-442d-25bbfbc75881@gmx.com> <19884168.u0ROftlITR@puma>
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
Message-ID: <76e60f34-9831-3bda-4b71-fcc5f9b46a7c@gmx.com>
Date:   Sun, 24 May 2020 17:24:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <19884168.u0ROftlITR@puma>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C1UhWG8o8GfGEyhbPAdBOSk9uGHK4vath"
X-Provags-ID: V03:K1:10YmCkoRuKwrXe9ukazKHekExDOFS+suZhv4/5SQGm4eK6D1Wv5
 hroPcBRHI/so+OP1+/YoXFVsjo9Xd6opYVXVX37Ll6mFHX+AS7YNvr9pSMH73JFkfCnNzsi
 SgmtVcU9VZFUz0AZnjURLi4A1abjFNF/Yum0fJlDF9vAPu/ezx55gGMr8fwkc2czv3GAqY3
 ZYpf0AJuhKRGSn6eA3Qkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TCzAPQBvfNk=:XSPTFKIXxDFb7j/wgs9seU
 vfwyBdDFIUwIR9b6eKki5zTW9fQ/cicDPWP/mqmGfp7cTNt2QXwJ6+vDP1aRk7C2XcneY0quq
 OAv4aF2TvAzYM2D+LCieQJNsSmlbN06Hn32zBzoxCnYoggYVhPDKrsQw+kmEOxoqTc1yEB2Kv
 HyxVXn6T1qKrwjpc6i/ii+bMUdwbG10gKTnyaAFwuh2XouOKOSIiUcTIDlfEduEbmIoRA7k7j
 OkeVyjCFxgLOU1+2eDfPIo5DXJe2fdX2WzbYUXlZ2chzq0DDQse5Y+vS0D8d1P27EeR0UriGv
 ejdrAXggMnLRScJplf9nrsI045y+x1jG5RFwmeYF/b87woc+gadfamEFMTyu1D7pv3dc20MBT
 5WjZX2iy8n57w+zEqs54PzHDGv/OCJb9QiHgjJtO7o00PMb9tTtBmHH9Bok9MSQFhEOQna1wZ
 XiUzHgw86fPPuIfQ/9FEGAew4PoQTEkjrgAVr+4cLatNIfIB5fM7DIuOGcY/XZmXFHdB7bycP
 +gOZz0q6BHR8AKggMZMf4oRPvUlhjg5/WpbfAjtJ/okpoIM72lInWt7LLw83TeAkrbNZGPgiz
 n2BU3rVDiZhVJ1Y44+opVOm/fvtF/hrJxfxggvw7uwtkRXEsG0FZ4pogg+lRiHLV75vrDeDhU
 WGXsq3VkZ3reiE/JUe8StTzdhYawT4o3LOQC4VfQZG5WNq9w9S2B/H7YN/iaeZC+PyR/fPv7D
 /3ZzLbkpuo+hMXURdD96ygn6NtRCS60+egIGBMmq57+Ev+d5GUrBS5cqU3X8ikxL4fCHLGXLg
 crLqKC2uxIERVfJtfpg2T9srdXtAgUoIPC1a8JI+tC1zsz0uq4on7k6B+POaxS/wJ86dqMFND
 wZAIDyJ1Yv6XkIeZfpPbVh1CgyTc+CggnxYzj9AC9NPlksxolW3bAGUQ+BpAbWpjopTZUFLnR
 Q1LonXTAREUmjqstkwmNj95n7jw0JPz//zFD/pzWcj5RYCbKuSUXhLAPNLrWIaTR1Xjik/ZE9
 wO+cUoeTeLbJpdAy7tChWh7CSZAs63UdClE3snAVNDGkyRSsNZjDFWkdI8o+ZuMNNruOdfBi2
 F29EGg9yEKBcdsNwIPwNYRx4zR28DykIZ4mnQ5ydEoI0UYIT12stnancCaV5SI2EGggz0gTYu
 ffviMoUFrNJkHzEAqtTGQp/MREFvup7jkspC56Mwhw+/5NVvhFB4rHLoRQAMh09R19MKC0IRm
 wfr64TrdMTCV0wn8Z
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C1UhWG8o8GfGEyhbPAdBOSk9uGHK4vath
Content-Type: multipart/mixed; boundary="xTbgOcf6ID5n1Ddv8tohKHpCXMiFTGiJw"

--xTbgOcf6ID5n1Ddv8tohKHpCXMiFTGiJw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/24 =E4=B8=8B=E5=8D=882:37, Pierre Abbat wrote:
> On Friday, May 22, 2020 6:02:44 AM EDT Qu Wenruo wrote:
>> For that purpose, we have btrfs-image, which will only dump the
>> metadata, which is way smaller than the full disk, and can be further
>> compressed using -c9 option. (And you can compress it furthermore).
>>
>> That btrfs-image dump even contains log tree, which is exactly what we=

>> need to fix the hang.
>=20
> I'm sending it. Let me know if you can reproduce the hang.

Didn't get the image.

Maybe it's blocked by the mail list filter?

Thanks,
Qu
>=20
> Pierre
>=20


--xTbgOcf6ID5n1Ddv8tohKHpCXMiFTGiJw--

--C1UhWG8o8GfGEyhbPAdBOSk9uGHK4vath
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7KPUMACgkQwj2R86El
/qhFGgf8DxafyZdwfLfl5NxdPX0gFCevV9ciY/ACTaWMjeFGpBpCceDdIH/HHrp8
p8mdgeU/Z+bwr27FNnoYuuwAO4Auqo74GRyVGIb6kFbdBuKcL3g+YTWe+gq/64cB
DaxrzIhD13XYBNBYBB8kJiP5/w7fobdCaX9z6UeXKjQzvOR0J2Mevb6NCNxkete8
e7QJdRFkz6hdvPMD6aukoOzezO5BMFpk6WmiZVyLziEZQYc/NeToiOaf4Pn8LVl0
O9rGa1kVuupKlqFGFDfcsAJd8udRTv6x936ZiIX1yOAKkYGffzHsJZ3M4m6/WJw2
fiPjAOqGD5BuPqoUHy2qeYq6WVSqaw==
=1Voe
-----END PGP SIGNATURE-----

--C1UhWG8o8GfGEyhbPAdBOSk9uGHK4vath--
