Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D407067F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEQMV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjEQMV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 08:21:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F28193
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 05:21:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6812768BEB; Wed, 17 May 2023 14:21:51 +0200 (CEST)
Date:   Wed, 17 May 2023 14:21:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/6] btrfs: use a linked list for tracking
 per-transaction/log dirty buffers
Message-ID: <20230517122150.GA17334@lst.de>
References: <20230515192256.29006-1-hch@lst.de> <20230515192256.29006-2-hch@lst.de> <CAL3q7H7k0fvvQVb5Eq3Uz61q6j1EnjxCVEeaaqu-o-JCL8K+7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7k0fvvQVb5Eq3Uz61q6j1EnjxCVEeaaqu-o-JCL8K+7Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 11:40:14AM +0100, Filipe Manana wrote:
> > This patch instead switches tracking to one linked list per transaction
> > and two to each root for the two tree logs which link a new object that
> > points directly to the buffer.  Note that the list_head can't directly be
> > embedded into the extent_buffer structure given that a buffer can be part
> > of more than one transaction or tree_log.  This also means the existing
> > error propagation based off eb->log_index never fully worked, as this
> > index would get overwritten once a buffer is added to a new dirty tree.
> 
> If an extent buffer is part of 2 transactions, it means that when it
> was allocated
> for the next one, it was already cleaned up in the previous one, so
> its ->log_index is
> no longer used by the previous transaction and can be safely
> overwritten by the next transaction.
> 
> Or did you find a case where that is not true?

At least with a previous version of this patch where the list_head was
embedded into the extent_buffer structure I could very easily reproduce
cases where one buffer was added to another list while still on another
one.  The most common case was a tree log and a transaction, but I think
I've also seen two transactions or two tree logs.

"Cleanup up" means written back and waited for writeback or dirty
canceled I guess? Or is there some other aspect I should look for?

> > @@ -202,7 +202,8 @@ struct btrfs_root {
> >         struct btrfs_root_item root_item;
> >         struct btrfs_key root_key;
> >         struct btrfs_fs_info *fs_info;
> > -       struct extent_io_tree dirty_log_pages;
> > +       struct list_head dirty_buffers[2];
> 
> As this is for the log tree, I'd prefer to have its name reflect that,
> like we had before.
> Something like "log_dirty_buffers" for example.

Ok.  Given that the btrfs_root structure isn't specific to log_trees
that absolutely makes sense.

> 1) With the io tree approach, if we allocate multiple extent buffers
> that are adjacent, we get a single entry to represent them, due the
> merging done by the io tree code.
> With this new approach we don't have any merging at all, using more
> memory and keeping a longer list, which will take longer to iterate
> and sort.

At least in theory yes.  But we also save a whole lot of lookups
by going directly to the object instead of indirecting through the
pages xarray and then again through the buffers array for the
sub-block case.

> For example if a 1G metadata block group is allocated, and then we
> allocate all metadata extents from it, we get 65536 struct
> dirty_buffer allocated, while with the io tree approach we would get a
> single struct extent_state record.

But that will only get you to the filemap_fdtawrite and fdatawait.
After that we're still looking up every single page in that range
while with this series (the patch alone isn't enough, the rest of
the work comes in later patches) the list gets us straight to the
extent_buffer.

> 2) We now need to keep references on the extent buffers. This means
> they can't be released from memory until the transaction commits.
> Before we didn't do this, and if an extent buffer was allocated and
> freed in the same transaction, we wouldn't need to keep it in memory
> until the transaction commits.
> We would not need to do it as well if its writeback is started and
> completed before the transaction commit.

True.  But at the same time it will allow to get rid of all the
extent_buffer_under_io hacks.  Note that if we figure out what
causes buffers to be added to multiple transactions/tree_logs and
just have a list in the object we could just deleted it when cleaned
and have the best of both worlds.

> 3) Looking a bit below, we now need to sort the list, which can be
> huge, especially taking into account the fact that adjacent extents
> are not merged anymore as mentioned before, potentially making anyone
> who's waiting on the transaction commit to wait for longer.
> On the other end, when a task allocates a new buffer the insertion is
> faster, as it's just appending to a list and can reduce the latency of
> many syscalls (creat, mkdir, rmdir, rename, link/unlink, reflinks,
> etc)
> 
> Not saying that in the end this approach isn't often or generally
> better, but at the very least I would like to see all these
> differences explicitly mentioned in the changelog.
> The changelog gives the impression that there are no tradeoffs and the
> new solution is better in every aspect.
> 
> I would say more tests/benchmarks results would be good to have too,
> other than just fs_mark, and have the tests mentioned in the changelog
> (results before and after this change, command lines, fio configs for
> example).

Do you have any particular workload you think would be useful to test?
