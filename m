Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FCDA4DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 06:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392372AbfJQE4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 00:56:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54422 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfJQE4Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:56:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H4sCrP050144;
        Thu, 17 Oct 2019 04:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=rw209Cd1C8Yk1Ill94sveuHbk3g++EhHIZIMwuzSma0=;
 b=FIwNnXCzL+6BH063Z1nKoz1X8qNiQA1UFqBK6TYi3jLnYoddS/ykGMtclxRAsJ7qhO/d
 3NuIfOqaC/UKHXVpKNvj0MkMzhYIlO2JUF8Kb4PhTwfKObleoDZEt8Mli8S85WHlUz/O
 FwLHBj0/oQBo0beRDH0S3waW4rK/VjaedBkk9PZGLAjJNsMz9cejS1MrcTG+nhJKDD5J
 hzvcRspjo4lolClg7Vv1IKRQ+5KLpCEBD4aW9ADc3AG1ZVy64ezPCk9h88f71aUn5Mfb
 +c1qH0tuYV2IeVktZmL051weDI8Ufd8qDX9aPHGE0LN+fCIztsp4ca4tDxwWHdmODZRT vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vk68uuk27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 04:56:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H4rJCH103742;
        Thu, 17 Oct 2019 04:56:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vp70p6u6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 04:56:18 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9H4uHIL023370;
        Thu, 17 Oct 2019 04:56:17 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 04:56:17 +0000
Subject: Re: [PATCH v2 3/7] btrfs-progs: Enable read-write ability for
 'bg_tree' feature
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-4-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8444fabf-c761-5dae-e056-a5e9a58b34d4@oracle.com>
Date:   Thu, 17 Oct 2019 12:56:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008044936.157873-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 12:49 PM, Qu Wenruo wrote:
> Allow btrfs-progs to open, read and write 'bg_tree' enabled fs.
> 
> The modification itself is not large, as block groups items are only
> used at 4 timing:
> 1) open_ctree()
>     We only need to populate fs_info->bg_root and read block group items
>     from fs_info->bg_root.
>     The obvious change is, we don't need to do btrfs_search_slot() for
>     each block group item, but btrfs_next_item() is enough.
> 
>     This should hugely reduce open_ctree() execution duration.
> 
> 2) btrfs_commit_transaction()
>     We need to write back dirty block group items back to bg_root.
> 
>     The modification here is to insert new block group item if we can't
>     find one existing in bg_root, and delete the old one in extent tree
>     if we're converting to bg_tree feature.
> 
> 3) btrfs_make_block_group()
>     Just change @root for btrfs_insert_item() from @extent_root to
>     @bg_root for fs with that feature.
> 
>     This modification needs extra handling for converting case, where
>     block group items can be either in extent tree or bg tree.
> 
> 4) free_block_group_item()
>     Just delete the block group item in extent tree.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

looks good.
two nit below.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   ctree.h       |  11 +++-
>   disk-io.c     |  20 +++++++
>   extent-tree.c | 152 +++++++++++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 168 insertions(+), 15 deletions(-)
> 
> diff --git a/ctree.h b/ctree.h
> index 2899de358613..c2a18c8ab72f 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -89,6 +89,9 @@ struct btrfs_free_space_ctl;
>   /* tracks free space in block groups. */
>   #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
>   
> +/* store BLOCK_GROUP_ITEMS in a seperate tree */
> +#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
> +
>   /* device stats in the device tree */
>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>   
> @@ -490,6 +493,7 @@ struct btrfs_super_block {
>   #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
>   #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
>   #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
> +#define BTRFS_FEATURE_INCOMPAT_BG_TREE		(1ULL << 11)
>   
>   #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
>   
> @@ -513,7 +517,8 @@ struct btrfs_super_block {
>   	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
>   	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
>   	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
> -	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
> +	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
> +	 BTRFS_FEATURE_INCOMPAT_BG_TREE)
>   
>   /*
>    * A leaf is full of items. offset and size tell us where to find
> @@ -1123,6 +1128,7 @@ struct btrfs_fs_info {
>   	struct btrfs_root *quota_root;
>   	struct btrfs_root *free_space_root;
>   	struct btrfs_root *uuid_root;
> +	struct btrfs_root *bg_root;
>   
>   	struct rb_root fs_root_tree;
>   
> @@ -1175,6 +1181,9 @@ struct btrfs_fs_info {
>   	unsigned int avoid_sys_chunk_alloc:1;
>   	unsigned int finalize_on_close:1;
>   
> +	/* Converting from bg in extent tree to bg tree */
> +	unsigned int convert_to_bg_tree:1;
> +

  This should probably be part of the patch 7/7.

>   	int transaction_aborted;
>   
>   	int (*free_extent_hook)(struct btrfs_fs_info *fs_info,
> diff --git a/disk-io.c b/disk-io.c
> index 8978f0cb60c7..38248aa895b8 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -716,6 +716,8 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
>   	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
>   		return fs_info->free_space_root ? fs_info->free_space_root :
>   						ERR_PTR(-ENOENT);
> +	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
> +		return fs_info->bg_root ? fs_info->bg_root : ERR_PTR(-ENOENT);
>   
>   	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID ||
>   	       location->offset != (u64)-1);
> @@ -768,6 +770,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
>   	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
>   	fs_info->free_space_root = calloc(1, sizeof(struct btrfs_root));
>   	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
> +	fs_info->bg_root = calloc(1, sizeof(struct btrfs_root));
>   	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
>   
>   	if (!fs_info->tree_root || !fs_info->extent_root ||
> @@ -930,6 +933,21 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
>   		return ret;
>   	fs_info->extent_root->track_dirty = 1;
>   
> +	if (btrfs_fs_incompat(fs_info, BG_TREE)) {
> +		ret = setup_root_or_create_block(fs_info, flags,
> +					fs_info->bg_root,
> +					BTRFS_BLOCK_GROUP_TREE_OBJECTID, "bg");
> +		if (ret < 0) {
> +			error("Couldn't setup bg tree");
> +			return ret;
> +		}
> +		fs_info->bg_root->track_dirty = 1;
> +		fs_info->bg_root->ref_cows = 0;
> +	} else {
> +		free(fs_info->bg_root);
> +		fs_info->bg_root = NULL;
> +	}
> +
>   	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
>   				  fs_info->dev_root);
>   	if (ret) {
> @@ -1012,6 +1030,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
>   		free_extent_buffer(fs_info->free_space_root->node);
>   	if (fs_info->quota_root)
>   		free_extent_buffer(fs_info->quota_root->node);
> +	if (fs_info->bg_root)
> +		free_extent_buffer(fs_info->bg_root->node);
>   	if (fs_info->csum_root)
>   		free_extent_buffer(fs_info->csum_root->node);
>   	if (fs_info->dev_root)
> diff --git a/extent-tree.c b/extent-tree.c
> index 9713d627764c..cb3d7a1add0f 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -1528,22 +1528,68 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
>   				 struct btrfs_path *path,
>   				 struct btrfs_block_group_cache *cache)
>   {
> +	bool is_bg_tree = btrfs_fs_incompat(trans->fs_info, BG_TREE);
>   	int ret;
> -	struct btrfs_root *extent_root = trans->fs_info->extent_root;
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_root *root;
>   	unsigned long bi;
>   	struct extent_buffer *leaf;
>   
> -	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
> +	if (is_bg_tree)
> +		root = fs_info->bg_root;
> +	else
> +		root = fs_info->extent_root;
> +
> +	ret = btrfs_search_slot(trans, root, &cache->key, path, 0, 1);
>   	if (ret < 0)
> -		goto fail;


> -	BUG_ON(ret);

  Unrelated change ?

Thanks, Anand

> +		goto out;
>   
> -	leaf = path->nodes[0];
> -	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
> -	write_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
> -	btrfs_mark_buffer_dirty(leaf);
> -	btrfs_release_path(path);
> -fail:
> +	if (ret == 0) {
> +		/* Update existing bg */
> +		leaf = path->nodes[0];
> +		bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
> +		write_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
> +		btrfs_mark_buffer_dirty(leaf);
> +		btrfs_release_path(path);
> +	} else {



> +		btrfs_release_path(path);
> +
> +		/*
> +		 * Insert new bg item
> +		 *
> +		 * This only happens for bg_tree feature
> +		 */
> +		if (!is_bg_tree) {
> +			error("can't find block group item for bytenr %llu",
> +			      cache->key.objectid);
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +		ret = btrfs_insert_item(trans, root, &cache->key, &cache->item,
> +					sizeof(cache->item));
> +		if (ret < 0)
> +			goto out;
> +
> +		/* Also delete the existing one in next tree if needed */
> +		if (fs_info->convert_to_bg_tree) {
> +			ret = btrfs_search_slot(trans, fs_info->extent_root,
> +						&cache->key, path, -1, 1);
> +			if (ret < 0) {
> +				btrfs_release_path(path);
> +				goto out;
> +			}
> +			/* Good, already converted */
> +			if (ret > 0) {
> +				ret = 0;
> +				btrfs_release_path(path);
> +				goto out;
> +			}
> +			/* Delete old block group item in extent tree */
> +			ret = btrfs_del_item(trans, fs_info->extent_root, path);
> +			btrfs_release_path(path);
> +		}
> +	}
> +out:
>   	if (ret)
>   		return ret;
>   	return 0;
> @@ -2717,14 +2763,66 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
>   	return 0;
>   }
>   
> +static int read_block_group_tree(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *root = fs_info->bg_root;
> +	struct btrfs_key key = { 0 };
> +	struct btrfs_path path;
> +	int ret;
> +
> +	btrfs_init_path(&path);
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to search block group tree: %m");
> +		return ret;
> +	}
> +	if (ret == 0)
> +		goto invalid_key;
> +
> +	while (1) {
> +		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +		if (key.type != BTRFS_BLOCK_GROUP_ITEM_KEY)
> +			goto invalid_key;
> +
> +		ret = read_one_block_group(fs_info, &path);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to read one block group: %m");
> +			goto out;
> +		}
> +		ret = btrfs_next_item(root, &path);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to search block group tree: %m");
> +			goto out;
> +		}
> +		if (ret > 0) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +
> +invalid_key:
> +	error("invalid key (%llu, %u, %llu) found in block group tree",
> +	      key.objectid, key.type, key.offset);
> +	btrfs_release_path(&path);
> +	return -EUCLEAN;
> +}
> +
>   int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_path path;
> -	struct btrfs_root *root;
> +	struct btrfs_root *root = fs_info->extent_root;
>   	int ret;
>   	struct btrfs_key key;
>   
> -	root = fs_info->extent_root;
> +	if (btrfs_fs_incompat(fs_info, BG_TREE))
> +		return read_block_group_tree(fs_info);
> +
>   	key.objectid = 0;
>   	key.offset = 0;
>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> @@ -2804,12 +2902,17 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
>   			   u64 type, u64 chunk_offset, u64 size)
>   {
>   	int ret;
> -	struct btrfs_root *extent_root = fs_info->extent_root;
> +	struct btrfs_root *root;
>   	struct btrfs_block_group_cache *cache;
>   
> +	if (btrfs_fs_incompat(fs_info, BG_TREE))
> +		root = fs_info->bg_root;
> +	else
> +		root = fs_info->extent_root;
> +
>   	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
>   				      size);
> -	ret = btrfs_insert_item(trans, extent_root, &cache->key, &cache->item,
> +	ret = btrfs_insert_item(trans, root, &cache->key, &cache->item,
>   				sizeof(cache->item));
>   	BUG_ON(ret);
>   
> @@ -2943,8 +3046,16 @@ static int free_block_group_item(struct btrfs_trans_handle *trans,
>   	if (!path)
>   		return -ENOMEM;
>   
> +	/* Using bg tree only */
> +	if (btrfs_fs_incompat(fs_info, BG_TREE) && !fs_info->convert_to_bg_tree)
> +		goto bg_tree;
> +
>   	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
>   	if (ret > 0) {
> +		if (btrfs_fs_incompat(fs_info, BG_TREE)) {
> +			btrfs_release_path(path);
> +			goto bg_tree;
> +		}
>   		ret = -ENOENT;
>   		goto out;
>   	}
> @@ -2952,6 +3063,19 @@ static int free_block_group_item(struct btrfs_trans_handle *trans,
>   		goto out;
>   
>   	ret = btrfs_del_item(trans, root, path);
> +	goto out;
> +
> +bg_tree:
> +	root = fs_info->bg_root;
> +	ret = btrfs_search_slot(trans, fs_info->bg_root, &key, path, -1, 1);
> +	if (ret < 0)
> +		goto out;
> +	if (ret > 0) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	ret = btrfs_del_item(trans, root, path);
> +
>   out:
>   	btrfs_free_path(path);
>   	return ret;
> 

