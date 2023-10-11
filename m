Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911C57C47A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 04:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbjJKCMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 22:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbjJKCMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 22:12:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A08E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 19:12:40 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S4x5M4b0FzkY6N;
        Wed, 11 Oct 2023 10:08:39 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 10:12:36 +0800
Message-ID: <3f04845f-b9b5-68b6-90a0-8921eaa53b4d@huawei.com>
Date:   Wed, 11 Oct 2023 10:12:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 7/9] Btrfs: add free space tree sanity tests
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, <linux-btrfs@vger.kernel.org>
References: <cover.1443583874.git.osandov@osandov.com>
 <b8fbdc4c149cee8648399ebd985f111e4e4f191d.1443583874.git.osandov@osandov.com>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <b8fbdc4c149cee8648399ebd985f111e4e4f191d.1443583874.git.osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2015/9/30 11:50, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This tests the operations on the free space tree trying to excercise all
> of the main cases for both formats. Between this and xfstests, the free
> space tree should have pretty good coverage.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/Makefile                      |   3 +-
>  fs/btrfs/super.c                       |   3 +
>  fs/btrfs/tests/btrfs-tests.c           |  52 +++
>  fs/btrfs/tests/btrfs-tests.h           |  10 +
>  fs/btrfs/tests/free-space-tests.c      |  35 +-
>  fs/btrfs/tests/free-space-tree-tests.c | 571 +++++++++++++++++++++++++++++++++
>  fs/btrfs/tests/qgroup-tests.c          |  20 +-
>  7 files changed, 646 insertions(+), 48 deletions(-)
>  create mode 100644 fs/btrfs/tests/free-space-tree-tests.c
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 766169709146..128ce17a80b0 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -16,4 +16,5 @@ btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
>  	tests/extent-buffer-tests.o tests/btrfs-tests.o \
> -	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o
> +	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o \
> +	tests/free-space-tree-tests.o
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 11d1eab9234d..442bf434b783 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2212,6 +2212,9 @@ static int btrfs_run_sanity_tests(void)
>  	if (ret)
>  		goto out;
>  	ret = btrfs_test_qgroups();
> +	if (ret)
> +		goto out;
> +	ret = btrfs_test_free_space_tree();
>  out:
>  	btrfs_destroy_test_fs();
>  	return ret;
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index 9626252ee6b4..ba28cefdf9e7 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -21,6 +21,9 @@
>  #include <linux/magic.h>
>  #include "btrfs-tests.h"
>  #include "../ctree.h"
> +#include "../free-space-cache.h"
> +#include "../free-space-tree.h"
> +#include "../transaction.h"
>  #include "../volumes.h"
>  #include "../disk-io.h"
>  #include "../qgroup.h"
> @@ -122,6 +125,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(void)
>  	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
>  	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
>  	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> +	extent_io_tree_init(&fs_info->freed_extents[0], NULL);
> +	extent_io_tree_init(&fs_info->freed_extents[1], NULL);
> +	fs_info->pinned_extents = &fs_info->freed_extents[0];
>  	return fs_info;
>  }
>  
> @@ -169,3 +175,49 @@ void btrfs_free_dummy_root(struct btrfs_root *root)
>  	kfree(root);
>  }
>  
> +struct btrfs_block_group_cache *
> +btrfs_alloc_dummy_block_group(unsigned long length)
> +{
> +	struct btrfs_block_group_cache *cache;
> +
> +	cache = kzalloc(sizeof(*cache), GFP_NOFS);
> +	if (!cache)
> +		return NULL;
> +	cache->free_space_ctl = kzalloc(sizeof(*cache->free_space_ctl),
> +					GFP_NOFS);
> +	if (!cache->free_space_ctl) {
> +		kfree(cache);
> +		return NULL;
> +	}
> +
> +	cache->key.objectid = 0;
> +	cache->key.offset = length;
> +	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> +	cache->sectorsize = 4096;
> +	cache->full_stripe_len = 4096;
> +
> +	INIT_LIST_HEAD(&cache->list);
> +	INIT_LIST_HEAD(&cache->cluster_list);
> +	INIT_LIST_HEAD(&cache->bg_list);
> +	btrfs_init_free_space_ctl(cache);
> +	mutex_init(&cache->free_space_lock);
> +
> +	return cache;
> +}
> +
> +void btrfs_free_dummy_block_group(struct btrfs_block_group_cache *cache)
> +{
> +	if (!cache)
> +		return;
> +	__btrfs_remove_free_space_cache(cache->free_space_ctl);
> +	kfree(cache->free_space_ctl);
> +	kfree(cache);
> +}
> +
> +void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans)
> +{
> +	memset(trans, 0, sizeof(*trans));
> +	trans->transid = 1;
> +	INIT_LIST_HEAD(&trans->qgroup_ref_list);
> +	trans->type = __TRANS_DUMMY;
> +}
> diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
> index fd3954224480..054b8c73c951 100644
> --- a/fs/btrfs/tests/btrfs-tests.h
> +++ b/fs/btrfs/tests/btrfs-tests.h
> @@ -24,17 +24,23 @@
>  #define test_msg(fmt, ...) pr_info("BTRFS: selftest: " fmt, ##__VA_ARGS__)
>  
>  struct btrfs_root;
> +struct btrfs_trans_handle;
>  
>  int btrfs_test_free_space_cache(void);
>  int btrfs_test_extent_buffer_operations(void);
>  int btrfs_test_extent_io(void);
>  int btrfs_test_inodes(void);
>  int btrfs_test_qgroups(void);
> +int btrfs_test_free_space_tree(void);
>  int btrfs_init_test_fs(void);
>  void btrfs_destroy_test_fs(void);
>  struct inode *btrfs_new_test_inode(void);
>  struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(void);
>  void btrfs_free_dummy_root(struct btrfs_root *root);
> +struct btrfs_block_group_cache *
> +btrfs_alloc_dummy_block_group(unsigned long length);
> +void btrfs_free_dummy_block_group(struct btrfs_block_group_cache *cache);
> +void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans);
>  #else
>  static inline int btrfs_test_free_space_cache(void)
>  {
> @@ -63,6 +69,10 @@ static inline int btrfs_test_qgroups(void)
>  {
>  	return 0;
>  }
> +static inline int btrfs_test_free_space_tree(void)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif
> diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
> index 2299bfde39ee..bae6c599f604 100644
> --- a/fs/btrfs/tests/free-space-tests.c
> +++ b/fs/btrfs/tests/free-space-tests.c
> @@ -22,35 +22,6 @@
>  #include "../free-space-cache.h"
>  
>  #define BITS_PER_BITMAP		(PAGE_CACHE_SIZE * 8)
> -static struct btrfs_block_group_cache *init_test_block_group(void)
> -{
> -	struct btrfs_block_group_cache *cache;
> -
> -	cache = kzalloc(sizeof(*cache), GFP_NOFS);
> -	if (!cache)
> -		return NULL;
> -	cache->free_space_ctl = kzalloc(sizeof(*cache->free_space_ctl),
> -					GFP_NOFS);
> -	if (!cache->free_space_ctl) {
> -		kfree(cache);
> -		return NULL;
> -	}
> -
> -	cache->key.objectid = 0;
> -	cache->key.offset = 1024 * 1024 * 1024;
> -	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> -	cache->sectorsize = 4096;
> -	cache->full_stripe_len = 4096;
> -
> -	spin_lock_init(&cache->lock);
> -	INIT_LIST_HEAD(&cache->list);
> -	INIT_LIST_HEAD(&cache->cluster_list);
> -	INIT_LIST_HEAD(&cache->bg_list);
> -
> -	btrfs_init_free_space_ctl(cache);
> -
> -	return cache;
> -}
>  
>  /*
>   * This test just does basic sanity checking, making sure we can add an exten
> @@ -883,7 +854,7 @@ int btrfs_test_free_space_cache(void)
>  
>  	test_msg("Running btrfs free space cache tests\n");
>  
> -	cache = init_test_block_group();
> +	cache = btrfs_alloc_dummy_block_group(1024 * 1024 * 1024);
>  	if (!cache) {
>  		test_msg("Couldn't run the tests\n");
>  		return 0;
> @@ -901,9 +872,7 @@ int btrfs_test_free_space_cache(void)
>  
>  	ret = test_steal_space_from_bitmap_to_extent(cache);
>  out:
> -	__btrfs_remove_free_space_cache(cache->free_space_ctl);
> -	kfree(cache->free_space_ctl);
> -	kfree(cache);
> +	btrfs_free_dummy_block_group(cache);
>  	test_msg("Free space cache tests finished\n");
>  	return ret;
>  }
> diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
> new file mode 100644
> index 000000000000..d05fe1ab4808
> --- /dev/null
> +++ b/fs/btrfs/tests/free-space-tree-tests.c
> @@ -0,0 +1,571 @@
> +/*
> + * Copyright (C) 2015 Facebook.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License v2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this program; if not, write to the
> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> + * Boston, MA 021110-1307, USA.
> + */
> +
> +#include "btrfs-tests.h"
> +#include "../ctree.h"
> +#include "../disk-io.h"
> +#include "../free-space-tree.h"
> +#include "../transaction.h"
> +
> +struct free_space_extent {
> +	u64 start, length;
> +};
> +
> +/*
> + * The test cases align their operations to this in order to hit some of the
> + * edge cases in the bitmap code.
> + */
> +#define BITMAP_RANGE (BTRFS_FREE_SPACE_BITMAP_BITS * 4096)
> +
> +static int __check_free_space_extents(struct btrfs_trans_handle *trans,
> +				      struct btrfs_fs_info *fs_info,
> +				      struct btrfs_block_group_cache *cache,
> +				      struct btrfs_path *path,
> +				      struct free_space_extent *extents,
> +				      unsigned int num_extents)
> +{
> +	struct btrfs_free_space_info *info;
> +	struct btrfs_key key;
> +	int prev_bit = 0, bit;
> +	u64 extent_start = 0, offset, end;
> +	u32 flags, extent_count;
> +	unsigned int i;
> +	int ret;
> +
> +	info = search_free_space_info(trans, fs_info, cache, path, 0);
> +	if (IS_ERR(info)) {
> +		test_msg("Could not find free space info\n");
> +		ret = PTR_ERR(info);
> +		goto out;
> +	}
> +	flags = btrfs_free_space_flags(path->nodes[0], info);
> +	extent_count = btrfs_free_space_extent_count(path->nodes[0], info);
> +
> +	if (extent_count != num_extents) {
> +		test_msg("Extent count is wrong\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
> +		if (path->slots[0] != 0)
> +			goto invalid;
> +		end = cache->key.objectid + cache->key.offset;
> +		i = 0;
> +		while (++path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
> +			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +			if (key.type != BTRFS_FREE_SPACE_BITMAP_KEY)
> +				goto invalid;
> +			offset = key.objectid;
> +			while (offset < key.objectid + key.offset) {
> +				bit = free_space_test_bit(cache, path, offset);
> +				if (prev_bit == 0 && bit == 1) {
> +					extent_start = offset;
> +				} else if (prev_bit == 1 && bit == 0) {
> +					if (i >= num_extents)
> +						goto invalid;
> +					if (i >= num_extents ||
> +					    extent_start != extents[i].start ||
> +					    offset - extent_start != extents[i].length)
> +						goto invalid;
> +					i++;
> +				}
> +				prev_bit = bit;
> +				offset += cache->sectorsize;
> +			}
> +		}
> +		if (prev_bit == 1) {
> +			if (i >= num_extents ||
> +			    extent_start != extents[i].start ||
> +			    end - extent_start != extents[i].length)
> +				goto invalid;
> +			i++;
> +		}
> +		if (i != num_extents)
> +			goto invalid;
> +	} else {
> +		if (btrfs_header_nritems(path->nodes[0]) != num_extents + 1 ||
> +		    path->slots[0] != 0)
> +			goto invalid;
> +		for (i = 0; i < num_extents; i++) {
> +			path->slots[0]++;
> +			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +			if (key.type != BTRFS_FREE_SPACE_EXTENT_KEY ||
> +			    key.objectid != extents[i].start ||
> +			    key.offset != extents[i].length)
> +				goto invalid;
> +		}
> +	}
> +
> +	ret = 0;
> +out:
> +	btrfs_release_path(path);
> +	return ret;
> +invalid:
> +	test_msg("Free space tree is invalid\n");
> +	ret = -EINVAL;
> +	goto out;
> +}
> +
> +static int check_free_space_extents(struct btrfs_trans_handle *trans,
> +				    struct btrfs_fs_info *fs_info,
> +				    struct btrfs_block_group_cache *cache,
> +				    struct btrfs_path *path,
> +				    struct free_space_extent *extents,
> +				    unsigned int num_extents)
> +{
> +	struct btrfs_free_space_info *info;
> +	u32 flags;
> +	int ret;
> +
> +	info = search_free_space_info(trans, fs_info, cache, path, 0);
> +	if (IS_ERR(info)) {
> +		test_msg("Could not find free space info\n");
> +		btrfs_release_path(path);
> +		return PTR_ERR(info);
> +	}
> +	flags = btrfs_free_space_flags(path->nodes[0], info);
> +	btrfs_release_path(path);
> +
> +	ret = __check_free_space_extents(trans, fs_info, cache, path, extents,
> +					 num_extents);
> +	if (ret)
> +		return ret;
> +
> +	/* Flip it to the other format and check that for good measure. */
> +	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
> +		ret = convert_free_space_to_extents(trans, fs_info, cache, path);
> +		if (ret) {
> +			test_msg("Could not convert to extents\n");
> +			return ret;
> +		}
> +	} else {
> +		ret = convert_free_space_to_bitmaps(trans, fs_info, cache, path);
> +		if (ret) {
> +			test_msg("Could not convert to bitmaps\n");
> +			return ret;
> +		}
> +	}
> +	return __check_free_space_extents(trans, fs_info, cache, path, extents,
> +					  num_extents);
> +}
> +
> +static int test_empty_block_group(struct btrfs_trans_handle *trans,
> +				  struct btrfs_fs_info *fs_info,
> +				  struct btrfs_block_group_cache *cache,
> +				  struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid, cache->key.offset},
> +	};
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));

Inject fault when probe btrfs.ko, there is a null-ptr-deref as below, it
seems that the transaction in btrfs_trans_handle struct has not been
initialized but used in __btrfs_abort_transaction() when calling
WRITE_ONCE(trans->transaction->aborted, errno).


[37093.705309] FAULT_INJECTION: forcing a failure.
[37093.705309] name failslab, interval 1, probability 0, space 0, times 0
[37093.706279] CPU: 6 PID: 22177 Comm: modprobe Tainted: G        W
  N 6.6.0-rc4+ #70
[37093.707019] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[37093.707742] Call Trace:
[37093.707965]  <TASK>
[37093.708161]  dump_stack_lvl+0x33/0x50
[37093.708492]  should_fail_ex+0x4c3/0x5c0
[37093.708836]  ? alloc_bitmap+0xaf/0x150 [btrfs]
[37093.709332]  should_failslab+0xa/0x20
[37093.709669]  __kmem_cache_alloc_node+0x59/0x350
[37093.710068]  ? alloc_bitmap+0xaf/0x150 [btrfs]
[37093.710545]  ? alloc_bitmap+0xaf/0x150 [btrfs]
[37093.711015]  __kmalloc_node+0x55/0x150
[37093.711371]  ? btrfs_search_slot+0x17bd/0x2950 [btrfs]
[37093.711889]  alloc_bitmap+0xaf/0x150 [btrfs]
[37093.712332]  convert_free_space_to_bitmaps+0x266/0xd40 [btrfs]
[37093.712906]  ? alloc_extent_buffer+0x1020/0x1020 [btrfs]
[37093.713444]  ? btrfs_release_path+0x51/0x2b0 [btrfs]
[37093.713958]  ? search_free_space_info+0x3b0/0x3b0 [btrfs]
[37093.714497]  ? __check_free_space_extents+0x64e/0xb20 [btrfs]
[37093.715080]  ? free_extent_buffer+0x136/0x290 [btrfs]
[37093.715556]  ? btrfs_test_qgroups+0x860/0x860 [btrfs]
[37093.716036]  ? btrfs_release_path+0x51/0x2b0 [btrfs]
[37093.716548]  ? kasan_quarantine_put+0x21/0x1a0
[37093.716949]  check_free_space_extents+0xac/0x170 [btrfs]
[37093.717497]  test_empty_block_group+0xb9/0x140 [btrfs]
[37093.718025]  ? __mutex_unlock_slowpath.constprop.0+0x2a0/0x2a0
[37093.718547]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.719031]  ? add_block_group_free_space+0x168/0x2a0 [btrfs]
[37093.719595]  run_test+0x5ba/0xb80 [btrfs]
[37093.720001]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.720475]  ? test_empty_block_group+0x140/0x140 [btrfs]
[37093.721029]  ? __wake_up_klogd.part.0+0x7d/0xc0
[37093.721422]  ? printk_timed_ratelimit+0xb0/0xb0
[37093.721814]  ? __kmem_cache_free+0xc4/0x310
[37093.722170]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.722651]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.723132]  run_test_both_formats+0x27/0xc0 [btrfs]
[37093.723621]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.724103]  btrfs_test_free_space_tree+0x12a/0x200 [btrfs]
[37093.724650]  ? run_test_both_formats+0xc0/0xc0 [btrfs]
[37093.725149]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.725621]  ? test_remove_beginning+0x190/0x190 [btrfs]
[37093.726127]  ? test_remove_end+0x190/0x190 [btrfs]
[37093.726598]  ? test_remove_middle+0x1c0/0x1c0 [btrfs]
[37093.727090]  ? test_merge_left+0x290/0x290 [btrfs]
[37093.727556]  ? test_merge_right+0x280/0x280 [btrfs]
[37093.728044]  ? test_merge_both+0x320/0x320 [btrfs]
[37093.728512]  ? test_merge_none+0x370/0x370 [btrfs]
[37093.728981]  ? check_free_space_extents+0x170/0x170 [btrfs]
[37093.729506]  ? btrfs_test_qgroups+0x587/0x860 [btrfs]
[37093.729997]  btrfs_run_sanity_tests+0xc4/0x150 [btrfs]
[37093.730484]  init_btrfs_fs+0x4b/0x340 [btrfs]
[37093.730956]  ? btrfs_interface_init+0x20/0x20 [btrfs]
[37093.731453]  do_one_initcall+0x87/0x2e0
[37093.731796]  ? trace_event_raw_event_initcall_level+0x1b0/0x1b0
[37093.732305]  ? memset_orig+0x82/0xac
[37093.732624]  ? kasan_unpoison+0x40/0x70
[37093.732989]  do_init_module+0x22d/0x730
[37093.733334]  load_module+0x4ffd/0x67d0
[37093.733670]  ? module_frob_arch_sections+0x20/0x20
[37093.734102]  ? update_cfs_group+0x10a/0x290
[37093.734484]  ? sched_clock_cpu+0x69/0x550
[37093.734856]  ? kernel_read_file+0x3ca/0x510
[37093.735220]  ? __x64_sys_fspick+0x2a0/0x2a0
[37093.735585]  ? __schedule+0x9fa/0x2a50
[37093.735914]  ? init_module_from_file+0xd2/0x130
[37093.736320]  init_module_from_file+0xd2/0x130
[37093.736734]  ? __ia32_sys_init_module+0xa0/0xa0
[37093.737144]  ? _raw_spin_lock_bh+0xe0/0xe0
[37093.737500]  ? cgroup_leave_frozen+0x1e1/0x2d0
[37093.737903]  ? ptrace_stop.part.0+0x544/0x790
[37093.738290]  idempotent_init_module+0x339/0x610
[37093.738696]  ? init_module_from_file+0x130/0x130
[37093.739109]  ? __fget_light+0x57/0x500
[37093.739426]  __x64_sys_finit_module+0xba/0x130
[37093.739838]  do_syscall_64+0x35/0x80
[37093.740161]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[37093.740621] RIP: 0033:0x7fa73731b839
[37093.740942] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[37093.742555] RSP: 002b:00007fff44e94228 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[37093.743224] RAX: ffffffffffffffda RBX: 0000564c90379db0 RCX:
00007fa73731b839
[37093.743858] RDX: 0000000000000000 RSI: 0000564c8e81bc2e RDI:
0000000000000003
[37093.744499] RBP: 0000564c8e81bc2e R08: 0000000000000000 R09:
0000564c90379db0
[37093.745106] R10: 0000000000000003 R11: 0000000000000246 R12:
0000000000000000
[37093.745730] R13: 0000564c90379e30 R14: 0000000000040000 R15:
0000564c90379db0
[37093.746351]  </TASK>
[37093.746587] BTRFS error (device (efault): state A): Transaction
aborted (error -12)
[37093.747348] general protection fault, probably for non-canonical
address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
[37093.748299] KASAN: null-ptr-deref in range
[0x0000000000000020-0x0000000000000027]
[37093.748950] CPU: 6 PID: 22177 Comm: modprobe Tainted: G        W
  N 6.6.0-rc4+ #70
[37093.749682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[37093.750406] RIP: 0010:__btrfs_abort_transaction+0xab/0x180 [btrfs]
[37093.751049] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bc 00 00 00
48 b8 00 00 00 00 00 fc ff df 48 8b 5b 20 48 8d 7b 24 48 89 fa 48 c1 ea
03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 69 44
[37093.752636] RSP: 0018:ffff88811629f2f0 EFLAGS: 00010203
[37093.753101] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
00000000fffffff4
[37093.753719] RDX: 0000000000000004 RSI: ffffffffa066dec0 RDI:
0000000000000024
[37093.754337] RBP: ffff888117844000 R08: 0000000000000001 R09:
ffffed1022c53df8
[37093.754953] R10: ffff88811629efc7 R11: 0000000046525442 R12:
00000000fffffff4
[37093.755573] R13: ffffffffa066dec0 R14: 0000000000000152 R15:
0000000000000000
[37093.756207] FS:  00007fa7379f5540(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[37093.756904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37093.757407] CR2: 00007fff44e90ff8 CR3: 000000010f33d001 CR4:
0000000000770ee0
[37093.758026] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[37093.758638] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[37093.759263] PKRU: 55555554
[37093.759509] Call Trace:
[37093.759743]  <TASK>
[37093.759940]  ? die_addr+0x3d/0xa0
[37093.760228]  ? exc_general_protection+0x144/0x220
[37093.760633]  ? asm_exc_general_protection+0x22/0x30
[37093.761069]  ? __btrfs_abort_transaction+0xab/0x180 [btrfs]
[37093.761603]  convert_free_space_to_bitmaps+0x6f1/0xd40 [btrfs]
[37093.762177]  ? btrfs_release_path+0x51/0x2b0 [btrfs]
[37093.762698]  ? search_free_space_info+0x3b0/0x3b0 [btrfs]
[37093.763238]  ? __check_free_space_extents+0x64e/0xb20 [btrfs]
[37093.763788]  ? free_extent_buffer+0x136/0x290 [btrfs]
[37093.764271]  ? btrfs_test_qgroups+0x860/0x860 [btrfs]
[37093.764737]  ? btrfs_release_path+0x51/0x2b0 [btrfs]
[37093.765233]  ? kasan_quarantine_put+0x21/0x1a0
[37093.765640]  check_free_space_extents+0xac/0x170 [btrfs]
[37093.766153]  test_empty_block_group+0xb9/0x140 [btrfs]
[37093.766674]  ? __mutex_unlock_slowpath.constprop.0+0x2a0/0x2a0
[37093.767184]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.767656]  ? add_block_group_free_space+0x168/0x2a0 [btrfs]
[37093.768237]  run_test+0x5ba/0xb80 [btrfs]
[37093.768646]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.769059]  ? test_empty_block_group+0x140/0x140 [btrfs]
[37093.769590]  ? __wake_up_klogd.part.0+0x7d/0xc0
[37093.770021]  ? printk_timed_ratelimit+0xb0/0xb0
[37093.770427]  ? __kmem_cache_free+0xc4/0x310
[37093.770822]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.771298]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.771768]  run_test_both_formats+0x27/0xc0 [btrfs]
[37093.772257]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.772740]  btrfs_test_free_space_tree+0x12a/0x200 [btrfs]
[37093.773296]  ? run_test_both_formats+0xc0/0xc0 [btrfs]
[37093.773806]  ? test_remove_all+0x180/0x180 [btrfs]
[37093.774281]  ? test_remove_beginning+0x190/0x190 [btrfs]
[37093.774815]  ? test_remove_end+0x190/0x190 [btrfs]
[37093.775278]  ? test_remove_middle+0x1c0/0x1c0 [btrfs]
[37093.775793]  ? test_merge_left+0x290/0x290 [btrfs]
[37093.776270]  ? test_merge_right+0x280/0x280 [btrfs]
[37093.776768]  ? test_merge_both+0x320/0x320 [btrfs]
[37093.777240]  ? test_merge_none+0x370/0x370 [btrfs]
[37093.777714]  ? check_free_space_extents+0x170/0x170 [btrfs]
[37093.778266]  ? btrfs_test_qgroups+0x587/0x860 [btrfs]
[37093.778782]  btrfs_run_sanity_tests+0xc4/0x150 [btrfs]
[37093.779307]  init_btrfs_fs+0x4b/0x340 [btrfs]
[37093.779764]  ? btrfs_interface_init+0x20/0x20 [btrfs]
[37093.780274]  do_one_initcall+0x87/0x2e0
[37093.780612]  ? trace_event_raw_event_initcall_level+0x1b0/0x1b0
[37093.781146]  ? memset_orig+0x82/0xac
[37093.781473]  ? kasan_unpoison+0x40/0x70
[37093.781812]  do_init_module+0x22d/0x730
[37093.782151]  load_module+0x4ffd/0x67d0
[37093.782477]  ? module_frob_arch_sections+0x20/0x20
[37093.782930]  ? update_cfs_group+0x10a/0x290
[37093.783300]  ? sched_clock_cpu+0x69/0x550
[37093.783653]  ? kernel_read_file+0x3ca/0x510
[37093.784018]  ? __x64_sys_fspick+0x2a0/0x2a0
[37093.784388]  ? __schedule+0x9fa/0x2a50
[37093.784726]  ? init_module_from_file+0xd2/0x130
[37093.785125]  init_module_from_file+0xd2/0x130
[37093.785529]  ? __ia32_sys_init_module+0xa0/0xa0
[37093.785938]  ? _raw_spin_lock_bh+0xe0/0xe0
[37093.786308]  ? cgroup_leave_frozen+0x1e1/0x2d0
[37093.786708]  ? ptrace_stop.part.0+0x544/0x790
[37093.787099]  idempotent_init_module+0x339/0x610
[37093.787484]  ? init_module_from_file+0x130/0x130
[37093.787894]  ? __fget_light+0x57/0x500
[37093.788233]  __x64_sys_finit_module+0xba/0x130
[37093.788623]  do_syscall_64+0x35/0x80
[37093.788946]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[37093.789407] RIP: 0033:0x7fa73731b839
[37093.789745] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[37093.791390] RSP: 002b:00007fff44e94228 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[37093.792064] RAX: ffffffffffffffda RBX: 0000564c90379db0 RCX:
00007fa73731b839
[37093.792707] RDX: 0000000000000000 RSI: 0000564c8e81bc2e RDI:
0000000000000003
[37093.793328] RBP: 0000564c8e81bc2e R08: 0000000000000000 R09:
0000564c90379db0
[37093.793948] R10: 0000000000000003 R11: 0000000000000246 R12:
0000000000000000
[37093.794592] R13: 0000564c90379e30 R14: 0000000000040000 R15:
0000564c90379db0
[37093.795200]  </TASK>
[37093.795403] Modules linked in: btrfs(+) blake2b_generic fpga_region
fpga_bridge [last unloaded: btrfs]
[37093.796373] Dumping ftrace buffer:
[37093.796704]    (ftrace buffer empty)
[37093.797077] ---[ end trace 0000000000000000 ]---
[37093.797491] RIP: 0010:__btrfs_abort_transaction+0xab/0x180 [btrfs]
[37093.798105] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bc 00 00 00
48 b8 00 00 00 00 00 fc ff df 48 8b 5b 20 48 8d 7b 24 48 89 fa 48 c1 ea
03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 69 44
[37093.800294] RSP: 0018:ffff88811629f2f0 EFLAGS: 00010203
[37093.800813] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
00000000fffffff4
[37093.801424] RDX: 0000000000000004 RSI: ffffffffa066dec0 RDI:
0000000000000024
[37093.802097] RBP: ffff888117844000 R08: 0000000000000001 R09:
ffffed1022c53df8
[37093.802780] R10: ffff88811629efc7 R11: 0000000046525442 R12:
00000000fffffff4
[37093.803382] R13: ffffffffa066dec0 R14: 0000000000000152 R15:
0000000000000000
[37093.804051] FS:  00007fa7379f5540(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[37093.804802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37093.805295] CR2: 00007fff44e90ff8 CR3: 000000010f33d001 CR4:
0000000000770ee0
[37093.805971] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[37093.806728] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[37093.807351] PKRU: 55555554
[37093.807639] Kernel panic - not syncing: Fatal exception
[37093.808876] Dumping ftrace buffer:
[37093.809128]    (ftrace buffer empty)
[37093.809377] Kernel Offset: disabled
[37093.809684] Rebooting in 1 seconds..


Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>


> +}
> +
> +static int test_remove_all(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info,
> +			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid,
> +					    cache->key.offset);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +static int test_remove_beginning(struct btrfs_trans_handle *trans,
> +				 struct btrfs_fs_info *fs_info,
> +				 struct btrfs_block_group_cache *cache,
> +				 struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid + BITMAP_RANGE,
> +			cache->key.offset - BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid, BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +
> +}
> +
> +static int test_remove_end(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info,
> +			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid, cache->key.offset - BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid +
> +					    cache->key.offset - BITMAP_RANGE,
> +					    BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +static int test_remove_middle(struct btrfs_trans_handle *trans,
> +			      struct btrfs_fs_info *fs_info,
> +			      struct btrfs_block_group_cache *cache,
> +			      struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid, BITMAP_RANGE},
> +		{cache->key.objectid + 2 * BITMAP_RANGE,
> +			cache->key.offset - 2 * BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid + BITMAP_RANGE,
> +					    BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +static int test_merge_left(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info,
> +			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid, 2 * BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid,
> +					    cache->key.offset);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid, BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +static int test_merge_right(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info,
> +			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid + BITMAP_RANGE, 2 * BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid,
> +					    cache->key.offset);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + 2 * BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +static int test_merge_both(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info,
> +			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid, 3 * BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid,
> +					    cache->key.offset);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid, BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + 2 * BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +static int test_merge_none(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info,
> +			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_path *path)
> +{
> +	struct free_space_extent extents[] = {
> +		{cache->key.objectid, BITMAP_RANGE},
> +		{cache->key.objectid + 2 * BITMAP_RANGE, BITMAP_RANGE},
> +		{cache->key.objectid + 4 * BITMAP_RANGE, BITMAP_RANGE},
> +	};
> +	int ret;
> +
> +	ret = __remove_from_free_space_tree(trans, fs_info, cache, path,
> +					    cache->key.objectid,
> +					    cache->key.offset);
> +	if (ret) {
> +		test_msg("Could not remove free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid, BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + 4 * BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	ret = __add_to_free_space_tree(trans, fs_info, cache, path,
> +				       cache->key.objectid + 2 * BITMAP_RANGE,
> +				       BITMAP_RANGE);
> +	if (ret) {
> +		test_msg("Could not add free space\n");
> +		return ret;
> +	}
> +
> +	return check_free_space_extents(trans, fs_info, cache, path,
> +					extents, ARRAY_SIZE(extents));
> +}
> +
> +typedef int (*test_func_t)(struct btrfs_trans_handle *,
> +			   struct btrfs_fs_info *,
> +			   struct btrfs_block_group_cache *,
> +			   struct btrfs_path *);
> +
> +static int run_test(test_func_t test_func, int bitmaps)
> +{
> +	struct btrfs_root *root = NULL;
> +	struct btrfs_block_group_cache *cache = NULL;
> +	struct btrfs_trans_handle trans;
> +	struct btrfs_path *path = NULL;
> +	int ret;
> +
> +	root = btrfs_alloc_dummy_root();
> +	if (IS_ERR(root)) {
> +		test_msg("Couldn't allocate dummy root\n");
> +		ret = PTR_ERR(root);
> +		goto out;
> +	}
> +
> +	root->fs_info = btrfs_alloc_dummy_fs_info();
> +	if (!root->fs_info) {
> +		test_msg("Couldn't allocate dummy fs info\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
> +					BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
> +	root->fs_info->free_space_root = root;
> +	root->fs_info->tree_root = root;
> +
> +	root->node = alloc_test_extent_buffer(root->fs_info, 4096);
> +	if (!root->node) {
> +		test_msg("Couldn't allocate dummy buffer\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	btrfs_set_header_level(root->node, 0);
> +	btrfs_set_header_nritems(root->node, 0);
> +	root->alloc_bytenr += 8192;
> +
> +	cache = btrfs_alloc_dummy_block_group(8 * BITMAP_RANGE);
> +	if (!cache) {
> +		test_msg("Couldn't allocate dummy block group cache\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	cache->bitmap_low_thresh = 0;
> +	cache->bitmap_high_thresh = (u32)-1;
> +	cache->needs_free_space = 1;
> +
> +	btrfs_init_dummy_trans(&trans);
> +
> +	path = btrfs_alloc_path();
> +	if (!path) {
> +		test_msg("Couldn't allocate path\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = add_block_group_free_space(&trans, root->fs_info, cache);
> +	if (ret) {
> +		test_msg("Could not add block group free space\n");
> +		goto out;
> +	}
> +
> +	if (bitmaps) {
> +		ret = convert_free_space_to_bitmaps(&trans, root->fs_info,
> +						    cache, path);
> +		if (ret) {
> +			test_msg("Could not convert block group to bitmaps\n");
> +			goto out;
> +		}
> +	}
> +
> +	ret = test_func(&trans, root->fs_info, cache, path);
> +	if (ret)
> +		goto out;
> +
> +	ret = remove_block_group_free_space(&trans, root->fs_info, cache);
> +	if (ret) {
> +		test_msg("Could not remove block group free space\n");
> +		goto out;
> +	}
> +
> +	if (btrfs_header_nritems(root->node) != 0) {
> +		test_msg("Free space tree has leftover items\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = 0;
> +out:
> +	btrfs_free_path(path);
> +	btrfs_free_dummy_block_group(cache);
> +	btrfs_free_dummy_root(root);
> +	return ret;
> +}
> +
> +static int run_test_both_formats(test_func_t test_func)
> +{
> +	int ret;
> +
> +	ret = run_test(test_func, 0);
> +	if (ret)
> +		return ret;
> +	return run_test(test_func, 1);
> +}
> +
> +int btrfs_test_free_space_tree(void)
> +{
> +	test_func_t tests[] = {
> +		test_empty_block_group,
> +		test_remove_all,
> +		test_remove_beginning,
> +		test_remove_end,
> +		test_remove_middle,
> +		test_merge_left,
> +		test_merge_right,
> +		test_merge_both,
> +		test_merge_none,
> +	};
> +	int i;
> +
> +	test_msg("Running free space tree tests\n");
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		int ret = run_test_both_formats(tests[i]);
> +		if (ret) {
> +			test_msg("%pf failed\n", tests[i]);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
> index 846d277b1901..8ea5d34bc5a2 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -23,14 +23,6 @@
>  #include "../qgroup.h"
>  #include "../backref.h"
>  
> -static void init_dummy_trans(struct btrfs_trans_handle *trans)
> -{
> -	memset(trans, 0, sizeof(*trans));
> -	trans->transid = 1;
> -	INIT_LIST_HEAD(&trans->qgroup_ref_list);
> -	trans->type = __TRANS_DUMMY;
> -}
> -
>  static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
>  				  u64 num_bytes, u64 parent, u64 root_objectid)
>  {
> @@ -44,7 +36,7 @@ static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
>  	u32 size = sizeof(*item) + sizeof(*iref) + sizeof(*block_info);
>  	int ret;
>  
> -	init_dummy_trans(&trans);
> +	btrfs_init_dummy_trans(&trans);
>  
>  	ins.objectid = bytenr;
>  	ins.type = BTRFS_EXTENT_ITEM_KEY;
> @@ -94,7 +86,7 @@ static int add_tree_ref(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
>  	u64 refs;
>  	int ret;
>  
> -	init_dummy_trans(&trans);
> +	btrfs_init_dummy_trans(&trans);
>  
>  	key.objectid = bytenr;
>  	key.type = BTRFS_EXTENT_ITEM_KEY;
> @@ -144,7 +136,7 @@ static int remove_extent_item(struct btrfs_root *root, u64 bytenr,
>  	struct btrfs_path *path;
>  	int ret;
>  
> -	init_dummy_trans(&trans);
> +	btrfs_init_dummy_trans(&trans);
>  
>  	key.objectid = bytenr;
>  	key.type = BTRFS_EXTENT_ITEM_KEY;
> @@ -178,7 +170,7 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
>  	u64 refs;
>  	int ret;
>  
> -	init_dummy_trans(&trans);
> +	btrfs_init_dummy_trans(&trans);
>  
>  	key.objectid = bytenr;
>  	key.type = BTRFS_EXTENT_ITEM_KEY;
> @@ -232,7 +224,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root)
>  	struct ulist *new_roots = NULL;
>  	int ret;
>  
> -	init_dummy_trans(&trans);
> +	btrfs_init_dummy_trans(&trans);
>  
>  	test_msg("Qgroup basic add\n");
>  	ret = btrfs_create_qgroup(NULL, fs_info, 5);
> @@ -326,7 +318,7 @@ static int test_multiple_refs(struct btrfs_root *root)
>  	struct ulist *new_roots = NULL;
>  	int ret;
>  
> -	init_dummy_trans(&trans);
> +	btrfs_init_dummy_trans(&trans);
>  
>  	test_msg("Qgroup multiple refs test\n");
>  
