Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA61E113C73
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfLEHix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:38:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:59105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEHix (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575531531;
        bh=KVx0ad+0D3qvfOdKzY1uM2Pjvj93NJkaSDMbDimjlWw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=knsCuJgB8wz+2sxxlyLi/ARriT6li+LGfxsIFtJygvl5zNhi/L+JhfadzGAm+GFCm
         hbo6To1HKiDIcX/OR8BRvOjuD5OnN/3/UT/6qQAENDKN2TivKqYp2o0zNf6SFwGBtK
         1pkMC7hczwuBAEtuJHw6o3bUq+57vNeqoMrMgj2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDywo-1iV1xu0hIS-00A0jz; Thu, 05
 Dec 2019 08:38:50 +0100
Subject: Re: [PATCH 04/10] btrfs-progs: reform the function
 block_group_cache_tree_search()
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-5-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d491f547-626d-c974-8e70-9e39815a7dab@gmx.com>
Date:   Thu, 5 Dec 2019 15:38:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-5-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CMIVGH6YmFIWFoKpbi69fS1cxI0feVJtG"
X-Provags-ID: V03:K1:Db0nj3+cxxqsDRIBPTTz1dAqn6lbEi68PTKJhpt/k+kaqmua2OA
 6rnNZ1NIziEkwpXbTG3zHAiT9PvDGJLclpiwnpR1F6yB8NJLToPcl8pdCuu11ratiNGNDfa
 KteCeJnTkde3pRn8KDD1TLqcuyzsOpqnqRkkFtnVqpbncNtI2jeko4i0dEvhA4ULZLxk/5E
 rdH7lNHEZArQOXG4ZsrPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qof++Fhz5ZY=:Rh/6X3CMXoQH2lcV8HlHDI
 7Pk4BGhVGGR+m4QV2rxsYZHTzltAVwa7PmP+7xUNFsIkrxf7KG+lczsMxJIk7WHNZnYc50xnX
 sUQUm8D/Mwu5BMm3HYZXMABTaKHHGQ1hvgCsY9YmCHActRaJd/mgkGXYl61eRFrZuhQV+3c/M
 b6LpyQgvEdfFIx0VHWA4FArl0auykuQFybsyv91OEjYs+ertqhpnkgKM8JNH7bihmruuQMv0q
 vCu8gmbEQQmU/yPP9hOZ5SM+bRjIMj4H+jhRN7HD5seh8dE9ZAvM83Yl2yQr/+mJ2l7YU69a2
 Pvx7vvQDY5Vk3x9VV8o7BDMYnp+rNdBJV52GQZS5N3Z5YiufIrClgI7Y1Ckq5SQVBWcRf1qaB
 lcCWRYwtY33+dCrjfP2a7eu1KAcNey766/DfZ7MaMAeKLHORHwc1Zf7FjsjBSb93E7mi5zbhq
 HFOuekbuF3TsyiZIE1mTATBUbw2f8Pi2lq9dqoB7rwlDVGo9TF73WTD377w8a6kC0p7ce7Q/F
 TEqgqkZXxY1+WT8AqssnIJZX1FFJziMF9l0i1DTQtLMR3JQSjIZdjwMnovdvQhCCY59Gpqb+Q
 Z0263zpsA+RPv0IbG+2EBCtQ7WgZ1y8IGlNrf8xe6+5ViwE/iW8v+QuFjC52zuZlb/GN2gPuX
 HHt6/oq1Hf5LvRseHluJiw32hUb85stDmnMn/frEt38gL8IFmPlLVzIXRseow/YC7zfEHWeSu
 uY3H7Jcja4jvf8YhdX/f/BvY/0pV0blmtiQAcehRuQMEID1WpzecZVOnumftKJI/nArE5oB44
 9fADaOfRLX7BwcOvAyNkLoQt0m7DPjdLX0IPPJwrZ1Ivvi49S/7Rfsbfd0XahD8iv08VR/AFO
 zBzKG11PfY+iUhGoxBFKfWVc0nA5rSary+nbsnajZJ7k/rzaGVvqT1a5ftu8fXATM3hgErwjo
 4A0+Z/dUrV6gFHlIw0zZ8G0i/2rcTnwwTJqt1bKT7CpWqw1vPHr/j5RAE0Pp0NUk2KqRcA3pU
 bcOsiIHU8dxMbyOtsqewGE6T6cwBarNBncq/+Zeweu0sHudBPjnejtTux1BHTKBi5zM37nL1m
 lsaoRA1nEkHfmvWw1yC/hODI0xMAB1K/M3f9FUhMSo9cajwVtp6hSz1AkyQdmm90U8wrajoIB
 8V7KVyg1IZaWJCGaw4HGYVcYdwEtsViLr74PgJ8Bmak9Iw5unsxBZXATw1/dd4rrHwfC/ftfO
 26Ie3XrnGC9Fz8DX/tlwQebmOoJAoP5/bwGp+gw3UDE+xm3XfHgHUzyOdd7k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMIVGH6YmFIWFoKpbi69fS1cxI0feVJtG
Content-Type: multipart/mixed; boundary="Edh6RHbQclLUru9CcxP6vxZJloWuyDHUs"

--Edh6RHbQclLUru9CcxP6vxZJloWuyDHUs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> Add the new value 2 of @contains in block_group_cache_tree_search().
> The new values means the function will return the block group that
> contains bytenr, otherwise return the next one that starts after
> @bytenr. Will be used in later commit.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  extent-tree.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index ab576f8732a2..1d8535049eaf 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -196,13 +196,16 @@ static int btrfs_add_block_group_cache(struct btr=
fs_fs_info *info,
>  }
> =20
>  /*
> - * This will return the block group at or after bytenr if contains is =
0, else
> - * it will return the block group that contains the bytenr
> + * @contains:
> + *   if 0, return the block group at or after bytenr if contains is 0.=

> + *   if 1, return the block group that contains the bytenr.
> + *   if 2, return the block group that contains bytenr, otherwise retu=
rn the
> + *     next one that starts after @bytenr.

Thats a creative solution, good job on that.

However since contains is no longer just simple 1 or 0, it's better to
enum to define the behavior, other than using the immediate numbers.

>   */
>  static struct btrfs_block_group_cache *block_group_cache_tree_search(
>  		struct btrfs_fs_info *info, u64 bytenr, int contains)
>  {
> -	struct btrfs_block_group_cache *cache, *ret =3D NULL;
> +	struct btrfs_block_group_cache *cache, *ret =3D NULL, *tmp =3D NULL;
>  	struct rb_node *n;
>  	u64 end, start;
> =20
> @@ -215,8 +218,8 @@ static struct btrfs_block_group_cache *block_group_=
cache_tree_search(
>  		start =3D cache->key.objectid;
> =20
>  		if (bytenr < start) {
> -			if (!contains && (!ret || start < ret->key.objectid))
> -				ret =3D cache;
> +			if (!tmp || start < tmp->key.objectid)
> +				tmp =3D cache;

This doesn't look correct.

I was expecting something based on last found node, other than doing
something strange in the rb-tree iteration code.

At least this breaks readability. It would be much better to handle this
after the rb tree while loop.

Thanks,
Qu
>  			n =3D n->rb_left;
>  		} else if (bytenr > start) {
>  			if (contains && bytenr <=3D end) {
> @@ -229,6 +232,13 @@ static struct btrfs_block_group_cache *block_group=
_cache_tree_search(
>  			break;
>  		}
>  	}
> +
> +	/*
> +	 * If ret is NULL, means not found any block group cotanins @bytenr.
> +	 * So just except the case that cotanins equals 1.
> +	 */
> +	if (!ret && contains !=3D 1)
> +		ret =3D tmp;
>  	return ret;
>  }
> =20
>=20


--Edh6RHbQclLUru9CcxP6vxZJloWuyDHUs--

--CMIVGH6YmFIWFoKpbi69fS1cxI0feVJtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3otAYXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiRjQf+OB/oUY+NVqnS6L0pIaUYM5Y3
QYCL8BJnxpSIHZQiTIddGx+jueM5TRACcbQeMYk06wVTNihFA7J+zEE/6qT9GHPv
UP5W0lj2sRRL6k1gYJ3QPzm8Pu4uXiIvEYfc1yWLjDsDOGzQCsxkV3FPQoKCG/3i
0BnleEZQ1fdoMR+4aMopKfnubsUBLaRrXGtCw3yFX9SUHIJGgOYhrhuRou8Flclv
UtyQXmT7/1emhayal1FXUy4qtkOU6Z6KShWo1ogQoxfElxkhApfGB3rVqWayQY5v
NGSKzK+LkutZwuhZn4s9tD0eOlsIMipyRVZgU96HHBsGangnmhN2EjWIQgLMNg==
=WhM9
-----END PGP SIGNATURE-----

--CMIVGH6YmFIWFoKpbi69fS1cxI0feVJtG--
