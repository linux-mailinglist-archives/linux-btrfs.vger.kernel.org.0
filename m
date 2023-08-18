Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D96780A70
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376395AbjHRKsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376407AbjHRKrl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 06:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A0273C
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 03:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72D7F63ED3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 10:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84735C433C7;
        Fri, 18 Aug 2023 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692355658;
        bh=XVMPaWpCzVzj/4tA3EFuS4HDlTmBJXWXcFNBEzgNjks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtbQdHDuzvznTKhujiDLplQLcbnanMvmk0uDMtZIYyu89za2MiumtCI3VNOOGgTYc
         J0bCRupb030irzVYcrJJwqCMaqtHelCTiikesCR6iglNJCDdxB+gtAbDvTk3zBPohp
         TvlfHvkzX+piKwjKrpgzB+co/Da5areQz/t4MIQFtPwxuSZpILk6gfo9wpUtpjsukQ
         cXf1GlmKHEeQ+zNuikk0xjlw2qjSW3RQK1qSvgQ0pqPyEC7rqbEep/L6P5FgHppMrV
         pak1HwlOzLbHt2NpC8973Mnf81SnC8cyW/V0Tk/4Wppom6o/P+7xUlmqTCe7qCbosb
         WZxK7mm3gXHqQ==
Date:   Fri, 18 Aug 2023 11:47:35 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/4] btrfs: add extent_map tests for dropping with odd
 layouts
Message-ID: <ZN9MR3RHDtT59lMr@debian0.Home>
References: <cover.1692305624.git.josef@toxicpanda.com>
 <bfdfeb73fec4d1352992fb9d6027eaabe9723d6d.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdfeb73fec4d1352992fb9d6027eaabe9723d6d.1692305624.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 04:57:31PM -0400, Josef Bacik wrote:
> While investigating weird problems with the extent_map I wrote a self
> test testing the various edge cases of btrfs_drop_extent_map_range.
> This can split in different ways and behaves different in each case, so
> test the various edge cases to make sure everything is functioning
> properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, just some minor comment below.

> ---
>  fs/btrfs/tests/extent-map-tests.c | 219 ++++++++++++++++++++++++++++++
>  1 file changed, 219 insertions(+)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index ed0f36ae5346..d5f5e48ab55c 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  #include "btrfs-tests.h"
>  #include "../ctree.h"
> +#include "../btrfs_inode.h"
>  #include "../volumes.h"
>  #include "../disk-io.h"
>  #include "../block-group.h"
> @@ -442,6 +443,219 @@ static int test_case_4(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +static int add_compressed_extent(struct extent_map_tree *em_tree,
> +				 const u64 start, const u64 len,
> +				 const u64 block_start)
> +{
> +	struct extent_map *em;
> +	int ret;
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		return -ENOMEM;
> +	}
> +
> +	em->start = start;
> +	em->len = len;
> +	em->block_start = block_start;
> +	em->block_len = SZ_4K;
> +	set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
> +	write_lock(&em_tree->lock);
> +	ret = add_extent_mapping(em_tree, em, 0);
> +	write_unlock(&em_tree->lock);
> +	free_extent_map(em);
> +	if (ret < 0) {
> +		test_err("cannot add extent map [%llu, %llu)", start,
> +			 start + len);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct extent_range {
> +	u64 start;
> +	u64 len;
> +};
> +
> +/* The valid states of the tree after every drop, as described below. */
> +struct extent_range valid_ranges[][7] = {
> +	{
> +	  { .start = 0,			.len = SZ_8K },		/* [0, 8K) */
> +	  { .start = SZ_4K * 3,		.len = SZ_4K * 3},	/* [12k, 24k) */
> +	  { .start = SZ_4K * 6,		.len = SZ_4K * 3},	/* [24k, 36k) */
> +	  { .start = SZ_32K + SZ_4K,	.len = SZ_4K},		/* [36k, 40k) */
> +	  { .start = SZ_4K * 10,	.len = SZ_4K * 6},	/* [40k, 64k) */
> +	},
> +	{
> +	  { .start = 0,			.len = SZ_8K },		/* [0, 8K) */
> +	  { .start = SZ_4K * 5,		.len = SZ_4K},		/* [20k, 24k) */
> +	  { .start = SZ_4K * 6,		.len = SZ_4K * 3},	/* [24k, 36k) */
> +	  { .start = SZ_32K + SZ_4K,	.len = SZ_4K},		/* [36k, 40k) */
> +	  { .start = SZ_4K * 10,	.len = SZ_4K * 6},	/* [40k, 64k) */
> +	},
> +	{
> +	  { .start = 0,			.len = SZ_8K },		/* [0, 8K) */
> +	  { .start = SZ_4K * 5,		.len = SZ_4K},		/* [20k, 24k) */
> +	  { .start = SZ_4K * 6,		.len = SZ_4K},		/* [24k, 28k) */
> +	  { .start = SZ_32K,		.len = SZ_4K},		/* [32k, 36k) */
> +	  { .start = SZ_32K + SZ_4K,	.len = SZ_4K},		/* [36k, 40k) */
> +	  { .start = SZ_4K * 10,	.len = SZ_4K * 6},	/* [40k, 64k) */
> +	},
> +	{
> +	  { .start = 0,			.len = SZ_8K},		/* [0, 8K) */
> +	  { .start = SZ_4K * 5,		.len = SZ_4K},		/* [20k, 24k) */
> +	  { .start = SZ_4K * 6,		.len = SZ_4K},		/* [24k, 28k) */
> +	}
> +};
> +
> +static int validate_range(struct extent_map_tree *em_tree, int index)
> +{
> +	struct rb_node *n;
> +	int i;
> +
> +	for (i = 0, n = rb_first_cached(&em_tree->map);
> +	     valid_ranges[index][i].len && n; i++, n = rb_next(n)) {
> +		struct extent_map *entry = rb_entry(n, struct extent_map, rb_node);
> +
> +		if (entry->start != valid_ranges[index][i].start) {
> +			test_err("mapping has start %llu expected %llu",
> +				 entry->start, valid_ranges[index][i].start);
> +			return -EINVAL;
> +		}
> +
> +		if (entry->len != valid_ranges[index][i].len) {
> +			test_err("mapping has len %llu expected %llu",
> +				 entry->len, valid_ranges[index][i].len);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * We exited because we don't have any more entries in the extent_map
> +	 * but we still expect more valid entries.
> +	 */
> +	if (valid_ranges[index][i].len) {
> +		test_err("missing an entry");
> +		return -EINVAL;
> +	}
> +
> +	/* We exited the loop but still have entries in the extent map. */
> +	if (n) {
> +		test_err("we have a left over entry in the extent map we didn't expect");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Test scenario:
> + *
> + * Test the various edge cases of btrfs_drop_extent_map_range, create the
> + * following ranges
> + *
> + * [0, 12k)[12k, 24k)[24k, 36k)[36k, 40k)[40k,64k)
> + *
> + * And then we'll drop:
> + *
> + * [8k, 12k) - test the single front split
> + * [12k, 20k) - test the single back split
> + * [28k, 32k) - test the double split
> + * [32k, 64k) - test whole em dropping
> + *
> + * They'll have the EXTENT_FLAG_COMPRESSED flag set to keep the em tree from
> + * merging the em's.
> + */
> +static int test_case_5(void)
> +{
> +	struct extent_map_tree *em_tree;
> +	struct inode *inode = NULL;

This initialization is not needed.

> +	u64 start, end;
> +	int ret;
> +
> +	test_msg("Running btrfs_drop_extent_map_range tests");
> +
> +	inode = btrfs_new_test_inode();
> +	if (!inode) {
> +		test_std_err(TEST_ALLOC_INODE);
> +		return -ENOMEM;
> +	}
> +
> +	em_tree = &BTRFS_I(inode)->extent_tree;
> +
> +	/* [0, 12k) */
> +	ret = add_compressed_extent(em_tree, 0, SZ_4K * 3, 0);
> +	if (ret) {
> +		test_err("cannot add extent range [0, 12K)");
> +		goto out;
> +	}
> +
> +	/* [12k, 24k) */
> +	ret = add_compressed_extent(em_tree, SZ_4K * 3, SZ_4K * 3, SZ_4K);
> +	if (ret) {
> +		test_err("cannot add extent range [12k, 24k)");
> +		goto out;
> +	}
> +
> +	/* [24k, 36k) */
> +	ret = add_compressed_extent(em_tree, SZ_4K * 6, SZ_4K * 3, SZ_8K);
> +	if (ret) {
> +		test_err("cannot add extent range [12k, 24k)");
> +		goto out;
> +	}
> +
> +	/* [36k, 40k) */
> +	ret = add_compressed_extent(em_tree, SZ_32K + SZ_4K, SZ_4K, SZ_4K * 3);
> +	if (ret) {
> +		test_err("cannot add extent range [12k, 24k)");
> +		goto out;
> +	}
> +
> +	/* [40k, 64k) */
> +	ret = add_compressed_extent(em_tree, SZ_4K * 10, SZ_4K * 6, SZ_16K);
> +	if (ret) {
> +		test_err("cannot add extent range [12k, 24k)");
> +		goto out;
> +	}
> +
> +	/* Drop [8k, 12k) */
> +	start = SZ_8K;
> +	end = (3 * SZ_4K) - 1;
> +	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
> +	ret = validate_range(&BTRFS_I(inode)->extent_tree, 0);
> +	if (ret)
> +		goto out;
> +
> +	/* Drop [12k, 20k) */
> +	start = SZ_4K * 3;
> +	end = SZ_16K + SZ_4K - 1;
> +	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
> +	ret = validate_range(&BTRFS_I(inode)->extent_tree, 1);
> +	if (ret)
> +		goto out;
> +
> +	/* Drop [28k, 32k) */
> +	start = SZ_32K - SZ_4K;
> +	end = SZ_32K - 1;
> +	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
> +	ret = validate_range(&BTRFS_I(inode)->extent_tree, 2);
> +	if (ret)
> +		goto out;
> +
> +	/* Drop [32k, 64k) */
> +	start = SZ_32K;
> +	end = SZ_64K - 1;
> +	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
> +	ret = validate_range(&BTRFS_I(inode)->extent_tree, 3);
> +	if (ret)
> +		goto out;
> +out:
> +	iput(inode);
> +	return ret;
> +}
> +
>  struct rmap_test_vector {
>  	u64 raid_type;
>  	u64 physical_start;
> @@ -619,6 +833,11 @@ int btrfs_test_extent_map(void)
>  	if (ret)
>  		goto out;
>  	ret = test_case_4(fs_info, em_tree);
> +	if (ret)
> +		goto out;
> +	ret = test_case_5();
> +	if (ret)
> +		goto out;
>  
>  	test_msg("running rmap tests");
>  	for (i = 0; i < ARRAY_SIZE(rmap_tests); i++) {
> -- 
> 2.26.3
> 
