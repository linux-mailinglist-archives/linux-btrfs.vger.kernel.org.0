Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F453B4F6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiFBIY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiFBIY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 04:24:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410B16581
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 01:24:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CABA721A75;
        Thu,  2 Jun 2022 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654158293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpm3jWn6NhHdpzUqRerGE9SuTeIE5MNAuK+EY7x6RH8=;
        b=dKKYGzr0mDUhjQR7eC/5vVMlfCADhrrm8tZvfmR5z2OrI/hLUXhduCw3WvX4wAs7UGEQRp
        W0kI3mBhHLwzOKfZ2swwa/ly+3fKS07NMTPqI5r9XDpMNsbKZRE12DYCQAz7JGZfc1r/bf
        pfcgg7xG0ra+ZS+DlUNoYaJQ4pK0KfM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1BCA13AC8;
        Thu,  2 Jun 2022 08:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LM2uJNVzmGLMJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 02 Jun 2022 08:24:53 +0000
Message-ID: <2cc71b46-7e53-d1a1-327f-39b28b18687e@suse.com>
Date:   Thu, 2 Jun 2022 11:24:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/12] btrfs: improve batch deletion of delayed dir index
 items
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <ddec7fd521fe5b0158241a2e111a54bab253f6d3.1654009356.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <ddec7fd521fe5b0158241a2e111a54bab253f6d3.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.05.22 г. 18:06 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 

<snip>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

One small idea, see further down below though.

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/delayed-inode.c | 60 +++++++++++++++++-----------------------
>   1 file changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 0125586fd565..74c806d3ab2a 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -791,68 +791,58 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>   {

<snip>

> +	while (slot < last_slot) {
> +		struct btrfs_key key;
>   
> -		curr = next;
>   		next = __btrfs_next_delayed_item(curr);
>   		if (!next)
>   			break;
>   
> -		if (!btrfs_is_continuous_delayed_item(curr, next))
> +		slot++;
> +		btrfs_item_key_to_cpu(leaf, &key, slot);
> +		if (btrfs_comp_cpu_keys(&next->key, &key) != 0)
>   			break;
> -
> -		i++;
> -		if (i > last_item)
> -			break;
> -		btrfs_item_key_to_cpu(leaf, &key, i);
> +		nitems++;
> +		curr = next;
> +		list_add_tail(&curr->tree_list, &batch_list);
>   	}
>   
> -	/*
> -	 * Our caller always gives us a path pointing to an existing item, so
> -	 * this can not happen.
> -	 */
> -	ASSERT(nitems >= 1);
> -	if (nitems < 1)
> -		return -ENOENT;
> -
>   	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
>   	if (ret)
> -		goto out;
> +		return ret;
>   
> -	list_for_each_entry_safe(curr, next, &head, tree_list) {
> +	list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
>   		btrfs_delayed_item_release_metadata(root, curr);
>   		list_del(&curr->tree_list);
>   		btrfs_release_delayed_item(curr);
>   	}

nit: This function could be further optimized
with the following snippet.

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index fedbc45b71a2..950f5a2a9950 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -805,6 +805,7 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
         LIST_HEAD(batch_list);
         int nitems, slot, last_slot;
         int ret;
+       u64 bytes_reserved = item->bytes_reserved;
  
         ASSERT(leaf != NULL);
  
@@ -840,6 +841,7 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
                         break;
                 nitems++;
                 curr = next;
+               bytes_reserved += curr->bytes_reserved;
                 list_add_tail(&curr->tree_list, &batch_list);
         }
  
@@ -847,8 +849,11 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
         if (ret)
                 return ret;
  
+       btrfs_block_rsv_release(root->fs_info, &root->fs_info->delayed_block_rsv,
+                               bytes_reserved, NULL);
+
         list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
-               btrfs_delayed_item_release_metadata(root, curr);
+               //btrfs_delayed_item_release_metadata(root, curr);
                 list_del(&curr->tree_list);
                 btrfs_release_delayed_item(curr);
         }


Running your series VS this diff on top produces:

Before this change:
@block_rsv_release: 1004
@btrfs_delete_delayed_items_total_time: 14602
@delete_batches: 505

After:
@block_rsv_release: 510
@btrfs_delete_delayed_items_total_time: 13643
@delete_batches: 507


>   
> -out:
> -	return ret;
> +	return 0;
>   }
>   
>   static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
