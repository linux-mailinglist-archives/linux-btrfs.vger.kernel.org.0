Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA7D113C9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfLEHwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:52:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:48233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfLEHwu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575532368;
        bh=prukIuAXjrmQ7OVxyMut49c5OAQSdNAxhgC9AtcKZJI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IoHG0mD/9E1jXYbE67/JGxmpiWu+RCVv8QGgJaYmWeLodTBTcQSvYlXiwG/RkZEZp
         pGZmEA1ZSGVnLN8O4+GhsM1QW/M6hRK3LUgA7A6eb2PXexndwyEGdm4BSRNgmG9P1j
         m9/t7nyc9WJhx2mrcVj0LzAviN7qvrJxdJM4Og8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Hdq-1ib82n1x4k-002pLf; Thu, 05
 Dec 2019 08:52:48 +0100
Subject: Re: [PATCH 10/10] btrfs-progs: cleanups after block group cache
 reform
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-11-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ca92426f-3ac1-fedd-fdf4-a473b6be5178@gmx.com>
Date:   Thu, 5 Dec 2019 15:52:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-11-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YiJs1FyNykUn8CAO8gFnuFJCVOTGoQFCq"
X-Provags-ID: V03:K1:WcA7VDqXwlhNyrkS36/dcIUIWTFSaHGCxa7tG58w4tNaFqXlYdy
 3hKzZyqlTpMqt2cPqrmP6meMD/javbPgvx+hwOJll8EhVTDabAu6fm/WK5Smo88Av0q7uJt
 oI02ZiIuc5VUQc59tPcyMB3TOtj0zN+TmAYubkE6SchJrMJLnIUESTQ1AWJa+PQgIHkKrxa
 LhBEatf448Lve1t14dQHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:haNoWlv8Fw4=:KMUfiEgGuPklAGwfvL0mGZ
 4lOdeptYEbYz1OKEd91cwMWbNP1LdEuWAixmBL4ivzSFpWI//vCZFyrz5rvioqrOB3VCwvaCm
 6M60m9p2Z6pBFdqHWZttXruWaqcWUikSLwH4jbzNNUxzDRRUGd/PHbiaplgrdRQRyS3MV/f8+
 8WQW28b3dmuCh/7velQwnafopMNqkLdr5TtNtI9SCbL5wMDCDvdCdfpdQsp6jHdCOFba0ut47
 mnTQ0XctmHTdbjZwChcGkD296tSoGw8fGBXu559H2rmSAL07Xv347TLQoyPO3PzZiIQ7t38jw
 QYfGalrYbfKtiJZlDXM6DF/RfR1EsSdSWyekVDzGjOoelbsZD5HevMTGfyVMpbEJZYj5oGSay
 P2oaqJgnzQg+4GdOrzvXPMnHOwK8KeobVqWKHt2kL6xa9JuYVMl8uWuodW0EpvCRPexJV1xs/
 SBvC8DFtFoTw7MZkB6xPiyXkCOALCvenfuJqZltyVVwdsPHA76Yicthl8TuyzxiY242dHLQw+
 1Ua4wUDCKponkiq1jh89/NJb33gIRJWQEN/GUbPTkXWMsF4esgitN2EuRw7BcU9MBR4fiAEPP
 4CLQzI+kiothIrQqy8NRx88EDd2WxDo1Q3ZyIxUfTLDCjtndOcGM67kBDaukZRxaCL9qO7xRu
 Bx482Z2HK6DEhhbtVx4Ou1wOyZlYXCqVNq+CY5LVqZ01AX+K3fFsflAu1LnSJQuFG4F6NCCUu
 9oGkOAXwHhJCU5EOTPxxF6C8W21mMHwAnXJjqVnlgWmhBAAaRqfo6HRF28Hi0sUKBU2BT3GS4
 9mAYq4/VnAgabOgXci0b9RrBLVAbGBrtYsqFIzNVEEbUR+CeNvaovb0YYPsrp3UR7/SH+ERbL
 J7u74ZIxFAaoXZ0u5PCS+API4js/EilIY1liq2T85WZR757UNOU1ntGF4XBy9zR+IphXXs8jz
 PXLJjc6c53CRzIIyJuVHNEPgEjmtAUDPJQi0821Bl0znPmelgX6Sm+9JOIzw9s2uPG1J/jjhG
 rIMD5AqHmozfSns47Nz7XuO9z47Dhfmcm2j3GfwKk4ZOhuFhpQQcoarqVDgLIPNP+hasiyro6
 9cb89vGDXxfpR3qJtzcUQqWSxa6J2mbXl+kcdLmalwYrT6KsSiqoMxzB56fyiOgj/YwojUvIb
 rTwHeOzUCMO6pstcs+vIcNevnA415Vcq3A7Of9PSGJ+UMvGiwGi57qQQPBF0dATEBu9FqfwxH
 NdHEPg3ZkYDzsGgzYwN43Z02dIDhK+6YoQjTPj+EJqLLiMrQgF0kMDGdRPnU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YiJs1FyNykUn8CAO8gFnuFJCVOTGoQFCq
Content-Type: multipart/mixed; boundary="K9NlKkleRFY6pCg99kj44xda0Dx1czrqY"

--K9NlKkleRFY6pCg99kj44xda0Dx1czrqY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> btrfs_fs_info::block_group_cache and the bit BLOCK_GROUP_DIRY are
> useless. So is the block_group_state_bits().
>=20
> Remove them.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  ctree.h       |  1 -
>  disk-io.c     |  2 --
>  extent-tree.c | 12 ------------
>  extent_io.h   |  2 --
>  4 files changed, 17 deletions(-)

Everyone loves such cleanup.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> diff --git a/ctree.h b/ctree.h
> index 53882d04ac03..6d2fad6406d7 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -1146,7 +1146,6 @@ struct btrfs_fs_info {
> =20
>  	struct extent_io_tree extent_cache;
>  	struct extent_io_tree free_space_cache;
> -	struct extent_io_tree block_group_cache;
>  	struct extent_io_tree pinned_extents;
>  	struct extent_io_tree extent_ins;
>  	struct extent_io_tree *excluded_extents;
> diff --git a/disk-io.c b/disk-io.c
> index b7ae72a99f59..95958d9706da 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -794,7 +794,6 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writabl=
e, u64 sb_bytenr)
> =20
>  	extent_io_tree_init(&fs_info->extent_cache);
>  	extent_io_tree_init(&fs_info->free_space_cache);
> -	extent_io_tree_init(&fs_info->block_group_cache);
>  	extent_io_tree_init(&fs_info->pinned_extents);
>  	extent_io_tree_init(&fs_info->extent_ins);
> =20
> @@ -1069,7 +1068,6 @@ void btrfs_cleanup_all_caches(struct btrfs_fs_inf=
o *fs_info)
>  	free_mapping_cache_tree(&fs_info->mapping_tree.cache_tree);
>  	extent_io_tree_cleanup(&fs_info->extent_cache);
>  	extent_io_tree_cleanup(&fs_info->free_space_cache);
> -	extent_io_tree_cleanup(&fs_info->block_group_cache);
>  	extent_io_tree_cleanup(&fs_info->pinned_extents);
>  	extent_io_tree_cleanup(&fs_info->extent_ins);
>  }
> diff --git a/extent-tree.c b/extent-tree.c
> index e227c4db51cf..2815888b6cc5 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -333,18 +333,6 @@ wrapped:
>  	goto again;
>  }
> =20
> -static int block_group_state_bits(u64 flags)
> -{
> -	int bits =3D 0;
> -	if (flags & BTRFS_BLOCK_GROUP_DATA)
> -		bits |=3D BLOCK_GROUP_DATA;
> -	if (flags & BTRFS_BLOCK_GROUP_METADATA)
> -		bits |=3D BLOCK_GROUP_METADATA;
> -	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> -		bits |=3D BLOCK_GROUP_SYSTEM;
> -	return bits;
> -}
> -
>  static struct btrfs_block_group_cache *
>  btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_gro=
up_cache
>  		       *hint, u64 search_start, int data, int owner)
> diff --git a/extent_io.h b/extent_io.h
> index 1715acc60708..7f88e3f8a305 100644
> --- a/extent_io.h
> +++ b/extent_io.h
> @@ -47,8 +47,6 @@
>  #define BLOCK_GROUP_METADATA	(1U << 2)
>  #define BLOCK_GROUP_SYSTEM	(1U << 4)
> =20
> -#define BLOCK_GROUP_DIRTY 	(1U)
> -
>  /*
>   * The extent buffer bitmap operations are done with byte granularity =
instead of
>   * word granularity for two reasons:
>=20


--K9NlKkleRFY6pCg99kj44xda0Dx1czrqY--

--YiJs1FyNykUn8CAO8gFnuFJCVOTGoQFCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3ot0sXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjMVgf+PVPptsAbgsuYecdms5q+wxBZ
ZFiLzHL5v1934AP9XPlXNp9Gqpmz0s8XQAcENerLEGfAuVWVHEXpbpvJBH56NMrO
HWstPP29JHYnO8YLWn50y84qmej1PJy8mH6D6Wo2CskDG0UtpqBIyEUWiR85I1Pj
/1xayX9bejt0OWBmepPqLksFgSoZUg4ub/hFlM1yG/OhQxfalvAcYVtuDwqZ6wGP
hFbIOAvwOXuTkzBM/HiThImaCadRknxvJ9VLqPPLEwl3sJhVHyd0Kc4gKMZwjqo8
+P9RiESj97DFiIUyhybLX3g2Ob5lJwZm8P+lReFnHwe0srUTplmmZBdBLYl+PQ==
=4Bg9
-----END PGP SIGNATURE-----

--YiJs1FyNykUn8CAO8gFnuFJCVOTGoQFCq--
