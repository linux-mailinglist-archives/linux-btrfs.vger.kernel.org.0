Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C424A9F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHSXbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 19:31:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:48191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHSXbU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 19:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597879878;
        bh=KcWyDqg7DF+Wm1dh3XHJnxsF7EiqG5It9MalaZdh+Aw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jumknFp4NNal6CCz2rD/wV06RycbzKH4yGzavwXENtNyCqQe2k4W3U1oTOKvZnYBx
         061GNUuTzPEX7qCpoXEWCJ/dI/fwqXtj2RCdIEXH7i7DO7a8asUbsR4xOaJZbYUUjr
         fogtDbWuu2M6kjUCdGC2U4AgiF+ZuJqKnDzQp+T8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2aD-1kXw9J0ChD-00k5Sc; Thu, 20
 Aug 2020 01:31:18 +0200
Subject: Re: BUG: kernel NULL pointer dereference when using zstd
To:     Daniel Martinez <danielsmartinez@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAMmfObZhCNGDW6Z4jGHNA+ZCVP=tWvt=DLm1isuwRS4NEebp4Q@mail.gmail.com>
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
Message-ID: <4988ccc8-8c18-ecde-c6d4-bc2aa0360482@gmx.com>
Date:   Thu, 20 Aug 2020 07:31:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMmfObZhCNGDW6Z4jGHNA+ZCVP=tWvt=DLm1isuwRS4NEebp4Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a4AhwGTwOQ7uDBfhUmndgKwGgRU5eiNoG"
X-Provags-ID: V03:K1:pidBbGOPwa5nXwGZYv2Ss5nxxX35fY4nQHweFZvgW4wlu9OvcGm
 oAuFiKp1HbAWEai70GyPDkezuwlqzMPkGckqc7p2TVSRAOyvLL1gaiPEMWdLrHa5gEyaPq1
 mP5Gsx/AeCUKO2mIS0Ju7S8vuH9oM7Rc16uTMIRF5OC8k9qauAs/LIL5f7D4KXuvIOcEiKX
 sGbHofOguDtzxZUpdYZqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SDaWCVc28co=:K5D2mIRO7l8qYNkSm7q/+W
 BtV2JShNi8Dw8nv7Ic44DA3AzIISwrl5vAdx9aUlIl9+csFDO7tFpW/AicJnuoSrGPCH/TQJC
 VYwjdKdZNlHCj1z6RyfqhGEsCHzvYWRMZLXy0mNZn0yFgfJUZDS0pv5SmDP+cPtKbaLlSsK6r
 +yhRl64jmnOzvvd3c/FcgFOjxQ8CgbW+F6cPLlZ0xTh59aZ/pa0Xc07DYNkDvECSl5rDWEJJi
 /jmQBh7dUQE9mFi227pSjYOq2L6ykjfiGSjtFVCUfN04/wdUiaMoUjvXdSNaNyTL2tW5FNZXy
 W7ZwZTPbhn2TWL4fFwEPesPiIab31GSZUy4jUTrzf6RM2EUMZ2qbjxsLPmhiP1A4rRUPnf8cV
 INjOXtjUfteLhMqcgOB+PL0Hm/1hi5eMPF0QfZv8g8vVjCwsO1AUjLw5v2TQUTNMBv1hjbJyI
 NaOdX7G7MyK6v5mVSfO0neCSpSZinkVMzaLeox9DbrqyFiTdOMDY/IwDXC0YZ71jwTI1Bmus1
 Ul1D1kUdnTt9/2p9hRyhxCLWH1UI15Ww1irQAW6d9M7YmmpEh5N4MejVT1jbCMCiO7CQVDc+K
 YZx8SEJuesdQPy+FkKcceGD250j/nx1RJBgGkwQk67JbmBJLivaLobxdPPWorq+knF6v9vTfA
 mwi3NbWXfJsq0ydwsXp6sP0X2Er/Ef2y8kghTCVYQs9F8HmrzMNzB8rwUFEVqSer6cKB7+m5K
 5PJZoHUip6V1O/f7LTTI25TkJpP3EQ7d472+tq9IYVnqdejjv6Nrjjm0wZ+YJebUkCxONRziY
 xMMDpKRtoLLpBvq2NJ9A8hwaayuTUWW0uPaRJEZhYeb5qlc94uguLiLu5Vz+mdqHKnXqiUlcL
 2pOOEN1B64A9b7/uobsNzSX66GWP/d+yUNhurBJMG/IgrM+BnxXzmVIv1aQ8E10Mm7emmjFL2
 AMpJQ43MLwj7RVMaM6AMqHtp5yGVk7pTOnI5NgXdpHUuVsHh1OGOBA9Z/GiK12jD8IeH1h3BQ
 j0zfM25flQ/fyphysyF3C4R67H3nQnv1pl0gxOhP0EziSyMlmEh9UeDWUdDEiuu7Kne4I2feG
 mVOhn7C09rGsQ+7PjvYS1dNND7XQgCQMBsse90q8AnmcjjQhiM/rM5o3jFUkQgwHNxNd973MU
 KZ72kxSChmH8AE4H/gQ/y2RjXpvdZEX52/U0cxUDtcolxbFzyX3SRtnMJM6KXbP6rnlAqKXxp
 ig3q+ng1XQbPmvPaXjFwM1F4LPwrFOuxwgVQbRA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a4AhwGTwOQ7uDBfhUmndgKwGgRU5eiNoG
Content-Type: multipart/mixed; boundary="EsYsYhv0G0sAcplXzpCnCR7NxF3eyGBTw"

--EsYsYhv0G0sAcplXzpCnCR7NxF3eyGBTw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/20 =E4=B8=8A=E5=8D=887:14, Daniel Martinez wrote:
> Hello,
>=20
> I have encountered a bug when using zstd compression (I assume that's
> what caused it, but I could be wrong) on the Debian kernel 5.7.10-1.

It's not zstd I guess, but a generic compression bug.

It's fixed by the upstream commit 1e6e238c3002 ("btrfs: inode: fix NULL
pointer dereference if inode doesn't need compression").

It's not yet merged into v5.7.y stable branch, I guess I need to
backport it manually then.

Thanks,
Qu
>=20
> Not sure if its relevant, but I may be hitting some corner case here,
> so my full storage stack is:
> Windows 10 -> VMware workstation full drive passthrough -> btrfs x2 -> =
mergerfs
>=20
> In btrfs, I have 2 arrays that are merged into one using mergerfs.
> (The use case here is to have different RAID profiles for different
> data in arbitrary locations):
> 3x8tb + 1x2tb in RAID1 meta+data -  rw,noatime,space_cache=3Dv2,autodef=
rag
> 1x2tb in Single data + DUP metadata -
> rw,noatime,space_cache,autodefrag,compress=3Dzstd (this one is also
> using xxhash instead of CRC32)
>=20
> Syslog attached.
>=20
> Thanks,
> Daniel.
>=20


--EsYsYhv0G0sAcplXzpCnCR7NxF3eyGBTw--

--a4AhwGTwOQ7uDBfhUmndgKwGgRU5eiNoG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl89tkMACgkQwj2R86El
/qgYoQf/ZhFjJZyvsOhzZUz3YQ1l8bV/ACefqBHAjvEpEp1Iv5ODH9aaStWo+ShZ
5Y/AuGOkxppRql56B6dXGarPyDwS5Y2GBXBEn/LSR0GEWKrB/SqTQu0pXelIBbNC
dPeC4t1ayIzJ0kTyHfXOwe8VtQUxs4G0RYi6DW4RvJVLq4kWDDvAURrT3zs6+VlB
FL0J1FPer2+eNF7PWAQ0j6rVCS1cQYp5MMP2oQZw1zRAc4KUTfq3vx8MPCn/Qy4e
JWOeeVsA2YvO8BkUiD1tmHvGKDAA4ywZ/tCMgdgQPOex+7vkq2P+2XcXTLm4F5ES
OK+AFdjMAbIXJKD05I4Mm2rbCWEyQg==
=WAIy
-----END PGP SIGNATURE-----

--a4AhwGTwOQ7uDBfhUmndgKwGgRU5eiNoG--
