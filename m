Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E15446BA4
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhKFArg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:47:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:35221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhKFArd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636159489;
        bh=AP7BAGxVnQd7/7xCnMxSX8c8u7FxMqxrVW71xVER52k=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FviXHQmzqf4QpYuF1o1b6BlNgoqOEcYguUlggAzbvocrtxlwfPkIIfl0CURpjfBLx
         3LdU12LOpoSKMQFPxvU0cCPa8U8PG/8+r4S1+DXlJj0hSoC72DQChEGT1o+V5dHJjM
         t1EoIl2ARH2nFCasmv0gtnW2LSmjHUXdPYIZBehg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5UN-1mvYZT2qYx-00FCnO; Sat, 06
 Nov 2021 01:44:49 +0100
Message-ID: <aeb475b0-3e54-9db3-a1c1-ded8dd44fec7@gmx.com>
Date:   Sat, 6 Nov 2021 08:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 14/20] btrfs-progs: stop accessing ->free_space_root
 directly
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <3a94a56ca844c243d961883b37e1a83d72409f4a.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3a94a56ca844c243d961883b37e1a83d72409f4a.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6q2QFHZ5AtcCfKxDROcZng7/3N3qTwcuJoQzyKsg4c/XzzLSMzr
 V6GjaizRt3sUFmIZybf0yMrstvLuVXFkO/KthU8fFLVIO4mI+lNrimcFK9vUkQiUNmBO44p
 BGcOOW93qLZ4jSvaiLEKWyzbVY5wPiL76DOYsZ9nv21vnoNH9ifOYuRyW1NwKgKc9dNKTgM
 spfZFMMV5LFjlh4sm2MpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eh3BZVkmwp8=:i5Kk5tMfJAcVUjddEu69nJ
 KDOhg4cHTrsxNmbJ63d0tu4KQMeHHRy8ZJmK+fkzSkNYNIjlcEivKNSw6kbu2XgMKlueGOtIp
 7w7hCAgb3vCbb9D5ernU4LOnJb7v5Qr2LKYxc18/OzmistSFRK5a0maFqxKccbSQd5XzFYnSl
 iv+5z9Z+506/hGX/qBczn2e+YRhuhFDo2prU9BQgJwymuayBaYCcoJavFBERcpScmrqHzPY0x
 vY8UBJ2SL3xcVHZLCi2O+0k+ChKIGkI6DKakDHWNOPR45JfoFjxYHEx0FKbxnMzbWK6ecfcjB
 yOcs3CCwaSaD60mAWnAfpPBxcPAMtAyUqS6MHaLVPVTMmmp0Og9P4Z1yTc3jDIGRJNOxYBIvB
 iv50HsE6DdaPpem1iwcwKQ6vEW5ZyvsIMxlGRQ0yC0pnoyC68SfCGFE85tl6TT6iPVJVpkW/l
 C496qhC9JWNO63h0sZSC02CxB2rZfXrKnkdf32w1E1oW0Ymu9z0lhlNLBvLz5301Hgc4fX5yJ
 hdHp0jf3SpXapa+XFwDrR2VrS6JwKayjv7v6dYzGK89wW6uCz62CB9o+JYt9D8XX8kiyjo45p
 Oa9AgHXYuWvKojErNJ9AAU4IgRnAYnwcVoW2msKOJ8jIBycNgjB7Lp5+b+gs/jxXzK/fh90qg
 2u74BfcN0ogpxNGwae5jyupKeu/pZ3XqFzI2YNTaUJ9o8JD6axmSrNDkca7Y2jtMEXy+dezAC
 xdP3Irn4H1COfPNc2Np+hN4QSeYoqaC6Gak7d6c5Jz/+pwOB0SngEphQ3j7b0wr36zXJXst3a
 67Kq8JaLRkqzqZC40FPq39YFqRJUYvHcTcqNymbuPnrt0NBPFFw2eTMcTEykp6J81VupPjgRt
 EX9xUNHK6TI/2+4e29Vd2EjySL0no4OeudS+s3QP+Vu1OasEcIJzGMZNf2tqld8RsKRLNQwD+
 oOBGt7M/AzuHx1EMKlw0XDR8I3NXOtW3kvnQF9XKoM9u2qCFPgKcjCckJW9vK3bMtNu2lrD5d
 reNN1QE9z3Q06cFCR1lJBRMFDUyDfVqDOEy8QDBypPIER+WJqIPDi3GiXHzfsPzHaOdqQEcJF
 BCJE01/mnHLVeE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We're going to have multiple free space roots in the future, so access
> it via a helper in most cases.  We will address the remaining direct
> accesses in future patches.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This is much better, there is no more place holder for
btrfs_free_pace_root() parameters.

But still, I'd prefer it to be in the extent-tree-v2 patchset other than
a dedicated preparation.

Thanks,
Qu
> ---
>   kernel-shared/ctree.h           |  2 +-
>   kernel-shared/disk-io.c         | 24 ++++++++++-----------
>   kernel-shared/free-space-tree.c | 37 +++++++++++++++++++++------------
>   mkfs/main.c                     |  4 ++--
>   4 files changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 23750156..c263a3bb 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1163,7 +1163,7 @@ struct btrfs_fs_info {
>   	struct btrfs_root *dev_root;
>   	struct btrfs_root *_csum_root;
>   	struct btrfs_root *quota_root;
> -	struct btrfs_root *free_space_root;
> +	struct btrfs_root *_free_space_root;
>   	struct btrfs_root *uuid_root;
>
>   	struct rb_root fs_root_tree;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index b4c45719..0e803db8 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -780,7 +780,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_f=
s_info *fs_info,
>   		return fs_info->quota_enabled ? fs_info->quota_root :
>   				ERR_PTR(-ENOENT);
>   	if (location->objectid =3D=3D BTRFS_FREE_SPACE_TREE_OBJECTID)
> -		return fs_info->free_space_root ? fs_info->free_space_root :
> +		return fs_info->_free_space_root ? fs_info->_free_space_root :
>   						ERR_PTR(-ENOENT);
>
>   	BUG_ON(location->objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID);
> @@ -810,7 +810,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_inf=
o)
>   	free(fs_info->chunk_root);
>   	free(fs_info->dev_root);
>   	free(fs_info->_csum_root);
> -	free(fs_info->free_space_root);
> +	free(fs_info->_free_space_root);
>   	free(fs_info->uuid_root);
>   	free(fs_info->super_copy);
>   	free(fs_info->log_root_tree);
> @@ -831,14 +831,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writab=
le, u64 sb_bytenr)
>   	fs_info->dev_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->_csum_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->quota_root =3D calloc(1, sizeof(struct btrfs_root));
> -	fs_info->free_space_root =3D calloc(1, sizeof(struct btrfs_root));
> +	fs_info->_free_space_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->uuid_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->super_copy =3D calloc(1, BTRFS_SUPER_INFO_SIZE);
>
>   	if (!fs_info->tree_root || !fs_info->_extent_root ||
>   	    !fs_info->chunk_root || !fs_info->dev_root ||
>   	    !fs_info->_csum_root || !fs_info->quota_root ||
> -	    !fs_info->free_space_root || !fs_info->uuid_root ||
> +	    !fs_info->_free_space_root || !fs_info->uuid_root ||
>   	    !fs_info->super_copy)
>   		goto free_all;
>
> @@ -1031,17 +1031,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *=
fs_info, u64 root_tree_bytenr,
>
>   	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
>   		ret =3D find_and_setup_root(root, fs_info, BTRFS_FREE_SPACE_TREE_OBJ=
ECTID,
> -					  fs_info->free_space_root);
> +					  fs_info->_free_space_root);
>   		if (ret) {
> -			free(fs_info->free_space_root);
> -			fs_info->free_space_root =3D NULL;
> +			free(fs_info->_free_space_root);
> +			fs_info->_free_space_root =3D NULL;
>   			printk("Couldn't read free space tree\n");
>   			return -EIO;
>   		}
> -		fs_info->free_space_root->track_dirty =3D 1;
> +		fs_info->_free_space_root->track_dirty =3D 1;
>   	} else {
> -		free(fs_info->free_space_root);
> -		fs_info->free_space_root =3D NULL;
> +		free(fs_info->_free_space_root);
> +		fs_info->_free_space_root =3D NULL;
>   	}
>
>   	ret =3D find_and_setup_log_root(root, fs_info, sb);
> @@ -1080,8 +1080,8 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs=
_info, u64 root_tree_bytenr,
>
>   void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
>   {
> -	if (fs_info->free_space_root)
> -		free_extent_buffer(fs_info->free_space_root->node);
> +	if (fs_info->_free_space_root)
> +		free_extent_buffer(fs_info->_free_space_root->node);
>   	if (fs_info->quota_root)
>   		free_extent_buffer(fs_info->quota_root->node);
>   	if (fs_info->_csum_root)
> diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-=
tree.c
> index 0434733d..70b3d62a 100644
> --- a/kernel-shared/free-space-tree.c
> +++ b/kernel-shared/free-space-tree.c
> @@ -25,13 +25,19 @@
>   #include "kernel-lib/bitops.h"
>   #include "common/internal.h"
>
> +static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *f=
s_info,
> +						struct btrfs_block_group *block_group)
> +{
> +	return fs_info->_free_space_root;
> +}
> +
>   static struct btrfs_free_space_info *
>   search_free_space_info(struct btrfs_trans_handle *trans,
>   		       struct btrfs_fs_info *fs_info,
>   		       struct btrfs_block_group *block_group,
>   		       struct btrfs_path *path, int cow)
>   {
> -	struct btrfs_root *root =3D fs_info->free_space_root;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_key key;
>   	int ret;
>
> @@ -103,7 +109,8 @@ static int add_new_free_space_info(struct btrfs_tran=
s_handle *trans,
>   				   struct btrfs_block_group *block_group,
>   				   struct btrfs_path *path)
>   {
> -	struct btrfs_root *root =3D trans->fs_info->free_space_root;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_free_space_info *info;
>   	struct btrfs_key key;
>   	struct extent_buffer *leaf;
> @@ -179,7 +186,7 @@ static int convert_free_space_to_bitmaps(struct btrf=
s_trans_handle *trans,
>   				  struct btrfs_path *path)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *root =3D fs_info->free_space_root;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_free_space_info *info;
>   	struct btrfs_key key, found_key;
>   	struct extent_buffer *leaf;
> @@ -318,7 +325,7 @@ static int convert_free_space_to_extents(struct btrf=
s_trans_handle *trans,
>   				  struct btrfs_path *path)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *root =3D fs_info->free_space_root;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_free_space_info *info;
>   	struct btrfs_key key, found_key;
>   	struct extent_buffer *leaf;
> @@ -558,7 +565,8 @@ static int modify_free_space_bitmap(struct btrfs_tra=
ns_handle *trans,
>   				    struct btrfs_path *path,
>   				    u64 start, u64 size, int remove)
>   {
> -	struct btrfs_root *root =3D trans->fs_info->free_space_root;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_key key;
>   	u64 end =3D start + size;
>   	u64 cur_start, cur_size;
> @@ -671,7 +679,8 @@ static int remove_free_space_extent(struct btrfs_tra=
ns_handle *trans,
>   				    struct btrfs_path *path,
>   				    u64 start, u64 size)
>   {
> -	struct btrfs_root *root =3D trans->fs_info->free_space_root;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_key key;
>   	u64 found_start, found_end;
>   	u64 end =3D start + size;
> @@ -811,7 +820,8 @@ static int add_free_space_extent(struct btrfs_trans_=
handle *trans,
>   				 struct btrfs_path *path,
>   				 u64 start, u64 size)
>   {
> -	struct btrfs_root *root =3D trans->fs_info->free_space_root;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_key key, new_key;
>   	u64 found_start, found_end;
>   	u64 end =3D start + size;
> @@ -1107,7 +1117,8 @@ out:
>   int remove_block_group_free_space(struct btrfs_trans_handle *trans,
>   				  struct btrfs_block_group *block_group)
>   {
> -	struct btrfs_root *root =3D trans->fs_info->free_space_root;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_path *path;
>   	struct btrfs_key key, found_key;
>   	struct extent_buffer *leaf;
> @@ -1215,7 +1226,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_in=
fo *fs_info)
>   {
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_root *tree_root =3D fs_info->tree_root;
> -	struct btrfs_root *free_space_root =3D fs_info->free_space_root;
> +	struct btrfs_root *free_space_root =3D btrfs_free_space_root(fs_info, =
NULL);
>   	int ret;
>   	u64 features;
>
> @@ -1227,7 +1238,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_in=
fo *fs_info)
>   	features &=3D ~(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
>   		      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
>   	btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
> -	fs_info->free_space_root =3D NULL;
> +	fs_info->_free_space_root =3D NULL;
>
>   	ret =3D clear_free_space_tree(trans, free_space_root);
>   	if (ret)
> @@ -1263,7 +1274,7 @@ static int load_free_space_bitmaps(struct btrfs_fs=
_info *fs_info,
>   				   u32 expected_extent_count,
>   				   int *errors)
>   {
> -	struct btrfs_root *root =3D fs_info->free_space_root;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_key key;
>   	int prev_bit =3D 0, bit;
>   	u64 extent_start =3D 0;
> @@ -1343,7 +1354,7 @@ static int load_free_space_extents(struct btrfs_fs=
_info *fs_info,
>   				   u32 expected_extent_count,
>   				   int *errors)
>   {
> -	struct btrfs_root *root =3D fs_info->free_space_root;
> +	struct btrfs_root *root =3D btrfs_free_space_root(fs_info, block_group=
);
>   	struct btrfs_key key, prev_key;
>   	int have_prev =3D 0;
>   	u64 start, end;
> @@ -1463,7 +1474,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_i=
nfo *fs_info)
>   		ret =3D PTR_ERR(free_space_root);
>   		goto abort;
>   	}
> -	fs_info->free_space_root =3D free_space_root;
> +	fs_info->_free_space_root =3D free_space_root;
>   	add_root_to_dirty_list(free_space_root);
>
>   	do {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 9647f12a..16f9ba19 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -289,8 +289,8 @@ static int recow_roots(struct btrfs_trans_handle *tr=
ans,
>   	ret =3D __recow_root(trans, csum_root);
>   	if (ret)
>   		return ret;
> -	if (info->free_space_root) {
> -		ret =3D __recow_root(trans, info->free_space_root);
> +	if (info->_free_space_root) {
> +		ret =3D __recow_root(trans, info->_free_space_root);
>   		if (ret)
>   			return ret;
>   	}
>
