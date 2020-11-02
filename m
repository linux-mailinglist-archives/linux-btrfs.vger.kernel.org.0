Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C482A2F67
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKBQMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 11:12:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:53532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgKBQMf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 11:12:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C221B23B;
        Mon,  2 Nov 2020 16:12:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0613EDA7D2; Mon,  2 Nov 2020 17:10:56 +0100 (CET)
Date:   Mon, 2 Nov 2020 17:10:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Message-ID: <20201102161056.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201102144906.3767963-1-nborisov@suse.com>
 <SN4PR0401MB359899B411E936800C19F9419B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359899B411E936800C19F9419B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 03:48:52PM +0000, Johannes Thumshirn wrote:
> On 02/11/2020 15:49, Nikolay Borisov wrote:
> > Here is another batch which  gets use closer to unified btrfs_inode vs inode
> > usage in functions.
> > 
> > Nikolay Borisov (14):
> >   btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode
> >   btrfs: Make insert_prealloc_file_extent take btrfs_inode
> >   btrfs: Make btrfs_truncate_inode_items take btrfs_inode
> >   btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric
> >   btrfs: Make btrfs_delayed_update_inode take btrfs_inode
> >   btrfs: Make btrfs_update_inode_item take btrfs_inode
> >   btrfs: Make btrfs_update_inode take btrfs_inode
> >   btrfs: Make maybe_insert_hole take btrfs_inode
> >   btrfs: Make find_first_non_hole take btrfs_inode
> >   btrfs: Make btrfs_insert_replace_extent take btrfs_inode
> >   btrfs: Make btrfs_truncate_block take btrfs_inode
> >   btrfs: Make btrfs_cont_expand take btrfs_inode
> >   btrfs: Make btrfs_drop_extents take btrfs_inode
> >   btrfs: Make btrfs_update_inode_fallback take btrfs_inode
> > 
> >  fs/btrfs/block-group.c      |   2 +-
> >  fs/btrfs/ctree.h            |  21 +--
> >  fs/btrfs/delayed-inode.c    |  13 +-
> >  fs/btrfs/delayed-inode.h    |   3 +-
> >  fs/btrfs/file-item.c        |  18 +--
> >  fs/btrfs/file.c             |  88 +++++++------
> >  fs/btrfs/free-space-cache.c |   8 +-
> >  fs/btrfs/inode-map.c        |   2 +-
> >  fs/btrfs/inode.c            | 249 ++++++++++++++++++------------------
> >  fs/btrfs/ioctl.c            |   6 +-
> >  fs/btrfs/reflink.c          |   9 +-
> >  fs/btrfs/transaction.c      |   3 +-
> >  fs/btrfs/tree-log.c         |  24 ++--
> >  fs/btrfs/xattr.c            |   4 +-
> >  14 files changed, 233 insertions(+), 217 deletions(-)
> > 
> > --
> > 2.25.1
> > 
> > 
> 
> 
> Code wise this looks good to me. FYI patches 11/14 and 12/14 don't 
> apply cleanly on today's misc-next (at least for me).

We're expecting conflicts, there are about 50+ patches in for-next where
it could collide but I'd like to see what's the scope so I could
better schedule the order.
