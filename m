Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506B449C92
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhKHTjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhKHTjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:39:20 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D9C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:36:36 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id b11so12627928qvm.7
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tjzvnZWQ+BuNgWYYkD5f9HnJwmOXcWBO6QVBExcRwUY=;
        b=5Ms6dbmCw7kuTHumpmprrRqIC1qvxMr3VSjCkhkrdjnPlWCKrTTuUdY1b8wxDbjOvp
         35QXLQEpnORSi8cd+ZMIoGqiXNg9CrvO2xRpufIgRCXFb5Oo2urTgg5sGpLKz1ODJEdx
         Y4BXd+uq+UDEhZfvNc9F1gjwu3iEJrtQJD973OVuEUlaBTU3cxQONJJcQAnp3x6AAW7c
         5vy5wsU64V/WLzYPagSyFTgb0dz01p7ecqieSGStOMWgnW3yu0EMJaSq6n3KSI5uWHr0
         eyCqNCKk0koujtLqpOmPuI9SdknAuG7/QnBGCcsiwaRxBj4waLGnrp57oquWBxt4hOy3
         +ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjzvnZWQ+BuNgWYYkD5f9HnJwmOXcWBO6QVBExcRwUY=;
        b=AHBpkxDveRLYfaREGng3DhGZBWJlwU19hfBOa25LsXCB/WiBVen2xYb2AFODEAnPpF
         oaFVZZ1KGLM5uCLdfBV5BiUJ55dm01KEULOZ0p40yIkzOfYKn42lqkJRtJyNdhVnvwIf
         Pg/kmDQjaBsAoWnL9+Dg9IVOoKLY+bZPrANbN/34BIYA1eqDwlYEoNJZalYyOeQXC9L3
         5DWGWL6ab1pywcnW6+EJJdkZqaYWLulTLyU4aqGS+Tfk2oVjRPQ0v4iCnZKZJFTjD+SV
         EIP7bPxymsaJuBbpj6MmlFEWASpM1qKdY0pJOuRUScO7edDceEjSHeyBLAOh6Nd/Xwvk
         timA==
X-Gm-Message-State: AOAM533mH5swQsKV9SqKV9QBAOUPgvjOHZuG1Qe0cPkU04GN5IpykW0A
        aORMkhrfVwAXSkCWtM7U+nvOnA==
X-Google-Smtp-Source: ABdhPJwiQmv4r1l4aLjh+vcVJHT3esUZWn0Oh/J0m5gEeSwqvjLpvOt6Kz2zX1xffRnQGSUC7RQjDg==
X-Received: by 2002:a05:6214:2a45:: with SMTP id jf5mr1611183qvb.50.1636400195165;
        Mon, 08 Nov 2021 11:36:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m16sm11341675qtx.46.2021.11.08.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:36:34 -0800 (PST)
Date:   Mon, 8 Nov 2021 14:36:33 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Message-ID: <YYl8QTnLySc5hDRV@localhost.localdomain>
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749db638-d703-fd30-4835-d539806197cb@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 06, 2021 at 09:11:44AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/6 04:49, Josef Bacik wrote:
> > This code adds the on disk structures for the block group root, which
> > will hold the block group items for extent tree v2.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/ctree.h                | 26 ++++++++++++++++-
> >   fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
> >   fs/btrfs/disk-io.h              |  2 ++
> >   fs/btrfs/print-tree.c           |  1 +
> >   include/trace/events/btrfs.h    |  1 +
> >   include/uapi/linux/btrfs_tree.h |  3 ++
> >   6 files changed, 74 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 8ec2f068a1c2..b57367141b95 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -271,8 +271,13 @@ struct btrfs_super_block {
> >   	/* the UUID written into btree blocks */
> >   	u8 metadata_uuid[BTRFS_FSID_SIZE];
> > 
> > +	__le64 block_group_root;
> > +	__le64 block_group_root_generation;
> > +	u8 block_group_root_level;
> > +
> 
> Is there any special reason that, block group root can't be put into
> root tree?
> 

Yes, I'm so glad you asked!

One of the planned changes with extent-tree-v2 is how we do relocation.  With no
longer being able to track metadata in the extent tree, relocation becomes much
more of a pain in the ass.

In addition, relocation currently has a pretty big problem, it can generate
unlimited delayed refs because it absolutely has to update all paths that point
to a relocated block in a single transaction.

I'm fixing both of these problems with a new relocation thing, which will walk
through a block group, copy those extents to a new block group, and then update
a tree that maps the old logical address to the new logical address.

Because of this we could end up with blocks in the tree root that need to be
remapped from a relocated block group into a new block group.  Thus we need to
be able to know what that mapping is before we go read the tree root.  This
means we have to store the block group root (and the new mapping root I'll
introduce later) in the super block.

These two roots will behave like the chunk root, they'll have to be read first
in order to know where to find any remapped metadata blocks.  Because of that we
have to keep pointers to them in the super block instead of the tree root.

> If it's to reduce the unnecessary update on tree root, then I guess free
> space tree root should also have some space in super block.
> 
> As now free space tree(s) and extent tree(s) are having almost the same
> hotness, thus one having direct pointer in super block, while the other
> doesn't would not make much sense.

The extent tree and free space trees are both in the tree root, the only thing
that's in the superblock (currently) is the tree root and the chunk root.
Thanks,

Josef
