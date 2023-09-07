Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66BE7979F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbjIGR0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbjIGRZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:25:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901AAE6B
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 10:25:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D50D01F8A8;
        Thu,  7 Sep 2023 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694085971;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4irvQo0hQzxNMIgbNIaRyn8aCJJhoin3fBHMhsp/iLs=;
        b=W0U1JZqfZ23vRMJxTM1A4j3cORRuMjVCwvb5TrLZN1qwaiLnde/gg8flRmtSMp7lixs7Vu
        EaxubfOnmMYsvmpzDoIXeqntCIcKerL9Rt8pvL0wcgnnaXqiUYpHC2ijAZzzxCFO83Jy2i
        GwSFvvGf50HOdwbQTS/ENWudfnukn6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694085971;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4irvQo0hQzxNMIgbNIaRyn8aCJJhoin3fBHMhsp/iLs=;
        b=IoobgatT+UxuH62nJih6FKs+JtqI62ok6GQoL7L2zh/qXnwwEjvD1+icJ0OTkbx55ETzPy
        9+H5ApZtHlDwZFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 990D0138F9;
        Thu,  7 Sep 2023 11:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9fqmJFOz+WTVdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 11:26:11 +0000
Date:   Thu, 7 Sep 2023 13:19:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 02/18] btrfs: add new quota mode for simple quotas
Message-ID: <20230907111939.GB3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <f202a99129b673a2dae686d2421f50995d00d2f9.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f202a99129b673a2dae686d2421f50995d00d2f9.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:49PM -0700, Boris Burkov wrote:
> Add a new quota mode called "simple quotas". It can be enabled by the
> existing quota enable ioctl via a new command, and sets an incompat
> bit, as the implementation of simple quotas will make backwards
> incompatible changes to the disk format of the extent tree.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c          |  4 +-
>  fs/btrfs/fs.h                   |  5 +-
>  fs/btrfs/ioctl.c                |  3 +-
>  fs/btrfs/qgroup.c               | 91 +++++++++++++++++++++++----------
>  fs/btrfs/qgroup.h               |  4 +-
>  fs/btrfs/root-tree.c            |  2 +-
>  fs/btrfs/transaction.c          |  4 +-
>  include/uapi/linux/btrfs.h      |  2 +
>  include/uapi/linux/btrfs_tree.h | 14 ++++-
>  9 files changed, 91 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6a13cf00218b..a9b938d3a531 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -898,7 +898,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&

The expression

"btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED"

is repeated in many places, this should be a helper. Checking for the
secific mode open coded is fine.

>  	    !generic_ref->skip_qgroup) {
>  		record = kzalloc(sizeof(*record), GFP_NOFS);
>  		if (!record) {
> @@ -1002,7 +1002,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
>  	    !generic_ref->skip_qgroup) {
>  		record = kzalloc(sizeof(*record), GFP_NOFS);
>  		if (!record) {
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..f76f450c2abf 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -218,7 +218,8 @@ enum {
>  	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
>  	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
>  	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
> -	 BTRFS_FEATURE_INCOMPAT_ZONED)
> +	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
> +	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
>  
>  #ifdef CONFIG_BTRFS_DEBUG
>  	/*
> @@ -233,7 +234,6 @@ enum {
>  
>  #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>  	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE)
> -

Keep the lines there please

>  #endif
>  
>  #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
> @@ -790,7 +790,6 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_state_change_map[4];
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
> -

Same

>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..9b61bc62e439 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3691,7 +3691,8 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
>  
>  	switch (sa->cmd) {
>  	case BTRFS_QUOTA_CTL_ENABLE:
> -		ret = btrfs_quota_enable(fs_info);
> +	case BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA:
> +		ret = btrfs_quota_enable(fs_info, sa);
>  		break;
>  	case BTRFS_QUOTA_CTL_DISABLE:
>  		ret = btrfs_quota_disable(fs_info);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 0a2085ae9bcd..558f66994667 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -34,6 +34,8 @@ enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
>  {
>  	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
>  		return BTRFS_QGROUP_MODE_DISABLED;
> +	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE)
> +		return BTRFS_QGROUP_MODE_SIMPLE;
>  	return BTRFS_QGROUP_MODE_FULL;
>  }
>  
> @@ -347,6 +349,8 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
>  
>  static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
>  {
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		return;
>  	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
>  				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
>  				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
> @@ -367,8 +371,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  	int ret = 0;
>  	u64 flags = 0;
>  	u64 rescan_progress = 0;
> +	bool simple;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
>  		return 0;
>  
>  	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
> @@ -418,14 +423,14 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  				 "old qgroup version, quota disabled");
>  				goto out;
>  			}
> +			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
> +			simple = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE;

bool expressions assigned should be written like

			x = (a & b);

so it's clear that it's not a trivial statement. Similarly for '==' or
ternary operator.

>  			if (btrfs_qgroup_status_generation(l, ptr) !=
> -			    fs_info->generation) {
> +			    fs_info->generation && !simple) {
>  				qgroup_mark_inconsistent(fs_info);
>  				btrfs_err(fs_info,
>  					"qgroup generation mismatch, marked as inconsistent");
>  			}
> -			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l,
> -									  ptr);
>  			rescan_progress = btrfs_qgroup_status_rescan(l, ptr);
>  			goto next1;
>  		}
> @@ -557,7 +562,7 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
>  	struct rb_node *node;
>  	bool ret = false;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
>  		return ret;
>  	/*
>  	 * Since we're unmounting, there is no race and no need to grab qgroup
> @@ -956,7 +961,8 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> -int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
> +int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> +		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args)
>  {
>  	struct btrfs_root *quota_root;
>  	struct btrfs_root *tree_root = fs_info->tree_root;
> @@ -968,6 +974,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  	struct btrfs_qgroup *qgroup = NULL;
>  	struct btrfs_trans_handle *trans = NULL;
>  	struct ulist *ulist = NULL;
> +	bool simple = quota_ctl_args->cmd == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA;

	const bool simple = ( ... == ...);

>  	int ret = 0;
>  	int slot;
>  
> @@ -1070,8 +1077,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  				 struct btrfs_qgroup_status_item);
>  	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
>  	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
> -	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
> -				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
> +	if (simple)
> +		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> +	else
> +		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
>  	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
>  				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
>  	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
> @@ -1187,8 +1197,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  	spin_lock(&fs_info->qgroup_lock);
>  	fs_info->quota_root = quota_root;
>  	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> +	if (simple)
> +		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
>  	spin_unlock(&fs_info->qgroup_lock);
>  
> +	/* Skip rescan for simple qgroups */
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		goto out_free_path;
> +
>  	ret = qgroup_rescan_init(fs_info, 0, 1);
>  	if (!ret) {
>  	        qgroup_rescan_zero_tracking(fs_info);
> @@ -1302,6 +1318,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  	quota_root = fs_info->quota_root;
>  	fs_info->quota_root = NULL;
>  	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
> +	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
>  	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
>  	spin_unlock(&fs_info->qgroup_lock);
>  
> @@ -1787,6 +1804,9 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
>  	struct btrfs_qgroup_extent_record *entry;
>  	u64 bytenr = record->bytenr;
>  
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
> +		return 0;
> +
>  	lockdep_assert_held(&delayed_refs->lock);
>  	trace_btrfs_qgroup_trace_extent(fs_info, record);
>  
> @@ -1819,6 +1839,8 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>  	struct btrfs_backref_walk_ctx ctx = { 0 };
>  	int ret;
>  
> +	if (btrfs_qgroup_mode(trans->fs_info) != BTRFS_QGROUP_MODE_FULL)
> +		return 0;
>  	/*
>  	 * We are always called in a context where we are already holding a
>  	 * transaction handle. Often we are called when adding a data delayed
> @@ -1874,7 +1896,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  	struct btrfs_delayed_ref_root *delayed_refs;
>  	int ret;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL

Could this be written as an '==' condition?

>  	    || bytenr == 0 || num_bytes == 0)

With the rest it's not clear what exactly is it testing for.

>  		return 0;
>  	record = kzalloc(sizeof(*record), GFP_NOFS);
> @@ -1907,7 +1929,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
>  	u64 bytenr, num_bytes;
>  
>  	/* We can be called directly from walk_up_proc() */
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)

Reading more from the patch, the meaning of the "!= FULL" is either
disabled or simple quotas, can this be inverted so we have something
like "if no accounting"? This covers either quotas disabled or simple
quotas.

>  		return 0;
>  
>  	for (i = 0; i < nr; i++) {
> @@ -2283,7 +2305,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
>  	int level;
>  	int ret;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
>  		return 0;
>  
>  	/* Wrong parameter order */
> @@ -2340,7 +2362,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
>  	BUG_ON(root_level < 0 || root_level >= BTRFS_MAX_LEVEL);
>  	BUG_ON(root_eb == NULL);
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
>  		return 0;
>  
>  	spin_lock(&fs_info->qgroup_lock);
> @@ -2680,7 +2702,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  	 * If quotas get disabled meanwhile, the resources need to be freed and
>  	 * we can't just exit here.
>  	 */
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL ||
>  	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
>  		goto out_free;
>  
> @@ -2768,6 +2790,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
>  	u64 qgroup_to_skip;
>  	int ret = 0;
>  
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		return 0;
> +
>  	delayed_refs = &trans->transaction->delayed_refs;
>  	qgroup_to_skip = delayed_refs->qgroup_to_skip;
>  	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
> @@ -2883,7 +2908,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>  			qgroup_mark_inconsistent(fs_info);
>  		spin_lock(&fs_info->qgroup_lock);
>  	}
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED)
>  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_ON;
>  	else
>  		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
> @@ -2936,7 +2961,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  
>  	if (!committing)
>  		mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
>  		goto out;
>  
>  	quota_root = fs_info->quota_root;
> @@ -3010,7 +3035,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  		qgroup_dirty(fs_info, dstgroup);
>  	}
>  
> -	if (srcid) {
> +	if (srcid && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL) {
>  		srcgroup = find_qgroup_rb(fs_info, srcid);
>  		if (!srcgroup)
>  			goto unlock;
> @@ -3302,6 +3327,9 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
>  	int slot;
>  	int ret;
>  
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
> +		return 1;
> +
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
>  	extent_root = btrfs_extent_root(fs_info,
>  				fs_info->qgroup_rescan_progress.objectid);
> @@ -3384,8 +3412,8 @@ static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
>  {
>  	return btrfs_fs_closing(fs_info) ||
>  		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state) ||
> -		!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
> -			  fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
> +		btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
> +		fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;

The condition has become quite unreadable, please convert it to an 'if'
or series of more 'ifs' grouping the conditions. Eg. the
btrfs_fs_closing() can be a separate statement as it's not directly
related to the quotas and rescan.

>  }
>  
>  static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> @@ -3399,6 +3427,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  	bool stopped = false;
>  	bool did_leaf_rescans = false;
>  
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		return;
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		goto out;
> @@ -3502,6 +3533,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
>  {
>  	int ret = 0;
>  
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
> +		btrfs_warn(fs_info, "qgroup rescan init failed, running in simple mode. mode: %d\n",

No "\n" in the message helpers and I don't think we need the numeric
value of the mode when it's stated in words

> +			btrfs_qgroup_mode(fs_info));
> +		return -EINVAL;
> +	}
> +
>  	if (!init_flags) {
>  		/* we're resuming qgroup rescan at mount time */
>  		if (!(fs_info->qgroup_flags &
> @@ -3532,7 +3569,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
>  			btrfs_warn(fs_info,
>  			"qgroup rescan init failed, qgroup is not enabled");
>  			ret = -EINVAL;
> -		} else if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
> +		} else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
>  			/* Quota disable is in progress */
>  			ret = -EBUSY;
>  		}
> @@ -3788,7 +3825,7 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
>  	u64 to_reserve;
>  	int ret;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &root->fs_info->flags) ||
> +	if (btrfs_qgroup_mode(root->fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
>  	    !is_fstree(root->root_key.objectid) || len == 0)
>  		return 0;
>  
> @@ -3920,7 +3957,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
>  	int trace_op = QGROUP_RELEASE;
>  	int ret;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &inode->root->fs_info->flags))
> +	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED)
>  		return 0;
>  
>  	/* In release case, we shouldn't have @reserved */
> @@ -4031,7 +4068,7 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	int ret;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
>  	    !is_fstree(root->root_key.objectid) || num_bytes == 0)
>  		return 0;
>  
> @@ -4072,7 +4109,7 @@ void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
>  	    !is_fstree(root->root_key.objectid))
>  		return;
>  
> @@ -4088,7 +4125,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
>  	    !is_fstree(root->root_key.objectid))
>  		return;
>  
> @@ -4153,7 +4190,7 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
>  	    !is_fstree(root->root_key.objectid))
>  		return;
>  	/* Same as btrfs_qgroup_free_meta_prealloc() */
> @@ -4261,7 +4298,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
>  	int level = btrfs_header_level(subvol_parent) - 1;
>  	int ret = 0;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
>  		return 0;
>  
>  	if (btrfs_node_ptr_generation(subvol_parent, subvol_slot) >
> @@ -4371,7 +4408,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
>  	int ret = 0;
>  	int i;
>  
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
>  		return 0;
>  	if (!is_fstree(root->root_key.objectid) || !root->reloc_root)
>  		return 0;
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index bb15e55f00b8..d4c4d039585f 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -249,13 +249,15 @@ enum {
>  	ENUM_BIT(QGROUP_FREE),
>  };
>  
> -int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
>  enum btrfs_qgroup_mode {
>  	BTRFS_QGROUP_MODE_DISABLED,
>  	BTRFS_QGROUP_MODE_FULL,
> +	BTRFS_QGROUP_MODE_SIMPLE
>  };
>  
>  enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
> +int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> +		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args);
>  int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
>  int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
>  void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 859874579456..044a8c2710f8 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -508,7 +508,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED) {
>  		/* One for parent inode, two for dir entries */
>  		qgroup_num_bytes = 3 * fs_info->nodesize;
>  		ret = btrfs_qgroup_reserve_meta_prealloc(root,
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 815f61d6b506..89ff15aa085f 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1529,11 +1529,11 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>  	int ret;
>  
>  	/*
> -	 * Save some performance in the case that qgroups are not
> +	 * Save some performance in the case that full qgroups are not
>  	 * enabled. If this check races with the ioctl, rescan will
>  	 * kick in anyway.
>  	 */
> -	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
>  		return 0;
>  
>  	/*
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dbb8b96da50d..0e42f4a2121d 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
>  #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
>  #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
>  #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
> +#define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 14)
>  
>  struct btrfs_ioctl_feature_flags {
>  	__u64 compat_flags;
> @@ -753,6 +754,7 @@ struct btrfs_ioctl_get_dev_stats {
>  #define BTRFS_QUOTA_CTL_ENABLE	1
>  #define BTRFS_QUOTA_CTL_DISABLE	2
>  #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
> +#define BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA 4
>  struct btrfs_ioctl_quota_ctl_args {
>  	__u64 cmd;
>  	__u64 status;
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index ab38d0f411fa..47aca414a41b 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1200,9 +1200,21 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
>   */
>  #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
>  
> +/*
> + * 3rd and 4th bits taken by non-persisted status flags in qgroup.h
> + */

If the bits are not persisted and used only internally or for in-memory
tracking then they should be renumbered so you can use the value (1ULL
<< 3) in sequence.

> +
> +/*
> + * Whether or not this filesystem is using simple quotas.
> + * Not exactly the incompat bit, because we support using simple quotas,
> + * disabling it, then going back to full qgroup quotas.
> + */
> +#define BTRFS_QGROUP_STATUS_FLAG_SIMPLE	(1ULL << 5)

Here the context of 'SIMPLE' is not obvious, it's referring to
accounting but adding that to the identifier would make it quite long so
I'm not sure if we should do that. OTOH it's in the ioctl public API so
clarity is important.

> +
>  #define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |		\
>  					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |	\
> -					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
> +					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |	\
> +					 BTRFS_QGROUP_STATUS_FLAG_SIMPLE)
>  
>  #define BTRFS_QGROUP_STATUS_VERSION        1
>  
> -- 
> 2.41.0
