Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A44BDCE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358144AbiBUMlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 07:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358180AbiBUMkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 07:40:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A441928E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 04:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2E6861315
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 12:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B800C340E9;
        Mon, 21 Feb 2022 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645447218;
        bh=LRmrR7Ihdmkp2MFSgXtlFedUdOepio2Tg7oUhFLX3DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgsREbjWjxcBJRziU4NnnKRcYPlQA7IJQwaFICJYN6tQiDTaL1qcLkc/YsEQbG0JF
         roh3h/skZOI58UB1ot2CKJwUNVl0bECBDfJToHBPR4YF4y4wnHtpJWvY7OwAR9lgAq
         d88PLCo3P8bbqEm44OD2gzvBIhPRhVnhH2xCqjurbcTAFndZBSgdbMfCBAc8F/M6z5
         FVuxh3L0LPJ22EGnreXrKCiq618yu10eRdiAlaU9ulc7P+hqFZCMwmgIZduXfaW07K
         DIatA8TNV9s4GKiGuMVTqTf0HwQrbYcormTfkRmVfhLX/prwsCvk2iqvNSi/+Bxc6L
         LVPNaiLrFAj4g==
Date:   Mon, 21 Feb 2022 12:40:15 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] btrfs: use btrfs_fs_info for deleting snapshots
 and cleaner
Message-ID: <YhOIL6ujpHoBn3++@debian9.Home>
References: <cover.1645214059.git.josef@toxicpanda.com>
 <62d358e74de3ac1393c1e3e8d35d048b3d9861f2.1645214059.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d358e74de3ac1393c1e3e8d35d048b3d9861f2.1645214059.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 02:56:11PM -0500, Josef Bacik wrote:
> We're passing a root around here, but we only really need the fs_info,
> so fix up btrfs_clean_one_deleted_snapshot() to take an fs_info instead,
> and then fix up all the callers appropriately.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/disk-io.c     | 7 +++----
>  fs/btrfs/transaction.c | 4 ++--
>  fs/btrfs/transaction.h | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ed62e81c0b66..183baeffd9c9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1947,8 +1947,7 @@ static void end_workqueue_fn(struct btrfs_work *work)
>  
>  static int cleaner_kthread(void *arg)
>  {
> -	struct btrfs_root *root = arg;
> -	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)arg;
>  	int again;
>  
>  	while (1) {
> @@ -1981,7 +1980,7 @@ static int cleaner_kthread(void *arg)
>  
>  		btrfs_run_delayed_iputs(fs_info);
>  
> -		again = btrfs_clean_one_deleted_snapshot(root);
> +		again = btrfs_clean_one_deleted_snapshot(fs_info);
>  		mutex_unlock(&fs_info->cleaner_mutex);
>  
>  		/*
> @@ -3806,7 +3805,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_sysfs;
>  	}
>  
> -	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, tree_root,
> +	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
>  					       "btrfs-cleaner");
>  	if (IS_ERR(fs_info->cleaner_kthread))
>  		goto fail_sysfs;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index dfceee28a149..385c909f0db8 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2475,10 +2475,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   * because btrfs_commit_super will poke cleaner thread and it will process it a
>   * few seconds later.
>   */
> -int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
> +int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
>  {
> +	struct btrfs_root *root;
>  	int ret;
> -	struct btrfs_fs_info *fs_info = root->fs_info;
>  
>  	spin_lock(&fs_info->trans_lock);
>  	if (list_empty(&fs_info->dead_roots)) {
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index ba8a9826eb37..970ff316069d 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -217,7 +217,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
>  void btrfs_add_dead_root(struct btrfs_root *root);
>  int btrfs_defrag_root(struct btrfs_root *root);
>  void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info);
> -int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
> +int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
>  int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
>  void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
>  int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
> -- 
> 2.26.3
> 
