Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698E5228C74
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgGUXFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 19:05:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:33413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbgGUXFT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 19:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595372711;
        bh=tfpsuw1N8oCSbVozg8RcT9Rt79st+NlukD/wHfpO1fk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=h6McHM6BK0I/kMpIM6ISq9pxe0NXorXW8hSq9SZqwN55NhHkZEO9x7Ibj3obYFZct
         QsWMhWWofjaSt2ZEb83WwVZc5ro3ZZq0XaohUdRrRpSeAoD5IPeMq8X1fLeqB33pQu
         6iQWqrcoiF7InjwQaBG7pmBQS9xTECmgrd4p/Sus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1kjeAH3x8F-00wEnl; Wed, 22
 Jul 2020 01:05:11 +0200
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200721151057.9325-1-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <cd1ec35d-e9ac-6cee-e0af-d1ecdc111e1e@gmx.com>
Date:   Wed, 22 Jul 2020 07:05:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721151057.9325-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aHQDsKyMftHGulKEpeKbTOcVY6r2thyjA"
X-Provags-ID: V03:K1:kfMSmuBNZwJhSpM0G+qbsjNyBSXf5PlvEdy0YVbUiSMEWux+xOv
 CBaHW2qM+N6fgMj+HHIW06i6NU3W1j9cVgSFPrZCbZnxTD2vjkNXZkTJUtlBwGghxHu3Eqb
 DwFewm8rhE8qDLAB2Fjs37kiK2v7ytydhh9gAHQH+pQG09kdrwi0b9BywCGz/m/LQCEqxzr
 dzvYxx1rWSOwc5jybv5Zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vTpOF02o7vI=:Eich6h40jiXUKONMV9+WpV
 3qB1zwaT2Zxu8ouefI+p1eUWNzWnmPOsPEhUffANO9nkWPf1yK1JDC74/htcUJ0+xWgzc0JUk
 CnITLPHkZBCHpVuvavgiV+t9sxJPW4m1Pr5ZMPGj3atQSiRVB2hCzs16A3qaW7jBIjjAlz44y
 agNjJFP6nO0VvTWwg8SyRTKFSH68YXEWWxCt7nOnXFaQGohfoyopexIlD6VhRM2flL6/XAWb+
 YJDlt1Kcqgb9JBy6FJSCM2ZwUu3GQdmQI6vGbQCM4Ou8aUsfkr/ICCJFoV7PhM6WoFR16RGUk
 dvUqbUFBwHORwCOdD3Cpre2JhiIdRSBCKkeffPcaaIdyXBG4qZcB0L5joEqeVp9UW5d9LB36A
 HlS47fpcwRjRsNRImpzHTk2n4zKZmS8+pGA+rsYKg6j2G+1164K/MJPoVVqgeNWarWMgEoxma
 I9H1z3I39sceOQbztyDlpwVn0610MziHK/LUKnxuS+d+zDYzkVyPGQzoEafECN6lakMkoFOT0
 wydDN4NI5MujijT+WTBTBc/GxMmjoebAX3TKLTHXczuQchFjmTODqeleweMOGhv1xM6356uiY
 ptfZCEqvVq5SZ80WxQ0BPck8dBJCqBnnxaFrCR9wSOj8HofeHXG1GA9Z3kV7+E4VXE2YfYcRt
 H27e1xn/+V6JmX4HtjmMK9TaEq3bS5jKnCAgHhueZ916SnZiPM1upfGNprlODkklXcrXx6n2Z
 JpNEp09fBLFLGUsCXM6lvf6zEvMt2Orc4iFKaz+/sr8217u3PRdFkD4bT3hXM2qOqUBQ1kPqE
 P0iZ2LaBJjd7+mZbtfxLKWftVEOrVhECrAHt6W3f9qkbkf3P6YbNU2wydCr54hiEfZaEIrIaP
 XWh/ji6bjXSlQWIyc6fWUfF6T+fkHnfobln5BFM7CBkIKTtnwi+2ZFKywdnzY0S8/R9nTdCKp
 ajbwb1oj2e54ufYKefisw0TYNv6/QMPpW559sr4gxvvf0IwC4Mi/8LR9A4Lzja5Pyj378EW+G
 K69+WhR0ypwzXHllAUp0+ecqyl88vge3Cx80pOyaf/Q7flKlkWa8Wsmro7WfjeHFmjvAVQCs2
 L3+Liy2rrmuVPtrcEJCxTJM8eIBF1zDUqqkdsAm8VGmQf3iYW5aM/1Xf280vO2HjI8f+yCvbI
 c2K7dhroW2jn4FvZIaPvChfBQYUgZCppRmgnx+kuHs8Qf6VzH8TWfJE38oIFb//Nxe00zXfrd
 0VTAySmhWH1VskTVBi1ak1MkJcbICDrYfaHz6YA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aHQDsKyMftHGulKEpeKbTOcVY6r2thyjA
Content-Type: multipart/mixed; boundary="JLsSD4mBueAzJLlx5ELoLl22p85PA6e9q"

--JLsSD4mBueAzJLlx5ELoLl22p85PA6e9q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/21 =E4=B8=8B=E5=8D=8811:10, Josef Bacik wrote:
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
> everything.  Turn it into rescue=3Donlyfs, and then any major root we f=
ail
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
> v1->v2:
> - Rebase onto recent misc-next.
> - Add in the fill_dummy_bgs since skipbg is no longer in this tree.
>=20
>  fs/btrfs/block-group.c | 49 +++++++++++++++++++++++++++++
>  fs/btrfs/ctree.h       |  1 +
>  fs/btrfs/disk-io.c     | 71 +++++++++++++++++++++++++++++-------------=

>  fs/btrfs/inode.c       |  6 +++-
>  fs/btrfs/super.c       | 29 +++++++++++++++--
>  fs/btrfs/volumes.c     |  7 +++++
>  6 files changed, 138 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 884de28a41e4..416fc419fd95 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1997,6 +1997,52 @@ static int read_one_block_group(struct btrfs_fs_=
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
> +	read_lock(&em_tree->lock);
> +	for (node =3D rb_first_cached(&em_tree->map); node;
> +	     node =3D rb_next(node)) {
> +		em =3D rb_entry(node, struct extent_map, rb_node);
> +		map =3D em->map_lookup;
> +		bg =3D btrfs_create_block_group_cache(fs_info, em->start);
> +		if (!bg) {
> +			ret =3D -ENOMEM;
> +			goto out;
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
> +			goto out;
> +		}
> +		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
> +					0, &space_info);
> +		bg->space_info =3D space_info;
> +		link_block_group(bg);
> +
> +		set_avail_alloc_bits(fs_info, bg->flags);
> +	}
> +out:
> +	read_unlock(&em_tree->lock);
> +	return ret;
> +}
> +
>  int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  {
>  	struct btrfs_path *path;
> @@ -2007,6 +2053,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info =
*info)
>  	int need_clear =3D 0;
>  	u64 cache_gen;
> =20
> +	if (btrfs_test_opt(info, ONLYFS))
> +		return fill_dummy_bgs(info);
> +
>  	key.objectid =3D 0;
>  	key.offset =3D 0;
>  	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b70c2024296f..0be7d9461443 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1266,6 +1266,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> +#define BTRFS_MOUNT_ONLYFS		(1 << 30)
> =20
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c850d7f44fbe..0dffa4c12d8c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2326,8 +2326,13 @@ static int btrfs_read_roots(struct btrfs_fs_info=
 *fs_info)
> =20
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
> +			if (!btrfs_test_opt(fs_info, ONLYFS)) {
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

Comment is still the skip-bg version.

> +	if (btrfs_test_opt(fs_info, ONLYFS) && !sb_rdonly(sb)) {
> +		btrfs_err(fs_info,
> +			  "rescue=3Donlyfs can only be used on read-only mount");
> +		err =3D -EINVAL;
> +		goto fail_alloc;
> +	}
> +
>  	ret =3D btrfs_init_workqueues(fs_info, fs_devices);
>  	if (ret) {
>  		err =3D ret;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 611b3412fbfd..49cd3eba651e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2191,7 +2191,8 @@ static blk_status_t btrfs_submit_bio_hook(struct =
inode *inode, struct bio *bio,
>  	int skip_sum;
>  	int async =3D !atomic_read(&BTRFS_I(inode)->sync_writers);
> =20
> -	skip_sum =3D BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
> +	skip_sum =3D (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> +		btrfs_test_opt(fs_info, ONLYFS);

This means, if onlyfs is spcified, csum is completely skipped even it
matches.

I'm not yet determined whether it's preferred.

On one hand, even at recovery, user may want csum verification to detect
bad copy if possible, but on the other hand, since user is doing data
salvage, bothering csum could only lead to extra error.

Despite that, the patch looks pretty good and indeed an enhancement to
skipbg.

Thanks,
Qu
> =20
>  	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
>  		metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> @@ -2846,6 +2847,9 @@ static int btrfs_readpage_end_io_hook(struct btrf=
s_io_bio *io_bio,
>  	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
> =20
> +	if (btrfs_test_opt(root->fs_info, ONLYFS))
> +		return 0;
> +
>  	if (root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID &&
>  	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {=

>  		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 58f890f73650..4dc3f35ca7e3 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -345,6 +345,7 @@ enum {
>  	Opt_rescue,
>  	Opt_usebackuproot,
>  	Opt_nologreplay,
> +	Opt_rescue_onlyfs,
> =20
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -440,6 +441,7 @@ static const match_table_t tokens =3D {
>  static const match_table_t rescue_tokens =3D {
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_nologreplay, "nologreplay"},
> +	{Opt_rescue_onlyfs, "onlyfs"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -472,6 +474,11 @@ static int parse_rescue_options(struct btrfs_fs_in=
fo *info, const char *options)
>  			btrfs_set_and_info(info, NOLOGREPLAY,
>  					   "disabling log replay at mount time");
>  			break;
> +		case Opt_rescue_onlyfs:
> +			btrfs_set_and_info(info, ONLYFS,
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
> +	if (btrfs_test_opt(info, ONLYFS))
> +		seq_puts(seq, ",rescue=3Donlyfs");
>  	if (btrfs_test_opt(info, FLUSHONCOMMIT))
>  		seq_puts(seq, ",flushoncommit");
>  	if (btrfs_test_opt(info, DISCARD_SYNC))
> @@ -1839,6 +1848,14 @@ static int btrfs_remount(struct super_block *sb,=
 int *flags, char *data)
>  	if (ret)
>  		goto restore;
> =20
> +	if (btrfs_test_opt(fs_info, ONLYFS) !=3D
> +	    (old_opts & BTRFS_MOUNT_ONLYFS)) {
> +		btrfs_err(fs_info,
> +		"rescue=3Donlyfs mount option can't be changed during remount");
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
> +		if (btrfs_test_opt(fs_info, ONLYFS)) {
> +			btrfs_err(fs_info,
> +		"remounting read-write with rescue=3Donlyfs is not allowed");
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
> +	if (btrfs_test_opt(fs_info, ONLYFS) ||
> +	    (!mixed && block_rsv->space_info->full &&
> +	     total_free_meta - thresh < block_rsv->size))
>  		buf->f_bavail =3D 0;
> =20
>  	buf->f_type =3D BTRFS_SUPER_MAGIC;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 537ccf66ee20..e86f78579884 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7628,6 +7628,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_inf=
o *fs_info)
>  	u64 prev_dev_ext_end =3D 0;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * For rescue=3Donlyfs mount option, we're already RO and are salvagi=
ng
> +	 * data, no need for such strict check.
> +	 */
> +	if (btrfs_test_opt(fs_info, ONLYFS))
> +		return 0;
> +
>  	key.objectid =3D 1;
>  	key.type =3D BTRFS_DEV_EXTENT_KEY;
>  	key.offset =3D 0;
>=20


--JLsSD4mBueAzJLlx5ELoLl22p85PA6e9q--

--aHQDsKyMftHGulKEpeKbTOcVY6r2thyjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8XdKQACgkQwj2R86El
/qhc/wf9GhixGmxPU3PTAyc154cXx5GnNmdDujjhQykWGA4D0oOke850qDkLaqQn
8tX1XKb+CTLST/0wdikPfy/F37+vn7ZHHA2ocOhNKx34eh9ED8am+ccdC6/PtJcv
AQ/rGII554plFIpJrNVfJFUtsjx0tUnlkt9zRYrWPP5N3kwLLW+aW5bPxmvcJzro
kZ85AH1mV8JxQ9OPqV5CWuYo1cUFu+2CdNwSy2Z+iWUSksf1lEOhPYpKB9CjF4IX
RwldNnwaFOwIJMI6tbMvKD5CVnShr434W+g546KVn0DoPAGzgjAF/S6z7x40Uhfn
V8I29EVd8nPRRvvtXHRAcwseiOnv0w==
=5fzx
-----END PGP SIGNATURE-----

--aHQDsKyMftHGulKEpeKbTOcVY6r2thyjA--
