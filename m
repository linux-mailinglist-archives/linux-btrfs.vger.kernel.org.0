Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E493D845E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 02:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhG1ACI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 20:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232766AbhG1ACH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 20:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1068D60F41;
        Wed, 28 Jul 2021 00:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627430527;
        bh=u1L3/fBZGfpGz6BbxBXJosMfsTcFutweTcDjoqIjV/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fB5q68iR1za5ayL1Yi8xxi18/Ree2cdt3FfFwi1KJDhZ7J/7BWiePjz4wI6+YHH6K
         Jyq6U7igLuesKIIOs6iXsR/um2QxyUTFlLgCRKxgtIsgvqRYoxz1+Q7N6qyqJiAa/4
         tqfFNHrAjgyl8FprW0g3yM/75QGo/QW22pT0lzBWXDCshvpQ4QhmWIyB77WkwQkPvR
         inRMCuG0Mf9sQb1bz0mzlDML2x1O+cJxjZlVf9V6rspXqqZWPxwtM9GQ1rJsS4DNkt
         b7J10001O7KMV+W2h3Jkh4F+zftgjnaLP1eTgQ/9IVoa/j5vr484tZqOnVRVG8uGgy
         GBvlVPF80KShg==
Date:   Tue, 27 Jul 2021 17:02:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/7] btrfs: Allocate btrfs_ioctl_balance_args on stack
Message-ID: <20210728000206.GA1241197@magnolia>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <320216bed8e0c28e9235571db1962cbb1e18366a.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320216bed8e0c28e9235571db1962cbb1e18366a.1627418762.git.rgoldwyn@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 04:17:28PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_balance_args, allocate
> btrfs_ioctl_balance_args on stack.
> 
> sizeof(btrfs_ioctl_balance_args) = 1024

That's a pretty big addition to the stack frame.  Aren't some of the
kbuild robots configured to whinge about functions that eat more than
1100 bytes or so?

--D

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ioctl.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 90b134b5a653..9c3acc539052 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4141,7 +4141,7 @@ static long btrfs_ioctl_balance_ctl(struct btrfs_fs_info *fs_info, int cmd)
>  static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
>  					 void __user *arg)
>  {
> -	struct btrfs_ioctl_balance_args *bargs;
> +	struct btrfs_ioctl_balance_args bargs = {0};
>  	int ret = 0;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -4153,18 +4153,11 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
>  		goto out;
>  	}
>  
> -	bargs = kzalloc(sizeof(*bargs), GFP_KERNEL);
> -	if (!bargs) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	btrfs_update_ioctl_balance_args(fs_info, bargs);
> +	btrfs_update_ioctl_balance_args(fs_info, &bargs);
>  
> -	if (copy_to_user(arg, bargs, sizeof(*bargs)))
> +	if (copy_to_user(arg, &bargs, sizeof(bargs)))
>  		ret = -EFAULT;
>  
> -	kfree(bargs);
>  out:
>  	mutex_unlock(&fs_info->balance_mutex);
>  	return ret;
> -- 
> 2.32.0
> 
