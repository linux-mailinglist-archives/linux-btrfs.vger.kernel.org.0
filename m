Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9B1B3BA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgDVJqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 05:46:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:41697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDVJqm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 05:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587548791;
        bh=9X1e1ZzU2z6R9HCjEZiTA76R2lfLXZu8EF9+e14lbTw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:In-reply-to:Date;
        b=kYdDA6obgZSKCEkahcUR/pMcs2Rt8dcV+Nn235QD/l12jS+gWEj2rvsGgrhqC/x6S
         7sMQV4usIzh6elqe+oKKRCASmrrhaDznf3KSfRdtH6iT9glvAqDYUfoWyELja7eyp8
         jTwd1xesoS8QrnPjP9TMhVzlCu421kaIh6YLsK+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from nas ([34.92.246.95]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMofW-1jjxnW0DbQ-00IlcX; Wed, 22
 Apr 2020 11:46:31 +0200
From:   Su Yue <Damenly_Su@gmx.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de, marek.behun@nic.cz
Subject: Re: [PATCH U-BOOT 18/26] fs: btrfs: Implement btrfs_lookup_path()
References: <20200422065009.69392-1-wqu@suse.com> <20200422065009.69392-19-wqu@suse.com>
User-agent: mu4e 1.2.0; emacs 26.3
In-reply-to: <20200422065009.69392-19-wqu@suse.com>
Date:   Wed, 22 Apr 2020 17:46:25 +0800
Message-ID: <368vvoni.fsf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:Xulak+M4tN9TNaedVQhOrRGkuFcpdjR+JFRmp+aoglYiDm0s0EI
 HGRR2PgedUntyLdEYheZQuurUJGu/Hq+dD4bRRbgpfseXyIEAPVoqnBabOz7x/2Cx59X+fV
 t8dgDr/ptfMM8kcP3s5ESnREU7OxL796lEtQ44xCHjOvfEwGnts6cgYtNM/fKXT9+R2/EEN
 p1ceRkukS3trNdNr+bVqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IvSeNvPxPBc=:lt97PrktE0G/+KJv3wyyeO
 n/ftYqOJkVtTvJpMK94kibzDVZV4Bwx+hi3tiKnqBBQBbdDIKhXw4Tp1NGMVSlT4XYnLkX9sF
 Tw6hwYO2mQQdl4/HDiwTXUGIYp/Rhy5rvhxbAJ0Ksb6Orgj49554MrNTuVpy7JtPeYRI6Zozt
 wTF/afU0jH8ZULORqKo1lMBPxAdmaTyY5YxgLJ7nfrhdCqQnBM+y16PFvt94VE99IOHphDkJj
 JaLFwM8hGfnRjRcYL7r4WeoPDkrWpYA5AaWYi9oeB2FwYNFN5VlqxiGlV8IakuHMbK4pk/Tnr
 Ws9Gwwi25b1VYStfVyhu/1lQsHM3mj9//4rlzSXbSL1txNcxpwjO7/Ynar37Xg2zO4MCGUI00
 MmycIH2hh1RhgbXykiVVrj8DlhYOZA0a7MCrLcPvC4ss3dmg/24b7yO5etkaL37dOyu6HRO2D
 7I/uTkwqrycnSOin3xVjp+Fr/U0mzcFc6Y3Hcw51KpNILyYRaaqi91pdekYHgXcJNnIZjfoxZ
 qEGxt3h0xBg5PyWylqVZldTD6b5llqJQrlsD28jRzC5I8iDwBKD7YBT9xNebuROOU/3sK1tgB
 6GQuOeVCuXNiTPHIHfF+v/fh53Ivt2w7tdi8Fg6TV5+/ZszX4Ttt1loJOTBwffFjkc3g3Qvtk
 /8eSIklOIH1uI8xJT0JKrAKUNEd3XKO6kSWR9A4NlgJml7/aK2Jc1HJhvYIopxg+Xln3/Lywg
 V4SbawlwiX8yxZtdHOG0bPhL0PFaVvwgRi6oSXveEznq18gvl+Cfd8vfBrh2RpIRZ3lVoqwBA
 2nw/CQGtZWTLULZ0czYLLXbJTPlHzLrshuKERGFrBYsCDV+kbg3hVRgtHFWwlREiwFyMQRogp
 lR8YYFQZVvdE36zK3z3NNRi3PyEcDIOJLATikTJAkCsuoQS/eMRw9XggzCTpmDociudic/nho
 wekV/nLhEV7H0agf0FTtRQmvFQfmhsql9Um1O1D82UZhOrcir8hvms3SP34XMkuIfPAXywHa/
 CMj47XX7D2QGErEXZsgWXjFA6CreoI2GJoaiCKZgz3wMc4t6sUlVn7CNjWQHUiAP/LzH6iPOB
 LPNhMKtkkgX1l3zNE2GG3btbcM4ENg9exjCaqOe4UoI03hNNoj+dt2JxjYzlE4jTAusLx7nwj
 pAbwvNZo2IXzMTHRx6ENv7I27OPD5o9Lzxv5v3ovk6QGpc/EiYcNhDQLv9ZaknCFP0sih36m3
 P7W2IeTYoEfdWX9vT
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 22 Apr 2020 at 14:50, Qu Wenruo <wqu@suse.com> wrote:

> This is the extent buffer based path lookup routine.
>
> To implement this, btrfs_lookup_dir_item() is cross ported from
> btrfs-progs, and implement btrfs_lookup_path() from scratch.
>
> Unlike the existing __btrfs_lookup_path(), since btrfs_read_fs_root()
> will check whether a root is orphan at read time, there is no need to
> check root backref, this make the code a little easier to read.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h    |   4 +
>  fs/btrfs/dir-item.c | 106 +++++++++++++++++++
>  fs/btrfs/inode.c    | 245 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f702eaff293c..78f7746d1f32 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1284,6 +1284,10 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(stru=
ct btrfs_trans_handle *trans,
>  					     struct btrfs_path *path, u64 dir,
>  					     const char *name, int name_len,
>  					     int mod);
> +/* inode.c */
> +int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *fil=
ename,
> +			struct btrfs_root **root_ret, u64 *ino_ret,
> +			u8 *type_ret, int symlink_limit);
>
>  /* ctree.c */
>  int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_=
key *k2);
> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> index aea621c72bb3..4bf45c2fa925 100644
> --- a/fs/btrfs/dir-item.c
> +++ b/fs/btrfs/dir-item.c
> @@ -8,6 +8,112 @@
>  #include "btrfs.h"
>  #include "disk-io.h"
>
> +static int verify_dir_item(struct btrfs_root *root,
> +		    struct extent_buffer *leaf,
> +		    struct btrfs_dir_item *dir_item)
> +{
> +	u16 namelen =3D BTRFS_NAME_LEN;
> +	u8 type =3D btrfs_dir_type(leaf, dir_item);
> +
> +	if (type =3D=3D BTRFS_FT_XATTR)
> +		namelen =3D XATTR_NAME_MAX;
> +
> +	if (btrfs_dir_name_len(leaf, dir_item) > namelen) {
> +		fprintf(stderr, "invalid dir item name len: %u\n",
> +		       (unsigned)btrfs_dir_data_len(leaf, dir_item));
> +		return 1;
> +	}
> +
> +	/* BTRFS_MAX_XATTR_SIZE is the same for all dir items */
> +	if ((btrfs_dir_data_len(leaf, dir_item) +
> +	     btrfs_dir_name_len(leaf, dir_item)) >
> +			BTRFS_MAX_XATTR_SIZE(root->fs_info)) {
> +		fprintf(stderr, "invalid dir item name + data len: %u + %u\n",
> +		       (unsigned)btrfs_dir_name_len(leaf, dir_item),
> +		       (unsigned)btrfs_dir_data_len(leaf, dir_item));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_root *roo=
t,
> +			      struct btrfs_path *path,
> +			      const char *name, int name_len)
> +{
> +	struct btrfs_dir_item *dir_item;
> +	unsigned long name_ptr;
> +	u32 total_len;
> +	u32 cur =3D 0;
> +	u32 this_len;
> +	struct extent_buffer *leaf;
> +
> +	leaf =3D path->nodes[0];
> +	dir_item =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_ite=
m);
> +	total_len =3D btrfs_item_size_nr(leaf, path->slots[0]);
> +	if (verify_dir_item(root, leaf, dir_item))
> +		return NULL;
> +
> +	while(cur < total_len) {
> +		this_len =3D sizeof(*dir_item) +
> +			btrfs_dir_name_len(leaf, dir_item) +
> +			btrfs_dir_data_len(leaf, dir_item);
> +		if (this_len > (total_len - cur)) {
> +			fprintf(stderr, "invalid dir item size\n");
> +			return NULL;
> +		}
> +
> +		name_ptr =3D (unsigned long)(dir_item + 1);
> +
> +		if (btrfs_dir_name_len(leaf, dir_item) =3D=3D name_len &&
> +		    memcmp_extent_buffer(leaf, name, name_ptr, name_len) =3D=3D 0)
> +			return dir_item;
> +
> +		cur +=3D this_len;
> +		dir_item =3D (struct btrfs_dir_item *)((char *)dir_item +
> +						     this_len);
> +	}
> +	return NULL;
> +}
> +
> +struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle =
*trans,
> +					     struct btrfs_root *root,
> +					     struct btrfs_path *path, u64 dir,
> +					     const char *name, int name_len,
> +					     int mod)
> +{
> +	int ret;
> +	struct btrfs_key key;
> +	int ins_len =3D mod < 0 ? -1 : 0;
> +	int cow =3D mod !=3D 0;
> +	struct btrfs_key found_key;
> +	struct extent_buffer *leaf;
> +
> +	key.objectid =3D dir;
> +	key.type =3D BTRFS_DIR_ITEM_KEY;
> +
> +	key.offset =3D btrfs_name_hash(name, name_len);
> +
> +	ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, cow);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	if (ret > 0) {
> +		if (path->slots[0] =3D=3D 0)
> +			return NULL;
> +		path->slots[0]--;
> +	}
> +
> +	leaf =3D path->nodes[0];
> +	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +	if (found_key.objectid !=3D dir ||
> +	    found_key.type !=3D BTRFS_DIR_ITEM_KEY ||
> +	    found_key.offset !=3D key.offset)
> +		return NULL;
> +
> +	return btrfs_match_dir_item_name(root, path, name, name_len);
> +}
> +
>  static int __verify_dir_item(struct btrfs_dir_item *item, u32 start, u3=
2 total)
>  {
>  	u16 max_len =3D BTRFS_NAME_LEN;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index df2f6590bb40..af4f30bbd50c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -161,6 +161,115 @@ int __btrfs_readlink(const struct __btrfs_root *ro=
ot, u64 inr, char *target)
>  	return 0;
>  }
>
> +static int lookup_root_ref(struct btrfs_fs_info *fs_info,
> +			   u64 rootid, u64 *root_ret, u64 *dir_ret)
> +{
> +	struct btrfs_root *root =3D fs_info->tree_root;
> +	struct btrfs_root_ref *root_ref;
> +	struct btrfs_path path;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	btrfs_init_path(&path);
> +	key.objectid =3D rootid;
> +	key.type =3D BTRFS_ROOT_BACKREF_KEY;
> +	key.offset =3D (u64)-1;
> +
> +	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	/* Should not happen */
> +	if (ret =3D=3D 0) {
> +		ret =3D -EUCLEAN;
> +		goto out;
> +	}
> +	ret =3D btrfs_previous_item(root, &path, rootid, BTRFS_ROOT_BACKREF_KE=
Y);
> +	if (ret < 0)
> +		goto out;
> +	if (ret > 0) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +	root_ref =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
> +				  struct btrfs_root_ref);
> +	*root_ret =3D key.offset;
> +	*dir_ret =3D btrfs_root_ref_dirid(path.nodes[0], root_ref);
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> +
> +/*
> + * To get the parent inode of @ino of @root.
> + *
> + * @root_ret and @ino_ret will be filled.
> + *
> + * NOTE: This function is not reliable. It can only get one parent inod=
e.
> + * The get the proper parent inode, we need a full VFS inodes stack to
> + * resolve properly.
> + */
> +static int get_parent_inode(struct btrfs_root *root, u64 ino,
> +			    struct btrfs_root **root_ret, u64 *ino_ret)
> +{
> +	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_path path;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	if (ino =3D=3D BTRFS_FIRST_FREE_OBJECTID) {
> +		u64 parent_root;
> +
> +		/* It's top level already, no more parent */
> +		if (root->root_key.objectid =3D=3D BTRFS_FS_TREE_OBJECTID) {
> +			*root_ret =3D fs_info->fs_root;
> +			*ino_ret =3D BTRFS_FIRST_FREE_OBJECTID;
> +			return 0;
> +		}
> +
> +		ret =3D lookup_root_ref(fs_info, root->root_key.objectid,
> +				      &parent_root, ino_ret);
> +		if (ret < 0)
> +			return ret;
> +
> +		key.objectid =3D parent_root;
> +		key.type =3D BTRFS_ROOT_ITEM_KEY;
> +		key.offset =3D (u64)-1;
> +		*root_ret =3D btrfs_read_fs_root(fs_info, &key);
> +		if (IS_ERR(*root_ret))
> +			return PTR_ERR(*root_ret);
> +
> +		return 0;
> +	}
> +
> +	btrfs_init_path(&path);
> +	key.objectid =3D ino;
> +	key.type =3D BTRFS_INODE_REF_KEY;
> +	key.offset =3D (u64)-1;
> +
> +	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	/* Should not happen */
> +	if (ret =3D=3D 0) {
> +		ret =3D -EUCLEAN;
> +		goto out;
> +	}
> +	ret =3D btrfs_previous_item(root, &path, ino, BTRFS_INODE_REF_KEY);
> +	if (ret < 0)
> +		goto out;
> +	if (ret > 0) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +	*root_ret =3D root;
> +	*ino_ret =3D key.offset;
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> +
>  /* inr must be a directory (for regular files with multiple hard links =
this
>     function returns only one of the parents of the file) */
>  static u64 __get_parent_inode(struct __btrfs_root *root, u64 inr,
> @@ -235,6 +344,142 @@ static inline const char *skip_current_directories=
(const char *cur)
>  	return cur;
>  }
>
> +/*
> + * Resolve one filename of @ino of @root.
> + *
> + * key_ret:	The child key (either INODE_ITEM or ROOT_ITEM type)
> + * type_ret:	BTRFS_FT_* of the child inode.
> + *
> + * Return 0 with above members filled.
> + * Return <0 for error.
> + */
> +static int resolve_one_filename(struct btrfs_root *root, u64 ino,
> +				const char *name, int namelen,
> +				struct btrfs_key *key_ret, u8 *type_ret)
> +{
> +	struct btrfs_dir_item *dir_item;
> +	struct btrfs_path path;
> +	int ret =3D 0;
> +
> +	btrfs_init_path(&path);
> +
> +	dir_item =3D btrfs_lookup_dir_item(NULL, root, &path, ino, name,
> +					 namelen, 0);
> +	if (IS_ERR(dir_item)) {
> +		ret =3D PTR_ERR(dir_item);
> +		goto out;
> +	}
> +
> +	btrfs_dir_item_key_to_cpu(path.nodes[0], dir_item, key_ret);
> +	*type_ret =3D btrfs_dir_type(path.nodes[0], dir_item);
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> +
> +/*
> + * Resolve a full path @filename. The start point is @ino of @root.
> + *
> + * The result will be filled into @root_ret, @ino_ret and @type_ret.
> + */
> +int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *fil=
ename,
> +			struct btrfs_root **root_ret, u64 *ino_ret,
> +			u8 *type_ret, int symlink_limit)
> +{
> +	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_root *next_root;
> +	struct btrfs_key key;
> +	const char *cur =3D filename;
> +	u64 next_ino;
> +	u8 next_type;
> +	u8 type;
> +	int len;
> +	int ret =3D 0;
> +
> +	/* If the path is absolute path, also search from fs root */
> +	if (*cur =3D=3D '/') {
> +		root =3D fs_info->fs_root;
> +		ino =3D btrfs_root_dirid(&root->root_item);
> +		type =3D BTRFS_FT_DIR;
> +	}
> +
> +	while (*cur !=3D '\0') {
> +
> +		cur =3D skip_current_directories(cur);
> +		len =3D next_length(cur);
> +		if (len > BTRFS_NAME_LEN) {

next_length() promises @len <=3D BTRFS_NAME_LEN, so the check is trivial.

> +			printf("%s: Name too long at \"%.*s\"\n", __func__,
> +			       BTRFS_NAME_LEN, cur);
> +			return -ENAMETOOLONG;
> +		}
> +		if (len =3D=3D 1 && cur[0] =3D=3D '.')
> +			break;
> +		/* Go one level up */
> +		if (len =3D=3D 2 && cur[0] =3D=3D '.' && cur[1] =3D=3D '.') {
> +			ret =3D get_parent_inode(root, ino, &next_root, &next_ino);
> +			if (ret < 0)
> +				return ret;
> +			root =3D next_root;
> +			ino =3D next_ino;
> +			goto next;
> +		}
> +		if (!*cur)
> +			break;
> +
> +		ret =3D resolve_one_filename(root, ino, cur, len, &key, &type);
> +		if (ret < 0)
> +			return ret;
> +		/* Child inode is a subvolume */
> +		if (key.type =3D=3D BTRFS_ROOT_ITEM_KEY) {
> +
> +			next_root =3D btrfs_read_fs_root(fs_info, &key);
> +			if (IS_ERR(next_root))
> +				return PTR_ERR(next_root);
> +			root =3D next_root;
> +			ino =3D btrfs_root_dirid(&root->root_item);
> +			goto next;
> +		}
> +		/* Child inode is a symlink */
> +		if (type =3D=3D BTRFS_FT_SYMLINK && symlink_limit >=3D 0) {
> +			char *target;
> +
> +			if (symlink_limit =3D=3D 0) {
> +				printf("%s: Too much symlinks!\n", __func__);
> +				return -EMLINK;
> +			}
> +			target =3D malloc(fs_info->sectorsize);
> +			if (!target)
> +				return -ENOMEM;
> +			ret =3D btrfs_readlink(root, ino, target);
> +			if (ret < 0) {
> +				free(target);
> +				return ret;
> +			}
> +			target[ret] =3D '\0';

It was done in btrfs_readlink() already.
> +
> +			ret =3D btrfs_lookup_path(root, ino, target, &next_root,
> +						&next_ino, &next_type,
> +						symlink_limit);

Just notify gentlely this is a recursive call here. I don't know
whether uboot cares about stack things. But, recursion makes coding simple=
r :).

=2D-
Su
> +			if (ret < 0)
> +				return ret;
> +			root =3D next_root;
> +			ino =3D next_ino;
> +			type =3D next_type;
> +			goto next;
> +		}
> +		/* Child inode is an inode */
> +		ino =3D key.objectid;
> +next:
> +		cur +=3D len;
> +	}
> +	if (!ret) {
> +		*root_ret =3D root;
> +		*ino_ret =3D ino;
> +		*type_ret =3D type;
> +	}
> +	return ret;
> +}
> +
>  u64 __btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char =
*path,
>  		      u8 *type_p, struct btrfs_inode_item *inode_item_p,
>  		      int symlink_limit)

