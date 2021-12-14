Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B97474070
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 11:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhLNK2E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 05:28:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58446 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhLNK2D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 05:28:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A6AB81823
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 10:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5904C34600;
        Tue, 14 Dec 2021 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639477681;
        bh=VCZH+2ScHhDbVzaUTlnA5SaKdE7pTdGq+5lzvktLgNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifYp9ke2XlgP2csE0si0plSMpeqXDToyZKTZgbilCsumtmFnam49OD6fdsRjJ/cwa
         uu2Pw455j6pVG8v/yfB8s70T5E5qAb6p4Kf9BD7Nvo2xuT1D5MMQhskC6dQWKrjpf0
         gM5cIWvY6EUe3w8VeFmvL5PxXNtBoerrttFCsEabq0amA9SdSDHC7c30lEWIGjupT9
         RgiX03YCVhvCQYSSDd86IuXIxwXiBfAZa5Cx5SQpin/dxDSAypXSys2Sv5nXkWGRuw
         agtqE35RbLTuNHmTcdPmJnNK7FOffHVJCPlCHUICVjTz/Dl/k24hYivxjyaBKFzsCk
         Ws25CE8aZy8+A==
Date:   Tue, 14 Dec 2021 10:27:42 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove some duplicated checks in
 btrfs_previous_*_item()
Message-ID: <Ybhxngswi6vN+vH4@debian9.Home>
References: <20211214071411.48324-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214071411.48324-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 03:14:11PM +0800, Qu Wenruo wrote:
> In btrfs_previous_item() and btrfs_previous_extent_item() we check
> btrfs_header_nritems() in a loop.
> 
> But in fact we don't need to do it in a loop at all.
> 
> Firstly, if a tree block is empty, the whole tree is empty and nodes[0]
> is the tree root.
> We don't need to do anything and can exit immediately.
> 
> Secondly, the only timing we could get a slots[0] >= nritems is when the
> function get called. After the first slots[0]--, the slot should always
> be <= nritems.
> 
> So this patch will move all the nritems related checks out of the loop
> by:
> 
> - Check nritems of nodes[0] to do a quick exit
> 
> - Sanitize path->slots[0] before entering the loop
>   I doubt if there is any caller setting path->slots[0] beyond
>   nritems + 1 (setting to nritems is possible when item is not found).
>   Sanitize path->slots[0] to nritems won't hurt anyway.
> 
> - Unconditionally reduce path->slots[0]
>   Since we're sure all tree blocks should not be empty, and
>   btrfs_prev_leaf() will return with path->slots[0] == nritems, we
>   can safely reduce slots[0] unconditionally.
>   Just keep an extra ASSERT() to make sure no tree block is empty.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.c | 52 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 781537692a4a..555345aed84d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4704,23 +4704,39 @@ int btrfs_previous_item(struct btrfs_root *root,
>  {
>  	struct btrfs_key found_key;
>  	struct extent_buffer *leaf;
> -	u32 nritems;
> +	const u32 nritems = btrfs_header_nritems(path->nodes[0]);
>  	int ret;
>  
> +	/*
> +	 * Check nritems first, if the tree is empty we exit immediately.
> +	 * And if this leave is not empty, none of the tree blocks of this root
> +	 * should be empty.
> +	 */
> +	if (nritems == 0)
> +		return 1;
> +
> +	/*
> +	 * If we're several slots beyond nritems, we reset slot to nritems,
> +	 * and it will be handled properly inside the loop.
> +	 */
> +	if (unlikely(path->slots[0] > nritems))
> +		path->slots[0] = nritems;
> +
>  	while (1) {
>  		if (path->slots[0] == 0) {
>  			ret = btrfs_prev_leaf(root, path);
>  			if (ret != 0)
>  				return ret;
> -		} else {
> -			path->slots[0]--;
>  		}
>  		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> -			path->slots[0]--;
> +		ASSERT(btrfs_header_nritems(leaf));
> +		/*
> +		 * This is for both regular case and above btrfs_prev_leaf() case.
> +		 * As btrfs_prev_leaf() will return with path->slots[0] == nritems,
> +		 * and we're sure no tree block is empty, we can go safely
> +		 * reduce slots[0] here.
> +		 */
> +		path->slots[0]--;

No, this is wrong.
btrfs_prev_leaf() computes the previous key and does a search_slot() for it.
With this unconditional decrement we can miss the previous key in 2 ways:

1) The previous key exists, and btrfs_prev_leaf() leaves us in a leaf that has it
   and the slot is btrfs_header_nritems(prev_leaf) - 1 -> the last key on a leaf;

2) The previous key exists, but after btrfs_prev_leaf() released the path and
   before it called search_slot(), there was a balance operation and it pushed the
   previous key in the middle of the leaf we had, or some other leaf, and the slot
   will be something less than btrfs_header_nritems(), it can even be 0.

That's why we have the call to header_nritems() in the loop, and check if slots[0]
is == to nritems before decrementing...

Thanks.


>  
>  		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>  		if (found_key.objectid < min_objectid)
> @@ -4745,23 +4761,27 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
>  {
>  	struct btrfs_key found_key;
>  	struct extent_buffer *leaf;
> -	u32 nritems;
> +	const u32 nritems = btrfs_header_nritems(path->nodes[0]);
>  	int ret;
>  
> +	/*
> +	 * Refer to btrfs_previous_item() for the reason of all nritems related
> +	 * checks/modifications.
> +	 */
> +	if (nritems == 0)
> +		return 1;
> +	if (unlikely(path->slots[0] > nritems))
> +		path->slots[0] = nritems;
> +
>  	while (1) {
>  		if (path->slots[0] == 0) {
>  			ret = btrfs_prev_leaf(root, path);
>  			if (ret != 0)
>  				return ret;
> -		} else {
> -			path->slots[0]--;
>  		}
>  		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> -			path->slots[0]--;
> +		ASSERT(btrfs_header_nritems(leaf));
> +		path->slots[0]--;
>  
>  		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>  		if (found_key.objectid < min_objectid)
> -- 
> 2.34.1
> 
