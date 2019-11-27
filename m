Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7610AE27
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 11:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfK0KrU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 05:47:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:36409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfK0KrT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574851560;
        bh=5ZTkAUQdnM/3FTpluXHBnwy3HFjuuMJRnruBJ8jKB54=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=L0foT5swSvwkqbT09X3MM2u1FnRnOc+nGtk/eHk+UMBA1oszWujrAu+EtFcvf5yfp
         REWY44sO5ZcPNvjWep67QPeu1C9zdLbAKagaDE1OSaQkerD6s4RIaSuFTG6InHysBW
         e3o2vCh5j+EPfc9dS0raz5WojT+vegZmoFkh35R8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKsnP-1iFEcM1mRB-00LCyx; Wed, 27
 Nov 2019 11:46:00 +0100
Subject: Re: [PATCH 2/4] btrfs: kill min_allocable_bytes in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191126162556.150483-1-josef@toxicpanda.com>
 <20191126162556.150483-3-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <faa822d3-274a-39e5-b563-c698b11cf544@gmx.com>
Date:   Wed, 27 Nov 2019 18:45:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126162556.150483-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BI3CzF27Kfxbmu35Ly81hWgITy1gMHhtc"
X-Provags-ID: V03:K1:sRpsPSIkx93gmePabat8r8PBQu1EBNoCeS/bhmxiALsr7ibh29s
 iZhiD2TYI8XkuF63xf1LDX+cOqUoTQldqBGD/IWd8gHBBQ1g3N2BSMmtzpsDn72QB8LNNA+
 C/yEq+4i1b8D9uFtEySYRZz3Q8+8fi3yfPqJ0T1tF5S2OXVrecduDdtJxs6bhQPNdhblYUS
 CFmxLto+sGnquPGsxwCpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xo8TB6k2OcE=:UVjCeTTOR7+XFMIo9NnHaY
 NVHJuT9rsJ3pJsKTCeStdwihcpshkfjOzF9L8/WUPI+vERQwoColRRjzGX4Rr5hRtIRs3D4+l
 Pqwh2W4+7VyEQh/d6shXhRMkMKmXQK2ZTIkKjou5Cj+MkDPWJJCFNdaMB9NYmBg0j91bCT6h8
 RTBT02B4sw+zdIM+1ZCIyOmC43SxNr+APu0U/Qf+5HmSnR59WIJzS206nnOKhs5W64TbRAPfd
 CVGyEZJz3cc1fbU57l6qN16JVczxehR/KJwrBokm0MsoGNfaDvQ3hC9ufB0utj8lH5isqa8Xe
 WjL2fc5e6kI05aeUM0Qmc0sZ9RjLnu7WsDQE10wDvKXiALeK2El6JMOTTtHAlC0aGCM0K1d/x
 SYyCGVUiUeWtxTndplWQ8jjgHIdsisYVQhhqcRgGDK9rHtlZuZVuB7llGO8sPDuZUd9+BweNz
 BtpJEbnnoHRz44neytQSkplMe62Lz5iTdgfWoueLBWyj8Uj+oKgJft5qRlnAgqgu3k+Fzhmep
 7q6kU6Fv+CZ72trj6/l6S3dEdU+ZO5/rP/WURsoDzxmHemA1bitg9jughC154bfOJBp1yVwdZ
 /Gh/0PINtHB70rZ+Wh77c3GTvuQTtAf+Ljf3vyRt2raoAjysV2nfZP+kMibNOd5Wt4LIa68/j
 5t6xcGnympazz3EL0bo2tLSHxSpDeluNLnnlbNQcrF2cX+bUtbSKR5aFlrRyr2LZfrdSMF5R0
 FrCu3K5iXtgG9xvWBCwzkd2PgxEQliMgMhx1fdJ2cpf8Y2hze3m6tzGTas3rEJLpjU1qOPNxN
 1Dc3pb6vtFwWzaOYd2p3KhzdXxDMr+tcymiVa/RbJzx8jdmXABMLU1EB51L5ZBDjWlDeP32Xp
 SE7HvG9HpFPcURsrk7MOp8bb2EIG3q7XWayyOeiyHkieW6Vf+n6VQ43pKxUfLkb3S0rVD7JR/
 nhlu/ssKBUOlEqQNsYTqM6ySIFFa3XDt6TyPolYXRXoPdNj7pdgZXw5WxcgCXZ1vzkrQ3RWkd
 3U/VXGGWn/VKumJjBbMM58VAwBLeN6lzk0pezCE8awFzymgtuZtSQxRo+vByw73xQSHNSXnUn
 3LGtuvE0MlJuNw2vuvL59IiHBPYyfv/u+sdHRJj5gTD4M8p153C5cVvZPrVBtDZJfGeJsKB0n
 CjWX+iNxrpkwsyeWbxSaHLxPLuUnKOwBiM/umFnoJqPgbiH/OkW6Si4jKAGBQK+v7PEAHb3/H
 3hZB5WEmScce29PcP0OrmY7UlKAlrt96lH8iEUhGuY/kuo+0Y6dOM6RMKGpU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BI3CzF27Kfxbmu35Ly81hWgITy1gMHhtc
Content-Type: multipart/mixed; boundary="z4BzbkBZOuUgFlASKvS8SSzduMNfOT8uL"

--z4BzbkBZOuUgFlASKvS8SSzduMNfOT8uL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/27 =E4=B8=8A=E5=8D=8812:25, Josef Bacik wrote:
> This is a relic from a time before we had a proper reservation mechanis=
m
> and you could end up with really full chunks at chunk allocation time.
> This doesn't make sense anymore, so just kill it.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/block-group.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6934a5b8708f..66fa39632cde 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1185,21 +1185,8 @@ static int inc_block_group_ro(struct btrfs_block=
_group *cache, int force)
>  	struct btrfs_space_info *sinfo =3D cache->space_info;
>  	u64 num_bytes;
>  	u64 sinfo_used;
> -	u64 min_allocable_bytes;
>  	int ret =3D -ENOSPC;
> =20
> -	/*
> -	 * We need some metadata space and system metadata space for
> -	 * allocating chunks in some corner cases until we force to set
> -	 * it to be readonly.
> -	 */
> -	if ((sinfo->flags &
> -	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
> -	    !force)
> -		min_allocable_bytes =3D SZ_1M;
> -	else
> -		min_allocable_bytes =3D 0;
> -
>  	spin_lock(&sinfo->lock);
>  	spin_lock(&cache->lock);
> =20
> @@ -1217,10 +1204,9 @@ static int inc_block_group_ro(struct btrfs_block=
_group *cache, int force)
>  	 * sinfo_used + num_bytes should always <=3D sinfo->total_bytes.
>  	 *
>  	 * Here we make sure if we mark this bg RO, we still have enough
> -	 * free space as buffer (if min_allocable_bytes is not 0).
> +	 * free space as buffer.
>  	 */
> -	if (sinfo_used + num_bytes + min_allocable_bytes <=3D
> -	    sinfo->total_bytes) {
> +	if (sinfo_used + num_bytes <=3D sinfo->total_bytes) {
>  		sinfo->bytes_readonly +=3D num_bytes;
>  		cache->ro++;
>  		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
> @@ -1233,8 +1219,8 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
>  		btrfs_info(cache->fs_info,
>  			"unable to make block group %llu ro", cache->start);
>  		btrfs_info(cache->fs_info,
> -			"sinfo_used=3D%llu bg_num_bytes=3D%llu min_allocable=3D%llu",
> -			sinfo_used, num_bytes, min_allocable_bytes);
> +			"sinfo_used=3D%llu bg_num_bytes=3D%llu",
> +			sinfo_used, num_bytes);
>  		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
>  	}
>  	return ret;
>=20


--z4BzbkBZOuUgFlASKvS8SSzduMNfOT8uL--

--BI3CzF27Kfxbmu35Ly81hWgITy1gMHhtc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3eU+EXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qi1pAf/comb87WmVMX7bLF7pnMgolU+
2Hi1fFu3U1hXa2jcYsGE40do8We4xGK41dJYcmLLJ3sQpNET4Yg1w444XgnahAMS
Gc0cURZu28eRuhr8wLTqE3dr+rA9zmU5hNCWf2MbxMsVjp5kQj0Xhtjl0bEslqqJ
lIH03Bs8JsnZoy2kaphHbkH2aOvILhmENdgZgmIW6cOTBN4kpJPoed4X6bbGf5Ld
kLqR8XB9TAiVFQWtfYy49Auoxkil2Ssu2xtNpGk2ReDkUDbRV/3E6dikiH1wE2XJ
0C8BUupbltjZg6hqu6RY0aBgDW38pMqSDJ6RttEgDkK79qgQll68wYIZtrjV2w==
=t0uR
-----END PGP SIGNATURE-----

--BI3CzF27Kfxbmu35Ly81hWgITy1gMHhtc--
