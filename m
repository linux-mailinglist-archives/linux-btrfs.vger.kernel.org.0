Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64434F5846
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiDFJBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445730AbiDFI4V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 04:56:21 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 602AB3AA72
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:40:56 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 274F12AF1E7; Tue,  5 Apr 2022 21:40:51 -0400 (EDT)
Date:   Tue, 5 Apr 2022 21:40:51 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <Ykzvoz47Rvknw7aH@hungrycats.org>
References: <20220405181108.GA28707@merlins.org>
 <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406000844.GK28707@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 05:08:44PM -0700, Marc MERLIN wrote:
> On Tue, Apr 05, 2022 at 07:51:29PM -0400, Zygo Blaxell wrote:
> > Other possibilites include irreproducible reads coming from the bcache
> > layer if that's still active (e.g. if it was on mdadm raid1, and the
> 
> bcache is still active, correct.
> mdadm5 array is running with 4 drives out of 5.
> 
> I'm not sure if I full understand the tree root issue we've been having.

Based on the history, I'd expect the filesystem is missing some number
of tree nodes, from a few dozen to thousands, depending on how many
writes were dropped after the 2nd drive failure before it was detected.
Since the array was also degraded at that time, with 4 drives in raid5,
there's 3 data drives, and if one of them was offline then we'd have a 2/3
success rate reading metadata blocks and 1/3 garbage.  That's definitely
in the "we need to write new software to recover from this" territory.

Normally, I'd expect that once we dig through a few layers of simple
dropped write blocks, we'll start hitting metadata pages with bad csums
and trashed contents, since the parity blocks will be garbage in the raid5
stripes where the writes were lost.  One important data point against
this theory is that we have not seen a csum failure yet, so maybe this
is a different (possibly better) scenario.  Possibly some of the lost
writes on the raid5 are still stored in the bcache, so there's few or no
garbage blocks (though reading the array through the cache might evict
the last copy of usable data and make some damage permanent--you might
want to make a backup copy of the cache device).

Backup roots only work if writes are dropped only in the most recent
transaction, maybe two, because only these trees are guaranteed to be
intact on disk.  After that, previously occupied pages are fair game
for new write allocations, and old metadata will be lost.  Unlike other
filesystems, btrfs never writes metadata in the same place twice, so when
a write is dropped, there isn't an old copy of the data still available at
the location of the dropped write--that location contains some completely
unrelated piece of the metadata tree whose current version now lives
at some other location.  Later tree updates will overwrite old copies
of the updated page, destroying the data in the affected page forever.
Essentially there will be a set of metadata pages where you have two
versions of different ages, and another set of metadata pages where you
have zero versions, and (hopefully) most of the other pages are intact.

> We know from the dump that we have these backups
> backup_tree_root:       13577814573056  gen: 1602089    level: 1
> backup_tree_root:       13577775284224  gen: 1602086    level: 1
> backup_tree_root:       13577821667328  gen: 1602087    level: 1
> backup_tree_root:       13577779511296  gen: 1602088    level: 1
> 
> but they didn't seem to work, or are we sure that none of them don't?

The root pointers are just pointers--having a pointer to a tree root isn't
going to help if the trees were never written at the referenced location.
Recursively, if you have a tree node but you don't have the next-level
nodes the previous-level node points to, then the root isn't useful
because large parts of its tree are unreachable.  If you're missing a
leaf node then whatever data was in the leaf is gone.  Once you've found
a root node, you can try walking over the entire tree to see if it's all
there (e.g. with btrfs ins dump-tree -t N), but if anything's missing
in any part of the tree, then that tree root can't be used as-is.

> Then we did a custom scan, but it found one of the 4 backup_tree_root we
> already had, so that doesn't help, correct?
> Found tree root at 13577814573056 gen 1602089 level 1
> 
> Was the expectation that there are more backup_tree_root hiding
> somewhere and we've been trying to find them?

If we have a superblock, the chunk tree, and a subvol tree, we can
drop all the other trees and rebuild them (bonus points if the csum
tree survived, then we can verify all the data was recovered correctly;
otherwise, we can read all the files and make a new csum tree but it won't
detect any data corruption that might have happened in degraded mode).
This is roughly what 'btrfs check --init-extent-tree' does (though due
to implementation details it has a few extra dependencies that might
get in the way) and you can find subvol roots with btrfs-find-root.

If we don't have any intact subvol trees (or the subvol trees we really
want aren't intact), then we can't recover this way.  Instead we'd have
to scrape the disk looking for metadata leaf nodes, and try to reinsert
those into a new tree structure.  The trick here is that we'll have the
duplicated and inconsitent nodes and we won't have some nodes at all,
and we'll have to make sense of those (or pass it to the existing btrfs
check and hope it can cope with them).  I'm guessing that a simplified
version of this is what Josef is building at this point, or will be
building soon if we aren't extremely lucky and find an intact subvol tree.
After building an intact subvol tree (even with a few garbage items in it
as long as check can handle them) we can go back to the --init-extent-tree
step and rebuild the rest of the filesystem.

> Thanks,
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/  
> 
