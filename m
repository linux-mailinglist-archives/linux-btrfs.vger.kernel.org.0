Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8772D446BA2
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhKFAoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:44:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:38865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhKFAoS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636159293;
        bh=T3moNEdEYxaiEB3Hc7aG6VZqud6CsnB9A8ah9vORsWg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XY3jf4VHzftl+j/uf18rt3pmWGSgLPfRwvO1K40Plb2SwdN8WnJhE1HWt7p7ODuN/
         /VYMvsf8/aL+CnOOPCFSKUMeG25UMVWho/uQOwo2yEmRniwimhtllDEYWPy/VFnsLI
         5TM/8M0IDDlMvTlDPGc7t8cD7VC4X+anMyDsfIwM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8mb-1mCrHy1Egv-00fBRP; Sat, 06
 Nov 2021 01:41:32 +0100
Message-ID: <de1aa17e-79b4-ca58-4b9c-15c1a8cf0520@gmx.com>
Date:   Sat, 6 Nov 2021 08:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 13/20] btrfs-progs: stop accessing ->extent_root directly
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <4d2b81a2f263fd9285ecc891ad091b8678b38557.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4d2b81a2f263fd9285ecc891ad091b8678b38557.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kCbWCYVRzDFvmhzfhnSntL+9J9DVhRNmtyk9bpjTbRcdexB3kvw
 6uk6YdVJfDVBEMJZ1tfA/e8Ikh6UntIPlMSCfGnC8jkWd2Y4xJ91yZJlOJ9x0hdxxjQ1q1V
 RW8Wla4HkW6N8Af6nnrrjlsOwJf+VzAb7cSAEU/PxdfGmj3566tWOzDGIZeapt3RfLlTkqH
 qRjcLdkI3mL1A+ltEfNWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:30HfIZQGIqY=:W5svIsjcilaB9KMJHgWC4E
 OhaGR0Vnvku+y9Piv4E7S2IY0fHG2A8Zv/vLUGtI0of/63PThI/PMDdsVt0xKbYlnQffQ22Kz
 39PBz3Wh584l2LSs4FnbPzcMBpL6MoTKA1DUwmIy62wR0Uo7Z4TvSErz+23KADWQn9mXfotYk
 njPS95QfT7AuoI8F4C+gKmGcUxczYMcjqE6BAlSmAT1VKoX+UFy9+AMVmpmonK6w/Rsa7RT2s
 mJUr10mVrf4tWK7m/GIFQNU35sPabOdoQjWR5BHHvd8Wu+KDJLe/CmMWxm161aywDoGik6y6O
 awCdIrPXJFVh72BtKlABrjJQt2dxqOP6LpHjCyZiUa40phTyBHqFIBeGYbnKEo5tNG4/OOP+U
 eHVGO63cQoVXRaGbErujH4L/Wn2EoZ42/y/mOVOErnX0KdWxrsPNCoBDXpmKdoAhM+b8ESBfp
 LkJybo3FfLq3tZxNY+o8k+h/bvxyLt1RcXv3N8QmrSe1PX5vdbVZ424XyVzva2ekzQTSwdKtT
 mUjX7XRIfd3Ztzl8dKRShfUptXBXNJr/ZNjGYycZ9Ksn2vB80qrh7gRo7njbkmb9KsFlbQ4NZ
 IilZgch4uGdLNnsiHf8rWjBWFEDsgUT9+46vuLhqfNSwNg9Y0xdpz8b4rJjAPIY2QfEuPrHoZ
 db2QBbwim3NzEoCraO9mXYz2Up9hZPu481iAE0r1QdXQHtNQ7Tkm3GOwVbeE5JKUGpNUWGNUK
 zTP+nklsoF61kkS/nbpgrt8zTF/PcVWq6hYl6Ouy4HEzPjLvc7enJ0ZFiP43WxQOgts7zjWc1
 8+s3G5a+VtonJRTQuLIqMsmuwPmazoO5P0pCVKWw3bGRNdvUCKgC+MqKZMyQIM5nW6YvsaZTF
 xLUG0FNPTplXrj9Uutisns6KNY4sAarWwYqau7EpJrQEDntbMqBJLllKUQzfPPJh3lG5+JS2R
 araOBycsyoDsoVe++Mnnx5fBbLQrLmG3TPcyiA0H/fN7nL6dO0y052pguLrKecsZJ+0rjdz21
 QrGK6nxmJPLXtPS277ebrAKrovxZZYITQk9Sr6WFeuqCJLfteH7jrPGrdV/GotyDjOA9tkhrW
 pFVqhG9fsWdG48=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> When we switch to multiple global trees we'll need to access the
> appropriate extent root depending on the block group or possibly root.
> To handle this, use a helper in most places and then the actual root in
> places where it is required.  We will whittle down the direct accessors
> with future patches, but this does the bulk of the preparatory work.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   btrfs-corrupt-block.c           | 13 +++---
>   btrfs-map-logical.c             |  9 ++--
>   btrfstune.c                     |  2 +-
>   check/main.c                    | 78 +++++++++++++++++++--------------
>   check/mode-common.c             |  8 ++--
>   check/mode-lowmem.c             | 72 +++++++++++++++++-------------
>   check/qgroup-verify.c           |  2 +-
>   cmds/rescue-chunk-recover.c     | 18 ++++----
>   common/repair.c                 |  5 +--
>   convert/main.c                  |  4 +-
>   image/main.c                    |  2 +-
>   kernel-shared/backref.c         | 10 +++--
>   kernel-shared/ctree.h           |  2 +-
>   kernel-shared/disk-io.c         | 30 ++++++++-----
>   kernel-shared/disk-io.h         |  1 +
>   kernel-shared/extent-tree.c     | 42 ++++++++++--------
>   kernel-shared/free-space-tree.c |  8 +++-
>   kernel-shared/volumes.c         |  3 +-
>   kernel-shared/zoned.c           |  2 +-
>   mkfs/main.c                     |  4 +-
>   20 files changed, 179 insertions(+), 136 deletions(-)
>
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index d7904b6f..d976345c 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -183,6 +183,7 @@ static int corrupt_keys_in_block(struct btrfs_fs_inf=
o *fs_info, u64 bytenr)
>   static int corrupt_extent(struct btrfs_trans_handle *trans,
>   			  struct btrfs_root *root, u64 bytenr)
>   {
> +	struct btrfs_root *extent_root;
>   	struct btrfs_key key;
>   	struct extent_buffer *leaf;
>   	u32 item_size;
> @@ -200,9 +201,9 @@ static int corrupt_extent(struct btrfs_trans_handle =
*trans,
>   	key.type =3D (u8)-1;
>   	key.offset =3D (u64)-1;
>
> +	extent_root =3D btrfs_extent_root(trans->fs_info, bytenr);
>   	while(1) {
> -		ret =3D btrfs_search_slot(trans, root->fs_info->extent_root,
> -					&key, path, -1, 1);
> +		ret =3D btrfs_search_slot(trans, extent_root, &key, path, -1, 1);
>   		if (ret < 0)
>   			break;
>
> @@ -472,7 +473,7 @@ static int corrupt_block_group(struct btrfs_root *ro=
ot, u64 bg, char *field)
>   	u64 orig, bogus;
>   	int ret =3D 0;
>
> -	root =3D root->fs_info->extent_root;
> +	root =3D btrfs_extent_root(root->fs_info, 0);

The problem is the same as previous helper for csum root.

There are too many 0 as place holders, which may need extra refactor again=
.

Thus I prefer these helpers to be introduced before we really need them.

Thanks,
Qu

>
>   	corrupt_field =3D convert_block_group_field(field);
>   	if (corrupt_field =3D=3D BTRFS_BLOCK_GROUP_ITEM_BAD) {
> @@ -1382,11 +1383,13 @@ int main(int argc, char **argv)
>   	}
>   	if (extent_tree) {
>   		struct btrfs_trans_handle *trans;
> +		struct btrfs_root *extent_root;
>
> +		extent_root =3D btrfs_extent_root(root->fs_info, 0);
>   		trans =3D btrfs_start_transaction(root, 1);
>   		BUG_ON(IS_ERR(trans));
> -		btrfs_corrupt_extent_tree(trans, root->fs_info->extent_root,
> -					  root->fs_info->extent_root->node);
> +		btrfs_corrupt_extent_tree(trans, extent_root,
> +					  extent_root->node);
>   		btrfs_commit_transaction(trans, root);
>   		goto out_close;
>   	}
> diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
> index 4ac644b4..b3a7526b 100644
> --- a/btrfs-map-logical.c
> +++ b/btrfs-map-logical.c
> @@ -42,6 +42,7 @@ static FILE *info_file;
>   static int map_one_extent(struct btrfs_fs_info *fs_info,
>   			  u64 *logical_ret, u64 *len_ret, int search_forward)
>   {
> +	struct btrfs_root *extent_root;
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	u64 logical;
> @@ -59,8 +60,8 @@ static int map_one_extent(struct btrfs_fs_info *fs_inf=
o,
>   	key.type =3D 0;
>   	key.offset =3D 0;
>
> -	ret =3D btrfs_search_slot(NULL, fs_info->extent_root, &key, path,
> -				0, 0);
> +	extent_root =3D btrfs_extent_root(fs_info, logical);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		goto out;
>   	BUG_ON(ret =3D=3D 0);
> @@ -73,10 +74,10 @@ again:
>   	    (key.type !=3D BTRFS_EXTENT_ITEM_KEY &&
>   	     key.type !=3D BTRFS_METADATA_ITEM_KEY)) {
>   		if (!search_forward)
> -			ret =3D btrfs_previous_extent_item(fs_info->extent_root,
> +			ret =3D btrfs_previous_extent_item(extent_root,
>   							 path, 0);
>   		else
> -			ret =3D btrfs_next_extent_item(fs_info->extent_root,
> +			ret =3D btrfs_next_extent_item(extent_root,
>   						     path, 0);
>   		if (ret)
>   			goto out;
> diff --git a/btrfstune.c b/btrfstune.c
> index d34d89c1..4f77cfc0 100644
> --- a/btrfstune.c
> +++ b/btrfstune.c
> @@ -233,7 +233,7 @@ static int change_buffer_header_uuid(struct extent_b=
uffer *eb, uuid_t new_fsid)
>
>   static int change_extents_uuid(struct btrfs_fs_info *fs_info, uuid_t n=
ew_fsid)
>   {
> -	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(fs_info, 0);
>   	struct btrfs_path path;
>   	struct btrfs_key key =3D {0, 0, 0};
>   	int ret =3D 0;
> diff --git a/check/main.c b/check/main.c
> index 632dfba0..e3e5a336 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5619,7 +5619,7 @@ static int verify_space_cache(struct btrfs_root *r=
oot,
>   	u64 last;
>   	int ret =3D 0;
>
> -	root =3D gfs_info->extent_root;
> +	root =3D btrfs_extent_root(root->fs_info, cache->start);
>
>   	last =3D max_t(u64, cache->start, BTRFS_SUPER_INFO_OFFSET);
>
> @@ -5837,6 +5837,7 @@ out:
>   static int check_extent_exists(struct btrfs_root *root, u64 bytenr,
>   			       u64 num_bytes)
>   {
> +	struct btrfs_root *extent_root;
>   	struct btrfs_path path;
>   	struct extent_buffer *leaf;
>   	struct btrfs_key key;
> @@ -5848,7 +5849,8 @@ static int check_extent_exists(struct btrfs_root *=
root, u64 bytenr,
>   	key.offset =3D (u64)-1;
>
>   again:
> -	ret =3D btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path,
> +	extent_root =3D btrfs_extent_root(gfs_info, key.objectid);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path,
>   				0, 0);
>   	if (ret < 0) {
>   		fprintf(stderr, "Error looking up extent record %d\n", ret);
> @@ -5858,7 +5860,7 @@ again:
>   		if (path.slots[0] > 0) {
>   			path.slots[0]--;
>   		} else {
> -			ret =3D btrfs_prev_leaf(root, &path);
> +			ret =3D btrfs_prev_leaf(extent_root, &path);
>   			if (ret < 0) {
>   				goto out;
>   			} else if (ret > 0) {
> @@ -5882,7 +5884,7 @@ again:
>   		if (path.slots[0] > 0) {
>   			path.slots[0]--;
>   		} else {
> -			ret =3D btrfs_prev_leaf(root, &path);
> +			ret =3D btrfs_prev_leaf(extent_root, &path);
>   			if (ret < 0) {
>   				goto out;
>   			} else if (ret > 0) {
> @@ -5895,7 +5897,7 @@ again:
>
>   	while (num_bytes) {
>   		if (path.slots[0] >=3D btrfs_header_nritems(path.nodes[0])) {
> -			ret =3D btrfs_next_leaf(root, &path);
> +			ret =3D btrfs_next_leaf(extent_root, &path);
>   			if (ret < 0) {
>   				fprintf(stderr, "Error going to next leaf "
>   					"%d\n", ret);
> @@ -5946,7 +5948,8 @@ again:
>   				 * anyway just in case.
>   				 */
>   				btrfs_release_path(&path);
> -				ret =3D check_extent_exists(root, new_start,
> +				ret =3D check_extent_exists(extent_root,
> +							  new_start,
>   							  new_bytes);
>   				if (ret) {
>   					fprintf(stderr, "Right section didn't "
> @@ -6720,6 +6723,7 @@ static int delete_extent_records(struct btrfs_tran=
s_handle *trans,
>   				 struct btrfs_path *path,
>   				 u64 bytenr)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info, bytenr)=
;
>   	struct btrfs_key key;
>   	struct btrfs_key found_key;
>   	struct extent_buffer *leaf;
> @@ -6732,7 +6736,7 @@ static int delete_extent_records(struct btrfs_tran=
s_handle *trans,
>   	key.offset =3D (u64)-1;
>
>   	while (1) {
> -		ret =3D btrfs_search_slot(trans, gfs_info->extent_root, &key,
> +		ret =3D btrfs_search_slot(trans, extent_root, &key,
>   					path, 0, 1);
>   		if (ret < 0)
>   			break;
> @@ -6775,7 +6779,7 @@ static int delete_extent_records(struct btrfs_tran=
s_handle *trans,
>   			"repair deleting extent record: key [%llu,%u,%llu]\n",
>   			found_key.objectid, found_key.type, found_key.offset);
>
> -		ret =3D btrfs_del_item(trans, gfs_info->extent_root, path);
> +		ret =3D btrfs_del_item(trans, extent_root, path);
>   		if (ret)
>   			break;
>   		btrfs_release_path(path);
> @@ -6807,7 +6811,8 @@ static int record_extent(struct btrfs_trans_handle=
 *trans,
>   			 int allocated, u64 flags)
>   {
>   	int ret =3D 0;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info,
> +							   rec->start);
>   	struct extent_buffer *leaf;
>   	struct btrfs_key ins_key;
>   	struct btrfs_extent_item *ei;
> @@ -6888,7 +6893,7 @@ static int record_extent(struct btrfs_trans_handle=
 *trans,
>   			 * just makes the backref allocator create a data
>   			 * backref
>   			 */
> -			ret =3D btrfs_inc_extent_ref(trans, gfs_info->extent_root,
> +			ret =3D btrfs_inc_extent_ref(trans, extent_root,
>   						   rec->start, rec->max_size,
>   						   parent,
>   						   dback->root,
> @@ -6917,7 +6922,7 @@ static int record_extent(struct btrfs_trans_handle=
 *trans,
>   		else
>   			parent =3D 0;
>
> -		ret =3D btrfs_inc_extent_ref(trans, gfs_info->extent_root,
> +		ret =3D btrfs_inc_extent_ref(trans, extent_root,
>   					   rec->start, rec->max_size,
>   					   parent, tback->root, 0, 0);
>   		fprintf(stderr,
> @@ -7437,7 +7442,6 @@ static int delete_duplicate_records(struct btrfs_r=
oot *root,
>   		list_move_tail(&tmp->list, &delete_list);
>   	}
>
> -	root =3D gfs_info->extent_root;
>   	trans =3D btrfs_start_transaction(root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
> @@ -7459,6 +7463,7 @@ static int delete_duplicate_records(struct btrfs_r=
oot *root,
>   			abort();
>   		}
>
> +		root =3D btrfs_extent_root(gfs_info, key.objectid);
>   		ret =3D btrfs_search_slot(trans, root, &key, &path, -1, 1);
>   		if (ret) {
>   			if (ret > 0)
> @@ -7697,7 +7702,7 @@ static int fixup_extent_refs(struct cache_tree *ex=
tent_cache,
>   	if (ret < 0)
>   		goto out;
>
> -	trans =3D btrfs_start_transaction(gfs_info->extent_root, 1);
> +	trans =3D btrfs_start_transaction(gfs_info->tree_root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out;
> @@ -7736,7 +7741,7 @@ static int fixup_extent_refs(struct cache_tree *ex=
tent_cache,
>   	}
>   out:
>   	if (trans) {
> -		int err =3D btrfs_commit_transaction(trans, gfs_info->extent_root);
> +		int err =3D btrfs_commit_transaction(trans, gfs_info->tree_root);
>
>   		if (!ret)
>   			ret =3D err;
> @@ -7753,7 +7758,7 @@ out:
>   static int fixup_extent_flags(struct extent_record *rec)
>   {
>   	struct btrfs_trans_handle *trans;
> -	struct btrfs_root *root =3D gfs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(gfs_info, rec->start);
>   	struct btrfs_path path;
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_key key;
> @@ -7822,6 +7827,7 @@ retry:
>   static int prune_one_block(struct btrfs_trans_handle *trans,
>   			   struct btrfs_corrupt_block *corrupt)
>   {
> +	struct btrfs_root *extent_root;
>   	int ret;
>   	struct btrfs_path path;
>   	struct extent_buffer *eb;
> @@ -7832,11 +7838,12 @@ static int prune_one_block(struct btrfs_trans_ha=
ndle *trans,
>
>   	btrfs_init_path(&path);
>   again:
> +	extent_root =3D btrfs_extent_root(gfs_info, corrupt->key.objectid);
>   	/* we want to stop at the parent to our busted block */
>   	path.lowest_level =3D level;
>
> -	ret =3D btrfs_search_slot(trans, gfs_info->extent_root,
> -				&corrupt->key, &path, -1, 1);
> +	ret =3D btrfs_search_slot(trans, extent_root, &corrupt->key, &path,
> +				-1, 1);
>
>   	if (ret < 0)
>   		goto out;
> @@ -7868,7 +7875,7 @@ again:
>   	 * We couldn't find the bad block.
>   	 * TODO: search all the nodes for pointers to this block
>   	 */
> -	if (eb =3D=3D gfs_info->extent_root->node) {
> +	if (eb =3D=3D extent_root->node) {
>   		ret =3D -ENOENT;
>   		goto out;
>   	} else {
> @@ -7879,7 +7886,7 @@ again:
>
>   del_ptr:
>   	printk("deleting pointer to block %llu\n", corrupt->cache.start);
> -	ret =3D btrfs_del_ptr(gfs_info->extent_root, &path, level, slot);
> +	ret =3D btrfs_del_ptr(extent_root, &path, level, slot);
>
>   out:
>   	btrfs_release_path(&path);
> @@ -7897,7 +7904,7 @@ static int prune_corrupt_blocks(void)
>   		if (!cache)
>   			break;
>   		if (!trans) {
> -			trans =3D btrfs_start_transaction(gfs_info->extent_root, 1);
> +			trans =3D btrfs_start_transaction(gfs_info->tree_root, 1);
>   			if (IS_ERR(trans))
>   				return PTR_ERR(trans);
>   		}
> @@ -7906,7 +7913,7 @@ static int prune_corrupt_blocks(void)
>   		remove_cache_extent(gfs_info->corrupt_blocks, cache);
>   	}
>   	if (trans)
> -		return btrfs_commit_transaction(trans, gfs_info->extent_root);
> +		return btrfs_commit_transaction(trans, gfs_info->tree_root);
>   	return 0;
>   }
>
> @@ -8011,7 +8018,8 @@ static int repair_extent_item_generation(struct ex=
tent_record *rec)
>   	struct btrfs_path path;
>   	struct btrfs_key key;
>   	struct btrfs_extent_item *ei;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info,
> +							   rec->start);
>   	u64 new_gen =3D 0;;
>   	int ret;
>
> @@ -8258,7 +8266,6 @@ repair_abort:
>   		} else if (!ret) {
>   			struct btrfs_trans_handle *trans;
>
> -			root =3D gfs_info->extent_root;
>   			trans =3D btrfs_start_transaction(root, 1);
>   			if (IS_ERR(trans)) {
>   				ret =3D PTR_ERR(trans);
> @@ -8714,7 +8721,7 @@ static int check_block_groups(struct block_group_t=
ree *bg_cache)
>   	if (!repair || !ret)
>   		return ret;
>
> -	trans =3D btrfs_start_transaction(gfs_info->extent_root, 1);
> +	trans =3D btrfs_start_transaction(gfs_info->tree_root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		fprintf(stderr, "Failed to start a transaction\n");
> @@ -8722,7 +8729,7 @@ static int check_block_groups(struct block_group_t=
ree *bg_cache)
>   	}
>
>   	ret =3D btrfs_fix_block_accounting(trans);
> -	btrfs_commit_transaction(trans, gfs_info->extent_root);
> +	btrfs_commit_transaction(trans, gfs_info->tree_root);
>   	return ret ? ret : -EAGAIN;
>   }
>
> @@ -9368,7 +9375,7 @@ again:
>   	}
>
>   	/* Ok we can allocate now, reinit the extent root */
> -	ret =3D btrfs_fsck_reinit_root(trans, gfs_info->extent_root);
> +	ret =3D btrfs_fsck_reinit_root(trans, btrfs_extent_root(gfs_info, 0));
>   	if (ret) {
>   		fprintf(stderr, "extent root initialization failed\n");
>   		/*
> @@ -9387,6 +9394,7 @@ again:
>   	while (1) {
>   		struct btrfs_block_group_item bgi;
>   		struct btrfs_block_group *cache;
> +		struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info, 0);
>   		struct btrfs_key key;
>
>   		cache =3D btrfs_lookup_first_block_group(gfs_info, start);
> @@ -9400,8 +9408,8 @@ again:
>   		key.objectid =3D cache->start;
>   		key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>   		key.offset =3D cache->length;
> -		ret =3D btrfs_insert_item(trans, gfs_info->extent_root, &key,
> -					&bgi, sizeof(bgi));
> +		ret =3D btrfs_insert_item(trans, extent_root, &key, &bgi,
> +					sizeof(bgi));
>   		if (ret) {
>   			fprintf(stderr, "Error adding block group\n");
>   			return ret;
> @@ -9618,7 +9626,7 @@ out:
>
>   static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans=
)
>   {
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info, 0);
>   	struct btrfs_root *csum_root;
>   	struct btrfs_path path;
>   	struct btrfs_extent_item *ei;
> @@ -9721,6 +9729,7 @@ static void free_roots_info_cache(void)
>
>   static int build_roots_info_cache(void)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info, 0);
>   	int ret =3D 0;
>   	struct btrfs_key key;
>   	struct extent_buffer *leaf;
> @@ -9737,7 +9746,7 @@ static int build_roots_info_cache(void)
>   	key.objectid =3D 0;
>   	key.type =3D BTRFS_EXTENT_ITEM_KEY;
>   	key.offset =3D 0;
> -	ret =3D btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path, 0,=
 0);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   	if (ret < 0)
>   		goto out;
>   	leaf =3D path.nodes[0];
> @@ -9757,7 +9766,7 @@ static int build_roots_info_cache(void)
>
>   		ctx.item_count++;
>   		if (slot >=3D btrfs_header_nritems(leaf)) {
> -			ret =3D btrfs_next_leaf(gfs_info->extent_root, &path);
> +			ret =3D btrfs_next_leaf(extent_root, &path);
>   			if (ret < 0) {
>   				break;
>   			} else if (ret) {
> @@ -10670,7 +10679,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>   	if (init_extent_tree || init_csum_tree) {
>   		struct btrfs_trans_handle *trans;
>
> -		trans =3D btrfs_start_transaction(gfs_info->extent_root, 0);
> +		trans =3D btrfs_start_transaction(gfs_info->tree_root, 0);
>   		if (IS_ERR(trans)) {
>   			error("error starting transaction");
>   			ret =3D PTR_ERR(trans);
> @@ -10711,12 +10720,13 @@ static int cmd_check(const struct cmd_struct *=
cmd, int argc, char **argv)
>   		 * Ok now we commit and run the normal fsck, which will add
>   		 * extent entries for all of the items it finds.
>   		 */
> -		ret =3D btrfs_commit_transaction(trans, gfs_info->extent_root);
> +		ret =3D btrfs_commit_transaction(trans, gfs_info->tree_root);
>   		err |=3D !!ret;
>   		if (ret)
>   			goto close_out;
>   	}
> -	if (!extent_buffer_uptodate(gfs_info->extent_root->node)) {
> +	root =3D btrfs_extent_root(gfs_info, 0);
> +	if (!extent_buffer_uptodate(root->node)) {
>   		error("critical: extent_root, unable to check the filesystem");
>   		ret =3D -EIO;
>   		err |=3D !!ret;
> diff --git a/check/mode-common.c b/check/mode-common.c
> index 56377840..72fec47c 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -176,6 +176,8 @@ static int check_prealloc_shared_data_ref(u64 parent=
, u64 disk_bytenr)
>    */
>   int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info,
> +							   disk_bytenr);
>   	struct btrfs_path path;
>   	struct btrfs_key key;
>   	int ret;
> @@ -189,7 +191,7 @@ int check_prealloc_extent_written(u64 disk_bytenr, u=
64 num_bytes)
>   	key.offset =3D num_bytes;
>
>   	btrfs_init_path(&path);
> -	ret =3D btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path, 0,=
 0);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   	if (ret > 0) {
>   		fprintf(stderr,
>   	"Missing extent item in extent tree for disk_bytenr %llu, num_bytes %=
llu\n",
> @@ -240,7 +242,7 @@ int check_prealloc_extent_written(u64 disk_bytenr, u=
64 num_bytes)
>   	path.slots[0]++;
>   	while (true) {
>   		if (path.slots[0] >=3D btrfs_header_nritems(path.nodes[0])) {
> -			ret =3D btrfs_next_leaf(gfs_info->extent_root, &path);
> +			ret =3D btrfs_next_leaf(extent_root, &path);
>   			if (ret < 0)
>   				goto out;
>   			if (ret > 0) {
> @@ -1083,7 +1085,7 @@ int recow_extent_buffer(struct btrfs_root *root, s=
truct extent_buffer *eb)
>    */
>   int get_extent_item_generation(u64 bytenr, u64 *gen_ret)
>   {
> -	struct btrfs_root *root =3D gfs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(gfs_info, bytenr);
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_path path;
>   	struct btrfs_key key;
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 696ad215..cc6773cd 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -33,7 +33,7 @@ static u64 total_used =3D 0;
>   static int calc_extent_flag(struct btrfs_root *root, struct extent_buf=
fer *eb,
>   			    u64 *flags_ret)
>   {
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_root_item *ri =3D &root->root_item;
>   	struct btrfs_extent_inline_ref *iref;
>   	struct btrfs_extent_item *ei;
> @@ -73,6 +73,7 @@ static int calc_extent_flag(struct btrfs_root *root, s=
truct extent_buffer *eb,
>   	key.type =3D (u8)-1;
>   	key.offset =3D (u64)-1;
>
> +	extent_root =3D btrfs_extent_root(gfs_info, key.objectid);
>   	ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>   	if (ret <=3D 0) {
>   		ret =3D -EIO;
> @@ -265,7 +266,7 @@ static int modify_block_group_cache(struct btrfs_blo=
ck_group *block_group, int c
>    */
>   static int modify_block_groups_cache(u64 flags, int cache)
>   {
> -	struct btrfs_root *root =3D gfs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(gfs_info, 0);
>   	struct btrfs_key key;
>   	struct btrfs_path path;
>   	struct btrfs_block_group *bg_cache;
> @@ -330,7 +331,7 @@ static int clear_block_groups_full(u64 flags)
>   static int create_chunk_and_block_group(u64 flags, u64 *start, u64 *nb=
ytes)
>   {
>   	struct btrfs_trans_handle *trans;
> -	struct btrfs_root *root =3D gfs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(gfs_info, 0);
>   	int ret;
>
>   	if ((flags & BTRFS_BLOCK_GROUP_TYPE_MASK) =3D=3D 0)
> @@ -418,7 +419,7 @@ static int is_chunk_almost_full(u64 start)
>   {
>   	struct btrfs_path path;
>   	struct btrfs_key key;
> -	struct btrfs_root *root =3D gfs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(gfs_info, 0);
>   	struct btrfs_block_group_item *bi;
>   	struct btrfs_block_group_item bg_item;
>   	struct extent_buffer *eb;
> @@ -594,10 +595,9 @@ out:
>   static int repair_block_accounting(void)
>   {
>   	struct btrfs_trans_handle *trans =3D NULL;
> -	struct btrfs_root *root =3D gfs_info->extent_root;
>   	int ret;
>
> -	trans =3D btrfs_start_transaction(root, 1);
> +	trans =3D btrfs_start_transaction(gfs_info->tree_root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		errno =3D -ret;
> @@ -606,7 +606,7 @@ static int repair_block_accounting(void)
>   	}
>
>   	ret =3D btrfs_fix_block_accounting(trans);
> -	btrfs_commit_transaction(trans, root);
> +	btrfs_commit_transaction(trans, gfs_info->tree_root);
>   	return ret;
>   }
>
> @@ -622,7 +622,7 @@ static int repair_tree_block_ref(struct btrfs_root *=
root,
>   				 struct node_refs *nrefs, int level, int err)
>   {
>   	struct btrfs_trans_handle *trans =3D NULL;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_path path;
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_tree_block_info *bi;
> @@ -656,6 +656,7 @@ static int repair_tree_block_ref(struct btrfs_root *=
root,
>   	key.offset =3D (u64)-1;
>
>   	/* Search for the extent item */
> +	extent_root =3D btrfs_extent_root(gfs_info, bytenr);
>   	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   	if (ret <=3D 0) {
>   		ret =3D -EIO;
> @@ -3001,7 +3002,7 @@ static int check_tree_block_ref(struct btrfs_root =
*root,
>   				int level, u64 owner, struct node_refs *nrefs)
>   {
>   	struct btrfs_key key;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_path path;
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_extent_inline_ref *iref;
> @@ -3030,6 +3031,7 @@ static int check_tree_block_ref(struct btrfs_root =
*root,
>   	key.offset =3D (u64)-1;
>
>   	/* Search for the backref in extent tree */
> +	extent_root =3D btrfs_extent_root(gfs_info, bytenr);
>   	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   	if (ret < 0) {
>   		err |=3D BACKREF_MISSING;
> @@ -3222,7 +3224,7 @@ static int repair_extent_data_item(struct btrfs_ro=
ot *root,
>   	struct btrfs_key key;
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_path path;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct extent_buffer *eb;
>   	u64 size;
>   	u64 disk_bytenr;
> @@ -3274,6 +3276,7 @@ static int repair_extent_data_item(struct btrfs_ro=
ot *root,
>   	key.offset =3D num_bytes;
>
>   	btrfs_init_path(&path);
> +	extent_root =3D btrfs_extent_root(gfs_info, key.objectid);
>   	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   	if (ret < 0) {
>   		ret =3D -EIO;
> @@ -3356,7 +3359,7 @@ static int check_extent_data_item(struct btrfs_roo=
t *root,
>   	struct btrfs_file_extent_item *fi;
>   	struct extent_buffer *eb =3D pathp->nodes[0];
>   	struct btrfs_path path;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_key fi_key;
>   	struct btrfs_key dbref_key;
>   	struct extent_buffer *leaf;
> @@ -3426,6 +3429,7 @@ static int check_extent_data_item(struct btrfs_roo=
t *root,
>   	dbref_key.type =3D BTRFS_EXTENT_ITEM_KEY;
>   	dbref_key.offset =3D btrfs_file_extent_disk_num_bytes(eb, fi);
>
> +	extent_root =3D btrfs_extent_root(gfs_info, dbref_key.objectid);
>   	ret =3D btrfs_search_slot(NULL, extent_root, &dbref_key, &path, 0, 0)=
;
>   	if (ret)
>   		goto out;
> @@ -3499,8 +3503,9 @@ static int check_extent_data_item(struct btrfs_roo=
t *root,
>   		dbref_key.offset =3D hash_extent_data_ref(owner, fi_key.objectid,
>   							fi_key.offset - offset);
>
> -		ret =3D btrfs_search_slot(NULL, gfs_info->extent_root,
> -					&dbref_key, &path, 0, 0);
> +		extent_root =3D btrfs_extent_root(gfs_info, dbref_key.objectid);
> +		ret =3D btrfs_search_slot(NULL, extent_root, &dbref_key, &path, 0,
> +					0);
>   		if (!ret) {
>   			found_dbackref =3D 1;
>   			goto out;
> @@ -3516,8 +3521,8 @@ static int check_extent_data_item(struct btrfs_roo=
t *root,
>   		dbref_key.type =3D BTRFS_SHARED_DATA_REF_KEY;
>   		dbref_key.offset =3D eb->start;
>
> -		ret =3D btrfs_search_slot(NULL, gfs_info->extent_root,
> -					&dbref_key, &path, 0, 0);
> +		ret =3D btrfs_search_slot(NULL, extent_root, &dbref_key, &path, 0,
> +					0);
>   		if (!ret) {
>   			found_dbackref =3D 1;
>   			goto out;
> @@ -3542,7 +3547,7 @@ out:
>    */
>   static int check_block_group_item(struct extent_buffer *eb, int slot)
>   {
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_root *chunk_root =3D gfs_info->chunk_root;
>   	struct btrfs_block_group_item *bi;
>   	struct btrfs_block_group_item bg_item;
> @@ -3598,6 +3603,7 @@ static int check_block_group_item(struct extent_bu=
ffer *eb, int slot)
>   	extent_key.offset =3D 0;
>
>   	btrfs_init_path(&path);
> +	extent_root =3D btrfs_extent_root(gfs_info, extent_key.objectid);
>   	ret =3D btrfs_search_slot(NULL, extent_root, &extent_key, &path, 0, 0=
);
>   	if (ret < 0)
>   		goto out;
> @@ -3673,6 +3679,7 @@ out:
>    */
>   static int query_tree_block_level(u64 bytenr)
>   {
> +	struct btrfs_root *extent_root;
>   	struct extent_buffer *eb;
>   	struct btrfs_path path;
>   	struct btrfs_key key;
> @@ -3689,10 +3696,12 @@ static int query_tree_block_level(u64 bytenr)
>   	key.offset =3D (u64)-1;
>
>   	btrfs_init_path(&path);
> -	ret =3D btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path, 0,=
 0);
> +
> +	extent_root =3D btrfs_extent_root(gfs_info, bytenr);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   	if (ret < 0)
>   		goto release_out;
> -	ret =3D btrfs_previous_extent_item(gfs_info->extent_root, &path, byten=
r);
> +	ret =3D btrfs_previous_extent_item(extent_root, &path, bytenr);
>   	if (ret < 0)
>   		goto release_out;
>   	if (ret > 0) {
> @@ -3920,7 +3929,7 @@ static int check_extent_data_backref(u64 root_id, =
u64 objectid, u64 offset,
>   				     u64 bytenr, u64 len, u32 count)
>   {
>   	struct btrfs_root *root;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_key key;
>   	struct btrfs_path path;
>   	struct extent_buffer *leaf;
> @@ -3935,6 +3944,7 @@ static int check_extent_data_backref(u64 root_id, =
u64 objectid, u64 offset,
>   		key.offset =3D (u64)-1;
>
>   		btrfs_init_path(&path);
> +		extent_root =3D btrfs_extent_root(gfs_info, bytenr);
>   		ret =3D btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
>   		if (ret < 0)
>   			goto out;
> @@ -4084,13 +4094,13 @@ out:
>    * Returns >0   the backref was deleted but extent still exists
>    * Returns =3D0   the whole extent item was deleted
>    */
> -static int repair_extent_item(struct btrfs_root *root, struct btrfs_pat=
h *path,
> -		      u64 bytenr, u64 num_bytes, u64 parent, u64 root_objectid,
> -		      u64 owner, u64 offset)
> +static int repair_extent_item(struct btrfs_path *path, u64 bytenr, u64
> +			      num_bytes, u64 parent, u64 root_objectid, u64
> +			      owner, u64 offset)
>   {
>   	struct btrfs_trans_handle *trans;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
>   	struct btrfs_key old_key;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(gfs_info, bytenr)=
;
>   	int ret;
>
>   	btrfs_item_key_to_cpu(path->nodes[0], &old_key, path->slots[0]);
> @@ -4121,7 +4131,7 @@ static int repair_extent_item(struct btrfs_root *r=
oot, struct btrfs_path *path,
>   	btrfs_commit_transaction(trans, extent_root);
>
>   	btrfs_release_path(path);
> -	ret =3D btrfs_search_slot(NULL, root, &old_key, path, 0, 0);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &old_key, path, 0, 0);
>   	if (ret > 0) {
>   		/* odd, there must be one block group before at least */
>   		if (path->slots[0] =3D=3D 0) {
> @@ -4159,7 +4169,7 @@ static int repair_extent_item_generation(struct bt=
rfs_path *path)
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_key key;
>   	struct btrfs_extent_item *ei;
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	u64 new_gen =3D 0;;
>   	int ret;
>
> @@ -4172,6 +4182,7 @@ static int repair_extent_item_generation(struct bt=
rfs_path *path)
>   	if (ret)
>   		return ret;
>   	btrfs_release_path(path);
> +	extent_root =3D btrfs_extent_root(gfs_info, key.objectid);
>   	trans =3D btrfs_start_transaction(extent_root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
> @@ -4349,9 +4360,8 @@ next:
>
>   	if ((tmp_err & (REFERENCER_MISSING | REFERENCER_MISMATCH))
>   	    && repair) {
> -		ret =3D repair_extent_item(gfs_info->extent_root, path,
> -			 key.objectid, num_bytes, parent, root_objectid,
> -			 owner, owner_offset);
> +		ret =3D repair_extent_item(path, key.objectid, num_bytes, parent,
> +					 root_objectid, owner, owner_offset);
>   		if (ret < 0) {
>   			err |=3D tmp_err;
>   			err |=3D FATAL_ERROR;
> @@ -4581,6 +4591,7 @@ next:
>   static int find_block_group_item(struct btrfs_path *path, u64 bytenr, =
u64 len,
>   				 u64 type)
>   {
> +	struct btrfs_root *root =3D btrfs_extent_root(gfs_info, 0);
>   	struct btrfs_block_group_item bgi;
>   	struct btrfs_key key;
>   	int ret;
> @@ -4589,7 +4600,7 @@ static int find_block_group_item(struct btrfs_path=
 *path, u64 bytenr, u64 len,
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	key.offset =3D len;
>
> -	ret =3D btrfs_search_slot(NULL, gfs_info->extent_root, &key, path, 0, =
0);
> +	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>   	if (ret < 0)
>   		return ret;
>   	if (ret > 0) {
> @@ -4705,7 +4716,7 @@ static int repair_chunk_item(struct btrfs_root *ch=
unk_root,
>   	struct btrfs_chunk *chunk;
>   	struct btrfs_key chunk_key;
>   	struct extent_buffer *eb =3D path->nodes[0];
> -	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_trans_handle *trans;
>   	u64 length;
>   	int slot =3D path->slots[0];
> @@ -4715,6 +4726,7 @@ static int repair_chunk_item(struct btrfs_root *ch=
unk_root,
>   	btrfs_item_key_to_cpu(eb, &chunk_key, slot);
>   	if (chunk_key.type !=3D BTRFS_CHUNK_ITEM_KEY)
>   		return err;
> +	extent_root =3D btrfs_extent_root(gfs_info, chunk_key.offset);
>   	chunk =3D btrfs_item_ptr(eb, slot, struct btrfs_chunk);
>   	type =3D btrfs_chunk_type(path->nodes[0], chunk);
>   	length =3D btrfs_chunk_length(eb, chunk);
> diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
> index a514fee1..0813b841 100644
> --- a/check/qgroup-verify.c
> +++ b/check/qgroup-verify.c
> @@ -1157,7 +1157,7 @@ static int scan_extents(struct btrfs_fs_info *info=
,
>   			u64 start, u64 end)
>   {
>   	int ret, i, nr, level;
> -	struct btrfs_root *root =3D info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(info, start);
>   	struct btrfs_key key;
>   	struct btrfs_path path;
>   	struct btrfs_disk_key disk_key;
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 115d91d7..3bf9c36c 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -555,6 +555,7 @@ static int check_chunk_by_metadata(struct recover_co=
ntrol *rc,
>   				   struct btrfs_root *root,
>   				   struct chunk_record *chunk, int bg_only)
>   {
> +	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	int ret;
>   	int i;
>   	int slot;
> @@ -616,7 +617,8 @@ bg_check:
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	key.offset =3D chunk->length;
>
> -	ret =3D btrfs_search_slot(NULL, root->fs_info->extent_root, &key, &pat=
h,
> +	root =3D btrfs_extent_root(fs_info, key.objectid);
> +	ret =3D btrfs_search_slot(NULL, root, &key, &path,
>   				0, 0);
>   	if (ret < 0) {
>   		fprintf(stderr, "Search block group failed(%d)\n", ret);
> @@ -997,7 +999,7 @@ static int block_group_remove_all_extent_items(struc=
t btrfs_trans_handle *trans,
>   	int del_s, del_nr;
>
>   	btrfs_init_path(&path);
> -	root =3D root->fs_info->extent_root;
> +	root =3D btrfs_extent_root(fs_info, start);
>
>   	key.objectid =3D start;
>   	key.offset =3D 0;
> @@ -1382,6 +1384,7 @@ static int rebuild_block_group(struct btrfs_trans_=
handle *trans,
>   			       struct recover_control *rc,
>   			       struct btrfs_root *root)
>   {
> +	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct chunk_record *chunk_rec;
>   	struct btrfs_key search_key;
>   	struct btrfs_path path;
> @@ -1396,12 +1399,11 @@ static int rebuild_block_group(struct btrfs_tran=
s_handle *trans,
>   		search_key.objectid =3D chunk_rec->offset;
>   		search_key.type =3D BTRFS_EXTENT_ITEM_KEY;
>   		search_key.offset =3D 0;
> -		ret =3D btrfs_search_slot(NULL, root->fs_info->extent_root,
> -					&search_key, &path, 0, 0);
> +		root =3D btrfs_extent_root(fs_info, chunk_rec->offset);
> +		ret =3D btrfs_search_slot(NULL, root, &search_key, &path, 0, 0);
>   		if (ret < 0)
>   			goto out;
> -		ret =3D calculate_bg_used(root->fs_info->extent_root,
> -					chunk_rec, &path, &used);
> +		ret =3D calculate_bg_used(root, chunk_rec, &path, &used);
>   		/*
>   		 * Extent tree is damaged, better to rebuild the whole extent
>   		 * tree. Currently, change the used to chunk's len to prevent
> @@ -1417,9 +1419,7 @@ static int rebuild_block_group(struct btrfs_trans_=
handle *trans,
>   			used =3D chunk_rec->length;
>   		}
>   		btrfs_release_path(&path);
> -		ret =3D __insert_block_group(trans, chunk_rec,
> -					   root->fs_info->extent_root,
> -					   used);
> +		ret =3D __insert_block_group(trans, chunk_rec, root, used);
>   		if (ret < 0)
>   			goto out;
>   	}
> diff --git a/common/repair.c b/common/repair.c
> index 413c3e86..c8624eaa 100644
> --- a/common/repair.c
> +++ b/common/repair.c
> @@ -168,7 +168,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_ha=
ndle *trans)
>   	struct extent_buffer *leaf;
>   	struct btrfs_block_group *cache;
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(fs_info, 0);
>
>   	ret =3D btrfs_run_delayed_refs(trans, -1);
>   	if (ret)
> @@ -190,8 +190,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_ha=
ndle *trans)
>   	key.offset =3D 0;
>   	key.objectid =3D 0;
>   	key.type =3D BTRFS_EXTENT_ITEM_KEY;
> -	ret =3D btrfs_search_slot(trans, root->fs_info->extent_root,
> -				&key, &path, 0, 0);
> +	ret =3D btrfs_search_slot(trans, root, &key, &path, 0, 0);
>   	if (ret < 0)
>   		return ret;
>   	while(1) {
> diff --git a/convert/main.c b/convert/main.c
> index 7f33d4e1..0fae4e98 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -944,7 +944,6 @@ static int make_convert_data_block_groups(struct btr=
fs_trans_handle *trans,
>   					  struct btrfs_mkfs_config *cfg,
>   					  struct btrfs_convert_context *cctx)
>   {
> -	struct btrfs_root *extent_root =3D fs_info->extent_root;
>   	struct cache_tree *data_chunks =3D &cctx->data_chunks;
>   	struct cache_extent *cache;
>   	u64 max_chunk_size;
> @@ -956,8 +955,7 @@ static int make_convert_data_block_groups(struct btr=
fs_trans_handle *trans,
>   	 */
>   	max_chunk_size =3D cfg->num_bytes / 10;
>   	max_chunk_size =3D min((u64)(SZ_1G), max_chunk_size);
> -	max_chunk_size =3D round_down(max_chunk_size,
> -				    extent_root->fs_info->sectorsize);
> +	max_chunk_size =3D round_down(max_chunk_size, fs_info->sectorsize);
>
>   	for (cache =3D first_cache_extent(data_chunks); cache;
>   	     cache =3D next_cache_extent(cache)) {
> diff --git a/image/main.c b/image/main.c
> index 57e0cb6c..ab57ce4e 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -922,7 +922,7 @@ static int copy_from_extent_tree(struct metadump_str=
uct *metadump,
>   	u64 num_bytes;
>   	int ret;
>
> -	extent_root =3D metadump->root->fs_info->extent_root;
> +	extent_root =3D btrfs_extent_root(metadump->root->fs_info, 0);
>   	bytenr =3D BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
>   	key.objectid =3D bytenr;
>   	key.type =3D BTRFS_EXTENT_ITEM_KEY;
> diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
> index c04d505e..42832c48 100644
> --- a/kernel-shared/backref.c
> +++ b/kernel-shared/backref.c
> @@ -645,7 +645,7 @@ static int __add_keyed_refs(struct btrfs_fs_info *fs=
_info,
>   			    struct btrfs_path *path, u64 bytenr,
>   			    int info_level)
>   {
> -	struct btrfs_root *extent_root =3D fs_info->extent_root;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, bytenr);
>   	int ret;
>   	int slot;
>   	struct extent_buffer *leaf;
> @@ -734,6 +734,7 @@ static int find_parent_nodes(struct btrfs_trans_hand=
le *trans,
>   			     u64 time_seq, struct ulist *refs,
>   			     struct ulist *roots, const u64 *extent_item_pos)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, bytenr);
>   	struct btrfs_key key;
>   	struct btrfs_path *path;
>   	int info_level =3D 0;
> @@ -756,7 +757,7 @@ static int find_parent_nodes(struct btrfs_trans_hand=
le *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	ret =3D btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, =
0);
> +	ret =3D btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		goto out;
>   	BUG_ON(ret =3D=3D 0);
> @@ -1136,6 +1137,7 @@ int extent_from_logical(struct btrfs_fs_info *fs_i=
nfo, u64 logical,
>   			struct btrfs_path *path, struct btrfs_key *found_key,
>   			u64 *flags_ret)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, logical)=
;
>   	int ret;
>   	u64 flags;
>   	u64 size =3D 0;
> @@ -1151,11 +1153,11 @@ int extent_from_logical(struct btrfs_fs_info *fs=
_info, u64 logical,
>   	key.objectid =3D logical;
>   	key.offset =3D (u64)-1;
>
> -	ret =3D btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0=
);
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		return ret;
>
> -	ret =3D btrfs_previous_extent_item(fs_info->extent_root, path, 0);
> +	ret =3D btrfs_previous_extent_item(extent_root, path, 0);
>   	if (ret) {
>   		if (ret > 0)
>   			ret =3D -ENOENT;
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index d2d1a006..23750156 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1157,7 +1157,7 @@ struct btrfs_fs_info {
>   	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>   	u8 *new_chunk_tree_uuid;
>   	struct btrfs_root *fs_root;
> -	struct btrfs_root *extent_root;
> +	struct btrfs_root *_extent_root;
>   	struct btrfs_root *tree_root;
>   	struct btrfs_root *chunk_root;
>   	struct btrfs_root *dev_root;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index c1d55692..b4c45719 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -750,6 +750,12 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_=
info *fs_info,
>   	return fs_info->_csum_root;
>   }
>
> +struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
> +				     u64 bytenr)
> +{
> +	return fs_info->_extent_root;
> +}
> +
>   struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
>   				      struct btrfs_key *location)
>   {
> @@ -761,7 +767,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_f=
s_info *fs_info,
>   	if (location->objectid =3D=3D BTRFS_ROOT_TREE_OBJECTID)
>   		return fs_info->tree_root;
>   	if (location->objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID)
> -		return fs_info->extent_root;
> +		return fs_info->_extent_root;
>   	if (location->objectid =3D=3D BTRFS_CHUNK_TREE_OBJECTID)
>   		return fs_info->chunk_root;
>   	if (location->objectid =3D=3D BTRFS_DEV_TREE_OBJECTID)
> @@ -800,7 +806,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_inf=
o)
>   		free(fs_info->quota_root);
>
>   	free(fs_info->tree_root);
> -	free(fs_info->extent_root);
> +	free(fs_info->_extent_root);
>   	free(fs_info->chunk_root);
>   	free(fs_info->dev_root);
>   	free(fs_info->_csum_root);
> @@ -820,7 +826,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable=
, u64 sb_bytenr)
>   		return NULL;
>
>   	fs_info->tree_root =3D calloc(1, sizeof(struct btrfs_root));
> -	fs_info->extent_root =3D calloc(1, sizeof(struct btrfs_root));
> +	fs_info->_extent_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->chunk_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->dev_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->_csum_root =3D calloc(1, sizeof(struct btrfs_root));
> @@ -829,7 +835,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable=
, u64 sb_bytenr)
>   	fs_info->uuid_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->super_copy =3D calloc(1, BTRFS_SUPER_INFO_SIZE);
>
> -	if (!fs_info->tree_root || !fs_info->extent_root ||
> +	if (!fs_info->tree_root || !fs_info->_extent_root ||
>   	    !fs_info->chunk_root || !fs_info->dev_root ||
>   	    !fs_info->_csum_root || !fs_info->quota_root ||
>   	    !fs_info->free_space_root || !fs_info->uuid_root ||
> @@ -985,11 +991,11 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs=
_info, u64 root_tree_bytenr,
>   		return -EIO;
>   	}
>
> -	ret =3D setup_root_or_create_block(fs_info, flags, fs_info->extent_roo=
t,
> +	ret =3D setup_root_or_create_block(fs_info, flags, fs_info->_extent_ro=
ot,
>   					 BTRFS_EXTENT_TREE_OBJECTID, "extent");
>   	if (ret)
>   		return ret;
> -	fs_info->extent_root->track_dirty =3D 1;
> +	fs_info->_extent_root->track_dirty =3D 1;
>
>   	ret =3D find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
>   				  fs_info->dev_root);
> @@ -1047,7 +1053,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs=
_info, u64 root_tree_bytenr,
>
>   	fs_info->generation =3D generation;
>   	fs_info->last_trans_committed =3D generation;
> -	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
> +	if (extent_buffer_uptodate(fs_info->_extent_root->node) &&
>   	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
>   		ret =3D btrfs_read_block_groups(fs_info);
>   		/*
> @@ -1082,8 +1088,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info =
*fs_info)
>   		free_extent_buffer(fs_info->_csum_root->node);
>   	if (fs_info->dev_root)
>   		free_extent_buffer(fs_info->dev_root->node);
> -	if (fs_info->extent_root)
> -		free_extent_buffer(fs_info->extent_root->node);
> +	if (fs_info->_extent_root)
> +		free_extent_buffer(fs_info->_extent_root->node);
>   	if (fs_info->tree_root)
>   		free_extent_buffer(fs_info->tree_root->node);
>   	if (fs_info->log_root_tree)
> @@ -1836,11 +1842,11 @@ static void backup_super_roots(struct btrfs_fs_i=
nfo *info)
>   	btrfs_set_backup_chunk_root_level(root_backup,
>   			       btrfs_header_level(info->chunk_root->node));
>
> -	btrfs_set_backup_extent_root(root_backup, info->extent_root->node->sta=
rt);
> +	btrfs_set_backup_extent_root(root_backup, info->_extent_root->node->st=
art);
>   	btrfs_set_backup_extent_root_gen(root_backup,
> -			       btrfs_header_generation(info->extent_root->node));
> +			       btrfs_header_generation(info->_extent_root->node));
>   	btrfs_set_backup_extent_root_level(root_backup,
> -			       btrfs_header_level(info->extent_root->node));
> +			       btrfs_header_level(info->_extent_root->node));
>   	/*
>   	 * we might commit during log recovery, which happens before we set
>   	 * the fs_root.  Make sure it is valid before we fill it in.
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index 38abbca5..dc71cc2b 100644
> --- a/kernel-shared/disk-io.h
> +++ b/kernel-shared/disk-io.h
> @@ -218,4 +218,5 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_tr=
ans_handle *trans,
>   				     struct btrfs_fs_info *fs_info,
>   				     u64 objectid);
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 =
bytenr);
> +struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 =
bytenr);
>   #endif
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 402904d1..3713452b 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -96,7 +96,7 @@ static int cache_block_group(struct btrfs_root *root,
>   	if (!block_group)
>   		return 0;
>
> -	root =3D root->fs_info->extent_root;
> +	root =3D btrfs_extent_root(root->fs_info, 0);
>   	free_space_cache =3D &root->fs_info->free_space_cache;
>
>   	if (block_group->cached)
> @@ -1243,6 +1243,8 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle=
 *trans,
>   			 u64 bytenr, u64 num_bytes, u64 parent,
>   			 u64 root_objectid, u64 owner, u64 offset)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(root->fs_info,
> +							   bytenr);
>   	struct btrfs_path *path;
>   	struct extent_buffer *leaf;
>   	struct btrfs_extent_item *item;
> @@ -1254,9 +1256,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle=
 *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	ret =3D insert_inline_extent_backref(trans, root->fs_info->extent_root=
,
> -					   path, bytenr, num_bytes, parent,
> -					   root_objectid, owner, offset, 1);
> +	ret =3D insert_inline_extent_backref(trans, extent_root, path, bytenr,
> +					   num_bytes, parent, root_objectid,
> +					   owner, offset, 1);
>   	if (ret =3D=3D 0)
>   		goto out;
>
> @@ -1274,9 +1276,8 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle=
 *trans,
>   	btrfs_release_path(path);
>
>   	/* now insert the actual backref */
> -	ret =3D insert_extent_backref(trans, root->fs_info->extent_root,
> -				    path, bytenr, parent, root_objectid,
> -				    owner, offset, 1);
> +	ret =3D insert_extent_backref(trans, extent_root, path, bytenr, parent=
,
> +				    root_objectid, owner, offset, 1);
>   	if (ret)
>   		err =3D ret;
>   out:
> @@ -1289,6 +1290,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_ha=
ndle *trans,
>   			     struct btrfs_fs_info *fs_info, u64 bytenr,
>   			     u64 offset, int metadata, u64 *refs, u64 *flags)
>   {
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, bytenr);
>   	struct btrfs_path *path;
>   	int ret;
>   	struct btrfs_key key;
> @@ -1315,7 +1317,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_ha=
ndle *trans,
>   		key.type =3D BTRFS_EXTENT_ITEM_KEY;
>
>   again:
> -	ret =3D btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, =
0);
> +	ret =3D btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		goto out;
>
> @@ -1374,6 +1376,7 @@ int btrfs_set_block_flags(struct btrfs_trans_handl=
e *trans, u64 bytenr,
>   			  int level, u64 flags)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, bytenr);
>   	struct btrfs_path *path;
>   	int ret;
>   	struct btrfs_key key;
> @@ -1396,7 +1399,7 @@ int btrfs_set_block_flags(struct btrfs_trans_handl=
e *trans, u64 bytenr,
>   	}
>
>   again:
> -	ret =3D btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, =
0);
> +	ret =3D btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		goto out;
>
> @@ -1537,7 +1540,7 @@ static int update_block_group_item(struct btrfs_tr=
ans_handle *trans,
>   {
>   	int ret;
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(fs_info, 0);
>   	unsigned long bi;
>   	struct btrfs_block_group_item bgi;
>   	struct extent_buffer *leaf;
> @@ -1911,9 +1914,10 @@ static int __free_extent(struct btrfs_trans_handl=
e *trans,
>   			 u64 owner_offset, int refs_to_drop)
>   {
>
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(trans->fs_info,
> +							   bytenr);
>   	struct btrfs_key key;
>   	struct btrfs_path *path;
> -	struct btrfs_root *extent_root =3D trans->fs_info->extent_root;
>   	struct extent_buffer *leaf;
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_extent_inline_ref *iref;
> @@ -2181,7 +2185,7 @@ static int noinline find_free_extent(struct btrfs_=
trans_handle *trans,
>   {
>   	int ret;
>   	u64 orig_search_start =3D search_start;
> -	struct btrfs_root * root =3D orig_root->fs_info->extent_root;
> +	struct btrfs_root *root =3D orig_root->fs_info->tree_root;
>   	struct btrfs_fs_info *info =3D root->fs_info;
>   	u64 total_needed =3D num_bytes;
>   	struct btrfs_block_group *block_group;
> @@ -2363,6 +2367,8 @@ static int alloc_reserved_tree_block(struct btrfs_=
trans_handle *trans,
>   				      struct btrfs_delayed_extent_op *extent_op)
>   {
>
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(trans->fs_info,
> +							   node->bytenr);
>   	struct btrfs_delayed_tree_ref *ref =3D btrfs_delayed_node_to_tree_ref=
(node);
>   	bool skinny_metadata =3D btrfs_fs_incompat(trans->fs_info, SKINNY_MET=
ADATA);
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -2403,8 +2409,7 @@ static int alloc_reserved_tree_block(struct btrfs_=
trans_handle *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	ret =3D btrfs_insert_empty_item(trans, fs_info->extent_root, path,
> -				      &ins, size);
> +	ret =3D btrfs_insert_empty_item(trans, extent_root, path, &ins, size);
>   	if (ret)
>   		return ret;
>
> @@ -2726,7 +2731,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
fs_info)
>   	int ret;
>   	struct btrfs_key key;
>
> -	root =3D fs_info->extent_root;
> +	root =3D btrfs_extent_root(fs_info, 0);
>   	key.objectid =3D 0;
>   	key.offset =3D 0;
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> @@ -2807,7 +2812,7 @@ static int insert_block_group_item(struct btrfs_tr=
ans_handle *trans,
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	key.offset =3D block_group->length;
>
> -	root =3D fs_info->extent_root;
> +	root =3D btrfs_extent_root(fs_info, 0);
>   	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
>   }
>
> @@ -2924,7 +2929,7 @@ static int remove_block_group_item(struct btrfs_tr=
ans_handle *trans,
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_key key;
> -	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(fs_info, 0);
>   	int ret =3D 0;
>
>   	key.objectid =3D block_group->start;
> @@ -3247,7 +3252,6 @@ int btrfs_remove_block_group(struct btrfs_trans_ha=
ndle *trans,
>   	return ret;
>   }
>
> -
>   static void __get_extent_size(struct btrfs_root *root, struct btrfs_pa=
th *path,
>   			      u64 *start, u64 *len)
>   {
> @@ -3319,7 +3323,7 @@ static int __btrfs_record_file_extent(struct btrfs=
_trans_handle *trans,
>   {
>   	int ret;
>   	struct btrfs_fs_info *info =3D root->fs_info;
> -	struct btrfs_root *extent_root =3D info->extent_root;
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(info, disk_bytenr=
);
>   	struct extent_buffer *leaf;
>   	struct btrfs_file_extent_item *fi;
>   	struct btrfs_key ins_key;
> diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-=
tree.c
> index 83a8520d..0434733d 100644
> --- a/kernel-shared/free-space-tree.c
> +++ b/kernel-shared/free-space-tree.c
> @@ -1014,12 +1014,18 @@ out:
>   int populate_free_space_tree(struct btrfs_trans_handle *trans,
>   			     struct btrfs_block_group *block_group)
>   {
> -	struct btrfs_root *extent_root =3D trans->fs_info->extent_root;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *extent_root;
>   	struct btrfs_path *path, *path2;
>   	struct btrfs_key key;
>   	u64 start, end;
>   	int ret;
>
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +		return -EINVAL;
> +
> +	extent_root =3D btrfs_extent_root(fs_info, 0);
> +
>   	path =3D btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index 7d6fe8fd..4092c067 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -1348,7 +1348,6 @@ static int create_chunk(struct btrfs_trans_handle =
*trans,
>   			struct btrfs_fs_info *info, struct alloc_chunk_ctl *ctl,
>   			struct list_head *private_devs)
>   {
> -	struct btrfs_root *extent_root =3D info->extent_root;
>   	struct btrfs_root *chunk_root =3D info->chunk_root;
>   	struct btrfs_stripe *stripes;
>   	struct btrfs_device *device =3D NULL;
> @@ -1432,7 +1431,7 @@ static int create_chunk(struct btrfs_trans_handle =
*trans,
>
>   	/* key was set above */
>   	btrfs_set_stack_chunk_length(chunk, ctl->num_bytes);
> -	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
> +	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
>   	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
>   	btrfs_set_stack_chunk_type(chunk, ctl->type);
>   	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index 776576bc..0164fe9f 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -757,7 +757,7 @@ static int calculate_alloc_pointer(struct btrfs_fs_i=
nfo *fs_info,
>   				   struct btrfs_block_group *cache,
>   				   u64 *offset_ret)
>   {
> -	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(fs_info, cache->start);
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	struct btrfs_key found_key;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c6cc51e9..9647f12a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -277,7 +277,7 @@ static int recow_roots(struct btrfs_trans_handle *tr=
ans,
>   	ret =3D __recow_root(trans, info->tree_root);
>   	if (ret)
>   		return ret;
> -	ret =3D __recow_root(trans, info->extent_root);
> +	ret =3D __recow_root(trans, info->_extent_root);
>   	if (ret)
>   		return ret;
>   	ret =3D __recow_root(trans, info->chunk_root);
> @@ -588,7 +588,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info =
*fs_info,
>   {
>   	struct btrfs_trans_handle *trans =3D NULL;
>   	struct btrfs_block_group_item *bgi;
> -	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct btrfs_root *root =3D btrfs_extent_root(fs_info, 0);
>   	struct btrfs_key key;
>   	struct btrfs_key found_key;
>   	struct btrfs_path path;
>
