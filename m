Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D62A113C7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfLEHnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:43:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:39793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfLEHnd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575531811;
        bh=3GJJ3kL0/E7ieGEgn5BRz1tdNSe7qiyoL56r78lzFtU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AspKIa7zSNt9qnvXyTZznWdsH7dUBD0rLQJpgpuQdVenEerQO7M+Y+XYAI3KehzMi
         LDE+GkAg9ccxzAM7lKiMaIgj017wU7rHGVtPn92mwl9o6jiyoiHHa5y5byv/ufpmSI
         hRo0A7MOxswceOAK+dLjr87KLOeuKk2FZcs5f15M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1iMt6a0c6w-00JFmj; Thu, 05
 Dec 2019 08:43:30 +0100
Subject: Re: [PATCH 07/10] block-progs: block_group: add dirty_bgs list
 related memebers
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-8-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1e30b37a-539c-5062-4651-368277085cdb@gmx.com>
Date:   Thu, 5 Dec 2019 15:43:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-8-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GIIQZHmvruCVhIEp67U5SP62uOIqKb9AC"
X-Provags-ID: V03:K1:nz9QnnRyd9UG8H7R9tm+zt7CjUaf/gAscwRVw3TlWellDC+4rvE
 lZcL2HmM/VZKHD62z3/TLO4FYLgNJut+EFd2lIBqxZ1a1r6+mzKagWEpJvgJSqKeMnjnI1K
 6qlmSIGfUrkl11BQ7v93tNJipbR/QyljiaEH2RjrdfV/gpIYYZvcAdLvFNxh6PFB5dWKzov
 MjppcP+eNjSUuGsqwickg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eMRMnfeoPO4=:gKX+htyeamMkRJrpxG1UMC
 TUyMttBw5vV4wBCNBjWALbB/qbAbUV84aqg9KEVP8WOmiUAc/Ia+g3TevQHqubPQgJp2l7vyI
 Kc2mCujkYe2F1N0Xdlt1b33lraxEoTCcmurqpUFrGRlh47ujcqw5U7TTSdmRjYBtTv1opBXnS
 zAcDXqWUSzt0PHvdNpxOGVPvTnViYfzoWmWcgYafB50nxA1gjmsaE/6sdSnZ9JVik+a3R5CEl
 Teju1hvDM8GWmQX5ZZgF6q68W5FcxJxA3+W9KplieZLPZvYSqNeC+EmEVMhBAkhnHCoznnyyL
 uaiifXpxLmrJTm9aWMoSXN9SUg8J5nUuloTNhc5e+Z+zoHLd1dsC5CLCsleEp5asOmTBx66Iy
 t26Al5VxL0H5AfxDi1fnfJbj1Eu5KVTXNNtutOXxlIlsrhhyQWOlZbmLmJdhsPReRJuSm5TUA
 kgAUxVBj7+aTg7DSJISbjvtJS6NKt8nK7pWixQcs4OK6eQYrUNWSbIJZZ/kYMqTaOP5GbVWMH
 /AFDx+56kXGzxBgfkla2N5bAQUfdfXoQ0cvrfvI+54xVAUS9r7CaZeQbLyBe+RwuMKZhrTkF+
 Po1X0pJsk7Me4N6QgKK/14qRPMTq6uRR5tpwi5O74acWzHHOphpQ2rnjHKj1D5RRyqpZFcfxK
 CsaamcElKeEegzUAnrl0ztDXqJAkko9voeHRwiVKnIRLTYx7v9V6fwI0QJaRM+qTezrx2RP5u
 3jxix7K9RYAI5LJe09/Ze4dJ0eT2jVbVWd51r9FHyXzLcILWkXRQsdixsn8nRIX+j39eJQBG9
 XLu3221YkKMJuZM2qlfKHjJ3wEtcEHW9vRwQqpvxPeWoZmpY2y3oc6+43Ml5DEg/Xn5TCfyD5
 QuoG33e88N+8mU/H7PFIKJly6sdcm3RY1UtLZd0IW4D4ZukagnZbJrVw/CYrn2fegI/HmoUx+
 x+ip8uM0Y4bcQSBEwzyHuNPUjmpdTCIwakAJI39NoyGYZqMIHeMP3pnxU9IFdrmzBil+LI/1G
 xpGPAotr8So/7eXHtTZmtupnZ8DGuPlYUlMv4Khyp8Z7x/YsjBwimeoYYrsVi/lo+ikRSrbhr
 ++PY5aZViztPFft0kzQC7RQB27XNAvcjuQoFrmNGrSpfHMwOYx1KXA5Rx0/sk4iSTqH9BvPHz
 fCnUyzeSQcGkUZG0o1UTaiM+FiI3gGfUtx9gZeD3KlXKoJSpmg3x/t/XvEpkO2l86giLlEnDO
 RZamT2X2M1YU5jQGJl78ApycDxWgcMbLo1OLaeiP1yiQjg6YvgQF7fG6ExKY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GIIQZHmvruCVhIEp67U5SP62uOIqKb9AC
Content-Type: multipart/mixed; boundary="YTaxAO7K6mjotNnFYNMRurWtkwVrp4zS4"

--YTaxAO7K6mjotNnFYNMRurWtkwVrp4zS4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> The old style uses extent bit BLOCK_GROUP_DIRTY to mark dirty block
> groups in extent cache. To replace it, add btrfs_trans_handle::dirty_bg=
s
> and btrfs_block_group_cache::dirty_list.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  ctree.h       | 3 +++
>  extent-tree.c | 4 ++++
>  transaction.c | 1 +
>  transaction.h | 3 ++-
>  4 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/ctree.h b/ctree.h
> index f3f5f52f2559..61ce53c46302 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -1119,6 +1119,9 @@ struct btrfs_block_group_cache {
> =20
>  	/* Block group cache stuff */
>  	struct rb_node cache_node;
> +
> +	/* For dirty block groups */
> +	struct list_head dirty_list;
>  };
> =20
>  struct btrfs_device;
> diff --git a/extent-tree.c b/extent-tree.c
> index ff3db5ca2e0c..981622e37ab7 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -2819,6 +2819,8 @@ static int read_one_block_group(struct btrfs_fs_i=
nfo *fs_info,
>  	cache->pinned =3D 0;
>  	cache->flags =3D btrfs_block_group_flags(&bgi);
>  	cache->used =3D btrfs_block_group_used(&bgi);
> +	INIT_LIST_HEAD(&cache->dirty_list);
> +
>  	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
>  		bit =3D BLOCK_GROUP_DATA;
>  	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> @@ -2900,6 +2902,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_in=
fo, u64 bytes_used, u64 type,
>  	cache->key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>  	cache->used =3D bytes_used;
>  	cache->flags =3D type;
> +	INIT_LIST_HEAD(&cache->dirty_list);
> =20
>  	exclude_super_stripes(fs_info, cache);
>  	ret =3D update_space_info(fs_info, cache->flags, size, bytes_used,
> @@ -2997,6 +3000,7 @@ int btrfs_make_block_groups(struct btrfs_trans_ha=
ndle *trans,
>  		cache->key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>  		cache->used =3D 0;
>  		cache->flags =3D group_type;
> +		INIT_LIST_HEAD(&cache->dirty_list);
> =20
>  		ret =3D update_space_info(fs_info, group_type, group_size,
>  					0, &cache->space_info);
> diff --git a/transaction.c b/transaction.c
> index c9035c765a74..269e52c01d29 100644
> --- a/transaction.c
> +++ b/transaction.c
> @@ -52,6 +52,7 @@ struct btrfs_trans_handle* btrfs_start_transaction(st=
ruct btrfs_root *root,
>  	root->last_trans =3D h->transid;
>  	root->commit_root =3D root->node;
>  	extent_buffer_get(root->node);
> +	INIT_LIST_HEAD(&h->dirty_bgs);
> =20
>  	return h;
>  }
> diff --git a/transaction.h b/transaction.h
> index 750f456b3cc0..8fa65508fa8d 100644
> --- a/transaction.h
> +++ b/transaction.h
> @@ -22,6 +22,7 @@
>  #include "kerncompat.h"
>  #include "ctree.h"
>  #include "delayed-ref.h"
> +#include "kernel-lib/list.h"
> =20
>  struct btrfs_trans_handle {
>  	struct btrfs_fs_info *fs_info;
> @@ -35,7 +36,7 @@ struct btrfs_trans_handle {
>  	unsigned long blocks_used;
>  	struct btrfs_block_group_cache *block_group;
>  	struct btrfs_delayed_ref_root delayed_refs;
> -
> +	struct list_head dirty_bgs;
>  };
> =20
>  struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *=
root,
>=20


--YTaxAO7K6mjotNnFYNMRurWtkwVrp4zS4--

--GIIQZHmvruCVhIEp67U5SP62uOIqKb9AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3otR4XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjXEQf/TEPI9GVx5LW5TRjrHzyav7vI
AU3VMXtfrbp6D7dcsteQjHawf0fCtlS7MXvAdPOmS1U7jZIFCYQn5I6uQ3F4M8j+
+kqUedSMw6RjaKBGq2hnusbVGrto+8C4tXvBgM2w0s8zTRRs0z1B/6bCfs5VNluR
RbI8jzVOz6qnAwvNsI80XdbHYRVSey3TmPBKlQorbflv0Z+5dfi1eLnRQ1DJk66f
0iWTbUyy19ivWUG0CkTONeE3DM84W1ty+Bro0iioPV86fNbiWbGVBfttHyfPpIjf
BWhcoRxbf1jkcFsa7Dx5sHYdASf+b0+4Eeo8cGparEsS/jw539ZdVAgLA7phZw==
=qCBu
-----END PGP SIGNATURE-----

--GIIQZHmvruCVhIEp67U5SP62uOIqKb9AC--
