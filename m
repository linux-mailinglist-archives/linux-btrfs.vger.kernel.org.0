Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416351F0ACE
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFGK2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 06:28:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:40725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgFGK2v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 06:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591525729;
        bh=CAYsnmPrqhVhyKC08HHDd2Kh0fruCOb4h8w1PBKEaoI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E9rbTSJyMRuC0XZP4U+mSYdXPrp5eFj11FeLR596fhIWHIhhzbcakVnANEgCmpjmp
         xWmaaWYpu6eBBOAPrPJTsyONAF/9Ta8FtX+wlo2r7Rgo0rLagVISRW5wdQWIYQxG9y
         F3AUCvtdsZnJNhC6AzVHx5Mcz01qzD+e/8iSwvIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1jpLad2wot-00BxHw; Sun, 07
 Jun 2020 12:28:49 +0200
Subject: Re: balance + ENOFS -> readonly filesystem
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-btrfs@vger.kernel.org
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl> <20200607100017.GB9208@qmqm.qmqm.pl>
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
Message-ID: <dd988b8e-2252-f391-4d45-ef754d644417@gmx.com>
Date:   Sun, 7 Jun 2020 18:28:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607100017.GB9208@qmqm.qmqm.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QlDeGrxkZBlBFYVkZMLWuRUOJfSVqXXQ5"
X-Provags-ID: V03:K1:1meavx3XTQdyPbUFhLjIFJ8THDvzIGTitfJho+kkibaGZufpKI0
 7MHIWJt3MBolFwVNmGXs1l+jDp5lNamJ6cAGkbL8HSJM6PrzUmuNh8pLQx7YOvLSXARrx6J
 U7NXz1DnhWUiLO5RqDy9FOE531dEEdIoH4G2h3/A2qyTQle/GEPIhZ8TCj3lYpzjd/V5GG4
 F+xWONcIRFh0te9xrixZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SpMNMIZht4Q=:9Tuoa+5vaF2ReA/EYZKkkY
 u+qLg+w+x4OMxqVfbb3xEpyC+7zDUgfgXxS6rQVRL3voe4I7wiS39xc6WMCJ50lGdmmlOmZSS
 l3kzZmCRzH4UI8MlTrXGu6FsTrC1Lk5KgAZIJJ1ffUxm5PYHg+W7CGB8TAaFqKb3ow2jTIJ9k
 //bM+dEv3iwnhT4NibIWsXjsAtn2coIgWvE3vqpU+FEyMHiMcaGfQOLZfHnhP5mDNhPiMOA7u
 QoFybNfUtiv9W/IL4Om3+ooz/j/tkq/2CQCjlMfLXW404UWWPQfQ+HPkdHh8iAQAf3VM9oJFb
 eNRxG4/0VYGFs2cHmt9bBuVnbo8IYHmEfuiSb6tI9wXUmetZCP8zgtlxkfoz/sNIKfoA718vT
 dzixBvO7OajwcFqZnXMEv32383cGsdzMTqrdl/FuwSqBNFltqaC67DZa7CFcjIs1nqr+DuDVs
 T7O2H/cc7F9jlPWTlj35gaB2pgCmnhOGZiMje7EMj2IYG8P5h0HtYmrmwskmVBJV/nVfiHMu7
 mwI1O7uKDnCUcDEZe5i03fkwNUtM3ZOBfdRQIwKXgMl7WPROIoqeVU15IveUiyy4xiNg0yTfm
 1UAMfeMjxfCsImFjWG9wwglWAt+8YUq1hptKfqTKpgx2Tx6jV8Cy+PP6RLE6D1/+HNB2Dt/aA
 r/KBq/CTDUhMqMuoyMHib0C+9rcgVP0UdKsWBs2h4U8cIHLiZXBHo7lK5FB5/w6Em99aL7ygT
 xZ0TaD3vRr/EB6Cq2D1yBuTa13/2PfHudgXULP3+FJka3m9/D5sOlENCbZi9YMHrlWc7uaU1H
 6MVF22IpzqOrjFymMo8LI+JKXYag2IH+VaHK/F0ZghGODLRcenuPBMsdUSRQHm+OwkRmx+kSY
 bWQfqsXzlbaIuH4FkPpfYEV/t4Faz3CuZ22N84DhlG0H9afJfhI7uLuMibU3N2LehzzDNorBX
 1fZ0HDdVcxzDl0Y6GyGF/vCJiKsmssPzdHY7ZtbcOQXaGcn3p3wSs2ajggaXgbwRK6OW8T8TI
 W69dDDLlAldnylSw3GjfyJ/JhINyUuqFPFqQGuKPUq1Y14jLeZJRhiv/MoZCntnxzhLWVqvVd
 9u8rUcrHQrcsk1/x+mb4n1C2Xrz+fiRppz80TW1oD+Xt0e60YGr2EXBo2FJxcD4gJ7fADWKwB
 j3IWs3N4Dv6yz+mvTl2+kmcAGUTC6SazNpC9X8Y9xY4drT+MBOWZnc2d09CU94zyWC7jcDLOw
 AOhC9htMo7ocIb5b2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QlDeGrxkZBlBFYVkZMLWuRUOJfSVqXXQ5
Content-Type: multipart/mixed; boundary="nvm2TfN4zxzbpAuXjQfntWp1sElKb2adD"

--nvm2TfN4zxzbpAuXjQfntWp1sElKb2adD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/7 =E4=B8=8B=E5=8D=886:00, Micha=C5=82 Miros=C5=82aw wrote:
> On Sun, Jun 07, 2020 at 10:34:52AM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
>> On Sun, Jun 07, 2020 at 03:35:36PM +0800, Qu Wenruo wrote:
>>> On 2020/6/7 =E4=B8=8B=E5=8D=881:12, Micha=C5=82 Miros=C5=82aw wrote:
>>>> Dear btrfs developers,
>>>>
>>>> I just added a new disk to already almost full filesystem and tried =
to
>>>> enable raid1 for metadata (transcript below).
>>> May I ask for your per-disk usage?
>>>
>>> There is a known bug (but rare to hit) that completely unbalance disk=

>>> usage can lead to unexpected ENOSPC (-28) error at certain critical c=
ode
>>> and cause the transaction abort you're hitting.
>>>
>>> If you have added a new disk to an almost full one, then I guess that=

>>> would be the case...
>>
>> # btrfs filesystem usage .
>> Overall:
>>     Device size:                   1.82TiB
>>     Device allocated:            932.51GiB
>>     Device unallocated:          930.49GiB
>>     Device missing:                  0.00B
>>     Used:                        927.28GiB
>>     Free (estimated):            933.86GiB      (min: 468.62GiB)
>>     Data ratio:                       1.00
>>     Metadata ratio:                   2.00
>>     Global reserve:              512.00MiB      (used: 0.00B)
>>
>> Data,single: Size:928.47GiB, Used:925.10GiB
>>    /dev/mapper/btrfs1         927.47GiB
>>    /dev/mapper/btrfs2           1.00GiB
>>
>> Metadata,RAID1: Size:12.00MiB, Used:1.64MiB
>>    /dev/mapper/btrfs1          12.00MiB
>>    /dev/mapper/btrfs2          12.00MiB
>>
>> Metadata,DUP: Size:2.00GiB, Used:1.09GiB
>>    /dev/mapper/btrfs1           4.00GiB
>>
>> System,DUP: Size:8.00MiB, Used:144.00KiB
>>    /dev/mapper/btrfs1          16.00MiB
>>
>> Unallocated:
>>    /dev/mapper/btrfs1           1.02MiB
>>    /dev/mapper/btrfs2         930.49GiB
>>
>>>> The operation failed and
>>>> left the filesystem in readonly state. Is this expected?
>>>
>>> Definitely not.
>>>
>>> If your disk layout fits my assumption, then the following patchset i=
s
>>> worth trying:
>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D29700=
5
>> I'll give it a try.
>=20
> The series doesn't apply on 5.6.x nor 5.7.x. :(

It's based on current David's misc-next branch:
https://github.com/kdave/btrfs-devel/tree/misc-next

Thanks,
Qu

>=20
> Best Regards,
> Micha=C5=82 Miros=C5=82aw
>=20


--nvm2TfN4zxzbpAuXjQfntWp1sElKb2adD--

--QlDeGrxkZBlBFYVkZMLWuRUOJfSVqXXQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7cwVwACgkQwj2R86El
/qjxqwf+JvP5DIAucY/3UXGgRgDE5DKslKA+zpMNjReOt4rK8izemC6Y7B+/EDq2
HgihmN9GGL6Sp38BKqTihg1vAq3VjIBf9MN+tjkpi1forRL/L9BPkDWXNomiTjyI
Oh1tP3Wl31yeCSLfQZKpMGJ4Sqp5Y+o6yhsLpJRodCUR4leqAs25hhskpBvqo8qs
6Fua0eIEVimnr6KN0P0WAc7f+KJdENCSaPBGs+LHNLptrUC49PFCNVEguvbO7lUh
H7xsVD3WsrrHqTlhZ6YbqbAerj76ruMnSSNcYd5RrIarlD6s33MWIOGlak7vNfcV
OQ4LuvMAvvQv1kGvIliaCV/iiMInGQ==
=ErS6
-----END PGP SIGNATURE-----

--QlDeGrxkZBlBFYVkZMLWuRUOJfSVqXXQ5--
