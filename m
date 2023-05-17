Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5F706E4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEQQiA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjEQQh7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 12:37:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6493C8
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 09:37:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8865F68B05; Wed, 17 May 2023 18:37:48 +0200 (CEST)
Date:   Wed, 17 May 2023 18:37:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/6] btrfs: use a linked list for tracking
 per-transaction/log dirty buffers
Message-ID: <20230517163748.GA5784@lst.de>
References: <20230515192256.29006-1-hch@lst.de> <20230515192256.29006-2-hch@lst.de> <CAL3q7H7k0fvvQVb5Eq3Uz61q6j1EnjxCVEeaaqu-o-JCL8K+7Q@mail.gmail.com> <20230517122150.GA17334@lst.de> <CAL3q7H6E6kUsqpVEaRqc=WRHatborKE+mG3BauNyYD+2Jc+O3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6E6kUsqpVEaRqc=WRHatborKE+mG3BauNyYD+2Jc+O3A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 05:24:59PM +0100, Filipe Manana wrote:
> Probably what you ran into is the case where a tree block is allocated
> and freed in the same transaction before being written, in that case
> it gets added
> back to the free space cache (this happens at btrfs_free_tree_block())
> and can be allocated again in the same transaction.
> If so, in that case you can remove it from the list and you shouldn't
> run into that issue anymore.
> We currently don't remove it from the io tree in that case, because
> that may need splitting an existing extent state record and therefore
> requiring allocating memory.

Yes.  I did in fact run into exactly that when I resurrected the
old idea of the embedded list_head and add a lot of instrumentation.
With the list removal in btrfs_clear_buffer_dirty it works fine.

> > At least in theory yes.  But we also save a whole lot of lookups
> > by going directly to the object instead of indirecting through the
> > pages xarray and then again through the buffers array for the
> > sub-block case.
> 
> I think you are talking about further changes in the patchset, not
> about this particular patch?

Yes.  This one is the enabler.

> I'm talking about the data structure used to represent a range, not pages.
> The io tree is good to merge adjacent ranges and reduce the total
> structure size and used memory

Yes.  Assuming you actually want to track ranges.  But that's now
what we ultimatively want to track here, though.  In the end everything
is about the actual buffers.  Patches 3 and 6 are the other key ones
that completely removed the need for any ranges.  I've tried to keep
them separate as Dave tends to prefer split out patches, but maybe
I should just fold them back to make it more obvious what is going on
here.

> fs_mark (as you did already), dbench, fio for random writes and periodic fsync,
> anything that is not too short, runtimes of several minutes at least.

Ok.  If you have any particular workloads you care about and have
scripts for them, feel free to send them my way.
