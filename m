Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0128D1E6991
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405909AbgE1Siz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:38:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405898AbgE1Siy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:38:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B14D2AC96;
        Thu, 28 May 2020 18:38:51 +0000 (UTC)
Date:   Thu, 28 May 2020 13:38:48 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200528183848.siuljkvqmxbqa436@fiona>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
 <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona>
 <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
 <20200528163450.uykayisbrn6hfm2z@fiona>
 <CAL3q7H700X4E5-NjTWcWwosBwLuKeFPOPx00f+OVn=2fBfmJbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H700X4E5-NjTWcWwosBwLuKeFPOPx00f+OVn=2fBfmJbQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17:45 28/05, Filipe Manana wrote:
> On Thu, May 28, 2020 at 5:34 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > > And who locked the extent range before?
> >
> > This is usually locked by a previous buffered write or read.
> 
> A previous buffered write/read that has already finished or is still
> in progress?
> 
> Because if it has finished we're not supposed to have the file range
> locked anymore.

In progress. Mixing buffered I/O with direct writes.

> 
> >
> > >
> > > That seems alarming to me, specially if it's a direct IO write failing
> > > to invalidate the page cache, since a subsequent buffered read could
> > > get stale data (what's in the page cache), and not what the direct IO
> > > write wrote.
> > >
> > > Can you elaborate more on all those details?
> >
> > The origin of the message is when iomap_dio_rw() tries to invalidate the
> > inode pages, but fails and calls dio_warn_stale_pagecache().
> >
> > In the vanilla code, generic_file_direct_write() aborts direct writes
> > and returns 0 so that it may fallback to buffered I/O. Perhaps this
> > should be changed in iomap_dio_rw() as well. I will write a patch to
> > accomodate that.
> 
> On vanilla we have no problems of mixing buffered and direct
> operations as long as they are done sequentially at least.
> And even if done concurrently we take several measures to ensure that
> are no surprises (locking ranges, waiting for any ordered extents in
> progress, etc).

Yes, it is because of the code in generic_file_direct_write(). Anyways,
I did some tests with the following patch, and it seems to work. I will
send a formal patch to so that it gets incorporated in iomap sequence as
well.

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e4addfc58107..215315be6233 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
         */
        ret = invalidate_inode_pages2_range(mapping,
                        pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
-       if (ret)
-               dio_warn_stale_pagecache(iocb->ki_filp);
-       ret = 0;
+       /*
+        * If a page can not be invalidated, return 0 to fall back
+        * to buffered write.
+        */
+       if (ret) {
+               if (ret == -EBUSY)
+                       ret = 0;
+               goto out_free_dio;
+       }
 
        if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
            !inode->i_sb->s_dio_done_wq) {



-- 
Goldwyn
