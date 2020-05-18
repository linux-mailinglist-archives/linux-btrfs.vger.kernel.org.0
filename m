Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17451D7CD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgERP31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 11:29:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:42530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERP31 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 11:29:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77859B20D;
        Mon, 18 May 2020 15:29:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04683DA7AD; Mon, 18 May 2020 17:28:31 +0200 (CEST)
Date:   Mon, 18 May 2020 17:28:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: fix lockdep warning chunk_mutex vs
 device_list_mutex
Message-ID: <20200518152831.GV18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
 <20200513194659.34493-1-anand.jain@oracle.com>
 <20200515174047.GN18421@twin.jikos.cz>
 <4fa7f041-5816-1d94-1148-780b10e705af@oracle.com>
 <d30c0e44-6425-fb7b-efe2-28db6f36cdea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d30c0e44-6425-fb7b-efe2-28db6f36cdea@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 07:07:21PM +0800, Anand Jain wrote:
> 
> 
> On 16/5/20 11:43 am, Anand Jain wrote:
> > On 16/5/20 1:40 am, David Sterba wrote:
> >> On Thu, May 14, 2020 at 03:46:59AM +0800, Anand Jain wrote:
> >>> A full list of tests just started.
> >>>
> >>>   fs/btrfs/volumes.c | 8 +++++---
> >>>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>> index 60ab41c12e50..ebc8565d0f73 100644
> >>> --- a/fs/btrfs/volumes.c
> >>> +++ b/fs/btrfs/volumes.c
> >>> @@ -984,7 +984,6 @@ static struct btrfs_fs_devices 
> >>> *clone_fs_devices(struct btrfs_fs_devices *orig)
> >>>       if (IS_ERR(fs_devices))
> >>>           return fs_devices;
> >>
> >> So now here's the device_list_mutex taken by a caller but inside
> >> clone_fs_devices there's
> >>
> >>     fs_devices = alloc_fs_devices(orig->fsid, NULL);
> >>
> >> just before this line and it does a GFP_KERNEL allocation.
> > 
> > Oh right the allocations. Its not just about the other locks
> > as I thought before.
> > 
> > There are two ways to fix.
> >    Use GFP_NOFS
> >     I am not yet sure if it not possible. There were some previous
> >     work on the GFP flags. I need to review them. or,
> >    Move the allocation outside the locks.
> > 
> >   Looking into both of these choices.
> > 
> 
> 
> Nack. On this patch.
> 
> In general GFP_KERNEL is preferred over GFP_NOFS. For example.
> 
> --------
> 6165572c btrfs: use GFP_KERNEL in btrfs_init_dev_replace_tgtdev
> cc8385b5 btrfs: preallocate radix tree node for readahead
> 78f2c9e6 btrfs: device add and remove: use GFP_KERNEL
> --------
> 
> And there are quite a lot of GFP_KERNEL allocation along the
> path leading to clone_fs_devices().

For that we have the scoped NOFS, using the
memalloc_nofs_save/memalloc_nofs_restore. So if this is set before/after
the device_list_mutex is taken when calling the cloning then it's safe
with any potential GFP_KERNEL allocations on the way.
