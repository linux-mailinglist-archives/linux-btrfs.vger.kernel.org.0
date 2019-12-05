Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC742113C89
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfLEHpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:45:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:39881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfLEHpF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575531902;
        bh=ZP8GL4CQafqB3CXVcjb8z3kSzaJA8VGjlFcGdA5JDLc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CV4GniFnatN7VdWA9FwUHU6FZshVLcAF+ggqEq6NdLF39qzjwW7cAr4H6jNM3hsbo
         2RP3WODayOXeP3Q3cOC5XbczcPUh6SOxJnF4uwnnwRJoWnw3j+IkkSA+NX6w3hmZCJ
         q70t3JTx/lkQ2F4WUG/8jD1+j3tLqMtq00kaY/0Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3DW-1iW7y10fEm-00FUDO; Thu, 05
 Dec 2019 08:45:01 +0100
Subject: Re: [PATCH 08/10] btrfs-progs: pass @trans to functions touch dirty
 block groups
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-9-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <968c9970-8262-5378-71d2-e2811d350a64@gmx.com>
Date:   Thu, 5 Dec 2019 15:44:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-9-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8IQOlYOITdmdmkTUOveX6OgocHam3YKqj"
X-Provags-ID: V03:K1:EfDSsh5EjVZx1FmGTp+BHi8ZCvaPHnceT7Odetoc68XyCdjZfhy
 gsBBEWI56mcAApCTfiY2WO7lg8zEssh0PXGMBtNjNC8wAk5HUgRUxW47De+XZZWYIjnxFmA
 5d4Uab92s64tX8MARzqehe3zxuRUE97H+RYe5PuBzRL7FD1oNCjRZiOlOE5w78APNAPkOoE
 7MPs4INZI2iLU3J7zKzxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjxPDpIrCYA=:f0TUlajWGPfqSZdvT+jgk+
 9ylqntPVYjjvBiTeZ7DlgDzc4h0esArzgxs0uDMyBebf2i9BVoajBX8QWktNP4G2rAH3FR3C5
 +PlcmaVjFARdTKvWSTNQPrKqdXxvNwGgzbspbG9dwEB9vFd/qmboVxpf31GDrVowNru/pXaGW
 6JqCKbxHC6m0d0hlBiQXL6at+T1WoqfRNY8+P5uEXmAQdDESK3F4kDcnO+YsO2OnCLfp1Rr6i
 nZmY3OY3XnXBfsUAmNkDUpxC8pcvfvQSrW2tx15bZQa7K5UIpvIlFCrYWZsh+VH7NNYuwzWvJ
 tpMiUrAla8MqTFlnlJ3qwyZG2dV3PviA0U4pIJdhgziWrMzkBa0zPmm3fGp+8SeMs26j0Nk2T
 SrtOjjqralDvn4TUSAdllU+T71tytdgKq2mF7DP5yWN3baHjhVoYEv8G9pEGOaAVLMh94bjOx
 gMuEGM0OAbrfGcbz0BdtUt+Rn07upTxO5NsnihN4c8oVpJ9CkeEcAukzZenTyZnqiztSwaXgL
 e5L7U/5UEd8WPbWkpUm46B9Qf2eH8ZuZBB+9mJkFDJT9Bx3Vze9o9vZjOEdcsxEdxh9e0j0cX
 nYjgtcTO9h0rGw/Ej5YxUvrf4FvkVTY7VbtFx51AI8ujMzP62JITNgPyFa86X4b1zEyqKh5oV
 H68jGdCXFnwp1vtZDcerqgP7Qo/ujCYQOzUAi5o3QvAl/MUr/fg1ASPBWfC41jUviR2hyOT4B
 HDE57Db40uUrCZmbtI6UZ7TQ7UXCXBVmaK+2iTq4OPOJJpPADthJcmnVQ9yQ1f8xl1RLVbsif
 cLOOf3AAXKAMaRE4NZMfQn9VcEinIYWgsY+5gbymukOdgG33XjunDc+7swj1Ol06CXwsanimm
 rTV1A6XHyI3AYTUq7dpHb9xnJ9EVAUJEdJxTNHzILY02Vn7kAxt1MgPrx3FsryHUQNyymVwls
 gpm46sC57uDQuA9IWrxgk4XkzNTO9QhQCamauS5Bxyyt9qSc1KG7+y6HaVAzpo9A3UvXquyr3
 jrhJnSoVuIEYPpANTuDajvusn88RLVFbgiFo62F8WxVtSlMawPzGRTDcwqplzom0iVm2fq4mF
 oW+W4WKQLLfGyrExYm7yLi/AbaPMGSSn291Wr7m59R/SWl+BARIul26miUdDo5LyQMWj2ndyf
 cdn89gccyZ+sdLw8ASwsv8kIHjfGnp1FAEUsNklcS2zCfcrrFytC/qNaV/agraQkqXa+czGTD
 nzwQ1ynBPLrdSZFg46Xkm0OF/d1lMrsOeG0KN7NcF2uY0Dr9OCpHTlXtEiDY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8IQOlYOITdmdmkTUOveX6OgocHam3YKqj
Content-Type: multipart/mixed; boundary="7jrOEHILSRKsfQBN3ZMSLcvzF3BdVqBGd"

--7jrOEHILSRKsfQBN3ZMSLcvzF3BdVqBGd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> We are going to touch dirty_bgs in trans directly, so every call chain
> should pass paramemter @trans to end functions.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  check/main.c                |  6 +++---
>  check/mode-lowmem.c         |  6 +++---
>  cmds/rescue-chunk-recover.c |  6 +++---
>  ctree.h                     |  4 ++--
>  extent-tree.c               | 18 +++++++++---------
>  image/main.c                |  5 +++--
>  6 files changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/check/main.c b/check/main.c
> index 08dc9e66d013..7d797750e6d6 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -6651,8 +6651,8 @@ static int delete_extent_records(struct btrfs_tra=
ns_handle *trans,
>  			u64 bytes =3D (found_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY) ?
>  				found_key.offset : fs_info->nodesize;
> =20
> -			ret =3D btrfs_update_block_group(fs_info->extent_root,
> -						       bytenr, bytes, 0, 0);
> +			ret =3D btrfs_update_block_group(trans, bytenr, bytes,
> +						       0, 0);
>  			if (ret)
>  				break;
>  		}
> @@ -6730,7 +6730,7 @@ static int record_extent(struct btrfs_trans_handl=
e *trans,
>  		}
> =20
>  		btrfs_mark_buffer_dirty(leaf);
> -		ret =3D btrfs_update_block_group(extent_root, rec->start,
> +		ret =3D btrfs_update_block_group(trans, rec->start,
>  					       rec->max_size, 1, 0);
>  		if (ret)
>  			goto fail;
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index f53a0c39e86e..74c60368ca01 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -735,7 +735,7 @@ static int repair_tree_block_ref(struct btrfs_root =
*root,
>  		}
>  		btrfs_mark_buffer_dirty(eb);
>  		printf("Added an extent item [%llu %u]\n", bytenr, node_size);
> -		btrfs_update_block_group(extent_root, bytenr, node_size, 1, 0);
> +		btrfs_update_block_group(trans, bytenr, node_size, 1, 0);
> =20
>  		nrefs->refs[level] =3D 0;
>  		nrefs->full_backref[level] =3D
> @@ -3292,8 +3292,8 @@ static int repair_extent_data_item(struct btrfs_r=
oot *root,
>  		btrfs_set_extent_flags(eb, ei, BTRFS_EXTENT_FLAG_DATA);
> =20
>  		btrfs_mark_buffer_dirty(eb);
> -		ret =3D btrfs_update_block_group(extent_root, disk_bytenr,
> -					       num_bytes, 1, 0);
> +		ret =3D btrfs_update_block_group(trans, disk_bytenr, num_bytes,
> +					       1, 0);
>  		btrfs_release_path(&path);
>  	}
> =20
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 171b4d07ecf9..461b66c6e13b 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -1084,7 +1084,7 @@ err:
>  	return ret;
>  }
> =20
> -static int block_group_free_all_extent(struct btrfs_root *root,
> +static int block_group_free_all_extent(struct btrfs_trans_handle *tran=
s,
>  				       struct block_group_record *bg)
>  {
>  	struct btrfs_block_group_cache *cache;
> @@ -1092,7 +1092,7 @@ static int block_group_free_all_extent(struct btr=
fs_root *root,
>  	u64 start;
>  	u64 end;
> =20
> -	info =3D root->fs_info;
> +	info =3D trans->fs_info;
>  	cache =3D btrfs_lookup_block_group(info, bg->objectid);
>  	if (!cache)
>  		return -ENOENT;
> @@ -1124,7 +1124,7 @@ static int remove_chunk_extent_item(struct btrfs_=
trans_handle *trans,
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D block_group_free_all_extent(root, chunk->bg_rec);
> +		ret =3D block_group_free_all_extent(trans, chunk->bg_rec);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/ctree.h b/ctree.h
> index 61ce53c46302..53882d04ac03 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -2568,8 +2568,8 @@ int btrfs_make_block_group(struct btrfs_trans_han=
dle *trans,
>  			   u64 type, u64 chunk_offset, u64 size);
>  int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
>  			    struct btrfs_fs_info *fs_info);
> -int btrfs_update_block_group(struct btrfs_root *root, u64 bytenr, u64 =
num,
> -			     int alloc, int mark_free);
> +int btrfs_update_block_group(struct btrfs_trans_handle *trans, u64 byt=
enr,
> +			     u64 num, int alloc, int mark_free);
>  int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
>  			      struct btrfs_root *root, u64 objectid,
>  			      struct btrfs_inode_item *inode,
> diff --git a/extent-tree.c b/extent-tree.c
> index 981622e37ab7..f012fd5bf6b6 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -1877,9 +1877,10 @@ static int do_chunk_alloc(struct btrfs_trans_han=
dle *trans,
>  	return 0;
>  }
> =20
> -static int update_block_group(struct btrfs_fs_info *info, u64 bytenr,
> +static int update_block_group(struct btrfs_trans_handle *trans, u64 by=
tenr,
>  			      u64 num_bytes, int alloc, int mark_free)
>  {
> +	struct btrfs_fs_info *info =3D trans->fs_info;
>  	struct btrfs_block_group_cache *cache;
>  	u64 total =3D num_bytes;
>  	u64 old_val;
> @@ -2242,8 +2243,7 @@ static int __free_extent(struct btrfs_trans_handl=
e *trans,
>  			goto fail;
>  		}
> =20
> -		update_block_group(trans->fs_info, bytenr, num_bytes, 0,
> -				   mark_free);
> +		update_block_group(trans, bytenr, num_bytes, 0, mark_free);
>  	}
>  fail:
>  	btrfs_free_path(path);
> @@ -2575,7 +2575,7 @@ static int alloc_reserved_tree_block(struct btrfs=
_trans_handle *trans,
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D update_block_group(fs_info, ins.objectid, fs_info->nodesize, =
1,
> +	ret =3D update_block_group(trans, ins.objectid, fs_info->nodesize, 1,=

>  				 0);
>  	if (sinfo) {
>  		if (fs_info->nodesize > sinfo->bytes_reserved) {
> @@ -3031,11 +3031,11 @@ int btrfs_make_block_groups(struct btrfs_trans_=
handle *trans,
>  	return 0;
>  }
> =20
> -int btrfs_update_block_group(struct btrfs_root *root,
> +int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  			     u64 bytenr, u64 num_bytes, int alloc,
>  			     int mark_free)
>  {
> -	return update_block_group(root->fs_info, bytenr, num_bytes,
> +	return update_block_group(trans, bytenr, num_bytes,
>  				  alloc, mark_free);
>  }
> =20
> @@ -3449,12 +3449,12 @@ int btrfs_fix_block_accounting(struct btrfs_tra=
ns_handle *trans)
>  		btrfs_item_key_to_cpu(leaf, &key, slot);
>  		if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY) {
>  			bytes_used +=3D key.offset;
> -			ret =3D btrfs_update_block_group(root,
> +			ret =3D btrfs_update_block_group(trans,
>  				  key.objectid, key.offset, 1, 0);
>  			BUG_ON(ret);
>  		} else if (key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
>  			bytes_used +=3D fs_info->nodesize;
> -			ret =3D btrfs_update_block_group(root,
> +			ret =3D btrfs_update_block_group(trans,
>  				  key.objectid, fs_info->nodesize, 1, 0);
>  			if (ret)
>  				goto out;
> @@ -3609,7 +3609,7 @@ static int __btrfs_record_file_extent(struct btrf=
s_trans_handle *trans,
>  					       BTRFS_EXTENT_FLAG_DATA);
>  			btrfs_mark_buffer_dirty(leaf);
> =20
> -			ret =3D btrfs_update_block_group(root, disk_bytenr,
> +			ret =3D btrfs_update_block_group(trans, disk_bytenr,
>  						       num_bytes, 1, 0);
>  			if (ret)
>  				goto fail;
> diff --git a/image/main.c b/image/main.c
> index bddb49720f0a..f88ffb16bafe 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -2338,8 +2338,9 @@ again:
>  	return 0;
>  }
> =20
> -static void fixup_block_groups(struct btrfs_fs_info *fs_info)
> +static void fixup_block_groups(struct btrfs_trans_handle *trans)
>  {
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>  	struct btrfs_block_group_cache *bg;
>  	struct btrfs_mapping_tree *map_tree =3D &fs_info->mapping_tree;
>  	struct cache_extent *ce;
> @@ -2499,7 +2500,7 @@ static int fixup_chunks_and_devices(struct btrfs_=
fs_info *fs_info,
>  		return PTR_ERR(trans);
>  	}
> =20
> -	fixup_block_groups(fs_info);
> +	fixup_block_groups(trans);
>  	ret =3D fixup_dev_extents(trans);
>  	if (ret < 0)
>  		goto error;
>=20


--7jrOEHILSRKsfQBN3ZMSLcvzF3BdVqBGd--

--8IQOlYOITdmdmkTUOveX6OgocHam3YKqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3otXkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjtGgf+IXGknWirDbRxOo94RLAs38hO
MX5wkwNAOiBgbhhoiKM15d0PsO9p4FhW/h5FyvmzRWXvIJcHQPtEvid6NK3mVblS
W5/ptZtoeSj5w1HRXW+kLeDPziOZpPnXEdZSMFwxA3NmASpejZEa6nIxV8Gh77p8
8cK4Zl2GsHScAp4+hXv1fEZ2JkQeRJi44oD7sL4fxSVoJqHbnUCjM+WasgbdABxM
pJByGoM5plGVNcZJDTZqIkjeG9tWfw/egcaXr8pBUrzKfpzN6eBZUEe1zGePbqzT
6z0+jahUd/bOfUnXG1bcFjmewSOx/t6sk8tNjieE8vznXSqtzDlTpQp52DC7rQ==
=VOqI
-----END PGP SIGNATURE-----

--8IQOlYOITdmdmkTUOveX6OgocHam3YKqj--
