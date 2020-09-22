Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB82743E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIVOPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:15:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIVOPV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:15:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BFDAB15B;
        Tue, 22 Sep 2020 14:15:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3504DA6E9; Tue, 22 Sep 2020 16:14:04 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:14:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
Message-ID: <20200922141404.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-15-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915053532.63279-15-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 01:35:27PM +0800, Qu Wenruo wrote:
> Btree inode is pretty special compared to all other inode extent io
> tree, although it has a btrfs inode, it doesn't have the track_uptodate
> bit at all.
> 
> This means a lot of things like extent locking doesn't even need to be
> applied to btree io tree.
> 
> Since it's so special, adds a new owner value for it to make debuging a
> little easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c        | 2 +-
>  fs/btrfs/extent-io-tree.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1ba16951ccaa..82a841bd0702 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2126,7 +2126,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
>  
>  	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
>  	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
> -			    IO_TREE_INODE_IO, inode);
> +			    IO_TREE_BTREE_IO, inode);
>  	BTRFS_I(inode)->io_tree.track_uptodate = false;
>  	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
>  
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 219a09a2b734..21d128383bfd 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -40,6 +40,7 @@ struct io_failure_record;
>  enum {
>  	IO_TREE_FS_PINNED_EXTENTS,
>  	IO_TREE_FS_EXCLUDED_EXTENTS,
> +	IO_TREE_BTREE_IO,

I've renamed it to IO_TREE_BTREE_INODE_IO, and btw don't forget to check
if enums aren't exported to tracepoints. This is and needs to be added
there as well.

>  	IO_TREE_INODE_IO,
>  	IO_TREE_INODE_IO_FAILURE,
>  	IO_TREE_RELOC_BLOCKS,
> -- 
> 2.28.0
