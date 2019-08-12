Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D16898CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfHLIhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 04:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbfHLIhd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 04:37:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC79EAD46;
        Mon, 12 Aug 2019 08:37:30 +0000 (UTC)
Subject: Re: [PATCH 1/1] btrfs: Add global_reserve_size mount option
To:     Vladimir Panteleev <git@thecybershadow.net>,
        linux-btrfs@vger.kernel.org
References: <20190810124101.15440-1-git@thecybershadow.net>
 <20190810124101.15440-2-git@thecybershadow.net>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ebdcf4f9-dd5e-b4ec-4a5b-ccda52c825d4@suse.com>
Date:   Mon, 12 Aug 2019 11:37:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810124101.15440-2-git@thecybershadow.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.19 г. 15:41 ч., Vladimir Panteleev wrote:
> In some circumstances (filesystems with many extents and backrefs),
> the global reserve gets overrun causing balance and device deletion
> operations to fail with -ENOSPC. Providing a way for users to increase
> the global reserve size can allow them to complete the operation.
> 
> Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>

I'm inclined to NAK this patch. On the basis that it pampers over
deficiencies in the current ENOSPC handling algorithms. Furthermore in
your cover letter you state that you don't completely understand the
root cause. So at the very best this is pampering over a bug.

> ---
>  fs/btrfs/block-rsv.c |  2 +-
>  fs/btrfs/ctree.h     |  3 +++
>  fs/btrfs/disk-io.c   |  1 +
>  fs/btrfs/super.c     | 17 ++++++++++++++++-
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 698470b9f32d..5e5f5521de0e 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -272,7 +272,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
>  	spin_lock(&sinfo->lock);
>  	spin_lock(&block_rsv->lock);
>  
> -	block_rsv->size = min_t(u64, num_bytes, SZ_512M);
> +	block_rsv->size = min_t(u64, num_bytes, fs_info->global_reserve_size);
>  
>  	if (block_rsv->reserved < block_rsv->size) {
>  		num_bytes = btrfs_space_info_used(sinfo, true);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 299e11e6c554..d975d4f5723c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -775,6 +775,8 @@ struct btrfs_fs_info {
>  	 */
>  	u64 max_inline;
>  
> +	u64 global_reserve_size;
> +
>  	struct btrfs_transaction *running_transaction;
>  	wait_queue_head_t transaction_throttle;
>  	wait_queue_head_t transaction_wait;
> @@ -1359,6 +1361,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> +#define BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE (SZ_512M)
>  
>  #define btrfs_clear_opt(o, opt)		((o) &= ~BTRFS_MOUNT_##opt)
>  #define btrfs_set_opt(o, opt)		((o) |= BTRFS_MOUNT_##opt)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5f7ee70b3d1a..06f835a44b8a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2723,6 +2723,7 @@ int open_ctree(struct super_block *sb,
>  	atomic64_set(&fs_info->tree_mod_seq, 0);
>  	fs_info->sb = sb;
>  	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
> +	fs_info->global_reserve_size = BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE;
>  	fs_info->metadata_ratio = 0;
>  	fs_info->defrag_inodes = RB_ROOT;
>  	atomic64_set(&fs_info->free_chunk_space, 0);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 78de9d5d80c6..f44223a44cb8 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -327,6 +327,7 @@ enum {
>  	Opt_treelog, Opt_notreelog,
>  	Opt_usebackuproot,
>  	Opt_user_subvol_rm_allowed,
> +	Opt_global_reserve_size,
>  
>  	/* Deprecated options */
>  	Opt_alloc_start,
> @@ -394,6 +395,7 @@ static const match_table_t tokens = {
>  	{Opt_notreelog, "notreelog"},
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
> +	{Opt_global_reserve_size, "global_reserve_size=%s"},
>  
>  	/* Deprecated options */
>  	{Opt_alloc_start, "alloc_start=%s"},
> @@ -426,7 +428,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  			unsigned long new_flags)
>  {
>  	substring_t args[MAX_OPT_ARGS];
> -	char *p, *num;
> +	char *p, *num, *retptr;
>  	u64 cache_gen;
>  	int intarg;
>  	int ret = 0;
> @@ -746,6 +748,15 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  		case Opt_user_subvol_rm_allowed:
>  			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
>  			break;
> +		case Opt_global_reserve_size:
> +			info->global_reserve_size = memparse(args[0].from, &retptr);
> +			if (retptr != args[0].to || info->global_reserve_size == 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			btrfs_info(info, "global_reserve_size at %llu",
> +				   info->global_reserve_size);
> +			break;
>  		case Opt_enospc_debug:
>  			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
>  			break;
> @@ -1336,6 +1347,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  		seq_puts(seq, ",clear_cache");
>  	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
>  		seq_puts(seq, ",user_subvol_rm_allowed");
> +	if (info->global_reserve_size != BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE)
> +		seq_printf(seq, ",global_reserve_size=%llu", info->global_reserve_size);
>  	if (btrfs_test_opt(info, ENOSPC_DEBUG))
>  		seq_puts(seq, ",enospc_debug");
>  	if (btrfs_test_opt(info, AUTO_DEFRAG))
> @@ -1725,6 +1738,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	u64 old_max_inline = fs_info->max_inline;
>  	u32 old_thread_pool_size = fs_info->thread_pool_size;
>  	u32 old_metadata_ratio = fs_info->metadata_ratio;
> +	u64 old_global_reserve_size = fs_info->global_reserve_size;
>  	int ret;
>  
>  	sync_filesystem(sb);
> @@ -1859,6 +1873,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	btrfs_resize_thread_pool(fs_info,
>  		old_thread_pool_size, fs_info->thread_pool_size);
>  	fs_info->metadata_ratio = old_metadata_ratio;
> +	fs_info->global_reserve_size = old_global_reserve_size;
>  	btrfs_remount_cleanup(fs_info, old_opts);
>  	return ret;
>  }
> 
