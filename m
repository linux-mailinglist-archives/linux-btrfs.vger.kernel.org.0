Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E53780A78
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358883AbjHRKtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 06:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbjHRKtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 06:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD73589
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 03:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C79632A4
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 10:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075ADC433C7;
        Fri, 18 Aug 2023 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692355758;
        bh=5jTGUs4CJMrBBTO6ykLfeYTZJPqx8DF7rhKFYkLReUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGiZaT2ozWb9xP/ZCq/jhP3r/o1ZJZLe0giHPJQMhF/yHHoPJ4gP4wbNZBs36yaqX
         H0uBiJ2sromQgN7FENtby3/JEVUVNhfDpAORUanEJRWqr6ARGnxUZejQ6AbX2glIA9
         5oJCe6spIWTECQfgz9Ak2K/z1KkXHFqmGGJ1c5ZJ9NdQKxydYAzVPuWXp2CI6AEcwn
         Rfrh0FoA+TJ5hgvz5dFp1OIDelv2xuJPNYQNmISu9MeJUKczZCmJXGCjXykJWH03wN
         QiaqXjsYzzI5icwxPdHQjKWcLE1NGwquYLt80JN36ucH/V+zNPkDocZdKJk+BbpHMi
         JNinHdbt4Qpsg==
Date:   Fri, 18 Aug 2023 11:49:15 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] btrfs: test invalid splitting when skipping pinned
 drop extent_map
Message-ID: <ZN9Mq5VDREK0rO1C@debian0.Home>
References: <cover.1692305624.git.josef@toxicpanda.com>
 <cb4e2f77d7ab9670223ca0d76594abb93bb1c32d.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4e2f77d7ab9670223ca0d76594abb93bb1c32d.1692305624.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 04:57:33PM -0400, Josef Bacik wrote:
> This reproduces the bug fixed by "btrfs: fix incorrect splitting in
> btrfs_drop_extent_map_range", we were improperly calculating the range
> for the split extent.  Add a test that exercises this scenario and
> validates that we get the correct resulting extent_maps in our tree.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, just a minor comment below.

> ---
>  fs/btrfs/tests/extent-map-tests.c | 138 ++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index 18ab03f0d029..06820a8b4d1f 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -710,6 +710,141 @@ static int test_case_6(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +/*
> + * Regression test for btrfs_drop_extent_map_range.  Calling with skip_pinned ==
> + * true would mess up the start/end calculations and subsequent splits would be
> + * incorrect.
> + */
> +static int test_case_7(void)
> +{
> +	struct extent_map_tree *em_tree;
> +	struct extent_map *em = NULL;
> +	struct inode *inode = NULL;

These two initializations to NULL are not needed.

> +	int ret;
> +
> +	test_msg("Running btrfs_drop_extent_cache with pinned");
> +
> +	inode = btrfs_new_test_inode();
> +	if (!inode) {
> +		test_std_err(TEST_ALLOC_INODE);
> +		return -ENOMEM;
> +	}
> +
> +	em_tree = &BTRFS_I(inode)->extent_tree;
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* [0, 16K), pinned */
> +	em->start = 0;
> +	em->len = SZ_16K;
> +	em->block_start = 0;
> +	em->block_len = SZ_4K;
> +	set_bit(EXTENT_FLAG_PINNED, &em->flags);
> +	write_lock(&em_tree->lock);
> +	ret = add_extent_mapping(em_tree, em, 0);
> +	write_unlock(&em_tree->lock);
> +	if (ret < 0) {
> +		test_err("couldn't add extent map");
> +		goto out;
> +	}
> +	free_extent_map(em);
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* [32K, 48K), not pinned */
> +	em->start = SZ_32K;
> +	em->len = SZ_16K;
> +	em->block_start = SZ_32K;
> +	em->block_len = SZ_16K;
> +	write_lock(&em_tree->lock);
> +	ret = add_extent_mapping(em_tree, em, 0);
> +	write_unlock(&em_tree->lock);
> +	if (ret < 0) {
> +		test_err("couldn't add extent map");
> +		goto out;
> +	}
> +	free_extent_map(em);
> +
> +	/*
> +	 * Drop [0, 36K) This should skip the [0, 4K) extent and then split the
> +	 * [32K, 48K) extent.
> +	 */
> +	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (36 * SZ_1K) - 1, true);
> +
> +	/* Make sure our extent maps look sane. */
> +	ret = -EINVAL;
> +
> +	em = lookup_extent_mapping(em_tree, 0, SZ_16K);
> +	if (!em) {
> +		test_err("didn't find an em at 0 as expected");
> +		goto out;
> +	}
> +
> +	if (em->start != 0) {
> +		test_err("em->start is %llu, expected 0", em->start);
> +		goto out;
> +	}
> +
> +	if (em->len != SZ_16K) {
> +		test_err("em->len is %llu, expected 16K", em->len);
> +		goto out;
> +	}
> +
> +	free_extent_map(em);
> +
> +	read_lock(&em_tree->lock);
> +	em = lookup_extent_mapping(em_tree, SZ_16K, SZ_16K);
> +	read_unlock(&em_tree->lock);
> +	if (em) {
> +		test_err("found an em when we weren't expecting one");
> +		goto out;
> +	}
> +
> +	read_lock(&em_tree->lock);
> +	em = lookup_extent_mapping(em_tree, SZ_32K, SZ_16K);
> +	read_unlock(&em_tree->lock);
> +	if (!em) {
> +		test_err("didn't find an em at 32K as expected");
> +		goto out;
> +	}
> +
> +	if (em->start != (36 * SZ_1K)) {
> +		test_err("em->start is %llu, expected 36K", em->start);
> +		goto out;
> +	}
> +
> +	if (em->len != (12 * SZ_1K)) {
> +		test_err("em->len is %llu, expected 12K", em->len);
> +		goto out;
> +	}
> +
> +	free_extent_map(em);
> +
> +	read_lock(&em_tree->lock);
> +	em = lookup_extent_mapping(em_tree, 48 * SZ_1K, (u64)-1);
> +	read_unlock(&em_tree->lock);
> +	if (em) {
> +		test_err("found an unexpected em above 48K");
> +		goto out;
> +	}
> +
> +	ret = 0;
> +out:
> +	free_extent_map(em);
> +	iput(inode);
> +	return ret;
> +}
> +
>  struct rmap_test_vector {
>  	u64 raid_type;
>  	u64 physical_start;
> @@ -893,6 +1028,9 @@ int btrfs_test_extent_map(void)
>  	if (ret)
>  		goto out;
>  	ret = test_case_6(fs_info, em_tree);
> +	if (ret)
> +		goto out;
> +	ret = test_case_7();
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.26.3
> 
