Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7161311606E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2019 06:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfLHFCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 00:02:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:37159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfLHFCl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 00:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575781341;
        bh=h9MuqpwjZBh6DSyH5oxzOWS5NFQ7tatqJvwIq2EtR8E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g8n8dxikofJFHCZ/1sDn8l44MC6gdEatTnZbBdL0jGZexvsv+ru2L191j7C8QLLcl
         acGqYjZiOYpV6jvsk2ATO3bSnELWxsbroSZ2NUYikUVL/O6PflqNNiMUqCU9DfBdA7
         fsVteqZZx7rXnA66fZYLWFF6qAWndNs1wgfaji4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1hqot02KEo-00x05a; Sun, 08
 Dec 2019 06:02:21 +0100
Subject: Re: [PATCH] fs: Fix a missing check bug
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191207144126.14320-1-dinghao.liu@zju.edu.cn>
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
Message-ID: <ada75c60-aefb-86ff-0f3a-33825fb4c958@gmx.com>
Date:   Sun, 8 Dec 2019 13:02:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191207144126.14320-1-dinghao.liu@zju.edu.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OljafmsOc4h5wEdWTbLiKily3BqmqVmqc"
X-Provags-ID: V03:K1:CNMqQgNKh3tPKJq6WXy/Filu61Tj7HdZX3faVN6uP1dFEiPlJZf
 DBEpxKEX7hdIV6qet0KgG2KHffsKow/ODKnRwlevRBnwDbUpxnnWWVjjojDywXnxKNfeCfi
 /RZSuJHtjrKe8IKtHfE/FlSGGOznuT1yJdI7FOwSa6bcnD51MWxLLLyOzFhSVlnSsdtd33c
 JeiY2YrKJRPKpYSoxTS0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogKqLd6Dsdc=:3dQzU/UYyomGm0NcvHuU+E
 7T+nBnjogCDsX9f7XknhbkmIEDM+EfPYqzhAQJwE6rUuE34PzpHPWqvd0Z6hgdc+zBryyQYrI
 cqyAQodvTeOUVWX+4cwcEWwUI+bKDJatheahbXe0/gS91YNK5NplmmQctvKst2VNfzMZset1d
 MGnN9aPa9cos0YnTRb7zkYpTQUsEPBxGDiEFPA4EIbZDt8FectUP5gbZEAVhQtTIbghG7u6YN
 haixGCsLpHDbqrOCgsXLM7q+ZIHo1ANyHZO7uAvyTiU92pKRD/jBnYf8a5JSMAxemRDqzUFBS
 tdta3c1vgcBf6YNRZQYUHRC6o0BN07O40FhKV2ASFxiwb67F0EkRUExnuZmga3hWw8TTYK/ix
 3xikJRhgqnuJqsLR1PcoPICVGqyTTUBvvhcOpSuGyTAGajW8/bdf/OUDG+j93rGlMnz2eXDu3
 LFxZ260+yIXlE2K1jknLzFyO9f2OobJG2ROYLwBonTqi5ObySwkyMaZ3pJawvgdLBLlAeaVmt
 CweWx5pOdcImhfHzwJVbUKaE8wrtoHPAjRj/8J5WIUtgTqyxmz3w5EYCIBF7cEBysZsY+dGRF
 HaO/3HCbVozjPyYiMu25G+cV0zv10EN4QVecVU3yFXkN1ix7vcYqu/eJp9fzmVqd7j2ezU8l7
 Hg/e3NqkMIh19gurU2oUXLLXt1OeCBAuqjsAaP36Z79AayOTdpfuluj0qbvi8PH5Qh+ZI8MuE
 XbYStVnBQBX0RiZInOEuoWAJ3bvpWjdYFAyE7xJKVpKbu86ign62VfbnpY/aRyZBIaxzVLHn5
 zrQKS6DnbLHcathzujk064sZJytS6m1+y+QKrmm8P06XiItLzmSh/Sfbkl2gA3gPBYpl3Fn0r
 XPKR+cSkUEnTb+ui/K/LEdiNCDRRtt83S943HkyrcB/7EpZr4bPr1nF5zz8onu6qiMbNLOse+
 zWVqaC8mCP4Jaz12yiy7j+UljKnwIngTq2acfFR+eNP90food9T2mmQSjk2lZ6/YT2l6os1jX
 Lpm31xjZwAW8uOLRAQbMrbPTL3oj4/UsU3dgluorrETSQkTLml6hKgWqjpUvsCGfUMp14f5n6
 CIQWidUlO1jKhDAlrO/Gce7UE/28mDladXLdHX/TsXVdjT0x5cutnpRxOVbFFXKr8GJZKvAnR
 6TWrmOqBDUKUZw48I8H46CXuG1PCbghVIZCkKtbMqNmnfuxiGITaEtRIejEtThf+VNqGIIwzR
 VqhTH6UQNAeZIGuXVzkQ13+aJn4vIEZbI0wTtEMvFQIjHxikzj+rldX68UnQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OljafmsOc4h5wEdWTbLiKily3BqmqVmqc
Content-Type: multipart/mixed; boundary="QOQIKyC0n9wuUj0H6ToJUWrQpQGROLGWR"

--QOQIKyC0n9wuUj0H6ToJUWrQpQGROLGWR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/7 =E4=B8=8B=E5=8D=8810:41, Dinghao Liu wrote:
> The return value of link_free_space(ctl, info) is checked out-sync. Onl=
y one branch of an if statement checks this return value after WARN_ON(re=
t).
>=20
> Since this path pair is similar in semantic, there might be a missing c=
heck bug.
>=20
> Fix this by simply adding a check on ret.

The main failure mode for link_free_space() is -EEXIST, which means
there is already free space in the cache.

Here EEXIST may not be a big problem, and we may really want to continue
the iteration other than error out.


Would you explain in details about why you believe error out is the
correct way other than current continue behavior?

Thanks,
Qu

>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  fs/btrfs/free-space-cache.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 3283da419200..acbb3a59d344 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2437,6 +2437,8 @@ int btrfs_remove_free_space(struct btrfs_block_gr=
oup *block_group,
>  			if (info->bytes) {
>  				ret =3D link_free_space(ctl, info);
>  				WARN_ON(ret);
> +				if (ret)
> +					goto out_lock;
>  			} else {
>  				kmem_cache_free(btrfs_free_space_cachep, info);
>  			}
>=20


--QOQIKyC0n9wuUj0H6ToJUWrQpQGROLGWR--

--OljafmsOc4h5wEdWTbLiKily3BqmqVmqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3sg9MACgkQwj2R86El
/qiaGgf/ZElzpjn9aMoFUlHerx4oosFcD0sEJ6GUbmz0hoM6h9ecafKg5C+KRRUH
Tj76Wr8lavpXz22SOfK2VP+XOc24kGu/Cyt80CKt0+h91H0JtW6ZAbf735TMkfQ6
roHgZpNAiP7hOJBGsVu2RSQClP+wNJVEcJ9nyw40Quz5WI3Dhbmqv11VZvw+nD+1
77qsZvD1o6rsgVwn3g+xXAzHLAKPRumWoQo93ujRiuWsGsXxQcHs55yoGnhxEcqW
P82Qoql3RTi+M9j689wX82FYWJeeN+xbP14cGsFXNdwS0FRyGQ5l5NeFcCDuyytD
R3YFNE40tPrBG5ixKIx+AMf5FbZ94g==
=Ldcx
-----END PGP SIGNATURE-----

--OljafmsOc4h5wEdWTbLiKily3BqmqVmqc--
