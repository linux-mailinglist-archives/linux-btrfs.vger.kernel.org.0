Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECC127775E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIXREA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 13:04:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXREA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 13:04:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50773AB54;
        Thu, 24 Sep 2020 17:03:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8358DA6E3; Thu, 24 Sep 2020 19:02:40 +0200 (CEST)
Date:   Thu, 24 Sep 2020 19:02:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 1/4] btrfs: support remount of ro fs with free space
 tree
Message-ID: <20200924170240.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <1d0cca6ce1f67484c6b7ef591e264c04ca740c96.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0cca6ce1f67484c6b7ef591e264c04ca740c96.1600282812.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 11:13:38AM -0700, Boris Burkov wrote:
>  #include "block-group.h"
>  #include "discard.h"
> +#include "free-space-tree.h"
>  
>  #include "qgroup.h"
>  #define CREATE_TRACE_POINTS
> @@ -1838,6 +1839,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	u64 old_max_inline = fs_info->max_inline;
>  	u32 old_thread_pool_size = fs_info->thread_pool_size;
>  	u32 old_metadata_ratio = fs_info->metadata_ratio;
> +	bool create_fst = false;
>  	int ret;
>  
>  	sync_filesystem(sb);
> @@ -1862,6 +1864,16 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	btrfs_resize_thread_pool(fs_info,
>  		fs_info->thread_pool_size, old_thread_pool_size);
>  
> +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
> +	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> +		create_fst = true;
> +		if (!sb_rdonly(sb) || *flags & SB_RDONLY) {
> +			btrfs_warn(fs_info,
> +				   "Remounting with free space tree only supported from read-only to read-write");

lowercase for start of the sting, unindent it so ends below 80 columns

> +			create_fst = false;
> +		}
> +	}
> +
>  	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
>  		goto out;
>  
> @@ -1924,6 +1936,21 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  			goto restore;
>  		}
>  
> +		/*
> +		 * NOTE: when remounting with a change that does writes, don't
> +		 * put it anywhere above this point, as we are not sure to be
> +		 * safe to write until we pass the above checks.
> +		 */
> +		if (create_fst) {
> +			ret = btrfs_create_free_space_tree(fs_info);
> +			if (ret) {
> +				btrfs_warn(fs_info,
> +					   "failed to create free space tree: %d", ret);

same

> +				goto restore;
> +			}
> +		}
> +
> +
>  		ret = btrfs_cleanup_fs_roots(fs_info);
>  		if (ret)
>  			goto restore;
> -- 
> 2.24.1
