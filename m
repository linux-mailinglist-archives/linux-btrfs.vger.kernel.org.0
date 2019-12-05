Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BB113C78
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfLEHlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:41:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:52891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfLEHlB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575531659;
        bh=tCATalrjvgL0dCO3u6n8CMU8WAKgCW1cXeqMLP7SbcE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jy/uwPb5l+zft5tJxn/zes8smE3daiccnDOn3yhnuNIIB7wDUfA9cSiUGPDzk8Fco
         +TGMHUJ7IthoPnDGmmHO2AMJrjKU+y74I0XHY5qb7h2vdcrM/aDDds2WxlGul69Ntq
         rOqL9eREM5nrIVRwihG9tGQUB5dY0mogP0CBfX/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1hjzLH25W5-00tXS2; Thu, 05
 Dec 2019 08:40:59 +0100
Subject: Re: [PATCH 05/10] btrfs-progs: adjust function
 btrfs_lookup_first_block_group_kernel
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-6-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <16783ea1-48e7-45ac-ea1a-3e9048aa2616@gmx.com>
Date:   Thu, 5 Dec 2019 15:40:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-6-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bQk2yMUU2ZeVKWjVx8spbLusktO497fWE"
X-Provags-ID: V03:K1:3mpgsSsR6qJvIy+utVdrQ9n+TPf3RqreAK9vNM9vDdiAm6avfxC
 0Id+j8iYyhwlFXsEvB4d7jaYVYKR1rE1o4StMd17KvqJGT/drg5DoSm5F3j9/FrHQ5/16+S
 LURu1lX00CCLL5OMBWiTkpIGzAYmhFE68xO0ipGia4HaKoYENUhMpAZVOIuKSEmzp5c5Hng
 7esTlJBT0rlWNe/CXkoLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlBcWOES7Zg=:AIkyQlta0xMTWcGu0zfmo/
 7Q3thyQT3hOxboMIs2LzEkQu+LsogE4kyZ77smmck5/yPdJUAggqoz/D+0woae+zOUbhZG8Zn
 R+q7Sf7drFQAN6qEJ1Lwb4VUlhGaiO+BSJLTqBazD01bjtCnmYSx1IZaNDgSrrQ9xPdC0MuWE
 PLNjrsCkXxpb+0jCVNN4RacF6os1nkymWj/CW5hS8PY+5YCCnIkD4yBX/z/rf+j40EXUeuEk+
 z0gY0RJ27OBP6EQjFVCHI7YTIpxgt1iEHdY3n7azEas7h+Hp4WATJu9zqoS9fKMDOeP+Zbp7G
 btduurYgev1GKaVjNzTgtOyTzg5BZcwKUnr2lCGH2qI7suC6RcBLn7IIPMTXBQy8bNeYeSdLg
 BI+/0eu0G7odT+/owCkRQkq2OT/fpAwN67jb/A2uoDnag3426/dIfHO6GdJXW0L/6MSqT3nXp
 CEfkIrE3l5ssfjq62Q6pWpmEv8lOYWs7n0RAVwnd/OMxqMEzXWWf3DQloAR1IUwLTVLfelRXB
 7I4INbbA8laUSBAo1ClGNMzKqwzy8glOxldB1+BBTvPmBfFvOmzIsJF7PuAuKof9w+CtJf64z
 AmZctumYIemMuuebMLu6O2MQYvsiwnndKg3HHiLTGXP/3jJjkVmAAdz9Sc7p8GqLU1PxdM/3g
 q179lS8zLPYQrLRxpFa0on+PB1HWGnMi5VizpIQPrDLN36rOVb6ICo7tq5/ODMEDtHXk83LlZ
 wiVBd/bptyjNXPaOdcnhUFnBN0lB7a2eqImKS6a3yzBaiRF9N+iA2DSxDYDjmnoI47XOyKSSz
 i3mVcbAAgG4hphotX68vcbUZVNrLT0GF3IRKWTG0Yo6irmV8OWaNrOs73l94y1Non98l8twyg
 dp5AhrSewN1UZRs618MhjfjrnyjVv6h3c85hsMUcb5wNurz0tOA+juxRnejYDK1er1qADJjZE
 VnyakP48+LCQ5FUglzf6+LnC1kjsWdusmlZee0dsmOAYdWiL9nCrIwaFAt0OfmLptvgt8FNPo
 QOzxz+Nj8ul3GeP505ZLEk9CB5ECqXJ9/i68LJ1z4AeFmqr8MAQx2vV4twoBIEy+ijWUVsFZA
 36VJaNWlnHvyxcwhakjdTyagVHIo4aeqyXWZfYbEU6nWXHMJwyShh0H12AqbAWeFnhGtkQI8H
 2cba5m5IhXicc9BH4Lx6ScTH/iPnXjxyDiN/Xn73/SsxrPw3Ve7xvxVnoBw/EJRvjHjP2lHq0
 sLRLaZlohAfR/JO4rx7uazaTxwK9yJb+4KphCfT+004v74mg9VmfyNtMz1jg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bQk2yMUU2ZeVKWjVx8spbLusktO497fWE
Content-Type: multipart/mixed; boundary="yyJ0lGA1gKqvAMVVKBd09la1NjzuSU1DI"

--yyJ0lGA1gKqvAMVVKBd09la1NjzuSU1DI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> The are different behavior of btrfs_lookup_first_block_group() and
> btrfs_lookup_first_block_group_kernel(). Unify the latter' behavior.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Is it possible to modify the specific callers in btrfs-progs to make
them use the kernel behavior other than re-inventing some new behavior?

Thanks,
Qu

> ---
>  extent-tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index 1d8535049eaf..274dfe540b1f 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -243,12 +243,13 @@ static struct btrfs_block_group_cache *block_grou=
p_cache_tree_search(
>  }
> =20
>  /*
> - * Return the block group that starts at or after bytenr
> + * Return the block group that contains @bytenr, otherwise return the =
next one
> + * that starts after @bytenr
>   */
>  struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(=

>  		struct btrfs_fs_info *info, u64 bytenr)
>  {
> -	return block_group_cache_tree_search(info, bytenr, 0);
> +	return block_group_cache_tree_search(info, bytenr, 2);
>  }
> =20
>  /*
>=20


--yyJ0lGA1gKqvAMVVKBd09la1NjzuSU1DI--

--bQk2yMUU2ZeVKWjVx8spbLusktO497fWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3otIYXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjHSwf/Xlfx5NomjDhPfwi1VVs5u+uQ
tB/isQbiYSuffNIxiZSxFQlIuzVwxolSWguIX2/8NfRcvvu2iZZz2Xu9halwJHyw
RGpQ8wVGJFyYoaLRrxxOpSWn3ovaLP4R/5qaA/Y1WRtmVhB1zbc/y5PEDlwiuxBA
5Xz23+Iay6aVc7Sw9tnj6P+asgCqMbTq8r94P1hKweRmgqenU7Hq6gYaiu8zR908
b7cFOBJOUUAQGZzOkH+/hBfIo6NBiefzU9/P9935vCUTbx141auhFVbjklHI2jGp
CVxWtrwCbG2wmLnc8CJURAr/TOjK9YqWQp7ahFYHBckyDU9JgZ8152gTXBKxQQ==
=oink
-----END PGP SIGNATURE-----

--bQk2yMUU2ZeVKWjVx8spbLusktO497fWE--
