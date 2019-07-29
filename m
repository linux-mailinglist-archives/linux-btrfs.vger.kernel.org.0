Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461FB78D09
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfG2Nme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:42:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbfG2Nmd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:42:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB86DAF1B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2019 13:42:31 +0000 (UTC)
Subject: Re: [PATCH 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190729074337.10573-1-wqu@suse.com>
 <20190729074337.10573-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bd6c75f8-c9b5-c29f-a691-101fee33cef5@suse.com>
Date:   Mon, 29 Jul 2019 16:42:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729074337.10573-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.07.19 г. 10:43 ч., Qu Wenruo wrote:
> This patch introduces the ability to check extent items.
> 
> This check involves:
> - key->objectid check
>   Basic alignment check.
> 
> - key->type check
>   Against btrfs_extent_item::type and SKINNY_METADATA feature.
> 
> - key->offset alignment check for EXTENT_ITEM
> 
> - key->offset check for METADATA_ITEM
> 
> - item size check
>   Both against minimal size and stepping check.
> 
> - btrfs_extent_item check
>   Checks its flags and generation.
> 
> - btrfs_extent_inline_ref checks
>   Against 4 types inline ref.
>   Checks bytenr alignment and tree level.
> 
> - btrfs_extent_item::refs check
>   Check against total refs found in inline refs.
> 
> This check would be the most complex single item check due to its nature
> of inlined items.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 249 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 249 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 71bbbce3076d..1e97bb127893 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -899,6 +899,251 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
>  	return 0;
>  }
>  
> +__printf(3,4)
> +__cold
> +static void extent_err(const struct extent_buffer *eb, int slot,
> +		       const char *fmt, ...)
> +{
> +	struct btrfs_key key;
> +	struct va_format vaf;
> +	va_list args;
> +	u64 bytenr;
> +	u64 len;
> +
> +	btrfs_item_key_to_cpu(eb, &key, slot);
> +	bytenr = key.objectid;
> +	if (key.type == BTRFS_METADATA_ITEM_KEY)
> +		len = eb->fs_info->nodesize;
> +	else
> +		len = key.offset;
> +	va_start(args, fmt);
> +
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	btrfs_crit(eb->fs_info,
> +	"corrupt %s: block=%llu slot=%d extent bytenr=%llu len=%llu %pV",
> +		btrfs_header_level(eb) == 0 ? "leaf" : "node",
> +		eb->start, slot, bytenr, len, &vaf);
> +	va_end(args);
> +}
> +
> +static int check_extent_item(struct extent_buffer *leaf,
> +			     struct btrfs_key *key, int slot)
> +{
> +	struct btrfs_fs_info *fs_info = leaf->fs_info;
> +	struct btrfs_extent_item *ei;
> +	bool is_tree_block = false;
> +	u64 ptr;	/* Current pointer inside inline refs */
> +	u64 end;	/* Extent item end */
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
> +	if (key->type == BTRFS_METADATA_ITEM_KEY) {
> +		if (key->offset >= BTRFS_MAX_LEVEL) {

make it a compound statement:

if key->type && key->offset. The extra if doesn't bring anything...

> +			extent_err(leaf, slot,
> +				"invalid tree level, have %llu expect [0, %u]",
> +				   key->offset, BTRFS_MAX_LEVEL - 1);
> +			return -EUCLEAN;
> +		}
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
> +			   "invalid item size, have %u expect >= %lu",
> +			   item_size, sizeof(*ei));
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
> +			"invalid generation, have %llu expect <= %llu",

nit: I find the '<= [number]' somewhat confusing, wouldn't it be better
if it's spelled our e.g 'expecting less than or equal than [number]'.
Might be just me.

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
> +	if (is_tree_block && key->type == BTRFS_EXTENT_ITEM_KEY &&
> +	    key->offset != fs_info->nodesize) {
> +		extent_err(leaf, slot,
> +			   "invalid extent length, have %llu expect %u",
> +			   key->offset, fs_info->nodesize);
> +		return -EUCLEAN;
> +	}
> +	if (!is_tree_block) {
> +		if (key->type != BTRFS_EXTENT_ITEM_KEY) {
> +			extent_err(leaf, slot,
> +		"invalid key type, have %u expect %u for data backref",
> +				   key->type, BTRFS_EXTENT_ITEM_KEY);
> +			return -EUCLEAN;
> +		}
> +		if (!IS_ALIGNED(key->offset, fs_info->sectorsize)) {
> +			extent_err(leaf, slot,
> +			"invalid extent length, have %llu expect aliged to %u",
> +				   key->offset, fs_info->sectorsize);
> +			return -EUCLEAN;
> +		}
> +	}

unify the two is_tree_block/!is_tree_block either in:

if (is_tree_block) {
	if (keypt->type = EXTENT_ITEM_KEY && offset != nodesize {
		foo;
	}
} else {
	bar;
}

or

if (is_tree_block && key->type == BTRFS_EXTENT_ITEM_KEY ..) {

} else if (!is_tree_block) {
bar
}

> +	ptr = (u64)(struct btrfs_extent_item *)(ei + 1);
> +
> +	/* Check the special case of btrfs_tree_block_info */
> +	if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
> +		struct btrfs_tree_block_info *info;
> +
> +		info = (struct btrfs_tree_block_info *)ptr;
> +		if (btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL) {
> +			extent_err(leaf, slot,
> +			"invalid tree block info level, have %u expect [0, %u)",

nit: Strictly speaking using [0, 7) is wrong, because ')' already
implies an open interval. Since we have 8 levels 0/7 inclusive this
means the correct way to print it would be [0, 7] or [0, 8).


> +				   btrfs_tree_block_level(leaf, info),
> +				   BTRFS_MAX_LEVEL - 1);
> +			return -EUCLEAN;
> +		}
> +		ptr = (u64)(struct btrfs_tree_block_info *)(info + 1);
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
> +	"invalid item size, size too small, ptr %llu end %llu",
> +				   ptr, end);
> +			goto err;
> +		}
> +		iref = (struct btrfs_extent_inline_ref *)ptr;
> +		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
> +		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
> +		if (ptr + btrfs_extent_inline_ref_size(inline_type) > end) {
> +			extent_err(leaf, slot,
> +	"invalid item size, size too small, ptr %llu end %llu",

Make that text explicit:

"inline ref item overflows extent item" or some such.

> +				   ptr, end);
> +			goto err;
> +		}
> +
> +		switch (inline_type) {
> +		/* inline_offset is subvolid of the owner, no need to check */
> +		case BTRFS_TREE_BLOCK_REF_KEY:
> +			inline_refs++;
> +			break;
> +		/* contains parent bytenr */
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
> +		goto err;
> +	}
> +
> +	/* Finally, check the inline refs against total refs */
> +	if (total_refs < inline_refs) {

nit: if (inline_refs > total_refs) {} looks saner to me.



> +		extent_err(leaf, slot,
> +			"invalid extent refs, have %llu expect >= %llu",
> +			   total_refs, inline_refs);
> +		goto err;
> +	}
> +	return 0;
> +err:
> +	return -EUCLEAN;
> +}
> +
>  /*
>   * Common point to switch the item-specific validation.
>   */
> @@ -937,6 +1182,10 @@ static int check_leaf_item(struct extent_buffer *leaf,
>  	case BTRFS_ROOT_ITEM_KEY:
>  		ret = check_root_item(leaf, key, slot);
>  		break;
> +	case BTRFS_EXTENT_ITEM_KEY:
> +	case BTRFS_METADATA_ITEM_KEY:
> +		ret = check_extent_item(leaf, key, slot);
> +		break;
>  	}
>  	return ret;
>  }
> 
