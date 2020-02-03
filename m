Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FE31504EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBCLJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:09:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:36349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbgBCLJu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 06:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580728187;
        bh=7G36NyB25cIIa+x+iuWU/sC+bJ0EYLGDwXrUpuCSrZM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W02+ag/U/nDpmLVFunnZeP4S5ab5MxUPG+RwDWQmRnZZUF/xdisr86UX1WnHAagDm
         AE9aUFdCbZ6L+5QyzEnvIs58ZVQhMjOqvY/YcHC28p778VmKgnXoU3786rZnkCnXQ4
         H52+nHYs2xrLvcbTBk6dCCEQlyznNG9+r4bHWDMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1j8dGb0CXz-00TRHO; Mon, 03
 Feb 2020 12:09:47 +0100
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
 <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
 <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com>
 <CACN+yT8OD1jFFgbdrNuqrfsfYZMpPfJaTQ+7cGUSuWaaeH9g9w@mail.gmail.com>
 <8944f055-6693-01a9-5b29-23d78c309274@gmx.com>
 <CACN+yT_6_LaZ_Yep88FgZZcRDTDXvmBczWDUW=r0O=ts6vkLJg@mail.gmail.com>
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
Message-ID: <14db65cb-f0d5-5af1-3efa-de8dfaf23f18@gmx.com>
Date:   Mon, 3 Feb 2020 19:09:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACN+yT_6_LaZ_Yep88FgZZcRDTDXvmBczWDUW=r0O=ts6vkLJg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YvD4Ub3xJAr2IHlx5SoVc0UpdItWpK7gf"
X-Provags-ID: V03:K1:ujz17dWAygpyXk8VvoQOx1v7VK20q7CtS1nPQPGzLju1uTX0nS7
 736Y2CIFGFo2Gkkaj9JTHR2A9ilZCb8Ic/YWQj7lX0BESjjeeXv2Siu+d95Qs4Zp0Y5Yy/m
 /dDYe5B4rNfp1ZpPGb6re4gfYxd3rGRAUAz8rEPynIFTk5p2S6/3LGYw1svScbQ3ScPi5EC
 uRqWic3e8dr8LAkG/R5IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3IvJlUnXL7o=:Goex3d1fS2WyCadgDFFFgE
 10xHUwQbL82Obv7yQIm3LBors8oIb+g7GqwiWK7ZzAeZz+8ntHOlzv75jxxGTvxtfYWsulWdO
 7qQ/brFnBbtrGFDzkp06euWFJJTDhJOU27I4kanHi4/a9vyMyaKJRZWLxS7RrpHVlmySp2Q//
 qlDfdwWWdYooLECFpl5rLFIWgiCoGOhP825Wy1YojpR7IMWZ8RkdAx1MZnGWKjYtQvwtTdcBX
 aZSrVpXeh481+qF9dnoM5Lk2F1QguHMY0XMlf0v+3Rer9UwPCaM4FtvkOQY1pwh56wkdF1kRq
 H9qC7/BpngWP/9z+tlKPWPCzp1vfDwMpDHZlHNkYx0chEjcZTJKch5HzLR2a7HmlWiY9eW98K
 Q/Zzz8SwFkKJA7crLMtTqF2uPM3DX77T26qIg+niA+xxu9QHDgucnfzZyQhYTnv8cXpFUwEDJ
 mJy5vZ3CLjEqtxlpQR4AaGGu3DtD1puFaf54gAfTmglbQrv3AY0qqBIA/n2IBqJNadu7mcH53
 cA0BWg134qb+mscR9Un+9P6jNiNOvJBdS6D09yrTVE0NAqbCXhR8a7+I3WJHA2mSf1PDtcI5P
 vXvUoaSR8fmg0NhTa0GbGQp3lzi4HTQMv6lwADD1Zqbwx7h2EOnfUl4p7ytVRdlm63qy6wkRc
 wJD8S6JGJ2CgSYW+L4RuiEhVjQYuq99u78pMEpOw5iGDKbmO5HP+xu01JXKnEQWT4412TeKiL
 HF6Q4aLRFNRXY5+6MvY6nuzdPUtN4z1t4Shv2/n9vXlrZWtbNOKyfdlMNakCb75hFsNuWpKeL
 B0/YM1Sndc69HwairU0sObdjanOcodz8RK9oBTHMjfvfOb3PGST8FHjt5gWXJof3EEOtjcXwU
 vR41qgGk+2bRx0Hl2SolkmJl1t5dTPLr3bK0qulpxZIhMibPmXw7fn2wN8QogmFtpSI1VLHFv
 k3VcY8iZWSElLYV7Ud0SF0VY/zSEZvehSNo9dh8rtSm32HoEcONU/yTCN+iMAgLI5TQchzKhE
 Dya9L8nPTpxOvc4dkQzbqS+RNbCRhEENDMFtGw3h1Tg/PUb1M1xzkNwzhVxZ9KxbIFgG5XH+i
 VXlhLZS6Dgg7l+njJClRoeAVtU93ufXupnjqAdVOF6kucd2A4jl9QnsAHiRR6qqKrN8B66dt6
 wrWzRKpg5ZMDJSPym0RoB8XI0i7uzBkgVjHPVETVuh6UK19g0i2nCBxlVv7KoFagoAxdfMvVx
 69ZqXPen8W6n9gvVP
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YvD4Ub3xJAr2IHlx5SoVc0UpdItWpK7gf
Content-Type: multipart/mixed; boundary="XQ0ToYzeaqxJQlG4qeqXpp6AENGCGauaR"

--XQ0ToYzeaqxJQlG4qeqXpp6AENGCGauaR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/3 =E4=B8=8B=E5=8D=886:56, Skibbi wrote:
> pon., 3 lut 2020 o 11:11 Qu Wenruo <quwenruo.btrfs@gmx.com> napisa=C5=82=
(a):
>=20
>> It depends on the timing.
>>
>> In fact, as your initial report said, btrfs even succeeded to read som=
e
>> tree copy from the disk when we lost the device for a while.
>> And finally goes RO if btrfs fails to write any tree blocks.
>=20
> Yeah, it wen't RO but when I tried to remount I got bad superblock bla
> bla.

Then that's the most important part.

> And I was unable to fix this by using btrfs repair for example.

btrfs check --repair is really the hardest part.
In theory we shouldn't even need it, but you know that's not the reality.=


> I'm not sure if it possible to recover from the error I got. That's
> why I'm concerned about power issues in the future. I've been using
> ext4 for decades and I don't remember that fatal filesystem crash.

All fses should survive power loss, obviously including btrfs.

> Yeah I lost some data due to bad sectors or power loss but I was
> always able to mount the filesystem.
>=20
The current conclusion is, as long as the disk follows FUA/FLUSH
correctly, btrfs should provide even data consistency across power loss.
(except certain known bugs in the past, which should all have been fixed)=


But the problem is, there seems to be some disks not following such
spec, especially in consumer grade HDDs, thus sometimes it's recommended
to disable write cache (aka, all writes returns when it reaches disk).

If you want to be extra safe, then you can go that solution.
The performance impact shouldn't be obvious, as linux page cache is
handling thing really well.

Thanks,
Qu


--XQ0ToYzeaqxJQlG4qeqXpp6AENGCGauaR--

--YvD4Ub3xJAr2IHlx5SoVc0UpdItWpK7gf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl43/3YACgkQwj2R86El
/qhT1gf+JOqodt1XUZz5c8HFQDiXST/4nX9I5xEgiJJWyPkXHv61YHeUklRNWJE3
7u9JWoGe3+FKLX4hZw7+e2OrbHPrrgcaLIGV3jVXDrvYily6B3qx2VYzMcycTiF0
zVL+wZUs9pjSMoXrg4Q+ouKdgzde3IrxHhWZUbXfLih4l7aQfq0Tq6V+F7TJqs02
6FBYPSD7DjKZj778ZlKk1Cu8gxhlbru96fBFzrMaS5uvELLfABsZ+m0VESzpHUI1
KQu2FyVm6vN1WhecqQ+IB/e2d3zCiFwZWeT9eB/fuRXIh1sRhxTfTsfav4V8Yy7w
2smf6677OYuXNon+iEnr/0eI71F6QQ==
=5NB6
-----END PGP SIGNATURE-----

--YvD4Ub3xJAr2IHlx5SoVc0UpdItWpK7gf--
