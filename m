Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF028B4641
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 06:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfIQETM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 17 Sep 2019 00:19:12 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47496 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726660AbfIQETM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 00:19:12 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 87E2C42C8DE; Tue, 17 Sep 2019 00:19:11 -0400 (EDT)
Date:   Tue, 17 Sep 2019 00:19:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190917041911.GE24379@hungrycats.org>
References: <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
 <20190914005655.GH22121@hungrycats.org>
 <20190913215038.Horde.gsxNyK9aSRLm6Qsl5sUNhf0@server53.web-hosting.com>
 <20190914044219.GL22121@hungrycats.org>
 <20190915135407.Horde.qqs07Bais-BPrjIVxyrrIfo@server53.web-hosting.com>
 <20190916225126.GB24379@hungrycats.org>
 <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 09:03:17PM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > Reflinks are the forward references--there is no other kind of forward
> > reference in btrfs (contrast with other filesystems which use one data
> > structure for single references and another for multiple references).
> > 
> > There are two distinct objects with similar names:  extent data items,
> > and extent ref items.
> > 
> > A file consists of an inode item followed by extent ref items (aka
> > reflinks) in a subvol tree keyed by (inode, offset) pairs.  Subvol tree
> > pages can be shared with other subvol trees to make snapshots.
> 
> Ok, so a reflink contains a virtual address. Did I get that right?

Virtual address of the extent (i.e. the beginning of the original contiguous
write) plus offset and length within the extent.  This allows an extent ref
to reference part of an extent.

> All extent ref items are reflinks which contain a 4 KB aligned address
> because the extents have that same alignment. Did I get that right?
> 
> Virtual addresses are 8-bytes in size?

The addresses are 8 bytes.  There's an offset and length in the ref which
IIRC are 4 bytes each (extents have several limits on their size, all below
2GB).  For compressed extents there's also a decompressed length.

> I hope that virtual addresses are not wasteful of address space (that is,
> many top bits in an 8 bit virtual address are all zero).

Block groups that are deleted are never reissued the same virtual address,
though I know of no reason they couldn't be.

> > Extent data items are stored in a single tree (with other trees using
> > the same keys) that just lists which parts of the filesystem are occupied,
> > how long they are, and what data/metadata they contain.  Each extent
> > item contains a list of references to one of four kinds of object that
> > refers to the extent item (aka backrefs).  The free space tree is the
> > inverse of the extent data tree.
> 
> Ok, so there is an "extent tree" keyed by virtual addresses. Items there
> contain extent data.
> 
> But, how are nodes in this extent tree addressed (how do you travel from the
> parent to the child)? I guess by full virtual address, i.e. by a reflink,
> but this reflink can point within-extent, meaning its address is not 4 KB
> aligned.

Metadata items are also stored in extents.  There's a device tree to bootstrap.

End addresses of extent refs can be not 4K-aligned (i.e. the trailing
bytes at EOF).  All other addresses must be 4K-aligned.

> Or, an alternative explanation:
> each whole metadata extent is a single node. Each node is often half-full to
> allow for various tree operations to be performed. Due to there being many
> items per each node, there is additional CPU processing effort required when
> updating a node.
> 
> > Each extent ref item is a reference to an extent data item, but it
> > also contains all the information required to access the data.  For
> > normal read operations the extent data tree can be ignored (though
> > you still need to do a lookup in the csum tree to verify csums.
> 
> So, for normal reads, the information in subvol tree is sufficient.
> 
> > > So, you are saying that backrefs are already in the extent tree (or
> > > reachable from it). I didn't know that, that information makes my defrag
> > > much simpler to implement and describe. Someone in this thread has
> > > previously mislead me to believe that backref information is not easily
> > > available.
> > 
> > The backref isn't a precise location--it just tells you which metadata
> > blocks are holding at least one reference to the extent.  Some CPU
> > and linear searching has to be done to resolve that fully to an (inode,
> > offset) pair in the subvol tree(s).  It's a tradeoff to make normal POSIX
> > go faster, because you don't need to update the extent tree again when
> > you do some operations on the forward ref side, even though they add or
> > remove references.  e.g. creating a snapshot does not change the backrefs
> > list on individual extents--it creates two roots sharing a subset of the
> > subvol trees' branches.
> 
> This reads like a mayor fu**** to me.
> 
> I don't get it. If a backref doesn't point to an exact item, than CPU has to
> scan the entire 16 KB metadata extent to find the matching reflink. However,
> this would imply that all the items in a metadata extent are always valid
> (not stale from older versions of metadata). This then implies that, when an
> item of a metadata extent is updated, all the parents of all the items in
> the same extent have to be updated. Now, that would be such a waste,
> wouldn't it? Especially if the metadata extent is allowed to contain stale
> items.

All parents are updated in all trees that are updated.  It's the
wandering-trees filesystem.  The extent tree gets a _lot_ of updates,
because its items do change for every new subvol item that is created
or deleted.

But you're getting into the depths I'm not clear on.  There are 4 kinds of
parent node (or 4 branches in the case statement that follows backrefs).
Some of them (like snapshot leaf nodes) are very static, not changing
without creating new nodes all the way up to the top of a subvol tree.
Others refer fairly directly and specifically to a (subvol, inode, offset)
tuple.

> An alternative explanation: all the b-trees have 16 KB nodes, where each
> node matches a metadata extent. Therefore, the entire node has a single
> parent in a particular tree.
> 
> This means all virtual addresses are always 4 K aligned, furthermore, all
> virtual addresses that point to metadata extents are 16 K aligned.
> 
> 16 KB is a pretty big for a tree node. I wonder why was this size selected
> vs. 4 KB nodes? But, it doesn't matter.

Probably due to a performance benchmark someone ran around 2007-2009...?

It is useful for subvol trees where small files (2K or less after
compression) are stored inline.

> > > > 	- csum tree:  location, 1 or more 4-byte csums packed in an array.
> > > > 	Length of item is number of extent data blocks * 4 bytes plus a
> > > > 	168-bit header (ish...csums from adjacent extents may be packed
> > > > 	using a shared header)
> > > >
> > > > 	- free space tree:  location, size of free space.  This appears
> > > > 	when the extent is deleted.  It may be merged with adjacent
> > > > 	records.  Length is maybe 20 bytes?
> > > >
> > > > Each page contains a few hundred items, so if there are a few hundred
> > > > unrelated extents between extents in the log file, each log file extent
> > > > gets its own metadata page in each tree.
> > > 
> > > As far as I can understand it, the extents in the extent tree are indexed
> > > (keyed) by inode&offset. Therefore, no matter how many unrelated extents
> > > there are between (physical locations of data) extents in the log file, the
> > > log file extent tree entries will (generally speaking) be localized, because
> > > multiple extent entries (extent items) are bunched tohgether in one 16 KB
> > > metadata extent node.
> > 
> > No, extents in the extent tree are indexed by virtual address (roughly the
> > same as physical address over small scales, let's leave the device tree
> > out of it for now).  The subvol trees are organized the way you are
> > thinking of.
> 
> So, I guess that the virtual-to-physical address translation tables are
> always loaded in memory and that this translation is very fast? And the
> translation in the opposite direction, too.

Block groups typically consist of 1GB chunks from each disk, so the
maximum number of block groups is typically total disk size / 1GB.
(It's possible to create smaller chunks if you do a lot of small
incrementing resizes but nobody does that).  So a 45TB filesystem might
have a 3.5MB translation btree.

Translation in the other direction is rare--everything in btrfs uses the virtual
addresses.  IO error reports do the reverse transformation to turn it into a
(device id, sector) pair...that's the only use case I can think of.  Well,
I guess the block group allocator must deal with block addresses too.

> Anyway, thanks for explaining this all to me, makes it all much more clear.
> 
> 
> 
