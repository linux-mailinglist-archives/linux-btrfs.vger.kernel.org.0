Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA640244593
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHNHPJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 03:15:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:49287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgHNHPG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 03:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597389299;
        bh=VAZ6yvofXzbOLhICYV1/RPAzj9I2gbVMkA8U6kxxAv0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lB3y/SSpi0aH+jUhhIHWdJuAySjAqDiYMTWUeQ6JKu0o6fwJYOHW+CwYQv4txoXk5
         wrGteeZ5k8BWNn7AbEtbPtzBl2sBPw6tmVWN3sDNLGLIsLZPyu08OViWlO7eIoePhG
         pXjeSOQvKM70gvaQ9Pm1IbYlV8igVKDFu7Vp6F3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1jtmKz0F8I-00HB8L; Fri, 14
 Aug 2020 09:14:59 +0200
Subject: Re: [PATCH][v3] btrfs: introduce rescue=all
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200722145819.1571-1-josef@toxicpanda.com>
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
Message-ID: <e9bda381-f77a-b20d-73a3-7d97a6b1c4a3@gmx.com>
Date:   Fri, 14 Aug 2020 15:14:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200722145819.1571-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="86zWNWiuCWfUPGjd6m9Qty6xcqWUPbEUf"
X-Provags-ID: V03:K1:gIu3OxL4IitgZ3PLl6zpomLVvXKsmi2q2SAz5f90QHdAy0vn7Vy
 eTrbmiDDdSZPHOUmVBbYrlu6I3a5YnfFlbgxHtiD4q6hJuPTgY1aOtF9wGfEJMq7tEDQHGf
 yUS6MLWBwu+Dqe37+u7iusMCljmNG+JMEP1j8QK/qrVDJpCcJIC40UsN5DLZUBTVQQYMOFb
 eBbmHu8j8RLkiSNBjfXyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:md7ToooTTII=:xCp/l0OPee9MtMjoutgPLf
 +Pc5WUHdzU2uuPv8KWitiWlLhncrgDAWOsD/GwG7F30UHQyx61e/AecEcT1+zrO/NP4SEBH8S
 myBVyQTi0cvMEm+xbGJBbd4yx3bm3vTLVyJN9eG1h20QU8ujT8kSCmkRCXG2H4knlUt0CVZVn
 GuctfPiCMfyTuCQuGM6HlNQn44CPd0wBR33saC9f0T1EqTIFL95SWPjyvekBqdCxp2PLYJhUj
 TpN+pKaDPuBwkrjbfejKmjWv3ME5cZeLCB27m7buNjEmAg8UKNg00KEez3bYlDZMU8MqWg94y
 Ksy4fX5nfdpzSqq4GTiWu1pKMYKLIrINdG+QzoeQMtaMqysFEiXzrnn7zgjQ0SbIdBBjD55aB
 VrzD+4VQqz3ou4P4E7cKbERmg/wMhzFoyirJICocCkbNHG9UN62fUXwli3YQ0I8KO5ItjgxJj
 3v6lli72GjrSdES6xnopOUzuDq/t6ZFbi7IUDybUEbmAZFEbUgoBEDUxVC5WlR8ncC9Cosjli
 Itjm6AG85LMz3BbfymLAdk/E9bwON4gpkmW41adiUjTkAI0oUUiKMXXaXg8BJNTylTnGhWBLI
 EeEpj3xYNuIhdb6uXRBYywhwmgmqFeepLuj64zVeYJCI+A92EPqkeVJppyGeVxy8FkIaZagE9
 YcXrTKY5nQXIDgA5Cn7vSfChyTAqKIYFDvAo9GR0gzQxEyZjXjMea3/6ziLBxd7Y0Qg4zC7eN
 C83xXxOanY7XpkBDNleaGoyiPUnbuL2QH+NPawv4mWHi9kvWDR4nnsy78BuctZomQY57wu27T
 xyRTW+pg9Akl/MKtJlzuEZzQUKauYi/uoxNlAhHtbBhVcL+hVUXNgAAuHGGztmEA9zLYafwmA
 X1BGUrICjgU0GL1veSbIkyPCeKMkfuUPAmbZAtB4r9rDWPmqKZk2BPh1O6LezoqXLYWG5I4FS
 4PPN9hP6W0yhn6aZ7SGK83n4DPpTIXcmZlq8YpiviAriOLSMJIkOilux3OffDl1QvkSga9ABl
 Dye5950GvWklvvkMpNyVNe/BqK6JkY/mTPMtXCQoww5JK5xQplpwfQC+fFS1PVNJfevV2W3DD
 1YzVhdEF6oCYPe/vZTYpwhBVo3CDo0I7WHaGT+39nI4aQ5/Mf0ikHWWYWtQi9Q6BqF/gCZfkN
 PZxoad/o0athTMiqCYxmmG2EDBCMdJgkE0ZC+G87K584Y2RnHaZoaK3hE3Kijdfr+J+B7oaju
 a0DfLxQ/4UHHVfY+x08o6dcrrHTza3UfrGDfpkQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--86zWNWiuCWfUPGjd6m9Qty6xcqWUPbEUf
Content-Type: multipart/mixed; boundary="J43LLvN4NMPDcmWeVFZzUqIcoZWyM2Rf1"

--J43LLvN4NMPDcmWeVFZzUqIcoZWyM2Rf1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/22 =E4=B8=8B=E5=8D=8810:58, Josef Bacik wrote:
> One of the things that came up consistently in talking with Fedora abou=
t
> switching to btrfs as default is that btrfs is particularly vulnerable
> to metadata corruption.  If any of the core global roots are corrupted,=

> the fs is unmountable and fsck can't usually do anything for you withou=
t
> some special options.
>=20
> Qu addressed this sort of with rescue=3Dskipbg, but that's poorly named=
 as
> what it really does is just allow you to operate without an extent root=
=2E
> However there are a lot of other roots, and I'd rather not have to do
>=20
> mount -o rescue=3Dskipbg,rescue=3Dnocsum,rescue=3Dnofreespacetree,rescu=
e=3Dblah
>=20
> Instead take his original idea and modify it so it just works for
> everything.  Turn it into rescue=3Dall, and then any major root we fail=

> to read just gets left empty and we carry on.
>=20
> Obviously if the fs roots are screwed then the user is in trouble, but
> otherwise this makes it much easier to pull stuff off the disk without
> needing our special rescue tools.  I tested this with my TEST_DEV that
> had a bunch of data on it by corrupting the csum tree and then reading
> files off the disk.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v2->v3:
> - Renamed to rescue=3Dall.

What about rescue=3Dsalvage?

Since this mount option would be the goto option for future data
salvage, using "salvage" as the option should be more user-friendly, and
shows the purpose directly.

> - Fixed a lockdep splat from fill_dummy_bgs.
> - Only skip csums if we fail to read the csum tree, otherwise use the c=
sums.

Some uuid tree related problem may worthy checking in another patchset.

E.g. if we got uuid tree corrupted, then we got fs_info->uuid_tree =3D=3D=

NULL, and in open_ctree() we will try to call btrfs_create_uuid_tree()
which will fail due to RO fs.

Then we just error out, without mounting the fs.

We may need to enhance such non-essential tree handling in the future.

But for now, I prefer to let the patch merged to benefit more end-users.

Thanks,
Qu

>=20
>  fs/btrfs/block-group.c | 46 +++++++++++++++++++++++++++
>  fs/btrfs/ctree.h       |  1 +
>  fs/btrfs/disk-io.c     | 71 +++++++++++++++++++++++++++++-------------=

>  fs/btrfs/inode.c       |  6 +++-
>  fs/btrfs/super.c       | 29 +++++++++++++++--
>  fs/btrfs/volumes.c     |  7 +++++
>  6 files changed, 135 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 884de28a41e4..50404e8c3629 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1997,6 +1997,49 @@ static int read_one_block_group(struct btrfs_fs_=
info *info,
>  	return ret;
>  }
> =20
> +static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
> +{
> +	struct extent_map_tree *em_tree =3D &fs_info->mapping_tree;
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	struct btrfs_block_group *bg;
> +	struct btrfs_space_info *space_info;
> +	struct rb_node *node;
> +	int ret =3D 0;
> +
> +	for (node =3D rb_first_cached(&em_tree->map); node;
> +	     node =3D rb_next(node)) {
> +		em =3D rb_entry(node, struct extent_map, rb_node);
> +		map =3D em->map_lookup;
> +		bg =3D btrfs_create_block_group_cache(fs_info, em->start);
> +		if (!bg) {
> +			ret =3D -ENOMEM;
> +			break;
> +		}
> +
> +		/* Fill dummy cache as FULL */
> +		bg->length =3D em->len;
> +		bg->flags =3D map->type;
> +		bg->last_byte_to_unpin =3D (u64)-1;
> +		bg->cached =3D BTRFS_CACHE_FINISHED;
> +		bg->used =3D em->len;
> +		bg->flags =3D map->type;
> +		ret =3D btrfs_add_block_group_cache(fs_info, bg);
> +		if (ret) {
> +			btrfs_remove_free_space_cache(bg);
> +			btrfs_put_block_group(bg);
> +			break;
> +		}
> +		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
> +					0, &space_info);
> +		bg->space_info =3D space_info;
> +		link_block_group(bg);
> +
> +		set_avail_alloc_bits(fs_info, bg->flags);
> +	}
> +	return ret;
> +}
> +
>  int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  {
>  	struct btrfs_path *path;
> @@ -2007,6 +2050,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info =
*info)
>  	int need_clear =3D 0;
>  	u64 cache_gen;
> =20
> +	if (btrfs_test_opt(info, RESCUE_ALL))
> +		return fill_dummy_bgs(info);
> +
>  	key.objectid =3D 0;
>  	key.offset =3D 0;
>  	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b70c2024296f..93848c2b6eb5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1266,6 +1266,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> +#define BTRFS_MOUNT_RESCUE_ALL		(1 << 30)
> =20
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c850d7f44fbe..805b9e836589 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2326,8 +2326,13 @@ static int btrfs_read_roots(struct btrfs_fs_info=
 *fs_info)
> =20
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->extent_root =3D root;
>  	}
>  	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>  	fs_info->extent_root =3D root;
> @@ -2335,21 +2340,27 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  	location.objectid =3D BTRFS_DEV_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->dev_root =3D root;
> +		btrfs_init_devices_late(fs_info);
>  	}
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->dev_root =3D root;
> -	btrfs_init_devices_late(fs_info);
> =20
>  	location.objectid =3D BTRFS_CSUM_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->csum_root =3D root;
>  	}
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->csum_root =3D root;
> =20
>  	/*
>  	 * This tree can share blocks with some other fs tree during relocati=
on
> @@ -2358,11 +2369,14 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  	root =3D btrfs_get_fs_root(tree_root->fs_info,
>  				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->data_reloc_root =3D root;
>  	}
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->data_reloc_root =3D root;
> =20
>  	location.objectid =3D BTRFS_QUOTA_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
> @@ -2375,9 +2389,11 @@ static int btrfs_read_roots(struct btrfs_fs_info=
 *fs_info)
>  	location.objectid =3D BTRFS_UUID_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		if (ret !=3D -ENOENT)
> -			goto out;
> +		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +			ret =3D PTR_ERR(root);
> +			if (ret !=3D -ENOENT)
> +				goto out;
> +		}
>  	} else {
>  		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>  		fs_info->uuid_root =3D root;
> @@ -2387,11 +2403,14 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  		location.objectid =3D BTRFS_FREE_SPACE_TREE_OBJECTID;
>  		root =3D btrfs_read_tree_root(tree_root, &location);
>  		if (IS_ERR(root)) {
> -			ret =3D PTR_ERR(root);
> -			goto out;
> +			if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +				ret =3D PTR_ERR(root);
> +				goto out;
> +			}
> +		}  else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->free_space_root =3D root;
>  		}
> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->free_space_root =3D root;
>  	}
> =20
>  	return 0;
> @@ -3106,6 +3125,14 @@ int __cold open_ctree(struct super_block *sb, st=
ruct btrfs_fs_devices *fs_device
>  		goto fail_alloc;
>  	}
> =20
> +	/* Skip bg needs RO and no tree-log to replay */
> +	if (btrfs_test_opt(fs_info, RESCUE_ALL) && !sb_rdonly(sb)) {
> +		btrfs_err(fs_info,
> +			  "rescue=3Dall can only be used on read-only mount");
> +		err =3D -EINVAL;
> +		goto fail_alloc;
> +	}
> +
>  	ret =3D btrfs_init_workqueues(fs_info, fs_devices);
>  	if (ret) {
>  		err =3D ret;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 611b3412fbfd..e3d73ee73f80 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2191,7 +2191,8 @@ static blk_status_t btrfs_submit_bio_hook(struct =
inode *inode, struct bio *bio,
>  	int skip_sum;
>  	int async =3D !atomic_read(&BTRFS_I(inode)->sync_writers);
> =20
> -	skip_sum =3D BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
> +	skip_sum =3D (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> +		!fs_info->csum_root;
> =20
>  	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
>  		metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> @@ -2846,6 +2847,9 @@ static int btrfs_readpage_end_io_hook(struct btrf=
s_io_bio *io_bio,
>  	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
> =20
> +	if (!root->fs_info->csum_root)
> +		return 0;
> +
>  	if (root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID &&
>  	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {=

>  		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 58f890f73650..de7a50353239 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -345,6 +345,7 @@ enum {
>  	Opt_rescue,
>  	Opt_usebackuproot,
>  	Opt_nologreplay,
> +	Opt_rescue_all,
> =20
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -440,6 +441,7 @@ static const match_table_t tokens =3D {
>  static const match_table_t rescue_tokens =3D {
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_nologreplay, "nologreplay"},
> +	{Opt_rescue_all, "all"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -472,6 +474,11 @@ static int parse_rescue_options(struct btrfs_fs_in=
fo *info, const char *options)
>  			btrfs_set_and_info(info, NOLOGREPLAY,
>  					   "disabling log replay at mount time");
>  			break;
> +		case Opt_rescue_all:
> +			btrfs_set_and_info(info, RESCUE_ALL,
> +					   "only reading fs roots, also setting  nologreplay");
> +			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized rescue option '%s'", p);
>  			ret =3D -EINVAL;
> @@ -1400,6 +1407,8 @@ static int btrfs_show_options(struct seq_file *se=
q, struct dentry *dentry)
>  		seq_puts(seq, ",notreelog");
>  	if (btrfs_test_opt(info, NOLOGREPLAY))
>  		seq_puts(seq, ",rescue=3Dnologreplay");
> +	if (btrfs_test_opt(info, RESCUE_ALL))
> +		seq_puts(seq, ",rescue=3Dall");
>  	if (btrfs_test_opt(info, FLUSHONCOMMIT))
>  		seq_puts(seq, ",flushoncommit");
>  	if (btrfs_test_opt(info, DISCARD_SYNC))
> @@ -1839,6 +1848,14 @@ static int btrfs_remount(struct super_block *sb,=
 int *flags, char *data)
>  	if (ret)
>  		goto restore;
> =20
> +	if (btrfs_test_opt(fs_info, RESCUE_ALL) !=3D
> +	    (old_opts & BTRFS_MOUNT_RESCUE_ALL)) {
> +		btrfs_err(fs_info,
> +		"rescue=3Dall mount option can't be changed during remount");
> +		ret =3D -EINVAL;
> +		goto restore;
> +	}
> +
>  	btrfs_remount_begin(fs_info, old_opts, *flags);
>  	btrfs_resize_thread_pool(fs_info,
>  		fs_info->thread_pool_size, old_thread_pool_size);
> @@ -1904,6 +1921,13 @@ static int btrfs_remount(struct super_block *sb,=
 int *flags, char *data)
>  			goto restore;
>  		}
> =20
> +		if (btrfs_test_opt(fs_info, RESCUE_ALL)) {
> +			btrfs_err(fs_info,
> +		"remounting read-write with rescue=3Dall is not allowed");
> +			ret =3D -EINVAL;
> +			goto restore;
> +		}
> +
>  		ret =3D btrfs_cleanup_fs_roots(fs_info);
>  		if (ret)
>  			goto restore;
> @@ -2208,8 +2232,9 @@ static int btrfs_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>  	 * still can allocate chunks and thus are fine using the currently
>  	 * calculated f_bavail.
>  	 */
> -	if (!mixed && block_rsv->space_info->full &&
> -	    total_free_meta - thresh < block_rsv->size)
> +	if (btrfs_test_opt(fs_info, RESCUE_ALL) ||
> +	    (!mixed && block_rsv->space_info->full &&
> +	     total_free_meta - thresh < block_rsv->size))
>  		buf->f_bavail =3D 0;
> =20
>  	buf->f_type =3D BTRFS_SUPER_MAGIC;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 537ccf66ee20..2d7b57303fe5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7628,6 +7628,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_inf=
o *fs_info)
>  	u64 prev_dev_ext_end =3D 0;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * For rescue=3Dall mount option, we're already RO and are salvaging
> +	 * data, no need for such strict check.
> +	 */
> +	if (btrfs_test_opt(fs_info, RESCUE_ALL))
> +		return 0;
> +
>  	key.objectid =3D 1;
>  	key.type =3D BTRFS_DEV_EXTENT_KEY;
>  	key.offset =3D 0;
>=20


--J43LLvN4NMPDcmWeVFZzUqIcoZWyM2Rf1--

--86zWNWiuCWfUPGjd6m9Qty6xcqWUPbEUf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl82Oe8ACgkQwj2R86El
/qg8jQf/aQyHNrucoUvWobT2187ZcFXpgjqB7JRQtU8Gnc4yGFmQ66sjLlbEpqnh
CajHfJGu0u529Xz6Tp/3iQvirAJ+ncI9UNp4t55U5VQSCCaVEcBfvZjDO0WQ7l/A
Ca3yosrghO1doRIXMw7q+z9QqqpS+y9vqxn/dHED7m0+b3RfRoPq9veQBXkoMY8i
oUxk9K2ZOMRLQWkImoWiZzJDS8ugYc9/Yk8a5iDyBd4aWavvR/pochN/nF9WJnsJ
6AcIPvj24YK24uWaVBewMIsDy293SrwJsIYWgu8k4gpBq01moaeWPKmPQcvIJ1JI
+Apxh3VR2ofZac5ZM2zV9UZVbPqErg==
=Y3aO
-----END PGP SIGNATURE-----

--86zWNWiuCWfUPGjd6m9Qty6xcqWUPbEUf--
