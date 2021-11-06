Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E85446BB4
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 02:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhKFBOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 21:14:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:54585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhKFBOe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 21:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636161108;
        bh=K6i/AG6YAY0FCKrEPIZSASr4NJZVB2kfHG2jkVj98Lk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=dXvedo2oc174HHtLltmiUhwNoLo28Sso9woiYL+1tns3nwykn5oIOAhl/KU9rRTas
         rRc1HlfpgFKnYKXBLDzXoXLmBZYvbP+5U9B7FIeWl2Tou0dJRx99iyWZqVcTt0boYx
         eaf79tFyxlvgurtT0s+otOLpeFEUDvDVzTaMGdS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1miKlY2cUx-0021CK; Sat, 06
 Nov 2021 02:11:48 +0100
Message-ID: <749db638-d703-fd30-4835-d539806197cb@gmx.com>
Date:   Sat, 6 Nov 2021 09:11:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QpvDbpPzcZPiFVhNlC6YJIMmopMBobvG+G2EKTXkX6psiaNzdbQ
 pQNKF7hrh8YetXUcxVKGKFUh7GHnUW1RG7GNBsdt792i4XtVqyTplNopBX+xNaFRahAwhyY
 Ao5I+f/XnAOkvDyIHUCM9iO6u9U+gGNiZ24F+lF80b4ugQZOBElvRdueAR+vnE7voInFn/a
 X1A3EXMqCsyoH++o+aP+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dzSp7+f2H0o=:YWpZY58AVGQ/4YWW67Pu1v
 r/elnJT8pQqRc2yjwwBVeGJaMySRbd+OuJ7GZ18IpZOmMFp5zfvM+q+VN+NBhJA1VAianDVm0
 7j+Av/MAw+ph0CaLu2zJECT2ogyhgBnJUgqSMVXaj88XnjPVBHk0j4vq+VzgJ2gjBd7yYcxDv
 qGPSpnZQvqSjIPD4ED+rsiCVTFf8E9tsOtJVztCbP1y5R1iBGuK965x8XJJOwTx+YwSKJuT3b
 idHgKjgax70iLTks58da1R8L6ou4ddiZY1kzQK9qP0rWIxsQPj6QShqRllgimpE8SsCFMbY/k
 7k02WbxDTxsnGbTWI3sQUuqbGklH2oX0SWhwMnILMtH8TGP+di8+pmsJH4pOUbUSxW5a4VNCd
 HUlqOqbvkP9q02+hV7s/rkMe3Weeem6E6LsFQwomT1M8+7ANE8fbZc5620mkbr5RY8otTxLvo
 76dJ8ViUgTbMTSyrC8amA/TbNcHN3DwP/hukc+GrKAgj6q8m9sI0GrZn5w35I/xRskkRyh7yh
 EpUHmm+fD0P71oIwwkfNbqA5I7tAnPUNn7EetNts5Z5JITeAIvvyVxi7gGyR6hZjU0okYMgxn
 UX12hRnHu7oR2VxFYlcas0mfchnCGfnX5NJGnyXT308PXcvIuuYEJ7nCSUpIyvs0yqtnKxMC2
 hIxq75Tt4KHO/4GfXHNNPVpU5vt97A0+OoSWwYQRK32Iwp30ePX7ZiwRyjNm3eishcSa7W1mX
 E/adZKyNAR4YI0kxo9loOxOWj0iTP191hremFgiBwix9N9G+fMb/QsEd1J7/Jd5tQS8JjEkBq
 hpt3vra/TylOcFUXQavXi/Pz/doCSKCWN92B18UWtnOXEVvh6+jbD7tdEl/jDmIeCa7cVCySK
 3GmJEdyr/pWyNIJ66PEaZNmHkiVY6hzba95zxfl8VP+DGygIayEfb/FZKbSQXx2Vt+hF2WnLa
 rNFtIdY2QSP5a9KKl+C5giHMzeprB84k6UXP1BX/tbvqqvxP/cphHHX/+juaWSYwXZrVTMbjB
 rVtmUx4udscBEOJ4RbiQdN+MhwpVLg6m4YS9EhfNgsYCQ3hP92OpSNa5j81CD5ivqeOpPuiJa
 6vN+hjaFFsyajM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:49, Josef Bacik wrote:
> This code adds the on disk structures for the block group root, which
> will hold the block group items for extent tree v2.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ctree.h                | 26 ++++++++++++++++-
>   fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
>   fs/btrfs/disk-io.h              |  2 ++
>   fs/btrfs/print-tree.c           |  1 +
>   include/trace/events/btrfs.h    |  1 +
>   include/uapi/linux/btrfs_tree.h |  3 ++
>   6 files changed, 74 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8ec2f068a1c2..b57367141b95 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -271,8 +271,13 @@ struct btrfs_super_block {
>   	/* the UUID written into btree blocks */
>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
>
> +	__le64 block_group_root;
> +	__le64 block_group_root_generation;
> +	u8 block_group_root_level;
> +

Is there any special reason that, block group root can't be put into
root tree?

If it's to reduce the unnecessary update on tree root, then I guess free
space tree root should also have some space in super block.

As now free space tree(s) and extent tree(s) are having almost the same
hotness, thus one having direct pointer in super block, while the other
doesn't would not make much sense.

>   	/* future expansion */
> -	__le64 reserved[28];
> +	u8 reserved8[7];
> +	__le64 reserved[25];
>   	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>   	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
>
> @@ -648,6 +653,7 @@ struct btrfs_fs_info {
>   	struct btrfs_root *quota_root;
>   	struct btrfs_root *uuid_root;
>   	struct btrfs_root *data_reloc_root;
> +	struct btrfs_root *block_group_root;
>
>   	/* the log root tree is a directory of all the other log roots */
>   	struct btrfs_root *log_root_tree;
> @@ -2326,6 +2332,17 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struc=
t btrfs_root_backup,
>   BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
>   		   num_devices, 64);
>
> +/*
> + * for extent tree v2 we overload the extent root with the block group =
root, as
> + * we will have multiple extent roots.
> + */
> +BTRFS_SETGET_STACK_FUNCS(backup_block_group_root, struct btrfs_root_bac=
kup,
> +			 extent_root, 64);
> +BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_gen, struct btrfs_root=
_backup,
> +			 extent_root_gen, 64);
> +BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_level,
> +			 struct btrfs_root_backup, extent_root_level, 8);

This also applies to free space trees root.

Thus I'd say, either they both have super block pointers and backup
roots, or none of them has.

Thanks,
Qu

> +
>   /* struct btrfs_balance_item */
>   BTRFS_SETGET_FUNCS(balance_flags, struct btrfs_balance_item, flags, 64=
);
>
> @@ -2460,6 +2477,13 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, =
struct btrfs_super_block,
>   BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic,=
 64);
>   BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_supe=
r_block,
>   			 uuid_tree_generation, 64);
> +BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_blo=
ck,
> +			 block_group_root, 64);
> +BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
> +			 struct btrfs_super_block,
> +			 block_group_root_generation, 64);
> +BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_sup=
er_block,
> +			 block_group_root_level, 8);
>
>   int btrfs_super_csum_size(const struct btrfs_super_block *s);
>   const char *btrfs_super_csum_name(u16 csum_type);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index db8e4856364e..45b2bde43150 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1733,6 +1733,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_i=
nfo)
>   	btrfs_put_root(fs_info->uuid_root);
>   	btrfs_put_root(fs_info->fs_root);
>   	btrfs_put_root(fs_info->data_reloc_root);
> +	btrfs_put_root(fs_info->block_group_root);
>   	btrfs_check_leaked_roots(fs_info);
>   	btrfs_extent_buffer_leak_debug_check(fs_info);
>   	kfree(fs_info->super_copy);
> @@ -2093,7 +2094,6 @@ static void backup_super_roots(struct btrfs_fs_inf=
o *info)
>   {
>   	const int next_backup =3D info->backup_root_index;
>   	struct btrfs_root_backup *root_backup;
> -	struct btrfs_root *extent_root =3D btrfs_extent_root(info, 0);
>   	struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0);
>
>   	root_backup =3D info->super_for_commit->super_roots + next_backup;
> @@ -2119,11 +2119,23 @@ static void backup_super_roots(struct btrfs_fs_i=
nfo *info)
>   	btrfs_set_backup_chunk_root_level(root_backup,
>   			       btrfs_header_level(info->chunk_root->node));
>
> -	btrfs_set_backup_extent_root(root_backup, extent_root->node->start);
> -	btrfs_set_backup_extent_root_gen(root_backup,
> -			       btrfs_header_generation(extent_root->node));
> -	btrfs_set_backup_extent_root_level(root_backup,
> -			       btrfs_header_level(extent_root->node));
> +	if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
> +		btrfs_set_backup_block_group_root(root_backup,
> +					info->block_group_root->node->start);
> +		btrfs_set_backup_block_group_root_gen(root_backup,
> +			btrfs_header_generation(info->block_group_root->node));
> +		btrfs_set_backup_block_group_root_level(root_backup,
> +			btrfs_header_level(info->block_group_root->node));
> +	} else {
> +		struct btrfs_root *extent_root =3D btrfs_extent_root(info, 0);
> +
> +		btrfs_set_backup_extent_root(root_backup,
> +					     extent_root->node->start);
> +		btrfs_set_backup_extent_root_gen(root_backup,
> +				btrfs_header_generation(extent_root->node));
> +		btrfs_set_backup_extent_root_level(root_backup,
> +					btrfs_header_level(extent_root->node));
> +	}
>
>   	/*
>   	 * we might commit during log recovery, which happens before we set
> @@ -2268,6 +2280,7 @@ static void free_root_pointers(struct btrfs_fs_inf=
o *info, bool free_chunk_root)
>   	free_root_extent_buffers(info->uuid_root);
>   	free_root_extent_buffers(info->fs_root);
>   	free_root_extent_buffers(info->data_reloc_root);
> +	free_root_extent_buffers(info->block_group_root);
>   	if (free_chunk_root)
>   		free_root_extent_buffers(info->chunk_root);
>   }
> @@ -2970,8 +2983,20 @@ static int load_important_roots(struct btrfs_fs_i=
nfo *fs_info)
>   	gen =3D btrfs_super_generation(sb);
>   	level =3D btrfs_super_root_level(sb);
>   	ret =3D load_super_root(fs_info->tree_root, bytenr, gen, level);
> -	if (ret)
> +	if (ret) {
>   		btrfs_warn(fs_info, "couldn't read tree root");
> +		return ret;
> +	}
> +
> +	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +		return 0;
> +
> +	bytenr =3D btrfs_super_block_group_root(sb);
> +	gen =3D btrfs_super_block_group_root_generation(sb);
> +	level =3D btrfs_super_block_group_root_level(sb);
> +	ret =3D load_super_root(fs_info->block_group_root, bytenr, gen, level)=
;
> +	if (ret)
> +		btrfs_warn(fs_info, "couldn't read block group root");
>   	return ret;
>   }
>
> @@ -2984,6 +3009,16 @@ static int __cold init_tree_roots(struct btrfs_fs=
_info *fs_info)
>   	int ret =3D 0;
>   	int i;
>
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +		struct btrfs_root *root;
> +		root =3D btrfs_alloc_root(fs_info,
> +					BTRFS_BLOCK_GROUP_TREE_OBJECTID,
> +					GFP_KERNEL);
> +		if (!root)
> +			return -ENOMEM;
> +		fs_info->block_group_root =3D root;
> +	}
> +
>   	for (i =3D 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
>   		if (handle_error) {
>   			if (!IS_ERR(tree_root->node))
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 80b45fcac72a..fe2e16e75a3b 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -113,6 +113,8 @@ static inline struct btrfs_root *btrfs_grab_root(str=
uct btrfs_root *root)
>
>   static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_f=
s_info *fs_info)
>   {
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +		return fs_info->block_group_root;
>   	return btrfs_extent_root(fs_info, 0);
>   }
>
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index aae1027bd76a..5d89c230af94 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -23,6 +23,7 @@ static const struct root_name_map root_map[] =3D {
>   	{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
>   	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
>   	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
> +	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
>   	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
>   };
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 0d729664b4b4..f068ff30d654 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -53,6 +53,7 @@ struct btrfs_space_info;
>   		{ BTRFS_TREE_RELOC_OBJECTID,	"TREE_RELOC"	},	\
>   		{ BTRFS_UUID_TREE_OBJECTID,	"UUID_TREE"	},	\
>   		{ BTRFS_FREE_SPACE_TREE_OBJECTID, "FREE_SPACE_TREE" },	\
> +		{ BTRFS_BLOCK_GROUP_TREE_OBJECTID, "BLOCK_GROUP_TREE" },\
>   		{ BTRFS_DATA_RELOC_TREE_OBJECTID, "DATA_RELOC_TREE" })
>
>   #define show_root_type(obj)						\
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index e1c4c732aaba..75c76b685972 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -53,6 +53,9 @@
>   /* tracks free space in block groups. */
>   #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
>
> +/* holds the block group items for extent tree v2. */
> +#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
> +
>   /* device stats in the device tree */
>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>
>
