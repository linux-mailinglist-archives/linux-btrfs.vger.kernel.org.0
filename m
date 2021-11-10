Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12A44C29E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 14:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhKJOAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 09:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhKJOAL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 09:00:11 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D93C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 05:57:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id bk22so2509432qkb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gTdxUYOkQtWNQjoRSz+/W9BlbHSLEROigElnrCorwts=;
        b=Gsv0Si2MVM63jIioznWmvO0KTPBO0eg/y42KLMj/0hFkr+iIQmujHAWrLOsWcic89F
         +S4Dt99CO7HuchJqJq1jeueB9NTItOy62S1reO/QXSjdhtIHRPqmHc9Ja0LKXC5pW0Fm
         2CJN/TRc+vYBlzFDaYWqhioMHIIxKVzggD5hFe5HWxLxlX14s1KG1UZm29BquwoFfyXS
         g1+lM5WYzJkw0I9sudeMcl0luHVBWP7jWrjEMLiilcRWVaYpPr79Dd6lq2sXzs1zcapM
         xLrO+h+JLswonF9Vqh3WL7pZkOdcO71bHuMXAEPW2moGTN/aGsqZ2328URw/EFiHc/fj
         TYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gTdxUYOkQtWNQjoRSz+/W9BlbHSLEROigElnrCorwts=;
        b=iJyqShZT8/DrrQHqf9zZIYjY3LmImu9Q+lUcbDYqxePSNyTrKscF+YlTscuViaGmen
         3rvFsCG0f1JYIYqc0OoHFfiClTWFknSoWInR4FaipsXlAukO25XyxTKElcP8S0/hoXKl
         cle+4ckjDbNeAijAv1cNj2I8vj5opNlAbanzmQrmKbyUbLPQhVGgjf/33PGs+8HmT5Fo
         VRcYJBWNuNh8JY0djMYWfOXrtxfZ1wBlJg4fp+JaQgNZ6EBEsrotzw2bJyNQfjAxYciF
         LQ3qaPjx60ACC6e5/bcMgT0GPniTazvsV59CtXXS0zwNUlGHTfj52YLznEW8Pr8RmsiO
         THZQ==
X-Gm-Message-State: AOAM533bJVGvkaVUjFRDcqWaj+70x1LWjS4KHSs2W+y0jzq5VkrKTktk
        ZsJmIG9/oUjCoVYw3MhgWhsBfUysGYMsbA==
X-Google-Smtp-Source: ABdhPJxl6Kgw753bU52EH8TyZE6PAllPdN85qlFJNkHyk6ZqdU6V5MNnV2clwspDiP13nmcv4yo6Gg==
X-Received: by 2002:a37:a617:: with SMTP id p23mr9908145qke.466.1636552643053;
        Wed, 10 Nov 2021 05:57:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c8sm13955305qtb.29.2021.11.10.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 05:57:22 -0800 (PST)
Date:   Wed, 10 Nov 2021 08:57:21 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Message-ID: <YYvPwRhnrd+up0PT@localhost.localdomain>
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
 <YYl8QTnLySc5hDRV@localhost.localdomain>
 <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
 <YYrK1QVmJhiG2vDc@localhost.localdomain>
 <6563adc9-9606-1100-344a-53236ee3185a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6563adc9-9606-1100-344a-53236ee3185a@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 07:44:51AM +0800, Qu Wenruo wrote:
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
> 
> OK, this makes sense now.
> 
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
> > The mapping's are never modified once they're created, unless we're remapping
> > and already remapped range.  Once the remapped extent is free'd it's new
> > location will be normal, and won't update anything in the mapping tree.
> 
> Oh, so the block group tree would be an colder version of extent tree, that
> would be really much nicer.
> 
> But that also means, to determine if a tree block/data extent is really
> belonging to a chunk/bg, we need to search for the new tree to be sure.
> 
> Would there be something to do reverse search? Or it may be a problem for
> balance again.
> 

Reverse search will be fuzzier than it used to be.  Using the snapshot tree
we'll be able to figure out who *potentially* points at a block, but we'll have
to go check.  This is the other reason I'm redoing balance at the same time,
first it super sucks and needs to be better, but secondly because it simply
won't be practical to do backref lookups for metadata anymore.  Thanks,

Josef
