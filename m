Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED11FDEDA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfJUNei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:34:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:37887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfJUNeh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571664873;
        bh=8obCMVdLFO3ZnZF+9i4c5M+dvUuVwqxTA35ZnfAHe68=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j81O7vhV9un8cqqGpkzzo7vKlA587CEUpbA3qAqatAJ9KB+g/deIeZzR18FLGSDso
         SbtMEUKJeG4lV125qoI20bPdtBVuMwjS6moKcfvu8m+WW2X9QSAG9d1/T1zROC08Y9
         vPP0kk7qn2KoX26k98UZ8G3uAm6026RVPNToy5W0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSc1L-1iSuWk3Qnx-00SuiI; Mon, 21
 Oct 2019 15:34:32 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
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
Message-ID: <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
Date:   Mon, 21 Oct 2019 21:34:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gNWtnVtl9xHqq5x0fVG8rbEchigl5tUH7"
X-Provags-ID: V03:K1:hWb640jL/KqliIJtEkafaB2nt9TR83E1+VyGtWThK6iN2i0vgSo
 hLjRDRGPnVVrBSAJzhMMgQjjIyk/JesKqYAds3+lBdTSo1CmYennc11YDyvJhkKTxW0Tu5z
 a8RhCftKa4bW6QRVZjZkEHo/koFBOGreXL4NxCQlWw7zmtSPtVQvKqWn1KgZLqMnUziG0vs
 AqHyXTSLrZ6Hr2J05nBnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UzstWcaGX+k=:ybBnszhuaI0L5vWmhwvEZZ
 bc2NPFHm3MLo5MyJnMLh4FaZd0kHUlXavtUIk8jNRKBj9Ux+ea9yfL1XwJScboYVF0k7gWt7C
 X7hSpSe5jWOuoPQA6BxvBhCjMCT7bRwMzB+NxcgslN40dLWddCLpJwPWzPWXEx0+52kIfWF/c
 1aAvyIFkBqIhjPYLs/UacIg5iZYhLUqrcRE5NRKA/mEGY3FYcf3FviqPsF4/T/jhLB+1l+V1w
 EnWRPPn6Ow4JatTm7W+gk9IU47el8rCcPJj7gqh0/APbPgIQvcbp7OWJDtvJkmuNdDKL+IAyx
 kk1JhTb8qhnmyJGdoH1KSzVSfLHsdcBAkIO0CUZ6li2GXFFwPoWgCg0FJXT0Pzmfn7RrdstVC
 JDK7CT3RA9zfyYtmocf5ZDdZ6zckcxPZz225I+hkZVt8lmbRbAqJHGjphEDS1X35H/vbgjZ01
 oY8mLJ2edKmWyta6DxCrON3D9PTi1KOithkC/zCiidWqLu4gd3UY4+aEwlHcO0NGfZQrxA5jj
 xY//NsEQizn0Ut7Y0SnAcUbKjKVdU9Vu6fec3VZ48i8wjfQyFUCdaEH0YM2hatnk18filuZxv
 UcycbPT5jsP4evXgl0reeDiLMyX+wbuBbcrYPwC8R4ACYhorIfXdtU5bhAJ9j9pf0uH+ACBvy
 AUrPF1p+yr25QNb0mEwrU4wRGxjaf3UNK9p4Pn4wkypwCXf3EzsRhX1VXvzGKroWhY/53N4ea
 CbkDc7LczJ07/y3cTUt6OxRZBzyUjLUc+zgMvX1LKMzkHt/55SvV+jsb4hK/l0tp0R2mx+Uhy
 uhUlG+ZYY67yXHUckp9sf2JKOdfAfNSoZVbeaMGFiFrgBdC36OQTUswX32gmwjb0Eep+9EPid
 BcrmaeHbl8EFkm9bPe0/OTlBAvOqy+p6wYZXW5TWOEXUYIlUzAFxPQAMrsl3HbjAIlJchUSWD
 42Mmux4SHZg3j4szbR8zSt4hRIN4WCphilvt60RNvxFuDUcEgJ/z3Ugq8EzV+TX8rfF5KDpwx
 wGHd5HoQmpPW1FLgENMKzdN0CVQfLKgUB8LU3LJxEfFemwQFB1wNGxXJdCl7ndp7LGwE+LRd3
 u9rUUdrmN61OgTtL8b/aRNP/j82kto76d1jiGXOcjDYtyxE+lfJbmDtEoKf/RJnAZSyjga3sT
 X20CG7IW3y9JWSoiT4uXG6fsS4iFXaIBEjc9yS5HKHb4X29uYV4sviwxUgzjx7SpKx6vTLQOs
 gvxT75lNHKjB3F9i/140e4M+QJOKwh36jor3vyJbYM4sXMcn2+4ZiBV738Xg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gNWtnVtl9xHqq5x0fVG8rbEchigl5tUH7
Content-Type: multipart/mixed; boundary="VU502PpcPrOWAdktla13ILWbqhZ7Jpb0U"

--VU502PpcPrOWAdktla13ILWbqhZ7Jpb0U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/21 =E4=B8=8B=E5=8D=889:02, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
>=20
> Am Mo., 21. Okt. 2019 um 13:47 Uhr schrieb Austin S. Hemmelgarn
> <ahferroin7@gmail.com>:
>> I've [worked with fs clones] like this dozens of times on single-devic=
e volumes with exactly zero issues.
>=20
> Thank you, I have taken precautions, but it does seem to work fine.
>=20
>> There are actually two possible ways I can think of a buggy GPU driver=
 causing this type of issue: [snip]
>=20
> Interesting and plausible, but ...
>=20
>> Your best option for mitigation [...] is to ensure that your hardware =
has an IOMMU [...] and ensure it's enabled in firmware.
>=20
> It has and it is. (The machine's been specced so GPU pass-through is
> an option, should it be required. I haven't gotten around to setting
> that up yet, haven't even gotten a second GPU, but I have laid the
> groundwork, the IOMMU is enabled and, as far as one can tell from logs
> and such, working.)
>=20
>> However, there's also the possibility that you may have hardware issue=
s.
>=20
> Don't I know it ... The problem is, if there are hardware issues,
> that's the first I've seen of them, and while I didn't run torture
> tests, there was quite a lot of benchmarking when it was new. Needle
> in a haystack. Some memory testing can't hurt, I suppose. Any other
> ideas (for hardware testing)?
>=20
> Back on the topic of TRIM: I'm 99 % certain discard wasn't set on the
> mount (not by me, in any case), but I think Mint runs fstrim
> periodically by default.

Oh, that explains why only one root (the current generation one) is not
all zero.

Then it should be a false alert, just fstrim wiped some old tree blocks.
But maybe it's some unfortunate race, that fstrim trimmed some tree
blocks still in use.

This means, it's a bug of btrfs.
However I can't find a bug fix during v5.0..v5.3 related to trim.
(Only some v5.2 regression and its fixes)

So it may be a hidden bug.

> Just to be sure, should any form of TRIM be
> disabled?

Not exactly.

There are some thing that is completely safe to trim, the unallocated spa=
ce.
And there may be something tricky to trim, tree blocks. (the bug you hit)=


One good compromise is, only trim unallocated space.

Then you need to pass something parameter for fstrim.
Like -o 0 -l 1M.

Newer kernel would try to trim block groups in that range, and modern
btrfs has no block groups in that range, then fstrim will go trim all
unallocated space them.
So with that options, fstrim should be safe.


BTW, as you can found already, trimmed blocks can make recovery
trickier, as old tree blocks are just trimmed, no way to rely on trimmed
data.

> The only other idea I've got is Timeshift's hourly snapshots. (How)
> would btrfs deal with a crash during snapshot creation?

In theory, btrfs has transaction and tree block CoW to take care of
everything. So no matter when the crash happens, it should be safe.
But in real world, you know life is always hard...

>=20
>=20
> In other news, I've still not quite given up, mainly because the fs
> doesn't look all that broken. The output of btrfs inspect-internal
> dump-tree (incl. options), for instance, looks like gibberish to me of
> course, but it looks sane, doesn't spew warnings, doesn't error out or
> crash. Also plain btrfs check --init-extent-tree errored out, same
> with -s0, but with -s1 it's now chugging along. (BTW, is there a
> hierarchy among the super block slots, a best or newest one?)

As your corruption is only in extent tree.
With my patchset, you should be able to mount it, so it's not that
screwed up.

But extent tree update is really somehow trickier than I thought.

Thanks,
Qu

>=20
> Will keep you posted.
>=20
> Cheers,
> C.
>=20


--VU502PpcPrOWAdktla13ILWbqhZ7Jpb0U--

--gNWtnVtl9xHqq5x0fVG8rbEchigl5tUH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2ts+MACgkQwj2R86El
/qgBkwf/fhWZWTtz9lM6b/QuEPi9QLVVt5wOnIZG6/omjbaMRSIoh6tLrY6LOPCJ
Uy9PI3LyUB97pxmPTGVSKJnrDHA2kif7TsUQk/YmFO0InvzE1RLTsap2T6VMgdU1
DaP5dx889buJdOcNtrW8f5fXJncjQP8NSnx6nZr1Z1YWMmkK/Jj0zCEOHz/jChKm
LToK2+D7RXjpqy1sPzOwyG+h2yBgx8t5ABIcyhg6DEMicgLdryD4xsahzlTqCM0b
RsMeRbUHNvjInYWJODIIGROFUrPmqNVPulqu3bGdc1lWqFCi4eLWXj5w/m7JoBS4
OqH5T/ct3EGiM2arA6waQtXFTNMoKQ==
=X1G6
-----END PGP SIGNATURE-----

--gNWtnVtl9xHqq5x0fVG8rbEchigl5tUH7--
