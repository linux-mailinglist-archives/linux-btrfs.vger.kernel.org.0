Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1697157CE3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 16:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiGUOwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGUOwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 10:52:37 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 07:52:36 PDT
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDAE27CD7;
        Thu, 21 Jul 2022 07:52:36 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 19AB080AA3;
        Thu, 21 Jul 2022 10:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658414828; bh=ncqPM5vdKuFQDcqYet0UNkbdtGe6dSYkRKLHsgnTL8g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FLhI3SS2C01EXlMzqJwBDrVT4ydnt7LcBqFVGGxcIEbhAEJ6GQ1GYVyismRojqGPC
         k1L+Jg7/8OwUzohMK/1RfGgKhVZbTWh1e7XYPpWKjNG5mIH80K5ftcFu0JqQaFAuw6
         pO2Zl/7BMnfQJ3IL7NDAyYZqgJ/hf2J/n/3at+S7bQHmfRz8hVakdZARt9ATgUU7/6
         EdlzwU349IUuuBh/MaUpkuDT0tPRg/sYkIblVjCylEKcQ1lnLLcMpGWzB9jlT1My4d
         7vf3EArzaDwb6rCW1DQ2BhKq2OMkfAlyK7rRkZhmir3w1zcShtxWDg6IZEgW71+r5a
         K+5LC6CSaC0aA==
Message-ID: <f8a33d2a-bd88-867b-2424-032c363c323d@dorminy.me>
Date:   Thu, 21 Jul 2022 10:47:05 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] fs: btrfs: fix a possible use-after-free bug caused by
 incorrect error handling in prepare_to_relocate()
Content-Language: en-US
To:     Zixuan Fu <r33s3n6@gmail.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20220721074829.2905233-1-r33s3n6@gmail.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220721074829.2905233-1-r33s3n6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 7/21/22 03:48, Zixuan Fu wrote:
> In btrfs_relocate_block_group(), the structure variable rc is allocated.
> Then btrfs_relocate_block_group() calls relocate_block_group() ->
> prepare_to_relocate() -> set_reloc_control(), and assigns rc to the
> variable fs_info->reloc_ctl. When prepare_to_relocate() returns, it
> calls btrfs_commit_transaction() -> btrfs_start_dirty_block_groups()
> -> btrfs_alloc_path() -> kmem_cache_zalloc(), which may fail. When the
> failure occurs, btrfs_relocate_block_group() detects the error and frees
> rc and doesn't set fs_info->reloc_ctl to NULL. After that, in
> btrfs_init_reloc_root(), rc is retrieved from fs_info->reloc_ctl and
> then used, which may cause a use-after-free bug.
> 
> This possible bug can be triggered by calling btrfs_ioctl_balance()
> before calling btrfs_ioctl_defrag().
> 
> To fix this possible bug, in prepare_to_relocate(), an if statement
> is added to check whether btrfs_commit_transaction() fails. If the
> failure occurs, unset_reloc_control() is called to set
> fs_info->reloc_ctl to NULL.
> 
> The error log in our fault-injection testing is shown as follows:
> 
> [   58.751070] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
> ...
> [   58.753577] Call Trace:
> ...
> [   58.755800]  kasan_report+0x45/0x60
> [   58.756066]  btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
> [   58.757304]  record_root_in_trans+0x792/0xa10 [btrfs]
> [   58.757748]  btrfs_record_root_in_trans+0x463/0x4f0 [btrfs]
> [   58.758231]  start_transaction+0x896/0x2950 [btrfs]
> [   58.758661]  btrfs_defrag_root+0x250/0xc00 [btrfs]
> [   58.759083]  btrfs_ioctl_defrag+0x467/0xa00 [btrfs]
> [   58.759513]  btrfs_ioctl+0x3c95/0x114e0 [btrfs]
> ...
> [   58.768510] Allocated by task 23683:
> [   58.768777]  ____kasan_kmalloc+0xb5/0xf0
> [   58.769069]  __kmalloc+0x227/0x3d0
> [   58.769325]  alloc_reloc_control+0x10a/0x3d0 [btrfs]
> [   58.769755]  btrfs_relocate_block_group+0x7aa/0x1e20 [btrfs]
> [   58.770228]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
> [   58.770655]  __btrfs_balance+0x1326/0x1f10 [btrfs]
> [   58.771071]  btrfs_balance+0x3150/0x3d30 [btrfs]
> [   58.771472]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
> [   58.771902]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
> ...
> [   58.773337] Freed by task 23683:
> ...
> [   58.774815]  kfree+0xda/0x2b0
> [   58.775038]  free_reloc_control+0x1d6/0x220 [btrfs]
> [   58.775465]  btrfs_relocate_block_group+0x115c/0x1e20 [btrfs]
> [   58.775944]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
> [   58.776369]  __btrfs_balance+0x1326/0x1f10 [btrfs]
> [   58.776784]  btrfs_balance+0x3150/0x3d30 [btrfs]
> [   58.777185]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
> [   58.777621]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
> ...
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>   fs/btrfs/relocation.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index a6dc827e75af..342ade83d062 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3573,7 +3573,12 @@ int prepare_to_relocate(struct reloc_control *rc)
>   		 */
>   		return PTR_ERR(trans);
>   	}
> -	return btrfs_commit_transaction(trans);
> +
> +	ret = btrfs_commit_transaction(trans);
> +	if (ret)
> +		unset_reloc_control(rc);
> +
> +	return ret;
>   }
>   
>   static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
