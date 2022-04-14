Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F6500F1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbiDNNYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 09:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbiDNNYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 09:24:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8D9AE7B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 06:18:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C05801F746;
        Thu, 14 Apr 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649942334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDO87uz2agmKn3RdwBura3ZjeVdKQS4Vkx52wlxG6gY=;
        b=RHp/v8jZZRttHgbPO6CDirzDOTlveYLRzgXygH7DfnTqxUVcO2DNF6yvgHhWdSp5ypL5yF
        RmmrXVD0lvTlav9GLXN72pmpXzg36tI0LMAAI1xLVnnE/vzdkx76DVMfE3/2JFNXgXacc9
        bzFXMhK1txZrygxQfxWyDkSKnGwMg4M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 870DB132C0;
        Thu, 14 Apr 2022 13:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VoX3HT4fWGLYQQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Apr 2022 13:18:54 +0000
Message-ID: <d108b994-3583-e794-d14e-f07e4cc3d91a@suse.com>
Date:   Thu, 14 Apr 2022 16:18:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220414101054.15230-1-gniebler@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220414101054.15230-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.04.22 г. 13:10 ч., Gabriel Niebler wrote:
> … in the btrfs_root struct and adjust all usages of this object to use the
> XArray API, because it is notionally easier to use and unserstand, as it
> provides array semantics, and also takes care of locking for us, further
> simplifying the code.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

Apart from some minor remarks (see below) looks good.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/ctree.h         |  4 ++--
>   fs/btrfs/delayed-inode.c | 49 +++++++++++++++++++---------------------
>   fs/btrfs/disk-io.c       |  2 +-
>   fs/btrfs/inode.c         |  2 +-
>   4 files changed, 27 insertions(+), 30 deletions(-)
> 

<snip>

> @@ -141,23 +141,17 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>   	/* cached in the btrfs inode and can be accessed */
>   	refcount_set(&node->refs, 2);
>   
> -	ret = radix_tree_preload(GFP_NOFS);
> -	if (ret) {
> -		kmem_cache_free(delayed_node_cache, node);
> -		return ERR_PTR(ret);
> -	}
> -
>   	spin_lock(&root->inode_lock);
> -	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
> -	if (ret == -EEXIST) {
> +	ret = xa_insert(&root->delayed_nodes, ino, node, GFP_NOFS);
> +	if (ret) {
>   		spin_unlock(&root->inode_lock);
>   		kmem_cache_free(delayed_node_cache, node);
> -		radix_tree_preload_end();
> -		goto again;
> +		if (ret == -EBUSY)
> +			goto again;
> +		return ERR_PTR(ret);
>   	}
>   	btrfs_inode->delayed_node = node;
>   	spin_unlock(&root->inode_lock);
> -	radix_tree_preload_end();

nit: One suggestion instead of relying on the goto again; do implement what's
essentially a do {} while() loop, this code can be easily turned into a
well-formed do {} while(). Usually this type of construct (label to implement a loop)
is used to reduce indentation levels however in this case I did the transformation
and we are not breaking the 80 chars line:

     21         do {
     20                 node = btrfs_get_delayed_node(btrfs_inode);
     19                 if (node)
     18                         return node;
     17
     16                 node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
     15                 if (!node)
     14                         return ERR_PTR(-ENOMEM);
     13                 btrfs_init_delayed_node(node, root, ino);
     12
     11                 /* cached in the btrfs inode and can be accessed */
     10                 refcount_set(&node->refs, 2);
      9
      8                 spin_lock(&root->inode_lock);
      7                 ret = xa_insert(&root->delayed_nodes, ino, node, GFP_NOFS);
      6                 if (ret) {
      5                         spin_unlock(&root->inode_lock);
      4                         kmem_cache_free(delayed_node_cache, node);
      3                         if (ret != -EBUSY)
      2                                 return ERR_PTR(ret);
      1                 }
   152          } while (ret);

I personally dislike using labels like that but since you are changing this code now might be
a good time to also fix this wrinkle but this is not a deal breaker and I'd be happy to see David's
opinion.

>   
>   	return node;
>   }

<snip>

> @@ -1870,29 +1863,33 @@ void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
>   
>   void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>   {
> -	u64 inode_id = 0;
> +	unsigned long index = 0;
> +	struct btrfs_delayed_node *delayed_node;
>   	struct btrfs_delayed_node *delayed_nodes[8];
>   	int i, n;
>   
>   	while (1) {
>   		spin_lock(&root->inode_lock);
> -		n = radix_tree_gang_lookup(&root->delayed_nodes_tree,
> -					   (void **)delayed_nodes, inode_id,
> -					   ARRAY_SIZE(delayed_nodes));
> -		if (!n) {
> +		if (xa_empty(&root->delayed_nodes)) {
>   			spin_unlock(&root->inode_lock);
>   			break;

nit: This could be turned into a return just because if someone's reading the code seeing the return would be an
instant "let's forget this function" rather than having to scan downwards to see if anything special
is going on after the loop's body.

>   		}
>   
> -		inode_id = delayed_nodes[n - 1]->inode_id + 1;
> -		for (i = 0; i < n; i++) {
> +		n = 0;
> +		xa_for_each_start(&root->delayed_nodes, index,
> +				  delayed_node, index) {
>   			/*
>   			 * Don't increase refs in case the node is dead and
>   			 * about to be removed from the tree in the loop below
>   			 */
> -			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
> -				delayed_nodes[i] = NULL;
> +			delayed_nodes[n] = delayed_node;
> +			if (!refcount_inc_not_zero(&delayed_node->refs))
> +				delayed_nodes[n] = NULL;

nit: instead of doing the assign; check if we should undo the assignment you can do
something like :

@@ -1878,13 +1879,13 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
                 n = 0;
                 xa_for_each_start(&root->delayed_nodes, index,
                                   delayed_node, index) {
+                       struct btrfs_delayed_node *delayed_nodes[8] = {};
                         /*
                          * Don't increase refs in case the node is dead and
                          * about to be removed from the tree in the loop below
                          */
-                       delayed_nodes[n] = delayed_node;
-                       if (!refcount_inc_not_zero(&delayed_node->refs))
-                               delayed_nodes[n] = NULL;
+                       if (refcount_inc_not_zero(&delayed_node->refs))
+                               delayed_nodes[n] = delayed_node;
                         n++;
                         if (n >= ARRAY_SIZE(delayed_nodes))
                                 break;

That is define the delayed_nodes array inside the loop as this is its lifetime, and also uses an
empty designated initializer so that the array is guaranteed to be zero initialized, then you only
assign a node if you manged to get a refcount. IMO this is somewhat cleaner.


> +			n++;

Also since you are doing a "for each" style iteration then n++ can be incremented only if you actually
saved a node, that is refcount was successful. That way you guarantee that delayed_nodes will contain 8 nodes to free.

Alternatively think if you have 8 nodes and 7 of them are dying, in this case you will only save 1 node but increment n 8 times
and then break, so the subsequent invocation of the freeing loop will only free 1 node i.e you lose the effect of batching.

<snip>


