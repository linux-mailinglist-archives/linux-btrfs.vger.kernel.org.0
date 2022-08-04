Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC25589EB7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 17:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiHDPda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHDPd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 11:33:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C633E34
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 08:33:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C1514E622;
        Thu,  4 Aug 2022 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659627207;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npdeK6csKnhC+7sq7nDqP5ULP7MeJekMLUgoQ2wNwSM=;
        b=dOEnKruEypIjV5nKcuhE4IGjy0qkHxKGnC0h7ZlGgUTgz95eFACk2WLAJYDV70hrnTpJcm
        9CLlYfyLWjY4KuzEd1DKH4gD0BSWjzZsMtTqVBO5KFZglNewPK0nfClPSUaB0GWUuLHHR2
        JWrjMdHX3AkbEZoaUObP5+mPVZYqxuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659627207;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npdeK6csKnhC+7sq7nDqP5ULP7MeJekMLUgoQ2wNwSM=;
        b=jgBkoJItmpXmh9nzKSu1ARwTF6GIEdnmd0zuEESSJDlIllpTdgsuwmQf6HFZiveZYrSRz/
        WDua6Un06etQBtAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05CEF13A94;
        Thu,  4 Aug 2022 15:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jD97AMfm62IpFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 15:33:27 +0000
Date:   Thu, 4 Aug 2022 17:28:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: introduce btrfs_find_inode
Message-ID: <20220804152823.GT13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220721135006.3345302-1-nborisov@suse.com>
 <20220721135006.3345302-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721135006.3345302-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 04:50:04PM +0300, Nikolay Borisov wrote:
> This function holds common code for searching the root's inode rb tree.
> It will be used to reduce code duplication in future patches.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h |  1 +
>  fs/btrfs/inode.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0ae7f6530da1..fc0a0ab01761 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3311,6 +3311,7 @@ int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
>  int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  		       struct btrfs_inode *dir, struct btrfs_inode *inode,
>  		       const char *name, int name_len);
> +struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid);
>  int btrfs_add_link(struct btrfs_trans_handle *trans,
>  		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
>  		   const char *name, int name_len, int add_backref, u64 index);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5fc831a8eba1..c11169ba28b2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4587,6 +4587,50 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
>  	return ret;
>  }
>  
> +/**
> + * btrfs_find_inode - returns the rb_node pointing to the inode with an ino
> + * equal or larger than @objectid

Please use the simplified format that we have in btrfs.

> + *
> + * @root:      root which is going to be searched for an inode
> + * @objectid:  ino being searched for, if no exact match can be found the
> + *             function returns the first largest inode
> + *
> + * Returns the rb_node pointing to the specified inode or returns NULL if no
> + * match is found.
> + *
> + */
> +struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)

Const arguments for int types does not make sense. The root can be made
const, compile tested, no complaints.

> +{
> +	struct rb_node *node = root->inode_tree.rb_node;
> +	struct rb_node *prev = NULL;
> +	struct btrfs_inode *entry;
> +
> +	lockdep_assert_held(&root->inode_lock);
> +
> +	while (node) {
> +		prev = node;
> +		entry = rb_entry(node, struct btrfs_inode, rb_node);
> +
> +		if (objectid < btrfs_ino(entry))
> +			node = node->rb_left;
> +		else if (objectid > btrfs_ino(entry))
> +			node = node->rb_right;
> +		else
> +			break;
> +	}
> +
> +	if (!node) {
> +		while (prev) {
> +			entry = rb_entry(prev, struct btrfs_inode, rb_node);
> +			if (objectid <= btrfs_ino(entry))
> +				return prev;
> +			prev = rb_next(prev);
> +		}
> +	}
> +
> +	return node;
> +}
> +
>  /* Delete all dentries for inodes belonging to the root */
>  static void btrfs_prune_dentries(struct btrfs_root *root)
>  {
> -- 
> 2.25.1
