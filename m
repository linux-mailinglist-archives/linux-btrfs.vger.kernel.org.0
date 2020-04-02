Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5345819B9BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 03:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgDBBKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 21:10:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDBBKN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 21:10:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30DBAAF3D;
        Thu,  2 Apr 2020 01:10:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A67FDA727; Thu,  2 Apr 2020 03:09:37 +0200 (CEST)
Date:   Thu, 2 Apr 2020 03:09:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 17/39] btrfs: Rename tree_entry to simple_node and
 export it
Message-ID: <20200402010936.GC5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-18-wqu@suse.com>
 <20200401154820.GT5920@twin.jikos.cz>
 <dfb63614-e246-8b96-e02b-2d333f5ffd82@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb63614-e246-8b96-e02b-2d333f5ffd82@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 02, 2020 at 07:40:29AM +0800, Qu Wenruo wrote:
> >>  struct btrfs_backref_node {
> >> -	struct rb_node rb_node;
> >> -	u64 bytenr;
> >> +	struct {
> >> +		struct rb_node rb_node;
> >> +		u64 bytenr;
> >> +	}; /* Use simple_node for search/insert */
> > 
> > Why is this anonymous struct? This should be the simple_node as I see
> > below. For some simple rb search API.
> 
> If using simple_node, we need a ton of extra wrapper to wrap things like
> rb_entry(), rb_postorder_()
> 
> Thus here we still want byte/rb_node directly embeded into the structure.
> 
> The ideal method would be anonymous but typed structure.
> Unfortunately no such C standard supports this.

My idea was to have something like this (simplified):

	struct tree_node {
		struct rb_node node;
		u64 bytenr;
	};

	struct backref_node {
		...
		struct tree_node cache_node;
		...
	};

	struct backref_node bnode;

when the rb_node is needed, pass &bnode.cache_node.rb_node . All the
rb_* functions should work without adding another interface layer.

> >>  	u64 new_bytenr;
> >>  	/* objectid of tree block owner, can be not uptodate */
> >> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> >> index 72bab64ecf60..d199bfdb210e 100644
> >> --- a/fs/btrfs/misc.h
> >> +++ b/fs/btrfs/misc.h
> >> @@ -6,6 +6,7 @@
> >>  #include <linux/sched.h>
> >>  #include <linux/wait.h>
> >>  #include <asm/div64.h>
> >> +#include <linux/rbtree.h>
> >>  
> >>  #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
> >>  
> >> @@ -58,4 +59,57 @@ static inline bool has_single_bit_set(u64 n)
> >>  	return is_power_of_two_u64(n);
> >>  }
> >>  
> >> +/*
> >> + * Simple bytenr based rb_tree relate structures
> >> + *
> >> + * Any structure wants to use bytenr as single search index should have their
> >> + * structure start with these members.
> > 
> > This is not very clean coding style, relying on particular placement and
> > order in another struct.
> 
> Order is not a problem, since we call container_of(), thus there is no
> need for any order or placement.
> User can easily put rb_node at the end of the structure, and bytenr at
> the beginning of the structure, and everything still goes well.
> 
> The anonymous structure is mostly here to inform callers that we're
> using simple_node structure.
> 
> > 
> >> + */
> >> +struct simple_node {
> >> +	struct rb_node rb_node;
> >> +	u64 bytenr;
> >> +};
> >> +
> >> +static inline struct rb_node *simple_search(struct rb_root *root, u64 bytenr)
> > 
> > simple_search is IMHO too vague, it's related to a rb-tree so this could
> > be reflected in the name somehow.
> > 
> > I think it's ok if you do this as a middle step before making it a
> > proper struct hook and API but I don't like the end result as it's not
> > really an improvement.
> > 
> That's the what I mean for "simple", it's really just a simple, not even
> a full wrapper, for bytenr based rb tree search.
> 
> Adding too many wrappers may simply kill the "simple" part.
> 
> Although I have to admit, that most of the simple_node part is only to
> reuse code across relocation.c and backref.c. Since no other users
> utilize such simple facility.
> 
> Any idea to improve such situation? Or we really need to go full wrappers?

If the above works we won't need to add more wrappers. But after some
thinking I'm ok with the way you implement it as it will certainly clean
up some things and once it's merged we'll have another chance to look at
the code and fix up only the structures.
