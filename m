Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCC246739
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgHQNQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 09:16:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbgHQNPG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 09:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A34B2ACB0;
        Mon, 17 Aug 2020 13:15:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FE4DDA6EF; Mon, 17 Aug 2020 15:14:00 +0200 (CEST)
Date:   Mon, 17 Aug 2020 15:14:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [RFC PATCH 6/8] btrfs: super: Introduce btrfs_mount_root_fc
Message-ID: <20200817131400.GG2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200812163654.17080-1-marcos@mpdesouza.com>
 <20200812163654.17080-7-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163654.17080-7-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 01:36:52PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This function will be used by the following patches to mount the root fs
> before mounting a subvolume.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/super.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 6b70fb73a1ea..5bbf4b947125 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2419,6 +2419,47 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  	return ERR_PTR(error);
>  }
>  
> +/*
> + * Duplicate the current fc and prepare for mounting the root.
> + * btrfs_get_tree will be called recursively, but then will check for the
> + * ctx->root being set and call btrfs_root_get_tree.

This sounds like the adding back recursive mount with -o subvol= that
was removed.

> + */
> +static int btrfs_mount_root_fc(struct fs_context *fc, unsigned int rdonly)
> +{
> +	struct btrfs_fs_context *ctx, *root_ctx;
> +	struct fs_context *root_fc;
> +	struct vfsmount *root_mnt;
> +	int ret;
> +
> +	root_fc = vfs_dup_fs_context(fc);
> +	if (IS_ERR(root_fc))
> +		return PTR_ERR(root_fc);
> +
> +	root_fc->sb_flags &= ~SB_RDONLY;
> +	root_fc->sb_flags |= rdonly | SB_NOSEC;
> +	root_ctx = root_fc->fs_private;
> +	root_ctx->root_mnt = NULL;
> +	root_ctx->root = true;
> +
> +	/*
> +	 * fc_mount will call btrfs_get_tree again, and by checking ctx->root
> +	 * being true it'll call btrfs_root_get_tree to avoid infinite recursion.
> +	 */

Can this race somehow? If there are several parallel mounts called eg.
for a set of system subvolumes.

> +	root_mnt = fc_mount(root_fc);
> +	if (IS_ERR(root_mnt)) {
> +		ret = PTR_ERR(root_mnt);
> +		goto error_fc;
> +	}
> +
> +	ctx = fc->fs_private;
> +	ctx->root_mnt = root_mnt;
> +	ret = 0;
> +
> +error_fc:
> +	put_fs_context(root_fc);
> +	return ret;
> +}
> +
>  /*
>   * Mount function which is called by VFS layer.
>   *
> -- 
> 2.28.0
