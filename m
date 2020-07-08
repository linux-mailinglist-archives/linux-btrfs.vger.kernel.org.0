Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594C72189C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgGHOFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:05:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgGHOFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 10:05:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91CF3ACF2;
        Wed,  8 Jul 2020 14:05:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6E36DA818; Wed,  8 Jul 2020 16:04:55 +0200 (CEST)
Date:   Wed, 8 Jul 2020 16:04:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Robbie Ko <robbieko@synology.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
Message-ID: <20200708140455.GA28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Robbie Ko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
 <3b3f9eb4-96ef-d039-5d86-a4c165e6d993@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b3f9eb4-96ef-d039-5d86-a4c165e6d993@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 10:19:22AM +0800, Robbie Ko wrote:
> David Sterba 於 2020/7/8 上午3:25 寫道:
> > On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
> >> From: Robbie Ko <robbieko@synology.com>
> >>
> >> When mounting, we always need to read the whole chunk tree,
> >> when there are too many chunk items, most of the time is
> >> spent on btrfs_read_chunk_tree, because we only read one
> >> leaf at a time.
> >>
> >> It is unreasonable to limit the readahead mechanism to a
> >> range of 64k, so we have removed that limit.
> >>
> >> In addition we added reada_maximum_size to customize the
> >> size of the pre-reader, The default is 64k to maintain the
> >> original behavior.
> >>
> >> So we fix this by used readahead mechanism, and set readahead
> >> max size to ULLONG_MAX which reads all the leaves after the
> >> key in the node when reading a level 1 node.
> > The readahead of chunk tree is a special case as we know we will need
> > the whole tree, in all other cases the search readahead needs is
> > supposed to read only one leaf.
> 
> If, in most cases, readahead requires that only one leaf be read, then
> reada_ maximum_size should be nodesize instead of 64k, or use
> reada_maximum_ nr (default:1) seems better.
> 
> >
> > For that reason I don't want to touch the current path readahead logic
> > at all and do the chunk tree readahead in one go instead of the
> > per-search.
> 
> I don't know why we don't make the change to readahead, because the current
> readahead is limited to the logical address in 64k is very unreasonable,
> and there is a good chance that the logical address of the next leaf 
> node will
> not appear in 64k, so the existing readahead is almost useless.

I see and it seems that the assumption about layout and chances
succesfuly read blocks ahead is not valid. The logic of readahead could
be improved but that would need more performance evaluation.

> > Also I don't like to see size increase of btrfs_path just to use the
> > custom once.
> 
> This variable is the parameter that controls the speed of the readahead,
> and I think it should be adjustable, not the hard code in the readahead 
> function.

Yes, but it takes 8 bytes and stays constant that does not even need 8
bytes.

I just don't want to touch the generic readahead logic that is started
by b-tree search because that would affect all workloads, while your're
interested in speeding up the chunk tree load.

> In the future, more scenarios will be available.
> For example, BGTREE. will be improved significantly faster,
> My own tests have improved the speed by almost 500%.
> Reference: https://lwn.net/Articles/801990 /

The optimized block group items whould be a huge win even without the
readahead but that's a different problem.

> > The idea of the whole tree readahead is to do something like:
> >
> > - find first item
> > - start readahead on all leaves from its level 1 node parent
> >    (readahead_tree_block)
> > - when the level 1 parent changes during iterating items, start the
> >    readahead again
> >
> > This skips readahead of all nodes above level 1, if you find a nicer way
> > to readahead the whole tree I won't object, but for the first
> > implementation the level 1 seems ok to me.
> >
> >> I have a test environment as follows:
> >>
> >> 200TB btrfs volume: used 192TB
> >>
> >> Data, single: total=192.00TiB, used=192.00TiB
> >> System, DUP: total=40.00MiB, used=19.91MiB
> > Can you please check what's the chunk tree height? 'btrfs inspect
> > tree-stats' prints that but it takes long as needs to go through the
> > whole metadata, so extracting it from 'btrfs inspect dump-tree -c chunk'
> > would be faster. Thanks.
> Chunk tree height 3, level (0-2)

Thanks.
