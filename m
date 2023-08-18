Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AD780A6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359039AbjHRKq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 06:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376513AbjHRKqX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 06:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009342D65
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 03:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79EC963C5D
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 10:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7B3C433C8;
        Fri, 18 Aug 2023 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692355568;
        bh=LN6UujZy8j/jEdN0KdOAtoCWpblTZwfGwJdOJYTkc2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsVKILAwzmeOg9EpNyl0rSgTR/Z/IEy0n/lPztB6fo1JYXnimX0zKugJKkKAQzvnH
         QsPWO9tN8wF8IEPQKBJgp3dU92okO/uxLJIOyNzb3QYw2Nx0GzgqMClmrlWfhXW5Rk
         d8xHo3TRgFA2fjy8m6tqE1KriOaPIXGt8IRaVlmnd+CM/qRiP6IV9TZx4l/Y7ssZuC
         DIy5E3qz1h+1FuS+0wlMtVVBbnS4VLi0A4LesSPMaulOYfVh480jMsguC+TtqGfKzJ
         QDUecgoUCBlhp0AQ0aWMviQ5jPw7l0IlNuwUHu0MeX2f+OxrlZqLj5Ax9w0R1joK7/
         6rKMCCHncQupA==
Date:   Fri, 18 Aug 2023 11:46:06 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/4] btrfs: fix incorrect splitting in
 btrfs_drop_extent_map_range
Message-ID: <ZN9L7tGRolPleFkO@debian0.Home>
References: <cover.1692305624.git.josef@toxicpanda.com>
 <e12c86889b1a64879ce6c6cf6f6d315d577295a7.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12c86889b1a64879ce6c6cf6f6d315d577295a7.1692305624.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 04:57:30PM -0400, Josef Bacik wrote:
> In production we were seeing a variety of WARN_ON()'s in the extent_map
> code, specifically in btrfs_drop_extent_map_range() when we have to call
> add_extent_mapping() for our second split.
> 
> Consider the following extent map layout
> 
> PINNED
> [0 16K)  [32K, 48K)
> 
> and then we call btrfs_drop_extent_map_range for [0, 36K), with
> skip_pinned == true.  The initial loop will have
> 
> start = 0
> end = 36K
> len = 36K
> 
> we will find the [0, 16k) extent, but since we are pinned we will skip
> it, which has this cod
> 
> 	start = em_end;
> 	if (end != (u64)-1)
> 		len = start + len - em_end;
> 
> em_end here is 16K, so now the values are
> 
> start = 16K
> len = 16K + 36K - 16K = 36K
> 
> len should instead be 20K.  This is a problem when we find the next
> extent at [32K, 48K), we need to split this extent to leave [36K, 48k),
> however the code for the split looks like this
> 
> 	split->start = start + len;
> 	split->len = em_end - (start + len);
> 
> In this case we have
> 
> em_end = 48K
> split->start = 16K + 36K //this should be 16K + 20K
> split->len = 48K - (16K + 36K) // this overflows as 16K + 36K is 52K
> 
> and now we have an invalid extent_map in the tree that potentially
> overlaps other entries in the extent map.  Even in the non-overlapping
> case we will have split->start set improperly, which will cause problems
> with any block related calculations.
> 
> We don't actually need len in this loop, we can simply use end as our
> end point, and only adjust start up when we find a pinned extent we need
> to skip.
> 
> Adjust the logic to do this, which keeps us from inserting an invalid
> extent map.
> 
> We only skip_pinned in the relocation case, so this is relatively rare,
> except in the case where you are running relocation a lot, which can
> happen with auto relocation on.
> 
> Fixes: 55ef68990029 ("Btrfs: Fix btrfs_drop_extent_cache for skip pinned case")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_map.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 0cdb3e86f29b..a6d8368ed0ed 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -760,8 +760,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
>  
>  		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
>  			start = em_end;
> -			if (end != (u64)-1)
> -				len = start + len - em_end;
>  			goto next;
>  		}
>  
> @@ -829,8 +827,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
>  				if (!split)
>  					goto remove_em;
>  			}
> -			split->start = start + len;
> -			split->len = em_end - (start + len);
> +			split->start = end;
> +			split->len = em_end - end;
>  			split->block_start = em->block_start;
>  			split->flags = flags;
>  			split->compress_type = em->compress_type;
> -- 
> 2.26.3
> 
