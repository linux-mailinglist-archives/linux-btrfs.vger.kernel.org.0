Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF47BD2157
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfJJHHK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 03:07:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:43505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfJJHHK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 03:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570691224;
        bh=a0tG+sdcuSfpSqdeCQTVsls7eMq6k54kpguHb6oxYZA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lDFlt+VYvMRvuV1xFqs2cO7GLxJOI58mV30eS+kxOOLiWRheA5zY4ibg/1WP3WTZ/
         8kvlHg5Zf4gfkbuqlYB8XjbSgFZ4JiIaiDohYN8CT06sJ/zY9ChyUHoBf5GI2MshJt
         uhq+5h9lnCiVsyUPsKj1NvCXd05bfoMCEJQDxZZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26r3-1iGWjO3QRl-002VIc; Thu, 10
 Oct 2019 09:07:04 +0200
Subject: Re: [PATCH v2 0/4] btrfs-progs: fix clone from wrong subvolume
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1563822638.git.osandov@fb.com>
 <20190904203539.GF7452@vader>
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
Message-ID: <73ec1124-7daa-4ea3-0142-e17e60464496@gmx.com>
Date:   Thu, 10 Oct 2019 15:06:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190904203539.GF7452@vader>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nJkUSpzY2r9uBjpHh2E9osZTZ2dd9LISY"
X-Provags-ID: V03:K1:BVzLCW+deivewAh2GDwj7Q56bp3oI1svA9Lkf5lT9/2Pnp10tKA
 NbCSsE1z5hL5I7GFPp5OM3XEDdMAZMHsg60+rkCWz5sgKEp1pHCdq/mOr996PrGFisGIKEq
 72nRIAz3Ko7zn+QDMKbxASt4BQMke+hZu3UZXOucYNFXWrRmk5abibWZTzaAiMr2vFugeRf
 XXTycjhMXsdpsCakFVQ5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V40cbqHPYnw=:1J9eIURfh/L/P7EtFld2Ox
 BNA448nE7v8VjYDWaX/yt+8Gf4zwQBLxXCTh0Wmg/agxnataK4jRMAq8HJoH0ALTH/Kr2LI6S
 ezUB7cIOSwNEKPLJQfXxoPM4W2QJS7R8C2k39RyRY/Xm+goKu8Ajl2XbcdGp/Xx/Z+oCrAdNf
 dHVlc71buVUMNR1Zoy3ZPRF5qrOZcs2ZcsPlakngGTl8reDNjIX1MRxATRhOw8cdIOpWSxjeH
 ClrwX/CkFk9MnBHxzhwqXZIgxKqFLOtzYNph91eks74bERF0jQssBXPijBExsAePbUDljLXaV
 ucPvCbxdbwQhGZDnJRBri3jmTGZyiFcfYsToMf8zEAiT5rk1JATFl0YXdjzkhHsPFBLD1Y2Gy
 RqkyN6pUFlCR1EGJ+t4eMyVEkePW4Z/R4Jw66rLOE+0xjlGv+44tkiV7tR+iLwFTjZTwC41EK
 kLuBvQMPM1QT4kd/5SZ4X+Dj0m95o5unGxpjXxmJMy9GARNC4w3lEK4fnKOMGHaXAewNqs6cI
 5UIJJBowRLcroskjVrqnEwJ8WzPURUNsZhgYuUOnzE5oLZnZv6iQz9eOonPxrIPIYjeQCvHfT
 NaY2DQ7KQY+NHVwyHysIwK4aCPMSFLZKC/WQCSHGJRSPnzHCheKkk8xICghhQGHqNaJ6G5mg0
 U+K0A6upK2WkW15cZnzE++wH+vqMp0mw1ABuKzH05Rox9FYf9B3XCBgFfOZ99g7YgbvH6rgcD
 imWTv3/evSHu6WV85y6akzxxYtJ/u3K7m6532AllFIMiddD6hCOCl1hDRe20TlbSE9CX4Gjdq
 xZ/KwQnkq2qr1ESEFB8pzHELi+WiaDNSL15hXrDncYmnLFP6ZPsSu01rcNt8qAj9g9F6oazIx
 G/g4LmaCDWuo21JcjScmM/zL/I1eJDvUPFX8ACNQctEvu5eOVSJe5xAj9pxN+BfJiiFg6nhWk
 ObzwjAF8a8+FIhrJt7hEM3fZnP/pp6ncNWt0vGeRgqgyTq6qKDqZIxTc1mvXw8WrY87z7wLTw
 SCAEo04j6/Y8i9FiNpZRswenxL+QIXW/LyzgEsbJOL8hOcHQfm5+miAB3HKy7HHq9n/PCKEkh
 Mi/rD7TELs+MtJvmTWLVd7m9E9Wjx+Vzd8rsb0SdY2fPRFpdmINsnONG2iNPvGOE+ckengGxF
 cridzyYD55t14mr6a+7falySUNgE14MvR4ji5E2GMmrTFjFJw51E1vKyklJ5Dx/UldyyuwYZ0
 1jF84Y2JDe//9mX8ojEVCczXoBCuBHXz4Q5Vf6AiAWA5iCMSGItU8vYjvxgA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nJkUSpzY2r9uBjpHh2E9osZTZ2dd9LISY
Content-Type: multipart/mixed; boundary="avxtKqCEdhRBRTzpDLXyt07PIYRCOC9vS"

--avxtKqCEdhRBRTzpDLXyt07PIYRCOC9vS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/5 =E4=B8=8A=E5=8D=884:35, Omar Sandoval wrote:
> On Mon, Jul 22, 2019 at 12:15:01PM -0700, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> This is v2 of [1]. Changes from v1:
>>
>> - Split out removing commented-out code to new patch 1 and removed a
>>   related comment block.
>> - Made subvol_path const char * in patch 2.
>> - Added test case as patch 4.
>> - Fixed wrong signed-off-by.
>>
>> Thanks,
>> Omar
>>
>> 1: https://lore.kernel.org/linux-btrfs/cover.1563600688.git.osandov@fb=
=2Ecom/T/#u
>>
>> Omar Sandoval (4):
>>   btrfs-progs: receive: remove commented out transid checks
>>   btrfs-progs: receive: get rid of unnecessary strdup()
>>   btrfs-progs: receive: don't lookup clone root for received subvolume=

>>   btrfs-progs: tests: add test for receiving clone from duplicate
>>     subvolume
>>
>>  cmds/receive.c                                | 50 ++++--------------=
-
>>  .../test.sh                                   | 34 +++++++++++++
>>  2 files changed, 45 insertions(+), 39 deletions(-)
>>  create mode 100755 tests/misc-tests/038-receive-clone-from-current-su=
bvolume/test.sh
>=20
> Ping. Looks like only patch 2 is in the devel branch.
>=20

Since it looks good to me, I'll include the remaining patches in my next
pull to David, and hopes he accepts them.

Thanks,
Qu


--avxtKqCEdhRBRTzpDLXyt07PIYRCOC9vS--

--nJkUSpzY2r9uBjpHh2E9osZTZ2dd9LISY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2e2JMACgkQwj2R86El
/qgExQf/cKtRa3rHaBgoOUP9khkA3C/rtBAmIGvqb/XUKWX1AnonQYsGHLiqyksH
FXEo8mmVfHeHRuyp+1OBUaXhh9OtCMA9RzamJAmsjJCoONU6ds6jux+tezx0XOG2
0jWh7k1OHmG7uj++gf5Mdku1ypCWGw/FV5UwU4svOJro6S/ipn7f0H/Jtz+z76Ef
FLUDXsUr2kaXgsveKexw3kEOrlj3wH7AI/ViulaYrzcYmRLpuMKTLZ4/PTg2QccS
luyQdMFxka3BbcrdM5NsPFW9Mr+1Dv+RQ4JC4Zizy8jhuy0Gig6LCWq9oqSIldDr
emUZdfOsEIB9cNPPpszcpyhfEIm2Fw==
=qUmG
-----END PGP SIGNATURE-----

--nJkUSpzY2r9uBjpHh2E9osZTZ2dd9LISY--
