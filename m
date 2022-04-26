Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161150FBBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbiDZLOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiDZLOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 07:14:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465D05FAF
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 04:11:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA7BA210E4;
        Tue, 26 Apr 2022 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650971460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApN9LLjHYFwVzOk154LLCyqdNPudKzOrgwT8dw6FEQU=;
        b=rxd5TTAqNAIyeiKD5AdekLMhTmzLLFu8D3cbSTN7ICfyvKX5h1Sqxk2OyYvDHM8ftPv6hH
        YWfHkRBs+K54X/UMaiyk6JWweFbH+6bAtYKQd03IPZRPp43PV+dKB8/k8NSpKhr/L3o5VG
        yl+4GL3t0+vvqCEG6XIHkaUtv4EeX78=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B14AE13AD5;
        Tue, 26 Apr 2022 11:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5JdaKETTZ2JZagAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 26 Apr 2022 11:11:00 +0000
Message-ID: <8878c000-a9f2-477f-8996-08381d1fecc5@suse.com>
Date:   Tue, 26 Apr 2022 14:11:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220426094304.7952-1-gniebler@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220426094304.7952-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.04.22 г. 12:43 ч., Gabriel Niebler wrote:
> … in the btrfs_root struct and adjust all usages of this object to use the
> XArray API, because it is notionally easier to use and unserstand, as it
> provides array semantics, and also takes care of locking for us, further
> simplifying the code.
> 
> Also use the opportunity to do some light refactoring.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

<snip>

> @@ -1870,32 +1863,36 @@ void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
>   
>   void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>   {
> -	u64 inode_id = 0;
> +	unsigned long index = 0;
> +	struct btrfs_delayed_node *delayed_node;
>   	struct btrfs_delayed_node *delayed_nodes[8];
> -	int i, n;
>   
>   	while (1) {
> +		int n = 0;
> +
>   		spin_lock(&root->inode_lock);
> -		n = radix_tree_gang_lookup(&root->delayed_nodes_tree,
> -					   (void **)delayed_nodes, inode_id,
> -					   ARRAY_SIZE(delayed_nodes));
> -		if (!n) {
> +		if (xa_empty(&root->delayed_nodes)) {
>   			spin_unlock(&root->inode_lock);
> -			break;
> +			return;
>   		}
>   
> -		inode_id = delayed_nodes[n - 1]->inode_id + 1;
> -		for (i = 0; i < n; i++) {
> +		xa_for_each_start(&root->delayed_nodes, index,
> +				  delayed_node, index) {
>   			/*
>   			 * Don't increase refs in case the node is dead and
>   			 * about to be removed from the tree in the loop below
>   			 */
> -			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
> -				delayed_nodes[i] = NULL;
> +			if (refcount_inc_not_zero(&delayed_node->refs)) {
> +				delayed_nodes[n] = delayed_node;
> +				n++;
> +			}
> +			if (n >= ARRAY_SIZE(delayed_nodes))
> +				break;
>   		}
> +		index++;
>   		spin_unlock(&root->inode_lock);
>   
> -		for (i = 0; i < n; i++) {
> +		for (int i = 0; i < n; i++) {
>   			if (!delayed_nodes[i])
>   				continue;

nit: This check now becomes redundant right, because the way n is 
modified we are guaranteed that everything from 0..n will actually be 
populated.

<snip>
