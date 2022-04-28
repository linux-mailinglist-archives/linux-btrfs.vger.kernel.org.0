Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC6513325
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiD1MCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1MCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 08:02:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA08908A
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 04:59:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4EB2F210DF;
        Thu, 28 Apr 2022 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651147163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCw1gV5UVx00w73JfQFuxJMLF7WLyqMbg6WBPCn1bbM=;
        b=Fo/4EcU6tg1vUfDMfijV7kF6ZMd7KZ9wH919nULSNvUu2D+zRpmJKqAk5v6t6lEtvePIau
        ktu3XPduWNqrtmPPqSMHrLfK2k9bUzkKQgHLvAra8MZgNWDHVHM1UB+5ObQ79+T78k0ySC
        3E1+wga0yLWMgW75UAyc5kXElKfaE0k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18D5B13AF8;
        Thu, 28 Apr 2022 11:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hGv1ApuBamJDGgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Apr 2022 11:59:23 +0000
Message-ID: <a2b7e2c4-440c-318c-ea1f-273be04591f0@suse.com>
Date:   Thu, 28 Apr 2022 14:59:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220426214525.14192-1-gniebler@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220426214525.14192-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.04.22 г. 0:45 ч., Gabriel Niebler wrote:
> … rename it to simply fs_roots and adjust all usages of this object to use
> the XArray API, because it is notionally easier to use and unserstand, as
> it provides array semantics, and also takes care of locking for us,
> further simplifying the code.
> 
> Also do some refactoring, esp. where the API change requires largely
> rewriting some functions, anyway.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>   fs/btrfs/ctree.h       |   5 +-
>   fs/btrfs/disk-io.c     | 176 ++++++++++++++++++++---------------------
>   fs/btrfs/inode.c       |  13 +--
>   fs/btrfs/transaction.c |  67 +++++++---------
>   4 files changed, 126 insertions(+), 135 deletions(-)
> 

<snip>

> @@ -2346,28 +2340,23 @@ void btrfs_put_root(struct btrfs_root *root)
>   
>   void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
>   {
> -	int ret;
> -	struct btrfs_root *gang[8];
> -	int i;
> +	struct btrfs_root *root;
> +	unsigned long index = 0;
>   
>   	while (!list_empty(&fs_info->dead_roots)) {
> -		gang[0] = list_entry(fs_info->dead_roots.next,
> -				     struct btrfs_root, root_list);
> -		list_del(&gang[0]->root_list);
> +		root = list_entry(fs_info->dead_roots.next,
> +				  struct btrfs_root, root_list);
> +		list_del(&root->root_list);
>   
> -		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
> -			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
> -		btrfs_put_root(gang[0]);
> +		if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state))
> +			btrfs_drop_and_free_fs_root(fs_info, root);
> +		btrfs_put_root(root);
>   	}
>   
> -	while (1) {
> -		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> -					     (void **)gang, 0,
> -					     ARRAY_SIZE(gang));
> -		if (!ret)
> -			break;
> -		for (i = 0; i < ret; i++)
> -			btrfs_drop_and_free_fs_root(fs_info, gang[i]);
> +	while (!xa_empty(&fs_info->fs_roots))  > +		xa_for_each(&fs_info->fs_roots, index, root) {

Why do you need the nested loop structure? xa_for_each should be 
sufficient as btrfs_free_fs_roots happens when the fs is being unmounted 
and we can't get another loop added after having done xa_for_each. And 
even if it could the nested loop structure won't help because we don't 
hold any locks, so hypothetically speaking, even if there was a race 
using nested loops doesn't solve it.

TLDR: Leavint this xa_for_each should be sufficient.

> +			btrfs_drop_and_free_fs_root(fs_info, root);
> +		}
>   	}
>   }
>   

<snip>

> @@ -4491,12 +4480,12 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
>   {
>   	bool drop_ref = false;
>   
> -	spin_lock(&fs_info->fs_roots_radix_lock);
> -	radix_tree_delete(&fs_info->fs_roots_radix,
> -			  (unsigned long)root->root_key.objectid);
> +	spin_lock(&fs_info->fs_roots_lock);
> +	xa_erase(&fs_info->fs_roots,
> +		 (unsigned long)root->root_key.objectid);

nit: No need to have the 2nd argument on a new line, as the line is 
short enough.
>   	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
>   		drop_ref = true;
> -	spin_unlock(&fs_info->fs_roots_radix_lock);
> +	spin_unlock(&fs_info->fs_roots_lock);
>   
>   	if (BTRFS_FS_ERROR(fs_info)) {
>   		ASSERT(root->log_root == NULL);
> @@ -4512,50 +4501,54 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
>   
>   int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>   {
> -	u64 root_objectid = 0;
> -	struct btrfs_root *gang[8];
> -	int i = 0;
> +	struct btrfs_root *roots[8];
> +	unsigned long index = 0;
> +	int i;
nit: This can be defined into the 2 loops that use the variable.


>   	int err = 0;
> -	unsigned int ret = 0;
> +	int grabbed;
>   
>   	while (1) {
> -		spin_lock(&fs_info->fs_roots_radix_lock);
> -		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> -					     (void **)gang, root_objectid,
> -					     ARRAY_SIZE(gang));
> -		if (!ret) {
> -			spin_unlock(&fs_info->fs_roots_radix_lock);
> +		struct btrfs_root *root;
> +
> +		spin_lock(&fs_info->fs_roots_lock);
> +		if (!xa_find(&fs_info->fs_roots, &index,
> +			     ULONG_MAX, XA_PRESENT)) {
> +			spin_unlock(&fs_info->fs_roots_lock);
>   			break;
>   		}
> -		root_objectid = gang[ret - 1]->root_key.objectid + 1;
>   
> -		for (i = 0; i < ret; i++) {
> -			/* Avoid to grab roots in dead_roots */
> -			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
> -				gang[i] = NULL;
> -				continue;
> +		grabbed = 0;
> +		xa_for_each_start(&fs_info->fs_roots, index, root,
> +				  index) {
> +			/* Avoid grabbing roots in dead_roots */
> +			if (btrfs_root_refs(&root->root_item) == 0) {
> +				roots[grabbed] = NULL;
> +			} else {
> +				/* Grab all the search results for later use */
> +				roots[grabbed] = btrfs_grab_root(root);
>   			}
> -			/* grab all the search result for later use */
> -			gang[i] = btrfs_grab_root(gang[i]);
> +			grabbed++;
> +			if (grabbed >= ARRAY_SIZE(roots))
> +				break;
>   		}
> -		spin_unlock(&fs_info->fs_roots_radix_lock);
> +		spin_unlock(&fs_info->fs_roots_lock);
>   
> -		for (i = 0; i < ret; i++) {
> -			if (!gang[i])
> +		for (i = 0; i < grabbed; i++) {
> +			if (!roots[i])
>   				continue;
> -			root_objectid = gang[i]->root_key.objectid;
> -			err = btrfs_orphan_cleanup(gang[i]);
> +			index = roots[i]->root_key.objectid;
> +			err = btrfs_orphan_cleanup(roots[i]);
>   			if (err)
>   				break;
> -			btrfs_put_root(gang[i]);
> +			btrfs_put_root(roots[i]);
>   		}
> -		root_objectid++;
> +		index++;
>   	}
>   
> -	/* release the uncleaned roots due to error */
> -	for (; i < ret; i++) {
> -		if (gang[i])
> -			btrfs_put_root(gang[i]);
> +	/* Release the roots that remain uncleaned due to error */
> +	for (; i < grabbed; i++) {
> +		if (roots[i])
> +			btrfs_put_root(roots[i]);
>   	}
>   	return err;
>   }
> @@ -4872,31 +4865,36 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
>   
>   static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_root *gang[8];
> -	u64 root_objectid = 0;
> -	int ret;
> +	unsigned long index = 0;
>   
> -	spin_lock(&fs_info->fs_roots_radix_lock);
> -	while ((ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> -					     (void **)gang, root_objectid,
> -					     ARRAY_SIZE(gang))) != 0) {
> +	spin_lock(&fs_info->fs_roots_lock);
> +	while (xa_find(&fs_info->fs_roots,
> +		       &index, ULONG_MAX, XA_PRESENT)) {

nit: No need to split across two lines as it's short enough.

> +		struct btrfs_root *root;
> +		struct btrfs_root *roots[8];
>   		int i;

nit: This can probably be defined inside the for loop

> +		int grabbed = 0;
>   
> -		for (i = 0; i < ret; i++)
> -			gang[i] = btrfs_grab_root(gang[i]);
> -		spin_unlock(&fs_info->fs_roots_radix_lock);
> +		xa_for_each_start(&fs_info->fs_roots, index, root,
> +				  index) {
> +			roots[grabbed] = btrfs_grab_root(root);
> +			grabbed++;
> +			if (grabbed >= ARRAY_SIZE(roots))
> +				break;
> +		}
> +		spin_unlock(&fs_info->fs_roots_lock);
>   
> -		for (i = 0; i < ret; i++) {
> -			if (!gang[i])
> +		for (i = 0; i < grabbed; i++) {
> +			if (!roots[i])
>   				continue;
> -			root_objectid = gang[i]->root_key.objectid;
> -			btrfs_free_log(NULL, gang[i]);
> -			btrfs_put_root(gang[i]);
> +			index = roots[i]->root_key.objectid;
> +			btrfs_free_log(NULL, roots[i]);
> +			btrfs_put_root(roots[i]);
>   		}
> -		root_objectid++;
> -		spin_lock(&fs_info->fs_roots_radix_lock);
> +		index++;
> +		spin_lock(&fs_info->fs_roots_lock);
>   	}
> -	spin_unlock(&fs_info->fs_roots_radix_lock);
> +	spin_unlock(&fs_info->fs_roots_lock);
>   	btrfs_free_log_root_tree(NULL, fs_info);
>   }
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5082b9c70f8c..d0ef3a17ce11 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3494,6 +3494,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>   	u64 last_objectid = 0;
>   	int ret = 0, nr_unlink = 0;
>   
> +	/* Bail out if the cleanup is already running. */
nit: This seems like an irrelevant change.

>   	if (test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &root->state))
>   		return 0;
>   

<snip>

> @@ -1404,9 +1402,8 @@ void btrfs_add_dead_root(struct btrfs_root *root)
>   static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>   {
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	struct btrfs_root *gang[8];
> -	int i;
> -	int ret;
> +	struct btrfs_root *root;
> +	unsigned long index;
>   
>   	/*
>   	 * At this point no one can be using this transaction to modify any tree
> @@ -1414,17 +1411,11 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>   	 */
>   	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
>   
> -	spin_lock(&fs_info->fs_roots_radix_lock);
> -	while (1) {
> -		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
> -						 (void **)gang, 0,
> -						 ARRAY_SIZE(gang),
> -						 BTRFS_ROOT_TRANS_TAG);
> -		if (ret == 0)
> -			break;
> -		for (i = 0; i < ret; i++) {
> -			struct btrfs_root *root = gang[i];
> -			int ret2;
> +	spin_lock(&fs_info->fs_roots_lock);
> +	while (xa_marked(&fs_info->fs_roots, BTRFS_ROOT_TRANS_TAG)) {
> +		xa_for_each_marked(&fs_info->fs_roots, index, root,

While the while/xa_for_each_marked and not straight xa_for_each_marked?

> +				   BTRFS_ROOT_TRANS_TAG) {
> +			int ret;
>   
>   			/*
>   			 * At this point we can neither have tasks logging inodes

<snip>
