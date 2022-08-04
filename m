Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8820C589EE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiHDPqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 11:46:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3926AE2
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 08:46:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6EAE833B37;
        Thu,  4 Aug 2022 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659628004;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQN3IgEsSVbzt4dNHFXLuT9QSWiXqao1ou8qXAcBqMA=;
        b=SU0DQMB4rhiccl82irYfr6R/Q/4E3DHS584eFkgXpi3wJOq6XFWNtKZcbAD0SUNZfS4KJn
        VE+gctNh/QarxdIloQDn3saNAnU/A7nqNGZJNbf22IAU56UUSKmVPdHdRgEb34KbR9/VdD
        RYZADyeaphy9nvAX+IA9s942CVaWAVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659628004;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQN3IgEsSVbzt4dNHFXLuT9QSWiXqao1ou8qXAcBqMA=;
        b=7aWaqe+jo8Yp71qAGF6vOq9foM3yqLTvU1TUja4g66lTh4v2PfIBwfBvCh3CEh0Ks3nyaj
        uslMFQR+ZUDlQ9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 462C113434;
        Thu,  4 Aug 2022 15:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ZMpEOTp62KcGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 15:46:44 +0000
Date:   Thu, 4 Aug 2022 17:41:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: use btrfs_find_inode in btrfs_prune_dentries
Message-ID: <20220804154141.GU13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220721135006.3345302-1-nborisov@suse.com>
 <20220721135006.3345302-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721135006.3345302-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 04:50:05PM +0300, Nikolay Borisov wrote:
> Now that we have a standalone function which encapsulates the logic of
> searching the root's ino rb tree use that. It results in massive
> simplification of the code.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode.c | 47 +++++++++++++++++------------------------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c11169ba28b2..06724925a3d3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4635,44 +4635,27 @@ struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
>  static void btrfs_prune_dentries(struct btrfs_root *root)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	struct rb_node *node;
> -	struct rb_node *prev;
> -	struct btrfs_inode *entry;
> -	struct inode *inode;
> +	struct rb_node *node = NULL;
>  	u64 objectid = 0;
>  
>  	if (!BTRFS_FS_ERROR(fs_info))
>  		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
>  
>  	spin_lock(&root->inode_lock);
> -again:
> -	node = root->inode_tree.rb_node;
> -	prev = NULL;
> -	while (node) {
> -		prev = node;
> -		entry = rb_entry(node, struct btrfs_inode, rb_node);
> +	do {
> +		struct btrfs_inode *entry;
> +		struct inode *inode;
>  
> -		if (objectid < btrfs_ino(entry))
> -			node = node->rb_left;
> -		else if (objectid > btrfs_ino(entry))
> -			node = node->rb_right;
> -		else
> -			break;
> -	}
> -	if (!node) {
> -		while (prev) {
> -			entry = rb_entry(prev, struct btrfs_inode, rb_node);
> -			if (objectid <= btrfs_ino(entry)) {
> -				node = prev;
> +		if (!node) {
> +			node = btrfs_find_inode(root, objectid);
> +			if (!node)
>  				break;
> -			}
> -			prev = rb_next(prev);
>  		}
> -	}
> -	while (node) {
> +
>  		entry = rb_entry(node, struct btrfs_inode, rb_node);
>  		objectid = btrfs_ino(entry) + 1;
>  		inode = igrab(&entry->vfs_inode);
> +
>  		if (inode) {
>  			spin_unlock(&root->inode_lock);
>  			if (atomic_read(&inode->i_count) > 1)
> @@ -4684,14 +4667,18 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
>  			iput(inode);
>  			cond_resched();
>  			spin_lock(&root->inode_lock);
> -			goto again;
> +			node = NULL;

This sets node to NULL and continues, which sends it down to while
(node), which makes it effectively a break and it's not equivalent to
the original behaviour that jumps back to again: or "do {" , or I'm
missing something.

> +			continue;
>  		}
>  
> -		if (cond_resched_lock(&root->inode_lock))
> -			goto again;
> +		if (cond_resched_lock(&root->inode_lock)) {
> +			node = NULL;
> +			continue;
> +		}
>  
>  		node = rb_next(node);
> -	}
> +	} while(node);
> +
>  	spin_unlock(&root->inode_lock);
>  }
>  
> -- 
> 2.25.1
