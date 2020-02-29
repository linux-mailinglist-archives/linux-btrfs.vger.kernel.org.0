Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF02F17440C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Feb 2020 02:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB2BAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 20:00:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:50563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgB2BAy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 20:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582938047;
        bh=kGO/1ONakhlDBocsHdhfmEzBHghkOZHBJFn/qsRLTf4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PBuZ6Og9yGmKBxCclu/mM6MTqNw5hXOKX26JW69BmFfryD64LcvMEQhQcYX5OXbp9
         cNFnI4E9Rg4wXlulaNlPrlJExGo6y60ggKYl9xTMYJ5lUaCVCKn+T579Y/Gjj52MXy
         cnIdDM3rFuLL61resp7R8gb3f/Bn/VEuEAwKOOtY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYc0-1jp7ej0aL8-00m65s; Sat, 29
 Feb 2020 02:00:47 +0100
Subject: Re: [PATCH 00/10] btrfs: relocation: Refactor build_backref_tree()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200226055652.24857-1-wqu@suse.com>
 <20200228154555.GN2902@twin.jikos.cz>
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
Message-ID: <99a7a002-65bb-6077-7303-c4076c34e05e@gmx.com>
Date:   Sat, 29 Feb 2020 09:00:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228154555.GN2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HQM6ZNz83BnpBvBfN5Jbt2cmZ0Wdgh8Kf"
X-Provags-ID: V03:K1:neC5QzjrEtP8div4zP1QxHWKDlJzfBEc9Mbr7Pyi9vzyF81woIt
 5dt4LBMunGCwXNwwE/UgxSlxoWVu0RIbOV+zffXPIQ3cXxQ9l4vyw5rs9ZiJoudVhpTyzQl
 rML8heMaXhC9QX+VshfaTwuXiM8xPJJKwfDdJ6oOJfmHIsaG2AAgcTer+n3XDxptiN6HEEg
 FC2UjMLJom8+2XsbnHLaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uTFirtzJU+U=:V636x/pdse0j7LuCLzqo+S
 wy3imAX1tsPiKW/bznYlm0D8+Eo5KZCgheE4gqpJFBoqKRSKpBQkyNdo17KR7UsZniE8wbM7q
 +9I1envvX1KOxVZMaV6XbC0g/c9z3dOQj8Zzms3KRWi173PPZGTA2+Xx3wmRvCkoHp+yz4XXZ
 mgRayTb93oKUv1SpHMdj9yCygs0v1Q5TqjFNlG5AcSL2siUJX30OG3np9x9+kUbHGRTZhNHPB
 W33A2joSI3qpBtxhZO8a6NRXtLqSHvdfaH8zispKJPBITSn1uuyZTPXHYQqFuNaCtjkGLq1ux
 tpj6RkIymkoIUzewunhCMF8RAZmxyEeJMiOONcPgt85HmLy79gRqJHQZzGYsX0X0RMVLxYEoH
 qtTM9Xm694LA1q7HZIt/K1h0j6Yh+5b1N8SzR4giv7fWum8QbkhhaQifYuL13RdVyJh1yOJWs
 v75JbI+b/gaJTYCZCrF2CWtnSuETYhUn0zoiSXO+4ZLPSomoLGrwZzSWu8u9n+sgRyDmYLMI+
 fAYAD5m37UbloFQivILra6WF1+bR9+EV/urK0A4eNV7Amo7uqdaVaLVVLEI/uuFwx0j2qh1c+
 UMqa/tzoiTfWdkiYCf+iGOoxD5j+602gODSrsV8UXF8f/X7t1wS5dbCYle2HDyr7+DsYEm86b
 /Dd3FbXVzw90U7osKWROJAqsSCy4AGFHca2733JM9l4H7J8PqzhFEcDc97gc1xnijGKzfoXXP
 XBfAaIm0+AtlYVD2H9JCCV95sp5FBXNLJZRoBnU8TmDtLl1lQa5dGrqbyFC9N5ntyhjdWRINS
 ecucZyh8fnsDceaT2Ejse5NKGR82mQMBtySxsI0bGS4wVaiwUE/YQ5hPtpu/MXiTiChBd4W5B
 LR8YCqFE8tDchC8KzPUqUr0x9op6GFZrIa8xDgZwaNFKKXJ/LIeLGDwxKjvJgWdsp3QppiSE2
 +FDjSp5SJHzWBn252hRZnSyqtYX/4uzj6LcDU4TC8UBKO4E4bbpcmlrqN4PC0GC2lLXuDsWsm
 QNiGh6t5Ip/R9GQrAmk3R2YtG9rurhvgwY/HRHlTtRkHqZ9nuLcLsJdBCZtNst8ewRYeezoi9
 Y/jsZT9g3RNPikdwXbykMthjfFDUNN8fu6VjTZvih8UpaWTvChUxcSSsWD7npQHPH8vtKcBIi
 Bk3DWgdQAYj285OMO5kJA5MXU/rQ9apeq7A3wXgBrZ5SIzpnJp/5oMyQpbFdpEw4tGlAJgCYH
 eS2ndFvb1BA+N1xdk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HQM6ZNz83BnpBvBfN5Jbt2cmZ0Wdgh8Kf
Content-Type: multipart/mixed; boundary="eOZ1y763YswufvwXZupO7oGWOZdPQa4ja"

--eOZ1y763YswufvwXZupO7oGWOZdPQa4ja
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8B=E5=8D=8811:45, David Sterba wrote:
> On Wed, Feb 26, 2020 at 01:56:42PM +0800, Qu Wenruo wrote:
>> This branch can be fetched from github:
>> https://github.com/adam900710/linux/tree/backref_cache_new
>=20
> This is based on v5.6-rc1, you should base on something more recent.
> There are many non-trivial conflicts at patch 5 so I stopped there but
> if you and I like to get the pathes merged, the branch needs to be in a=

> state where it's not that hard to apply the patches.

Because it looks like current misc-next is not a good place to do proper
testing, and it's undergoing frequent updates.

Thus I choose the latest rc when I started the development.

Currently the branch is only for review and my local testing, I just
want to make sure that everything works fine before rebasing them to
misc-next.

Anyway, next time I'll mention the basis, and explicitly shows that I'll
do the rebase (and retest) if you want to try merge.

Thanks,
Qu

>=20
> Minor conflicts are expected, like obvious differences in context or
> renames, there are tools that can deal with that automatically (I use
> wiggle).
>=20
> The branch also contains unrelated patches to the backref code, some of=

> them either upstream or in misc-next. All of that makes it unnecessaril=
y
> hard to get the patches to for-next when the time comes (reviews, patch=

> backlog processed).
>=20


--eOZ1y763YswufvwXZupO7oGWOZdPQa4ja--

--HQM6ZNz83BnpBvBfN5Jbt2cmZ0Wdgh8Kf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Zt7sACgkQwj2R86El
/qixBwf6AxD1CdaDG7+ZgJGbNEvBn/Me5JJqNjSsF2zuI4hsupZTs22hfY7kRaZ7
2thl0PjybVkG7i8Gts6qCEi27gjYwQYJdPuaf2wopB00zbQ/dN250uBJryoqPm9/
eSGzDEUUel3o13qcjOnLCqP/uZBqz6grbfiLmJ1Zv2HHbiqVgWgkEi1ws+WXkvAW
vvW2GxbmN2a4Wu0jgQU00Z+1IhPhBGWZlbuh8RCWpmFjDf6rlCMJ2RdMqFlt4RPo
0giftlIg4hpk8yjUqyvyxIJ9aRfcaMqW2Pu+49/BVnVOIHbbmPv8fkuV6lmuo3CF
I6vovCAw7Irl2xRXm506MumEvbJetg==
=kZ8z
-----END PGP SIGNATURE-----

--HQM6ZNz83BnpBvBfN5Jbt2cmZ0Wdgh8Kf--
