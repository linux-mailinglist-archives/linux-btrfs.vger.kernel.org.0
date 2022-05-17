Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2743B529E31
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiEQJj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 05:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244034AbiEQJjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 05:39:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3B44764
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 02:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E649CE1921
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 09:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F16C385B8;
        Tue, 17 May 2022 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652780349;
        bh=IetfwoJAa5dFj/fa3rJEobAqr40By5NNuuczGU5V19A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYB4+nJx1NOTo2OyR1nxv+X3fVEboXmn2ZUwd7B9VJmFm+t+NtAS8aE3OK3MYCbEB
         iZ7Wrah6osod389FiQsrWEhE5NL+joPskuhnYrZ2CDRpRqXav/DhYoWch7/nPc5KiF
         Y2gNA6PXYmqGZLpDTrJmYEyBpQ6+EwCjloE0tGS5omhFDvyRZ5gQYpKWdey1f9fEQ9
         RZkvb0nOLS/GV6L7uQhZeYXKmruolBZCib9wKvjG2Oj+vRL5H8fn1dWHPy4sO6Q/Dp
         nK1nt4Q4OZRH2p233ihdF7dDd0hUjUpnIdFuEH3gBep7IhLdbAXEBlTtv9nklVOJcJ
         SQRj36SjMq4kg==
Date:   Tue, 17 May 2022 10:39:06 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: send: avoid trashing the page cache
Message-ID: <20220517093906.GA2606208@falcondesktop>
References: <cover.1651770555.git.fdmanana@suse.com>
 <41782eb393b3a3ba47f4a7fce1cbb33433c3f994.1651770555.git.fdmanana@suse.com>
 <50994099-b70e-8307-dd41-ac88784e552c@gmx.com>
 <8ded3794-1a2e-605e-e01a-6c2ecbab1b7e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ded3794-1a2e-605e-e01a-6c2ecbab1b7e@gmx.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 03:26:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/5/17 14:35, Qu Wenruo wrote:
> > 
> > 
> > On 2022/5/6 01:16, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > A send operation reads extent data using the buffered IO path for getting
> > > extent data to send in write commands and this is both because it's
> > > simple
> > > and to make use of the generic readahead infrastructure, which results in
> > > a massive speedup.
> > > 
> > > However this fills the page cache with data that, most of the time, is
> > > really only used by the send operation - once the write commands are
> > > sent,
> > > it's not useful to have the data in the page cache anymore. For large
> > > snapshots, bringing all data into the page cache eventually leads to the
> > > need to evict other data from the page cache that may be more useful for
> > > applications (and kernel susbsystems).
> > > 
> > > Even if extents are shared with the subvolume on which a snapshot is
> > > based
> > > on and the data is currently on the page cache due to being read through
> > > the subvolume, attempting to read the data through the snapshot will
> > > always result in bringing a new copy of the data into another location in
> > > the page cache (there's currently no shared memory for shared extents).
> > > 
> > > So make send evict the data it has read before if when it first opened
> > > the inode, its mapping had no pages currently loaded: when
> > > inode->i_mapping->nr_pages has a value of 0. Do this instead of deciding
> > > based on the return value of filemap_range_has_page() before reading an
> > > extent because the generic readahead mechanism may read pages beyond the
> > > range we request (and it very often does it), which means a call to
> > > filemap_range_has_page() will return true due to the readahead that was
> > > triggered when processing a previous extent - we don't have a simple way
> > > to distinguish this case from the case where the data was brought into
> > > the page cache through someone else. So checking for the mapping number
> > > of pages being 0 when we first open the inode is simple, cheap and it
> > > generally accomplishes the goal of not trashing the page cache - the
> > > only exception is if part of data was previously loaded into the page
> > > cache through the snapshot by some other process, in that case we end
> > > up not evicting any data send brings into the page cache, just like
> > > before this change - but that however is not the common case.
> > > 
> > > Example scenario, on a box with 32G of RAM:
> > > 
> > >    $ btrfs subvolume create /mnt/sv1
> > >    $ xfs_io -f -c "pwrite 0 4G" /mnt/sv1/file1
> > > 
> > >    $ btrfs subvolume snapshot -r /mnt/sv1 /mnt/snap1
> > > 
> > >    $ free -m
> > >                   total        used        free      shared
> > > buff/cache   available
> > >    Mem:           31937         186       26866           0
> > > 4883       31297
> > >    Swap:           8188           0        8188
> > > 
> > >    # After this we get less 4G of free memory.
> > >    $ btrfs send /mnt/snap1 >/dev/null
> > > 
> > >    $ free -m
> > >                   total        used        free      shared
> > > buff/cache   available
> > >    Mem:           31937         186       22814           0
> > > 8935       31297
> > >    Swap:           8188           0        8188
> > > 
> > > The same, obviously, applies to an incremental send.
> > > 
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > 
> > Unfortunately, this patch seems to cause subpage cases to fail test case
> > btrfs/007, the reproducibility is around 50%, thus better "-I 8" to be
> > extra safe.
> > 
> > And I believe it also causes other send related failure for subpage cases.
> > 
> > I guess it's truncate_inode_pages_range() only truncating the full page,
> > but for subpage case, since one sector is smaller than one page, it
> > doesn't work as expected?
> 
> It looks like that's the case.
> 
> The following diff fixed the send related bugs here:
> (mail client seems to screw up the indent)
> 
> https://paste.opensuse.org/95871661

That may seem to work often, but it's not really correct because prev_extent_end
is already aligned to the page size, except possibly for the first extent processed.

For the case of the first processed extent not starting at an offset that is page
size aligned, we also need to round down that offset so that we evict the page
(and not simply zero out part of its content).

Can you try this instead:  https://pastebin.com/raw/kRPZKYxG ?

Thanks.


> 
> Thanks,
> Qu
> > 
> > If needed, I can provide you the access to my aarch64 vm for debugging.
> > 
> > Thanks,
> > Qu
> > 
> > > ---
> > >   fs/btrfs/send.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 77 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > > index 55275ba90cb4..d899049dea53 100644
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -137,6 +137,8 @@ struct send_ctx {
> > >        */
> > >       struct inode *cur_inode;
> > >       struct file_ra_state ra;
> > > +    u64 prev_extent_end;
> > > +    bool clean_page_cache;
> > > 
> > >       /*
> > >        * We process inodes by their increasing order, so if before an
> > > @@ -5157,6 +5159,28 @@ static int send_extent_data(struct send_ctx *sctx,
> > >           }
> > >           memset(&sctx->ra, 0, sizeof(struct file_ra_state));
> > >           file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
> > > +
> > > +        /*
> > > +         * It's very likely there are no pages from this inode in
> > > the page
> > > +         * cache, so after reading extents and sending their data,
> > > we clean
> > > +         * the page cache to avoid trashing the page cache (adding
> > > pressure
> > > +         * to the page cache and forcing eviction of other data
> > > more useful
> > > +         * for applications).
> > > +         *
> > > +         * We decide if we should clean the page cache simply by
> > > checking
> > > +         * if the inode's mapping nrpages is 0 when we first open
> > > it, and
> > > +         * not by using something like filemap_range_has_page() before
> > > +         * reading an extent because when we ask the readahead code to
> > > +         * read a given file range, it may (and almost always does) read
> > > +         * pages from beyond that range (see the documentation for
> > > +         * page_cache_sync_readahead()), so it would not be reliable,
> > > +         * because after reading the first extent future calls to
> > > +         * filemap_range_has_page() would return true because the
> > > readahead
> > > +         * on the previous extent resulted in reading pages of the
> > > current
> > > +         * extent as well.
> > > +         */
> > > +        sctx->clean_page_cache =
> > > (sctx->cur_inode->i_mapping->nrpages == 0);
> > > +        sctx->prev_extent_end = offset;
> > >       }
> > > 
> > >       while (sent < len) {
> > > @@ -5168,6 +5192,33 @@ static int send_extent_data(struct send_ctx *sctx,
> > >               return ret;
> > >           sent += size;
> > >       }
> > > +
> > > +    if (sctx->clean_page_cache) {
> > > +        const u64 end = round_up(offset + len, PAGE_SIZE);
> > > +
> > > +        /*
> > > +         * Always start from the end offset of the last processed
> > > extent.
> > > +         * This is because the readahead code may (and very often does)
> > > +         * reads pages beyond the range we request for readahead. So if
> > > +         * we have an extent layout like this:
> > > +         *
> > > +         *            [ extent A ] [ extent B ] [ extent C ]
> > > +         *
> > > +         * When we ask page_cache_sync_readahead() to read extent A, it
> > > +         * may also trigger reads for pages of extent B. If we are doing
> > > +         * an incremental send and extent B has not changed between the
> > > +         * parent and send snapshots, some or all of its pages may end
> > > +         * up being read and placed in the page cache. So when
> > > truncating
> > > +         * the page cache we always start from the end offset of the
> > > +         * previously processed extent up to the end of the current
> > > +         * extent.
> > > +         */
> > > +        truncate_inode_pages_range(&sctx->cur_inode->i_data,
> > > +                       sctx->prev_extent_end,
> > > +                       end - 1);
> > > +        sctx->prev_extent_end = end;
> > > +    }
> > > +
> > >       return 0;
> > >   }
> > > 
> > > @@ -6172,6 +6223,30 @@ static int btrfs_unlink_all_paths(struct
> > > send_ctx *sctx)
> > >       return ret;
> > >   }
> > > 
> > > +static void close_current_inode(struct send_ctx *sctx)
> > > +{
> > > +    u64 i_size;
> > > +
> > > +    if (sctx->cur_inode == NULL)
> > > +        return;
> > > +
> > > +    i_size = i_size_read(sctx->cur_inode);
> > > +
> > > +    /*
> > > +     * If we are doing an incremental send, we may have extents
> > > between the
> > > +     * last processed extent and the i_size that have not been processed
> > > +     * because they haven't changed but we may have read some of
> > > their pages
> > > +     * through readahead, see the comments at send_extent_data().
> > > +     */
> > > +    if (sctx->clean_page_cache && sctx->prev_extent_end < i_size)
> > > +        truncate_inode_pages_range(&sctx->cur_inode->i_data,
> > > +                       sctx->prev_extent_end,
> > > +                       round_up(i_size, PAGE_SIZE) - 1);
> > > +
> > > +    iput(sctx->cur_inode);
> > > +    sctx->cur_inode = NULL;
> > > +}
> > > +
> > >   static int changed_inode(struct send_ctx *sctx,
> > >                enum btrfs_compare_tree_result result)
> > >   {
> > > @@ -6182,8 +6257,7 @@ static int changed_inode(struct send_ctx *sctx,
> > >       u64 left_gen = 0;
> > >       u64 right_gen = 0;
> > > 
> > > -    iput(sctx->cur_inode);
> > > -    sctx->cur_inode = NULL;
> > > +    close_current_inode(sctx);
> > > 
> > >       sctx->cur_ino = key->objectid;
> > >       sctx->cur_inode_new_gen = 0;
> > > @@ -7671,7 +7745,7 @@ long btrfs_ioctl_send(struct inode *inode,
> > > struct btrfs_ioctl_send_args *arg)
> > > 
> > >           name_cache_free(sctx);
> > > 
> > > -        iput(sctx->cur_inode);
> > > +        close_current_inode(sctx);
> > > 
> > >           kfree(sctx);
> > >       }
