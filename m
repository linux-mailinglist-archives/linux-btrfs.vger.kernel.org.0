Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9A896AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 07:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfHLFUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 01:20:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:36905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfHLFUI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 01:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565587205;
        bh=q7IwCwBW/K/jdukMR/Iy3esC7vm3UwH3BOr5eJ05Lpc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZvMUAX7b/srKGBqChjuu2T9xHq+DdXXBSSKUKItZt5EIKBc0r30M7YPC4MuLA/3Kd
         qwJn9X/fw6CtoRl2+ueJB3ZYG7eJBAjPiNnbyxr7+0EsNm4spWKlE/ksE7Vbq+myeM
         6KPCSlVN5Nl9uc9Eq4W96fHgm+Mk/VAyhTH81Qdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1hvvlA2kUm-007k5Y; Mon, 12
 Aug 2019 07:20:05 +0200
Subject: Re: WARNING: fs/btrfs/extent-tree.c:6974
 __btrfs_free_extent.isra.0.cold
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRCgyhECZqFndqai2TTu-2k2ww_eiwn3Xpy0eU09GM5Mg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <a35f3069-6bbd-08ab-c200-39463a03a1fb@gmx.com>
Date:   Mon, 12 Aug 2019 13:20:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRCgyhECZqFndqai2TTu-2k2ww_eiwn3Xpy0eU09GM5Mg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IUGIOQ3xRchsJgNPFU0LuSDlT5jY29AEl"
X-Provags-ID: V03:K1:wUAejYUXqjgdRUv9gEGzAt6ZPceQvclYC4wHYyE9a+h3otH4Ll1
 JB7jA30mYBHA9YDkf7isFuIYU9b3xlMB9QNv5OUqq35UAlGvaNqk/iUnBcgzWv8+S0BS4zm
 CYCtaveyPn8ngoP8k2h3Qi/43bXhlq789hGhFgU9jsv5479uoDTMLVF+HC28sVRSxj4bBBm
 4B1wyqivP6cPjObqD5oNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0dLwcwpk8U=:NNRLawUGbrQF4MafLfLX40
 H+Uei6yR5+AnBJylzImLFT4tuFFD1PJFyLW6Ma3A7QlBgR/1MOYu6cWajpcNGkrszwIfI2cNN
 L1CiDqhrc3p1isk0rYp90qiKxBbIK5Gxq8AAbsNjPowf3VQj9A27ygYLrRPTVudobBsxZzoUD
 BgilFsxak0PCNM8ABB/dB9+G1QDJNl9GH6MIAWbf1qHPc20uR0NeI+t8QZD3sumh7DRp23BKH
 g3OeKY227FIitNwXRPpesptnWNMV76zIOTMHf1RtFsaJyphXl0BnDmhTUfV7orz4NSXJOtNXC
 umDf9RIJzVFwbcecwUm6lLzUXOEZHalfsVPcrY2g468jIwckzHsO9ja0RU3LGoHVRIrdP587e
 ZQyPxzKBo/TXPAf1+gzM2xMje0RMRr67CSGkX46sXjpwl0wC5Wxd1ZaSpLAoJmWo2JYsRbTou
 A8hXz9dVGI72qYvSgmW7SUdTTiSqLEX/AVGaCFvmWgFyV/Vpe5HFbgKrCWP1iKrFWOA0pTvCA
 unpMRFQYjpbAZRF9knDEfmgK3uhyRmvlk+UndGnJuZ/miqiFuH4/cjoCL8ETdOKvySDQPJDLT
 ohqhzmVA3JO+6h1kdbiIAneU0tAouC3yQkTI1HEMUzvW1WWeSZ6KaqYLKvLDk8z+APooRDdj1
 qZm9xBEGM66dTkDo9JEnyI8z35QZyVSpltCWivtscKqRuaVkK78gmOgPy05hDwh2dhlLpXYo5
 NosZxuLlckfrHY/4hIbS82aeF9ypFAG8j3p24ZftqgOh2EjD9KP9CRo2t5kEWc2EyVYwN24IW
 tcqvJHJ0Dbgft99wz+ITY3lwxgqmwtowh/cOr4PaJwt+3RPQc6NIOjgILJrPwE9WW2wToZzyJ
 x+vqcKSvF0hMzn0mLfVKZ1BBymTM+2oKllK/6/DHSEUbnrWN/lNgxsD7fhCDMkRUTutRVaZBh
 O46DTDGg5R3zRmSXlKIb233kygPA178KNblGAbTmcA7+3AzCN5UInJs2+IOLlxAKqqlVspSeY
 BwS03TN11cRUIPw0fchE+EGahpYYygDY3oajIGwSYjv8jQL9+Dtf8w9bM50TmfPSz9bFzNo8P
 SG1v7OdgQYBl/idqxRUMRwA/WyYwwvqcsC8CTPXHy4AfUvt/6CMuv/Kgg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IUGIOQ3xRchsJgNPFU0LuSDlT5jY29AEl
Content-Type: multipart/mixed; boundary="9OrQfPiKhleovYuc15IjSgmdXZ7dtfhjC";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <a35f3069-6bbd-08ab-c200-39463a03a1fb@gmx.com>
Subject: Re: WARNING: fs/btrfs/extent-tree.c:6974
 __btrfs_free_extent.isra.0.cold
References: <CAJCQCtRCgyhECZqFndqai2TTu-2k2ww_eiwn3Xpy0eU09GM5Mg@mail.gmail.com>
In-Reply-To: <CAJCQCtRCgyhECZqFndqai2TTu-2k2ww_eiwn3Xpy0eU09GM5Mg@mail.gmail.com>

--9OrQfPiKhleovYuc15IjSgmdXZ7dtfhjC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/12 =E4=B8=8B=E5=8D=881:00, Chris Murphy wrote:
> Filed bug here
> https://bugzilla.kernel.org/show_bug.cgi?id=3D204557

Exactly the WARN_ON()/BUG_ON()s I'm going to kill in this patch:

https://patchwork.kernel.org/patch/11038303/

So hopefully in 5.3/5.4 release, it will be a more developer-friendly
output.
(But still not user-friendly)
>=20
> kernel 5.2.8
> progs  5.2.1
>=20
> I'm getting a kernel warning, and tainted kernel following 'btrfs
> scrub start' on a file system that was previously corrupted during
> failure to clear v1 cache.
>=20
> It's valid to complain about a problem with the file system that can't
> be fixed. But for the scrub to abort and also taint the kernel sounds
> like a bug?
>=20
Corruption in extent tree is a serious problem, it could easily screw
btrfs CoW, so we *must* abort transaction when we find anything wrong on
extent tree.
(Ironically, most corruption happens in extent tree).

For the warning part, it is going to be fixed.

Thanks,
Qu


--9OrQfPiKhleovYuc15IjSgmdXZ7dtfhjC--

--IUGIOQ3xRchsJgNPFU0LuSDlT5jY29AEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1Q9wEACgkQwj2R86El
/qgYawgAlSQoohmkSXWm20tzqyoKI8mtl3pQIojVtK0hRXnj/SMHb+Rw8pjPUZJn
ADTfAea+MEJWn4tvIuiVpb78aWWC8PknK0L0UHUA4vvXsl3M0++qVzLdRhVkVvxJ
9u/D8cIqngUIUJJpnpWH7JB3OD5R5BK7eenBLdAmSLXlQwTJiGQimB/9KqEEdxSo
ajWd1bzzxXnojhiOwZU3QqGdEV04qru60zxWJAxbka1Ev3qlOyTe68I4xFKoy5vR
Bi16qIi9TRSUzTH+7mnesiWAukCVhdgQnI9NpJV/r4TUxE4pWjfM6NJSMaLpxa+v
LeiiUKMTBAQ01J8xqOZTL8I01ASZWA==
=TzVZ
-----END PGP SIGNATURE-----

--IUGIOQ3xRchsJgNPFU0LuSDlT5jY29AEl--
