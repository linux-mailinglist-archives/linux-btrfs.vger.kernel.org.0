Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCEE355C13
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhDFTPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 15:15:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhDFTPg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 15:15:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66F35B474;
        Tue,  6 Apr 2021 19:15:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CCF6DA732; Tue,  6 Apr 2021 21:13:15 +0200 (CEST)
Date:   Tue, 6 Apr 2021 21:13:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210406191315.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210403110853.GD7604@twin.jikos.cz>
 <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 05, 2021 at 02:14:34PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/4/3 下午7:08, David Sterba wrote:
> > On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
> >> This patchset can be fetched from the following github repo, along with
> >> the full subpage RW support:
> >> https://github.com/adam900710/linux/tree/subpage
> >>
> >> This patchset is for metadata read write support.
> >
> >> Qu Wenruo (13):
> >>    btrfs: add sysfs interface for supported sectorsize
> >>    btrfs: use min() to replace open-code in btrfs_invalidatepage()
> >>    btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
> >>    btrfs: refactor how we iterate ordered extent in
> >>      btrfs_invalidatepage()
> >>    btrfs: introduce helpers for subpage dirty status
> >>    btrfs: introduce helpers for subpage writeback status
> >>    btrfs: allow btree_set_page_dirty() to do more sanity check on subpage
> >>      metadata
> >>    btrfs: support subpage metadata csum calculation at write time
> >>    btrfs: make alloc_extent_buffer() check subpage dirty bitmap
> >>    btrfs: make the page uptodate assert to be subpage compatible
> >>    btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
> >>    btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
> >>      compatible
> >>    btrfs: add subpage overview comments
> >
> > Moved from topic branch to misc-next.
> >
> 
> Note sure if it's too late, but I inserted the last comment patch into
> the wrong location.

Not late yet but getting very close to the pre-merge window code freeze.

> In fact, there are 4 more patches to make subpage metadata RW really work:
>   btrfs: make lock_extent_buffer_for_io() to be subpage compatible
>   btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
>   btrfs: introduce end_bio_subpage_eb_writepage() function
>   btrfs: introduce write_one_subpage_eb() function
> 
> Those 4 patches should be before the final comment patch.
> 
> Should I just send the 4 patches in a separate series?

As they've been posted now, I'll add them to for-next and reorder before
the last patch with comment, after some testing.

> Sorry for the bad split, it looks like multi-series patches indeed has
> such problem...

Yeah, but so far it's been all fixable given the scope of the whole
subpage support.
