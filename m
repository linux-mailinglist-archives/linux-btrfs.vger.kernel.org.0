Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB901243B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLRJwD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 04:52:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:55245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfLRJwD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 04:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576662721;
        bh=TnUsOq/x9OSzsCalCwIIS+TzZdxu9ketb0BtyiTZvn0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FPwdRp2UzIGDNUjK+Jcc/Fr9yd0BcpBXy76hsgEZbCiygAtnhgJW118KjZAkfZLZf
         Y5ycrAcHyF7jdlThwL0KzNb9B3SUSO65gQMMg89/vRWmwoFdaiy5R+rShAGfAYaOSk
         qBAyI1KH/FteeiA8GtOUInvPGel+UCVlJA1HX17E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1htYjt2c4z-00qCFQ; Wed, 18
 Dec 2019 10:52:01 +0100
Subject: Re: [PATCH V2 04/10] btrfs-progs: reform the function
 block_group_cache_tree_search()
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
 <20191218051849.2587-5-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d0facb13-1bdf-7595-2223-b28634cff95a@gmx.com>
Date:   Wed, 18 Dec 2019 17:51:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218051849.2587-5-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="InIT8dwlrAHAy0RjvdgwoFmg7VDxAEpfz"
X-Provags-ID: V03:K1:91vt6g+mWHcZA0zqksX45gTduW5TZbyk2PPG+Zxs7uCPqfljNZz
 RlYuIcQfGWYWv1OOZVDaQYPBkw5uJkwdnmQRh6pnyk5cmDQDshgtx1wm9irVVkzYZd4HU5H
 csVmL42641sqY91Mnb55vA3MhTTBmWGsf1pX+op4Vj3l4egNQx0LTPciZXpvZYUiTDQkjpI
 HaeibaERDW/BpFdeGzEFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6rIz80KmOCk=:3Y+Yrw0QMwuV8VRD0g9W1z
 P2SzqH0lBohYVGWBCuEAkLvJ0fhdGHg9RgI+erdSJbJWbKIU5Mcrz+Qh7I/eXxTo8u7mrTn8/
 kH+DADpmXPzOp6kdDnmZp5zdBDWhYHCKLUSxcTzcaKSH3Qa4NiaSUicusMfJ4cwWRTP8Fgq/D
 Q9Ad6BZ8aik1qBUoO1vabSmK7EiCFbGV61Bpn7YivDx9YDOknBhO7jNFrvzYgfW6wPx9nwSMC
 +C5gCXAozTmMBtfW5SvrGjjM1wCfjqZwiy8BE3bIJ0jX5Sk2gshRrz+kgeNm6l8kRCXpcJ68k
 Dy0LVbYXaO2lnJXBT2TZrLj8xxXZtXppbkaZvURpd4FdnTQgtyCV6+vGgr7vM+xrmyvh4UlA4
 +hCckKruq2INGerNqHXK8tfSuwB8ggjkHTUFCrOa+oG+dgH1XLaoGqqUEVWGhESL0mpjxvU3v
 FZzteL0lyl1/FLuklR82SMDQiIs3STKC7ouiuit2D5e/uheugBhX/crdnaU0WdK9eXnUt7vPD
 s+8eEQEXmw9KX2sQD8MD/2t8pszMy4vbYe6TSJsuThc+p8asfBTyD9KdLOfHUAGWbhmAuEZHJ
 zgHl27Zw3Awjqti3KN5yMuKXDBHJl6o8P4pGaMuAktL5ose2HNeTSJQeQE/IcZhvovAEyIQKs
 LpnxzD+K/CuGgucgLzQK8kunK51UCbuMpaAhm0yWaPmUKAySRC1vXVPuzh3qJ40f259afwmAP
 IgzWg+EpwNrnCG5tJT80B7Vxj0q652wRpocbOhLXDY7VZ0p6CuNy4zRc9cFmxGiDMA3j+fZZ8
 5jM5NT6ZfCfDWCAWNiFry0rD0O2eDNh07EJylFyoXufZFw+3P9TxJ4vo8KPfcOP5epDJcMzgR
 lkSE/CRAzswtbpRRF721hRm4e02PM+PrH6O0ug+e5fZddIjicA6xRZx7XZmEMhGIJRmcE1OQz
 j+rTZvDEaRMR5Z81QBYBQAfYjnOIg+Wga+s5mzWLqeoXauzHUPqa9BO1aJAomCloZXZMG6SV3
 H4ocb0re7X1LyAnd0TTaOry9pRsoXEUd+QeJrdvbdtkiHUFGqVDQMqvGuznY2/hij3wpuHVDT
 +T45fAGLJTrhCcsZrAcJdVhDbIQ8hTmq3XQ9af39okQfOJk5Ecx2DRUOqKBI++9JPs01jLAAh
 BZgpsuubtRt5hLsA0TEEcle4KVj1QkwMY+tYhHcYReb0M9Um4fblwAT15L1KAsszJMyMoYcfv
 KEg+zcLIv6386nhGuRg3bUN9WOZLuC5vbWmYBSaYbNj0KEYT+szRTo453WVE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--InIT8dwlrAHAy0RjvdgwoFmg7VDxAEpfz
Content-Type: multipart/mixed; boundary="KmBUYYNlKK2KZDejFWcWmsyQ3sgxpA4x8"

--KmBUYYNlKK2KZDejFWcWmsyQ3sgxpA4x8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8B=E5=8D=881:18, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> Change @cotnains to @next of block_group_cache_tree_search().
> Now, the function will try to search the block group containing
> the @bytenr. If not found, return NULL if @next is zero. Or
> It will return the next block group.
>=20
> Will be used in the later commit.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

The @next looks pretty good, more clear than old @contains.

Thanks,
Qu

> ---
>  extent-tree.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index ab576f8732a2..fdfa29a2409f 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -196,11 +196,15 @@ static int btrfs_add_block_group_cache(struct btr=
fs_fs_info *info,
>  }
> =20
>  /*
> - * This will return the block group at or after bytenr if contains is =
0, else
> - * it will return the block group that contains the bytenr
> + * This will return the block group which contains @bytenr if it exist=
s.
> + * If found nothing, the return depends on @next.
> + *
> + * @next:
> + *   if 0, return NULL if there's no block group containing the bytenr=
=2E
> + *   if 1, return the block group which starts after @bytenr.
>   */
>  static struct btrfs_block_group_cache *block_group_cache_tree_search(
> -		struct btrfs_fs_info *info, u64 bytenr, int contains)
> +		struct btrfs_fs_info *info, u64 bytenr, int next)
>  {
>  	struct btrfs_block_group_cache *cache, *ret =3D NULL;
>  	struct rb_node *n;
> @@ -215,11 +219,11 @@ static struct btrfs_block_group_cache *block_grou=
p_cache_tree_search(
>  		start =3D cache->key.objectid;
> =20
>  		if (bytenr < start) {
> -			if (!contains && (!ret || start < ret->key.objectid))
> +			if (next && (!ret || start < ret->key.objectid))
>  				ret =3D cache;
>  			n =3D n->rb_left;
>  		} else if (bytenr > start) {
> -			if (contains && bytenr <=3D end) {
> +			if (bytenr <=3D end) {
>  				ret =3D cache;
>  				break;
>  			}
> @@ -229,6 +233,7 @@ static struct btrfs_block_group_cache *block_group_=
cache_tree_search(
>  			break;
>  		}
>  	}
> +
>  	return ret;
>  }
> =20
>=20


--KmBUYYNlKK2KZDejFWcWmsyQ3sgxpA4x8--

--InIT8dwlrAHAy0RjvdgwoFmg7VDxAEpfz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl359rwXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg9tQf/eC9OyQ9ayavVr0PhSYvOhTDt
0G/R22XcAiERLQUiDxUOLB+yFWccrRLgxhPfrRHo9PGXXqqAVDatB/6SMQxJHjfm
jvuSE6kW7/dNXIDtcUQNl0ldfafOC00bcAY80If3IPAtJyLLYEZHiMxNMm2MhcgL
XbmrYsqVJ9ndtEQZorfSr/hRP17qwz39YsFx+vt4wzbTvHGASQJ9yHyLPxv925ky
is2xFdC5jibnTLN4vYIKkynLoDqnwTS15iMbSuCaBMsy9JWkI8s06hDMQg+SdOnu
HfXadXUCFbRE57NBBz2YQsrZ3cX+egGOe/nn/od3dtCS5L8pc06Fjt3aNDRshA==
=x4NJ
-----END PGP SIGNATURE-----

--InIT8dwlrAHAy0RjvdgwoFmg7VDxAEpfz--
