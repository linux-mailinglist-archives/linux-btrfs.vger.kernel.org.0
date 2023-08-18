Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739B780A75
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376426AbjHRKsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376459AbjHRKs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 06:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895B2713
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 03:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9E163ED3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 10:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D993C433C8;
        Fri, 18 Aug 2023 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692355705;
        bh=7mnij2Q3ziEePpkt1WNdw6n0y789ZfJ+tM9RevcyeTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WX0sDyJGcVLUYw3PYl/ENgtWcSOMiIxk/tg9AuUw8in5Dt86/eOmB4g5DSPBIl8aB
         CYU4SfsGunDPDrOeOJwqxWHOrIF6wRJCisSukILFZfzQtv5PKmY7oaVAhVPctrNt9o
         h2qDLYO6lcIa9CO7NmJaaZgwg5o269mWoVduGvALm18hz/fVXyMi4YizbOJWkD/oSJ
         qAKlLyOnThzyS89x7lBlkDilI8LQkXMJe0+8QDDyx/qkT+UhoqYuHV3ES5wu87LTyr
         VEORhid1wpzbyWgo3uLQsev3AGII0yrJVi5RDLYeMZROKe4tAkVzD+3depBH4dgX4r
         vzgSR0LNMak4w==
Date:   Fri, 18 Aug 2023 11:48:22 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] btrfs: add a self test for btrfs_add_extent_mapping
Message-ID: <ZN9MdmLm1zontM57@debian0.Home>
References: <cover.1692305624.git.josef@toxicpanda.com>
 <cc5a97b95855d170aecb76ae358c6dfc08e47559.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc5a97b95855d170aecb76ae358c6dfc08e47559.1692305624.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 04:57:32PM -0400, Josef Bacik wrote:
> This helper is different from the normal add_extent_mapping in that it
> will stuff an em into a gap that exists between overlapping em's in the
> tree.  It appeared there was a bug so I wrote a self test to validate it
> did the correct thing when it worked with two side by side ems.
> Thankfully it is correct, but more testing is better.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tests/extent-map-tests.c | 57 +++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index d5f5e48ab55c..18ab03f0d029 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -656,6 +656,60 @@ static int test_case_5(void)
>  	return ret;
>  }
>  
> +/*
> + * Test the btrfs_add_extent_mapping helper which will attempt to create an em
> + * for areas between two existing ems.  Validate it doesn't do this when there
> + * are two unmerged em's side by side.
> + */
> +static int test_case_6(struct btrfs_fs_info *fs_info,
> +		       struct extent_map_tree *em_tree)
> +{
> +	struct extent_map *em = NULL;
> +	int ret;
> +
> +	ret = add_compressed_extent(em_tree, 0, SZ_4K, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_compressed_extent(em_tree, SZ_4K, SZ_4K, 0);
> +	if (ret)
> +		goto out;
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		return -ENOMEM;
> +	}
> +
> +	em->start = SZ_4K;
> +	em->len = SZ_4K;
> +	em->block_start = SZ_16K;
> +	em->block_len = SZ_16K;
> +	write_lock(&em_tree->lock);
> +	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, 0, SZ_8K);
> +	write_unlock(&em_tree->lock);
> +
> +	if (ret != 0) {
> +		test_err("got an error when adding our em: %d", ret);
> +		goto out;
> +	}
> +
> +	ret = -EINVAL;
> +	if (em->start != 0) {
> +		test_err("unexpected em->start at %llu, wanted 0", em->start);
> +		goto out;
> +	}
> +	if (em->len != SZ_4K) {
> +		test_err("unexpected em->len %llu, expected 4K", em->len);
> +		goto out;
> +	}
> +	ret = 0;
> +out:
> +	free_extent_map(em);
> +	free_extent_map_tree(em_tree);
> +	return ret;
> +}
> +
>  struct rmap_test_vector {
>  	u64 raid_type;
>  	u64 physical_start;
> @@ -836,6 +890,9 @@ int btrfs_test_extent_map(void)
>  	if (ret)
>  		goto out;
>  	ret = test_case_5();
> +	if (ret)
> +		goto out;
> +	ret = test_case_6(fs_info, em_tree);
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.26.3
> 
