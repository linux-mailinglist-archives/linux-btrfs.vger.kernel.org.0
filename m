Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9C21D581
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGMMIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:08:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgGMMIu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:08:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE46AB1CE;
        Mon, 13 Jul 2020 12:08:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18882DA809; Mon, 13 Jul 2020 14:08:27 +0200 (CEST)
Date:   Mon, 13 Jul 2020 14:08:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Robbie Ko <robbieko@synology.com>
Subject: Re: [PATCH] btrfs: prefetch chunk tree leaves at mount
Message-ID: <20200713120826.GH3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Robbie Ko <robbieko@synology.com>
References: <20200710131928.7187-1-dsterba@suse.com>
 <52b7c8df-9c9f-a9b4-0df7-abcb6442e7e1@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b7c8df-9c9f-a9b4-0df7-abcb6442e7e1@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 10, 2020 at 10:29:52AM -0400, Josef Bacik wrote:
> On 7/10/20 9:19 AM, David Sterba wrote:
> > The whole chunk tree is read at mount time so we can utilize readahead
> > to get the tree blocks to memory before we read the items. The idea is
> > from Robbie, but instead of updating search slot readahead, this patch
> > implements the chunk tree readahead manually from nodes on level 1.
> > 
> > We've decided to do specific readahead optimizations and then unify them
> > under a common API so we don't break everything by changing the search
> > slot readahead logic.
> 
> So this is just for now, and then will be replaced with a bigger rework of the 
> readahead logic?

Yes. Validating the readahead optimization just for the chunk tree is
easy and safe. Once we have the readahead logic updated, switching it
should be straightforward, I'm expecting one of the RA modes to be like
the one for the chunk tree.

> > Higher chunk trees grow on large filesystems (many terabytes), and
> > prefetching just level 1 seems to be sufficient. Provided example was
> > from a 200TiB filesystem with chunk tree level 2.
> > 
> > CC: Robbie Ko <robbieko@synology.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/volumes.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index c7a3d4d730a3..e19891243199 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -7013,6 +7013,19 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> >   	return ret;
> >   }
> >   
> > +void readahead_tree_node_children(struct extent_buffer *node)
> > +{
> > +	int i;
> > +	const int nr_items = btrfs_header_nritems(node);
> > +
> > +	for (i = 0; i < nr_items; i++) {
> > +		u64 start;
> > +
> > +		start = btrfs_node_blockptr(node, i);
> > +		readahead_tree_block(node->fs_info, start);
> > +	}
> > +}
> > +
> >   int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> >   {
> >   	struct btrfs_root *root = fs_info->chunk_root;
> > @@ -7023,6 +7036,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> >   	int ret;
> >   	int slot;
> >   	u64 total_dev = 0;
> > +	u64 last_ra_node = 0;
> >   
> >   	path = btrfs_alloc_path();
> >   	if (!path)
> > @@ -7048,6 +7062,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> >   	if (ret < 0)
> >   		goto error;
> >   	while (1) {
> > +		struct extent_buffer *node;
> > +
> >   		leaf = path->nodes[0];
> >   		slot = path->slots[0];
> >   		if (slot >= btrfs_header_nritems(leaf)) {
> > @@ -7058,6 +7074,13 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> >   				goto error;
> >   			break;
> >   		}
> > +		node = path->nodes[1];
> > +		if (node) {
> > +			if (last_ra_node != node->start) {
> > +				readahead_tree_node_children(node);
> > +				last_ra_node = node->start;
> > +			}
> > +		}
> 
> We're doing a read search, path->nodes[1] won't be read locked here, so this 
> isn't technically safe.  I realize that nobody else is going to be messing with 
> stuff here, so maybe just a comment.  Thanks,

Right, for the mount path we skip locking for some other structures too
so I guess as long as it's documented it's acceptable.
