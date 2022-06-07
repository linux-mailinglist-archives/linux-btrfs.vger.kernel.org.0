Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36E453F9D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiFGJbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiFGJbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 05:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20B2EA15
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 02:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA88860C93
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C618AC385A5;
        Tue,  7 Jun 2022 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654594302;
        bh=pbcSEPo/Mx5aa1Gy7QwnWbgPPqLlxGjXak+Fh7AoFQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYHWpFwW9oq0ZaAy4TCKcEVmXJnQWLU8v5GBXbFDFwHt7KhNABulkFUgsRH1pFAg5
         u0b6LhBxY6RDltcUtvP18p1lw1ORPFtGv9/nMPT0p7B8ZyVBsLevF7ONxeuDJXYnPy
         BLGeBqdCAde3UKHCLsMPGhmD6LCvK8FxnE8UU1WlteG9OqWV9jrFNY+KbYWUMzOIOE
         dbWNNRVyp4j0ysogAWLfAjCxKhaM5Ibu9GcDEJjzAPnLekVh3Ca46LjP7xA+TRwGVy
         7gn8m5eRBl43HEa0bBnciP0G7yRvIAttYD0kEcJQfpPNFxrY6yD/8A84NR3/3mhNgl
         1dCBpbbne1+Jg==
Date:   Tue, 7 Jun 2022 10:31:39 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: add missing inode updates on each iteration
 when replacing extents
Message-ID: <20220607093139.GA3554947@falcondesktop>
References: <cover.1654508104.git.fdmanana@suse.com>
 <980e6be197825045a08ad6d463456bc73521e4d4.1654508104.git.fdmanana@suse.com>
 <Yp57qB5gjZ1wpnja@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp57qB5gjZ1wpnja@zen>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 06, 2022 at 03:11:52PM -0700, Boris Burkov wrote:
> On Mon, Jun 06, 2022 at 10:41:18AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > When replacing file extents, called during fallocate, hole punching,
> > clone and deduplication, we may not be able to replace/drop all the
> > target file extent items with a single transaction handle. We may get
> > -ENOSPC while doing it, in which case we release the transaction handle,
> > balance the dirty pages of the btree inode, flush delayed items and get
> > a new transaction handle to operate on what's left of the target range.
> > 
> > By dropping and replacing file extent items we have effectively modified
> 
> How can you be sure that you definitely modified it? Is it possible for
> btrfs_drop_extents to return ENOSPC without dropping extents?

If btrfs_drop_extents() fails with -ENOSPC, it means it tried to modify
more than one leaf. Since we reserved enough space for modifying one leaf,
it can only fail if it tries to modify more leaves, and if it tries to do
so, it means it dropped or trimmed file extent items from a leaf already.

> 
> > the inode, so we should bump its iversion and update its mtime/ctime
> > before we update the inode item. This is because if the transaction
> > we used for partially modifying the inode gets committed by someone after
> > we release it and before we finish the rest of the range, a power failure
> > happens, then after mounting the filesystem our inode has an outdated
> > iversion and mtime/ctime, corresponding to the values it had before we
> > changed it.
> > 
> > So add the missing iversion and mtime/ctime updates.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ctree.h   |  2 ++
> >  fs/btrfs/file.c    | 19 +++++++++++++++++++
> >  fs/btrfs/inode.c   |  1 +
> >  fs/btrfs/reflink.c |  1 +
> >  4 files changed, 23 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 55dee1564e90..737cd59d16b6 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1330,6 +1330,8 @@ struct btrfs_replace_extent_info {
> >  	 * existing extent into a file range.
> >  	 */
> >  	bool is_new_extent;
> > +	/* Indicate if we should update the inode's mtime and ctime. */
> > +	bool update_times;
> >  	/* Meaningful only if is_new_extent is true. */
> >  	int qgroup_reserved;
> >  	/*
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 1fd827b99c1b..29de433b7804 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2803,6 +2803,25 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
> >  			extent_info->file_offset += replace_len;
> >  		}
> >  
> > +		/*
> > +		 * We are releasing our handle on the transaction, balance the
> > +		 * dirty pages of the btree inode and flush delayed items, and
> > +		 * then get a new transaction handle, which may now point to a
> > +		 * new transaction in case someone else may have committed the
> > +		 * transaction we used to replace/drop file extent items. So
> > +		 * bump the inode's iversion and update mtime and ctime except
> > +		 * if we are called from a dedupe context. This is because a
> > +		 * power failure/crash may happen after the transaction is
> > +		 * committed and before we finish replacing/dropping all the
> > +		 * file extent items we need.
> > +		 */
> > +		inode_inc_iversion(&inode->vfs_inode);
> > +
> > +		if (!extent_info || extent_info->update_times) {
> > +			inode->vfs_inode.i_mtime = current_time(&inode->vfs_inode);
> > +			inode->vfs_inode.i_ctime = inode->vfs_inode.i_mtime;
> > +		}
> > +
> >  		ret = btrfs_update_inode(trans, root, inode);
> >  		if (ret)
> >  			break;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 3ede3e873c2a..ab4ebcb7878c 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -9907,6 +9907,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
> >  	extent_info.file_offset = file_offset;
> >  	extent_info.extent_buf = (char *)&stack_fi;
> >  	extent_info.is_new_extent = true;
> > +	extent_info.update_times = true;
> >  	extent_info.qgroup_reserved = qgroup_released;
> >  	extent_info.insertions = 0;
> >  
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index 7e3b0aa318c1..977e0d218d79 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -497,6 +497,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
> >  			clone_info.file_offset = new_key.offset;
> >  			clone_info.extent_buf = buf;
> >  			clone_info.is_new_extent = false;
> > +			clone_info.update_times = !no_time_update;
> >  			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
> >  					drop_start, new_key.offset + datal - 1,
> >  					&clone_info, &trans);
> > -- 
> > 2.35.1
> > 
