Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCB5070C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiDSOlG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350133AbiDSOlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 10:41:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547EE2181B
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 07:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 135F02129B;
        Tue, 19 Apr 2022 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650379101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XZyZE1x+5Zg488oQTOy5LEGng8AYp2FrAJdboxQ5ME=;
        b=USGTB2RfjNMkLNqyTiJMKz3vBMTgeiBPoT+E9tldTFs1yDxXMHMP31XvxR2uEpIRyITqru
        FQIAwmz4ca66jkVt1kxilmHYbNOcS7KJA7dy4BTXCI7vU7e4e14xyq1iaVBaDinQ2nBft6
        IkJ9N+F2bdEvpoEUJHUIbYogeMs01tA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E80D9132E7;
        Tue, 19 Apr 2022 14:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K4GSNlzJXmKBJQAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 19 Apr 2022 14:38:20 +0000
Message-ID: <3dd9274d-0ab7-d5b4-ebd4-bf01a31a2273@suse.com>
Date:   Tue, 19 Apr 2022 16:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: RETRACTED [PATCH v4] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220419133741.23849-1-gniebler@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20220419133741.23849-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Disregard this patch, please, it has a syntax error and won't even 
compile...

Am 19.04.22 um 15:37 schrieb Gabriel Niebler:
> … in the btrfs_root struct and adjust all usages of this object to use the
> XArray API, because it is notionally easier to use and unserstand, as it
> provides array semantics, and also takes care of locking for us, further
> simplifying the code.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

<snip>

> @@ -128,36 +128,29 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>   	u64 ino = btrfs_ino(btrfs_inode);
>   	int ret;
>   
> -again:
> -	node = btrfs_get_delayed_node(btrfs_inode);
> -	if (node)
> -		return node;
> -
> -	node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
> -	if (!node)
> -		return ERR_PTR(-ENOMEM);
> -	btrfs_init_delayed_node(node, root, ino);
> +        do {
> +		node = btrfs_get_delayed_node(btrfs_inode);
> +		if (node)
> +			return node;
>   
> -	/* cached in the btrfs inode and can be accessed */
> -	refcount_set(&node->refs, 2);
> +		node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
> +		if (!node)
> +			return ERR_PTR(-ENOMEM);
> +		btrfs_init_delayed_node(node, root, ino);
>   
> -	ret = radix_tree_preload(GFP_NOFS);
> -	if (ret) {
> -		kmem_cache_free(delayed_node_cache, node);
> -		return ERR_PTR(ret);
> -	}
> +		/* cached in the btrfs inode and can be accessed */
> +		refcount_set(&node->refs, 2);
>   
> -	spin_lock(&root->inode_lock);
> -	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
> -	if (ret == -EEXIST) {
> -		spin_unlock(&root->inode_lock);
> -		kmem_cache_free(delayed_node_cache, node);
> -		radix_tree_preload_end();
> -		goto again;
> -	}
> +		spin_lock(&root->inode_lock);
> +		ret = xa_insert(&root->delayed_nodes, ino, node, GFP_NOFS);
> +		if (ret) {
> +			spin_unlock(&root->inode_lock);
> +			kmem_cache_free(delayed_node_cache, node);
> +			if (ret != -EBUSY)
> +				return ERR_PTR(ret);
> +	} while (ret);

Here it is: missing "}"!

<snip>

Resubmission pending, sorry for the inconvenience
