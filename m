Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1441B262374
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 01:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIHXLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 19:11:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:46651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgIHXLG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 19:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599606653;
        bh=ooMBWcJJfZ2+CH88rOp4uusKma2CCjP5e7daEOJlhWo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VdAzN5DIukkxKMttfASJIuCF8hU9k8Rdwzh59qVa2xLGCFLJAD2aDWhd+yfQCcCRe
         bWIELNZ+UmqfxGbQxrWBe+uXUHk/XyGrDi3c3/Z7zIy/3wN1X8Q1jmW6NbggOF3f/t
         hPalbP/8WHufC8fHNPm7+LKNW2uU5Wu0BSpa0tg8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MacSe-1knScQ3F5m-00cBpi; Wed, 09
 Sep 2020 01:10:53 +0200
Subject: Re: [PATCH] btrfs: introduce rescue=all
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <921662f28b90d7e5a67bb52a1e0b0b2e9584f946.1599579772.git.josef@toxicpanda.com>
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
Message-ID: <b862077c-0903-b4f0-ccc9-ee1c815534bc@gmx.com>
Date:   Wed, 9 Sep 2020 07:10:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <921662f28b90d7e5a67bb52a1e0b0b2e9584f946.1599579772.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jvqbn13nsBZBOgIxpnF97doApjFcR9kYE"
X-Provags-ID: V03:K1:2eM1Ep3s5h7pIEuCDiaGblmrJ1lW3ZRr2Y0m1l2a7WaULRqqHo5
 UR+FR1Cc2Y73rMfLeB+zyh4+a/jDpscBVhD1CI62yyIrIDDNidv/11emJMvLXAPbQkwmQp8
 zUMTdYZ5DdzcvJM8ZVD5q+dS7tpHm9epQ2YrkDTaAAP7X1vjnUaAXeg7TWnDG2AUi9eymKO
 St/3imbNoGh0gJDzAywgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZG6hkI34DGI=:7Dpq84hp1NsS3pqj2hCYrv
 7qcEEpqJno2NL5YahEm0YT8YyR4uxpu8DA0xIXysXicRFn3EzZkaiSXiK+8tcW1D76lPqUoV4
 14t0UjyLptnWd9am2guQ0rSoBTYNkPoKBK2SmTizURdo4LlmJ9T0nUWXZ2XINy7UIZRXO4U0a
 xGv8Cctuu6A36w1xYWvC2M2qiYq7GsJarUOp3OZEEBjW5o1G+L4vUZYj3V9o1jHQd7ITYALFQ
 EEMVwp3zhd8aYwGbtD89OcwkteZOpBu6c5ieXINjL7o0rcGM7aakrCTwC9tUqd8pKbmr6DheT
 ZclbM8cdJlQGSDELPrmjfA/89QW3kJ9OzRhIvqmtFZ9QnzXgmUP85mSYZVeiJVIBI3Yy/PtZS
 VXGxoNK95uOVkQimChOhkhl4R327i9JBxtHR1wRpWR8rQvTbNQmAY6cRsjKaZanMLkujUm42P
 gvoytyD0eYbObB95wqFYDhCnT/WjGtrGb6uDwmsiWclA85EbE/NE5NayVx9l5pAiku6Zii0nh
 WXRIG338C4DtfB5U5a4NExqZmZU0Cg0Qu5gGDh3UdUwq8nDgW77Y91c3bRSFJtHC4GqZ8ztmY
 r6jsJTjXtD3+ToOnWqW4qM37M/NWMfc+BUBmiy80qseNF68nsiS6YE9ZA2CcY7W/03OM4pnWR
 9jb7dYXN+xhT5etizT0kQB/wQ+iTns8QwTI2/qOgZJ/bXLog0pHve9flqJ0+9lreXhh0Wz5Ik
 YsI1nkpgjK3GOx5HoIjDvGVAudtXUv9iX0mKK4GhlW9jaN0rVUSfjypXUb0ZKLMKi/aFCjKcE
 XOY/Eq/gWDRLpYggUBx5uj42O88bKE06p/PVJ0KGVPgL2V73IkQxBaWLi01sVbkv52BPELH6R
 JL9b232KA43juYO0EPwpJXwggzKCaXHItUzteJmYsnf9t8+a6LdCSf88aW2/xo+pdTMAxoaUp
 ERiRHupVyMredlvlFZHHcWT1mNYr9EdnCbgoZgtmucz5n5lHiaWA9O2ne/jA3shBGDCy1MGDW
 dYqvv570HDKzDMNfichFEiLAdsmln4iIQhADYc7ZR0Lj7Kji/MHCwzLVnpjRkoF7SrFCk2jgZ
 kwpbD6hIcPGW7WJHD4+/A0i6teAEMjAj3nQXZeMs4e6NAEQ/vqFI6jWE1NR8d5LmIC0UYHiSy
 SzMuNCDR6zl8CgZXT6oCXQoU48+/eqgOIjcGbgdZI1iP0BL4e+CBGpG+xWeMKImyRv638vCBI
 ZSUeo+5GqFQkxG/2jEB3PePZtz8br4AJjc3TnWA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvqbn13nsBZBOgIxpnF97doApjFcR9kYE
Content-Type: multipart/mixed; boundary="09FFeS3FOgwD14a5HAnylaBKyXjPprxON"

--09FFeS3FOgwD14a5HAnylaBKyXjPprxON
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/8 =E4=B8=8B=E5=8D=8811:43, Josef Bacik wrote:
> One of the things that came up consistently in talking with Fedora abou=
t
> switching to btrfs as default is that btrfs is particularly vulnerable
> to metadata corruption.  If any of the core global roots are corrupted,=

> the fs is unmountable and fsck can't usually do anything for you withou=
t
> some special options.
>=20
> What we really want is a simple mount option we can tell all users to
> try if things are really wrong that are going to give them the highest
> chance of allowing them to mount their file system and copy off their
> data in the most direct way possible.

Then "all" doesn't look correct for such usage.
I'd prefer "salvage" then.

Thanks,
Qu

>=20
> Obviously if the fs roots are screwed then the user is in trouble, but
> otherwise this makes it much easier to pull stuff off the disk without
> needing our special rescue tools.  I tested this with an xfstest that
> I've submitted along side this patch that clears the roots and makes
> sure we're still able to read the data on the disk.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 46 ++++++++++++++++++++++++++
>  fs/btrfs/ctree.h       |  1 +
>  fs/btrfs/disk-io.c     | 73 ++++++++++++++++++++++++++++--------------=

>  fs/btrfs/inode.c       |  6 +++-
>  fs/btrfs/super.c       | 29 +++++++++++++++--
>  fs/btrfs/volumes.c     |  7 ++++
>  6 files changed, 135 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 01e8ba1da1d3..dfff2b6e7708 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1991,6 +1991,49 @@ static int read_one_block_group(struct btrfs_fs_=
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
> @@ -2001,6 +2044,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info =
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
> index 98c5f6178efc..f84b3f67faa4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1275,6 +1275,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> +#define BTRFS_MOUNT_RESCUE_ALL		(1 << 30)
> =20
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7147237d9bf0..f61366a57be4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2303,30 +2303,39 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
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
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->extent_root =3D root;
> =20
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
> @@ -2335,11 +2344,14 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
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
> @@ -2352,9 +2364,11 @@ static int btrfs_read_roots(struct btrfs_fs_info=
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
> @@ -2364,11 +2378,14 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
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
> @@ -3082,6 +3099,14 @@ int __cold open_ctree(struct super_block *sb, st=
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
> index cce6f8789a4e..d90c86ac9ebe 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2196,7 +2196,8 @@ static blk_status_t btrfs_submit_bio_hook(struct =
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
> @@ -2851,6 +2852,9 @@ static int btrfs_readpage_end_io_hook(struct btrf=
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
> index 3ebe7240c63d..89703c2ec1f3 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -360,6 +360,7 @@ enum {
>  	Opt_rescue,
>  	Opt_usebackuproot,
>  	Opt_nologreplay,
> +	Opt_rescue_all,
> =20
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -455,6 +456,7 @@ static const match_table_t tokens =3D {
>  static const match_table_t rescue_tokens =3D {
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_nologreplay, "nologreplay"},
> +	{Opt_rescue_all, "all"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -487,6 +489,11 @@ static int parse_rescue_options(struct btrfs_fs_in=
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
> @@ -1421,6 +1428,8 @@ static int btrfs_show_options(struct seq_file *se=
q, struct dentry *dentry)
>  		seq_puts(seq, ",notreelog");
>  	if (btrfs_test_opt(info, NOLOGREPLAY))
>  		seq_puts(seq, ",rescue=3Dnologreplay");
> +	if (btrfs_test_opt(info, RESCUE_ALL))
> +		seq_puts(seq, ",rescue=3Dall");
>  	if (btrfs_test_opt(info, FLUSHONCOMMIT))
>  		seq_puts(seq, ",flushoncommit");
>  	if (btrfs_test_opt(info, DISCARD_SYNC))
> @@ -1858,6 +1867,14 @@ static int btrfs_remount(struct super_block *sb,=
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
> @@ -1924,6 +1941,13 @@ static int btrfs_remount(struct super_block *sb,=
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
> @@ -2238,8 +2262,9 @@ static int btrfs_statfs(struct dentry *dentry, st=
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
> index 2a55356ef4a2..614acd4b9988 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7648,6 +7648,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_inf=
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


--09FFeS3FOgwD14a5HAnylaBKyXjPprxON--

--jvqbn13nsBZBOgIxpnF97doApjFcR9kYE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9YD3kACgkQwj2R86El
/qjObgf/SB8+CzMTMOnq9lxC31cisk6FfUSkxzi/4/7CB0pQ15atZl8t4RbjcU5J
yON9Th85VzK2Ez057Lyhxm2atttVtvPK/a+Vt1rGrT3ebfSNeHzvXOIOtpnLdhu0
NPwhZ9+G8dqlKSGdwGHoBUylzYEMR9i0MzoXGPX4Po7sXqdmcz48UEXJnylyWx7k
tFApEomVTRnIVe/7lyMFCTXzFb4yrphwmThsetpe4hlAokrypTC7KPQMhauxWEZC
dR6s+84YPayrqJM1vDTLq/joO6nWBpF3fc/BHnryKW7JPZbL84xn/Xns45KklWr1
K2xJOJpLKkyG06T0Kgnp+jiZu0uXhQ==
=mSiF
-----END PGP SIGNATURE-----

--jvqbn13nsBZBOgIxpnF97doApjFcR9kYE--
