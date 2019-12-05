Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C3113C79
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfLEHmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:42:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:36619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfLEHmU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575531737;
        bh=2ZBKnZ4SQpvPhPzkWIaB7gg5UuTxvlyKDq8nqo9PY9c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MaAAvs2pC4VD+iHJBdNxJK0PoTKBJkUCrdUMiqMysaQ+fh0621ELhmjo40y8Lp4kr
         V5BA1w7M5Yu2PSIjvqOJvraGyou6aC1jfHMVsY/dd8SPGeNZWrgx4H1rCxqUtTlHlI
         U8sWR8tOwthQfEOUBIdfdlGjprOuj/RyPpSX1tJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1iMbwC030v-00Iymd; Thu, 05
 Dec 2019 08:42:17 +0100
Subject: Re: [PATCH 06/10] btrfs-progs: abstract function
 btrfs_add_block_group_cache()
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-7-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bb408d9c-446d-35e8-d1ce-0205d018fb2b@gmx.com>
Date:   Thu, 5 Dec 2019 15:42:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-7-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D8MJcoO1xboyyVbZGhfdqnlHL4jx9Tn2w"
X-Provags-ID: V03:K1:Bl/7qEYRFcBlCZ3mVx/s8HCDO1/ryofQoEQPf3uC0koJRnObYxR
 6JGhyI7pPsgYkSmIPQjPMkHLuSMQaSxfQr1JWbBaFOcb83ltFuopGLoPuv/lhX2VmN67paA
 v9JlBbgcDXrCeuJUj8VzUHNCskzU0jbYI+QSNACv0qpryfLKI9DNnfdlyJISGlNgIhVEifi
 acyeJw6FxY5yuuAP2W6VA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:42JlqaqFA40=:AjpxRBuV2Y/jZFa6/+0U2e
 ci2SSNZJ29/sBWtimk/CXMTltmsPgVZUvIxuxMN+H/Wlk2mbT/VsYAtltIDo11Mgn3/xbdZy/
 6p5CEmpvwukbrmm8Z3y0DcRoAXb4OOBKysk57EA/95ZmveYeaNGfKH7DPZcsGHVP1DCHU4yXP
 Zl7nioYlAK6obeD9Urpqia1TD8+6A547icr4yzAK4tnt+QwylKIVF0hqogSIPRYWj6AMGNht9
 vBFYRHPl8H5UN9MN9x7DumvGFSL413vUfIYxOxvINQ7AVnAzpCIwolcH4IHPWRUXwGXSFHMxg
 +hSR5yjnz51RrnMs9wY2mE0deuywcofMY8ZHn8CRq8PJ3h5Qgx45CLmvNJE/TTn/d9R69xyyH
 HqG3AXbgoXtfkxJKpCbtIxhhOVyTZjkN7uCa6Rzij7tXHn949zz2wI9EkAb/Dmj+JCxf8iNj5
 Rtq2crPXDBLIkn7kcVVby0oWqFidiFcQWu96m6Nli6+vVqKncHsMxqZ1z7Nkg8+mFPbydl4R2
 RadS5PRTVpFbe7DbIOVI89ukxk6svugDOYIYskLHF+ZyK4nCMvPKfHpBe2yJ5fMJfNOp9IJxG
 5VCmfuXfMtod/V8Oc7aWVhg9l2LuG5nv1mFggtiYZB2upe0MuKl05tjUDVSAUpMqf0afJSS4J
 bcukZUVrnsCn7LozmlcAa4lz7wAdQXcL3JbB5uf/p1dPqSX4dWwjdwrm/D4AcCTooB6bXCl0c
 xirQDXlc+QRw0Kd1PVg2Bl+1fPMttnXHp96viYiaG4q2IdGG+dK5Gz/agvgpQnFI3bge5uNc3
 1JSHU113Ra/2pS05C5K1m2G7ChLjdA0eHQxDw0/aiNmeQ1gH8DrMtKqcDzLa+fgRYwd9CZavI
 zFdSTDPrTqHf95qDSqJ9FBUsqtYVl6IHrX2F9sFqTbbyJ6GMnNcb+dDuRKX9mN+GZ7/Jjz7u1
 0lr/cSGEXB7ncmxX+sOiKPhFex8ZLR0SAvjzU74glDkYxIVM/27aSabj7nomJ2BwIqnsUdP/J
 t235JUkoJ+4bNtR577QJ9UjWndRE6Hw1YUlyyGMxYOiy5LVibwK/HXrruBbpSEF8qI4zbbBGp
 9n0cI2XFJA4PUiRZpKGvfW7aCKvpLQUUZd4Yo4MTrT6CwZHoJU+nFJM8w/yAad2S+/jX94kjC
 M5kjuI6bEVVoBEtlJCu4zuTLyyCF/8cIeEcEpZsPLbR+3cyGuhUtG2Z8B04fUx8gL9GYf6FXU
 ifcnUpPuHri961Bcd5MyPJ4mhP/CbkJU8XmxNdf6hClwWGG23xuu7H3wl43M=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D8MJcoO1xboyyVbZGhfdqnlHL4jx9Tn2w
Content-Type: multipart/mixed; boundary="hAnDLRmfRF17A1pXy6lgWJP25FOmQIWLd"

--hAnDLRmfRF17A1pXy6lgWJP25FOmQIWLd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> The new function btrfs_add_block_group_cache() abstracts the old
> set_extent_bits and set_state_private operations.
>=20
> Rename the rb tree version to btrfs_add_block_group_cache_kernel().
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  extent-tree.c | 50 ++++++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index 274dfe540b1f..ff3db5ca2e0c 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -164,10 +164,31 @@ err:
>  	return 0;
>  }
> =20
> +static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
> +				       struct btrfs_block_group_cache *cache,
> +				       int bits)
> +{
> +	int ret;
> +
> +	ret =3D set_extent_bits(&info->block_group_cache, cache->key.objectid=
,
> +			      cache->key.objectid + cache->key.offset - 1,
> +			      bits);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D set_state_private(&info->block_group_cache, cache->key.object=
id,
> +				(unsigned long)cache);
> +	if (ret)
> +		clear_extent_bits(&info->block_group_cache, cache->key.objectid,
> +				  cache->key.objectid + cache->key.offset - 1,
> +				  bits);
> +	return ret;
> +}
> +
>  /*
>   * This adds the block group to the fs_info rb tree for the block grou=
p cache
>   */
> -static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
> +static int btrfs_add_block_group_cache_kernel(struct btrfs_fs_info *in=
fo,
>  				struct btrfs_block_group_cache *block_group)
>  {
>  	struct rb_node **p;
> @@ -2769,7 +2790,6 @@ error:
>  static int read_one_block_group(struct btrfs_fs_info *fs_info,
>  				 struct btrfs_path *path)
>  {
> -	struct extent_io_tree *block_group_cache =3D &fs_info->block_group_ca=
che;
>  	struct extent_buffer *leaf =3D path->nodes[0];
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_block_group_cache *cache;
> @@ -2819,11 +2839,7 @@ static int read_one_block_group(struct btrfs_fs_=
info *fs_info,
>  	}
>  	cache->space_info =3D space_info;
> =20
> -	set_extent_bits(block_group_cache, cache->key.objectid,
> -			cache->key.objectid + cache->key.offset - 1,
> -			bit | EXTENT_LOCKED);
> -	set_state_private(block_group_cache, cache->key.objectid,
> -			  (unsigned long)cache);
> +	btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
>  	return 0;
>  }
> =20
> @@ -2875,9 +2891,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_in=
fo, u64 bytes_used, u64 type,
>  	int ret;
>  	int bit =3D 0;
>  	struct btrfs_block_group_cache *cache;
> -	struct extent_io_tree *block_group_cache;
> -
> -	block_group_cache =3D &fs_info->block_group_cache;
> =20
>  	cache =3D kzalloc(sizeof(*cache), GFP_NOFS);
>  	BUG_ON(!cache);
> @@ -2894,13 +2907,8 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_i=
nfo, u64 bytes_used, u64 type,
>  	BUG_ON(ret);
> =20
>  	bit =3D block_group_state_bits(type);
> -	ret =3D set_extent_bits(block_group_cache, chunk_offset,
> -			      chunk_offset + size - 1,
> -			      bit | EXTENT_LOCKED);
> -	BUG_ON(ret);
> =20
> -	ret =3D set_state_private(block_group_cache, chunk_offset,
> -				(unsigned long)cache);
> +	ret =3D btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCK=
ED);
>  	BUG_ON(ret);
>  	set_avail_alloc_bits(fs_info, type);
> =20
> @@ -2950,9 +2958,7 @@ int btrfs_make_block_groups(struct btrfs_trans_ha=
ndle *trans,
>  	int bit;
>  	struct btrfs_root *extent_root =3D fs_info->extent_root;
>  	struct btrfs_block_group_cache *cache;
> -	struct extent_io_tree *block_group_cache;
> =20
> -	block_group_cache =3D &fs_info->block_group_cache;
>  	total_bytes =3D btrfs_super_total_bytes(fs_info->super_copy);
>  	group_align =3D 64 * fs_info->sectorsize;
> =20
> @@ -2996,12 +3002,8 @@ int btrfs_make_block_groups(struct btrfs_trans_h=
andle *trans,
>  					0, &cache->space_info);
>  		BUG_ON(ret);
>  		set_avail_alloc_bits(fs_info, group_type);
> -
> -		set_extent_bits(block_group_cache, cur_start,
> -				cur_start + group_size - 1,
> -				bit | EXTENT_LOCKED);
> -		set_state_private(block_group_cache, cur_start,
> -				  (unsigned long)cache);
> +		btrfs_add_block_group_cache(fs_info, cache,
> +					    bit | EXTENT_LOCKED);
>  		cur_start +=3D group_size;
>  	}
>  	/* then insert all the items */
>=20


--hAnDLRmfRF17A1pXy6lgWJP25FOmQIWLd--

--D8MJcoO1xboyyVbZGhfdqnlHL4jx9Tn2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3otNMXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiTsAgAoISVdfwJWYPOmA/NuAWs6yEL
GaCnfqbI4pkFOuqXoVFNrV3uSl8NCRaeBbFce3IiGZZIf1AkDnhUAyuScvKouEP8
WpT6EyI1usDjauPRGg32E4WcXl/tx28SQ0xURXhpqgcp0zkOmAMIVkcuPvE2/RbF
DvTSiQNdpLn5jgEYcMM7L/7n/6pqYuRTVifZ3+3J5Vnp00ZvwZFj1g2LuKaUA4nJ
TW/cbBXsVqBAFbPuBSfgu48q3WB+hJ5PYJcKMPyJFKtKd2jzfIVC3pz7ZN9GiWT8
/dgvS6zpbLSLMqtKB2/eqwlDzyIyEiIlL+5UkkHY8trZvXQrN2NdCoCiBCeldg==
=XkAM
-----END PGP SIGNATURE-----

--D8MJcoO1xboyyVbZGhfdqnlHL4jx9Tn2w--
