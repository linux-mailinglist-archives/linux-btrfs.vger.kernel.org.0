Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B031F468C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgFISqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 14:46:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgFISqP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 14:46:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9AFB2ACCF;
        Tue,  9 Jun 2020 18:46:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CFD9BDA790; Tue,  9 Jun 2020 20:46:06 +0200 (CEST)
Date:   Tue, 9 Jun 2020 20:46:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
Message-ID: <20200609184605.GD27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607072512.31721-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 03:25:12PM +0800, Qu Wenruo wrote:

Please write some changelog.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c |  6 ++++++
>  fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/qgroup.h  |  2 +-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f8ec2d8606fd..48d047e64461 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4058,6 +4058,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  	ASSERT(list_empty(&fs_info->delayed_iputs));
>  	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
>  
> +	if (btrfs_qgroup_has_leak(fs_info)) {
> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> +		     KERN_ERR "BTRFS: qgroup reserved space leaked\n");
> +		btrfs_err(fs_info, "qgroup reserved space leaked\n");

No newline in the btrfs_err strings.

> +	}
> +
>  	btrfs_free_qgroup_config(fs_info);
>  	ASSERT(list_empty(&fs_info->delalloc_roots));
>  
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5bd4089ad0e1..3fccf2ffdcf1 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -505,6 +505,49 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  	return ret < 0 ? ret : 0;
>  }
>  
> +static u64 btrfs_qgroup_subvolid(u64 qgroupid)
> +{
> +	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
> +}

Missing newline.

> +/*
> + * Get called for close_ctree() when quota is still enabled.
> + * This verifies we don't leak some reserved space.
> + *
> + * Return false if no reserved space is left.
> + * Return true if some reserved space is leaked.
> + */
> +bool btrfs_qgroup_has_leak(struct btrfs_fs_info *fs_info)

I think we've been naming such functions with 'check' eg.
btrfs_check_quota_leak, and return true/false.

> +{
> +	struct btrfs_qgroup *qgroup;
> +	struct rb_node *node;
> +	bool ret = false;
> +
> +	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +		return ret;
> +	/*
> +	 * Since we're unmounting, there is no race and no need to grab
> +	 * qgroup lock.
> +	 * And here we don't go post order to provide a more user friendly
> +	 * sorted result.
> +	 */
> +	for (node = rb_first(&fs_info->qgroup_tree); node; node = rb_next(node)) {
> +		int i;
> +
> +		qgroup = rb_entry(node, struct btrfs_qgroup, node);
> +		for (i = 0; i < BTRFS_QGROUP_RSV_LAST; i++) {
> +			if (qgroup->rsv.values[i]) {
> +				ret = true;
> +				btrfs_warn(fs_info,
> +		"qgroup %llu/%llu has unreleased space, type=%d rsv=%llu",

If this could be potentially noisy, the ratelimited version would be
more suitable.

The message wording sounds ok, as it points to the qgroups and there's
one global message printed from close_ctree that says it's a 'leak'.

> +				   btrfs_qgroup_level(qgroup->qgroupid),
> +				   btrfs_qgroup_subvolid(qgroup->qgroupid),
> +				   i, qgroup->rsv.values[i]);
> +			}
> +		}
> +	}
> +	return ret;
> +}
> +
>  /*
>   * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
>   * first two are in single-threaded paths.And for the third one, we have set
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 1bc654459469..e3e9f9df8320 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -415,5 +415,5 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
>  int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
>  		struct btrfs_root *root, struct extent_buffer *eb);
>  void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
> -
> +bool btrfs_qgroup_has_leak(struct btrfs_fs_info *fs_info);

So when I'm pointing out newlines, please keep one between the text and
the last #endif.

Thanks.

>  #endif
> -- 
> 2.26.2
