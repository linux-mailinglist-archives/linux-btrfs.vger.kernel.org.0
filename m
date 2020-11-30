Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE42C8E74
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 20:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgK3Tvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 14:51:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:44174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgK3Tvy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 14:51:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFDA7AC2E;
        Mon, 30 Nov 2020 19:51:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4BA24DA6E1; Mon, 30 Nov 2020 20:49:41 +0100 (CET)
Date:   Mon, 30 Nov 2020 20:49:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 06/12] btrfs: clear free space tree on ro->rw remount
Message-ID: <20201130194941.GI6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
 <f91ff85f985eeaf8993022453ca21fa4772e28a8.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91ff85f985eeaf8993022453ca21fa4772e28a8.1605736355.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:06:21PM -0800, Boris Burkov wrote:
> A user might want to revert to v1 or nospace_cache on a root filesystem,
> and much like turning on the free space tree, that can only be done
> remounting from ro->rw. Support clearing the free space tree on such
> mounts by moving it into the shared remount logic.
> 
> Since the CLEAR_CACHE option sticks around across remounts, this change
> would result in clearing the tree for ever on every remount, which is
> not desirable. To fix that, add CLEAR_CACHE to the oneshot options we
> clear at mount end, which has the other bonus of not cluttering the
> /proc/mounts output with clear_cache.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/disk-io.c | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0bc7d9766f8c..64e5707f008b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2892,6 +2892,7 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
>  void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
>  {
>  	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
> +	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
>  }
>  
>  /*
> @@ -2901,6 +2902,27 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
>  int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
>  {
>  	int ret;
> +	bool clear_free_space_tree = false;
> +
> +	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
> +	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> +		clear_free_space_tree = true;
> +	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> +		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
> +		btrfs_warn(fs_info, "free space tree is invalid");
> +		clear_free_space_tree = true;
> +	}
> +
> +	if (clear_free_space_tree) {
> +		btrfs_info(fs_info, "clearing free space tree");
> +		ret = btrfs_clear_free_space_tree(fs_info);
> +		if (ret) {
> +			btrfs_warn(fs_info,
> +				   "failed to clear free space tree: %d", ret);
> +			close_ctree(fs_info);

This is probably a copy&paste error, this was originally in open_ctree
that calls close_ctree after errors, but here it's not supposed to be
called.

> +			return ret;
> +		}
> +	}
>  
>  	ret = btrfs_cleanup_fs_roots(fs_info);
>  	if (ret)
> @@ -2975,7 +2997,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	struct btrfs_root *chunk_root;
>  	int ret;
>  	int err = -EINVAL;
> -	int clear_free_space_tree = 0;
>  	int level;
>  
>  	ret = init_mount_fs_info(fs_info, sb);
> @@ -3377,26 +3398,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	if (sb_rdonly(sb))
>  		goto clear_oneshot;
>  
> -	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
> -	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> -		clear_free_space_tree = 1;
> -	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> -		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
> -		btrfs_warn(fs_info, "free space tree is invalid");
> -		clear_free_space_tree = 1;
> -	}
> -
> -	if (clear_free_space_tree) {
> -		btrfs_info(fs_info, "clearing free space tree");
> -		ret = btrfs_clear_free_space_tree(fs_info);
> -		if (ret) {
> -			btrfs_warn(fs_info,
> -				   "failed to clear free space tree: %d", ret);
> -			close_ctree(fs_info);
> -			return ret;
> -		}
> -	}
> -
>  	ret = btrfs_mount_rw(fs_info);
>  	if (ret) {
>  		close_ctree(fs_info);
> -- 
> 2.24.1
