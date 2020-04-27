Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3645D1BA85B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgD0PrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 11:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgD0PrP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A5AAACBD;
        Mon, 27 Apr 2020 15:47:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54573DA781; Mon, 27 Apr 2020 17:46:28 +0200 (CEST)
Date:   Mon, 27 Apr 2020 17:46:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs : improve the speed of compare orphan item and
 dead roots with tree root when mount
Message-ID: <20200427154628.GE18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200427080411.13273-1-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427080411.13273-1-robbieko@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 27, 2020 at 04:04:11PM +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> When mounting, we handle deleted subvol and orphan items.
> First, find add orphan roots, then add them to fs_root radix tree.
> Second, in tree-root, process each orphan item, skip if it is dead root.
> 
> The original algorithm is based on the list of dead_roots,
> one by one to visit and check whether the objectid is consistent,
> the time complexity is O (n ^ 2).
> When processing 50000 deleted subvols, it takes about 120s.
> 
> We can quickly check whether the orphan item is dead root
> through the fs_roots radix tree.
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/inode.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 320d1062068d..1becf5c63e5a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3000,18 +3000,16 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  			 * orphan must not get deleted.
>  			 * find_dead_roots already ran before us, so if this
>  			 * is a snapshot deletion, we should find the root
> -			 * in the dead_roots list
> +			 * in the fs_roots radix tree.
>  			 */
> -			spin_lock(&fs_info->trans_lock);
> -			list_for_each_entry(dead_root, &fs_info->dead_roots,
> -					    root_list) {
> -				if (dead_root->root_key.objectid ==
> -				    found_key.objectid) {
> -					is_dead_root = 1;
> -					break;
> -				}
> -			}
> -			spin_unlock(&fs_info->trans_lock);
> +
> +			spin_lock(&fs_info->fs_roots_radix_lock);
> +			dead_root = radix_tree_lookup(&fs_info->fs_roots_radix,
> +							 (unsigned long)found_key.objectid);
> +			if (dead_root && btrfs_root_refs(&dead_root->root_item) == 0)
> +				is_dead_root = 1;
> +			spin_unlock(&fs_info->fs_roots_radix_lock);

The list uses fs_info::trans_lock and the radix uses
fs_roots_radix_lock. I'd like to know why you think it's safe.

The trans_lock is used for a lot of things, fs_roots_radix_lock is for
the radix tree insertion/deletion/update/lookup so it does not seem like
an equivalent change. It could be functionally equivalent due to some
other constraint, like that the number of references is 0 and the tree
won't be ever touched outside of the orphan cleanup process.

btrfs_orphan_cleanup can be called during the whole filesystem mount
lifetime, so we can't rely on the mount time where nothing can iterfere.
