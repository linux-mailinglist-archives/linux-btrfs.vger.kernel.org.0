Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8999788
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 16:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfHVO64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 10:58:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388968AbfHVO64 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 10:58:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F416EAC8E
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 14:58:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB85CDA791; Thu, 22 Aug 2019 16:59:17 +0200 (CEST)
Date:   Thu, 22 Aug 2019 16:59:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.2 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
Message-ID: <20190822145916.GH2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190809012424.11420-1-wqu@suse.com>
 <20190809012424.11420-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809012424.11420-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 09, 2019 at 09:24:22AM +0800, Qu Wenruo wrote:
> +static int check_extent_item(struct extent_buffer *leaf,
> +			     struct btrfs_key *key, int slot)
> +{
> +	struct btrfs_fs_info *fs_info = leaf->fs_info;
> +	struct btrfs_extent_item *ei;
> +	bool is_tree_block = false;
> +	unsigned long ptr;	/* Current pointer inside inline refs */
> +	unsigned long end;	/* Extent item end */
> +	u32 item_size = btrfs_item_size_nr(leaf, slot);
> +	u64 flags;
> +	u64 generation;
> +	u64 total_refs;		/* Total refs in btrfs_extent_item */
> +	u64 inline_refs = 0;	/* found total inline refs */
> +
> +	if (key->type == BTRFS_METADATA_ITEM_KEY &&
> +	    !btrfs_fs_incompat(fs_info, SKINNY_METADATA)) {
> +		generic_err(leaf, slot,
> +"invalid key type, METADATA_ITEM type invalid when SKINNY_METADATA feature disabled");
> +		return -EUCLEAN;
> +	}
> +	/* key->objectid is the bytenr for both key types */
> +	if (!IS_ALIGNED(key->objectid, fs_info->sectorsize)) {
> +		generic_err(leaf, slot,
> +"invalid key objectid, have %llu expect to be aligned to %u",
> +			   key->objectid, fs_info->sectorsize);
> +		return -EUCLEAN;
> +	}
> +
> +	/* key->offset is tree level for METADATA_ITEM_KEY */
> +	if (key->type == BTRFS_METADATA_ITEM_KEY &&
> +	    key->offset >= BTRFS_MAX_LEVEL) {
> +		extent_err(leaf, slot,
> +			   "invalid tree level, have %llu expect [0, %u]",
> +			   key->offset, BTRFS_MAX_LEVEL - 1);
> +		return -EUCLEAN;
> +	}
> +
> +	/*
> +	 * EXTENT/METADATA_ITEM is consistent of:
> +	 * 1) One btrfs_extent_item
> +	 *    Records the total refs, type and generation of the extent.
> +	 *
> +	 * 2) One btrfs_tree_block_info (for EXTENT_ITEM and tree backref only)
> +	 *    Records the first key and level of the tree block.
> +	 *
> +	 * 2) *Zero* or more btrfs_extent_inline_ref(s)
> +	 *    Each inline ref has one btrfs_extent_inline_ref shows:
> +	 *    2.1) The ref type, one of the 4
> +	 *         TREE_BLOCK_REF	Tree block only
> +	 *         SHARED_BLOCK_REF	Tree block only
> +	 *         EXTENT_DATA_REF	Data only
> +	 *         SHARED_DATA_REF	Data only
> +	 *    2.2) Ref type specific data
> +	 *         Either using btrfs_extent_inline_ref::offset, or specific
> +	 *         data structure.
> +	 */
> +	if (item_size < sizeof(*ei)) {
> +		extent_err(leaf, slot,
> +			   "invalid item size, have %u expect [%zu, %u)",
> +			   item_size, sizeof(*ei),
> +			   BTRFS_LEAF_DATA_SIZE(fs_info));
> +		return -EUCLEAN;
> +	}
> +	end = item_size + btrfs_item_ptr_offset(leaf, slot);
> +
> +	/* Checks against extent_item */
> +	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
> +	flags = btrfs_extent_flags(leaf, ei);
> +	total_refs = btrfs_extent_refs(leaf, ei);
> +	generation = btrfs_extent_generation(leaf, ei);
> +	if (generation > btrfs_super_generation(fs_info->super_copy) + 1) {
> +		extent_err(leaf, slot,
> +			"invalid generation, have %llu expect (0, %llu]",
> +			   generation,
> +			   btrfs_super_generation(fs_info->super_copy) + 1);
> +		return -EUCLEAN;
> +	}
> +	if (!is_power_of_2(flags & (BTRFS_EXTENT_FLAG_DATA |
> +				    BTRFS_EXTENT_FLAG_TREE_BLOCK))) {
> +		extent_err(leaf, slot,
> +		"invalid extent flag, have 0x%llx expect 1 bit set in 0x%llx",
> +			flags, BTRFS_EXTENT_FLAG_DATA |
> +			BTRFS_EXTENT_FLAG_TREE_BLOCK);
> +		return -EUCLEAN;
> +	}
> +	is_tree_block = !!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK);
> +	if (is_tree_block) {
> +		if (key->type == BTRFS_EXTENT_ITEM_KEY &&
> +		    key->offset != fs_info->nodesize) {
> +			extent_err(leaf, slot,
> +				   "invalid extent length, have %llu expect %u",
> +				   key->offset, fs_info->nodesize);
> +			return -EUCLEAN;
> +		}
> +	} else {
> +		if (key->type != BTRFS_EXTENT_ITEM_KEY) {
> +			extent_err(leaf, slot,
> +		"invalid key type, have %u expect %u for data backref",
> +				   key->type, BTRFS_EXTENT_ITEM_KEY);
> +			return -EUCLEAN;
> +		}
> +		if (!IS_ALIGNED(key->offset, fs_info->sectorsize)) {
> +			extent_err(leaf, slot,
> +			"invalid extent length, have %llu expect aligned to %u",
> +				   key->offset, fs_info->sectorsize);
> +			return -EUCLEAN;
> +		}
> +	}
> +	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
> +
> +	/* Check the special case of btrfs_tree_block_info */
> +	if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
> +		struct btrfs_tree_block_info *info;
> +
> +		info = (struct btrfs_tree_block_info *)ptr;
> +		if (btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL) {
> +			extent_err(leaf, slot,
> +			"invalid tree block info level, have %u expect [0, %u]",
> +				   btrfs_tree_block_level(leaf, info),
> +				   BTRFS_MAX_LEVEL - 1);
> +			return -EUCLEAN;
> +		}
> +		ptr = (unsigned long)(struct btrfs_tree_block_info *)(info + 1);
> +	}
> +
> +	/* Check inline refs */
> +	while (ptr < end) {
> +		struct btrfs_extent_inline_ref *iref;
> +		struct btrfs_extent_data_ref *dref;
> +		struct btrfs_shared_data_ref *sref;
> +		u64 dref_offset;
> +		u64 inline_offset;
> +		u8 inline_type;
> +
> +		if (ptr + sizeof(*iref) > end) {
> +			extent_err(leaf, slot,
> +"inline ref item overflows extent item, ptr %lu iref size %zu end %lu",
> +				   ptr, sizeof(*iref), end);
> +			goto err;

Half of the function does return -EUCLEAN and the other goto err, that
does return -EUCLEAN without any other code. Is there a reason you don't
use the return consistently?

> +		}
> +		iref = (struct btrfs_extent_inline_ref *)ptr;
> +		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
> +		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
> +		if (ptr + btrfs_extent_inline_ref_size(inline_type) > end) {
> +			extent_err(leaf, slot,
> +"inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> +				   ptr, inline_type, end);
> +			goto err;
> +		}
> +
> +		switch (inline_type) {
> +		/* inline_offset is subvolid of the owner, no need to check */
> +		case BTRFS_TREE_BLOCK_REF_KEY:
> +			inline_refs++;
> +			break;
> +		/* contains parent bytenr */

Comments should start with a capital letter unless it's an identifier.

> +		case BTRFS_SHARED_BLOCK_REF_KEY:
> +			if (!IS_ALIGNED(inline_offset, fs_info->sectorsize)) {
> +				extent_err(leaf, slot,
> +	"invalid tree parent bytenr, have %llu expect aligned to %u",
> +					   inline_offset, fs_info->sectorsize);
> +				goto err;
> +			}
> +			inline_refs++;
> +			break;
> +		/*
> +		 * contains owner subvolid, owner key objectid, adjusted offset.
> +		 * the only obvious corruption can happen in that offset.
> +		 */
> +		case BTRFS_EXTENT_DATA_REF_KEY:
> +			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
> +			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
> +			if (!IS_ALIGNED(dref_offset, fs_info->sectorsize)) {
> +				extent_err(leaf, slot,
> +		"invalid data ref offset, have %llu expect aligned to %u",
> +					   dref_offset, fs_info->sectorsize);
> +				goto err;
> +			}
> +			inline_refs += btrfs_extent_data_ref_count(leaf, dref);
> +			break;
> +		/* contains parent bytenr and ref count */
> +		case BTRFS_SHARED_DATA_REF_KEY:
> +			sref = (struct btrfs_shared_data_ref *)(iref + 1);
> +			if (!IS_ALIGNED(inline_offset, fs_info->sectorsize)) {
> +				extent_err(leaf, slot,
> +		"invalid data parent bytenr, have %llu expect aligned to %u",
> +					   inline_offset, fs_info->sectorsize);
> +				goto err;
> +			}
> +			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
> +			break;
> +		default:
> +			extent_err(leaf, slot, "unknown inline ref type: %u",
> +				   inline_type);
> +			goto err;
> +		}
> +		ptr += btrfs_extent_inline_ref_size(inline_type);
> +	}
> +	/* No padding is allowed */
> +	if (ptr != end) {
> +		extent_err(leaf, slot,
> +			   "invalid extent item size, padding bytes found");

The other messages are detailed which is good, this one lacks the amount
of padding found.

> +		goto err;
> +	}
> +
> +	/* Finally, check the inline refs against total refs */
> +	if (inline_refs > total_refs) {
> +		extent_err(leaf, slot,
> +			"invalid extent refs, have %llu expect >= inline %llu",
> +			   total_refs, inline_refs);
> +		goto err;
> +	}
> +	return 0;
> +err:
> +	return -EUCLEAN;
> +}
