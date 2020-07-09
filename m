Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0957A21A44C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGIQDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 12:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgGIQDR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 12:03:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E153CAD26;
        Thu,  9 Jul 2020 16:03:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4F51DAB7F; Thu,  9 Jul 2020 18:02:55 +0200 (CEST)
Date:   Thu, 9 Jul 2020 18:02:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/3] btrfs: qgroup: allow btrfs_qgroup_reserve_data()
 to revert the range it just set without releasing other existing ranges
Message-ID: <20200709160255.GA15161@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708062447.81341-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 02:24:45PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
> reserved space of the changeset.
> 
> For example:
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, 0, SZ_1M);
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_1M, SZ_1M);
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_2M, SZ_1M);
> 
> If the last btrfs_qgroup_reserve_data() failed, it will release all [0,
> 3M) range.
> 
> This behavior is kinda OK for now, as when we hit -EDQUOT, we normally
> go error handling and need to release all reserved ranges anyway.
> 
> But this also means the following call is not possible:
> 	ret = btrfs_qgroup_reserve_data();
> 	if (ret == -EDQUOT) {
> 		/* Do something to free some qgroup space */
> 		ret = btrfs_qgroup_reserve_data();
> 	}
> 
> As if the first btrfs_qgroup_reserve_data() fails, it will free all
> reserved qgroup space.
> 
> [CAUSE]
> This is because we release all reserved ranges when
> btrfs_qgroup_reserve_data() fails.
> 
> [FIX]
> This patch will implement a new function, qgroup_revert(), to iterate
> through the ulist nodes, to find any nodes in the failure range, and
> remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
> the extent_changeset::bytes_changed, so that we can revert to previous
> status.
> 
> This allows later patches to retry btrfs_qgroup_reserve_data() if EDQUOT
> happens.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 90 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ee0ad33b659c..84a452dea3f9 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3447,6 +3447,71 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
>  	}
>  }
>  
> +static int qgroup_revert(struct btrfs_inode *inode,
> +			struct extent_changeset *reserved, u64 start,
> +			u64 len)

I've renamed it to qgroup_unreserve_range, as it's not clear what is
being reverted.

> +{
> +	struct rb_node *n = reserved->range_changed.root.rb_node;
> +	struct ulist_node *entry = NULL;
> +	int ret = 0;
> +
> +	while (n) {
> +		entry = rb_entry(n, struct ulist_node, rb_node);
> +		if (entry->val < start)
> +			n = n->rb_right;
> +		else if (entry)
> +			n = n->rb_left;

Please don't use single letter variables in new code unless it's 'i' for
integer indexing. 'node' is fine.

> +		else
> +			break;
> +	}
> +	/* Empty changeset */
> +	if (!entry)
> +		goto out;

Switched to return as suggested.

> +
> +	if (entry->val > start && rb_prev(&entry->rb_node))
> +		entry = rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
> +				 rb_node);
> +
> +	n = &entry->rb_node;
> +	while (n) {
> +		struct rb_node *tmp = rb_next(n);

Renamed to 'next'

All non-functional changes, no need to resend.
