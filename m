Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995B226DC60
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgIQNDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 09:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgIQMv7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 08:51:59 -0400
X-Greylist: delayed 760 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:51:59 EDT
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E103ACB0;
        Thu, 17 Sep 2020 12:52:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29978DA7C7; Thu, 17 Sep 2020 14:50:32 +0200 (CEST)
Date:   Thu, 17 Sep 2020 14:50:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
Message-ID: <20200917125031.GS1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-15-wqu@suse.com>
 <20200916160612.GO1791@twin.jikos.cz>
 <9ea58668-b6e5-6471-01fe-d4bf8ae8b310@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ea58668-b6e5-6471-01fe-d4bf8ae8b310@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 08:02:05AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/17 上午12:06, David Sterba wrote:
> > On Tue, Sep 15, 2020 at 01:35:27PM +0800, Qu Wenruo wrote:
> >> Btree inode is pretty special compared to all other inode extent io
> >> tree, although it has a btrfs inode, it doesn't have the track_uptodate
> >> bit at all.
> >>
> >> This means a lot of things like extent locking doesn't even need to be
> >> applied to btree io tree.
> >>
> >> Since it's so special, adds a new owner value for it to make debuging a
> >> little easier.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/disk-io.c        | 2 +-
> >>  fs/btrfs/extent-io-tree.h | 1 +
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index 1ba16951ccaa..82a841bd0702 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -2126,7 +2126,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> >>  
> >>  	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
> >>  	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
> >> -			    IO_TREE_INODE_IO, inode);
> >> +			    IO_TREE_BTREE_IO, inode);
> > 
> > This looks like an independent patch, so it could be taken separately.
> > 
> Errr, why?
> 
> We added a new owner for btree inode io tree, and utilize that new owner
> in the same patch looks completely sane to me.
> 
> Or did I miss something?

The IO_TREE_* ids are only for debugging and IO_TREE_INODE_IO is
supposed to be used for data inodes. But the btree_inode has that too,
which does not seem to follow the purpose of the tree id, you fix that
in this patch and it applies to current code too.
