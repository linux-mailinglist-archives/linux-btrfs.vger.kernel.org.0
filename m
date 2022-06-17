Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5785B54F541
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiFQKVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiFQKVu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9DC6A058
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85B3DB82853
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 10:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24BFC3411B;
        Fri, 17 Jun 2022 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655461307;
        bh=D0/CxniUakwdN3SCKHiGK4G9gAZoGYX8LKoHxE713Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5lzCo1OLxzaRW4z1C0rBR8PwiDSmCLqMoy9nZcKgFh7pOMWtzqLTh3qO5wHin9Uv
         XxjgeOSJLI+ayfWslW1rboeF34864tzS9bRVpWfaaq8rvQXj+Iv+w7KT2lLiz2L9el
         9x7hcGgWcFA9ft1k/rrCB8QXvphNVF3NO+Wijcs8mw49w7L0uiMBMUG1OzdHrCfn0N
         662xmdoLgR3eesXQiCc9MW+KBlEEKdoI34qOWRctvz6u08HgIdKCBysW1oSaVkIn4L
         J1PNzuYppFAncI+YZZgtiDjdZGQlYxAzMAAUiPlH7amKgi4NOjjhUH/R/YkDxOREH3
         z9qNdkgEhY7MA==
Date:   Fri, 17 Jun 2022 11:21:44 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: fix error handling of fallbacked uncompress
 write
Message-ID: <20220617102144.GD4041436@falcondesktop>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <f0ac3032fcd07344a84a9b1f7d05f8862aa60760.1655391633.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ac3032fcd07344a84a9b1f7d05f8862aa60760.1655391633.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 12:45:41AM +0900, Naohiro Aota wrote:
> When cow_file_range() fails in the middle of the allocation loop, it
> unlocks the pages but remains the ordered extents intact. Thus, we need to

s/remains/leaves/

> call btrfs_cleanup_ordered_extents() to finish the created ordered extents.
> 
> Also, we need to call end_extent_writepage() if locked_page is available
> because btrfs_cleanup_ordered_extents() never process the region on the
> locked_page.
> 
> Furthermore, we need to set the mapping as error if locked_page is
> unavailable before unlocking the pages, so that the errno is properly
> propagated to the userland.
> 
> CC: stable@vger.kernel.org

It would be better to specify a version here.

The delalloc paths for compression were (a bit heavily) refactored last year
in preparation for the subpage sector size support, so blindly adding this
to any stable releases might introduce regressions (assuming the patch does
not fail to apply).

> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4e1100f84a88..cae15924fc99 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -934,8 +934,18 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
>  		goto out;
>  	}
>  	if (ret < 0) {
> -		if (locked_page)
> +		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
> +		if (locked_page) {
> +			u64 page_start = page_offset(locked_page);
> +			u64 page_end = page_start + PAGE_SIZE - 1;
> +
> +			btrfs_page_set_error(inode->root->fs_info, locked_page,
> +					     page_start, PAGE_SIZE);
> +			set_page_writeback(locked_page);
> +			end_page_writeback(locked_page);
> +			end_extent_writepage(locked_page, ret, page_start, page_end);
>  			unlock_page(locked_page);
> +		}
>  		goto out;
>  	}

So as I commented in the previous patch, something is missing here: the call to
btrfs_cleanup_ordered_extents() at submit_uncompressed_range() in case cow_file_range()
returns an error.

Otherwise it looks fine.
Thanks.

>  
> @@ -1390,9 +1400,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	 * However, in case of unlock == 0, we still need to unlock the pages
>  	 * (except @locked_page) to ensure all the pages are unlocked.
>  	 */
> -	if (!unlock && orig_start < start)
> +	if (!unlock && orig_start < start) {
> +		if (!locked_page)
> +			mapping_set_error(inode->vfs_inode.i_mapping, ret);
>  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
>  					     locked_page, 0, page_ops);
> +	}
>  
>  	/*
>  	 * For the range (2). If we reserved an extent for our delalloc range
> -- 
> 2.35.1
> 
