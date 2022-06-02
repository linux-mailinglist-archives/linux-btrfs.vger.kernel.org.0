Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524BD53B572
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiFBIzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiFBIzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 04:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06F2A7A9A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 01:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79563611F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 08:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BCCC34114;
        Thu,  2 Jun 2022 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654160105;
        bh=acKEyEFXlQlAHT6dA9d6VJ5FDeebaWHlBuZMqJ3maRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWd46Cju1ese7sCvNHG/EwWyZ8Ql6rfBA81oKI594+S1Y9OGrkhvs1mrhNyY+PelB
         YsvPc7W/VFxkwW7qgDSNupH5JOpx0aIaJswMROCqbJXVIthNaiz7F6FOoeB+eLSOhQ
         E/xA8eJGyWyX0Z1UOPROkT+Y4yb7kES/jJimaFXKRunBOKvxidRr8xA655tGXvUDFi
         K/pLAmRBIKu0oeytsR1VS8uZ5GbYacB7Kcno1zdousREcnq1EKWjvzXVyc9g8441d2
         jg1w2o09qYNxgnIwyl6CRiUqFTA57EHFgZ4Tmwmq/SfL6rctg5pO3V+QfVOJ9RNLN0
         hcpb4NemConyw==
Date:   Thu, 2 Jun 2022 09:55:02 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/12] btrfs: improve batch deletion of delayed dir index
 items
Message-ID: <20220602085502.GA3331364@falcondesktop>
References: <cover.1654009356.git.fdmanana@suse.com>
 <ddec7fd521fe5b0158241a2e111a54bab253f6d3.1654009356.git.fdmanana@suse.com>
 <2cc71b46-7e53-d1a1-327f-39b28b18687e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cc71b46-7e53-d1a1-327f-39b28b18687e@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 02, 2022 at 11:24:53AM +0300, Nikolay Borisov wrote:
> 
> 
> On 31.05.22 г. 18:06 ч., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> 
> <snip>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> One small idea, see further down below though.

That's a rather different thing from what the patch intends, which
is just to improve the deletion of items in the btree.

Send that as a separate patch with a proper changelog.

Thanks.

> 
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/delayed-inode.c | 60 +++++++++++++++++-----------------------
> >   1 file changed, 25 insertions(+), 35 deletions(-)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 0125586fd565..74c806d3ab2a 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -791,68 +791,58 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
> >   {
> 
> <snip>
> 
> > +	while (slot < last_slot) {
> > +		struct btrfs_key key;
> > -		curr = next;
> >   		next = __btrfs_next_delayed_item(curr);
> >   		if (!next)
> >   			break;
> > -		if (!btrfs_is_continuous_delayed_item(curr, next))
> > +		slot++;
> > +		btrfs_item_key_to_cpu(leaf, &key, slot);
> > +		if (btrfs_comp_cpu_keys(&next->key, &key) != 0)
> >   			break;
> > -
> > -		i++;
> > -		if (i > last_item)
> > -			break;
> > -		btrfs_item_key_to_cpu(leaf, &key, i);
> > +		nitems++;
> > +		curr = next;
> > +		list_add_tail(&curr->tree_list, &batch_list);
> >   	}
> > -	/*
> > -	 * Our caller always gives us a path pointing to an existing item, so
> > -	 * this can not happen.
> > -	 */
> > -	ASSERT(nitems >= 1);
> > -	if (nitems < 1)
> > -		return -ENOENT;
> > -
> >   	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
> >   	if (ret)
> > -		goto out;
> > +		return ret;
> > -	list_for_each_entry_safe(curr, next, &head, tree_list) {
> > +	list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
> >   		btrfs_delayed_item_release_metadata(root, curr);
> >   		list_del(&curr->tree_list);
> >   		btrfs_release_delayed_item(curr);
> >   	}
> 
> nit: This function could be further optimized
> with the following snippet.
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index fedbc45b71a2..950f5a2a9950 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -805,6 +805,7 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>         LIST_HEAD(batch_list);
>         int nitems, slot, last_slot;
>         int ret;
> +       u64 bytes_reserved = item->bytes_reserved;
>         ASSERT(leaf != NULL);
> @@ -840,6 +841,7 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>                         break;
>                 nitems++;
>                 curr = next;
> +               bytes_reserved += curr->bytes_reserved;
>                 list_add_tail(&curr->tree_list, &batch_list);
>         }
> @@ -847,8 +849,11 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>         if (ret)
>                 return ret;
> +       btrfs_block_rsv_release(root->fs_info, &root->fs_info->delayed_block_rsv,
> +                               bytes_reserved, NULL);
> +
>         list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
> -               btrfs_delayed_item_release_metadata(root, curr);
> +               //btrfs_delayed_item_release_metadata(root, curr);
>                 list_del(&curr->tree_list);
>                 btrfs_release_delayed_item(curr);
>         }
> 
> 
> Running your series VS this diff on top produces:
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
> 
> > -out:
> > -	return ret;
> > +	return 0;
> >   }
> >   static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
