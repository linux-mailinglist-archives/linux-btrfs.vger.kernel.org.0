Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA5421CF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 05:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJED2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 23:28:14 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37270 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJED2N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 23:28:13 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 29AC4BA76DA; Mon,  4 Oct 2021 23:26:21 -0400 (EDT)
Date:   Mon, 4 Oct 2021 23:26:21 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Matthew Warren <matthewwarren101010@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: Changing the checksum algorithm on an existing BTRFS filesystem
Message-ID: <20211005032621.GQ29026@hungrycats.org>
References: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
 <20211004095146.GU9286@twin.jikos.cz>
 <CA+H1V9yopc2okgT=5XeCwvHF8oXPVhnojaf_rZOeuiThZEfqWQ@mail.gmail.com>
 <d2e7dd3d-5cbf-287f-893c-bed3e6219d0a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e7dd3d-5cbf-287f-893c-bed3e6219d0a@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 06:54:27AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/5 00:01, Matthew Warren wrote:
> > I don't know how btrfs is layed out internally, but is checksum tree
> > separate from file (meta)data or is it part of the (meta)data? If it's
> > separate it should be possible to build a second csum tree and then
> > replace the old one once it's done, right?
> 
> There are several problems, even for off-line covert.

I worked out something of a plan to do an online conversion, but there
are some unfortunate issues with the btrfs on-disk design that make online
conversion harder than it has to be.  It would be easier to do an online
conversion to a new on-disk format that supports multiple csum types,
than to convert from one of the existing csum types to another.

> 1) Metadata checksum
>    Unlike data checksum, metadata checksum is inlined into the metadata
>    header.
>    Thus there is no way to make the csum co-exist for metadata, and we
>    need to re-write (CoW) all metadata of the fs to convert them to the
>    new algo.

Metadata is the easy case.  In the metadata pages the csum is a
fixed-width field.  There is also a transid/generation field on each page.
So if you know that the csum was changed from crc32c to xxhash on transid
123456 (and you'd know this because the online conversion would store
this in an item at the beginning of the conversion process), then any
time you read a page with a transid below 123456 you check crc32c, and any
time you read a page with transid above 123456 you check xxhash, and any
time you write a page you use xxhash.  Once conversion is set up, run a
metadata balance, and all the metadata pages are converted to use the new
csum algorithm.  A few other places (chunk headers and superblocks) need
to be handled separately.  Allow only one conversion at a time to keep
things simple; otherwise, we'd need to maintain a list of transids and
csum algorithms to figure out which to use, or we'd have to brute-force
all possible algorithms until we figure out which one a metadata page
is using.  When all the metadata block groups have been balanced, the
conversion is done, and future csum checks use only the new algorithm.

An offline conversion tool can read, verify, compute, and write the new
csum algorithm in place, as there is a fixed-length 32 bytes struct in
each metadata page for csum.  It would need to do some kind of data
journalling to be crash-safe, but that's not difficult to arrange
(and in practice it can be YOLOed with no journal most of the time,
using dup or raid1 metadata to fix any blocks mangled by a crash).

> 2) Superblock flags/csum_type
>    Currently we have only one csum_type, which is shared by both data
>    and metadata.
> 
>    We need extra csum_type to indicate the destination csum algo.
>    We will also need to sync this bit to kernel, no matter if the kernel
>    really uses that.

In the data csum tree it's a bit awkward.  Although there are 136 bits
of (objectid, key, offset) for each csum item, for historical reasons
the objectid and key fields are constant, leaving no room to identify
the csum type in the item key (and we don't want to use any item data
bytes for this as it will make the items larger).  We could create a
new csum tree with a different root, or use the objectid in the key to
identify the csum algorithm, but this requires completely new multi-tree
code to read and modify multiple csum trees during conversion.  It would
have to ensure there are no overlapping csums in two trees (or distant
locations in a single tree, which is just as bad) at the same time.
Every read would require potentially two tree lookups--all at places
where there have historically been bugs in the csum tree implementation.
This double-lookup and double-update (and quadruple-kernel-bug-fixing)
would have to continue until the last item in the old csum tree is
deleted.

Ideally a future csum tree (csum_tree_v2?) would have keys of (objectid =
bytenr of data block, type = CSUM_ITEM_KEY, offset = csum algorithm).
Then the existing csum tree code can be used more or less unmodified,
except for the detail that each csum item might contain csums from
any one of the csum algorithms.  This is a simpler modification to the
csum tree code, since it uses only one tree, adjacent block csums are
adjacent in the tree key order, and lookup performance doesn't change.
The gotcha is that doing this requires a less-simple modification to the
fsync log tree code, which is apparently leveraging the existing csum item
key format to share a lot of code between fsync log tree and csum tree.
Also a single extent might have csums of different sizes, which will
complicate code that deals with e.g. printing csum values.

The advantage of csum_tree_v2 is that once the tree is converted to
a multi-csum tree format, it's much easier/faster to convert it again
(e.g. maybe you decide sha256 is too slow for you and you want to go
back to xxhash or blake2b), and you can mkfs new filesystems using
csum_tree_v2 from the beginning for online conversion later.

Any change in the tree organization probably means we have to solve the
multi-tree problem above anyway, since whatever new tree format we choose
to support multiple csums, the existing csum tree isn't laid out in the
same format.  There might be a way out of this if we borrow an idea from
space_cache=v2, and convert the csum tree to csum_tree_v2 format during
mount, without changing the csum algorithm at the same time.  This would
be relatively fast (compared to reading all the data blocks) but it
would eliminate the need to update multiple trees online (conversion
would simply copy the csums to a new tree and delete the old one, while
nothing is allowed to write to the filesystem).  After the csum tree
is converted to csum_tree_v2, the kernel would be able to complete the
conversion online.

Regardless of how multiple csum algorithms are supported, a data balance
would be sufficient to recompute all of the data csums by brute-force
reading (checking old csum) and writing (computing new csum) the data.
This is very wasteful as it rewrites many (but not all) of the metadata
trees again, as well as all of the data blocks, but it would work and
could be used until a proper conversion tool exists.

It might be possible to do something like scrub, but only reading the
data blocks and writing the csum trees.  Except not really scrub--I don't
think any of the existing scrub code can be used this way.  Maybe a
variation of defrag that only rewrites csums?  It might be easier to
build this component from scratch--none of the existing building blocks
in the kernel really fits.

Offline conversion of the existing csum tree from one csum algorithm
to another is non-trivial, since the csum data is packed into pages
dynamically.  Changing from any csum algorithm to one with a different
length will require not only rewriting the content of the csum tree pages,
but also allocating a new tree structures to store them.

Offline conversion to csum_tree_v2 is easy since it changes only the
arragement of bits in the btrfs key structure, not the size of anything.
It can be done in place the same way metadata can be converted in place.

> Thanks,
> Qu
> 
> > 
> > Matthew Warren
> > 
> > On Mon, Oct 4, 2021 at 4:52 AM David Sterba <dsterba@suse.cz> wrote:
> > > 
> > > On Mon, Oct 04, 2021 at 12:26:16AM -0500, Matthew Warren wrote:
> > > > Is there currently any way to change the checksum used by btrfs
> > > > without recreating the filesystem and copying data to the new fs?
> > > 
> > > I have a WIP patch but it's buggy. It works on small filesystems but
> > > when I tried it on TB-sized images it blew up somewhere. Also the WIP is
> > > not too smart, it deletes the whole checksum tree and rebuilds if from
> > > the on-disk data, so it lacks the verification against the existing
> > > csums. I intend to debug it some day but it's a nice to have feature,
> > > I'm aware that people have been asking for it but at this point it would
> > > be to dangerous to provide even the prototype.
