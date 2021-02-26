Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD432671B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 19:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBZSrx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 13:47:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:56940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhBZSro (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 13:47:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60EC6AAAE
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 18:47:02 +0000 (UTC)
Date:   Fri, 26 Feb 2021 12:47:20 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Remove force argument from run_delalloc_nocow()
Message-ID: <20210226184720.7ul23jknjth4h6j2@fiona>
References: <20210225205822.mgx5ei3tzcqmlts6@fiona>
 <20210226171421.GO7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226171421.GO7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18:14 26/02, David Sterba wrote:
> On Thu, Feb 25, 2021 at 02:58:22PM -0600, Goldwyn Rodrigues wrote:
> > force_nocow can be calculated by btrfs_inode and does not need to be
> > passed as an argument.
> > 
> > This simplifies run_delalloc_nocow() call from btrfs_run_delalloc_range()
> > since the decision whether the extent is cow'd or not can be derived
> > from need_force_cow(). Since BTRFS_INODE_NODATACOW and
> > BTRFS_INODE_PREALLOC flags are checked in need_force_cow(), there is
> > no need to check it again.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Change since v1:
> >  - Kept need_force_cow() as it is
> 
> Added to misc-next, thanks.
> 
> > ---
> >  fs/btrfs/inode.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 4f2f1e932751..e5dd8d7ef0c8 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1516,7 +1516,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
> >  static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
> >  				       struct page *locked_page,
> >  				       const u64 start, const u64 end,
> > -				       int *page_started, int force,
> > +				       int *page_started,
> >  				       unsigned long *nr_written)
> >  {
> >  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > @@ -1530,6 +1530,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
> >  	u64 ino = btrfs_ino(inode);
> >  	bool nocow = false;
> >  	u64 disk_bytenr = 0;
> > +	bool force = inode->flags & BTRFS_INODE_NODATACOW;
> >  
> >  	path = btrfs_alloc_path();
> >  	if (!path) {
> > @@ -1891,17 +1892,12 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
> >  		struct writeback_control *wbc)
> >  {
> >  	int ret;
> > -	int force_cow = need_force_cow(inode, start, end);
> >  	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
> >  
> > -	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
> > +	if (!need_force_cow(inode, start, end)) {
> 
> We may want to reverse the logic and naming so it says
> 'need_force_nocow', right now it's "we don't need to force COW, so let's
> do NOCOW", because COW is the default and the condition should pick the
> exceptional case.

Calling it need_force_nocow() or should_nocow() will result in the same
concept as previous patch where EXTENT_DEFRAG range would need to be
checked before checking inode flags BTRFS_INODE_NODATACOW and
BTRFS_INODE_PREALLOC. That's because EXTENT_DEFRAG in range
should result in a COW sequence immaterial of what CoW sequence the
inode flags say. Isn't it?

Maybe something like this would keep inode flags checks earlier than
test_range_bit():

static inline bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
{
        if (inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)) {
                if (inode->defrag_bytes &&
                    test_range_bit(&inode->io_tree, start, end, EXTENT_DEFRAG, 0, NULL))
                        return false;
                return true;
        }
        return false;
}



> 
> >  		ASSERT(!zoned);
> >  		ret = run_delalloc_nocow(inode, locked_page, start, end,
> > -					 page_started, 1, nr_written);
> > -	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
> > -		ASSERT(!zoned);
> > -		ret = run_delalloc_nocow(inode, locked_page, start, end,
> > -					 page_started, 0, nr_written);
> > +					 page_started, nr_written);
> >  	} else if (!inode_can_compress(inode) ||
> >  		   !inode_need_compress(inode, start, end)) {
> >  		if (zoned)

-- 
Goldwyn
