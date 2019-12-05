Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34DF113C9A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfLEHwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:52:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:57323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEHwA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575532318;
        bh=BtLkYp1/Q7b2VDImTsau1sFxFtLA+tN14PV1JJSAMow=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bYIP2c0mGtubv4gNy5WFIMAsLRdXdLipCeMy5hGlGGBAXXFZdmAyq0+IBI95jh7rK
         LJi+7wpiLi0JKB8LhFoo9sgc70egj5c10LOiZzGGraW6QY5WPTP0m8pzOvv4IH5kjR
         yhlHub8EUbwpUlagyk5UNFX4lnK7ZsVR0JBlPyiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQEn-1i0u4o48Zz-00oagd; Thu, 05
 Dec 2019 08:51:58 +0100
Subject: Re: [PATCH 09/10] btrfs-progs: refrom block groups caches structure
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-10-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ea48239e-3bba-beb7-8960-e847f70b4a6f@gmx.com>
Date:   Thu, 5 Dec 2019 15:51:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-10-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2tAlAgva2scVBkpyYfEl84RaAUBhXJag3"
X-Provags-ID: V03:K1:Z1y2ubgRuctNiFBfPupGX8EB64woiEt0Jmz5cp875WFb9FT4Ozf
 oIyRRwgF3KACzlNkWK8K1sflCZWBui6H7NY3AQr1FrDzyk6SSUCexLf2Tx7zOutfqesSJIc
 j+rE/3tNDJe3f2IZfT6VSYhy+kOX0gxt+TSUCBsUBlf+pfU4zvzYrgf3QNPnIikVjFRbJoB
 g19Zz/jiSsRP5B94W8HCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AK+NxycoGyo=:8CGVs8FnwUV2GuML2uc9ks
 3tytln4pj7Co6xZs1zIfe1Cgn7oZUdjwEs/WgtCNw3eQ+KRT7pTwjfCBfs2sS9PTBPMySoIiB
 R2DGOe/bAzp/b4o7Am6L+sHF9yIZ/RcuevF9td8SeTaOgbRQ8BQZKvJNkHRUzGBA/Ug9H0j1F
 ilxZgW/7/fYYeXa5tZfwitH2grU7CuJyfmm7i+IkD2b8h5DO25ywJInQTZFrZu/QYZpkvHVQd
 VkHLdl4o1INcCbBrbeOHU/mJfkKn+FKfGFoZzh5czbxPBuPF8yiJ6hV1DKv5oNbPzdE3WkocA
 8xMUpXq+p/7JiQaHcJCVwTZ0v/+45eBclUp3G31XnUVbbpoMYTDKB8g42acT0Oad6eEMSGioa
 c8IE9Qk1MtVUMvaW/7JHHAV7rzAPrysoTtDomyzVvfxI6PjKcRB0id0KkPgeFbcXWjK5Gfve0
 z8wmCWWIcsTNQ7n1YZWN3RcV5fQuR/00+z86tPpIBn04LHm0/K6gIvvnu640QmHVHqVO2ZJpC
 VC1JvfuJvc9JznXGWJ2s8rM4Htv+q+afn+y3lv0Zf2GEUnFGD1ct7an8V9qoeLBFPTOH3C1lx
 vo9rcvKD8IvuqvhdZaAKtQ29Dby/dJMjeMhVSu6Iva3HK+8OUZdUTc7Bz4ORIn67rUvMPQb5k
 yXhOFP9ndP+vi6sC/hxQ+F/1H/RZoMjMB5WYI/jezZoZR3w3Ua6GzyIi2SsPVl83ieuzMjxK+
 dilzRCCcGH3Tx/w9DlDsfqc7XaPqIbooe64uwYnISQecwe5LKN2Jt49H6NLF3pMnC5vKJh6rG
 CFpZ5vxWCsgyLEK5mAiWRtyaCRh6Vd0+UO1jA9HgW6WtEWfQ0C7ehuAPuObtAFWHkS0Q+60+C
 1Hj3MNiRATnR8hczJk+3XX8ZFstcx8b0PQCo3+eIrmbrvupzeb0SyOQc0drC2tcP23mSLsH4z
 YUPfgXbBlPRbo8hdCRt1IjLKA8fg0RQSwsCVB9G4NZnWK3tMiiv8l0gXMlfdi6flgBHHofJ8g
 dkZ2LrO3MbRQ8wDZVNkBhFTXXe/drFnssmC3aSoTTjX2o7vS63Jk0hzpZtjxB++vdt5uulHX+
 O8R+/RmfKjMcVqeUC+/Isr5uSWdLM0xCPHJgbPf7ek2h1UFsYsos6mDWsIvTa1HNPKO8DnW5z
 J/WZEHBV3aMgnA4QVu2z3+z56JISG1mxm4IUZCI7hRfhyeK61JyI3b1eGVba8i3Y1o16bO0dV
 Bel4jiDEn9b8Jh+jvZukBLsa6lSkBvxCaYO9FUW6+BDBFl0CjcpMzD+nCh9c=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2tAlAgva2scVBkpyYfEl84RaAUBhXJag3
Content-Type: multipart/mixed; boundary="qVQeiQU8RnnLPR12SL2So3pVWFk08DqA8"

--qVQeiQU8RnnLPR12SL2So3pVWFk08DqA8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> This commit organises block groups cache in
> btrfs_fs_info::block_group_cache_tree. And any dirty block groups are
> linked in transaction_handle::dirty_bgs.
>=20
> To keep coherence of bisect, it does almost replace in place:
> 1. Replace the old btrfs group lookup functions with new functions
> introduced in former commits.
> 2. set_extent_bits(..., BLOCK_GROUP_DIRYT) things are replaced by linki=
ng
> the block group cache into trans::dirty_bgs. Checking and clearing bits=

> are transformed too.
> 3. set_extent_bits(..., bit | EXTENT_LOCKED) things are replaced by
> new the btrfs_add_block_group_cache() which inserts caches into
> btrfs_fs_info::block_group_cache_tree directly. Other operations are
> converted to tree operations.

Great cleanup and code unification.

Overall looks good, just small nitpicks inlined below.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  cmds/rescue-chunk-recover.c |   4 +-
>  extent-tree.c               | 211 ++++++------------------------------=

>  image/main.c                |   5 +-
>  transaction.c               |   3 +-
>  4 files changed, 38 insertions(+), 185 deletions(-)
>=20
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 461b66c6e13b..a13acc015d11 100644

> @@ -2699,25 +2571,22 @@ int btrfs_free_block_groups(struct btrfs_fs_inf=
o *info)
>  	struct btrfs_block_group_cache *cache;
>  	u64 start;
>  	u64 end;
> -	u64 ptr;
>  	int ret;
> =20
> -	while(1) {
> -		ret =3D find_first_extent_bit(&info->block_group_cache, 0,
> -					    &start, &end, (unsigned int)-1);
> -		if (ret)
> +	while (rb_first(&info->block_group_cache_tree)) {
> +		cache =3D btrfs_lookup_first_block_group(info, 0);
> +		if (!cache)

Since we're freeing all block groups, what about
rbtree_postorder_for_each_entry_safe()?

That would be faster than rb_first() as we don't need to balance the tree=
=2E

Despite that, the patch looks great to me.
Especially for that -185 part.

Thanks,
Qu


--qVQeiQU8RnnLPR12SL2So3pVWFk08DqA8--

--2tAlAgva2scVBkpyYfEl84RaAUBhXJag3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3otxkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhxQwgAp+ovtUqtEqgpXn6A410zJRiy
vMU4734mUB5/RUL8gX0xUN+3C5h5fawgRGjIowUWJA/thZzbtRyQeDiJ+Ru1B5VQ
28105R+9Cc7mpgVI5n4t22xuIBhZK3ve5Ph+GDBl2UYCG9VLRClYTpS2PpnPUdqf
cGi/oaKgXe5Rta/nIKCILPGQRA3QpKot/ej/a5B7SGS5caDyP27dJs6RGziSs9xO
pmOpaIYfLK52aVNl87MYhMTVIpX0nWBsXs/fPXU9MxhWsZytpwDbpGzAUZ7ufs7i
vM1M0BUU6gOHVL7Dc8SvxuY7/TDRz+CDch1AyZQeJDkWkogs+mlCsdCSg+mImw==
=NCFI
-----END PGP SIGNATURE-----

--2tAlAgva2scVBkpyYfEl84RaAUBhXJag3--
