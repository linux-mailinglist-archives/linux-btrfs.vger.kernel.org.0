Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D657AB0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 02:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiGTAmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 20:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiGTAmJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 20:42:09 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E44F5AC
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 17:42:07 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1836780425;
        Tue, 19 Jul 2022 20:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658277727; bh=2P5JprYgoTjQR2AW3DIwf3vkIu/HEbbql1EYQndXdX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZwU301Fp6upV8Ka3/wH0nLqhfbIqGmbsNFnm6NbqsBX+BUTa72H0FScKtJFJ9JrTv
         2sz+ekhEJo8QaanqWOxGVr5xE/VHirC3yJJL11RZooJBJsLBHTUoBQXPLjM/c5lOS7
         XwdBj4FZcvcVBf0QniduAfx6fF3iU6U15Rj8ttOmXyce7NrtrngX+HFElFqyLagxcW
         12KXZpcHkAmvbfvMA4lWo0tJRO4C6MOEMPrAUK3BeoadvuK0pXuAaB2WasYNeaZtBD
         z07wmXc7wFR0o74xVEGXcyRGO9Cyf+3UVwgY23mLUZ0UJEtFlyLjEdDY0v9KGohXLh
         rhZb8vd5reYGg==
Message-ID: <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
Date:   Tue, 19 Jul 2022 20:42:04 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
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



On 7/19/22 01:11, Qu Wenruo wrote:
> We have hit some transaction abort due to -ENOSPC internally.
> 
> Normally we should always reserve enough space for metadata for every
> transaction, thus hitting -ENOSPC should really indicate some cases we
> didn't expect.
> 
> But unfrotunately current error reporting will only give a kernel
> wanring and backtrace, not really helpful to debug what's causing the
> problem.
> 
> And debug_enospc can only help when user can reproduce the problem, but
> under most cases, such transaction abort by -ENOSPC is really hard to
> reproduce.
> 
> So this patch will dump all space infos (data, metadata, system) when we
> abort the first transaction with -ENOSPC.
> 
> This should at least provide some clue to us.
> 
> The example of a dump would look like this:
> 
>   ------------[ cut here ]------------
>   <skip stack dump>
>   ---[ end trace 0000000000000000 ]---
>   BTRFS info (device dm-4: state A): dumpping space info >   BTRFS info (device dm-4: state A): space_info DATA has 8388608 
free, is not full
>   BTRFS info (device dm-4: state A):   total:         8388608
>   BTRFS info (device dm-4: state A):   used:          0
>   BTRFS info (device dm-4: state A):   pinned:        0
>   BTRFS info (device dm-4: state A):   reserved:      0
>   BTRFS info (device dm-4: state A):   may_use:       0
>   BTRFS info (device dm-4: state A):   read_only:     0
>   BTRFS info (device dm-4: state A): space_info META has 263979008 free, is not full
>   BTRFS info (device dm-4: state A):   total:         268435456
>   BTRFS info (device dm-4: state A):   used:          131072
>   BTRFS info (device dm-4: state A):   pinned:        65536
>   BTRFS info (device dm-4: state A):   reserved:      0
>   BTRFS info (device dm-4: state A):   may_use:       4194304
>   BTRFS info (device dm-4: state A):   read_only:     65536
>   BTRFS info (device dm-4: state A): space_info SYS has 8372224 free, is not full
>   BTRFS info (device dm-4: state A):   total:         8388608
>   BTRFS info (device dm-4: state A):   used:          16384
>   BTRFS info (device dm-4: state A):   pinned:        0
>   BTRFS info (device dm-4: state A):   reserved:      0
>   BTRFS info (device dm-4: state A):   may_use:       0
>   BTRFS info (device dm-4: state A):   read_only:     0
>   BTRFS info (device dm-4: state A): dumping metadata reservation: (reserved/size)
>   BTRFS info (device dm-4: state A):   global:          (3670016/3670016)
>   BTRFS info (device dm-4: state A):   trans:           (0/0)
>   BTRFS info (device dm-4: state A):   chunk:           (0/0)
>   BTRFS info (device dm-4: state A):   delayed_inode:   (0/0)
>   BTRFS info (device dm-4: state A):   delayed_refs:    (524288/524288)
>   BTRFS: error (device dm-1: state A) in cleanup_transaction:1971: errno=-28 No space left
>   BTRFS info (device dm-1: state EA): forced readonly
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ctree.h      |  6 ++++--
>   fs/btrfs/space-info.c | 14 ++++++++++++++
>   fs/btrfs/space-info.h |  2 ++
>   fs/btrfs/super.c      |  4 +++-
>   4 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e2569f84aab..3d6fd7f6b339 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3739,7 +3739,7 @@ const char * __attribute_const__ btrfs_decode_error(int errno);
>   __cold
>   void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>   			       const char *function,
> -			       unsigned int line, int errno);
> +			       unsigned int line, int errno, bool first_hit);
>   
>   /*
>    * Call btrfs_abort_transaction as early as possible when an error condition is
> @@ -3747,9 +3747,11 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>    */
>   #define btrfs_abort_transaction(trans, errno)		\
>   do {								\
> +	bool first = false;					\
>   	/* Report first abort since mount */			\
>   	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
>   			&((trans)->fs_info->fs_state))) {	\
> +		first = true;					\
>   		if ((errno) != -EIO && (errno) != -EROFS) {		\
>   			WARN(1, KERN_DEBUG				\
>   			"BTRFS: Transaction aborted (error %d)\n",	\
> @@ -3761,7 +3763,7 @@ do {								\
>   		}						\
>   	}							\
>   	__btrfs_abort_transaction((trans), __func__,		\
> -				  __LINE__, (errno));		\
> +				  __LINE__, (errno), first);	\
>   } while (0)
>   
>   #ifdef CONFIG_PRINTK_INDEX
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 81457049816e..af2b3f5ef2b0 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1717,3 +1717,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
>   	}
>   	return ret;
>   }
> +
> +/* Dump all the space infos when we abort a transaction due to ENOSPC. */
> +__cold void btrfs_dump_fs_space_info(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_space_info *space_info;
> +
> +	btrfs_info(fs_info, "dumping space info:");
> +	list_for_each_entry(space_info, &fs_info->space_info, list) {
> +		spin_lock(&space_info->lock);
> +		__btrfs_dump_space_info(fs_info, space_info);
> +		spin_unlock(&space_info->lock);
> +	}
> +	dump_metadata_rsv(fs_info);
> +}
This function looks similar to btrfs_dump_space_info(), and the name and 
callsite doesn't help distinguish it very much to me. It seems 
potentially useful to print all the space_infos when one space_info 
encounters a problem, and it seems potentially useful to print the block 
group infos when we're dumping all the space infos already, so maybe the
two functions could be combined.

Maybe you could adjust btrfs_dump_space_info() to print all the space 
infos, starting with the one passed in (potentially NULL), and call it 
instead of this new function?

> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index e7de24a529cf..01287a7a22a4 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -157,4 +157,6 @@ static inline void btrfs_space_info_free_bytes_may_use(
>   }
>   int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
>   			     enum btrfs_reserve_flush_enum flush);
> +void btrfs_dump_fs_space_info(struct btrfs_fs_info *fs_info);
> +
>   #endif /* BTRFS_SPACE_INFO_H */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4c7089b1681b..f6bc8aa00f44 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -346,12 +346,14 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
>   __cold
>   void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>   			       const char *function,
> -			       unsigned int line, int errno)
> +			       unsigned int line, int errno, bool first_hit)
>   {
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   
>   	WRITE_ONCE(trans->aborted, errno);
>   	WRITE_ONCE(trans->transaction->aborted, errno);
> +	if (first_hit && errno == -ENOSPC)
> +		btrfs_dump_fs_space_info(fs_info);
>   	/* Wake up anybody who may be waiting on this transaction */
>   	wake_up(&fs_info->transaction_wait);
>   	wake_up(&fs_info->transaction_blocked_wait);
DO_ONCE_LITE(btrfs_dump_fs_space_info, fs_info) from <linux/once_lite.h> 
seems like a more lightweight way to dump the space infos once upon 
first transaction abort. Then you don't have to plumb through the 
'first_hit' parameter from btrfs_abort_transaction(), and this change 
becomes even more minimal than it already is.
