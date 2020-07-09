Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2352B219BDA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGIJN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 05:13:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:50968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgGIJN1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 05:13:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F343AE0E;
        Thu,  9 Jul 2020 09:13:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AA43DAB7F; Thu,  9 Jul 2020 11:13:06 +0200 (CEST)
Date:   Thu, 9 Jul 2020 11:13:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Robbie Ko <robbieko@synology.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
Message-ID: <20200709091305.GE28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Robbie Ko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
 <20200708211142.GD28832@twin.jikos.cz>
 <0358f6f6-da68-94a4-f3ed-718e5caeded4@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0358f6f6-da68-94a4-f3ed-718e5caeded4@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 10:38:42AM +0800, Robbie Ko wrote:
> David Sterba 於 2020/7/9 上午5:11 寫道:
> > On Tue, Jul 07, 2020 at 09:25:11PM +0200, David Sterba wrote:
> >> On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
> >> This skips readahead of all nodes above level 1, if you find a nicer way
> >> to readahead the whole tree I won't object, but for the first
> >> implementation the level 1 seems ok to me.
> > Patch below, I tried to create large system chunk by fallocate on a
> > sparse loop device, but got only 1 node on level 1 so the readahead
> > cannot show off.
> >
> > # btrfs fi df .
> > Data, single: total=59.83TiB, used=59.83TiB
> > System, single: total=36.00MiB, used=6.20MiB
> > Metadata, single: total=1.01GiB, used=91.78MiB
> > GlobalReserve, single: total=26.80MiB, used=0.00B
> >
> > There were 395 leaf nodes that got read ahead, time between the first
> > and last is 0.83s and the block group tree read took about 40 seconds.
> > This was in a VM with file-backed images, and the loop device was
> > constructed from these devices so it's spinning rust.
> >
> > I don't have results for non-prefetched mount to compare at the moment.
> >
> I think what you're doing is working.
> 
> But there are many similar problems that need to be improved.

Agreed, but this started from 'let's readahead chunk tree' and now we
drifted to fixing or perhaps making better use of readahead in several
other areas.

> 1. load_free_space_tree
> We need to read all BTRFS_FREE_SPACE_BITMAP_KEY and
> BTRFS_FREE_SPACE_EXTENT_KEY until the next FREE_SPACE_INFO_KEY.
> 
> 2. populate_free_space_tree
> We need to read all BTRFS_EXTENT_ITEM_KEY and BTRFS_METADATA_ITEM_KEY 
> until the end of the block group
> 
> 3. btrfs_real_readdir
> We need as many reads as possible (inode, BTRFS_DIR_INDEX_KEY).
> 
> 4. btrfs_clone
> We need as many reads as possible (inode, BTRFS_EXTENT_DATA_KEY).
> 
> 5. btrfs_verify_dev_extents
> We need to read all the BTRFS_DEV_EXTENT_KEYs.

Each case needs to be evaluated separately because the items live in
different trees and other item types could be scattered among the ones
we're interested in.

But the list gives an insight in what types of readahead we might need,
like full key range [from, to], or just all items of one key type.

> 6. caching_kthread (inode-map.c)
> We need all the BTRFS_INODE_ITEM_KEY of fs_tree to build the inode map
> 
> For the above cases.
> It is not possible to write a special readahead code for each case.
> We have to provide a new readaread framework
> Enable the caller to determine the scope of readaheads needed.
> The possible parameters of the readahead are as follows
> 1. reada_maximum_nr : Read a maximum of several leaves at a time.
> 2. reada_max_key : READA_FORWARD Early Suspension Condition
> 3. reada_min_key : READA_BACK Abort condition ahead of time.

Yeah something like that.

> We need to review all users of readahead to confirm that the The 
> behavior of readahead.
> For example, in scrub_enumerate_chunks readahead has the effect of Very 
> small,
> Because most of the time is spent on scrub_chunk,
> The processing of scrub_chunk for all DEV_EXTENT in a leaf is A long time.
> If the dev tree has been modified in the meantime, the previously 
> pre-reading leaf may be useless.

Yes that's another case where doing the readahead is useless.

So, now it's a question if we should start with the easy cases with
specific readahead and then unify them under a common API, or try to
figure out the API and then audit all us.

I'd be more in favor of the former as it allows to give us a baseline
where the readahead would be implemented optimally, the followup API
cleanup would need to keep the performance.

The latter is IMHO harder just because getting an API right on the first
try usually does not work.
