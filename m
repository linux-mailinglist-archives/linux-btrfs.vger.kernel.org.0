Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245651E67A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405156AbgE1Qp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 12:45:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:37682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405140AbgE1Qp5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 12:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0BFFACCC;
        Thu, 28 May 2020 16:45:55 +0000 (UTC)
Date:   Thu, 28 May 2020 11:45:53 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org, dsterba@suse.cz
Subject: Re: [PATCH 3/7] iomap: Remove lockdep_assert_held()
Message-ID: <20200528164553.qnjnwjm6c6hlunjc@fiona>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
 <20200522123837.1196-4-rgoldwyn@suse.de>
 <20200528154014.GA8198@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528154014.GA8198@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  8:40 28/05, Darrick J. Wong wrote:
> On Fri, May 22, 2020 at 07:38:33AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Filesystems such as btrfs can perform direct I/O without holding the
> > inode->i_rwsem in some of the cases like writing within i_size.
> > So, remove the check for lockdep_assert_held() in iomap_dio_rw()
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  fs/iomap/direct-io.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index f88ba6e7f6af..e4addfc58107 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -416,8 +416,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	struct blk_plug plug;
> >  	struct iomap_dio *dio;
> >  
> > -	lockdep_assert_held(&inode->i_rwsem);
> > -
> 
> I could've sworn that I saw a reply from Dave asking to hoist this check
> into all the /other/ iomap_dio_rw callers, but I can't find it and maybe
> I just dreamed the whole thing.

It did happen! However, hch mentioned it is not required [1].
I did promise him to remove the entire concept of dio_sem
locking in btrfs, and just rely on inode->i_mutex. It is still a work in
progress.

> 
> Also, please cc fsdevel any time you make change to fs/iomap/, even if
> we've already reviewed the patches.
> 

Yes, missed that. Sorry.

[1] https://www.spinics.net/lists/linux-btrfs/msg96016.html

-- 
Goldwyn
