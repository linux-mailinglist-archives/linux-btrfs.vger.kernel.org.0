Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE71B32F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUXMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 19:12:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgDUXMN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 19:12:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B9FEABBD;
        Tue, 21 Apr 2020 23:12:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C588DA70B; Wed, 22 Apr 2020 01:11:29 +0200 (CEST)
Date:   Wed, 22 Apr 2020 01:11:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/15] btrfs: get rid of one layer of bios in direct
 I/O
Message-ID: <20200421231129.GP18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
 <bd8015bf0064f084c371ceee399383d791c807db.1587072977.git.osandov@fb.com>
 <f5e024ae-b148-a54b-c6ba-d875a16757b9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5e024ae-b148-a54b-c6ba-d875a16757b9@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 04:00:56PM +0300, Nikolay Borisov wrote:
> On 17.04.20 г. 0:46 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In the worst case, there are _4_ layers of bios in the Btrfs direct I/O
> > path:
> > 
> > 1. The bio created by the generic direct I/O code (dio_bio).
> > 2. A clone of dio_bio we create in btrfs_submit_direct() to represent
> >    the entire direct I/O range (orig_bio).
> > 3. A partial clone of orig_bio limited to the size of a RAID stripe that
> >    we create in btrfs_submit_direct_hook().
> > 4. Clones of each of those split bios for each RAID stripe that we
> >    create in btrfs_map_bio().
> > 
> > As of the previous commit, the second layer (orig_bio) is no longer
> > needed for anything: we can split dio_bio instead, and complete dio_bio
> > directly when all of the cloned bios complete. This lets us clean up a
> > bunch of cruft, including dip->subio_endio and dip->errors (we can use
> > dio_bio->bi_status instead). It also enables the next big cleanup of
> > direct I/O read repair.
> 
> nit: Please explicitly mention that btrfs_dio_private_put is now not
> only putting a structure and doing cleanups but also serves as the io
> completion routine for dio_bio. Given the name of the function and its
> purpose I find this a bit counter-intuitive. But since this is rather
> subjective I'd like to ask David if he also sees it as a bit surprising?

I tend to agree that mixing put and end_io together is counter
intuitive, but I don't se a way how to separate them.

> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/btrfs_inode.h |  16 ----
> >  fs/btrfs/inode.c       | 185 +++++++++++++++--------------------------
> >  2 files changed, 65 insertions(+), 136 deletions(-)
> > 
> 
> <snip>
> 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index fe87c465b13c..79b884d2f3ed 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7356,6 +7356,29 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
> >  	return ret;
> >  }
> >  
> > +static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
> > +{
> 
> The way you've structured the code is proliferating something which has
> been identified as bad practice, namely - asymmetry between  "refcount
> get" and "refcount put" operations. The put is nicely encapsulated
> behind an aptly named function, however getting the reference is really
> an open-coded refcount_inc. This has lead to at least 1 bug in the past
> (recently fixed by Filipe) since transaction's refcount management is
> similar. So I'd rather have the refcount_inc(dip->refs) be encapsulated
> behind a simple btrfs_dio_private_get() helper.

btrfs_dio_private_get for refcount_inc would be ok, but I'm not sure if
you also want the put+end_io for btrfs_dio_private_put.

Eg. in submit_dio_repair_bio, there's plain refcount_inc/refcount_dec,
here the end_io semantics is not expected (and won't probably happen).

In btrfs_submit_direct there's the conditional inc/dec, when transfering
the 1st reference from the init.

Suggestions welcome.
