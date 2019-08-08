Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346A3864F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfHHO7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 10:59:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732414AbfHHO7D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 10:59:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2C55B01F
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2019 14:59:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49C16DA7C5; Thu,  8 Aug 2019 16:59:32 +0200 (CEST)
Date:   Thu, 8 Aug 2019 16:59:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 3/3] btrfs: tree-checker: Add EXTENT_DATA_REF check
Message-ID: <20190808145932.GB8267@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190807140843.2728-1-wqu@suse.com>
 <20190807140843.2728-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807140843.2728-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 10:08:43PM +0800, Qu Wenruo wrote:
> EXTENT_DATA_REF is a little like DIR_ITEM which contains hash in its
> key->offset.
> 
> This patch will check the following contents:
> - Key->objectid
>   Basic alignment check.
> 
> - Hash
>   Hash of each extent_data_ref item must match key->offset.
> 
> - Offset
>   Basic alignment check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h        |  1 +
>  fs/btrfs/extent-tree.c  |  2 +-
>  fs/btrfs/tree-checker.c | 48 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0a61dff27f57..710ea3a6608c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2679,6 +2679,7 @@ enum btrfs_inline_ref_type {
>  int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  				     struct btrfs_extent_inline_ref *iref,
>  				     enum btrfs_inline_ref_type is_data);
> +u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
>  
>  u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes);
>  
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b4e9e36b65f1..c0888ed503df 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1114,7 +1114,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  	return BTRFS_REF_TYPE_INVALID;
>  }
>  
> -static u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
> +u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
>  {
>  	u32 high_crc = ~(u32)0;
>  	u32 low_crc = ~(u32)0;
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 6aaf3650b13d..5755a7a8477f 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1178,6 +1178,51 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
>  	return 0;
>  }
>  
> +static int check_extent_data_ref(struct extent_buffer *leaf,
> +				 struct btrfs_key *key, int slot)
> +{
> +	struct btrfs_extent_data_ref *dref;
> +	u64 ptr = btrfs_item_ptr_offset(leaf, slot);
> +	u64 end = ptr + btrfs_item_size_nr(leaf, slot);

same here, unsigned long

> +
> +	if (btrfs_item_size_nr(leaf, slot) % sizeof(*dref) != 0) {
> +		generic_err(leaf, slot,
> +	"invalid item size, have %u expect aligned to %lu for key type %u",
> +			    btrfs_item_size_nr(leaf, slot),
> +			    sizeof(*dref), key->type);

sizeof needs %zu

> +	}
> +	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
> +		generic_err(leaf, slot,
> +"invalid key objectid for shared block ref, have %llu expect aligned to %u",
> +			    key->objectid, leaf->fs_info->sectorsize);
> +		return -EUCLEAN;
> +	}
> +	for (; ptr < end; ptr += sizeof(*dref)) {
> +		u64 root_objectid;
> +		u64 owner;
> +		u64 offset;
> +		u64 hash;
> +
> +		dref = (struct btrfs_extent_data_ref *)ptr;
> +		root_objectid = btrfs_extent_data_ref_root(leaf, dref);
> +		owner = btrfs_extent_data_ref_objectid(leaf, dref);
> +		offset = btrfs_extent_data_ref_offset(leaf, dref);
> +		hash = hash_extent_data_ref(root_objectid, owner, offset);
> +		if (hash != key->offset) {
> +			extent_err(leaf, slot,
> +	"invalid extent data ref hash, item have 0x%016llx key have 0x%016llx",
> +				   hash, key->offset);
> +			return -EUCLEAN;
> +		}
> +		if (!IS_ALIGNED(offset, leaf->fs_info->sectorsize)) {
> +			extent_err(leaf, slot,
> +	"invalid extent data backref offset, have %llu expect aligned to %u",
> +				   offset, leaf->fs_info->sectorsize);
> +		}
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Common point to switch the item-specific validation.
>   */
> @@ -1225,6 +1270,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
>  	case BTRFS_SHARED_BLOCK_REF_KEY:
>  		ret = check_simple_keyed_refs(leaf, key, slot);
>  		break;
> +	case BTRFS_EXTENT_DATA_REF_KEY:
> +		ret = check_extent_data_ref(leaf, key, slot);
> +		break;
>  	}
>  	return ret;
>  }
> -- 
> 2.22.0
