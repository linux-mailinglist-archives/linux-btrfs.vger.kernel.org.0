Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C820F70C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgF3OYK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:24:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgF3OYJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:24:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DF01AC37;
        Tue, 30 Jun 2020 14:24:08 +0000 (UTC)
Date:   Tue, 30 Jun 2020 09:24:05 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 6/8] btrfs: Use shared inode lock for direct writes
 within EOF
Message-ID: <20200630142405.zl4nzqyj6ei65vph@fiona>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
 <20200622162017.21773-7-rgoldwyn@suse.de>
 <20200630084245.GT27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630084245.GT27795@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10:42 30/06, David Sterba wrote:
> On Mon, Jun 22, 2020 at 11:20:15AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > This is to parallelize direct writes within EOF or with direct I/O
> > reads. This covers the race with truncate() accidentally increasing the
> > filesize.
> 
> Please describe the race condition in more detail and how the DIO/EOF
> parallelization is supposed to work.
> 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/file.c | 25 +++++++------------------
> >  1 file changed, 7 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index aa6be931620b..c446a4aeb867 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1957,12 +1957,18 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	loff_t endbyte;
> >  	int err;
> >  	size_t count = 0;
> > -	bool relock = false;
> >  	int flags = IOMAP_DIOF_PGINVALID_FAIL;
> >  	int ilock_flags = 0;
> >  
> >  	if (iocb->ki_flags & IOCB_NOWAIT)
> >  		ilock_flags |= BTRFS_ILOCK_TRY;
> > +	/*
> > +	 * If the write DIO within EOF,  use a shared lock
> > +	 */
> > +	if (pos + count <= i_size_read(inode))
> 
> Inode size is now read outside of the inode lock, so it could change
> until the lock is taken a few lines below.

Good catch. This should be re-checked in btrfs_write_check().
Thanks.

> 
> > +		ilock_flags |= BTRFS_ILOCK_SHARED;
> > +	else if (iocb->ki_flags & IOCB_NOWAIT)
> > +		return -EAGAIN;
> >  
> >  	err = btrfs_inode_lock(inode, ilock_flags);
> 
> Is it necessary to revalidate that 'pos + count < i_size' still holds
> when the lock was taken as SHARED?

Yes, and convert the lock, if not. 

-- 
Goldwyn
