Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48E616F489
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 01:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBZAzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 19:55:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:33775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZAzT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 19:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582678516;
        bh=PzuCAn2qIcs+pB7FATGoD/Z57O9b8dvo5gMQDIs4OkQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TZWrkyMqQQiBZ1tJW7TzEcijAubd/JPL2mYQ2B4Q0PNNf8FvHUgqtGqBK3NXciUKL
         Ei8aSQZyI8qFnJLu1R7Zb5lf9+tm4z2OLzK0MLy5u/U62GlYvjDHtKQ4iSr/oYVe50
         KFJErro/vONVgPaCLnniQ13802GuTOpjs01FiIKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1jOz9d0VQ5-00uVfZ; Wed, 26
 Feb 2020 01:55:16 +0100
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Steven Fosdick <stevenfosdick@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     Jonathan H <pythonnut@gmail.com>
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
 <CAG_8rEf4BQpBPkYQywhMgg8Mw=-R8fs1KkE=n5qAz5XKevNM5Q@mail.gmail.com>
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
Message-ID: <efc139cb-1d50-d227-e3dc-cbac359f46af@gmx.com>
Date:   Wed, 26 Feb 2020 08:55:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAG_8rEf4BQpBPkYQywhMgg8Mw=-R8fs1KkE=n5qAz5XKevNM5Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pMtbxqlSmlt6kNhfw19RezXsZycicKMZJ"
X-Provags-ID: V03:K1:rPess8SfSjhapjyl9/eV1piL1r6rxxQfGEdJmYaqJuVcyJxEVUw
 lHnHyKmkHPVf95ciApwMkouio2dQFZK7W5pA4h5+bNgEIB8Qh6gACNr6DmM2lkk95HDtCwb
 aWsn8TOxJjX0WZzX70U4/CjPLOqTn9+Lmr1rI47KDYAZ/6LSLxPPnVC6PGkUCoIY8s3J4F6
 jr5KM+Qabcn+1zBdzrxmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Boz+pC6W/HQ=:MDyQn55gxWuYhswEnl/Qon
 6ysAPb9tWdBjFx1ZBjdiowH3kOoAtmZ13ZbWrqA0lpOAlqbEI9Ribf4QQyfoB0CPkNJEJXfHY
 JIkJrxABmeIhG8gZZYvk7OUijJPh325CnYOPZSgDNaXLQmTRq/BolWow3fk5l8SLaNnT3GW+P
 Ho5ePPi2yl3SD6c+J8SroUKIxQUrmOW4u0u4yl/EZh+31in6o1I6Y8603fVWBqm3bqa+kXVd/
 Isas7+OcQDTZHex6afjdampdXsWQhNNDlTxR8MSBuVvorkvILQlzYKwLJbfwd1SvHtdxs+r5J
 joGXLXf3WhqcxoKWyhVobNM80VMga0TalsfufHOdp5R14IIBdbWtIUPbxIMigZlq4Z2hJV+W1
 s7JRkqKMWRRyEVHNPjjDH67iNlKjkqjntOn1sKccka8C4gR8rFwPESX4hxUqYYF+ReSujhUEH
 tfnkcCQ9vbnMcbKSX89pPLbNN9dloJuDTnGqNJe//xnKc7KlJ9xG9N39wRfFpfHeQ9nCyv9WO
 n/bQ+KmCHsEu/5CNUU+f4KAODN3yKQ6mk6A/HSDd5jyjLcmsWMIGDaT0BaICyAkKWTsLTICbe
 jg4yStw5z9Xg9TMaPM5D/KwGfKwelcDZn8Avncc1ETyKmCfZubqwKMlVFg8pVKP7Yqz80AWdQ
 7LAzQMAvSQC5fk+zvWbGMtyY6C1O5uKVgqLt4AIeS0RigX/cUvMXqQma66jzDc8CVe/CornhS
 ByOAeLn1YYlLb+0tq4OhL6MtxrVB9EX513ALKE66O3aBAhSn4TqS86Cckinvz4N5ELt9VhVAE
 16I2N6y3kLKdjsHsxjPK7+WYF32fHN0nf3Cr4i1CZ2KQs5IBxePH2Mad9Bfpqa89u5+q1OzFJ
 qUaDyBKmwhHcBiUIxfhvsGiapRZ9kMJv0FKAY8UfVACeFt9v+tSYXcS25icOG19erXxD8TGJl
 AEKPRI/6d8SFmVPeO/60sJhhzfnRqkjfxCHsl51reDeLcKRX8pocsAq5NXM4zCLpNZnKIVdhR
 +w51HTMTq2bwSNfv0jZeXPGzUyqBV2tb7bywxu7wX7kd1S7WETeWTR8tOBIpAU5D6rIBHyrGh
 hFZi7+hPqsKxj3xHdGkBnZr/jMJjFPGlTGhaGhbHSL+qi60V4UXaDPOUTxAvBZUsbcHjg1mvp
 jkRkm1X0414apYa5M/GsAfORRZPfqB0mzRLz6vsJq3QQM50opkhk6YTzwH+4fvrAGCMfRqnwe
 ERpZ8T4fx/n0DTzpE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMtbxqlSmlt6kNhfw19RezXsZycicKMZJ
Content-Type: multipart/mixed; boundary="dv6KTWBZsNlxykHXa4GsMpbuNlwVP0fjb"

--dv6KTWBZsNlxykHXa4GsMpbuNlwVP0fjb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/26 =E4=B8=8A=E5=8D=888:51, Steven Fosdick wrote:
> On Tue, 25 Feb 2020 at 23:59, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:=

>> On 2020/2/26 =E4=B8=8A=E5=8D=884:39, Jonathan H wrote:
>>> [  +2.697798] BTRFS warning (device sdb): csum failed root -9 ino 257=

>>> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
>>> [  +0.003381] BTRFS warning (device sdb): csum failed root -9 ino 257=

>>> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
>>> [  +0.002514] BTRFS warning (device sdb): csum failed root -9 ino 257=

>>> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4
>>> [  +0.000543] BTRFS warning (device sdb): csum failed root -9 ino 257=

>>> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
>>> [  +0.001170] BTRFS warning (device sdb): csum failed root -9 ino 257=

>>> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
>>> [  +0.001151] BTRFS warning (device sdb): csum failed root -9 ino 257=

>>> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4
>>
>> This is a different error.
>> This means data reloc tree is corrupted.
>> This somewhat looks like an existing bug. especially when all rebuild
>> result the same csum.
>=20
> This looks remarkably similar to the errors I am getting that prevent
> removing a failed device from the array, except in my case it is only
> the found value is the same in the whole set of messages, the expected
> value varies.  Do you know if/when this bug was/will be corrected?
> Can the reloc tree be repaired/rebuilt?

Data reloc tree is just a temporary tree for relocation.

Since it failed to pass csum, relocation will abort and cleanup the data
reloc tree.

>=20
> Here are the messages I am getting:
>=20
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494745088 csum 0x8941f998 expected csum
> 0x99726972 mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494749184 csum 0x8941f998 expected csum
> 0x4c946d24 mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494753280 csum 0x8941f998 expected csum
> 0x3cacfa54 mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494757376 csum 0x8941f998 expected csum
> 0x453f4f60 mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494761472 csum 0x8941f998 expected csum
> 0x5630f6fa mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494765568 csum 0x8941f998 expected csum
> 0xbf215c7a mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494769664 csum 0x8941f998 expected csum
> 0x242df5b3 mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494773760 csum 0x8941f998 expected csum
> 0x84d8643c mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494777856 csum 0x8941f998 expected csum
> 0xcd4799e3 mirror 2
> Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 261 off 1494781952 csum 0x8941f998 expected csum
> 0x84e72065 mirror 2

Since the root is still -9, it's still data reloc tree and doesn't make
much sense.

BTW, full dmesg and btrfs check output are appreciated.

Thanks,
Qu
>=20
>=20
> Regards,
> Steve.
>=20


--dv6KTWBZsNlxykHXa4GsMpbuNlwVP0fjb--

--pMtbxqlSmlt6kNhfw19RezXsZycicKMZJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5VwfAACgkQwj2R86El
/qjauAf/eyX5l0eDS/LuPoIf+4EQr/mVg4ZZx14AChKv4c6ILzgSN08T0Y9TbJb5
ig7PI49FZ8ytuRutktLCea+6tMW+LUTxC66kIHbqhgTyJ6mXG6627G0mNsARFNNr
iwUJMcN3SBvZ5YamClCJMSi1vSeGh84jFck4v239yISlUU41eSkMMnJRdKf12rH1
5wgvCViybjqSVaVqru60HHrIviph5dicIGy8zcl4CF+Vhca2R4E7+62cwDeVnLZQ
07bOs5Czs0hxtPKMeD+gSv3FJq7Bm0xX/ZN9cdbPZCQWomQRogIHOL7QUSN/nu03
77xCD6tWhgqaGoCsqvJlgi6HuFW+fw==
=WpEz
-----END PGP SIGNATURE-----

--pMtbxqlSmlt6kNhfw19RezXsZycicKMZJ--
