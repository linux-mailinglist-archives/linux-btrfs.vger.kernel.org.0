Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2577F68C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350851AbjHQMks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350898AbjHQMko (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 08:40:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802A2D5F
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 05:40:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5908B2187A;
        Thu, 17 Aug 2023 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692276042;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IfOvtIzsn+r1kozaL4/Ll7Wh2du9LkDiDKVxjbx0RhE=;
        b=yxed3w5oFuz1wLvqcziC21sMMhfSOsy7+kMeIs6jWZRNaCEHLXd9IDJzIFvCu22lEhQrgY
        W9FoZ5b1pThfo/MBGrr9TrcyRvTye5vhz+P5W3zf+ntNaifrePkO6+k0M9svzrbs9jsac6
        2kQY0NjlNhKXfmkdcT7H7y7ShRs3S80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692276042;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IfOvtIzsn+r1kozaL4/Ll7Wh2du9LkDiDKVxjbx0RhE=;
        b=3yn0PFx3Om1/qavW+W5zgs0emLCHuO88HDyocoZ14Gx/IV/YTK2GT82xxM5oqZtz2VDdUY
        RXXQwtb7ek+2J7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24BC21392B;
        Thu, 17 Aug 2023 12:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VLE8CEoV3mT9ZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 12:40:42 +0000
Date:   Thu, 17 Aug 2023 14:34:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: Use a folio array throughout the defrag
 process
Message-ID: <20230817123413.GN2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230814170350.756488-1-willy@infradead.org>
 <20230814170350.756488-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814170350.756488-2-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 06:03:50PM +0100, Matthew Wilcox (Oracle) wrote:
> @@ -1020,7 +1020,7 @@ static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
>   */
>  static int defrag_one_locked_target(struct btrfs_inode *inode,
>  				    struct defrag_target_range *target,
> -				    struct page **pages, int nr_pages,
> +				    struct folio **folios, int nr_pages,

The nr_pages can be renamed to nr_folios here so it's in sync. I can fix
that in the commit unless there's a reason to resend the patch.

>  				    struct extent_state **cached_state)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> @@ -1029,7 +1029,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
>  	const u64 len = target->len;
>  	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
>  	unsigned long start_index = start >> PAGE_SHIFT;
> -	unsigned long first_index = page_index(pages[0]);
> +	unsigned long first_index = folios[0]->index;
>  	int ret = 0;
>  	int i;
>  
> @@ -1046,8 +1046,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
>  
>  	/* Update the page status */
>  	for (i = start_index - first_index; i <= last_index - first_index; i++) {
> -		ClearPageChecked(pages[i]);
> -		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
> +		folio_clear_checked(folios[i]);
> +		btrfs_page_clamp_set_dirty(fs_info, &folios[i]->page, start, len);
>  	}
>  	btrfs_delalloc_release_extents(inode, len);
>  	extent_changeset_free(data_reserved);
> @@ -1063,7 +1063,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>  	struct defrag_target_range *entry;
>  	struct defrag_target_range *tmp;
>  	LIST_HEAD(target_list);
> -	struct page **pages;
> +	struct folio **folios;
>  	const u32 sectorsize = inode->root->fs_info->sectorsize;
>  	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
>  	u64 start_index = start >> PAGE_SHIFT;
> @@ -1074,21 +1074,21 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>  	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
>  	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
>  
> -	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> -	if (!pages)
> +	folios = kcalloc(nr_pages, sizeof(struct folio *), GFP_NOFS);
> +	if (!folios)
>  		return -ENOMEM;
>  
>  	/* Prepare all pages */
>  	for (i = 0; i < nr_pages; i++) {
> -		pages[i] = defrag_prepare_one_page(inode, start_index + i);
> -		if (IS_ERR(pages[i])) {
> -			ret = PTR_ERR(pages[i]);
> -			pages[i] = NULL;
> -			goto free_pages;
> +		folios[i] = defrag_prepare_one_folio(inode, start_index + i);
> +		if (IS_ERR(folios[i])) {
> +			ret = PTR_ERR(folios[i]);
> +			nr_pages = i;
> +			goto free_folios;
>  		}
>  	}
>  	for (i = 0; i < nr_pages; i++)
> -		wait_on_page_writeback(pages[i]);
> +		folio_wait_writeback(folios[i]);
>  
>  	/* Lock the pages range */
>  	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
> @@ -1108,7 +1108,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>  		goto unlock_extent;
>  
>  	list_for_each_entry(entry, &target_list, list) {
> -		ret = defrag_one_locked_target(inode, entry, pages, nr_pages,
> +		ret = defrag_one_locked_target(inode, entry, folios, nr_pages,
>  					       &cached_state);
>  		if (ret < 0)
>  			break;
> @@ -1122,14 +1122,12 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>  	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
>  		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
>  		      &cached_state);
> -free_pages:
> +free_folios:
>  	for (i = 0; i < nr_pages; i++) {
> -		if (pages[i]) {
> -			unlock_page(pages[i]);
> -			put_page(pages[i]);
> -		}
> +		folio_unlock(folios[i]);
> +		folio_put(folios[i]);
>  	}
> -	kfree(pages);
> +	kfree(folios);
>  	return ret;
>  }
>  
> -- 
> 2.40.1
