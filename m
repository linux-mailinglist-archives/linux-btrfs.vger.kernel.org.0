Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4845B9CE64
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfHZLqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731517AbfHZLqQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5853AE35
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:46:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] btrfs: tree-checker: Try to detect missing INODE_ITEM
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190826074039.28517-1-wqu@suse.com>
 <20190826074039.28517-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c3557459-b003-a6d7-a96f-b1243f420dc7@suse.com>
Date:   Mon, 26 Aug 2019 14:46:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826074039.28517-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.19 г. 10:40 ч., Qu Wenruo wrote:
> For the following items, key->objectid is inode number:
> - DIR_ITEM
> - DIR_INDEX
> - XATTR_ITEM
> - EXTENT_DATA
> - INODE_REF
> 
> So in btrfs btree, such items must have its previous item shares the
> same objectid, e.g.:
>  (257 INODE_ITEM 0)
>  (257 DIR_INDEX xxx)
>  (257 DIR_ITEM xxx)
>  (258 INODE_ITEM 0)
>  (258 INODE_REF 0)
>  (258 XATTR_ITEM 0)
>  (258 EXTENT_DATA 0)
> 
> But if we have the following sequence, then there is definitely
> something wrong, normally some INODE_ITEM is missing, like:
>  (257 INODE_ITEM 0)
>  (257 DIR_INDEX xxx)
>  (257 DIR_ITEM xxx)
>  (258 XATTR_ITEM 0)  <<< objecitd suddenly changed to 258
>  (258 EXTENT_DATA 0)
> 
> So just by checking the previous key for above inode based key types, we
> can detect missing inode item.
> 
> For INODE_REF key type, the check will be added along with INODE_REF
> checker.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/tree-checker.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ccd5706199d7..636ce1b4566e 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -141,6 +141,19 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  		return -EUCLEAN;
>  	}
>  
> +	/*
> +	 * Previous key must have the same key->objectid (ino).
> +	 * It can be XATTR_ITEM, INODE_ITEM or just another EXTENT_DATA.
> +	 * But if objectids mismatch, it means we have a missing
> +	 * INODE_ITEM.
> +	 */
> +	if (slot > 0 && prev_key->objectid != key->objectid) {
> +		file_extent_err(leaf, slot,
> +		"invalid previous key objectid, have %llu expect %llu",
> +				prev_key->objectid, key->objectid);
> +		return -EUCLEAN;
> +	}
> +
>  	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
>  
>  	if (btrfs_file_extent_type(leaf, fi) > BTRFS_FILE_EXTENT_TYPES) {
> @@ -299,13 +312,21 @@ static void dir_item_err(const struct extent_buffer *eb, int slot,
>  }
>  
>  static int check_dir_item(struct extent_buffer *leaf,
> -			  struct btrfs_key *key, int slot)
> +			  struct btrfs_key *key, struct btrfs_key *prev_key,
> +			  int slot)
>  {
>  	struct btrfs_fs_info *fs_info = leaf->fs_info;
>  	struct btrfs_dir_item *di;
>  	u32 item_size = btrfs_item_size_nr(leaf, slot);
>  	u32 cur = 0;
>  
> +	/* Same check as in check_extent_data_item() */
> +	if (slot > 0 && prev_key->objectid != key->objectid) {
> +		dir_item_err(leaf, slot,
> +		"invalid previous key objectid, have %llu expect %llu",
> +			     prev_key->objectid, key->objectid);
> +		return -EUCLEAN;
> +	}
>  	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
>  	while (cur < item_size) {
>  		u32 name_len;
> @@ -841,7 +862,7 @@ static int check_leaf_item(struct extent_buffer *leaf,
>  	case BTRFS_DIR_ITEM_KEY:
>  	case BTRFS_DIR_INDEX_KEY:
>  	case BTRFS_XATTR_ITEM_KEY:
> -		ret = check_dir_item(leaf, key, slot);
> +		ret = check_dir_item(leaf, key, prev_key, slot);
>  		break;
>  	case BTRFS_BLOCK_GROUP_ITEM_KEY:
>  		ret = check_block_group_item(leaf, key, slot);
> 
