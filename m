Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD37979F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbjIGRZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbjIGRZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:25:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910971FEC
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 10:25:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BE071F8AB;
        Thu,  7 Sep 2023 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694089881;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umtSNeY9u8+zIOLCsOj8pNLhqXzAqriwmEPRsJmSE7I=;
        b=mLbRAK1fa8tj2hoo5crFtd8KJ6oqqeU+GPr+J+/RR7PniYMwZTmlFqarot+eRMSiexYk7W
        76vvMqSDb4XwqofMxxUk7jAc4xrRLq0Vcw70iJBqOMtqUJD+uAW5NOV5dDMZKsrXbsE5ZZ
        apMcYqjropQMz0PDdHThcEW0O5Rb1og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694089881;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umtSNeY9u8+zIOLCsOj8pNLhqXzAqriwmEPRsJmSE7I=;
        b=jLjMuzPOp1jepQ0VW5BIuFE2m8p1JPTk9cf1VlAUVWTnP4fOJZv0BXy4yrXSSMfqZdjGIh
        jAJ8RM1T3s4nYuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E84FE138F9;
        Thu,  7 Sep 2023 12:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cLQXOJjC+WTfHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:31:20 +0000
Date:   Thu, 7 Sep 2023 14:24:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 15/18] btrfs: check generation when recording simple
 quota delta
Message-ID: <20230907122449.GL3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <04ffbfcc145951c2f570312901b2c03c3c74e48e.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ffbfcc145951c2f570312901b2c03c3c74e48e.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:02PM -0700, Boris Burkov wrote:
> Simple quotas count extents only from the moment the feature is enabled.
> Therefore, if we do something like:
> 1. create subvol S
> 2. write F in S
> 3. enable quotas
> 4. remove F
> 5. write G in S
> 
> then after 3. and 4. we would expect the simple quota usage of S to be 0
> (putting aside some metadata extents that might be written) and after
> 5., it should be the size of G plus metadata. Therefore, we need to be
> able to determine whether a particular quota delta we are processing
> predates simple quota enablement.
> 
> To do this, store the transaction id when quotas were enabled. In
> fs_info for immediate use and in the quota status item to make it
> recoverable on mount. When we see a delta, check if the generation of
> the extent item is less than that of quota enablement. If so, we should
> ignore the delta from this extent.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/accessors.h            |  2 ++
>  fs/btrfs/extent-tree.c          |  4 ++++
>  fs/btrfs/fs.h                   |  2 ++
>  fs/btrfs/qgroup.c               | 14 ++++++++++++--
>  fs/btrfs/qgroup.h               |  1 +
>  include/uapi/linux/btrfs_tree.h |  7 +++++++
>  6 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index a23045c05937..513f8edbd98e 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -970,6 +970,8 @@ BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
>  		   flags, 64);
>  BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
>  		   rescan, 64);
> +BTRFS_SETGET_FUNCS(qgroup_status_enable_gen, struct btrfs_qgroup_status_item,
> +		   enable_gen, 64);
>  
>  /* btrfs_qgroup_info_item */
>  BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 1b5efd03ef83..395ab46e520b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1513,6 +1513,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  			.rsv_bytes = href->reserved_bytes,
>  			.is_data = true,
>  			.is_inc	= true,
> +			.generation = trans->transid,
>  		};
>  
>  		if (extent_op)
> @@ -1676,6 +1677,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  			.rsv_bytes = 0,
>  			.is_data = false,
>  			.is_inc = true,
> +			.generation = trans->transid,
>  		};
>  
>  		BUG_ON(!extent_op || !extent_op->update_flags);
> @@ -3217,6 +3219,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  			.rsv_bytes = 0,
>  			.is_data = is_data,
>  			.is_inc = false,
> +			.generation = btrfs_extent_generation(leaf, ei),
>  		};
>  
>  		/* In this branch refs == 1 */
> @@ -4850,6 +4853,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
>  	struct btrfs_simple_quota_delta delta = {
>  		.root = root_objectid,
>  		.num_bytes = ins->offset,
> +		.generation = trans->transid,
>  		.rsv_bytes = 0,
>  		.is_data = true,
>  		.is_inc = true,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index f76f450c2abf..da7b623ff15f 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -802,6 +802,8 @@ struct btrfs_fs_info {
>  	spinlock_t eb_leak_lock;
>  	struct list_head allocated_ebs;
>  #endif
> +
> +	u64 quota_enable_gen;

Please move it to the other quota/qgroup related members, at the end of
fs_info there's only debugging stuff.

>  };
>  
>  static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 58e9ed0deedd..a8a603242431 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -454,6 +454,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  			}
>  			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
>  			simple = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> +			if (simple)
> +				fs_info->quota_enable_gen = btrfs_qgroup_status_enable_gen(l, ptr);
>  			if (btrfs_qgroup_status_generation(l, ptr) !=
>  			    fs_info->generation && !simple) {
>  				qgroup_mark_inconsistent(fs_info);
> @@ -1107,10 +1109,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>  	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
>  	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
>  	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
> -	if (simple)
> +	if (simple) {
>  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> -	else
> +		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
> +	} else {
>  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +	}
>  	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
>  				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
>  	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
> @@ -1202,6 +1206,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>  		goto out_free_path;
>  	}
>  
> +	fs_info->quota_enable_gen = trans->transid;
> +
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	/*
>  	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
> @@ -4622,6 +4628,10 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
>  	if (!is_fstree(root))
>  		return 0;
>  
> +	/* If the extent predates enabling quotas, don't count it. */
> +	if (delta->generation < fs_info->quota_enable_gen)
> +		return 0;
> +
>  	spin_lock(&fs_info->qgroup_lock);
>  	qgroup = find_qgroup_rb(fs_info, root);
>  	if (!qgroup) {
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index ce6fa8694ca7..ae1ce14b365c 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -241,6 +241,7 @@ struct btrfs_simple_quota_delta {
>  	u64 rsv_bytes; /* The number of bytes reserved for this extent */
>  	bool is_inc; /* Whether we are using or freeing the extent */
>  	bool is_data; /* Whether the extent is data or metadata */
> +	u64 generation; /* The generation the extent was created in */

Please reorder it so it does not leave gaps between struct members.

>  };
>  
>  static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index eacb26caf3c6..1120ce3dae42 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1242,6 +1242,13 @@ struct btrfs_qgroup_status_item {
>  	 * of the scan. It contains a logical address
>  	 */
>  	__le64 rescan;
> +
> +	/*
> +	 * the generation when quotas are enabled. Used by simple quotas to
> +	 * avoid decrementing when freeing an extent that was written before
> +	 * enable.
> +	 */
> +	__le64 enable_gen;

This is public interface and btrfs_qgroup_status_item is used in many
places in user space at least in btrfs-progs. This needs a lot of
sanity checks.

>  } __attribute__ ((__packed__));
>  
>  struct btrfs_qgroup_info_item {
> -- 
> 2.41.0
