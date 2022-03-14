Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B674D8092
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 12:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiCNLU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbiCNLUz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 07:20:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59593A183
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 04:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFA7B80DB0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 11:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A65C340ED;
        Mon, 14 Mar 2022 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647256783;
        bh=tey1nuXi1enSpbjJl05uxRXDgcCRWhP8C/6ts4SFrYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRHp5ojpIlUSJ7Qa6pXL7NmkqHyb9byJYl54rApCTXijpj8oDmWKodscX+UJyRBsB
         ZYWZ6EQq4KzcE6mSA9+q73fPl7yoTlrRet/wylgUwr2qd4kPT59HWhnlu23QopJHYO
         RQ9xI2Nnia/Zu9BjfAlYa/ap7N7cQXRijHw2QyAdNGlXeIctTk5orScj+kLPGnY/DT
         Dsi7nL7cRxb5HgHfjNJiVQ7IP44PytKcaR9GP1xlljkADkPLHDaMOJbd2biObLsXbR
         INsh26fh1vgq9pZlMVh53ZDmCpIoNEOot303SDNGdvlHYuHzqTZd7xX8ee2ws+VAlv
         jVDsBG+c0rJ+w==
Date:   Mon, 14 Mar 2022 11:19:39 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <Yi8ky7zU4L6Kk+eo@debian9.Home>
References: <20220310192245.GA8165@magnolia>
 <YitAiiQ+cpbGZ2K/@debian9.Home>
 <20220311235110.GB8241@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311235110.GB8241@magnolia>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 03:51:10PM -0800, Darrick J. Wong wrote:
> On Fri, Mar 11, 2022 at 12:28:58PM +0000, Filipe Manana wrote:
> > On Thu, Mar 10, 2022 at 11:22:45AM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Since the initial introduction of (posix) fallocate back at the turn of
> > > the century, it has been possible to use this syscall to change the
> > > user-visible contents of files.  This can happen by extending the file
> > > size during a preallocation, or through any of the newer modes (punch,
> > > zero range).  Because the call can be used to change file contents, we
> > > should treat it like we do any other modification to a file -- update
> > > the mtime, and drop set[ug]id privileges/capabilities.
> > > 
> > > The VFS function file_modified() does all this for us if pass it a
> > > locked inode, so let's make fallocate drop permissions correctly.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > > Note: I plan to add fstests to test this behavior, but after the
> > > generic/673 mess, I'm holding back on them until I can fix the three
> > > major filesystems and clean up the xfs setattr_copy code.
> > > 
> > > https://lore.kernel.org/linux-ext4/20220310174410.GB8172@magnolia/T/#u
> > > ---
> > >  fs/btrfs/file.c |   23 +++++++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index a0179cc62913..79e61c88b9e7 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -2918,8 +2918,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
> > >  	return ret;
> > >  }
> > >  
> > > -static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > > +static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
> > >  {
> > > +	struct inode *inode = file_inode(file);
> > >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > >  	struct btrfs_root *root = BTRFS_I(inode)->root;
> > >  	struct extent_state *cached_state = NULL;
> > > @@ -2951,6 +2952,10 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > >  		goto out_only_mutex;
> > >  	}
> > >  
> > > +	ret = file_modified(file);
> > > +	if (ret)
> > > +		goto out_only_mutex;
> > > +
> > >  	lockstart = round_up(offset, btrfs_inode_sectorsize(BTRFS_I(inode)));
> > >  	lockend = round_down(offset + len,
> > >  			     btrfs_inode_sectorsize(BTRFS_I(inode))) - 1;
> > > @@ -3177,11 +3182,12 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
> > >  	return ret;
> > >  }
> > >  
> > > -static int btrfs_zero_range(struct inode *inode,
> > > +static int btrfs_zero_range(struct file *file,
> > >  			    loff_t offset,
> > >  			    loff_t len,
> > >  			    const int mode)
> > >  {
> > > +	struct inode *inode = file_inode(file);
> > >  	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
> > >  	struct extent_map *em;
> > >  	struct extent_changeset *data_reserved = NULL;
> > > @@ -3202,6 +3208,12 @@ static int btrfs_zero_range(struct inode *inode,
> > >  		goto out;
> > >  	}
> > >  
> > > +	ret = file_modified(file);
> > > +	if (ret) {
> > > +		free_extent_map(em);
> > > +		goto out;
> > > +	}
> > > +
> > 
> > Could be done before getting the extent map, to make the code a bit shorter, or
> > see the comment below.
> 
> The trouble is, if getting the extent map fails, we didn't change the
> file, so there's no reason to bump the timestamps and whatnot...

Right, I figured you had that sort of intention.

However after the call to file_modified(), we may actually have not change the
file at all, like when trying to zero a range that is already fully covered by a
preallocated extent.

> 
> > 
> > >  	/*
> > >  	 * Avoid hole punching and extent allocation for some cases. More cases
> > >  	 * could be considered, but these are unlikely common and we keep things
> > > @@ -3391,7 +3403,7 @@ static long btrfs_fallocate(struct file *file, int mode,
> > >  		return -EOPNOTSUPP;
> > >  
> > >  	if (mode & FALLOC_FL_PUNCH_HOLE)
> > > -		return btrfs_punch_hole(inode, offset, len);
> > > +		return btrfs_punch_hole(file, offset, len);
> > >  
> > >  	/*
> > >  	 * Only trigger disk allocation, don't trigger qgroup reserve
> > > @@ -3446,7 +3458,7 @@ static long btrfs_fallocate(struct file *file, int mode,
> > >  		goto out;
> > >  
> > >  	if (mode & FALLOC_FL_ZERO_RANGE) {
> > > -		ret = btrfs_zero_range(inode, offset, len, mode);
> > > +		ret = btrfs_zero_range(file, offset, len, mode);
> > >  		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
> > >  		return ret;
> > >  	}
> > > @@ -3528,6 +3540,9 @@ static long btrfs_fallocate(struct file *file, int mode,
> > >  		cur_offset = last_byte;
> > >  	}
> > >  
> > > +	if (!ret)
> > > +		ret = file_modified(file);
> > 
> > If call file_modified() before the if that checks for the zero range case,
> > then we avoid having to call file_modified() at btrfs_zero_range() too,
> > and get the behaviour for both plain fallocate and zero range.
> 
> ...and the reason I put it here is to make sure the ordered IO finishes
> ok and that we pass the quota limit checks before we start modifying
> things.

Ok, but before that point we may already have modified the file, through
a call to either btrfs_cont_expand() or btrfs_truncate_block() above, to
zero out part of the content of a page.

So if we did that, and we got an error when waiting for ordered extents
or from the qgroup reservation, we end up leaving fallocate without
calling file_modified(), despite having modified the file.

> 
> That said -- you all know btrfs far better than I do, so if you'd rather
> I put these calls further up (probably right after the inode_newsize_ok
> check?) then I'm happy to do that. :)

Technically I suppose we should only call file_modified() if we actually
change anything in the file, but as it is, we are calling it even when we
don't end up modifying it or in some cases not calling it when we modify
it.

How does xfs behaves in this respect? Does it call file_modified() only
if something in the file actually changed?

Thanks.

> 
> --D
> 
> > 
> > Otherwise, it looks good.
> > 
> > Thanks for doing this, I had it on my todo list since I noticed the generic/673
> > failure with reflinks and the suid/sgid bits.
> > 
> > > +
> > >  	/*
> > >  	 * If ret is still 0, means we're OK to fallocate.
> > >  	 * Or just cleanup the list and exit.
