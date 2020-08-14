Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B238324428E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHNAqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:46:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:35345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHNAqs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597366006;
        bh=4ZOU9uT4U1nH2U6c4K+Km+vqqaU6Gw/5q8U4GaKZUqE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c69vL6RadCWz9AqOgJPy7I4Chckk4vE2ACiu+vWNDV3g+8+gR2CUvPOEWbZFFPbsQ
         kTK1vCeVh8+Z9vZUqoW8emQ/q1SnvBtjMHYa5eZSiW5jR5N4nhlqqgGx/brgNlju5N
         2axVKAO3UOuSlrEZBleckVLZkTXAYvGupFpgVMk4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1kAAvT2sB4-00WVL7; Fri, 14
 Aug 2020 02:46:46 +0200
Subject: Re: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <004201d670c9$c69b9230$53d2b690$@gmx.net>
 <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
 <000801d670fd$bb2f62d0$318e2870$@gmx.net>
 <940c43d7-b7e0-82fa-d5a5-b81e672b85a9@gmx.com>
 <003301d671a8$b93b8b60$2bb2a220$@gmx.net>
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
Message-ID: <21a68d42-b5b2-fd74-d0ac-f59a288231e8@gmx.com>
Date:   Fri, 14 Aug 2020 08:46:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <003301d671a8$b93b8b60$2bb2a220$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wVPggP5Cy4iFC6QdV0xSJn4uexhn8wt90"
X-Provags-ID: V03:K1:6j0dqnmWAaEIugN+s8Fxs8qJ6t45zA/yl0I07VMdDNHGt9vWd03
 JnNqLBZeT6IIRGlbixpwVItFRZ++8vtfC9u1xXpkY/+vD6JVWXi3JfZIApvF6mmZq3m1P/x
 mXKj0cnLFc5tVY6vvrP7TX+X9acsQcQPqspuoEnSU7EYj7ICg1GvWq38iH8Urn91Zz+GtLu
 jalJC5yT+aixoyP0MVpug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZXrmqEwQA1E=:w+a6O1jTtgMUBtbX50VSeE
 qsr8Z65VBgOOn4YUGn6JtiPu/i30AXvx84yfuaXv1bc/WMy6eT33xbsgGEXMTXoOoTVG1LMVP
 LFwq1qhyJg2pTCHRbM+avbE8+ulhct5WABRGjXwh3aqlWdKLc+lW53TxAuSw43joJWVEkhUF+
 cLMApF1HyPwSBrD/H798F5bVZQz/treyBbUEGTIonCwK3/eCWicBIpopzKEwTGLB4BargbGev
 OzMnmk+6ytpxgGs1PV93M3sAswmQrKv1Zo0B6rH3k2Qa8CILoIToHRJTQrzSHQVS7Z9m7EN7+
 UVNvGUwH+D81o+7Q5/q8i/0D+ggjoxqW2edY0D0doJIjzGGyXvwEXcaCYGHXoaF94gZInlbtQ
 5EOCcMRSM8HitLnSxr0qF08VO4hF40HQHX2Oz7uol+kELS7dDByAtjhsyVrGHWzQH04lIy8nt
 Mh7x4MOGERHuCRqZ50lmprd9o9B+5ygDLD7fxFL4oFel1wD3T6OC9D+4qeuGHCte4S+M3kzXG
 0vXv4GXU2VBo+xPTYgOjeooHODHTbxX6D5N0f898fTFqWwtRhDu/dL7au0G7awy1c0HUqwEye
 xn0deX+fEuatacM/2pEK6yOyn+5EJ6b/lwK7nfOsHBG2tju14tX6XugAXGqWqtzrzoqkGnkmj
 y7NntdZ4+StSey3eQqnTzJUyqflBCBlwwmgDtr1sBzxIMyxZRYsJkvVo9Vmb7V/cWrc8VQYKI
 ldp2EhhNBwHf1zxib/LDK0t8K37ZxPxRRDA3d/w1NmGEAozrtdDPxQp5Y4zL6u9rEV++zDHTK
 fP3mm5YdBAIT6XA6nUfqgoRch037p/ZyujFX920KthBevApA2lqk6E7z9CTpRHttP8UhaWeDy
 KBZWzbmAWcMAWRNmEJD9hWrEHfSI36ZA0PsKCDBpB1umdRiUpFB8E4J4YVicLPxI1jIP45Po6
 whPauaQgG8vuwV0jmkG/QCrGFadQA3flInyfjKxOmA+QdJLmZhs+UahV5s16yuUpMa+u2hSzE
 eIAU53Vtg9JGQBy1RJMae+IEOIaLnIcfM2Ji2UoA17yCoQ9cWOlW+XAxivshFTy8rN8j2thTg
 zjxsLy49ClRGv3hqUZTV4nC1RyOTTAp7b5lSf25mEExK2JrDEAHTLhZkYdiTqLn1mI2Y/wj1F
 92Rcf2FA6f+NoZQVrrH31z5LS3y3nD+N8NUqmC7FYHTNFeA1455zsfogFM98JWlc9l7oMTrfF
 cx/3fFd04NdLcyUT1K7weVRT98SUGAjpA8TEVNg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wVPggP5Cy4iFC6QdV0xSJn4uexhn8wt90
Content-Type: multipart/mixed; boundary="Gc5GNIhKgaYm3XcJA2Z0EkKkKZ93Zrb7t"

--Gc5GNIhKgaYm3XcJA2Z0EkKkKZ93Zrb7t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/14 =E4=B8=8A=E5=8D=883:34, benjamin.haendel@gmx.net wrote:
> Hi Qu,
>=20
> thanks for your help and support, but it is still not clear to me how t=
o download and compile that branch.
> The newest Version that i can find under releases is from "10 Dec 2014 =
v3.18-rc1 =E2=80=A6 1519ee3  zip  tar.gz"

You need to grab it using git, and grab that specific branch, not
downing the zip.

>=20
> Also if i finally do understand how to download it am i correct to assu=
me, that i will need to remove current btrfs-progs 5.7
> And install the branch here instead ?

You can compile the branch, and just run that built btrfs without
installing.

But considering the skills needed, I recommend you go the send method.

Just boot using the last working kernel, send out the stream.
Then re-make the fs using latest kernel, and receive the stream.

Or, you can wait your distro to ship v5.9 btrfs-progs (maybe months
away), meanwhile you can still use your older kernel without any problem.=


Thanks,
Qu

>=20
> Best Regards,
> Ben
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Gesendet: Donnerstag, 13. August 2020 01:30
> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
> Betreff: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>=20
>=20
>=20
> On 2020/8/13 =E4=B8=8A=E5=8D=887:10, benjamin.haendel@gmx.net wrote:
>> Hi Qu,
>>
>> thanks for your reply, i am not sure what to do from here on.
>> What do i have to download from here or compile/make/install etc. ?
>=20
> You need to compile that branch.
>=20
> For how to compile, please check the README.md.
>=20
>=20
>>
>> I'm no total idiot but i still don't understand what i have to get And=
=20
>> how to apply it...sorry :(
>=20
> Or you can use btrfs-send to send out the content of your fs with older=
 kernel, and create a new fs using newer kernel, then receive the stream.=

>=20
> The uninitialized data is only in extent tree, which won't be sent with=
 the stream, by receiving it with newer kernel, you won't lose anything.
>=20
> Thanks,
> Qu=20
>=20
>=20


--Gc5GNIhKgaYm3XcJA2Z0EkKkKZ93Zrb7t--

--wVPggP5Cy4iFC6QdV0xSJn4uexhn8wt90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl813vMACgkQwj2R86El
/qh1/wf7B5Ta0jHt/qZhbchDMvqlEgHmmEeDdqoFA9GOG/MCDikN1IN/DVNw+WId
WjCUk77eBe/IrqI9cP8fSpcJOAHfyI4SIG33Wky36pISY1E+iqgYyRi2SSFuFPyW
sla3M6R+j6SpUMcijxUS1/F0m+w7lFIT0pX8sarpATCVnd55ocA9Y+M2JRNiWU8Z
mqav7BtFyWG9yQR0h4CFDz3a4jh9sRg66A0yUZDT/XWWo8MJXJ2ol4TOLXnejdhx
hFHc0ZQKT+CMIbCq9f/cFAPvRPnU1e8jQEID3a0JSiBNob5N0qBQZzW1phszkS/9
HVRYHbwrHbNJityE0KDwRbKIBaYoHA==
=1O/j
-----END PGP SIGNATURE-----

--wVPggP5Cy4iFC6QdV0xSJn4uexhn8wt90--
