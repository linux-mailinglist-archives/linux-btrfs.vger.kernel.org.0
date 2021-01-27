Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1540B305B19
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 13:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhA0MTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 07:19:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:47022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237694AbhA0MRZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 07:17:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 501E8AC4F;
        Wed, 27 Jan 2021 12:16:42 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:16:35 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Michal Rostecki <mrostecki@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Avoid calling btrfs_get_chunk_map() twice
Message-ID: <20210127121635.GA29301@wotan.suse.de>
References: <20210127095131.22600-1-mrostecki@suse.de>
 <CAL3q7H4Bs7DfK09bpRGFE00yNY7YbwkGvHBcR_2mJ3uSk2FTbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4Bs7DfK09bpRGFE00yNY7YbwkGvHBcR_2mJ3uSk2FTbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 11:20:55AM +0000, Filipe Manana wrote:
> On Wed, Jan 27, 2021 at 9:59 AM Michal Rostecki <mrostecki@suse.de> wrote:
> >
> > From: Michal Rostecki <mrostecki@suse.com>
> >
> > Before this change, the btrfs_get_io_geometry() function was calling
> > btrfs_get_chunk_map() to get the extent mapping, necessary for
> > calculating the I/O geometry. It was using that extent mapping only
> > internally and freeing the pointer after its execution.
> >
> > That resulted in calling btrfs_get_chunk_map() de facto twice by the
> > __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> > first and then calling btrfs_get_chunk_map() directly to get the extent
> > mapping, used by the rest of the function.
> >
> > This change fixes that by passing the extent mapping to the
> > btrfs_get_io_geometry() function as an argument.
> >
> > Fixes: 89b798ad1b42 ("btrfs: Use btrfs_get_io_geometry appropriately")
> 
> Generally we only use the Fixes tag for bug fixes or serious
> performance regressions.
> Have you seen here a serious performance regression?
> 

No, I didn't see any big difference in terms of performance (at least in
seq reads). I will remove the tag in v2.

> > Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> > ---
> >  fs/btrfs/inode.c   | 37 ++++++++++++++++++++++++++++---------
> >  fs/btrfs/volumes.c | 39 ++++++++++++++++-----------------------
> >  fs/btrfs/volumes.h |  5 +++--
> >  3 files changed, 47 insertions(+), 34 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 0dbe1aaa0b71..a4ce8501ed4d 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -2183,9 +2183,10 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
> >         struct inode *inode = page->mapping->host;
> >         struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >         u64 logical = bio->bi_iter.bi_sector << 9;
> > +       struct extent_map *em;
> >         u64 length = 0;
> >         u64 map_length;
> > -       int ret;
> > +       int ret = 0;
> >         struct btrfs_io_geometry geom;
> >
> >         if (bio_flags & EXTENT_BIO_COMPRESSED)
> > @@ -2193,14 +2194,21 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
> >
> >         length = bio->bi_iter.bi_size;
> >         map_length = length;
> > -       ret = btrfs_get_io_geometry(fs_info, btrfs_op(bio), logical, map_length,
> > -                                   &geom);
> > +       em = btrfs_get_chunk_map(fs_info, logical, map_length);
> > +       if (IS_ERR(em))
> > +               return PTR_ERR(em);
> > +       ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical,
> > +                                   map_length, &geom);
> >         if (ret < 0)
> > -               return ret;
> > +               goto out;
> >
> > -       if (geom.len < length + size)
> > -               return 1;
> > -       return 0;
> > +       if (geom.len < length + size) {
> > +               ret = 1;
> > +               goto out;
> > +       }
> > +out:
> > +       free_extent_map(em);
> > +       return ret;
> >  }
> >
> >  /*
> > @@ -7941,10 +7949,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
> >         u64 submit_len;
> >         int clone_offset = 0;
> >         int clone_len;
> > +       int logical;
> >         int ret;
> >         blk_status_t status;
> >         struct btrfs_io_geometry geom;
> >         struct btrfs_dio_data *dio_data = iomap->private;
> > +       struct extent_map *em;
> >
> >         dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
> >         if (!dip) {
> > @@ -7970,11 +7980,17 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
> >         }
> >
> >         start_sector = dio_bio->bi_iter.bi_sector;
> > +       logical = start_sector << 9;
> >         submit_len = dio_bio->bi_iter.bi_size;
> >
> >         do {
> > -               ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
> > -                                           start_sector << 9, submit_len,
> > +               em = btrfs_get_chunk_map(fs_info, logical, submit_len);
> > +               if (IS_ERR(em)) {
> > +                       status = errno_to_blk_status(ret);
> > +                       goto out_err;
> 
> em must be set to NULL before going to "out_err", otherwise we get a
> crash due to an invalid memory access.
> 
> Also, status should be set to "errno_to_blk_status(PTR_ERR(em))". The
> value of ret at this point is undefined.
> 
> Other than that, it looks good.
> 
> Thanks.
> 

Will fix in v2. Thanks!

> > +               }
> > +               ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
> > +                                           logical, submit_len,
> >                                             &geom);
> >                 if (ret) {
> >                         status = errno_to_blk_status(ret);
> > @@ -8030,12 +8046,15 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
> >                 clone_offset += clone_len;
> >                 start_sector += clone_len >> 9;
> >                 file_offset += clone_len;
> > +
> > +               free_extent_map(em);
> >         } while (submit_len > 0);
> >         return BLK_QC_T_NONE;
> >
> >  out_err:
> >         dip->dio_bio->bi_status = status;
> >         btrfs_dio_private_put(dip);
> > +       free_extent_map(em);
> >         return BLK_QC_T_NONE;
> >  }
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index a8ec8539cd8d..4c753b17c0a2 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -5940,23 +5940,24 @@ static bool need_full_stripe(enum btrfs_map_op op)
> >  }
> >
> >  /*
> > - * btrfs_get_io_geometry - calculates the geomery of a particular (address, len)
> > + * btrfs_get_io_geometry - calculates the geometry of a particular (address, len)
> >   *                    tuple. This information is used to calculate how big a
> >   *                    particular bio can get before it straddles a stripe.
> >   *
> > - * @fs_info - the filesystem
> > - * @logical - address that we want to figure out the geometry of
> > - * @len            - the length of IO we are going to perform, starting at @logical
> > - * @op      - type of operation - write or read
> > - * @io_geom - pointer used to return values
> > + * @fs_info: the filesystem
> > + * @em:      mapping containing the logical extent
> > + * @op:      type of operation - write or read
> > + * @logical: address that we want to figure out the geometry of
> > + * @len:     the length of IO we are going to perform, starting at @logical
> > + * @io_geom: pointer used to return values
> >   *
> >   * Returns < 0 in case a chunk for the given logical address cannot be found,
> >   * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
> >   */
> > -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> > -                       u64 logical, u64 len, struct btrfs_io_geometry *io_geom)
> > +int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
> > +                         enum btrfs_map_op op, u64 logical, u64 len,
> > +                         struct btrfs_io_geometry *io_geom)
> >  {
> > -       struct extent_map *em;
> >         struct map_lookup *map;
> >         u64 offset;
> >         u64 stripe_offset;
> > @@ -5964,14 +5965,9 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> >         u64 stripe_len;
> >         u64 raid56_full_stripe_start = (u64)-1;
> >         int data_stripes;
> > -       int ret = 0;
> >
> >         ASSERT(op != BTRFS_MAP_DISCARD);
> >
> > -       em = btrfs_get_chunk_map(fs_info, logical, len);
> > -       if (IS_ERR(em))
> > -               return PTR_ERR(em);
> > -
> >         map = em->map_lookup;
> >         /* Offset of this logical address in the chunk */
> >         offset = logical - em->start;
> > @@ -5985,8 +5981,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> >                 btrfs_crit(fs_info,
> >  "stripe math has gone wrong, stripe_offset=%llu offset=%llu start=%llu logical=%llu stripe_len=%llu",
> >                         stripe_offset, offset, em->start, logical, stripe_len);
> > -               ret = -EINVAL;
> > -               goto out;
> > +               return -EINVAL;
> >         }
> >
> >         /* stripe_offset is the offset of this block in its stripe */
> > @@ -6033,10 +6028,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> >         io_geom->stripe_offset = stripe_offset;
> >         io_geom->raid56_stripe_offset = raid56_full_stripe_start;
> >
> > -out:
> > -       /* once for us */
> > -       free_extent_map(em);
> > -       return ret;
> > +       return 0;
> >  }
> >
> >  static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
> > @@ -6069,12 +6061,13 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
> >         ASSERT(bbio_ret);
> >         ASSERT(op != BTRFS_MAP_DISCARD);
> >
> > -       ret = btrfs_get_io_geometry(fs_info, op, logical, *length, &geom);
> > +       em = btrfs_get_chunk_map(fs_info, logical, *length);
> > +       ASSERT(!IS_ERR(em));
> > +
> > +       ret = btrfs_get_io_geometry(fs_info, em, op, logical, *length, &geom);
> >         if (ret < 0)
> >                 return ret;
> >
> > -       em = btrfs_get_chunk_map(fs_info, logical, *length);
> > -       ASSERT(!IS_ERR(em));
> >         map = em->map_lookup;
> >
> >         *length = geom.len;
> > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > index c43663d9c22e..04e2b26823c2 100644
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -440,8 +440,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> >  int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> >                      u64 logical, u64 *length,
> >                      struct btrfs_bio **bbio_ret);
> > -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> > -               u64 logical, u64 len, struct btrfs_io_geometry *io_geom);
> > +int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
> > +                         enum btrfs_map_op op, u64 logical, u64 len,
> > +                         struct btrfs_io_geometry *io_geom);
> >  int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
> >  int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
> >  int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
> > --
> > 2.30.0
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
