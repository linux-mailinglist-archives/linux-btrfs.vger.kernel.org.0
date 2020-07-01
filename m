Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7D211027
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbgGAQFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 12:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGAQFf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 12:05:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7C4AACC3;
        Wed,  1 Jul 2020 16:05:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8CD1DA781; Wed,  1 Jul 2020 18:05:17 +0200 (CEST)
Date:   Wed, 1 Jul 2020 18:05:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     robbieko <robbieko@synology.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
Message-ID: <20200701160517.GE27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        robbieko <robbieko@synology.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200701092449.19545-1-robbieko@synology.com>
 <ddd19f85-7d55-38f2-3546-683a0229d51d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddd19f85-7d55-38f2-3546-683a0229d51d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 06:58:55PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/1 下午5:24, robbieko wrote:
> > From: Robbie Ko <robbieko@synology.com>
> > 
> > When mounting, we always need to read the whole chunk tree,
> > when there are too many chunk items, most of the time is
> > spent on btrfs_read_chunk_tree, because we only read one
> > leaf at a time.
> 
> Well, under most case it would be btrfs_read_block_groups(), unless all
> data chunks are very compact with just several large data extents.

I've checked chunk tree on some filesystems:

- 1T, 40% used, chunk tree size 80K, 1 node, the rest are leaves
- 1T, 93% used, chunk tree size 112K, 1 node, the rest are leaves

so yeah readahead of chunk tree is not the part where it takes long.
For many-terabytes filesystems it would be stil in range of megabytes
and the chunk tree is not scattered.

We could do the readahead of block group items, it could speed up some
things and maybe worth trying. We have the async readahead API, ie.
start readahead on a given key and forget about it. Either it will be in
cache in time we read it or the proper read will be first.

> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -353,7 +353,7 @@ struct btrfs_node {
> >   * The slots array records the index of the item or block pointer
> >   * used while walking the tree.
> >   */
> > -enum { READA_NONE, READA_BACK, READA_FORWARD };
> > +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
> >  struct btrfs_path {
> >  	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
> >  	int slots[BTRFS_MAX_LEVEL];
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 0d6e785bcb98..78fd65abff69 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> >  	path = btrfs_alloc_path();
> >  	if (!path)
> >  		return -ENOMEM;
> > +	path->reada = READA_FORWARD_FORCE;
> 
> Why not just use regular forward readahead?
> 
> Mind to share the reason here? Just to force reada for all tree leaves?

Maybe the current readahead is a good idea to do here anyway, we know
we'll need to read the whole chunk tree anyway so it's not wasteful.
