Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994A2191F8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGHVMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 17:12:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgGHVMF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 17:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7D5AAD33;
        Wed,  8 Jul 2020 21:12:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C605DA818; Wed,  8 Jul 2020 23:11:42 +0200 (CEST)
Date:   Wed, 8 Jul 2020 23:11:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
Message-ID: <20200708211142.GD28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707192511.GE16141@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 09:25:11PM +0200, David Sterba wrote:
> On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
> > From: Robbie Ko <robbieko@synology.com>
> > 
> > When mounting, we always need to read the whole chunk tree,
> > when there are too many chunk items, most of the time is
> > spent on btrfs_read_chunk_tree, because we only read one
> > leaf at a time.
> > 
> > It is unreasonable to limit the readahead mechanism to a
> > range of 64k, so we have removed that limit.
> > 
> > In addition we added reada_maximum_size to customize the
> > size of the pre-reader, The default is 64k to maintain the
> > original behavior.
> > 
> > So we fix this by used readahead mechanism, and set readahead
> > max size to ULLONG_MAX which reads all the leaves after the
> > key in the node when reading a level 1 node.
> 
> The readahead of chunk tree is a special case as we know we will need
> the whole tree, in all other cases the search readahead needs is
> supposed to read only one leaf.
> 
> For that reason I don't want to touch the current path readahead logic
> at all and do the chunk tree readahead in one go instead of the
> per-search.
> 
> Also I don't like to see size increase of btrfs_path just to use the
> custom once.
> 
> The idea of the whole tree readahead is to do something like:
> 
> - find first item
> - start readahead on all leaves from its level 1 node parent
>   (readahead_tree_block)
> - when the level 1 parent changes during iterating items, start the
>   readahead again
> 
> This skips readahead of all nodes above level 1, if you find a nicer way
> to readahead the whole tree I won't object, but for the first
> implementation the level 1 seems ok to me.

Patch below, I tried to create large system chunk by fallocate on a
sparse loop device, but got only 1 node on level 1 so the readahead
cannot show off.

# btrfs fi df .
Data, single: total=59.83TiB, used=59.83TiB
System, single: total=36.00MiB, used=6.20MiB
Metadata, single: total=1.01GiB, used=91.78MiB
GlobalReserve, single: total=26.80MiB, used=0.00B

There were 395 leaf nodes that got read ahead, time between the first
and last is 0.83s and the block group tree read took about 40 seconds.
This was in a VM with file-backed images, and the loop device was
constructed from these devices so it's spinning rust.

I don't have results for non-prefetched mount to compare at the moment.


----
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..e19891243199 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7013,6 +7013,19 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+void readahead_tree_node_children(struct extent_buffer *node)
+{
+	int i;
+	const int nr_items = btrfs_header_nritems(node);
+
+	for (i = 0; i < nr_items; i++) {
+		u64 start;
+
+		start = btrfs_node_blockptr(node, i);
+		readahead_tree_block(node->fs_info, start);
+	}
+}
+
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -7023,6 +7036,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	int ret;
 	int slot;
 	u64 total_dev = 0;
+	u64 last_ra_node = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -7048,6 +7062,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	if (ret < 0)
 		goto error;
 	while (1) {
+		struct extent_buffer *node;
+
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		if (slot >= btrfs_header_nritems(leaf)) {
@@ -7058,6 +7074,13 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 				goto error;
 			break;
 		}
+		node = path->nodes[1];
+		if (node) {
+			if (last_ra_node != node->start) {
+				readahead_tree_node_children(node);
+				last_ra_node = node->start;
+			}
+		}
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 		if (found_key.type == BTRFS_DEV_ITEM_KEY) {
 			struct btrfs_dev_item *dev_item;
