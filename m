Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AA1ABDA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504513AbgDPKJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 06:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504467AbgDPKJV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 06:09:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D987AAC7;
        Thu, 16 Apr 2020 10:09:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 06811DA727; Thu, 16 Apr 2020 12:08:38 +0200 (CEST)
Date:   Thu, 16 Apr 2020 12:08:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/15] btrfs: simplify direct I/O read repair
Message-ID: <20200416100838.GG5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
 <20200403164050.GH5920@twin.jikos.cz>
 <20200403180523.GA189126@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403180523.GA189126@vader>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 11:05:23AM -0700, Omar Sandoval wrote:
> On Fri, Apr 03, 2020 at 06:40:51PM +0200, David Sterba wrote:
> > On Mon, Mar 09, 2020 at 02:32:39PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Direct I/O read repair is an over-complicated mess. There is major code
> > > duplication between __btrfs_subio_endio_read() (checks checksums and
> > > handles I/O errors for files with checksums),
> > > __btrfs_correct_data_nocsum() (handles I/O errors for files without
> > > checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
> > > for retries of files with checksums), and btrfs_retry_endio_nocsum()
> > > (handles I/O errors for retries of files without checksum). If it sounds
> > > like these should be one function, that's because they should.
> > > 
> > > After the previous commit getting rid of orig_bio, we can reuse the same
> > > endio callback for repair I/O and the original I/O, we just need to
> > > track the file offset and original iterator in the repair bio. We can
> > > also unify the handling of files with and without checksums and replace
> > > the atrocity that was probably the inspiration for "Go To Statement
> > > Considered Harmful" with normal loops. We also no longer have to wait
> > > for each repair I/O to complete one by one.
> > 
> > This patch looks like a revert of 8b110e393c5a ("Btrfs: implement repair
> > function when direct read fails"), that probably added the extra layer
> > you're removing.
> > 
> > So instead of the funny remarks, I'd rather see some analysis that the
> > issues in the original patch are not coming back.  Quoting from the
> > changelog:
> > 
> > - When we find the data is not right, we try to read the data from the other
> >   mirror.
> > - When the io on the mirror ends, we will insert the endio work into the
> >   dedicated btrfs workqueue, not common read endio workqueue, because the
> >   original endio work is still blocked in the btrfs endio workqueue, if we
> >   insert the endio work of the io on the mirror into that workqueue, deadlock
> >   would happen.
> > - After we get right data, we write it back to the corrupted mirror.
> > - And if the data on the new mirror is still corrupted, we will try next
> >   mirror until we read right data or all the mirrors are traversed.
> > - After the above work, we set the uptodate flag according to the result.
> > 
> > It's not too detailed either, but what immediatelly looks suspicious is
> > the extra workqueue that was added to avoid deadlocks. That is now going
> > to be removed. This seems like a high level change even for such an old
> > code (2014) so that its effects are not affected by some other changes
> > in the dio code.
> 
> This patch doesn't touch the extra workqueue. The next patch that gets
> rid of it has an explanation:
> 
>     This was originally added in commit 8b110e393c5a ("Btrfs: implement
>     repair function when direct read fails") because the original bio waited
>     for the repair bio to complete, so the repair I/O couldn't go through
>     the same workqueue. As of the previous commit, this is no longer true,
>     so this separate workqueue is unnecessary.
> 
> I can expand on that for v2. The deadlock addressed by the original code
> is pretty much that while the worker is executing the original bio, it
> will be blocked on the repair bio completing, and the repair bio will be
> blocked on the worker finishing the original bio. With this rework, the
> original bio doesn't block on the repair bio, so the worker becomes
> available for the repair bio right away.

I haven't noticed that the next patch mentions the commmit 8b110e393c5a,
so for clarity it would be better to have more references in both. The
explanation above sounds good to me.

Please send v2, of the whole patchset, it's post rc1 so time for new
code. I'm testing the dio-iomap code, it's getting better so hopefully
both patchsets can be merged together.
