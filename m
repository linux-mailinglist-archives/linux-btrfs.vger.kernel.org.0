Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6672467643
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 12:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380408AbhLCL2p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 06:28:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51776 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380405AbhLCL2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 06:28:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CF02B826AD
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 11:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3386AC53FAD;
        Fri,  3 Dec 2021 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530719;
        bh=rCCbFC9TbN48lbID4tPB3s6EmbS++hjTWmsB1lJ4yrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWeEfJUu9JWjsmFzXBY5CV8I78vu3ZbZdwJR7iTtHqtLqdhJ7I6kRZVzS8NkmaVO+
         6GREbCn/oVvOCJfTSwJHWEZPYsxZP9gJ2zHql4FUs5Gr1rfUfWqp1b5SqMU8X7SD5n
         HLC3qiCWtRRizneoZtTR6dcTZiubKpGErww1ybjBL8xtUmhPN7gSCIcq5E3EsUolUs
         YVRpPYSCCa0WacKHd/0FHqc8p0P74R4+5xOYGxneht6vk1wBYG0v9WFz8FoN/ikegJ
         5cdz85RJJELLmSz+Ip5uiObXiE4bofZ/+sHZAd3mRx9RvdJoPXccU6WXhM/BsxIjAK
         uznlAQIm9hmgQ==
Date:   Fri, 3 Dec 2021 11:25:17 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: free exchange changeset on failures
Message-ID: <Yan+ncm6Vc8bdl/5@debian9.Home>
References: <95ce11234dd6911a433b1a016e4d4194856212b5.1638523623.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ce11234dd6911a433b1a016e4d4194856212b5.1638523623.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 02:55:33AM -0800, Johannes Thumshirn wrote:
> Fstests runs on my VMs have show several kmemleak reports like the following.
> 
>   unreferenced object 0xffff88811ae59080 (size 64):
>     comm "xfs_io", pid 12124, jiffies 4294987392 (age 6.368s)
>     hex dump (first 32 bytes):
>       00 c0 1c 00 00 00 00 00 ff cf 1c 00 00 00 00 00  ................
>       90 97 e5 1a 81 88 ff ff 90 97 e5 1a 81 88 ff ff  ................
>     backtrace:
>       [<00000000ac0176d2>] ulist_add_merge+0x60/0x150 [btrfs]
>       [<0000000076e9f312>] set_state_bits+0x86/0xc0 [btrfs]
>       [<0000000014fe73d6>] set_extent_bit+0x270/0x690 [btrfs]
>       [<000000004f675208>] set_record_extent_bits+0x19/0x20 [btrfs]
>       [<00000000b96137b1>] qgroup_reserve_data+0x274/0x310 [btrfs]
>       [<0000000057e9dcbb>] btrfs_check_data_free_space+0x5c/0xa0 [btrfs]
>       [<0000000019c4511d>] btrfs_delalloc_reserve_space+0x1b/0xa0 [btrfs]
>       [<000000006d37e007>] btrfs_dio_iomap_begin+0x415/0x970 [btrfs]
>       [<00000000fb8a74b8>] iomap_iter+0x161/0x1e0
>       [<0000000071dff6ff>] __iomap_dio_rw+0x1df/0x700
>       [<000000002567ba53>] iomap_dio_rw+0x5/0x20
>       [<0000000072e555f8>] btrfs_file_write_iter+0x290/0x530 [btrfs]
>       [<000000005eb3d845>] new_sync_write+0x106/0x180
>       [<000000003fb505bf>] vfs_write+0x24d/0x2f0
>       [<000000009bb57d37>] __x64_sys_pwrite64+0x69/0xa0
>       [<000000003eba3fdf>] do_syscall_64+0x43/0x90
> 
> In case brtfs_qgroup_reserve_data() or btrfs_delalloc_reserve_metadata()
> fail the allocated extent_changeset will not be freed.
> 
> So in btrfs_check_data_free_space() and btrfs_delalloc_reserve_space()
> free the allocated extent_changeset to get rid of the allocated memory.
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Looks good, and it ran successfully on my fstests run with kmemleak as well.

Just a note worth adding, is that the issue currently only happens in the
direct IO write path, but only after my change "btrfs: fix ENOSPC failure
when attempting direct IO write into NOCOW range", and also at
defrag_one_locked_target() (haven't checked since when). Every other place
is always calling extent_changeset_free() even if its call to
btrfs_delalloc_reserve_space() or btrfs_check_data_free_space() has failed.

With that, which probably David can add, it looks good:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/delalloc-space.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index bca438c7c972..fb46a28f5065 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -143,10 +143,13 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
>  
>  	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
>  	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		btrfs_free_reserved_data_space_noquota(fs_info, len);
> -	else
> +		extent_changeset_free(*reserved);
> +		*reserved = NULL;
> +	} else {
>  		ret = 0;
> +	}
>  	return ret;
>  }
>  
> @@ -452,8 +455,11 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
>  	if (ret < 0)
>  		return ret;
>  	ret = btrfs_delalloc_reserve_metadata(inode, len);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		btrfs_free_reserved_data_space(inode, *reserved, start, len);
> +		extent_changeset_free(*reserved);
> +		*reserved = NULL;
> +	}
>  	return ret;
>  }
>  
> -- 
> 2.31.1
> 
