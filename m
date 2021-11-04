Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D27445367
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhKDM5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 08:57:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49498 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhKDM5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 08:57:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E561F212BD;
        Thu,  4 Nov 2021 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636030512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOrid0ZM7s/4nYFGEfGVq7yT4Wgr67N7L76bEuwu0NE=;
        b=HLX2lWLASqJUeqKOZ/7S3kDQPm6FJkYFjZ2VyikOI8nMNpTwSRc9jKuzd8h5EjjQCWgYdO
        qNEhCho0RPDiMLcgZom7zUbc62RLlX3qM/xSr5pT/cgBXmK29OOht7Zvwie4bBniZvWIoQ
        c8ePbv4E9yjXGax8e9/qR3UZiiscMcI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B49DE13BD4;
        Thu,  4 Nov 2021 12:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TAeuKTDYg2HEGgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 12:55:12 +0000
Subject: Re: [PATCH 3/4] btrfs: get rid of root->orphan_cleanup_state
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1635450288.git.josef@toxicpanda.com>
 <dc82d55bbdf6448b612c49856c5499b5add1bbc5.1635450288.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3ce2791f-ee93-0e71-b06f-e4952052bba2@suse.com>
Date:   Thu, 4 Nov 2021 14:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dc82d55bbdf6448b612c49856c5499b5add1bbc5.1635450288.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.21 г. 22:50, Josef Bacik wrote:
> Now that we don't care about the stage of the orphan_cleanup_state,
> simply replace it with a bit on ->state to make sure we don't call the
> orphan cleanup every time we wander into this root.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h   | 9 ++-------
>  fs/btrfs/disk-io.c | 1 -
>  fs/btrfs/inode.c   | 4 +---
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7553e9dc5f93..01f6a40ba2dd 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -511,11 +511,6 @@ struct btrfs_discard_ctl {
>  	atomic64_t discard_bytes_saved;
>  };
>  
> -enum btrfs_orphan_cleanup_state {
> -	ORPHAN_CLEANUP_STARTED	= 1,
> -	ORPHAN_CLEANUP_DONE	= 2,
> -};
> -
>  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
>  
>  /* fs_info */
> @@ -1110,6 +1105,8 @@ enum {
>  	BTRFS_ROOT_HAS_LOG_TREE,
>  	/* Qgroup flushing is in progress */
>  	BTRFS_ROOT_QGROUP_FLUSHING,
> +	/* We started the orphan cleanup for this root. */
> +	BTRFS_ROOT_ORPHAN_CLEANUP,
>  };
>  
>  /*
> @@ -1178,8 +1175,6 @@ struct btrfs_root {
>  	spinlock_t log_extents_lock[2];
>  	struct list_head logged_list[2];
>  
> -	int orphan_cleanup_state;
> -
>  	spinlock_t inode_lock;
>  	/* red-black tree that keeps track of in-memory inodes */
>  	struct rb_root inode_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c7254331cf38..5be0ae67ceb7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1144,7 +1144,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
>  	root->node = NULL;
>  	root->commit_root = NULL;
>  	root->state = 0;
> -	root->orphan_cleanup_state = 0;
>  
>  	root->last_trans = 0;
>  	root->free_objectid = 0;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c783a3e434b9..a9ebafb168b5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3475,7 +3475,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  	u64 last_objectid = 0;
>  	int ret = 0, nr_unlink = 0;
>  
> -	if (cmpxchg(&root->orphan_cleanup_state, 0, ORPHAN_CLEANUP_STARTED))
> +	if (test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &root->state))
>  		return 0;
>  
>  	path = btrfs_alloc_path();
> @@ -3633,8 +3633,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  	/* release the path since we're done with it */
>  	btrfs_release_path(path);
>  
> -	root->orphan_cleanup_state = ORPHAN_CLEANUP_DONE;

Don't you need to clear the bit at this stage?

> -
>  	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state)) {
>  		trans = btrfs_join_transaction(root);
>  		if (!IS_ERR(trans))
> 
