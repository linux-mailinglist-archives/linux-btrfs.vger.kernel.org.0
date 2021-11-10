Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11A144C290
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhKJN5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 08:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhKJN5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 08:57:34 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007EAC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 05:54:46 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id az8so2523542qkb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZHp/+6BlPw7wsdSB9/Sq02ZO+SgI8O0/Y4Ghogg7FU=;
        b=SLT2MVuSTjskezy4QDXcuggKnlro+vdMetH17t9TDYghKOeUIvtQV48Tv2j52EoeDh
         /9EmI0pFz7h+P+PAj5OClQT2pua7AlUt6sLKqIhZvXFOjAa208xN/256LHxshQXASLFP
         CdEf3/0D3HzaxCl+lYlFQHnhvyFVzF8ZnxZF+wLjqSs/MWdP92hHMFGLgk1FnceqznWB
         8DFPQjsSaO48yPV8ClFFQYGhC6nLADetYG7ZVRqX5VrGEs1VyYaTtFssqwO0FZDwpEJl
         8am5lkmnVhK9dLisYu57WcrKSBjfOy3uK7CvyuvXFS/3xBWIZ7Ovmuf0v8dRtzZG4qf4
         uzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZHp/+6BlPw7wsdSB9/Sq02ZO+SgI8O0/Y4Ghogg7FU=;
        b=cUk//p2D2c1PPC1CIpnOOnr7LGf+0SbE8h7/ECn8Bc83+/WHP/QHxFogqJ6Np4jTV3
         Y2dnkWz903s9H/V/q1dIn7WAdq0btcQr2aqp1Z/3SLVKTr5EEvG5qbXxLP42Ob/Uwijc
         DwCk+qtbCeb9GVxQC/WjBi0XdjG6u9A/Rd0tKYbDEH5OeBlEri/kH1qxdF206L3QUUw9
         vqfyG3IudB+Mj2p7HNUFbsxQGGUdPgGeuvzevOCKQE7DHhhhP8qnIk2AevxEC3c5qecE
         Kqgsj9ggslOQ2uG2QkALsO42VCeIcuGXN/RX2ZXIcB8qWOYGi1FIf/4lyfiKCqKvSjo/
         cmzg==
X-Gm-Message-State: AOAM532CBMxPhZXYKa3Di/KiJWoiH79sv1GUlh5qBmMaSrcEoFTT5S2k
        PwrVe1vMIMaTf2ujO9Aq77qJag==
X-Google-Smtp-Source: ABdhPJyzmxRAtukMZR4+yU6K5HRsyFQqOIBFSk5t7icaY1RVwdWt39anpWX77JC8SiZ3SzJBV2MuoA==
X-Received: by 2002:a05:620a:25cc:: with SMTP id y12mr12561648qko.322.1636552485852;
        Wed, 10 Nov 2021 05:54:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g15sm467651qtk.2.2021.11.10.05.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 05:54:45 -0800 (PST)
Date:   Wed, 10 Nov 2021 08:54:38 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Message-ID: <YYvPHv9dxZKFlraB@localhost.localdomain>
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
 <YYl8QTnLySc5hDRV@localhost.localdomain>
 <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
 <YYrK1QVmJhiG2vDc@localhost.localdomain>
 <e58230c4-1536-dca5-7e1c-1b6a4a0321bb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58230c4-1536-dca5-7e1c-1b6a4a0321bb@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/10 03:24, Josef Bacik wrote:
> > On Tue, Nov 09, 2021 at 09:14:06AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/11/9 03:36, Josef Bacik wrote:
> > > > On Sat, Nov 06, 2021 at 09:11:44AM +0800, Qu Wenruo wrote:
> > > > > 
> > > > > 
> > > > > On 2021/11/6 04:49, Josef Bacik wrote:
> > > > > > This code adds the on disk structures for the block group root, which
> > > > > > will hold the block group items for extent tree v2.
> > > > > > 
> > > > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > > > ---
> > > > > >     fs/btrfs/ctree.h                | 26 ++++++++++++++++-
> > > > > >     fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
> > > > > >     fs/btrfs/disk-io.h              |  2 ++
> > > > > >     fs/btrfs/print-tree.c           |  1 +
> > > > > >     include/trace/events/btrfs.h    |  1 +
> > > > > >     include/uapi/linux/btrfs_tree.h |  3 ++
> > > > > >     6 files changed, 74 insertions(+), 8 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > > > > index 8ec2f068a1c2..b57367141b95 100644
> > > > > > --- a/fs/btrfs/ctree.h
> > > > > > +++ b/fs/btrfs/ctree.h
> > > > > > @@ -271,8 +271,13 @@ struct btrfs_super_block {
> > > > > >     	/* the UUID written into btree blocks */
> > > > > >     	u8 metadata_uuid[BTRFS_FSID_SIZE];
> > > > > > 
> > > > > > +	__le64 block_group_root;
> > > > > > +	__le64 block_group_root_generation;
> > > > > > +	u8 block_group_root_level;
> > > > > > +
> > > > > 
> > > > > Is there any special reason that, block group root can't be put into
> > > > > root tree?
> > > > > 
> > > > 
> > > > Yes, I'm so glad you asked!
> > > > 
> > > > One of the planned changes with extent-tree-v2 is how we do relocation.  With no
> > > > longer being able to track metadata in the extent tree, relocation becomes much
> > > > more of a pain in the ass.
> > > 
> > > I'm even surprised that relocation can even be done without proper metadata
> > > tracking in the new extent tree(s).
> > > 
> > > > 
> > > > In addition, relocation currently has a pretty big problem, it can generate
> > > > unlimited delayed refs because it absolutely has to update all paths that point
> > > > to a relocated block in a single transaction.
> > > 
> > > Yep, that's also the biggest problem I attacked for the qgroup balance
> > > optimization.
> > > 
> > > > 
> > > > I'm fixing both of these problems with a new relocation thing, which will walk
> > > > through a block group, copy those extents to a new block group, and then update
> > > > a tree that maps the old logical address to the new logical address.
> > > 
> > > That sounds like the proposal from Johannes for zoned support of RAID56.
> > > An FTL-like layer.
> > > 
> > > But I'm still not sure how we could even get all the tree blocks in one
> > > block group in the first place, as there is no longer backref in the extent
> > > tree(s).
> > > 
> > > By iterating all tree blocks? That doesn't sound sane to me...
> > > 
> > 
> > No, iterating the free areas in the free space tree.  We no longer care about
> > the metadata itself, just the space that is utilized in the block group.  We
> > will mark the block group as read only, search through the free space tree for
> > that block group to find extents, copy them to new locations, insert a mapping
> > object for that block group to say "X range is now at Y".
> > 
> > As extent's are free'd their new respective ranges are freed.  Once a relocated
> > block groups ->used hits 0 its mapping items are deleted.
> > 
> > > > 
> > > > Because of this we could end up with blocks in the tree root that need to be
> > > > remapped from a relocated block group into a new block group.  Thus we need to
> > > > be able to know what that mapping is before we go read the tree root.  This
> > > > means we have to store the block group root (and the new mapping root I'll
> > > > introduce later) in the super block.
> > > 
> > > Wouldn't the new mapping root becoming a new bottleneck then?
> > > 
> > > If we relocate the full fs, then the mapping root (block group root) would
> > > be no different than an old extent tree?
> > > 
> > > Especially the mapping is done in extent level, not chunk level, thus it can
> > > cause tons of mapping entries, really not that better than old extent tree
> > > then.
> > > 
> > 
> > Except the problem with the old extent tree is we are constantly modifying it.
> 
> I have another question related to this block group tree.
> 
> AFAIK your new extent-tree-v2 will greatly reduce the amount of extent
> items by:
> 
> - Skip all backref items for global trees
> 
> - Skip backref items for non-shared subvolumes
>   As they act just like global trees (until being snapshotted).
> 
> I'm wondering if above modification is enough to make extent tree so
> cold that we don't even need block group tree?
> 

We need it separate still because we need to get at it from the super block in
order to pre-load it so we can load the mapping tree in order to do the
logical->logical translation for the new relocation scheme.

Also the extent tree is still going to have data backrefs, so we'll still end up
with a huge spread.  Thanks,

Josef
