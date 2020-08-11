Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF124171B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 09:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHKHXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 03:23:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgHKHXh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 03:23:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0418B745;
        Tue, 11 Aug 2020 07:23:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CCFFDAFD3; Tue, 11 Aug 2020 09:22:34 +0200 (CEST)
Date:   Tue, 11 Aug 2020 09:22:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
Message-ID: <20200811072234.GK2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200731140807.GM3703@twin.jikos.cz>
 <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 01, 2020 at 07:35:26AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/31 下午10:08, David Sterba wrote:
> > On Fri, Jul 31, 2020 at 07:29:11PM +0800, Qu Wenruo wrote:
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
> >>  	}
> >>  
> >>  	mutex_lock(&fs_info->chunk_mutex);
> >> +	/*
> >> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
> >> +	 * current device boundary.
> >> +	 * This shouldn't fail, as alloc_state should only utilize those two
> >> +	 * bits, thus we shouldn't alloc new memory for clearing the status.
> > 
> > If this fails or not depends on implementation details of
> > clear_extent_bits and this comment will get out of sync eventually, so I
> > don't think it should be that specific.
> > 
> > If the new_size is somewhere in the middle of an existing state, it'll
> > need to be split anyway, no?
> 
> Nope. Because in alloc_state we only have two bits utilized,
> CHUNK_TRIMMED and CHUNK_ALLOCATED.
> 
> Thus what we're doing is to clear all utilized bits.

Which is true for now, adding a new bit would change that.

> > 
> > alloc_state |-----+++++|
> > clear             |------------------------- ... (u64)-1|
> > 
> > So we'd need to keep the state "-" and unset bits only from "+", and
> > this will require a split.
> 
> In this case, we would only reduce the the size of the existing status,
> or just remove it completely.

I haven't found the 'only reduce the size' in the code, thre's always
some split. The case in __clear_extent_bit is

 773          *     | ---- desired range ---- |
 774          *  | state | or
 775          *  | ------------- state -------------- |

the case on line 774 and followed by split_state.

> > But I still have doubts about just clearing the range, why are there any
> > device->alloc_state entries at all after device is shrunk?
> 
> Because the alloc_state is mostly only utilized by trim facility, thus
> existing functions won't bother clearing/setting it.
> 
> In this particular case, previous fstrim run would set the CHUNK_TRIMMED
> bit for all unallocated range (except the super reserve).
> Then shrink doesn't clear the exceed range, and cause problem.

So the unallocated range on a device is also represented in the
alloc_state tree?

> Thus clearing the bit in btrfs_shrink_device() makes sense.
> 
> > Using
> > clear_extent_bits here is not wrong if we look at the end result of
> > clearing the range, but otherwise it leaves some state information
> > and allocated memory behind.
> > 
> Not that complex case, just plain not fully considered corner case.

So what to do about that? I expect the alloc_state tree to represent the
device accurately and don't want to leave known issues unfixed.
