Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06E76CF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfGZP2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 11:28:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387941AbfGZP2v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 11:28:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36BECAE42
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 15:28:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3004DA811; Fri, 26 Jul 2019 17:29:25 +0200 (CEST)
Date:   Fri, 26 Jul 2019 17:29:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: tree-checker: Add ROOT_ITEM check
Message-ID: <20190726152925.GG2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190716090034.11641-1-wqu@suse.com>
 <20190716090034.11641-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716090034.11641-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 05:00:34PM +0800, Qu Wenruo wrote:
> This patch will introduce ROOT_ITEM check, which includes:
> - Key->objectid and key->offset check
>   Currently only some easy check, e.g. 0 as rootid is invalid.
> 
> - Item size check
>   Root item size is fixed.
> 
> - Generation checks
>   Generation, v2_generaetion and last_snapshot should not pass super
>   generation + 1
> 
> - Level and alignment check
>   Level should be in [0, 7], and bytenr must be aligned to sector size.
> 
> - Flags check

Nice. I found some small things that I can fix, no need to resend.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203261
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 92 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a4c7f7ed8490..71bbbce3076d 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -810,6 +810,95 @@ static int check_inode_item(struct extent_buffer *leaf,
>  	return 0;
>  }
>  
> +static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
> +			   int slot)
> +{
> +	struct btrfs_fs_info *fs_info = leaf->fs_info;
> +	struct btrfs_root_item ri;
> +	u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
> +			       BTRFS_ROOT_SUBVOL_DEAD;

You can use 'const' here.

> +
> +	/* No Such Tree id*/
> +	if (key->objectid == 0) {
> +		generic_err(leaf, slot, "invalid root id 0");
> +		return -EUCLEAN;
> +	}
> +
> +	/*
> +	 * Some older kernel may create ROOT_ITEM with non-zero offset,
> +	 * so here we only check offset for reloc tree whose key->offset
> +	 * must be a valid tree.
> +	 */
> +	if (key->objectid == BTRFS_TREE_RELOC_OBJECTID && key->offset == 0) {
> +		generic_err(leaf, slot, "invalid root id 0 for reloc tree");
> +		return -EUCLEAN;
> +	}
> +
> +	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri)) {
> +		generic_err(leaf, slot,
> +			"invalid root item size, have %u expect %lu",
> +			    btrfs_item_size_nr(leaf, slot), sizeof(ri));

sizeof needs %zu

> +	}
> +
> +	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
> +			   sizeof(ri));
> +
> +	/* Generateion related */

typo here and a few more times below

> +	if (btrfs_root_generation(&ri) >
> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
> +		generic_err(leaf, slot,
> +			"invalid root generaetion, have %llu expect (0, %llu]",
> +			    btrfs_root_generation(&ri),
> +			    btrfs_super_generation(fs_info->super_copy) + 1);
> +		return -EUCLEAN;
> +	}
> +	if (btrfs_root_generation_v2(&ri) >
> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
> +		generic_err(leaf, slot,
> +		"invalid root v2 generaetion, have %llu expect (0, %llu]",

So (0, %llu] here means that it must be greater than zero, right? I'm
not sure that everyone uses the same notation for open/closed notation.

> +			    btrfs_root_generation_v2(&ri),
> +			    btrfs_super_generation(fs_info->super_copy) + 1);
> +		return -EUCLEAN;
> +	}
> +	if (btrfs_root_last_snapshot(&ri) >
> +	    btrfs_super_generation(fs_info->super_copy) + 1) {
> +		generic_err(leaf, slot,
> +		"invalid root last_snapshot, have %llu expect (0, %llu]",
> +			    btrfs_root_last_snapshot(&ri),
> +			    btrfs_super_generation(fs_info->super_copy) + 1);
> +		return -EUCLEAN;
> +	}
> +
> +	/* Alignment and level check */
> +	if (!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize)) {
> +		generic_err(leaf, slot,
> +			"invalid root bytenr, have %llu expect to be aligned to %u",
> +			    btrfs_root_bytenr(&ri), fs_info->sectorsize);
> +		return -EUCLEAN;
> +	}
> +	if (btrfs_root_level(&ri) >= BTRFS_MAX_LEVEL) {
> +		generic_err(leaf, slot,
> +			"invalid root level, have %u expect [0, %u]",
> +			    btrfs_root_level(&ri), BTRFS_MAX_LEVEL - 1);
> +		return -EUCLEAN;
> +	}
> +	if (ri.drop_level >= BTRFS_MAX_LEVEL) {
> +		generic_err(leaf, slot,
> +			"invalid root level, have %u expect [0, %u]",
> +			    ri.drop_level, BTRFS_MAX_LEVEL - 1);
> +		return -EUCLEAN;
> +	}
> +
> +	/* Flags check */
> +	if (btrfs_root_flags(&ri) & ~valid_root_flags) {
> +		generic_err(leaf, slot,
> +			"invalid root flags, have 0x%llx expect mask 0x%llu",

                                                                     0x%llx

> +			    btrfs_root_flags(&ri), valid_root_flags);
> +		return -EUCLEAN;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Common point to switch the item-specific validation.
>   */
> @@ -845,6 +934,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
>  	case BTRFS_INODE_ITEM_KEY:
>  		ret = check_inode_item(leaf, key, slot);
>  		break;
> +	case BTRFS_ROOT_ITEM_KEY:
> +		ret = check_root_item(leaf, key, slot);
> +		break;
>  	}
>  	return ret;
>  }
> -- 
> 2.22.0
