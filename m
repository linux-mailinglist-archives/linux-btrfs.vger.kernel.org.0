Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF9DA453
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 05:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404547AbfJQDYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 23:24:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732869AbfJQDYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 23:24:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H3Nugj177702;
        Thu, 17 Oct 2019 03:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=/DLcw5vLzRSnzh6M5mDQTJt2aSR8w+cxW0F8Cab/Txg=;
 b=GZHY+JRdds0KxuWyL463YmcU/5nWT5QoMeYSG0Iofwu8NqogT+WzmIZkX0IVjJmfc1Y0
 mc4JerGvXcXK7sN+WXIYCAvFoDxCsVZoLGTV9/8FVpOlboo95AtiynbivOXhlvucGUTh
 LFr0/fxtJ/RslXtrO33aMAczKvI82VdneGkf/7axC6s2E3o23Ga+pdrmzPFVw8fFAK1/
 3UlMcTAfKbVDv9ouzDsZvQqXi9dA1OymYe7O1aw5HV4TMp4oqu4dBgngHrcQu4YMHaHn
 +X1bmxnL6ZjCP9bFAuFOznUD49KtfYrrG442AxJvgXCo8Et2motat0KFSzMUwS0pIf7E 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vk68uu7a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 03:23:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H38JUR046976;
        Thu, 17 Oct 2019 03:23:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vpcm21pc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 03:23:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9H3NqtS013433;
        Thu, 17 Oct 2019 03:23:52 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 03:23:51 +0000
Subject: Re: [PATCH v2 2/7] btrfs-progs: Refactor btrfs_read_block_groups()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fd4f3e1c-fd98-6550-6284-f1456e0332ba@oracle.com>
Date:   Thu, 17 Oct 2019 11:23:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008044936.157873-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170023
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 12:49 PM, Qu Wenruo wrote:
> This patch does the following refactor:
> - Refactor parameter from @root to @fs_info
> 
> - Refactor the large loop body into another function
>    Now we have a helper function, read_one_block_group(), to handle
>    block group cache and space info related routine.
> 
> - Refactor the return value
>    Even we have the code handling ret > 0 from find_first_block_group(),
>    it never works, as when there is no more block group,
>    find_first_block_group() just return -ENOENT other than 1.


  Can it be separated into patches? My concern is as it alters the return
  value of the rescue command. So we shall have clarity of a discrete
  patch to blame. Otherwise I agree its a good change.


>    This is super confusing, it's almost a mircle it even works.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   ctree.h       |   2 +-
>   disk-io.c     |   9 ++-
>   extent-tree.c | 160 ++++++++++++++++++++++++++++----------------------
>   3 files changed, 97 insertions(+), 74 deletions(-)
> 
> diff --git a/ctree.h b/ctree.h
> index 8c7b3cb40151..2899de358613 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -2550,7 +2550,7 @@ int update_space_info(struct btrfs_fs_info *info, u64 flags,
>   		      u64 total_bytes, u64 bytes_used,
>   		      struct btrfs_space_info **space_info);
>   int btrfs_free_block_groups(struct btrfs_fs_info *info);
> -int btrfs_read_block_groups(struct btrfs_root *root);
> +int btrfs_read_block_groups(struct btrfs_fs_info *info);
>   struct btrfs_block_group_cache *
>   btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
>   		      u64 chunk_offset, u64 size);
> diff --git a/disk-io.c b/disk-io.c
> index be44eead5cef..8978f0cb60c7 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -983,14 +983,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
>   	fs_info->last_trans_committed = generation;
>   	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
>   	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
> -		ret = btrfs_read_block_groups(fs_info->tree_root);
> +		ret = btrfs_read_block_groups(fs_info);
>   		/*
>   		 * If we don't find any blockgroups (ENOENT) we're either
>   		 * restoring or creating the filesystem, where it's expected,
>   		 * anything else is error
>   		 */
> -		if (ret != -ENOENT)
> -			return -EIO;
> +		if (ret < 0 && ret != -ENOENT) {
> +			errno = -ret;
> +			error("failed to read block groups: %m");
> +			return ret;
> +		}
>   	}


As mentioned this alters the rescue command semantics as show below.
Earlier we had only -EIO as error now its much more and accurate
which is good. fstests is fine but anything else?

cmd_rescue_chunk_recover()
   btrfs_recover_chunk_tree()
     open_ctree_with_broken_chunk()
       btrfs_setup_all_roots()

Thanks, Anand

>   	key.objectid = BTRFS_FS_TREE_OBJECTID;
> diff --git a/extent-tree.c b/extent-tree.c
> index 19d1ea0df570..9713d627764c 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -2607,6 +2607,13 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>   	return 0;
>   }
>   
> +/*
> + * Find a block group which starts >= @key->objectid in extent tree.
> + *
> + * Return 0 for found
> + * Retrun >0 for not found
> + * Return <0 for error
> + */
>   static int find_first_block_group(struct btrfs_root *root,
>   		struct btrfs_path *path, struct btrfs_key *key)
>   {
> @@ -2636,36 +2643,95 @@ static int find_first_block_group(struct btrfs_root *root,
>   			return 0;
>   		path->slots[0]++;
>   	}
> -	ret = -ENOENT;
> +	ret = 1;
>   error:
>   	return ret;
>   }
>   
> -int btrfs_read_block_groups(struct btrfs_root *root)
> +/*
> + * Helper function to read out one BLOCK_GROUP_ITEM and insert it into
> + * block group cache.
> + *
> + * Return 0 if nothing wrong (either insert the bg cache or skip 0 sized bg)
> + * Return <0 for error.
> + */
> +static int read_one_block_group(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_path *path)
>   {
> -	struct btrfs_path *path;
> -	int ret;
> -	int bit;
> -	struct btrfs_block_group_cache *cache;
> -	struct btrfs_fs_info *info = root->fs_info;
> +	struct extent_io_tree *block_group_cache = &fs_info->block_group_cache;
> +	struct extent_buffer *leaf = path->nodes[0];
>   	struct btrfs_space_info *space_info;
> -	struct extent_io_tree *block_group_cache;
> +	struct btrfs_block_group_cache *cache;
>   	struct btrfs_key key;
> -	struct btrfs_key found_key;
> -	struct extent_buffer *leaf;
> +	int slot = path->slots[0];
> +	int bit = 0;
> +	int ret;
>   
> -	block_group_cache = &info->block_group_cache;
> +	btrfs_item_key_to_cpu(leaf, &key, slot);
> +	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
> +
> +	/*
> +	 * Skip 0 sized block group, don't insert them into block
> +	 * group cache tree, as its length is 0, it won't get
> +	 * freed at close_ctree() time.
> +	 */
> +	if (key.offset == 0)
> +		return 0;
> +
> +	cache = kzalloc(sizeof(*cache), GFP_NOFS);
> +	if (!cache)
> +		return -ENOMEM;
> +	read_extent_buffer(leaf, &cache->item,
> +			   btrfs_item_ptr_offset(leaf, slot),
> +			   sizeof(cache->item));
> +	memcpy(&cache->key, &key, sizeof(key));
> +	cache->cached = 0;
> +	cache->pinned = 0;
> +	cache->flags = btrfs_block_group_flags(&cache->item);
> +	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
> +		bit = BLOCK_GROUP_DATA;
> +	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		bit = BLOCK_GROUP_SYSTEM;
> +	} else if (cache->flags & BTRFS_BLOCK_GROUP_METADATA) {
> +		bit = BLOCK_GROUP_METADATA;
> +	}
> +	set_avail_alloc_bits(fs_info, cache->flags);
> +	if (btrfs_chunk_readonly(fs_info, cache->key.objectid))
> +		cache->ro = 1;
> +	exclude_super_stripes(fs_info, cache);
> +
> +	ret = update_space_info(fs_info, cache->flags, cache->key.offset,
> +				btrfs_block_group_used(&cache->item),
> +				&space_info);
> +	if (ret < 0) {
> +		free(cache);
> +		return ret;
> +	}
> +	cache->space_info = space_info;
> +
> +	set_extent_bits(block_group_cache, cache->key.objectid,
> +			cache->key.objectid + cache->key.offset - 1,
> +			bit | EXTENT_LOCKED);
> +	set_state_private(block_group_cache, cache->key.objectid,
> +			  (unsigned long)cache);
> +	return 0;
> +}
>   
> -	root = info->extent_root;
> +int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_path path;
> +	struct btrfs_root *root;
> +	int ret;
> +	struct btrfs_key key;
> +
> +	root = fs_info->extent_root;
>   	key.objectid = 0;
>   	key.offset = 0;
>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> -	path = btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> +	btrfs_init_path(&path);
>   
>   	while(1) {
> -		ret = find_first_block_group(root, path, &key);
> +		ret = find_first_block_group(root, &path, &key);
>   		if (ret > 0) {
>   			ret = 0;
>   			goto error;
> @@ -2673,67 +2739,21 @@ int btrfs_read_block_groups(struct btrfs_root *root)
>   		if (ret != 0) {
>   			goto error;
>   		}
> -		leaf = path->nodes[0];
> -		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
>   
> -		cache = kzalloc(sizeof(*cache), GFP_NOFS);
> -		if (!cache) {
> -			ret = -ENOMEM;
> +		ret = read_one_block_group(fs_info, &path);
> +		if (ret < 0)
>   			goto error;
> -		}
>   
> -		read_extent_buffer(leaf, &cache->item,
> -				   btrfs_item_ptr_offset(leaf, path->slots[0]),
> -				   sizeof(cache->item));
> -		memcpy(&cache->key, &found_key, sizeof(found_key));
> -		cache->cached = 0;
> -		cache->pinned = 0;
> -		key.objectid = found_key.objectid + found_key.offset;
> -		if (found_key.offset == 0)
> +		if (key.offset == 0)
>   			key.objectid++;
> -		btrfs_release_path(path);
> -
> -		/*
> -		 * Skip 0 sized block group, don't insert them into block
> -		 * group cache tree, as its length is 0, it won't get
> -		 * freed at close_ctree() time.
> -		 */
> -		if (found_key.offset == 0) {
> -			free(cache);
> -			continue;
> -		}
> -
> -		cache->flags = btrfs_block_group_flags(&cache->item);
> -		bit = 0;
> -		if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
> -			bit = BLOCK_GROUP_DATA;
> -		} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> -			bit = BLOCK_GROUP_SYSTEM;
> -		} else if (cache->flags & BTRFS_BLOCK_GROUP_METADATA) {
> -			bit = BLOCK_GROUP_METADATA;
> -		}
> -		set_avail_alloc_bits(info, cache->flags);
> -		if (btrfs_chunk_readonly(info, cache->key.objectid))
> -			cache->ro = 1;
> -
> -		exclude_super_stripes(info, cache);
> -
> -		ret = update_space_info(info, cache->flags, found_key.offset,
> -					btrfs_block_group_used(&cache->item),
> -					&space_info);
> -		BUG_ON(ret);
> -		cache->space_info = space_info;
> -
> -		/* use EXTENT_LOCKED to prevent merging */
> -		set_extent_bits(block_group_cache, found_key.objectid,
> -				found_key.objectid + found_key.offset - 1,
> -				bit | EXTENT_LOCKED);
> -		set_state_private(block_group_cache, found_key.objectid,
> -				  (unsigned long)cache);
> +		else
> +			key.objectid = key.objectid + key.offset;
> +		btrfs_release_path(&path);
>   	}
>   	ret = 0;
>   error:
> -	btrfs_free_path(path);
> +	btrfs_release_path(&path);
>   	return ret;
>   }
>   
> 

