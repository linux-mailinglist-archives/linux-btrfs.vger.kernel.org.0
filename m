Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61A234E9F
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGaXfh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 19:35:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:46721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGaXfg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 19:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596238531;
        bh=N2y/3y3LSjFvxRzB+uVoZik3NnO8JVjH/ttFMp1JbBs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iyUIeMw6CjXWskOZLtZDvLH4HXW1TOhS9OicbUKnowhy8DNEBVJQW7WT6sVKNEoAf
         w+v+vnsJ7WTw8Y+5xYBpqPBNkA9ljScvnY+ZN0ZUHnBz42mtoWeuon9oXVN/riWOw0
         lgUslwpAGJ98oEvCcqfce0OeSQWzmGELjEdnHzoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1kuqc71CNF-00tR1f; Sat, 01
 Aug 2020 01:35:30 +0200
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200731140807.GM3703@twin.jikos.cz>
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
Message-ID: <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
Date:   Sat, 1 Aug 2020 07:35:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731140807.GM3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AHF7IB0SiSccyFX545YRWYZ3SwzB6kL4y"
X-Provags-ID: V03:K1:li+noiZspvbzmSKBFODJslxaf+bGl3d2hKfD1UYzx91I7nCRNKI
 /iOIguH20dH8WA7TdHuSgSqdYdBlNrW7YLBZaEhxU0abITLchpx7vLVyfNWZB23aJ8TW5n3
 Dc5wfcneZKY+JNcAlgYc2pgons3ptTOGHMBUGADpHHhaRtIH4xRwAsW5PH1lKxKUD6OquPX
 DLlBTK7KdNuYVtjrYpkIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BXDpE5Jmrbs=:k7cc7cYfbwCN7zohL2BH/N
 iXzr786iEzrU8OQmrkMDKU3cA52R5+g78LoIb7Jl9Gf4aFFBgKSy2xvA2yGEmytvSEh7atAA3
 hO1R7fuSyyEfykEz57R5xUeZ057cIGU2tWxqgKrPUQIKYT7sVvVrlCLlorE9Z8gylEm7xkBrD
 q14xQSsghmhvfjhPxPLXV2W8C1y+gci6gt8CgaNRxRZ+c5NTXyCuhGKjq/8AWQhdWMOF/rMkZ
 doS2wOMzLd0rQpArMsl7Y5fbRPN/aHZbcAib2x0/wOwtoSh1BZHrinEh9u28dEiVuYHpP/FCm
 n/YQ5fOUpzJKGGpy++pj6WZ/E3shFJHhYcTz3Pk25zOs30KJ3AcEIvML7TOv0TGu1Ftut/VmG
 X7Q6IjjfBc9KXbT5Dd07nHC24fE5ZGLYw1qXZm8TBZ7a9BiCEzgJ/UVxmXT1tWCE9sQZthTRI
 Tvk9p0+YX2x2QwKMkzyftz9GEcpyqdeovcPcdKpgXudjoOK2Iw9lVr3g+++OemZA4fgIZH2gM
 RMkhlUlD5yCyh+27zRdA5nx47ngLsCLAMGwAQfzHpY+RBWuDza37MRvojvnfQVWq9xzh850qa
 E97XJN+CfMNrxpIV3kFd73L4z0NYwQcEsCBht0aIerYTPLYL7yFeZxKW7aHHXmIro2DvlfwTK
 oFzwEr9kVXMeZKEWFTkhUza4qdarR7P8XVFYkNTCnO9pEfVzwRRwQB8wU/mi3085SrR64Xtzv
 HqOqHp9em33p3E609nnPUbdwkhK7NXbREKArSZy4TCEX9A6e9BChXdpX2LxT6yBORdKyKxFsz
 aguywoKY071o4VUa9cHQ9jIHZEoNuhKC7aS01uoMczr9fjaAvBI/JRjH3pH3nN19zy8x/KAQE
 BkfLsFxRNQ0uk3WL7Xxug3sDHnchBuAs4YZkMQpR0Pk7n7tA8DbPdZs0rF4PvG4DBx6T4cIF3
 JPfULpgDDEYAWTMowTUZdQZAt6kKDW4cOxSih9KFz1MOpPuTY8x8xMdgcKmvAw6YE2Q/mSh0H
 v00v4j/ChlD65sX5QRlagQKrO+XI9+B4YWFk5jLfTwPND0+3EaurNSxHKAwIDqwsNLYcjvbxr
 aG6itK190HwKaGi84sRBDEVqroEjUzUdnY+buWpQAm760d+OwWDAJPCRYrAkb6zvzUA45fnX3
 6+XB4sKGIx7r8AhYTC6v8ICqQueF0amOnTpYKkFzp/zrAbMSkk7KZWVAMDn3C4XrRBIT5hU0V
 kPbSz/TpR/dlPdhDAaLL9ogp2Lbz5Xbbp/4cwag==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AHF7IB0SiSccyFX545YRWYZ3SwzB6kL4y
Content-Type: multipart/mixed; boundary="Dazns3j9JbH49cuMN2q4Jkpz4uJVGjPD9"

--Dazns3j9JbH49cuMN2q4Jkpz4uJVGjPD9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/31 =E4=B8=8B=E5=8D=8810:08, David Sterba wrote:
> On Fri, Jul 31, 2020 at 07:29:11PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *de=
vice, u64 new_size)
>>  	}
>> =20
>>  	mutex_lock(&fs_info->chunk_mutex);
>> +	/*
>> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
>> +	 * current device boundary.
>> +	 * This shouldn't fail, as alloc_state should only utilize those two=

>> +	 * bits, thus we shouldn't alloc new memory for clearing the status.=

>=20
> If this fails or not depends on implementation details of
> clear_extent_bits and this comment will get out of sync eventually, so =
I
> don't think it should be that specific.
>=20
> If the new_size is somewhere in the middle of an existing state, it'll
> need to be split anyway, no?

Nope. Because in alloc_state we only have two bits utilized,
CHUNK_TRIMMED and CHUNK_ALLOCATED.

Thus what we're doing is to clear all utilized bits.

>=20
> alloc_state |-----+++++|
> clear             |------------------------- ... (u64)-1|
>=20
> So we'd need to keep the state "-" and unset bits only from "+", and
> this will require a split.

In this case, we would only reduce the the size of the existing status,
or just remove it completely.

>=20
> But I still have doubts about just clearing the range, why are there an=
y
> device->alloc_state entries at all after device is shrunk?

Because the alloc_state is mostly only utilized by trim facility, thus
existing functions won't bother clearing/setting it.

In this particular case, previous fstrim run would set the CHUNK_TRIMMED
bit for all unallocated range (except the super reserve).
Then shrink doesn't clear the exceed range, and cause problem.

Thus clearing the bit in btrfs_shrink_device() makes sense.

> Using
> clear_extent_bits here is not wrong if we look at the end result of
> clearing the range, but otherwise it leaves some state information
> and allocated memory behind.
>=20
Not that complex case, just plain not fully considered corner case.

Thanks,
Qu


--Dazns3j9JbH49cuMN2q4Jkpz4uJVGjPD9--

--AHF7IB0SiSccyFX545YRWYZ3SwzB6kL4y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8kqr4ACgkQwj2R86El
/qjf0Qf/bKIWTzRIMbAPU4twJsHd4HRXEZSlasxNMW/e4hnYlN4RuvRVZayDRx/Z
6Yvyp7paJL1c65sVAxKyP9aHCR+xzx0Cb9Uqr6zh63r1EUKTc+aahQysSN2WZDAb
Ei6kan/7SOlJYk1sCdiPza73ZrY2m+iCLuGiiXbAEtcq3STCtaDtawqevNmyZGTy
qXJSDEY8L7nth3ehdyhMyl/OwSOFGHKGwYzmI9Tk217xjhBkTEZcvHP+7UausYnv
fGYZMgWBV55YV8TM8fIofylloKRjNxnnMJXnF8xiFemTS59lZ6dhYiMcu/qgv8yV
uwYeDs8TJoJ5ta+rKeJf3+Iiwj27tw==
=X8es
-----END PGP SIGNATURE-----

--AHF7IB0SiSccyFX545YRWYZ3SwzB6kL4y--
