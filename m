Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9036EAFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhD2M6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 08:58:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233701AbhD2M6f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 08:58:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10EEDB019;
        Thu, 29 Apr 2021 12:57:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C93AFDA783; Thu, 29 Apr 2021 14:55:24 +0200 (CEST)
Date:   Thu, 29 Apr 2021 14:55:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove redundant assignment to ret
Message-ID: <20210429125524.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1619691320-81639-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619691320-81639-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 06:15:20PM +0800, Jiapeng Chong wrote:
> Variable ret is set to zero but this value is never read as it
> is overwritten or not used later on, hence it is a redundant
> assignment and can be removed.
> 
> Cleans up the following clang-analyzer warning:

I've looked at clang analyzer warnings in the past and the dead stores
were ones of the least useful, namely because of the return value
assignments.

> fs/btrfs/volumes.c:8019:4: warning: Value stored to 'ret' is never read
> [clang-analyzer-deadcode.DeadStores].
> 
> fs/btrfs/volumes.c:4757:4: warning: Value stored to 'ret' is never read
> [clang-analyzer-deadcode.DeadStores].
> 
> fs/btrfs/volumes.c:7951:4: warning: Value stored to 'ret' is never read
> [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/btrfs/volumes.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9a1ead0..30504fa 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4754,7 +4754,6 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  			mutex_unlock(&fs_info->reclaim_bgs_lock);
>  			if (ret < 0)
>  				goto done;
> -			ret = 0;
>  			btrfs_release_path(path);
>  			break;

So this is a code pattern where 'ret' is used for some local function
call but we want to make sure it does not go outside of the block as a
non-zero value, potentially being returned from the whole function.
No harm done if the value is not used later.

>  		}
> @@ -7939,7 +7938,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
>  	struct btrfs_key key;
>  	u64 prev_devid = 0;
>  	u64 prev_dev_ext_end = 0;
> -	int ret = 0;
> +	int ret;

Similar here, initializing ret to zero does no harm. We've had compiler
warnings about unitialized ret when some error path was jumping around
it.

>  
>  	/*
>  	 * We don't have a dev_root because we mounted with ignorebadroots and
> @@ -8016,7 +8015,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
>  		if (ret < 0)
>  			goto out;
>  		if (ret > 0) {
> -			ret = 0;
>  			break;
>  		}

Same pattern as in the first case.
