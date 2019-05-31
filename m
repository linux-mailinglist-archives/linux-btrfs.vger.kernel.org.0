Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9C30E11
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaMZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 08:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfEaMZz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 08:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA8C6AD76;
        Fri, 31 May 2019 12:25:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3D70DA85E; Fri, 31 May 2019 14:26:45 +0200 (CEST)
Date:   Fri, 31 May 2019 14:26:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
Message-ID: <20190531122643.GK15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190508104958.18363-1-wqu@suse.com>
 <20190509144915.GV20156@twin.jikos.cz>
 <a32c0d72-ca46-1886-1788-1ca5d926353c@gmx.com>
 <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4Px96R9upobOO=7osCjoMeW-w9RCixMo81YEOCsc07kQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 15, 2019 at 03:56:31PM +0100, Filipe Manana wrote:
> On Fri, May 10, 2019 at 12:30 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > On 2019/5/9 下午10:49, David Sterba wrote:
> > > On Wed, May 08, 2019 at 06:49:58PM +0800, Qu Wenruo wrote:
> > >> [BUG]
> > >> The following script can cause unexpected fsync failure:
> > >>
> > >>   #!/bin/bash
> > >>
> > >>   dev=/dev/test/test
> > >>   mnt=/mnt/btrfs
> > >>
> > >>   mkfs.btrfs -f $dev -b 512M > /dev/null
> > >>   mount $dev $mnt -o nospace_cache
> > >>
> > >>   # Prealloc one extent
> > >>   xfs_io -f -c "falloc 8k 64m" $mnt/file1
> > >>   # Fill the remaining data space
> > >>   xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
> > >>   sync
> > >>
> > >>   # Write into the prealloc extent
> > >>   xfs_io -c "pwrite 1m 16m" $mnt/file1
> > >>
> > >>   # Reflink then fsync, fsync would fail due to ENOSPC
> > >>   xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
> > >>   umount $dev
> > >>
> > >> The fsync fails with ENOSPC, and the last page of the buffered write is
> > >> lost.
> > >>
> > >> [CAUSE]
> > >> This is caused by:
> > >> - Btrfs' back reference only has extent level granularity
> > >>   So write into shared extent must be CoWed even only part of the extent
> > >>   is shared.
> > >>
> > >> So for above script we have:
> > >> - fallocate
> > >>   Create a preallocated extent where we can do NOCOW write.
> > >>
> > >> - fill all the remaining data and unallocated space
> > >>
> > >> - buffered write into preallocated space
> > >>   As we have not enough space available for data and the extent is not
> > >>   shared (yet) we fall into NOCOW mode.
> > >>
> > >> - reflink
> > >>   Now part of the large preallocated extent is shared, later write
> > >>   into that extent must be CoWed.
> > >>
> > >> - fsync triggers writeback
> > >>   But now the extent is shared and therefore we must fallback into COW
> > >>   mode, which fails with ENOSPC since there's not enough space to
> > >>   allocate data extents.
> > >>
> > >> [WORKAROUND]
> > >> The workaround is to ensure any buffered write in the related extents
> > >> (not just the reflink source range) get flushed before reflink/dedupe,
> > >> so that NOCOW writes succeed that happened before reflinking succeed.
> > >>
> > >> The workaround is expensive
> > >
> > > Can you please quantify that, how big the performance drop is going to
> > > be?
> >
> > Depends on how many dirty pages there are at the timing of reflink/dedupe.
> >
> > If there are a lot, then it would be a delay for reflink/dedupe.
> >
> > >
> > > If the fsync comes soon after reflink, then it's effectively no change.
> > > In case the buffered writes happen on a different range than reflink and
> > > fsync comes later, the buffered writes will stall reflink, right?
> >
> > Fsync doesn't make much difference, it mostly depends on how many dirty
> > pages are.
> >
> > Thus the most impacted use case is concurrent buffered write with
> > reflink/dedupe.
> >
> > >
> > > If there are other similar corner cases we'd better know them in advance
> > > and estimate the impact, that'll be something to look for when we get
> > > complaints that reflink is suddenly slow.
> > >
> > >> NOCOW range, but that needs extra accounting for NOCOW range.
> > >> For now, fix the possible data loss first.
> > >
> > > filemap_flush says
> > >
> > >  437 /**
> > >  438  * filemap_flush - mostly a non-blocking flush
> > >  439  * @mapping:    target address_space
> > >  440  *
> > >  441  * This is a mostly non-blocking flush.  Not suitable for data-integrity
> > >  442  * purposes - I/O may not be started against all dirty pages.
> > >  443  *
> > >  444  * Return: %0 on success, negative error code otherwise.
> > >  445  */
> > >
> > > so how does this work together with the statement about preventing data
> > > loss?
> >
> > The data loss is caused by the fact that we can start buffered write
> > without reserving data space, but after reflink/dedupe we have to do CoW.
> > Without enough space, CoW will fail due to ENOSPC.
> >
> > The fix here is, we ensure all dirties pages start their writeback
> > (start btrfs_run_delalloc_range()) before reflink.
> >
> > At btrfs_run_delalloc_range() we determine whether a range goes through
> > NOCOW or COW, and submit ordered extent to do real write back/csum
> > calculation/etc.
> >
> > As long as the whole inode goes through btrfs_run_delalloc_range(), any
> > NOCOW write will go NOCOW on-disk.
> > We don't need to wait for the ordered extent to finish, just ensure all
> > pages goes through delalloc is enough.
> > Waiting for ordered extent will cause even more latency for reflink.
> >
> > Thus the filemap_flush() is enough, as the point is to ensure delalloc
> > is started before reflink.
> 
> I believe that David's comment is related to this part of the comment
> on filemap_flush():
> 
> "I/O may not be started against all dirty pages."
> 
> I.e., his concern being that writeback may not be started and
> therefore we end up with the data loss due to ENOSPC later, and not to
> the technical details of why the ENOSPC failure happens, which is
> already described in the changelog and discussed during the review of
> previous versions of the patch.
> 
> However btrfs has its own writepages() implementation, which even for
> WB_SYNC_NONE (used by filemap_flush) starts writeback (and doesn't
> wait for it to finish if it started before, which is fine for this use
> case).
> Anyway, just my interpretation of the doubt/comment.

That's correct and answers my questions, thanks.
