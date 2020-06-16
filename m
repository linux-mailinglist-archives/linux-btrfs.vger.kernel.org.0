Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CED1FB5B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgFPPKR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 11:10:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFPPKQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 11:10:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8BE0BB134;
        Tue, 16 Jun 2020 15:10:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AB18DA7C3; Tue, 16 Jun 2020 17:10:05 +0200 (CEST)
Date:   Tue, 16 Jun 2020 17:10:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
Message-ID: <20200616151004.GE27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616021737.44617-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 10:17:36AM +0800, Qu Wenruo wrote:
> [BUG]
> When a lot of subvolumes are created, there is a user report about
> transaction aborted:
> 
>   ------------[ cut here ]------------
>   BTRFS: Transaction aborted (error -24)
>   WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
>   RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
>   Call Trace:
>    create_pending_snapshots+0x82/0xa0 [btrfs]
>    btrfs_commit_transaction+0x275/0x8c0 [btrfs]
>    btrfs_mksubvol+0x4b9/0x500 [btrfs]
>    btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>    btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>    btrfs_ioctl+0x11a4/0x2da0 [btrfs]
>    do_vfs_ioctl+0xa9/0x640
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x1a/0x20
>    do_syscall_64+0x5a/0x110
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ---[ end trace 33f2f83f3d5250e9 ]---
>   BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
>   BTRFS info (device sda1): forced readonly
>   BTRFS warning (device sda1): Skipping commit of aborted transaction.
>   BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown
> 
> [CAUSE]
> When the global anonymous block device pool is exhausted, the following
> call chain will fail, and lead to transaction abort:
> 
>  btrfs_ioctl_snap_create_v2()
>  |- btrfs_ioctl_snap_create_transid()
>     |- btrfs_mksubvol()
>        |- btrfs_commit_transaction()
>           |- create_pending_snapshot()
>              |- btrfs_get_fs_root()
>                 |- btrfs_init_fs_root()
>                    |- get_anon_bdev()
> 
> [FIX]
> Although we can't enlarge the anonymous block device pool, at least we
> can preallocate anon_dev for subvolume/snapshot creation.
> So that when the pool is exhausted, user will get an error other than
> aborting transaction later.
> 
> Reported-by: Greed Rong <greedrong@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c     | 51 ++++++++++++++++++++++++++++++++++++------
>  fs/btrfs/disk-io.h     |  2 ++
>  fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
>  fs/btrfs/transaction.c |  3 ++-
>  fs/btrfs/transaction.h |  2 ++
>  5 files changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index cfc0ff288238..14fd69b71cb8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1395,7 +1395,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>  	goto out;
>  }
>  
> -static int btrfs_init_fs_root(struct btrfs_root *root)
> +static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
>  {
>  	int ret;
>  	unsigned int nofs_flag;
> @@ -1435,9 +1435,13 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
>  	 */
>  	if (is_fstree(root->root_key.objectid) &&
>  	    btrfs_root_refs(&root->root_item)) {
> -		ret = get_anon_bdev(&root->anon_dev);
> -		if (ret)
> -			goto fail;
> +		if (!anon_dev) {
> +			ret = get_anon_bdev(&root->anon_dev);
> +			if (ret)
> +				goto fail;
> +		} else {
> +			root->anon_dev = anon_dev;
> +		}
>  	}
>  
>  	mutex_lock(&root->objectid_mutex);
> @@ -1542,8 +1546,27 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  }
>  
>  
> -struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
> -				     u64 objectid, bool check_ref)
> +/*
> + * Get a fs root.
> + *
> + * For essential trees like root/extent tree, we grab it from fs_info directly.
> + * For subvolume trees, we check the cached fs roots first. If miss then
> + * read it from disk and add it to cached fs roots.
> + *
> + * Caller should release the root by calling btrfs_put_root() after the usage.
> + *
> + * NOTE: Reloc and log trees can't be read by this function as they share the
> + *	 same root objectid.
> + *
> + * @objectid:	Root (subvolume) id
> + * @anon_dev:	Preallocated anonymous block device number for new roots.
> + * 		Pass 0 for automatic allocation.
> + * @check_ref:	Whether to check root refs. If true, return -ENOENT for orphan
> + * 		roots.
> + */
> +static struct btrfs_root *__get_fs_root(struct btrfs_fs_info *fs_info,
> +					u64 objectid, dev_t anon_dev,
> +					bool check_ref)


> +struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
> +				     u64 objectid, bool check_ref)
> +{
> +	return __get_fs_root(fs_info, objectid, 0, check_ref);
> +}
> +
> +struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
> +					 u64 objectid, dev_t anon_dev)
> +{
> +	return __get_fs_root(fs_info, objectid, anon_dev, true);
> +}

This does not look like a good API, we should keep btrfs_get_fs_root and
add the anon_bdev initialization to the callers, there are only a few.
