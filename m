Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78FE487576
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 11:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiAGK0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 05:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiAGK0k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 05:26:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDBC061245;
        Fri,  7 Jan 2022 02:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BBDEB8255D;
        Fri,  7 Jan 2022 10:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8EDC36AE9;
        Fri,  7 Jan 2022 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641551198;
        bh=Rw+VYT70aD5bce3sFap9PFdOHR03/WOo/CEeeP8Q5kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1K45Mzyo8h9SscfTquxln5KIJleQLYsL0QcuS47g2lPVIwbIdJh94i7aiMg+4WFG
         CzlKQJ9+NDot5oXzqBSiBQleKFwsG0K6nLDTvxaB+kvGpe517d/iqwZEZ3SqO8IxKA
         IOX7jHzrCVcOuawGrRIukV7G3ZKj+zauMZGywkeMI7jPjYdBYs6/EyL5TQaS8EUTTS
         DoSFgCOKjiHrybr80GRjQAtrJShJJ1+LR5s34JO+3Q/JaSlcBLsQ9RKHKMvOgc2sLZ
         1jVI3vwUdfjuitgem3Wm/om7FkT/xgu/C4YfP5x2jJoGe+g/nAHCW0p54nFNAt3oGj
         dNo3YPqKGeUOA==
Date:   Fri, 7 Jan 2022 10:26:33 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix double unlock bugs in btrfs_compare_trees()
Message-ID: <YdgVWU9lzrXG7Hsu@debian9.Home>
References: <20220107072430.GE22086@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107072430.GE22086@kili>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 10:24:30AM +0300, Dan Carpenter wrote:
> These error paths unlock before the goto, but the goto also unlocks
> so it's a double unlock.

There's also the case where there's an unlock without a previous lock.
I've just sent out a different version of the patch that fixes that as well:

https://lore.kernel.org/linux-btrfs/a7b1b2094bb0697dda72bdd9bf1ed789cb0b9b08.1641550850.git.fdmanana@suse.com/

Thanks.

> 
> Fixes: 5646ffa863d0 ("btrfs: make send work with concurrent block group relocation")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/btrfs/send.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 3fc144b8c0d8..1aa8a0998673 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7152,7 +7152,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
>  	left_path->nodes[left_level] =
>  			btrfs_clone_extent_buffer(left_root->commit_root);
>  	if (!left_path->nodes[left_level]) {
> -		up_read(&fs_info->commit_root_sem);
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> @@ -7162,7 +7161,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
>  	right_path->nodes[right_level] =
>  			btrfs_clone_extent_buffer(right_root->commit_root);
>  	if (!right_path->nodes[right_level]) {
> -		up_read(&fs_info->commit_root_sem);
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -- 
> 2.20.1
> 
