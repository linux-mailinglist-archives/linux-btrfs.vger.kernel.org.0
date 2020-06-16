Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52001FB26D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFPNpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 09:45:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:43037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgFPNpY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 09:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592315122;
        bh=djzNhmBNrpgDiPMamc80mfmB5sl84SXfGUvVF8ybwyo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dPZAEdEg1ZAUGKkgiO5tsk+XHQn9V3eOreC9huH7eC66YFlxKCMUsbOO++AsTj+fC
         u4GkzVlKnUwwR4He7DYtIyrTxuG3pNZofL6U2uHyS36w3RJTfynbTJKTufhq19LctQ
         XqUAdA2jbv+H0uiF9VT7ev0GREKc+SaQi7o6lOEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1iuBft17B2-00qzqb; Tue, 16
 Jun 2020 15:45:21 +0200
Subject: Re: Having troubles to disable inline extents
To:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2e956e490f6a430f9aa82fed3c8be08c@rs.bosch.com>
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
Message-ID: <e77dbead-308f-94f6-cd98-2abd524a863d@gmx.com>
Date:   Tue, 16 Jun 2020 21:45:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2e956e490f6a430f9aa82fed3c8be08c@rs.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HDFLo8BVGrX2qAKbx7PCNtArue4GLaWGj"
X-Provags-ID: V03:K1:YVMt3lsG0zIHXG+LKJBoTVLVQQpkn8u/WI4uRK7X2XMF/DdUB+D
 dU7Gn8C+Ju22Z9I7jVS1lS7RZCQoTtpryuTq+O1UGTXEUkL5LKWfjoBIt1KuARN+YKFgw8M
 ZH3t4dajqPD05m36OVANBRg0NdZ97Aqdw1UcRQ+gDRUb3tdR8rPYaoQOjJJNeYwXx/n22wW
 flq1o5DVTNTGjwD54JhIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhnhxD2e/iY=:wWmwv8xwvMIEHSpbwhHyyo
 7uqh2rgmhl0pDocA5JJ3eO+5uf5tKfG/28g/YeYfzOqiZhSD8mRJJezcnikAxMQgomJ2kXjjd
 iPA1i0f98+RBUFxlHypITrs9G2zwzJN9Lozecv/cBTkVqnMaz7TdTCq5wNMHticZNtVgTeooW
 hRpPddNr5Ay/ishrn2pGaGboIWpHDXC5KZmXhVtWeVqCB/z6UYH08IB7INU8DE5kn4Kxc7dMe
 t2dqMtjrxwqZXYMVs68ncRSr5sP7ZtugrJSAlnV7qs6JpWhQ3tJo5HkaujZXO5BHSvoRz0czY
 bNxGcYdRBUeoyg3e4seMvIdZmoyhU5e0oLNUYikjYSn3UKl/bkwE8yPGq39Zp4u+wSXN4+2gP
 souenrPKsEv650k1hrp4HjBS16unapHFBdtXAIlen7E+VpHD3XXuBU3nMappwaq7P6D8awCZD
 xyA7DwP56jWp4k3m8UOfU4JnTjSvmXcdR5Qur77lTtpeRPAG9NhPTrBWKdS/rPsTW2cpwbroL
 hVZMGBQwmXse5C1GGAM2l17rAEbHI0Ezwnjr4jDy0YgftROT+H6zl501PjftMeyN4CIgGANFU
 u7dQkxEaz2RWWDX3sR96IO3DAA4SyM5H0FOahLmS+qfrFONrDaE+S+DJRHgxTUhRr9V+sqagJ
 jsY55WPunIUpPnRnGgz6M3bRqhtfjs3A8pEk4Mh5nGkuvwuaj914ICnJf4zR71aA8SrQFsQcb
 SY+cDI2CXJ3BYAw5yz24xPvCa3JSiZgVRvgRXrK8T9vOjZ1BRNCHwPgafeePVekUGq9/9SKt+
 RO6DHTGcktMfFPtX05bg9zmSLPnasj+MPxqiT9ykbthm09YkQ6Pl58UdvlDwLeojqm8bmb0V1
 nMcjy8Zu/g9NLn4gqoukg+BXXlylH/FZwi1aDlo8JNArQNi72Au1FwlD068XVDq38DCwIt8Cx
 1ED5ojuNK5yM/Yu8b1K8PNGooj32Lm1Dqi/0lV+6KsD/UbamKwBnq8SiE+blvQAhfWImxDqf/
 dXXssj/8skIxS+PexokAAwitWFN3FRpS52dxx8Az05lJHDkGLyUCAk4Ss8TmIpSICSx0zdEYE
 U2Dg0nRkXHNNo9uTm8NymOHFYYIPm2SG576ZS63BLQNeo94hlZ7vYk8USVSH1p346R/Lo5mSZ
 b6SERNNRHcJQnz8KMKPYACqY3OXpMNR6BPqrhHC50xzz5iuhYXq+IGOdYgwk56lgiyQt0klR4
 6EwkNlhMMZQuRs1Rv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HDFLo8BVGrX2qAKbx7PCNtArue4GLaWGj
Content-Type: multipart/mixed; boundary="OdB0vlZfPCWZUSD1PkZVFSZygcLlXeW7y"

--OdB0vlZfPCWZUSD1PkZVFSZygcLlXeW7y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/16 =E4=B8=8B=E5=8D=889:41, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote=
:
> Hi,
>=20
> We are trying to add support for BTRFS in our project, so we started to=
 examine this filesystem.
> For the moment, we don't want inline extents for our tests, but we have=
 difficulties to turn them off. I'm using 'max_inline=3D0' mount option t=
o disable them, but I still see them for small files (< 50 Bytes) using F=
S_IOC_FIEMAP ioctl. Kernel log when executing mount:

max_inline only affects new writes.
So existing inlined extent won't be affected.

You need to defrag such small files to convert them back to regular exten=
ts.

Thanks,
Qu

> [11051.642976] BTRFS info (device loop0): max_inline at 0
> [11051.642978] BTRFS info (device loop0): disk space caching is enabled=

> [11051.642979] BTRFS info (device loop0): has skinny extents
>=20
> Environment:
> - 4.15.0-96-generic #97~16.04.1-Ubuntu SMP Wed Apr 1 03:03:31 UTC 2020 =
x86_64 x86_64 x86_64 GNU/Linux
> - btrfs-progs v4.4
>=20
> I would really appreciate your support on this.
> Tnx.
>=20
> Best regards,
>=20
> Dejan Rebraca
> BSOT/PJ-ES1-Bg
>=20


--OdB0vlZfPCWZUSD1PkZVFSZygcLlXeW7y--

--HDFLo8BVGrX2qAKbx7PCNtArue4GLaWGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7ozO4ACgkQwj2R86El
/qjeKAgAlRjGfh8YngQfTmvU4wE3G1UI2PUB+JRFTLT7eXfvmhNoKimTaAb8hMp2
w+SKquj3j5z5faypOTP26T3h6hgmZfI3wLft49Am11QQ61yJGJ5j/nXpTph2zwRc
eVHyZ0P8M8R1SiG1gcp3PQURAGJ42RkcUEgz9Rg9jcaDJlQstXeYjNPoa4F2Us1f
8BxekPuH1mxpT09UB8V6TaLb0pGSKVJlSQeG72Xs6CiXsueBsDzLZFOc05wL/c+Z
0iE3bY2FqnsjR+3PCt36Pf99/IW7tFcM08yQ4SYgPQdLOB5TIPaNcE0N4whOwUhi
9rvuwaVIEjt3/FmDzcXhjDNrHvCZaQ==
=3gAg
-----END PGP SIGNATURE-----

--HDFLo8BVGrX2qAKbx7PCNtArue4GLaWGj--
