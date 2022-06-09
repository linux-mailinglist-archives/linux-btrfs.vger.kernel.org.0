Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732255447DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiFIJmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbiFIJmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 05:42:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374664C7BD
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 02:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 63D44CE2D6A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 09:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5091EC3411B;
        Thu,  9 Jun 2022 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654767751;
        bh=3DdYAVDVNVqKgu7ZDQkYO1G+Iek3/llbpR0toah8WPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXXQ9B6bhrtaZLrN4+2aWqMpkSacl7twm2ab6dQV0HMI6UTfiOXvV6F3M9JLVCvwl
         ymdSOFxoC39JfIiHGyxmmaiGSAUwM6e/ellUVG+nFf2oSVhJhOUwnx9QgvUCuwMlZB
         hYLUCp+xl41Da3Xi9kOC03jlpHgsb93RGoEM86XqbbFY91CTmVi1X6fkWZnC5kMkm3
         H5SXF6LxtC+CVIJnTHIyMeFepmBdE/5nxLQa7A1I0t08byOxyiuxfeB9n86PcbngMl
         j+ZYYbRs1tRARiGxXtveahjni5sZwyRBGBh2hguA6/IurTEp3Z9eTQWuE6W9f96/QL
         zjplejUBzhoWw==
Date:   Thu, 9 Jun 2022 10:42:28 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't set lock_owner when locking tree pages for
 reading
Message-ID: <20220609094228.GA3668047@falcondesktop>
References: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 10:39:36PM -0400, Zygo Blaxell wrote:
> In 196d59ab9ccc "btrfs: switch extent buffer tree lock to rw_semaphore"
> the functions for tree read locking were rewritten, and in the process
> the read lock functions started setting eb->lock_owner = current->pid.
> Previously lock_owner was only set in tree write lock functions.
> 
> Read locks are shared, so they don't have exclusive ownership of the
> underlying object, so setting lock_owner to any single value for a
> read lock makes no sense.  It's mostly harmless because write locks
> and read locks are mutually exclusive, and none of the existing code
> in btrfs (btrfs_init_new_buffer and print_eb_refs_lock) cares what
> nonsense is written in lock_owner when no writer is holding the lock.
> 
> KCSAN does care, and will complain about the data race incessantly.
> Remove the assignments in the read lock functions because they're
> useless noise.
> 
> Fixes: 196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")
> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>


Looks good to me.
Btw, the subject is misleading, the part "when locking tree pages" gives
the idea that it's about page locks, but what we are locking is an extent
buffer, so it should read like "... when locking extent buffer for reading".
Thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/locking.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 313d9d685adb..33461b4f9c8b 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -45,7 +45,6 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
>  		start_ns = ktime_get_ns();
>  
>  	down_read_nested(&eb->lock, nest);
> -	eb->lock_owner = current->pid;
>  	trace_btrfs_tree_read_lock(eb, start_ns);
>  }
>  
> @@ -62,7 +61,6 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
>  int btrfs_try_tree_read_lock(struct extent_buffer *eb)
>  {
>  	if (down_read_trylock(&eb->lock)) {
> -		eb->lock_owner = current->pid;
>  		trace_btrfs_try_tree_read_lock(eb);
>  		return 1;
>  	}
> @@ -90,7 +88,6 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
>  void btrfs_tree_read_unlock(struct extent_buffer *eb)
>  {
>  	trace_btrfs_tree_read_unlock(eb);
> -	eb->lock_owner = 0;
>  	up_read(&eb->lock);
>  }
>  
> -- 
> 2.30.2
> 
