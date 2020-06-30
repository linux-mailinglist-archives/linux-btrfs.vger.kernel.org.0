Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160E20F701
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbgF3OUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgF3OUf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:20:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 466A7AC37;
        Tue, 30 Jun 2020 14:20:34 +0000 (UTC)
Date:   Tue, 30 Jun 2020 09:20:31 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] btrfs: Use shared inode lock for direct writes
 within EOF
Message-ID: <20200630142031.45vgiqn4nuslsro2@fiona>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
 <20200622162017.21773-7-rgoldwyn@suse.de>
 <CAL3q7H4wL318dHrHcQKU_9n_p+_YFhySy1CzLSfTDYJYcv9pOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4wL318dHrHcQKU_9n_p+_YFhySy1CzLSfTDYJYcv9pOA@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10:37 30/06, Filipe Manana wrote:
> On Mon, Jun 22, 2020 at 5:22 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > This is to parallelize direct writes within EOF or with direct I/O
> > reads. This covers the race with truncate() accidentally increasing the
> > filesize.
> >
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
> >         loff_t endbyte;
> >         int err;
> >         size_t count = 0;
> > -       bool relock = false;
> >         int flags = IOMAP_DIOF_PGINVALID_FAIL;
> >         int ilock_flags = 0;
> >
> >         if (iocb->ki_flags & IOCB_NOWAIT)
> >                 ilock_flags |= BTRFS_ILOCK_TRY;
> > +       /*
> > +        * If the write DIO within EOF,  use a shared lock
> > +        */
> > +       if (pos + count <= i_size_read(inode))
> > +               ilock_flags |= BTRFS_ILOCK_SHARED;
> > +       else if (iocb->ki_flags & IOCB_NOWAIT)
> > +               return -EAGAIN;
> 
> In the next iteration, please rebase the patchset on a more recent misc-next.
> 
> That hunk returning -EAGAIN is buggy and was removed a couple weeks
> ago in a patchset fixing several bugs with NOWAIT writes.
> 

I worked against the vanilla and it is already ported in the git tree
since your patch was added in the meantime.

-- 
Goldwyn
