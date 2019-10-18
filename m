Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF03DCCC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 19:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505509AbfJRR14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 13:27:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505495AbfJRR1d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 13:27:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 760C0AF57;
        Fri, 18 Oct 2019 17:27:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C41BEDA785; Fri, 18 Oct 2019 19:27:45 +0200 (CEST)
Date:   Fri, 18 Oct 2019 19:27:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu WenRuo <wqu@suse.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Message-ID: <20191018172745.GD3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 16, 2019 at 11:19:54AM +0000, Qu WenRuo wrote:
> >> The most important aspect to me is, to allow real world user of super
> >> large fs to try this feature, to prove the usefulness of this design,
> >> other than my on-paper analyse.
> >>
> >> That's why I'm pushing the patchset, even it may not pass any review.
> >> I just want to hold a up-to-date branch so that when some one needs, it
> >> can grab and try them themselves.
> > 
> > Ok that's fine and I can add the branch to for-next for ease of testing.
> > I'm working on a prototype that does it the bg item key way, it compiles
> > and creates almost correct filesystem, so I have to fix it before
> > posting. The patches are on top of your bg-tree feature so we could have
> > both in the same kernel for testing.
> 
> That's great!
> 
> As long as we're pushing a solution to the mount time problem, I can't
> be more happier!
> 
> Then I guess no matter which version get merged to upstream, the
> patchset is already meaningful.

We'll see what works in the end, I'm getting to the point where the
prototype almost works and am debugging weird problems or making sure
it's correct. So I'll dump the ideas here and link to the code so you
can have a look.

We agree on the point that the block group items must be packed. The key
approach should move the new BGI to the beginning, ie. key type is
smaller than anything that appears in the extent tree. I chose 100 for
the prototype, it could change.

To keep changes to minimum, the new BGI uses the same block group item,
so the only difference then becomes how we search for the items.

Packing of the items is done by swapping the key objectid and offset.

Normal BGI has bg.start == key.objectid and bg.length == key.offset. As
the objectid is the thing that scatters the items all over the tree.

So the new BGI has bg.length == key.objectid and bg.start == key.offset.
As most of block groups are of same size, or from a small set, they're
packed.

The nice thing is that a lot of code can be shared between BGI and new
BGI, just needs some care with searches, inserts and search key
advances.

I'm now stuck a bit at mkfs, where the 8M block groups are separated by
some METADATA_ITEMs

 item 0 key (8388608 BLOCK_GROUP_ITEM_NEW 13631488) itemoff 16259 itemsize 24
         block group NEW used 0 chunk_objectid 256 flags DATA
 item 1 key (8388608 BLOCK_GROUP_ITEM_NEW 22020096) itemoff 16235 itemsize 24
         block group NEW used 16384 chunk_objectid 256 flags SYSTEM|DUP
 item 2 key (22036480 METADATA_ITEM 0) itemoff 16202 itemsize 33
         refs 1 gen 5 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root CHUNK_TREE
 item 3 key (30408704 METADATA_ITEM 0) itemoff 16169 itemsize 33
         refs 1 gen 4 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root FS_TREE
 item 4 key (30474240 METADATA_ITEM 0) itemoff 16136 itemsize 33
         refs 1 gen 4 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root CSUM_TREE
 item 5 key (30490624 METADATA_ITEM 0) itemoff 16103 itemsize 33
         refs 1 gen 4 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root DATA_RELOC_TREE
 item 6 key (30507008 METADATA_ITEM 0) itemoff 16070 itemsize 33
         refs 1 gen 4 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root UUID_TREE
 item 7 key (30523392 METADATA_ITEM 0) itemoff 16037 itemsize 33
         refs 1 gen 5 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root EXTENT_TREE
 item 8 key (30539776 METADATA_ITEM 0) itemoff 16004 itemsize 33
         refs 1 gen 5 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root DEV_TREE
 item 9 key (30556160 METADATA_ITEM 0) itemoff 15971 itemsize 33
         refs 1 gen 5 flags TREE_BLOCK
         tree block skinny level 0
         tree block backref root ROOT_TREE
 item 10 key (107347968 BLOCK_GROUP_ITEM_NEW 30408704) itemoff 15947 itemsize 24
         block group NEW used 114688 chunk_objectid 256 flags METADATA|DUP

After item 10, the rest of the block group would appear, and basically
the rest of the extent tree, many other items.

I don't want
to make hardcoded assumptins, that maximum objecit is 1G, but so far was
not able to come up with a generic and reliable formula how to set up
key for next search to reach item (107347968 BLOCK_GROUP_ITEM_NEW
30408704) once (8388608 BLOCK_GROUP_ITEM_NEW 22020096) has been
processed.

The swapped objectid and offset is the hard part for search because we
lose the linearity of block group start.  Advance objectid by one and
search again ie. (8388608+1 BGI_NEW 22020096) will land on the next
metadata item. Iterating objectid by one would eventually reach the 1G
block group item, but what to do after the last 1G item is found and we
want do decide wheather to continue or not?

This would be easy with the bg_tree, because we'd know that all items in
the tree are just the block group items. Some sort of enumeration could
work for bg_key too, but I don't have something solid.

The WIP is in my github repository branch dev/bg-key. It's not on top of
the bg_tree branch for now. The kernel part will be very similar once
the progs side is done.

Feedback welcome.
