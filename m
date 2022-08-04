Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F880589EEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiHDPw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPw2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 11:52:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC757261
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 08:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90F07B824B3
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 15:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4D0C433D7;
        Thu,  4 Aug 2022 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659628344;
        bh=BIpKGG+3coT5lIJy9aTCw7szwAP7WT6BlVRlSCMPbNA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cQHxd4ELHrEN0BMLqXN0Ao4NaPQ+ZBLSjbFHcaJn6yf2EqXUfvq9iqwbc4SBHNtk0
         tP9hi7afiJfiNkWx768SlUE3EPCjeKDKROqAhGJ878tmABlhHOPjH1JnTMlxvcbcAK
         Dq8g0LFKDF1CM5e+UC8FeBgk4UydKApvRSwi0hoJGy4s2j0Om+p9zCCPvhp0SUFqUI
         Fs3UdEWul0xM6tscy2XRzEAefQz4ZQesTm0ZMVX/BI77nBKpUdiUHK6GIENwyqYxVZ
         bcDN9pwNv5UkL6uIIBgTevL7PWeVJE18a8cmocoEbJVvB6wYN0sI0kzACr0KRgDWSy
         BhEvcmOd47DbA==
Date:   Thu, 4 Aug 2022 16:52:21 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: introduce btrfs_find_inode
Message-ID: <20220804155221.GA1840473@falcondesktop>
References: <20220721135006.3345302-1-nborisov@suse.com>
 <20220721135006.3345302-2-nborisov@suse.com>
 <20220804152823.GT13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804152823.GT13489@twin.jikos.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 04, 2022 at 05:28:24PM +0200, David Sterba wrote:
> On Thu, Jul 21, 2022 at 04:50:04PM +0300, Nikolay Borisov wrote:
> > This function holds common code for searching the root's inode rb tree.
> > It will be used to reduce code duplication in future patches.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/ctree.h |  1 +
> >  fs/btrfs/inode.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 0ae7f6530da1..fc0a0ab01761 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3311,6 +3311,7 @@ int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
> >  int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
> >  		       struct btrfs_inode *dir, struct btrfs_inode *inode,
> >  		       const char *name, int name_len);
> > +struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid);
> >  int btrfs_add_link(struct btrfs_trans_handle *trans,
> >  		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
> >  		   const char *name, int name_len, int add_backref, u64 index);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 5fc831a8eba1..c11169ba28b2 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4587,6 +4587,50 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
> >  	return ret;
> >  }
> >  
> > +/**
> > + * btrfs_find_inode - returns the rb_node pointing to the inode with an ino
> > + * equal or larger than @objectid
> 
> Please use the simplified format that we have in btrfs.
> 
> > + *
> > + * @root:      root which is going to be searched for an inode
> > + * @objectid:  ino being searched for, if no exact match can be found the
> > + *             function returns the first largest inode
> > + *
> > + * Returns the rb_node pointing to the specified inode or returns NULL if no
> > + * match is found.
> > + *
> > + */
> > +struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
> 
> Const arguments for int types does not make sense.

It makes sense to me, as much as declaring local variables as const, and I don't
recall you ever complain about local const variables before (I do it often, and
I'm not the only one).

Once I read the const part, I can tell for sure that nowhere in the function the
value of the argument is changed.

It happens often that large functions use an int argument as if it was a local
variable and change its value later on, which makes reading the code often a bit
more time consuming and often leads to mistakest too.


> The root can be made
> const, compile tested, no complaints.
> 
> > +{
> > +	struct rb_node *node = root->inode_tree.rb_node;
> > +	struct rb_node *prev = NULL;
> > +	struct btrfs_inode *entry;
> > +
> > +	lockdep_assert_held(&root->inode_lock);
> > +
> > +	while (node) {
> > +		prev = node;
> > +		entry = rb_entry(node, struct btrfs_inode, rb_node);
> > +
> > +		if (objectid < btrfs_ino(entry))
> > +			node = node->rb_left;
> > +		else if (objectid > btrfs_ino(entry))
> > +			node = node->rb_right;
> > +		else
> > +			break;
> > +	}
> > +
> > +	if (!node) {
> > +		while (prev) {
> > +			entry = rb_entry(prev, struct btrfs_inode, rb_node);
> > +			if (objectid <= btrfs_ino(entry))
> > +				return prev;
> > +			prev = rb_next(prev);
> > +		}
> > +	}
> > +
> > +	return node;
> > +}
> > +
> >  /* Delete all dentries for inodes belonging to the root */
> >  static void btrfs_prune_dentries(struct btrfs_root *root)
> >  {
> > -- 
> > 2.25.1
