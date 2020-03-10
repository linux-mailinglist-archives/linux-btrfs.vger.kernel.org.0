Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418301803B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCJQjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 12:39:42 -0400
Received: from verein.lst.de ([213.95.11.211]:53936 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgCJQjm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 12:39:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7CD7F68BE1; Tue, 10 Mar 2020 17:39:40 +0100 (CET)
Date:   Tue, 10 Mar 2020 17:39:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200310163940.GE6361@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adding Goldwyn,

as he has been looking into converting btrfs to the iomap direct
I/O code.  This doesn't look like a major conflict, but he should
be knowledgeable about the dio code by now after a few iterations
of that.

On Mon, Mar 09, 2020 at 02:32:26PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> This series includes several fixes, cleanups, and improvements to direct
> I/O and read repair. It's preparation for adding read repair to my
> RWF_ENCODED series [1], but it can go in independently.
> 
> Patches 1 and 2 are direct I/O error handling fixes. Patch 3 is a
> buffered read repair fix. Patch 4 is a buffered read repair improvement.
> Patches 5-9 are trivial cleanups. Patch 10 converts direct I/O to use
> refcount_t, which would've helped catch the bug fixed by patch 1.
> Patches 11-14 drastically simplify the direct I/O code. Patch 15 gets
> unifies buffered and direct I/O read repair, which also makes direct I/O
> repair actually do validation for large failed reads instead of
> rewriting the whole thing.
> 
> Overall, this is net about -400 lines of code and actually makes direct
> I/O more functional.
> 
> Note that this series causes btrfs/142 to fail. This is a bug in the
> test, as it assumes that direct I/O doesn't do read validation. I'm
> working on a fix for the test.
> 
> Christoph is cc'd for patch 3. The fix looks at the bio internals in a
> way that I wasn't sure was recommended, although there is precedent in
> the bcache code. I'd appreciate if Christoph acked that patch or
> suggested a better approach.
> 
> This series is based on misc-next.
> 
> Thanks!
> 
> 1: https://lore.kernel.org/linux-fsdevel/cover.1582930832.git.osandov@fb.com/
> 
> Omar Sandoval (15):
>   btrfs: fix error handling when submitting direct I/O bio
>   btrfs: fix double __endio_write_update_ordered in direct I/O
>   btrfs: look at full bi_io_vec for repair decision
>   btrfs: don't do repair validation for checksum errors
>   btrfs: clarify btrfs_lookup_bio_sums documentation
>   btrfs: rename __readpage_endio_check to check_data_csum
>   btrfs: make btrfs_check_repairable() static
>   btrfs: move btrfs_dio_private to inode.c
>   btrfs: kill btrfs_dio_private->private
>   btrfs: convert btrfs_dio_private->pending_bios to refcount_t
>   btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
>   btrfs: get rid of one layer of bios in direct I/O
>   btrfs: simplify direct I/O read repair
>   btrfs: get rid of endio_repair_workers
>   btrfs: unify buffered and direct I/O read repair
> 
>  fs/btrfs/btrfs_inode.h |  30 --
>  fs/btrfs/ctree.h       |   1 -
>  fs/btrfs/disk-io.c     |   8 +-
>  fs/btrfs/disk-io.h     |   1 -
>  fs/btrfs/extent_io.c   | 141 +++++----
>  fs/btrfs/extent_io.h   |  19 +-
>  fs/btrfs/file-item.c   |  11 +-
>  fs/btrfs/inode.c       | 694 ++++++++++-------------------------------
>  8 files changed, 260 insertions(+), 645 deletions(-)
> 
> -- 
> 2.25.1
---end quoted text---
