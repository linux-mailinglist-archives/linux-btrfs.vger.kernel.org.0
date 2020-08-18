Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D1248C3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 18:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgHRQ6g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 12:58:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgHRQ6N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 12:58:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9010BAB89;
        Tue, 18 Aug 2020 16:58:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7BD9DA703; Tue, 18 Aug 2020 18:56:52 +0200 (CEST)
Date:   Tue, 18 Aug 2020 18:56:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Subject: Re: [PATCH] btrfs: switch to iomap_dio_rw() for dio
Message-ID: <20200818165652.GI2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-btrfs@vger.kernel.org
References: <20200817161821.53ljczz3ahudfb2a@fiona>
 <65ed4f24-b772-8cbe-129c-4b23c9354522@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ed4f24-b772-8cbe-129c-4b23c9354522@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 18, 2020 at 12:47:55PM -0400, Josef Bacik wrote:
> On 8/17/20 12:18 PM, Goldwyn Rodrigues wrote:
> > [Rebased against kdave/misc-next]
> > 
> > Switch from __blockdev_direct_IO() to iomap_dio_rw().
> > Rename btrfs_get_blocks_direct() to btrfs_dio_iomap_begin() and use it
> > as iomap_begin() for iomap direct I/O functions. This function
> > allocates and locks all the blocks required for the I/O.
> > btrfs_submit_direct() is used as the submit_io() hook for direct I/O
> > ops.
> > 
> > Since we need direct I/O reads to go through iomap_dio_rw(), we change
> > file_operations.read_iter() to a btrfs_file_read_iter() which calls
> > btrfs_direct_IO() for direct reads and falls back to
> > generic_file_buffered_read() for incomplete reads and buffered reads.
> > 
> > We don't need address_space.direct_IO() anymore: set it to noop.
> > Similarly, we don't need flags used in __blockdev_direct_IO(). iomap is
> > capable of direct I/O reads from a hole, so we don't need to return
> > -ENOENT.
> > 
> > BTRFS direct I/O is now done under i_rwsem, shared in case of reads and
> > exclusive in case of writes. This guards against simultaneous truncates.
> > 
> > Use iomap->iomap_end() to check for failed or incomplete direct I/O:
> >    - for writes, call __endio_write_update_ordered()
> >    - for reads, unlock extents
> > 
> > btrfs_dio_data is now hooked in iomap->private and not
> > current->journal_info. It carries the reservation variable and the
> > amount of data submitted, so we can calculate the amount of data to call
> > __endio_write_update_ordered in case of an error.
> > 
> > This patch removes last use of struct buffer_head from btrfs.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This thing is huge, but it builds and passes the dio tests, and I went through 
> it twice.  I imagine we'll still find things broken after the fact, but IDK how 
> to break it up more since we're converting to a new style.

Thanks, ack, I think this is a resonably small version we can get. There
are 3 patches doing some post-cleanups but for now I'd like to get just
the switch so any eventual fixups are easy.

Tests finish for me but I haven't scanned all results so there are
potential failures. The plan is to push the patch out early for wider
testing despite that. Functionality-wise the patch is complete so we're
now going to just hunt the remaining bugs.

I'll add the patch to misc-next by the end of the week, it'll be in
for-next until then, more reviews are welcome.
