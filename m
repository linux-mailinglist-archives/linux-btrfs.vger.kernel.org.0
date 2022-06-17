Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ECE54F559
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiFQKay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQKax (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5386A43C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE5761DD1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 10:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95604C3411F;
        Fri, 17 Jun 2022 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655461851;
        bh=HMaccBSpypR03D2jqsGxzD/mIDqsvIPUbSn+K06CUL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3GWijfAsbyryLvvDTBEzUyHNRG6HrMuIjYxAvNYNwANsifiWAZlugnv6awqwry53
         d9lrAAmN+O2MLUPoNHOl//CJBL64ZYQxJkqVKDvsQw2gKhzwdrjofwbBOfs0tUeUEf
         Zn5Fud7XPl9mNzQ7IwlHjOO4c6z600S+BpEZ2KOZiMPfRjKiUBzF+hqZUd5Qi/muFU
         tPKjuubBb3z147IEmNoge3qyq3lJuRptvrkv5W4RwUNd3dOVCZepqS8ZxZLQ3pBcXT
         S0jcD0HPunkjmeHis+OfgitPMvT8cCF5f8/KIHyM0YcybUcmHR1TLAkJF0WP2CoFAn
         cGFiHchl9p/rg==
Date:   Fri, 17 Jun 2022 11:30:49 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Batch up release of delayed inode metadata
Message-ID: <20220617103049.GE4041436@falcondesktop>
References: <20220616133545.1001959-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616133545.1001959-1-nborisov@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 04:35:45PM +0300, Nikolay Borisov wrote:
> With Filipe's recent rework of the delayed inode code one aspect which
> isn't batched is the release of the reserved metadata of delayed inode's
> delete items. With this batch on top of his rework I see the following
> change of the number of calls to btrfs_block_rsv_release:
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

Placing here some numbers without any context is puzzling. Either paste
the test and bpftrace script here, or mention it's for the same test and
bpftrace script from the changelog of another patch (mentioning its subject).

> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
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

The tracepoint should include the number of the associated inode (item->key.objectid),
just like every where else, so that during debugging we can match the release with
the respective reservation call.

Also the subject is misleading: it's not the release of delayed inode metadata,
it's the release of reserved space for delayed items used for deletion.

Otherwise it looks fine, thanks.

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
