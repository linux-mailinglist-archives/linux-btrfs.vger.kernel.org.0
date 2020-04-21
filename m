Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDB1B32A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDUW1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 18:27:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:42496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDUW1m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 18:27:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E4BEAD4B;
        Tue, 21 Apr 2020 22:27:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6C01DA70B; Wed, 22 Apr 2020 00:26:57 +0200 (CEST)
Date:   Wed, 22 Apr 2020 00:26:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/15] btrfs: fix double __endio_write_update_ordered
 in direct I/O
Message-ID: <20200421222657.GN18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
 <594c8cb6dd64cebdf5e01016ce823e1be00fc7ab.1587072977.git.osandov@fb.com>
 <251a02c2-b6b9-7b31-38dc-a56abc2e0f77@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <251a02c2-b6b9-7b31-38dc-a56abc2e0f77@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 01:44:25PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.04.20 г. 0:46 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In btrfs_submit_direct(), if we fail to allocate the btrfs_dio_private,
> > we complete the ordered extent range. However, we don't mark that the
> > range doesn't need to be cleaned up from btrfs_direct_IO() until later.
> > Therefore, if we fail to allocate the btrfs_dio_private, we complete the
> > ordered extent range twice. We could fix this by updating
> > unsubmitted_oe_range earlier, but it's cleaner to reorganize the code so
> > that creating the btrfs_dio_private and submitting the bios are
> > separate, and once the btrfs_dio_private is created, cleanup always
> > happens through the btrfs_dio_private.
> > 
> > Fixes: f28a49287817 ("Btrfs: fix leaking of ordered extents after direct IO write error")
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Generally looks ok, so :
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>, however please see
> below for some remarks on the logic around unsubmitted_oe_range_start/end
> 
> > ---
> >  fs/btrfs/inode.c | 174 ++++++++++++++++++-----------------------------
> >  1 file changed, 66 insertions(+), 108 deletions(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b628c319a5b6..f6ce9749adb6 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7903,14 +7903,60 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
> >  	return ret;
> >  }
> >  
> > -static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
> > +/*
> > + * If this succeeds, the btrfs_dio_private is responsible for cleaning up locked
> > + * or ordered extents whether or not we submit any bios.
> > + */
> > +static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
> > +							  struct inode *inode,
> > +							  loff_t file_offset)
> >  {
> > -	struct inode *inode = dip->inode;
> > +	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
> > +	struct btrfs_dio_private *dip;
> > +	struct bio *bio;
> > +
> > +	dip = kzalloc(sizeof(*dip), GFP_NOFS);
> > +	if (!dip)
> > +		return NULL;
> > +
> > +	bio = btrfs_bio_clone(dio_bio);
> > +	bio->bi_private = dip;
> > +	btrfs_io_bio(bio)->logical = file_offset;
> > +
> > +	dip->private = dio_bio->bi_private;
> > +	dip->inode = inode;
> > +	dip->logical_offset = file_offset;
> > +	dip->bytes = dio_bio->bi_iter.bi_size;
> > +	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
> > +	dip->orig_bio = bio;
> > +	dip->dio_bio = dio_bio;
> > +	atomic_set(&dip->pending_bios, 1);
> > +
> > +	if (write) {
> > +		struct btrfs_dio_data *dio_data = current->journal_info;
> > +
> > +		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
> > +			dip->bytes;
> > +		dio_data->unsubmitted_oe_range_start =
> > +			dio_data->unsubmitted_oe_range_end;
> 
> The logic around those 2 members is really subtle. We really have the
> following:
> 
> 1. btrfs_direct_IO sets those two to the same value.
> 
> 2. When we call __blockdev_direct_IO unless
> btrfs_get_blocks_direct->btrfs_get_blocks_direct_write is called to
> modify unsubmitted_oe_range_start so that start < end. Cleanup won't
> happen.
> 
> 3. We come into btrfs_submit_direct - if it dip allocation fails we'd
> return with oe_range_end now modified so cleanup will happen.
> 
> 4. If we manage to allocate the dip we reset the unsubmitted range
> members to be equal so that cleanup happens from btrfs_endio_direct_write.
> 
> This 4-step logic is not really obvious, especially given it's scattered
> across 3 functions. Perhaps a comment saying that having the 2 members
> being equal means cleanup in btrfs_DIRECT_io is disabled.
> 
> I'd rather have it spelled out in the changelog, I guess David can also
> do that ?

The above added to changelog and a brief comment added, thanks.
