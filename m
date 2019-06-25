Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE60557B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfFYTR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 15:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728827AbfFYTRZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 15:17:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD492AE52;
        Tue, 25 Jun 2019 19:17:23 +0000 (UTC)
Date:   Tue, 25 Jun 2019 14:17:21 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190625191721.jqzk3m7qdpbgfxsk@fiona>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de>
 <20190622004624.GC1611011@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622004624.GC1611011@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17:46 21/06, Darrick J. Wong wrote:
> On Fri, Jun 21, 2019 at 02:28:23PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Introduces a new type IOMAP_COW, which means the data at offset
> > must be read from a srcmap and copied before performing the
> > write on the offset.
> > 
> > The srcmap is used to identify where the read is to be performed
> > from. This is passed to iomap->begin(), which is supposed to
> > put in the details for reading, typically set with type IOMAP_READ.
> 
> What is IOMAP_READ ?

Badd comment. I should have written IOMAP_MAPPED or IOMAP_HOLE.
> 
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/dax.c              |  8 +++++---
> >  fs/ext2/inode.c       |  2 +-
> >  fs/ext4/inode.c       |  2 +-
> >  fs/gfs2/bmap.c        |  3 ++-
> >  fs/internal.h         |  2 +-
> >  fs/iomap.c            | 31 ++++++++++++++++---------------
> >  fs/xfs/xfs_iomap.c    |  9 ++++++---
> >  include/linux/iomap.h |  4 +++-
> >  8 files changed, 35 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 2e48c7ebb973..80b9e2599223 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1078,7 +1078,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> >  
> >  static loff_t
> >  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct block_device *bdev = iomap->bdev;
> >  	struct dax_device *dax_dev = iomap->dax_dev;
> > @@ -1236,6 +1236,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	unsigned long vaddr = vmf->address;
> >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >  	struct iomap iomap = { 0 };
> > +	struct iomap srcmap = { 0 };
> >  	unsigned flags = IOMAP_FAULT;
> >  	int error, major = 0;
> >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > @@ -1280,7 +1281,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	 * the file system block size to be equal the page size, which means
> >  	 * that we never have to deal with more than a single extent here.
> >  	 */
> > -	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap);
> > +	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap, &srcmap);
> >  	if (iomap_errp)
> >  		*iomap_errp = error;
> >  	if (error) {
> > @@ -1460,6 +1461,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	struct inode *inode = mapping->host;
> >  	vm_fault_t result = VM_FAULT_FALLBACK;
> >  	struct iomap iomap = { 0 };
> > +	struct iomap srcmap = { 0 };
> >  	pgoff_t max_pgoff;
> >  	void *entry;
> >  	loff_t pos;
> > @@ -1534,7 +1536,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	 * to look up our filesystem block.
> >  	 */
> >  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> > -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap);
> > +	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap, &srcmap);
> 
> Line too long?
> 
> Also, I guess the DAX and directio write paths will just WARN_ON_ONCE if
> someone feeds them an IOMAP_COW type iomap?
> 
> Ah, right, I guess the only filesystems that use iomap directio and
> iomap dax don't support COW. :)

Well, I am planning on adding direct I/O to btrfs using iomap, but am stuck
with some bugs. So, I will add the WARN_ON().

> 
> --D
> 
> >  	if (error)
> >  		goto unlock_entry;
> >  
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index e474127dd255..f081f11980ad 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -801,7 +801,7 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
> >  
> >  #ifdef CONFIG_FS_DAX
> >  static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > -		unsigned flags, struct iomap *iomap)
> > +		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	unsigned int blkbits = inode->i_blkbits;
> >  	unsigned long first_block = offset >> blkbits;
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index c7f77c643008..a8017e0c302b 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3437,7 +3437,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
> >  }
> >  
> >  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > -			    unsigned flags, struct iomap *iomap)
> > +			    unsigned flags, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> >  	unsigned int blkbits = inode->i_blkbits;
> > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > index 93ea1d529aa3..affa0c4305b7 100644
> > --- a/fs/gfs2/bmap.c
> > +++ b/fs/gfs2/bmap.c
> > @@ -1124,7 +1124,8 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
> >  }
> >  
> >  static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
> > -			    unsigned flags, struct iomap *iomap)
> > +			    unsigned flags, struct iomap *iomap,
> > +			    struct iomap *srcmap)
> >  {
> >  	struct gfs2_inode *ip = GFS2_I(inode);
> >  	struct metapath mp = { .mp_aheight = 1, };
> > diff --git a/fs/internal.h b/fs/internal.h
> > index a48ef81be37d..79e495d86165 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -188,7 +188,7 @@ extern int do_vfs_ioctl(struct file *file, unsigned int fd, unsigned int cmd,
> >   * iomap support:
> >   */
> >  typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
> > -		void *data, struct iomap *iomap);
> > +		void *data, struct iomap *iomap, struct iomap *srcmap);
> >  
> >  loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
> >  		unsigned flags, const struct iomap_ops *ops, void *data,
> > diff --git a/fs/iomap.c b/fs/iomap.c
> > index 23ef63fd1669..6648957af268 100644
> > --- a/fs/iomap.c
> > +++ b/fs/iomap.c
> > @@ -41,6 +41,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
> >  		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
> >  {
> >  	struct iomap iomap = { 0 };
> > +	struct iomap srcmap = { 0 };
> >  	loff_t written = 0, ret;
> >  
> >  	/*
> > @@ -55,7 +56,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
> >  	 * expose transient stale data. If the reserve fails, we can safely
> >  	 * back out at this point as there is nothing to undo.
> >  	 */
> > -	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
> > +	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
> >  	if (ret)
> >  		return ret;
> >  	if (WARN_ON(iomap.offset > pos))
> > @@ -75,7 +76,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
> >  	 * we can do the copy-in page by page without having to worry about
> >  	 * failures exposing transient data.
> >  	 */
> > -	written = actor(inode, pos, length, data, &iomap);
> > +	written = actor(inode, pos, length, data, &iomap, &srcmap);
> >  
> >  	/*
> >  	 * Now the data has been copied, commit the range we've copied.  This
> > @@ -282,7 +283,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
> >  
> >  static loff_t
> >  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_readpage_ctx *ctx = data;
> >  	struct page *page = ctx->cur_page;
> > @@ -424,7 +425,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
> >  
> >  static loff_t
> >  iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> > -		void *data, struct iomap *iomap)
> > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_readpage_ctx *ctx = data;
> >  	loff_t done, ret;
> > @@ -444,7 +445,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> >  			ctx->cur_page_in_bio = false;
> >  		}
> >  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> > -				ctx, iomap);
> > +				ctx, iomap, srcmap);
> >  	}
> >  
> >  	return done;
> > @@ -796,7 +797,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> >  
> >  static loff_t
> >  iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iov_iter *i = data;
> >  	long status = 0;
> > @@ -913,7 +914,7 @@ __iomap_read_page(struct inode *inode, loff_t offset)
> >  
> >  static loff_t
> >  iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	long status = 0;
> >  	ssize_t written = 0;
> > @@ -1002,7 +1003,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
> >  
> >  static loff_t
> >  iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> > -		void *data, struct iomap *iomap)
> > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	bool *did_zero = data;
> >  	loff_t written = 0;
> > @@ -1071,7 +1072,7 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
> >  
> >  static loff_t
> >  iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> > -		void *data, struct iomap *iomap)
> > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct page *page = data;
> >  	int ret;
> > @@ -1169,7 +1170,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
> >  
> >  static loff_t
> >  iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct fiemap_ctx *ctx = data;
> >  	loff_t ret = length;
> > @@ -1343,7 +1344,7 @@ page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
> >  
> >  static loff_t
> >  iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
> > -		      void *data, struct iomap *iomap)
> > +		      void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	switch (iomap->type) {
> >  	case IOMAP_UNWRITTEN:
> > @@ -1389,7 +1390,7 @@ EXPORT_SYMBOL_GPL(iomap_seek_hole);
> >  
> >  static loff_t
> >  iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
> > -		      void *data, struct iomap *iomap)
> > +		      void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	switch (iomap->type) {
> >  	case IOMAP_HOLE:
> > @@ -1790,7 +1791,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> >  
> >  static loff_t
> >  iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> > -		void *data, struct iomap *iomap)
> > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_dio *dio = data;
> >  
> > @@ -2057,7 +2058,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
> >   * distinction between written and unwritten extents.
> >   */
> >  static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
> > -		loff_t count, void *data, struct iomap *iomap)
> > +		loff_t count, void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_swapfile_info *isi = data;
> >  	int error;
> > @@ -2161,7 +2162,7 @@ EXPORT_SYMBOL_GPL(iomap_swapfile_activate);
> >  
> >  static loff_t
> >  iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
> > -		void *data, struct iomap *iomap)
> > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	sector_t *bno = data, addr;
> >  
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 63d323916bba..6116a75f03da 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -925,7 +925,8 @@ xfs_file_iomap_begin(
> >  	loff_t			offset,
> >  	loff_t			length,
> >  	unsigned		flags,
> > -	struct iomap		*iomap)
> > +	struct iomap		*iomap,
> > +	struct iomap		*srcmap)
> >  {
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> > @@ -1148,7 +1149,8 @@ xfs_seek_iomap_begin(
> >  	loff_t			offset,
> >  	loff_t			length,
> >  	unsigned		flags,
> > -	struct iomap		*iomap)
> > +	struct iomap		*iomap,
> > +	struct iomap		*srcmap)
> >  {
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> > @@ -1234,7 +1236,8 @@ xfs_xattr_iomap_begin(
> >  	loff_t			offset,
> >  	loff_t			length,
> >  	unsigned		flags,
> > -	struct iomap		*iomap)
> > +	struct iomap		*iomap,
> > +	struct iomap		*srcmap)
> >  {
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 2103b94cb1bf..f49767c7fd83 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -25,6 +25,7 @@ struct vm_fault;
> >  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> >  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> >  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> > +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */
> >  
> >  /*
> >   * Flags for all iomap mappings:
> > @@ -102,7 +103,8 @@ struct iomap_ops {
> >  	 * The actual length is returned in iomap->length.
> >  	 */
> >  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> > -			unsigned flags, struct iomap *iomap);
> > +			unsigned flags, struct iomap *iomap,
> > +			struct iomap *srcmap);
> >  
> >  	/*
> >  	 * Commit and/or unreserve space previous allocated using iomap_begin.
> > -- 
> > 2.16.4
> > 

-- 
Goldwyn
