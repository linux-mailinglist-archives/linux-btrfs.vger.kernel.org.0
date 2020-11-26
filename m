Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363A12C4EAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 07:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbgKZG0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 01:26:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:37541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732543AbgKZG0q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 01:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606372003;
        bh=bbqv6g2zSI2/KAxdN26Z4uvatPixAy73a7PmBOQxMg8=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=GBo4QMm8KaZaRlljY/QQG7wv9SGPaZmpImgFAd2kPnhogF99+MUT1hVFXlFXUCZzU
         qT5Rof9rrlI7Q14Kz8R6zkN6UgoqvGfmHTCZsKrnR8DkgjtukycVcwJ4Utys+L40T/
         1R9o2hqpWLQUVh5hc0X3wZumoYtvn/CIBPwvTQuM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9UK-1kPXvS3YUG-00s8rf; Thu, 26
 Nov 2020 07:26:43 +0100
Subject: Re: btrfs crash on armv7
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Joe Hermaszewski <joe@monoid.al>, linux-btrfs@vger.kernel.org
References: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
 <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
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
Message-ID: <beb026bf-3f46-ae4d-7258-acf4c3ff001c@gmx.com>
Date:   Thu, 26 Nov 2020 14:26:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CyfmLfLBnX3op2t05DnBS32LhQeAJKFHl"
X-Provags-ID: V03:K1:xLyGc2KnV0nsYFJxPoeAX4Xg4I0CnT4WRKhguNM2pLcn6na92qF
 Yyppy0BaQPIXExpcwrs2qKiI/F2+nMAWmMQiESCOfTC1FjcqFrHuMOOF6qsUbxVtuZkHUDs
 4y0SrKJHKKjt0TXJkJZtzl22KrAz397EHh+vO5axYpthVjcXFXhNh6Rqj/5AaU6OlN5Mm3R
 6k/k2jBSiS77+cyhXFg+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bx1cKruYzUU=:jMfdDqJIUf7U+8ahA0JZs+
 k2EAhJTS0u8j2dBIKpOWbvjUm7zYwBsDW4Cgd1nul4DgawATgIjWmGCCAvCXzp5uhRNj9KfYp
 62AWnwu56DcdNTRHUUiGIbzWl8KA8dkdWoymoKt5y+o+XihtjH3SOUlETWApkkAXrIDTfwa4K
 hUfXtp70FqU5xPW0CzYBAjQWDpyP28HrbURa1aMRM1ZMVnUd0dVUxIDskREdAOWB+GzQiytgX
 UlK3Qb9IqEta+zAQVz5RCKkMnALcr15qDosV+yTvnbN9QFzCLzZsQQppSqLbImDq4OYXGL0/z
 V2BnUwAD6BZKXXI9AJKMrdp2X2NTSvA4dFZLcrvvzS0w2NA3jDGsZ6DnDY8d3V5Q/DGg3jyDS
 HCmnKIq3ssa33OkqR8ZcW4zmYkdBd/8Y8k4tawEYCGUnOA+2DjkpEbx2r+x3mHX6ft2QZ0zFp
 Y7eSENo6R67A8WuvF+E/pJveSRag4ahIywSfSzPtt9FkaQ5RdJiAzyCAEGI0L/opbScSOW1TU
 wHlVGS5VZha3TRb5CmRUzoFFBuE0jV8J3E41wYc1CxAzSkqgxhE/z/uGIVX77fDOTEXipzY3W
 JrRm1BHEZfCAvSPgfoSTVhSOK545wtQxUwYKkmQgXXOuK6lgMMrj3D4ik1ii5S6Wt3Za8GDYf
 4Zp8+yvq65Gpu3H7eNxBOOFNE4YB379Asm2ln0JMKjYTT9ZBQer72UPLXW/EE5FnDNv/6sgH9
 H/nte0m50I3Feu4EWY/lR4YfrPr5cSekNU+TQt9vufg3HMAy7Y5EplL31X6CZeDRZKGCEZo3+
 GG0gX6A5QF+i6OaSfzIcG/27SJiiUy/uZYXsTHos3bkPazZnzhPsVAl0+F+UhoQ5Sr0ExJBc3
 +ozZq98QhQdyiLnYqUMw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CyfmLfLBnX3op2t05DnBS32LhQeAJKFHl
Content-Type: multipart/mixed; boundary="epdzhhjKhPP9p5bT8Q0KfUvcOm1k2Pxp5"

--epdzhhjKhPP9p5bT8Q0KfUvcOm1k2Pxp5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/26 =E4=B8=8B=E5=8D=882:15, Qu Wenruo wrote:
>=20
>=20
> On 2020/11/25 =E4=B8=8B=E5=8D=8811:28, Joe Hermaszewski wrote:
>> Hi,
>>
>> I have a arm32 machine with four drives with a btrfs fs spanning then =
in RAID1.
>> The filesystem has started behaving badly recently and I'm writing to:=

>>
>> - Solicit advice on how best to get the system back to a stable state
>> - Report a potential bug
>>
>> ## What happened:
>>
>> A couple of days ago I could no longer ssh into it, and on the serial
>> connection there were heaps of messages (and new ones appearing with g=
reat
>> frequency) along the lines of: `parent transid verify failed on blah..=
=2E wanted
>> x got y`.
>>
>> Although I don't have a record of the precise messages I do remember t=
hat there
>> was a difference of `15` between x and y.
>=20
> This normally can be a sign of unreliable HDD, which lies on FLUSH,
> killing metadata COW.
>=20
> But, your btrfs check doesn't report the same problem, thus I'm confuse=
d.
>=20
> Would you please try to run a "btrfs check --readonly /dev/sda1" with
> the fs unmounted?
>=20
> And, would you provide the full dmesg of that mismatch?
> The reason for the exact number is, I'm suspecting hardware memory
> corruption.
>=20
>>
>> I power-cycled system and started a scrub after it rebooted, this was
>> interrupted quite promptly by several more errors in btrfs, and the di=
sk
>> remounted RO.
>>
>> Every now and then in the kernel log I get messages like:
>>
>> `parent transid verify failed on blah... wanted x got y`
>=20
> Not showing up in the gist dmesg though.
>=20
>>
>> ## Important info
>>
>> The dev stats are all zero.
>>
>> Here are the outputs of some btrfs commands, dmesg and the kernel log =
from the
>> previous two boots: https://gist.github.com/b1beab134403c5047e2efbceb9=
8985f9
>>
>> The "cut here" portion of the kernel log is as follows
>>
>> ```
>> [  409.158097] ------------[ cut here ]------------
>> [  409.158205] WARNING: CPU: 1 PID: 217 at fs/btrfs/disk-io.c:531
>> btree_csum_one_bio+0x208/0x248 [btrfs]
>=20
> The line number shows, the tree bytenr doesn't match with the one in me=
mory.
> This is really too rare to be seen, especially when we have no other
> error reported from btrfs (at least in the gist)
>=20
> Since there is no other problems showing up in the gist, it means it
> could be a bit flip, considering the magic generation gap you mention i=
s
> 15, I'm more suspicious about memory bit flip.
>=20
> If you can provide the full parent transid mismatch error message, it
> may help to determine the possibility of hardware memory corruption.

Also if you can access the device, especially sda, please also try to
attach it to a known working system, and check if "btrfs check" reports
any error. (That file hole error can be ignored, as it won't cause any
problem).

Thanks,
Qu

>=20
> Thanks,
> Qu



--epdzhhjKhPP9p5bT8Q0KfUvcOm1k2Pxp5--

--CyfmLfLBnX3op2t05DnBS32LhQeAJKFHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+/SqAACgkQwj2R86El
/qghrAf+K1zo/qYmeOhq1o32rVe332WCU8AsZnqhUlYvyizkOznhFhT1Zb2GEZII
DO2X/+LQPkRwvfBnSFHq5fOU25b+pDdAL5cA5v4EjHUbELe3km5fTEJ7Vgs5bh4E
/FE3lF8jLdAkTZKjxCUMTA+95Q72wgFkZqSHguf3HoE+cCdKOk3TmWfQUUC2D0mQ
8HunZCSWpnhb7iiLBTwvgGF7U0mcWDZWZyloEhTzp7XdykJvc7PuR7rq7WX4F6k8
x1vzsDivGA+wDvjQYfxWcpc0K531eu7aSoNioJyP7S0kwn7hdhpOQIWQcTF81+iy
wtr1y7ooCRyQagcsE49fo7Ol5DNqZQ==
=00Gn
-----END PGP SIGNATURE-----

--CyfmLfLBnX3op2t05DnBS32LhQeAJKFHl--
