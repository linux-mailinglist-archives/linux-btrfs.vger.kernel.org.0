Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388092466A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgHQMvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:55998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQMvl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:51:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D1B9B1AD;
        Mon, 17 Aug 2020 12:52:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3826EDA6EF; Mon, 17 Aug 2020 14:50:30 +0200 (CEST)
Date:   Mon, 17 Aug 2020 14:50:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [RFC PATCH 2/8] btrfs: super: Introduce fs_context ops, init and
 free functions
Message-ID: <20200817125029.GE2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200812163654.17080-1-marcos@mpdesouza.com>
 <20200812163654.17080-3-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163654.17080-3-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 01:36:48PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Create a btrfs_fs_context struct that will be used as fs_private between
> the fs context calls, holding options to be later assigned to fs_info,
> since we don't have a proper btrfs_fs_info at the parse_args phase.
> 
> fs_context is still not being used since the init function isn't being
> assigned in btrfs_fs_type.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/ctree.h | 27 +++++++++++++++++++++++++++
>  fs/btrfs/super.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 9c7e466f27a9..b7e3962a0941 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -28,6 +28,7 @@
>  #include <linux/dynamic_debug.h>
>  #include <linux/refcount.h>
>  #include <linux/crc32c.h>
> +#include "compression.h"
>  #include "extent-io-tree.h"
>  #include "extent_io.h"
>  #include "extent_map.h"
> @@ -35,6 +36,32 @@
>  #include "block-rsv.h"
>  #include "locking.h"
>  
> +struct btrfs_fs_context {
> +	char **devices;
> +	char *subvol_name;
> +	u64 subvolid;
> +
> +	int nr_devices;
> +	unsigned long mount_opt;
> +	unsigned long mount_opt_explicity;

What does 'explicity' mean here?

> +	unsigned long pending_changes;
> +	enum btrfs_compression_type	compress_type;
> +	unsigned int			compress_level;
> +
> +	u64				max_inline;
> +	u32				metadata_ratio;
> +	u32				thread_pool_size;
> +	u32				commit_interval;
> +#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> +	u32				check_integrity_print_mask;
> +#endif

Please change the indentation to the single space.

> +
> +	struct vfsmount *root_mnt;
> +	bool root;
> +	bool nospace_cache;
> +	bool no_compress;
> +};
> +
>  struct btrfs_trans_handle;
>  struct btrfs_transaction;
>  struct btrfs_pending_snapshot;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4e6654af90ea..fe19ffe962c6 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2326,6 +2326,51 @@ static void btrfs_kill_super(struct super_block *sb)
>  	btrfs_free_fs_info(fs_info);
>  }
>  
> +static void btrfs_fc_free(struct fs_context *fc)
> +{
> +	struct btrfs_fs_context *ctx = fc->fs_private;
> +	struct btrfs_fs_info *info = fc->s_fs_info;
> +
> +	if (info)
> +		btrfs_free_fs_info(info);
> +	if (ctx) {
> +		mntput(ctx->root_mnt);
> +		if (ctx->devices) {
> +			int i;
> +
> +			for (i = 0; i < ctx->nr_devices; i++)
> +				kfree(ctx->devices[i]);
> +			kfree(ctx->devices);
> +		}
> +		kfree(ctx->subvol_name);
> +		kfree(ctx);
> +	}
> +}
> +
> +static const struct fs_context_operations btrfs_context_ops = {
> +	.free = btrfs_fc_free,
> +};
> +
> +static int btrfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct btrfs_fs_context *ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	/* currently default options */

Please update all comments to uppercase first letter, unless it's an
identifier.

> +	btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
> +#ifdef CONFIG_BTRFS_FS_POSIX_ACL
> +	fc->sb_flags |= SB_POSIXACL;
> +#endif
> +	ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
> +
> +	fc->fs_private = ctx;
> +	fc->ops = &btrfs_context_ops;

So here the fc->ops are initialized but there are still unimplemented
callbacks in btrfs_context_ops.

Looking to fs/fs_context.c alloc_fs_context, this will assume that
support fc exists and does not use the wrappers, legacy_init_fs_context.
This would probably break bisection.
