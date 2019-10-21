Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15089DF1D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfJUPny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 11:43:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbfJUPny (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 11:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0A79AC7D;
        Mon, 21 Oct 2019 15:43:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0D7D6DA905; Mon, 21 Oct 2019 17:44:04 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:44:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Message-ID: <20191021154404.GP3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
 <20191018172745.GD3001@twin.jikos.cz>
 <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 19, 2019 at 08:04:51AM +0800, Qu Wenruo wrote:
> That's wonderful.
> Although I guess my patchset should provide the hint of where to modify
> the code, since there are only a limited number of places we modify
> block group item.

I indeed started at your patchset and grepped fro BG_TREE, adding
another branch.

> > We agree on the point that the block group items must be packed. The key
> > approach should move the new BGI to the beginning, ie. key type is
> > smaller than anything that appears in the extent tree. I chose 100 for
> > the prototype, it could change.
> > 
> > To keep changes to minimum, the new BGI uses the same block group item,
> > so the only difference then becomes how we search for the items.
> 
> If we're introducing new block group item, I hope to do a minor change.
> 
> Remove the chunk_objectid member, or even flags. to make it more
> compact. So that you can make the BGI subtree even smaller.

Yeah that can be done.

> But I guess since you don't want to modify the BGI structure, and keep
> the code modification minimal, it may not be a good idea right now.

As long as the changes are bearable, eg. a minor refactoring of block
group access (the cache.key serving a as offset and length) is fine. And
if we can make the b-tree item more then let's do it.

> > Packing of the items is done by swapping the key objectid and offset.
> > 
> > Normal BGI has bg.start == key.objectid and bg.length == key.offset. As
> > the objectid is the thing that scatters the items all over the tree.
> > 
> > So the new BGI has bg.length == key.objectid and bg.start == key.offset.
> > As most of block groups are of same size, or from a small set, they're
> > packed.
> 
> That doesn't look optimized enough.
> 
> bg.length can be at 1G, that means if extents starts below 1G can still
> be before BGIs.

This shold not be a big problem, the items are still grouped togethers.
Mkfs does 8M, we can have 256M or 1G. On average there could be several
packed groups, which I think is fine and the estimated overhead would be
a few more seeks.

> I believe we should have a fixed objectid for this new BGIs, so that
> they are ensured to be at the beginning of extent tree.

That was my idea too, but that also requires to add one more member to
the item to track the length. Currently the key is saves the bytes. With
the proposed changes to drop chunk_objectid, the overall size of BGI
would not increase so this still sounds ok. And all the problems with
searching would go away.

> > The nice thing is that a lot of code can be shared between BGI and new
> > BGI, just needs some care with searches, inserts and search key
> > advances.
> 
> Exactly, but since we're introducing a new key type, I prefer to perfect
> it. Not only change the key, but also the block group item structure to
> make it more compact.
> 
> Although from the design aspect, it looks like BG tree along with new
> BGI would be the best design.
> 
> New BG key goes (bg start, NEW BGI TYPE, used) no data. It would provide
> the most compact on-disk format.

That's very compact. Given the 'bg start' we can't use the same for the
extent tree item.

> > This would be easy with the bg_tree, because we'd know that all items in
> > the tree are just the block group items. Some sort of enumeration could
> > work for bg_key too, but I don't have something solid.
> 
> Why not fixed objectid for BGI and just ignore the bg.len part?

I wanted to avoid storing a useless number, it costs 8 bytes per item,
and the simple swap of objectid/offset was first idea how to avoid it.

> We have chunk<->BGI verification code, no bg.len is not a problem at
> all, we can still make sure chunk<->bg is 1:1 mapped and still verify
> the bg.used.

This is all great, sure, and makes the extensions easy. Let's try to
work out best for each approach we have so far. Having a separate tree
for block groups may open some future options.
