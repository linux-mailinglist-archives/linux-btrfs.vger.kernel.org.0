Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE61E6780
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405056AbgE1Qe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 12:34:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405004AbgE1Qez (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 12:34:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2AF11AD3A;
        Thu, 28 May 2020 16:34:53 +0000 (UTC)
Date:   Thu, 28 May 2020 11:34:50 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200528163450.uykayisbrn6hfm2z@fiona>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
 <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona>
 <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16:13 28/05, Filipe Manana wrote:
> On Tue, May 26, 2020 at 5:47 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > On 15:03 26/05, Johannes Thumshirn wrote:
> > > Just as a heads up, this one gives me lot's of Page cache invalidation
> > > failure prints from dio_warn_stale_pagecache() on btrfs/004 with
> > > current misc-next:
> > >
> > <snip>
> >
> > > [   23.696400] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> > > [   23.698115] File: /mnt/scratch/bgnoise/p0/f0 PID: 6562 Comm: fsstress
> > >
> > > I have no idea yet why but I'm investigating.
> >
> > This is caused because we are trying to release a page when the extent
> > has locked the page and release page returns false.
> 
> By "we" you mean what exaclty, a direct IO read, a direct IO write?
> 
> And who locked the extent range before?

This is usually locked by a previous buffered write or read.

> 
> That seems alarming to me, specially if it's a direct IO write failing
> to invalidate the page cache, since a subsequent buffered read could
> get stale data (what's in the page cache), and not what the direct IO
> write wrote.
> 
> Can you elaborate more on all those details?

The origin of the message is when iomap_dio_rw() tries to invalidate the
inode pages, but fails and calls dio_warn_stale_pagecache().

In the vanilla code, generic_file_direct_write() aborts direct writes
and returns 0 so that it may fallback to buffered I/O. Perhaps this
should be changed in iomap_dio_rw() as well. I will write a patch to
accomodate that.

-- 
Goldwyn
