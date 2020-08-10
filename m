Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6670C240466
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHJJ72 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 05:59:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:50343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJJ72 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 05:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597053565;
        bh=xE4PVdzaTW2EZ+LOzKhoFtI5E7NBFjkyZ/p47MC/X9U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VR6LczBjiaoNog/LoBixiRt3WjYwWqe/ZAyXScFFDo+FfK125R2RmJEwLenLppT2Y
         cozJn+Ed3T6ZeCUFaTz6UzdY06tBmGmksdq57l26DZH/pJJQnPoDRa9CMYETxz0JV1
         NxnsEHUYVN7qUo55c/wSZCQpfZJGdyTzymlF3pB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1kicVI05mz-014XBP; Mon, 10
 Aug 2020 11:59:25 +0200
Subject: Re: system hangs when running btrfs balance
To:     Johannes Rohr <jorohr@gmail.com>, linux-btrfs@vger.kernel.org
References: <c684e9ac-f28b-7056-0a46-6c6450ac4c1f@gmail.com>
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
Message-ID: <8a3370fd-7cda-78d2-b036-8350c5a3e964@gmx.com>
Date:   Mon, 10 Aug 2020 17:59:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c684e9ac-f28b-7056-0a46-6c6450ac4c1f@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XIs4Zaj7aO3Do8cvDdEBPvDMvxq5CtXWQ"
X-Provags-ID: V03:K1:7w7XtOySVcsyhBT96mt/3pbFrT0SX/jfILmAeEVr8A3CBSGo+YH
 5Cl2mvIiAoaV/lTXm1oG15MrXhixGmQ4C8Zr0+/MDPgtwTHn+w7RlNAWzFwAaYADYY7/Sto
 MUY8q1ztKcCGMNn4gIHLElJpcdL9CARHqvvwSm/6OhazQkQVAZul3U0/oZT+pAnOLRoWl+O
 My+KgjH0RiQu5LIaKbpxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QV9Ov4J+Bmo=:Mv3rAaLMhk2wLfOdU8bbO2
 B6RPxykuE7lTSlHaHya0n0jg4s7w7pVwZCXndOz/8ewnig83XwnkqAwol4W4QiSP/RTRhWHvW
 qfSGmelyQO65MMVMUUBkOZ6lVoWGtQNGDfGvvmWRWnZtp7leXSv2i5k+mRxcs+9RpQYMckPYw
 XQsDYNVC47AURiHz2PaIqdeE2AoxQ35yZyqFuu/XP9a/ID17Fkuvr8i6T/4BzvPyufdbM141l
 vaQhGbE89s/Sk6hjyxAqqdCC3fSGFwYTmcRjKZuL/P76FPyi1YR9VCpTxc3Wbn2w1yg0mU4hz
 f+7X5szBw+m0XrtHquY9yIfmRXK+x1Vfji4GkWOb9e9oHuJaSNiJXq+Jeap64prcLPE8Lun1B
 Bjs1nR3cH6CL/YASYJqF8jObLdKEFDKIMKzIlm6S5hop33lA3C5Nb7Ffh7KcbLlPDidnjfeXP
 CieyErSvZIlx8/bHSl56YMyUntRd2+7JMeMNI1mF19B7+U4fS9c7Pmak5a2QzkTNcNeUsHKNl
 1rlP6HhV92Jp5eNMP+LrusTIUTuCWvupR7tMNJ+yp2ob5xvsQLPsVUXW3ZyA18//Yw2ZtRMZa
 Q6Ncy/zjj4gCgcmClj2dMvle24zB0Fb4WA+kZNu/jZQiDQbXQ+8ggCrEFUM6MYKBuIoj9vNim
 Jf4EHKIBY/2Ch3YGa4e9wX4yganRv7w1I6N9D5/EEzGI8aVsHdQ4EM/7rRhEV1aEfOUYA7+R4
 0YODAlgDfYX/QLQU2ur9F4h0VwcCyfd5dw+TTAh8BVJxB5tTGRUeFW1u8YNvaMgqgmfFDdM9V
 4984KTg0vBwsGZn7rWWi3RCnZoW8zY0N2FaUVmkz4q5+39Y77/FX9Jbk7rv3eEEmVpoNFiewZ
 M6QId/thsEpG+clodvTezMTYdFXD4vljRJj7rwVDk5EAOTQC3KkEPUtQni9xgEFGenTmUfv4m
 KTdY8o0J5fkqPd3JKvIBwEpRqbmsy/CalChXYbLXFGFnGuNqg5nLtgBVDRJDw+/cHEvAT1kIW
 FnX2lXGKolosk7jX933LGO9NHddlz0hR4r8FcgGbdn216e/domzzfJllV/AwJqWpMOKarETTg
 EzdY1FTd5Msg8U+ovmlmBvPWuhQ8rTG7FGFwBZT+6MNKlIeAkNGQIxCNaIqrG4baO0buKRoD5
 eEsCjeraViq9iyJK5iK0V331GT2Oscc+8xoj93Zqh4Ebbbuu08BxVeOzss1FWpfZRsB6hk7rF
 MhVATCoeOjJraVQvy3s4pJMNNLxkME+sA8w/02w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XIs4Zaj7aO3Do8cvDdEBPvDMvxq5CtXWQ
Content-Type: multipart/mixed; boundary="xz8vKb9c12TnD9Vr27lc9FqYfLhICRmIN"

--xz8vKb9c12TnD9Vr27lc9FqYfLhICRmIN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/10 =E4=B8=8B=E5=8D=885:22, Johannes Rohr wrote:
> Dear devs,
>=20
> since I upgraded our system from Ubuntu 18.04 LTS to 20.04 LTS, the fil=
e
> system completely freezes when I run a btrfs balance on it. The only wa=
y
> to get a usable system for the time being is with the mount option
> "skip_balance".
>=20
> The server has a raid1 with 4 SSDs with 500 GB each.=20
> [Sun Aug  9 12:21:35 2020] CPU: 1 PID: 4537 Comm: btrfs-balance Tainted=
: G           O      5.4.47 #1

A quick git log glance shows that, some reloc tree related fixes haven't
landed in v5.4.47.

E.g. (commits are upstream commits, not stable tree commits)\

1dae7e0e58b484eaa43d530f211098fdeeb0f404 btrfs: reloc: clear
DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance
51415b6c1b117e223bc083e30af675cb5c5498f3 btrfs: reloc: fix reloc root
leak and NULL pointer dereference.

And above fixes only landed in v5.4.54, so I guess you have to update
your kernel anyway.

> There has been a related bug report at kernel.org for a year,
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203405 and I have found
> similar reports here and there, some pertaining to quite old kernel
> versions, but we have only been hit with kernel 5.4. After this first
> occurred, I had no better luck though, with older kernels (4 something
> from Debian buster, also 4 something from Ubuntu 18.04).

Nope, the mentioned one is another bug, we had some clue on this, but
need some time to solve it.
(It's mostly related to some special timing in canceling, leading to
parted dropped trees).

>=20
> Apart from fixing the underlying issue, would there be any wordaround
> for it?

Update your kernel to at least v5.4.54, then mount with skip_balance and
finally  "btrfs balance cancel <mnt>".
After that, doing whatever you like should be fine.

I prefer to do a btrfs check on the unmounted or at least ro mounted fs
to ensure your fs is sane in the first place.

Thanks,
Qu

> Currently the balance for the fs is in suspended status. Since
> there is quite a few people who depend on this server, I can't just pla=
y
> around with it at random. That's why I am asking for advice here...
>=20
> Thanks so much for any suggestions you might have!
>=20
> Johannes
>=20


--xz8vKb9c12TnD9Vr27lc9FqYfLhICRmIN--

--XIs4Zaj7aO3Do8cvDdEBPvDMvxq5CtXWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8xGnoACgkQwj2R86El
/qjyYggAq66Cm2jw6cJXk7PNT9tG4rmMM8zfOExHzNqqSy8pUc668qjgfXyH+UFH
O9YreQ4biYLywW6ZO8/yIeVq+UxQJUJO2d3RgJBaXNLr7PS2hXRpH2hHjZy6z1yy
JhEqhgJtm81yn9oTTRci0mWXhe3BRHOqjzra8+gzMVjYk6+uos90ApbqjgyaYbF8
dbeYbaq95GMm5YxInc/8YB1DAR/DWwdAW9u7304DZFb4ikmcN+dIOdvttlpBQIpL
ElTSgXKfGsLHCL/zP/QtBM+AMoJlofps8Bm8mr6Vjv3QwYw7PyYr+TpDg6na4QRU
OajYwBG2bGWXyL2uXauWFX0lPLabxg==
=mH0O
-----END PGP SIGNATURE-----

--XIs4Zaj7aO3Do8cvDdEBPvDMvxq5CtXWQ--
