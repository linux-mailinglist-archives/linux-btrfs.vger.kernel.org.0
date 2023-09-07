Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D34797BBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbjIGS1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbjIGS1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 14:27:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866B180
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 11:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5BF32187D;
        Thu,  7 Sep 2023 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694089404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85vGKT664wOjXHZPubTBFLDWYIY6+175wxsy5LEWRIU=;
        b=qZL0pCT20cIHzRbFS+1P2HZg9/OQaPG+UXOkSQCqfUKs5GRo1vxiJAq9/tqzE5xigUVRNE
        j7kwB15RiWg6HjnLgXi+WZGQbwf3xZEhQS0QOxZqWENz+WGU+9W8B7PddCeV5yuU7VfuB0
        gEjLiQQY+Um/CMvGB7hDBZwvngNQ37I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694089404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85vGKT664wOjXHZPubTBFLDWYIY6+175wxsy5LEWRIU=;
        b=bBBXzWCkSV/PWFCDsaQcXyWSQ2E23n2pJE5QYp13LA2dwz6ZZAMcNLezq0HlT3Cefa43Bv
        fEWgSZAo1rki8TAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AB10138F9;
        Thu,  7 Sep 2023 12:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dKITIbzA+WQ3GgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:23:24 +0000
Date:   Thu, 7 Sep 2023 14:16:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 14/18] btrfs: simple quota auto hierarchy for nested
 subvols
Message-ID: <20230907121652.GK3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <0e445145d0faff95d0c42e5ebac222d838bb0293.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e445145d0faff95d0c42e5ebac222d838bb0293.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:01PM -0700, Boris Burkov wrote:
> Consider the following sequence:
> - enable quotas
> - create subvol S id 256 at dir outer/
> - create a qgroup 1/100
> - add 0/256 (S's auto qgroup) to 1/100
> - create subvol T id 257 at dir outer/inner/
> 
> With full qgroups, there is no relationship between 0/257 and either of
> 0/256 or 1/100. There is an inherit feature that the creator of inner/
> can use to specify it ought to be in 1/100.
> 
> Simple quotas are targeted at container isolation, where such automatic
> inheritance for not necessarily trusted/controlled nested subvol
> creation would be quite helpful. Therefore, add a new default behavior
> for simple quotas: when you create a nested subvol, automatically
> inherit as parents any parents of the qgroup of the subvol the new inode
> is going in.
> 
> In our example, 257/0 would also be under 1/100, allowing easy control
> of a total quota over an arbitrary hierarchy of subvolumes.
> 
> I think this _might_ be a generally useful behavior, so it could be
> interesting to put it behind a new inheritance flag that simple quotas
> always use while traditional quotas let the user specify, but this is a
> minimally intrusive change to start.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ioctl.c       |  2 +-
>  fs/btrfs/qgroup.c      | 44 +++++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/qgroup.h      |  6 +++---
>  fs/btrfs/transaction.c | 13 +++++++++----
>  4 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9b61bc62e439..c9b069077fd0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -652,7 +652,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>  	/* Tree log can't currently deal with an inode which is a new root. */
>  	btrfs_set_log_full_commit(trans);
>  
> -	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
> +	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
>  	if (ret)
>  		goto out;
>  
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index dedc532669f4..58e9ed0deedd 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1550,8 +1550,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> -			      u64 dst)
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_qgroup *parent;
> @@ -2991,6 +2990,40 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>  	return ret;
>  }
>  
> +static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
> +			       u64 inode_rootid,
> +			       struct btrfs_qgroup_inherit **inherit)
> +{
> +	int i = 0;
> +	u64 num_qgroups = 0;
> +	struct btrfs_qgroup *inode_qg;
> +	struct btrfs_qgroup_list *qg_list;
> +
> +	if (*inherit)
> +		return -EEXIST;
> +
> +	inode_qg = find_qgroup_rb(fs_info, inode_rootid);
> +	if (!inode_qg)
> +		return -ENOENT;
> +
> +	num_qgroups = list_count_nodes(&inode_qg->groups);
> +
> +	if (!num_qgroups)
> +		return 0;
> +
> +	*inherit = kzalloc(sizeof(**inherit) + num_qgroups * sizeof(u64), GFP_NOFS);

There's kcalloc that verifies the potential multiplication overflow.

> +	if (!*inherit)
> +		return -ENOMEM;
> +	(*inherit)->num_qgroups = num_qgroups;
> +
> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> +		u64 qg_id = qg_list->group->qgroupid;
> +		*((u64 *)((*inherit)+1) + i) = qg_id;

What does this do?

> +	}

Instead of reusing the *inherit for operations, please add a local
variable and at the end assign it to *inherit.

> +
> +	return 0;
> +}
> +
>  /*
>   * Copy the accounting information between qgroups. This is necessary
>   * when a snapshot or a subvolume is created. Throwing an error will
> @@ -2998,7 +3031,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>   * when a readonly fs is a reasonable outcome.
>   */
>  int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
> +			 u64 objectid, u64 inode_rootid,
> +			 struct btrfs_qgroup_inherit *inherit)
>  {
>  	int ret = 0;
>  	int i;
> @@ -3040,6 +3074,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  		goto out;
>  	}
>  
> +	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)

Swap the conditions please

> +		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
> +
>  	if (inherit) {
>  		i_qgroups = (u64 *)(inherit + 1);
>  		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
> @@ -3066,6 +3103,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  	if (ret)
>  		goto out;
>  
> +

Stray newline

>  	/*
>  	 * add qgroup to all inherited groups
>  	 */
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 94d85b4fbebd..ce6fa8694ca7 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -271,8 +271,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
>  void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
>  int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
>  				     bool interruptible);
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> -			      u64 dst);
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
>  int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>  			      u64 dst);
>  int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
> @@ -366,7 +365,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
>  int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
>  int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit);
> +			 u64 objectid, u64 inode_rootid,
> +			 struct btrfs_qgroup_inherit *inherit);
>  void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
>  			       u64 ref_root, u64 num_bytes,
>  			       enum btrfs_qgroup_rsv_type type);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 25217888e897..fb857147df57 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1529,13 +1529,14 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>  	int ret;
>  
>  	/*
> -	 * Save some performance in the case that full qgroups are not
> +	 * Save some performance in the case that qgroups are not
>  	 * enabled. If this check races with the ioctl, rescan will
>  	 * kick in anyway.
>  	 */
>  	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
>  		return 0;
>  
> +

Again

>  	/*
>  	 * Ensure dirty @src will be committed.  Or, after coming
>  	 * commit_fs_roots() and switch_commit_roots(), any dirty but not
> @@ -1572,7 +1573,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>  
>  	/* Now qgroup are all updated, we can inherit it to new qgroups */
>  	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
> -				   inherit);
> +				   parent->root_key.objectid, inherit);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -1839,8 +1840,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  	 * To co-operate with that hack, we do hack again.
>  	 * Or snapshot will be greatly slowed down by a subtree qgroup rescan
>  	 */
> -	ret = qgroup_account_snapshot(trans, root, parent_root,
> -				      pending->inherit, objectid);
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL)
> +		ret = qgroup_account_snapshot(trans, root, parent_root,
> +					      pending->inherit, objectid);
> +	else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		ret = btrfs_qgroup_inherit(trans, root->root_key.objectid, objectid,
> +					   parent_root->root_key.objectid, pending->inherit);
>  	if (ret < 0)
>  		goto fail;
>  
> -- 
> 2.41.0
