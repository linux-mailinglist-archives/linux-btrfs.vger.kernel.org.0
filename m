Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19114D99DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347777AbiCOLDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347779AbiCOLDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:03:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5C45792
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 04:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A02BACE19E1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E93AC340E8;
        Tue, 15 Mar 2022 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647342140;
        bh=pxw11BVddp/7prftStvskAzg7GZq4T7xR1GbUYMfn5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFP9M//lh0/2DrPhxIXcCrGk8Pk9nWZImjdpc0pOCVFm9uhDft7C3BnVpG61dpzhR
         1OD23u0/5mCoKMrQX/XErkdlIZyxqEdLXrebBRzS3fCpCMeNvO6a3S4mIL6uZzyYjf
         gJ5OzKQGW9REHRLtN0oj/GlRU5MaHbJbplkWqrOb2NZjTVNUR5YBH/mVtx2J2ubZk5
         9tqa5LwA5PHvB7mQuJIn1wUMyTc/L7z4/zKol7K0lHt+JACmbtM27plud+4rkBv+H1
         aYqGa7nUwK6m53bYaSUruO+UpqBjaIi24I0hp5VwQVWBaPLt6q8sskkgTN3baMLtvN
         TodI3huhgRZSw==
Date:   Tue, 15 Mar 2022 11:02:17 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <YjByOZr5Lmw2/jw1@debian9.Home>
References: <20220310192245.GA8165@magnolia>
 <YitAiiQ+cpbGZ2K/@debian9.Home>
 <20220311235110.GB8241@magnolia>
 <Yi8ky7zU4L6Kk+eo@debian9.Home>
 <20220314174055.GE8241@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314174055.GE8241@magnolia>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 10:40:55AM -0700, Darrick J. Wong wrote:
> On Mon, Mar 14, 2022 at 11:19:39AM +0000, Filipe Manana wrote:
> > On Fri, Mar 11, 2022 at 03:51:10PM -0800, Darrick J. Wong wrote:
> > > On Fri, Mar 11, 2022 at 12:28:58PM +0000, Filipe Manana wrote:
> > > > On Thu, Mar 10, 2022 at 11:22:45AM -0800, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > Since the initial introduction of (posix) fallocate back at the turn of
> > > > > the century, it has been possible to use this syscall to change the
> > > > > user-visible contents of files.  This can happen by extending the file
> > > > > size during a preallocation, or through any of the newer modes (punch,
> > > > > zero range).  Because the call can be used to change file contents, we
> > > > > should treat it like we do any other modification to a file -- update
> > > > > the mtime, and drop set[ug]id privileges/capabilities.
> > > > > 
> > > > > The VFS function file_modified() does all this for us if pass it a
> > > > > locked inode, so let's make fallocate drop permissions correctly.
> > > > > 
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > > Note: I plan to add fstests to test this behavior, but after the
> > > > > generic/673 mess, I'm holding back on them until I can fix the three
> > > > > major filesystems and clean up the xfs setattr_copy code.
> > > > > 
> > > > > https://lore.kernel.org/linux-ext4/20220310174410.GB8172@magnolia/T/#u
> > > > > ---
> > > > >  fs/btrfs/file.c |   23 +++++++++++++++++++----
> > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > > > index a0179cc62913..79e61c88b9e7 100644
> > > > > --- a/fs/btrfs/file.c
> > > > > +++ b/fs/btrfs/file.c
> > > > > @@ -2918,8 +2918,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > -static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > > > > +static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
> > > > >  {
> > > > > +	struct inode *inode = file_inode(file);
> > > > >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > > > >  	struct btrfs_root *root = BTRFS_I(inode)->root;
> > > > >  	struct extent_state *cached_state = NULL;
> > > > > @@ -2951,6 +2952,10 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > > > >  		goto out_only_mutex;
> > > > >  	}
> > > > >  
> > > > > +	ret = file_modified(file);
> > > > > +	if (ret)
> > > > > +		goto out_only_mutex;
> > > > > +
> > > > >  	lockstart = round_up(offset, btrfs_inode_sectorsize(BTRFS_I(inode)));
> > > > >  	lockend = round_down(offset + len,
> > > > >  			     btrfs_inode_sectorsize(BTRFS_I(inode))) - 1;
> > > > > @@ -3177,11 +3182,12 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > -static int btrfs_zero_range(struct inode *inode,
> > > > > +static int btrfs_zero_range(struct file *file,
> > > > >  			    loff_t offset,
> > > > >  			    loff_t len,
> > > > >  			    const int mode)
> > > > >  {
> > > > > +	struct inode *inode = file_inode(file);
> > > > >  	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
> > > > >  	struct extent_map *em;
> > > > >  	struct extent_changeset *data_reserved = NULL;
> > > > > @@ -3202,6 +3208,12 @@ static int btrfs_zero_range(struct inode *inode,
> > > > >  		goto out;
> > > > >  	}
> > > > >  
> > > > > +	ret = file_modified(file);
> > > > > +	if (ret) {
> > > > > +		free_extent_map(em);
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > 
> > > > Could be done before getting the extent map, to make the code a bit shorter, or
> > > > see the comment below.
> > > 
> > > The trouble is, if getting the extent map fails, we didn't change the
> > > file, so there's no reason to bump the timestamps and whatnot...
> > 
> > Right, I figured you had that sort of intention.
> > 
> > However after the call to file_modified(), we may actually have not change the
> > file at all, like when trying to zero a range that is already fully covered by a
> > preallocated extent.
> 
> <nod>  At least in XFSland, there's no good way to check for a
> pre-existing prealloc extent without holding the ILOCK, which makes
> things complicated as I'll explain below. :)
> 
> > > 
> > > > 
> > > > >  	/*
> > > > >  	 * Avoid hole punching and extent allocation for some cases. More cases
> > > > >  	 * could be considered, but these are unlikely common and we keep things
> > > > > @@ -3391,7 +3403,7 @@ static long btrfs_fallocate(struct file *file, int mode,
> > > > >  		return -EOPNOTSUPP;
> > > > >  
> > > > >  	if (mode & FALLOC_FL_PUNCH_HOLE)
> > > > > -		return btrfs_punch_hole(inode, offset, len);
> > > > > +		return btrfs_punch_hole(file, offset, len);
> > > > >  
> > > > >  	/*
> > > > >  	 * Only trigger disk allocation, don't trigger qgroup reserve
> > > > > @@ -3446,7 +3458,7 @@ static long btrfs_fallocate(struct file *file, int mode,
> > > > >  		goto out;
> > > > >  
> > > > >  	if (mode & FALLOC_FL_ZERO_RANGE) {
> > > > > -		ret = btrfs_zero_range(inode, offset, len, mode);
> > > > > +		ret = btrfs_zero_range(file, offset, len, mode);
> > > > >  		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
> > > > >  		return ret;
> > > > >  	}
> > > > > @@ -3528,6 +3540,9 @@ static long btrfs_fallocate(struct file *file, int mode,
> > > > >  		cur_offset = last_byte;
> > > > >  	}
> > > > >  
> > > > > +	if (!ret)
> > > > > +		ret = file_modified(file);
> > > > 
> > > > If call file_modified() before the if that checks for the zero range case,
> > > > then we avoid having to call file_modified() at btrfs_zero_range() too,
> > > > and get the behaviour for both plain fallocate and zero range.
> > > 
> > > ...and the reason I put it here is to make sure the ordered IO finishes
> > > ok and that we pass the quota limit checks before we start modifying
> > > things.
> > 
> > Ok, but before that point we may already have modified the file, through
> > a call to either btrfs_cont_expand() or btrfs_truncate_block() above, to
> > zero out part of the content of a page.
> 
> Ahh, ok.  My goal was to eliminate the places where we don't call
> file_modified, even if that comes at the cost of occasionally doing it
> when it wasn't strictly necessary.
> 
> > So if we did that, and we got an error when waiting for ordered extents
> > or from the qgroup reservation, we end up leaving fallocate without
> > calling file_modified(), despite having modified the file.
> > 
> > > 
> > > That said -- you all know btrfs far better than I do, so if you'd rather
> > > I put these calls further up (probably right after the inode_newsize_ok
> > > check?) then I'm happy to do that. :)
> > 
> > Technically I suppose we should only call file_modified() if we actually
> > change anything in the file, but as it is, we are calling it even when we
> > don't end up modifying it or in some cases not calling it when we modify
> > it.
> 
> Yep.
> 
> > How does xfs behaves in this respect? Does it call file_modified() only
> > if something in the file actually changed?
> 
> file_modified calls back into the filesystem to run transactions to
> update metadata, which means that XFS can't call it if it's already
> gotten a transaction and an inode ILOCK.  Unfortunately, we also can't
> check to see if the file actually requires modifications (zeroing
> contents, extending i_size) until we've taken the ILOCK.
> 
> If we really wanted to be strict about only stripping permissions if the
> file *actually* changed, we'd either have to re-design our setattr
> implementation to notice a running transaction and use it; or do a weird
> little dance where we lock the inode, check it, undo all that to call
> file_modified if we decide it's necessary, and then create a new
> transaction and re-lock it.  We'd also have to keep doing that until the
> file stabilizes, which seemed like a lot of work to handle something
> that's mostly a corner case, so XFS always calls file_modified after
> successfully flushing data to disk.

Ah, I see.

So that also explains why XFS fails for this test:

  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  umount $DEV &> /dev/null

  #mkfs.btrfs -f -b 1g $DEV
  #mkfs.ext4 -F -b 4096 $DEV $(((1024 * 1024 * 1024) / 4096))
  #mkfs.f2fs -f -w 4096 $DEV $(((1024 * 1024 * 1024) / 4096))
  mkfs.xfs -f -d size=1g $DEV
  mount $DEV $MNT

  # Create a file with a size of 600M and two holes, one at [200M, 201M[
  # and another at [401M, 402M[
  xfs_io -f -c "pwrite -S 0xab 0 200M" \
            -c "pwrite -S 0xcd 201M 200M" \
            -c "pwrite -S 0xef 402M 198M" \
            $MNT/foobar

  # Now call fallocate against the whole file range, see if it fails
  # with -ENOSPC or not - it shouldn't since we only need to allocate
  # 2M of data space.
  echo -e "\nCalling fallocate..."
  xfs_io -c "falloc 0 600M" $MNT/foobar

  umount $MNT

The fallocate fails with -ENOSPC, as it seems XFS tries to allocate 600M
of space. So it seems that happens before taking the ILOCK, but it can
only know for sure how much space it needs to allocate after taking that
lock - I assume the space allocation can't happen after taking the ILOCK,
due to some possible deadlock maybe?

That test currently fails on btrfs as well, but I had just sent a patch
to fix it:

https://lore.kernel.org/linux-btrfs/9a69626ef93741583ab7f6386f2b450f5d064080.1647340917.git.fdmanana@suse.com/

We actually had at least one report about systemd using fallocate against
a file range that has already allocated extents, so it could unnecessarily
fail with -ENOSPC if the fs free space is low (it's reported somewhere
in the middle of the thread in the Link tag of the patch).

Ext4 and f2fs pass the test.

I was turning the test case into a generic test for fstests, but then
noticied XFS failing. Is this something you would consider fixing for
XFS? Should I submit it as a generic test case, or as a btrfs specific
test case?

Thanks for the explanation and the patch.

> 
> At that point XFS haven't even gotten to checking quota yet, so
> technically that's also a gap where we could drop privs but then fail
> the fallocate with EDQUOT.
> 
> --D
> 
> > 
> > Thanks.
> > 
> > > 
> > > --D
> > > 
> > > > 
> > > > Otherwise, it looks good.
> > > > 
> > > > Thanks for doing this, I had it on my todo list since I noticed the generic/673
> > > > failure with reflinks and the suid/sgid bits.
> > > > 
> > > > > +
> > > > >  	/*
> > > > >  	 * If ret is still 0, means we're OK to fallocate.
> > > > >  	 * Or just cleanup the list and exit.
