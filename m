Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B122310A1B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKZQEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:04:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727418AbfKZQEr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:04:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6511169B6A;
        Tue, 26 Nov 2019 16:04:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF42ADA898; Tue, 26 Nov 2019 17:04:39 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:04:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: Add self-tests for btrfs_rmap_block
Message-ID: <20191126160439.GI2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191119120555.6465-1-nborisov@suse.com>
 <20191119120555.6465-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119120555.6465-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 02:05:52PM +0200, Nikolay Borisov wrote:
> This is enough to exercise out of boundary address exclusion as well as
> address matching.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/tests/extent-map-tests.c | 128 +++++++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index 4a7f796c9900..e6a6417e87d2 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -6,6 +6,12 @@
>  #include <linux/types.h>
>  #include "btrfs-tests.h"
>  #include "../ctree.h"
> +#include "../volumes.h"
> +#include "../disk-io.h"
> +
> +extern int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
> +                            u64 physical, u64 **logical, int *naddrs,
> +                            int *stripe_len);
>  
>  static void free_extent_map_tree(struct extent_map_tree *em_tree)
>  {
> @@ -437,11 +443,125 @@ static int test_case_4(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +struct rmap_test_vector {
> +	u64 raid_type;
> +	u64 physical_start;
> +	u64 data_stripe_size;
> +	u64 num_data_stripes;
> +	u64 num_stripes;
> +	u64 data_stripe_phys_start[5]; /* Hacky, but convenient */

Please put the comment on own line and explain what is hacky here.

> +	int expected_mapped_addr; /* number of expected mapped addresses */
> +	u64 mapped_logical[5]; /* mapped addresses */

The comments do not say more than the names, they should be dropped or
expanded.

> +};
> +
> +static int test_rmap_block(struct btrfs_fs_info *fs_info,
> +			   struct rmap_test_vector *test)
> +{
> +	struct extent_map *em;
> +	struct map_lookup *map = NULL;
> +	u64 *logical;
> +	int i, out_ndaddrs, out_stripe_len;
> +	int ret = -EINVAL;
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		return -ENOMEM;
> +	}
> +
> +	map = kmalloc(map_lookup_size(test->num_stripes), GFP_KERNEL);
> +	if (!map) {
> +		kfree(em);
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		return -ENOMEM;
> +	}
> +
> +	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
> +	em->start = SZ_4G; /* Start at 4gb logical address */

Please avoid the in-line comments.

> +	em->len = test->data_stripe_size * test->num_data_stripes;
> +	em->block_len = em->len;
> +	em->orig_block_len = test->data_stripe_size;
> +	em->map_lookup = map;
> +
> +	map->num_stripes = test->num_stripes;
> +	map->stripe_len = BTRFS_STRIPE_LEN;
> +	map->type = test->raid_type;
> +
> +	for (i = 0; i < map->num_stripes; i++)
> +	{
> +		struct btrfs_device *dev = btrfs_alloc_dummy_device(fs_info);
> +		if (!dev)
> +			BUG();

No way to handle the error?

> +		map->stripes[i].dev = dev;
> +		map->stripes[i].physical = test->data_stripe_phys_start[i];
> +	}
> +
> +	write_lock(&fs_info->mapping_tree.lock);
> +	ret = add_extent_mapping(&fs_info->mapping_tree, em, 0);
> +	write_unlock(&fs_info->mapping_tree.lock);
> +	if (ret) {
> +		test_err("Error adding block group mapping to mapping tree");
> +	}

No need for { }, no capital letter at the beginnin of the string.

> +
> +	ret = btrfs_rmap_block(fs_info, em->start, btrfs_sb_offset(1),
> +			       &logical, &out_ndaddrs, &out_stripe_len);
> +	if (ret || (out_ndaddrs == 0 && test->expected_mapped_addr)) {
> +		test_err("Didn't rmap anything");

That's a good example of a useless error message

> +		goto out;
> +	}
> +
> +	if (out_stripe_len != BTRFS_STRIPE_LEN) {
> +		test_err("Calculated stripe len doesn't match");
> +		goto out;
> +	}
> +
> +	if (out_ndaddrs != test->expected_mapped_addr) {
> +		for (i = 0; i < out_ndaddrs; i++)
> +			test_msg("Mapped %llu", logical[i]);
> +		test_err("Unexpected number of mapped addresses: %d\n", out_ndaddrs);

No "\n"

> +		goto out;
> +	}
> +
> +	for (i = 0; i < out_ndaddrs; i++) {
> +		if (logical[i] != test->mapped_logical[i]) {
> +			test_err("Unexpected logical address mapped");
> +			goto out;
> +		}
> +	}
> +
> +	ret = 0;
> +out:
> +	write_lock(&fs_info->mapping_tree.lock);
> +	remove_extent_mapping(&fs_info->mapping_tree, em);
> +	write_unlock(&fs_info->mapping_tree.lock);
> +	/* For us */
> +	free_extent_map(em);
> +	/* For the tree */
> +	free_extent_map(em);
> +	return ret;
> +}
> +
>  int btrfs_test_extent_map(void)
>  {
>  	struct btrfs_fs_info *fs_info = NULL;
>  	struct extent_map_tree *em_tree;
> -	int ret = 0;
> +	int ret = 0, i;
> +	struct rmap_test_vector rmap_tests[] = {
> +		{
> +			/* Tests a chunk with 2 data stripes one of which
> +			 * interesects the physical address of the super block
> +			 * is correctly recognised.
> +			 */

Comment style from net/

> +			BTRFS_BLOCK_GROUP_RAID1, SZ_64M - SZ_4M, SZ_256M, 2, 2,
> +			{SZ_64M - SZ_4M, SZ_64M - SZ_4M + SZ_256M}, 1,
> +			{SZ_4G + SZ_4M}
> +		},
> +		{
> +			/* test that out of range physical addresses are ignored */
> +			0 /* SINGLE chunk type */, SZ_4G, SZ_256M, 1, 1,
> +			{SZ_256M}, 0, {0}
> +		}

Looking at the number of values it's hard to say what's being
initialized, please convert it to the designated initializers.

> +	};
>  
>  	test_msg("running extent_map tests");
>  
> @@ -474,6 +594,12 @@ int btrfs_test_extent_map(void)
>  		goto out;
>  	ret = test_case_4(fs_info, em_tree);

Maybe put a test_msg("running rmap tests") here so it's clear that any
following error message belongs to rmap anot not just extent_map tests.

>  
> +	for (i = 0; i < ARRAY_SIZE(rmap_tests); i++) {
> +		ret = test_rmap_block(fs_info, &rmap_tests[i]);
> +		if (ret)
> +			goto out;
> +	}
> +
>  out:
>  	kfree(em_tree);
>  	btrfs_free_dummy_fs_info(fs_info);
