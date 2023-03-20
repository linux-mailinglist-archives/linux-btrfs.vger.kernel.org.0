Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD86C0A62
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 07:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCTGMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 02:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCTGMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 02:12:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF11CBE4
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 23:12:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2145968AFE; Mon, 20 Mar 2023 07:12:07 +0100 (CET)
Date:   Mon, 20 Mar 2023 07:12:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Message-ID: <20230320061206.GB18708@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-2-hch@lst.de> <20230316173134.GC10580@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316173134.GC10580@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 16, 2023 at 06:31:34PM +0100, David Sterba wrote:
> On Tue, Mar 14, 2023 at 05:59:01PM +0100, Christoph Hellwig wrote:
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -1632,8 +1632,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
> >  	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
> >  	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
> >  	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
> > -	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
> > -	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
> 
> I haven't noticed in the past workque patches but here we lose the
> connection of mount option thread_pool and max_active per workqueue.

Looking at the code in detail, We do, but for the freespace-write workqueue
only.

endio-write passes 2 as the thresh argument to btrfs_alloc_workqueue,
which is below DFT_THRESHOLD and thus all the max active tracking is
disabled.

Which makes sense to me - the max_active tracking is fairly expensive,
and the cost of more active items in the workqueue code is non-existant
until they are actually used.

The history here is a bit weird, the initial version of
endio_freespace_worker was added by Josef in commit 0cb59c995317
("Btrfs: write out free space cache").  This was back in the day of the
old btrfs workers, that weren't using workqueues at all, and the
new freespace workers passed in a thread_pool_size of 1, instead
of fs_info->thread_pool_size used for the normal endio workers.

Qu then replaced the btrfs_workers with the btrfs_workqueue in commit
fccb5d86d8f5 ("btrfs: Replace fs_info->endio_* workqueue with btrfs_workqueue.")
which stopped looking at the thread_pool_size for both of them,
passing down the thread_pool_size (as the max_active local variable)
to both, then limits thresh to 2 for end-io-writes, but to the default
using 0 for the free-space write workqueue, which seems like a big
change to the original behavior, without much of an explanation in the
commit log.

So as far as I can tell this change (accidentally) restores behavior
that is closer, but not identical, to the 2014 behaviour and very
sesible, but it needs to be documented way better or even be split
into a prep patch.

This little exercise also makes me wonder what the point of the
threshold tracking in the btrfs-workqueue is to start with.  I think
the original idea based on some of the commit logs is to be able
to set a higher max_active than the workqueue default using
workqueue_set_max_active for HDD workloads using the thread_pool
mount option.  But given that a higher max_active in the workqueue
code has not extra resource cost until the additional workers are
created on demand, I think just wiring up workqueue_set_max_active to
btrfs_workqueue_set_max is a much better option than the separate
tracking that duplicates the core workqueue functionality.  But that
is left for another series..
