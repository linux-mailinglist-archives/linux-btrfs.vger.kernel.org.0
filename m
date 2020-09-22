Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D421C273F7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIVKUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgIVKUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:44 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0EC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 03:20:44 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 8142B1555E5;
        Tue, 22 Sep 2020 12:20:38 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
Date:   Tue, 22 Sep 2020 12:20:37 +0200
Message-ID: <4591966.Q0mfgpEauH@merkaba>
In-Reply-To: <20200922023701.32654-1-wqu@suse.com>
References: <20200922023701.32654-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu.

Instead of the tool, can I also patch my kernel with the patch below to 
have it automatically fix it?

If so, which approach would you prefer for testing?

I can apply the patch as I compile kernels myself.

Thanks,
Martin

Qu Wenruo - 22.09.20, 04:37:01 CEST:
> Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> introduced btrfs root item size check, however btrfs root item has two
> format, the legacy one which just ends before generation_v2 member,
> is smaller than current btrfs root item size.
> 
> This caused btrfs kernel to reject valid but old tree root leaves.
> 
> Fix this problem by also allowing legacy root item, since kernel can
> already handle them pretty well and upgrade to newer root item format
> when needed.
> 
> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c         | 17 ++++++++++++-----
>  include/uapi/linux/btrfs_tree.h |  9 +++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 7b1fee630f97..6f794aca48d3 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1035,7 +1035,7 @@ static int check_root_item(struct extent_buffer
> *leaf, struct btrfs_key *key, int slot)
>  {
>  	struct btrfs_fs_info *fs_info = leaf->fs_info;
> -	struct btrfs_root_item ri;
> +	struct btrfs_root_item ri = { 0 };
>  	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
>  				     BTRFS_ROOT_SUBVOL_DEAD;
>  	int ret;
> @@ -1044,14 +1044,21 @@ static int check_root_item(struct
> extent_buffer *leaf, struct btrfs_key *key, if (ret < 0)
>  		return ret;
> 
> -	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri)) {
> +	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri) &&
> +	    btrfs_item_size_nr(leaf, slot) != 
btrfs_legacy_root_item_size())
> { generic_err(leaf, slot,
> -			    "invalid root item size, have %u expect %zu",
> -			    btrfs_item_size_nr(leaf, slot), sizeof(ri));
> +			    "invalid root item size, have %u expect %zu or 
%zu",
> +			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
> +			    btrfs_legacy_root_item_size());
>  	}
> 
> +	/*
> +	 * For legacy root item, the members starting at generation_v2 
will
> be +	 * all filled with 0.
> +	 * And since we allow geneartion_v2 as 0, it will still pass the
> check. +	 */
>  	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
> -			   sizeof(ri));
> +			   btrfs_item_size_nr(leaf, slot));
> 
>  	/* Generation related */
>  	if (btrfs_root_generation(&ri) >
> diff --git a/include/uapi/linux/btrfs_tree.h
> b/include/uapi/linux/btrfs_tree.h index 9ba64ca6b4ac..464095a28b18
> 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -644,6 +644,15 @@ struct btrfs_root_item {
>  	__le64 reserved[8]; /* for future */
>  } __attribute__ ((__packed__));
> 
> +/*
> + * Btrfs root item used to be smaller than current size.
> + * The old format ends at where member generation_v2 is.
> + */
> +static inline size_t btrfs_legacy_root_item_size(void)
> +{
> +	return offsetof(struct btrfs_root_item, generation_v2);
> +}
> +
>  /*
>   * this is used for both forward and backward root refs
>   */


-- 
Martin


