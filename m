Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB9B54F70C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 13:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382041AbiFQLyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381683AbiFQLyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 07:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252EB6CF7C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 04:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B662261F50
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 11:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64AFC3411B;
        Fri, 17 Jun 2022 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655466889;
        bh=hsbbPieBhxVB4VimdHydjrBHR+whsESald1WZFSj5Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBWgXvhG09Cu/zmcQ4P7FAPLktj1P8xtpFjrzkO9qEO0bdTDCLb3XBn/U3IFeyZHU
         Pa6M0VST8o+xRLxm2W71FFLwnU2HSihJYLRVmc9eC1JUQphHKqb3z6MYVwj9QzMU2K
         fK5RBvV29ErCfRVnRDyw6klOfKJdyNhyzRoD02UOsPI4hSO75YyDKNMvfFh/zJu+gA
         qOtE6P3Mxi8MhdF9fEYT5B8Zt3J4z6i2m6Quu1hVglcFcKUUc4FafHPXOBvXgaXCOo
         PXoHdxx4F/wAvH/62rCw83urT1ejjRvlQuoyM1fy3CWtJlTRVwVhH44CAFTjTgJGGb
         j5llapVzeWjwQ==
Date:   Fri, 17 Jun 2022 12:54:46 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Batch up release of reserved metadata for
 delayed items used for deletion
Message-ID: <20220617115446.GA4049961@falcondesktop>
References: <20220617113630.1060249-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617113630.1060249-1-nborisov@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 02:36:30PM +0300, Nikolay Borisov wrote:
> With Filipe's recent rework of the delayed inode code one aspect which
> isn't batched is the release of the reserved metadata of delayed inode's
> delete items. With this patch on top of Filipe's rework and running the
> same test as provided in the description of a patch titled
> "btrfs: improve batch deletion of delayed dir index items" I observe
> the following change of the number of calls to btrfs_block_rsv_release:
> 
> Before this change:
> @block_rsv_release: 1004
> @btrfs_delete_delayed_items_total_time: 14602
> @delete_batches: 505
> 
> After:
> @block_rsv_release: 510
> @btrfs_delete_delayed_items_total_time: 13643
> @delete_batches: 507
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2:
>  * Improved subject wording to make it more clear (Filipe)
> 
>  * Print the inode number in the tracepoint (Filipe)
> 
>  * More explicit referal to the test case in Filipe's initial patch to make it
>  more clear how those numbers are derived.
> 
>  fs/btrfs/delayed-inode.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index e1e856436ad5..6c06ddba5a7a 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -800,11 +800,13 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>  				    struct btrfs_path *path,
>  				    struct btrfs_delayed_item *item)
>  {
> +	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_delayed_item *curr, *next;
>  	struct extent_buffer *leaf = path->nodes[0];
>  	LIST_HEAD(batch_list);
>  	int nitems, slot, last_slot;
>  	int ret;
> +	u64 total_reserved_size = item->bytes_reserved;
> 
>  	ASSERT(leaf != NULL);
> 
> @@ -841,14 +843,23 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>  		nitems++;
>  		curr = next;
>  		list_add_tail(&curr->tree_list, &batch_list);
> +		total_reserved_size += curr->bytes_reserved;
>  	}
> 
>  	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
>  	if (ret)
>  		return ret;
> 
> +	/*
> +	 * Check btrfs_delayed_item_reserve_metadata() to see why we don't need
> +	 * to release/reserve qgroup space.
> +	 */
> +	trace_btrfs_space_reservation(fs_info, "delayed_item", 0,
> +				      total_reserved_size, 0);

Still using 0 instead of item->key.objectid, just like v1.

Also, I forgot to point out in v1, these calls should be done under a:

   if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))

(or total_reserved_size > 0)

Thanks.

> +	btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
> +				total_reserved_size, NULL);
> +
>  	list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
> -		btrfs_delayed_item_release_metadata(root, curr);
>  		list_del(&curr->tree_list);
>  		btrfs_release_delayed_item(curr);
>  	}
> --
> 2.25.1
> 
