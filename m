Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF01F1323
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgFHG6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:58:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:46764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgFHG6v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 02:58:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A35BAC7D;
        Mon,  8 Jun 2020 06:58:52 +0000 (UTC)
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b460820d-f326-8876-7f3b-b9842d245de3@suse.com>
Date:   Mon, 8 Jun 2020 09:58:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607072512.31721-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.06.20 г. 10:25 ч., Qu Wenruo wrote:
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
I don't think the message from the WARN() brings any value, it's simply
duplicated by the btrfs_err. IMO it's more concise to do:

WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
btrfs_err(qgroup reserved space leaked);

without losing any information whatsoever.

> +	}

Is it safe calling this code here? workqueues are being destroyed after
it in btrfs_stop_all_workers so it's possible that they have some
lingering work which in turn might cause false positive in this check ?
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
> +/*
> + * Get called for close_ctree() when quota is still enabled.
> + * This verifies we don't leak some reserved space.
> + *
> + * Return false if no reserved space is left.
> + * Return true if some reserved space is leaked.
> + */
> +bool btrfs_qgroup_has_leak(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_qgroup *qgroup;

nit:This variable is used only in the loop below just define it there to
reduce its scope.

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
>  #endif
> 
