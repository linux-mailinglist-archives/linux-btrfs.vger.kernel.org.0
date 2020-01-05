Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8B13087A
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEOtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 09:49:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:45350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgAEOtg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 09:49:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1663AC3C;
        Sun,  5 Jan 2020 14:49:32 +0000 (UTC)
Subject: Re: [PATCH] btrfs: relocation: Fix KASAN reports caused by extended
 reloc tree lifespan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <933b818f-e83f-5080-7a6e-ba587f013986@suse.com>
Date:   Sun, 5 Jan 2020 16:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200104135602.34601-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.01.20 г. 15:56 ч., Qu Wenruo wrote:
> [BUG]
> There are several different KASAN reports for balance + snapshot
> workloads.
> Involved call paths include:
> 
>    should_ignore_root+0x54/0xb0 [btrfs]
>    build_backref_tree+0x11af/0x2280 [btrfs]
>    relocate_tree_blocks+0x391/0xb80 [btrfs]
>    relocate_block_group+0x3e5/0xa00 [btrfs]
>    btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
>    btrfs_relocate_chunk+0x53/0xf0 [btrfs]
>    btrfs_balance+0xc91/0x1840 [btrfs]
>    btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
>    btrfs_ioctl+0x8af/0x3e60 [btrfs]
>    do_vfs_ioctl+0x831/0xb10
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x43/0x50
>    do_syscall_64+0x79/0xe0
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>    create_reloc_root+0x9f/0x460 [btrfs]
>    btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
>    create_pending_snapshot+0xa9b/0x15f0 [btrfs]
>    create_pending_snapshots+0x111/0x140 [btrfs]
>    btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>    btrfs_mksubvol+0x915/0x960 [btrfs]
>    btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>    btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>    btrfs_ioctl+0x241b/0x3e60 [btrfs]
>    do_vfs_ioctl+0x831/0xb10
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x43/0x50
>    do_syscall_64+0x79/0xe0
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>    btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
>    create_pending_snapshot+0x209/0x15f0 [btrfs]
>    create_pending_snapshots+0x111/0x140 [btrfs]
>    btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>    btrfs_mksubvol+0x915/0x960 [btrfs]
>    btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>    btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>    btrfs_ioctl+0x241b/0x3e60 [btrfs]
>    do_vfs_ioctl+0x831/0xb10
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x43/0x50
>    do_syscall_64+0x79/0xe0
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [CAUSE]
> All these call sites are only relying on root->reloc_root, which can
> undergo btrfs_drop_snapshot(), and since we don't have real refcount
> based protection to reloc roots, we can reach already dropped reloc
> root, triggering KASAN.
> 
> [FIX]
> To avoid such access to unstable root->reloc_root, we should check
> BTRFS_ROOT_DEAD_RELOC_TREE bit first.
> 
> This patch introduces a new wrapper, have_reloc_root(), to do the proper
> check for most callers who don't distinguish merged reloc tree and no
> reloc tree.
> 
> The only exception is should_ignore_root(), as merged reloc tree can be
> ignored, while no reloc tree shouldn't.
> 
> Also, set_bit()/clear_bit()/test_bit() doesn't imply a memory barrier,
> and BTRFS_ROOT_DEAD_RELOC_TREE is the only indicator, also add extra
> memory barrier for that bit.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Singed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Difference between this and David's diff:
> - Use proper smp_mb__after_atomic() for clear_bit()
> - Use test_bit() only check for should_ignore_root()
>   That call site is an except, can't go regular have_reloc_root() check
> - Add extra comment for have_reloc_root()
> ---
>  fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d897a8e5e430..586f045bb6dc 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -517,6 +517,23 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
>  	return 1;
>  }
>  
> +/*
> + * Check if this subvolume tree has valid reloc(*) tree.
> + *
> + * *: Reloc tree after swap is considered dead, thus not considered as valid.
> + *    This is enough for most callers, as they don't distinguish dead reloc
> + *    root from no reloc root.
> + *    But should_ignore_root() below is a special case.
> + */
> +static bool have_reloc_root(struct btrfs_root *root)
> +{
> +	smp_mb__before_atomic();
> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> +		return false;
> +	if (!root->reloc_root)
> +		return false;
> +	return true;
> +}
>  
>  static int should_ignore_root(struct btrfs_root *root)
>  {
> @@ -525,6 +542,11 @@ static int should_ignore_root(struct btrfs_root *root)
>  	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>  		return 0;
>  
> +	/* This root has been merged with its reloc tree, we can ignore it */
> +	smp_mb__before_atomic();

Haven't analyzed the patch deeply but if you add memory barriers you
*must* add comments explaining the ordering guarantees those barriers
provide.

<snip>
