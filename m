Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7944B326
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhKIT0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 14:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbhKIT0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 14:26:54 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D57C061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 11:24:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bl12so122064qkb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 11:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0s/82m1YP1Pxv+EIM+LlrnkxEl55fzl09EdmKQa7XJI=;
        b=O6BlA3FD+lRctMTrJdNAunU7pg8Lt1fo7ryS+b8U6w/a4aPRnJ3zLhdl17EwEE0HXK
         JB0dK9Tt6e6iUnatCNWT7Rf5jDLTfDcoMoeu1foobN1JgkBmZoXyEBojPTD+6fPeOKNq
         2cZQt0X9ho4hIEHolclIbSrGDC7FMTsQCMpkWv9HoRT+acb8fTE3re2nQZfdmZ0EaZRz
         /g5n4vSzb6F24DL1LAe/SODcfGALFYmxNKXa5ZYRZFQpFJgi85syYOt1zmwiIlNnGbus
         gjCjtlTGKI9l+yGUQ5x5wtdDULDNZGLphOrNUYfwu2hLIBCF4QjkcOcntsr4iRk7f2+v
         3DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0s/82m1YP1Pxv+EIM+LlrnkxEl55fzl09EdmKQa7XJI=;
        b=oTevxaj6EocfYF9mes2FfERLE93YaekUg0YvsVA87ldC9swrOb6I3QP7h5Ylpa28L9
         7INcXm+X2ausk4VnBMIQN8S9X5QGHZxCP4qYFma4q5nVVYI7E004+JwyPDbUghF3Vh8a
         KeERcMsQYpRpyocIhIV1/O+9rkuv5oU9Rq1Q5MEeNjqhl06Qg2CZBV/FPVblwrLUlbUo
         171GVFfQxxu2hNKPAbkpSrsGYAtoxYhOIRw90uERJZ4+24ZCUaONaeWB4dHgq9LZLkGS
         yegBxDBJHax+nwyB5b0on3J3cw3sM88LxEck6EcMU4pRlnwa2mZu8nSL/Uoaro8pfzci
         FRMg==
X-Gm-Message-State: AOAM530FZPqUqHvZYk9K85f6udC5eGJ/XaTNMPHLVcQ3lbYLUZH3GYjo
        k/WUTxNkZe7pUzsdYSu2/CyIrKozMnetMw==
X-Google-Smtp-Source: ABdhPJwRpM8Tqdvy1E5jxoKYSAZinaIp1I+lGuzBWR1W2NwC/G9Ftw9crTgyuTfpVHI9MQ0E7v2ccA==
X-Received: by 2002:a05:620a:400f:: with SMTP id h15mr4963292qko.226.1636485846987;
        Tue, 09 Nov 2021 11:24:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t20sm12663259qkp.68.2021.11.09.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 11:24:06 -0800 (PST)
Date:   Tue, 9 Nov 2021 14:24:05 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Message-ID: <YYrK1QVmJhiG2vDc@localhost.localdomain>
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
 <YYl8QTnLySc5hDRV@localhost.localdomain>
 <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 09, 2021 at 09:14:06AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/9 03:36, Josef Bacik wrote:
> > On Sat, Nov 06, 2021 at 09:11:44AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/11/6 04:49, Josef Bacik wrote:
> > > > This code adds the on disk structures for the block group root, which
> > > > will hold the block group items for extent tree v2.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > >    fs/btrfs/ctree.h                | 26 ++++++++++++++++-
> > > >    fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
> > > >    fs/btrfs/disk-io.h              |  2 ++
> > > >    fs/btrfs/print-tree.c           |  1 +
> > > >    include/trace/events/btrfs.h    |  1 +
> > > >    include/uapi/linux/btrfs_tree.h |  3 ++
> > > >    6 files changed, 74 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > > index 8ec2f068a1c2..b57367141b95 100644
> > > > --- a/fs/btrfs/ctree.h
> > > > +++ b/fs/btrfs/ctree.h
> > > > @@ -271,8 +271,13 @@ struct btrfs_super_block {
> > > >    	/* the UUID written into btree blocks */
> > > >    	u8 metadata_uuid[BTRFS_FSID_SIZE];
> > > > 
> > > > +	__le64 block_group_root;
> > > > +	__le64 block_group_root_generation;
> > > > +	u8 block_group_root_level;
> > > > +
> > > 
> > > Is there any special reason that, block group root can't be put into
> > > root tree?
> > > 
> > 
> > Yes, I'm so glad you asked!
> > 
> > One of the planned changes with extent-tree-v2 is how we do relocation.  With no
> > longer being able to track metadata in the extent tree, relocation becomes much
> > more of a pain in the ass.
> 
> I'm even surprised that relocation can even be done without proper metadata
> tracking in the new extent tree(s).
> 
> > 
> > In addition, relocation currently has a pretty big problem, it can generate
> > unlimited delayed refs because it absolutely has to update all paths that point
> > to a relocated block in a single transaction.
> 
> Yep, that's also the biggest problem I attacked for the qgroup balance
> optimization.
> 
> > 
> > I'm fixing both of these problems with a new relocation thing, which will walk
> > through a block group, copy those extents to a new block group, and then update
> > a tree that maps the old logical address to the new logical address.
> 
> That sounds like the proposal from Johannes for zoned support of RAID56.
> An FTL-like layer.
> 
> But I'm still not sure how we could even get all the tree blocks in one
> block group in the first place, as there is no longer backref in the extent
> tree(s).
> 
> By iterating all tree blocks? That doesn't sound sane to me...
> 

No, iterating the free areas in the free space tree.  We no longer care about
the metadata itself, just the space that is utilized in the block group.  We
will mark the block group as read only, search through the free space tree for
that block group to find extents, copy them to new locations, insert a mapping
object for that block group to say "X range is now at Y".

As extent's are free'd their new respective ranges are freed.  Once a relocated
block groups ->used hits 0 its mapping items are deleted.

> > 
> > Because of this we could end up with blocks in the tree root that need to be
> > remapped from a relocated block group into a new block group.  Thus we need to
> > be able to know what that mapping is before we go read the tree root.  This
> > means we have to store the block group root (and the new mapping root I'll
> > introduce later) in the super block.
> 
> Wouldn't the new mapping root becoming a new bottleneck then?
> 
> If we relocate the full fs, then the mapping root (block group root) would
> be no different than an old extent tree?
> 
> Especially the mapping is done in extent level, not chunk level, thus it can
> cause tons of mapping entries, really not that better than old extent tree
> then.
> 

Except the problem with the old extent tree is we are constantly modifying it.
The mapping's are never modified once they're created, unless we're remapping
and already remapped range.  Once the remapped extent is free'd it's new
location will be normal, and won't update anything in the mapping tree.

> > 
> > These two roots will behave like the chunk root, they'll have to be read first
> > in order to know where to find any remapped metadata blocks.  Because of that we
> > have to keep pointers to them in the super block instead of the tree root.
> 
> Got the reason now, but I'm not yet convinced the block group root mapping
> is the proper way to go....
> 
> And still not sure how can we find out all tree blocks in one block group
> without backref for each tree blocks...
> 

We won't, we'll find allocated ranges.  It's certainly less precise than the
backref tree, but waaaaaaaay faster, because we only care about the range that
is allocated and moving that range.

Also it gives us another neat ability, we can relocate parts of extents instead
of being required to move full extents.  Before we had to move the whole extent
because we have to modify the file extent items to point at exactly the same
range.

Here the translation happens at the logical level, so we can easily split up
large extents and simply split up any bio's across the new logical locations and
stitch it back together at the end.  Thanks,

Josef
