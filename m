Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBF2D50F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgLJCk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 21:40:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:41501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgLJCkQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Dec 2020 21:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607567918;
        bh=2ze2r6nL+CSpLvsXvOI4Jo43fYFKWpAabHghqnezjBM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bCk4RA2tH/2RPT3D3zy38tVPLPUUKwB7dHt7K3L/FLS2XVAI1Wa0UyDov+ddzSTAg
         Scc+SXqdkud3BK8q+P14a1hHDA+guZvVlWKYZHj64k0hUd1WStvaEZsnRpZPiL3vk8
         DICGaw/OZqmcdy5VUbgEx/SHbCiT11BMQprWqUwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTiPv-1khW1Q2Yvd-00U42C; Thu, 10
 Dec 2020 03:38:38 +0100
Subject: Re: Global reserve ran out of space at 512MB, fails to rebalance
To:     Eric Wheeler <btrfs@lists.ewheeler.net>,
        linux-btrfs@vger.kernel.org
References: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
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
Message-ID: <853aa4b0-8cf1-8456-6f32-303be50ac92b@gmx.com>
Date:   Thu, 10 Dec 2020 10:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4Ke0ncb8RMAjI2t2KrE0KJiJpeILrY0WM"
X-Provags-ID: V03:K1:y6ZxknbigkA7gdx2bHW8swlsCnuTQtprWAjmkAUDyGgpZCtZaO9
 7HsACQXwRDjWppA6qICbi6rEM09ZJZVxibsGgJpQA+hUO1U4z0ePtiudoo0WoWkxKc7qEMm
 GsbElYz5e698mkRVIDUfQmgfofHTI8S+deX7qLVjEmAMRY0WrCn05RNtpo10K8K+LJ7WV3I
 4KJ5xjZAiHCxJvj6Rd7wQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5C7qY4Y79gk=:4aosMGQK7v4vlLhONsvAj+
 Y48+cHNy3SCOu0L9ZFjsRfCRxIQ3b2d/Uzgaeg20YOWKsyI9l/bFLF8JBpSZUBpTKpYiBRGVJ
 /v2G6689cFMmyFUH49zivW1PU/xqcSM3TS7SddGms9GySaAXoJKX3FywfAxCiOODyh0vPGxEh
 IhfU+YgnR13uAgsZiDEZv6nk5j70naRF1p9gVVCLzo/2c8fvCXmbxTWP5eWqXkWJpGbeJTvxd
 sgQbbahZOaKXxz9Z+yRY0FuJy0xmPtlhfIFaFC7fJpqnKrkNH0SZ7CAiDYlpP5rIfCalGpYCa
 CRK5zK9F1b1mSxb+MTKl04gsEIYiYV2q8Iwrco30fpbpUX2jTR895Fbo0MLKSeFCSAkgVixh2
 LtXynlzOBi5Q+f22xhKJQ3i/U/9/PkLjrRUvFWdFIFh5mKl509ikXd+b92LRbhE2oSEcB0geV
 LGcwR/H5byJKp+JtDke98rj6+apj3addWlmG7fMOT+/Dn5xfSukgbazUaosQ0A9kSzfjo+51p
 KCgW9wbBmyMJk5L3q03fuYUkoQ79FfYCt+mG7yS984J1yIx82pXB0bxoj4FT11OlYZAL+B8td
 IK1lSP7frRiEwvyZl9zIl17V2slgRA+qLYLR89qgXZL/4KRQzLXAuOUfG8BxO5mw538Lovo51
 ecg7FYlGwYAPzgl1PE49T8T4OG+vtoKHg7nfkgyCRVd4TIVoEqyy1ne7++lDo++11pghQ0z3x
 xaP/CNVV7AaoTbdocoHdNoZN6b1l9j6HD044OsxpeP6peKbFaPjP62xhopoUMOIR3cibejx0Q
 lGd1E0EuxBRNiX7l9/RnEpL+OmfYsi9WpSRXjjYe5mZ9Wjo5qha7sffGHahwGnwzUQKgzVVEf
 U4shdGs3HiTcyYAWllLA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Ke0ncb8RMAjI2t2KrE0KJiJpeILrY0WM
Content-Type: multipart/mixed; boundary="TVKIChb3OJQmmo6rhDF7IZuVpyvN5Ftd7"

--TVKIChb3OJQmmo6rhDF7IZuVpyvN5Ftd7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/10 =E4=B8=8A=E5=8D=889:52, Eric Wheeler wrote:
> Hello all,
>=20
> We have a 30TB volume with lots of snapshots that is low on space and w=
e=20
> are trying to rebalance.  Even if we don't rebalance, the space cleaner=
=20
> still fills up the Global reserve:
>=20
>     Device size:                  30.00TiB
>     Device allocated:             30.00TiB
>     Device unallocated:            1.00GiB

So it still has one GiB unallocated for rebalance.

But, don't expect much luck, as balance is not the solution to your probl=
em.
What you really need is to free up some metadata space, as you're really
exhausting the metadata space (only 1GiB available for new metadata)

>     Device missing:                  0.00B
>     Used:                         29.27TiB
>     Free (estimated):            705.21GiB	(min: 704.71GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>>>> Global reserve:              512.00MiB	(used: 512.00MiB) <<<<<<<
>=20
> This was on a Linux 5.6 kernel.  I'm trying a Linux 5.9.13 kernel with =
a=20
> hacked in SZ_4G in place of the SZ_512MB and will report back when I le=
arn=20
> more.

It won't change. In fact, if you increase the global rsv to 4G, it would
cause more problem since btrfs will try to reserve more metadata space,
which you definitely don't have.
>=20
> In the meantime, do you have any suggestions to work through the issue?=


If you can still remove files/snapshots, do it.

Thanks,
Qu
>=20
> Thank you for your help!
>=20
>=20
> --
> Eric Wheeler
>=20


--TVKIChb3OJQmmo6rhDF7IZuVpyvN5Ftd7--

--4Ke0ncb8RMAjI2t2KrE0KJiJpeILrY0WM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/RiisACgkQwj2R86El
/qhgqwf/frOr430BgGnghWQkLs33il+wO9ZzQBD1LDh/1kyDwWFSnHdWFG0bQwmK
GpdQ077wKqJZIS1c79c7jbsAmHLeZeXPwbE7fThg5QROsOxA5dEqqut88TGWVaTK
m3zZSSbLpop2OrevGgwu6mvi2IfRR0h7VYL2UFzqOb0Sn1NABYdh+lGTQAPCB0C7
hVyuBvxj6MQG1RLu7GwdvtvtPuJNjT1yQx7ycYIR6x6adYNDB6Yy1wmSbNBTK/oD
dm8+Zsn9D9TX2pKBqBEV3aDDcTw56II1a9kYSOjfsrGSjMQ+H90GWcRoKYWpvJSc
Hyd/EhNE/N3S6l0aaWhvshzn7m2Nrw==
=OU0g
-----END PGP SIGNATURE-----

--4Ke0ncb8RMAjI2t2KrE0KJiJpeILrY0WM--
