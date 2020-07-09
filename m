Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76AC219713
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 06:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIEJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 00:09:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:51317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgGIEJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 00:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594267761;
        bh=v5VK4l2zPkifNfVftKW0NQK1K1IsC46UobSvHTBe4hQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fMs80JH5kRJFOsZbb9yvZuyu7QpwFCceP/l0LxdGPbVuobEE0CqKu0uQno6TfsJJ+
         DzUOlw27VHv/ET3Iq+jVz/ANRdU0gd036LXXtg8ifF0uOJ7TytW8ZAHoL45bpsgzhm
         Zqi4A3zbxkrR2RhQ/R8g/BFzWs+KMsWmj9zBgCRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCKBc-1k1fb10UB0-009TYf; Thu, 09
 Jul 2020 06:09:21 +0200
Subject: Re: btrfs and system df
To:     Hans von Stoffeln <lists@schramm.by>, linux-btrfs@vger.kernel.org
References: <3ffa3a38-0e98-886f-2cfb-3aeb9f2c1c7c@schramm.by>
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
Message-ID: <8c7db612-fffd-99b5-8de0-50435f5637b8@gmx.com>
Date:   Thu, 9 Jul 2020 12:09:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3ffa3a38-0e98-886f-2cfb-3aeb9f2c1c7c@schramm.by>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Zjb0j11z546NnpapVQoFAi6LeiobH1i8e"
X-Provags-ID: V03:K1:BaqvG70eNSmoRX/43Xae6J5PjFHK9tD/0lifWdGfGDl5KrYkxHT
 q8NqMSGTEU9s2qWIqymO13vuJaazSnRjOpDqKNepvcXOfFdEUeXkw2NdMphc34p0N77YUIn
 Bzh6xX+2XVK98kUIKbPgoA0cRnEcQY3iocMYjGC0RhFjTf8sOov6YRqjD1N3IgNFpqgwcWA
 FgqfPS0+HPQYMMbSVlCTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:syELHdLMM8k=:+fIiATMkADo2MAnD/6+pAR
 YhK+znEY4fE/UlE5BOLvi5cyvtP0mZKBiUdpu4urMYidxvvVbSlazEKim1wjKCvWJqkSKqIEN
 ePAShN9y+lSFFQ2cBYqBTUJo0PTIc3GWeM4qu/Mb/6oI9rSGQ0XVfQQc5C8dvAygHJCORSmry
 6mF2MQ/gIs7pq0a6LrOyk5cm9mi7/9YJEr5imMJYXbh2DSjkV5ZybBuhXwShm5q078kq0ie9S
 QkgGD5f/Ne1nE/JuySOpHirnC7UUuGAC27F5hPK3Sm+ghkTCxCwwlp5JN938CGtSpqD8P2anG
 jwnH1WgXE8do6E4mm+z9TbDcrZmBEuCQBhmARnp5uNeeAvaZgObEZzXayVpNBrnVA/RENXBjn
 1UwODfdV3D3psUCP65Y77NkHgzjKtbg0cHvqHtundDstMFPZVvc83NQB0Kfn2yhafqyzwNJ3o
 PGKvq7iKwicUHa2UXa0mOEZjasI1yPyUY9Vcplbleuyut/uf2nnVUxC4xEHPmtt5O/yvNAtgs
 ESTajyA8p+tOs6A/cqgMUQBkhcE7/CVVwhKqc4/BsD4nC4MGB3ZO5riC0jsfrfli7+4B1O9nX
 qPRsOOMW130O+RizC6wFRsDd5aK208/Y3K6xhxfLDpNls3I6RjbiPvrkOiw6JQu7lvk5ZARv2
 ozDhFzf7veSCZuA2NQh4WsRzJoM7hKX4HidpfNo1oOs0NhshhPVKzH/dCfa3jzTIy2eYPqLZf
 Xl2CfJZC1ATaxbrH4oVKU8pYrLdZgQyuLdQTkMZ/chY6dSLfVqgxmDcEjoa1Jck3Va6VxT7RJ
 CPrW90Zx3z7cA3hpXO2+j26kVsr924zR2ELIGRQxH3759Gg9X2kZ2yOil1y51VNoGQQhsOUDb
 Q3lg5+etxs1abPWJfQdk8R49/ssvaAI5nyZRSLmCEPtmjbSKHrSSB2I99ezmXMyNkD30S+qmP
 iLpj96g7BIQwABE2bqynBUPgmC3npYscF7ds93Mdf485gc86eaB3w9rdY1gwI59cgUOo9M3Rr
 dQZ1L4itQsj8kqX7mJcKyyIg0ichmU67c9VypFScu6gGgpnthzl2yjT1KGC5UnC19LlmETJ87
 EdpCQaaSa5o05Jq1EuW+MJvpGbjRlU/SxwHfCvMP1Lft6iVeraO8Mph9ndGdKEqRe1WXIdkds
 3q7E28i9X8eb+wHWntJAd4E/R5oorSMk4O4wFZwIAcmlWjZ3iD8DJuMU9Fn9wSUuGfPxsxtSw
 FbOr/97EfeqqGxncNQiv89xUAMqLGbnQYWCW12A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zjb0j11z546NnpapVQoFAi6LeiobH1i8e
Content-Type: multipart/mixed; boundary="TnauvdRtIcmxQAh8AMImFzGxcgYX8VL4o"

--TnauvdRtIcmxQAh8AMImFzGxcgYX8VL4o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/9 =E4=B8=8A=E5=8D=8811:44, Hans von Stoffeln wrote:
> Hi,
>=20
> current situation is that the linux system df thinks the drive is full:=

>=20
> /dev/mapper/HyVol002-hy002_data=C2=A0=C2=A0=C2=A0 3,0T=C2=A0=C2=A0=C2=A0=
 655G=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 100%
> /home/pyloor/data

This looks like a bug fixed by commit d55966c4279b ("btrfs: do not zero
f_bavail if we have available space"), which is fixed in v5.6, and
backported.

So what's your kernel version?

Thanks,
Qu
>=20
> But its not:
>=20
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00Ti=
B
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 655.07GiB
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.36TiB
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 654.34GiB
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.36TiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (min: 1.18TiB)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0=
0
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (used: 0.00B)
>=20
> Data,single: Size:653.01GiB, Used:652.74GiB (99.96%)
> =C2=A0=C2=A0 /dev/mapper/HyVol002-hy002_data=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 653.01GiB
>=20
> Metadata,DUP: Size:1.00GiB, Used:818.20MiB (79.90%)
> =C2=A0=C2=A0 /dev/mapper/HyVol002-hy002_data=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 2.00GiB
>=20
> System,DUP: Size:32.00MiB, Used:96.00KiB (0.29%)
> =C2=A0=C2=A0 /dev/mapper/HyVol002-hy002_data=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 64.00MiB
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/mapper/HyVol002-hy002_data=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 2.36TiB
>=20
>=20
> I searched for the answer in the internet and a balance was suggested. =
I
> did it:
>=20
> btrfs fi balance start -dusage=3D5 .
> Done, had to relocate 3 out of 659 chunks
>=20
> I increment the value at usage to 95 but it says no chunks relocated.
>=20
> Thanks for the help and sry for the newbie question.
>=20
> Kind regards,
> Holger


--TnauvdRtIcmxQAh8AMImFzGxcgYX8VL4o--

--Zjb0j11z546NnpapVQoFAi6LeiobH1i8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8GmG0ACgkQwj2R86El
/qgwwgf8Dt8UibpQsTCBW0M/dmvDJJ9kX8CRFgv/3pRSr1KZzp/JbD9pPOJv3s1t
N5aFfJ2P8YGDXSwbeInGSzwOy93ylp/6k8YLxrGJMWODpRfsOkxCCY5GShUVyr0e
LoLqze1IWTw5xoH+iPBKGAt3TI2Vb/uNlDjO+bA+zDfZamVS9cfqJ9PYuom5GBLy
o929z+2gtCqnRIcZmirc04tySkUpEuEP3w+mgSxMUOKpbqG150l7PEyd3HzdqspC
6ABlJJPLR2QoFpovVdmB2vIRQPTvvZrN61jGJFm/XmEIJBhjc5YOsEv8HOkKGjJC
L9hFPJhNckI5/IqXB2GjYcNpE04jcw==
=22Xw
-----END PGP SIGNATURE-----

--Zjb0j11z546NnpapVQoFAi6LeiobH1i8e--
