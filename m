Return-Path: <linux-btrfs+bounces-1254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A0824BE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 00:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3401C22633
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D12D60E;
	Thu,  4 Jan 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lTZJFPuU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555C2D600
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Jan 2024 18:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704411689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQaC+qZOAnzqx/1J8RbXfkiEOhtli/fOHQQ6fdLgWVY=;
	b=lTZJFPuU3uxJMGeDHHgv34gnHH9FOVWiilUInXecX2Flb/Sgs4td1X6dlZeFCMm3b96RY6
	SnOWdXe1oieSQ23SwHiW102xI3sIknqK/UMZo0k5RxcRE3ZVLqtS4SFNwhoBmBv7+JIZrT
	zLQbzTXCNeqmVZULs+JyqRsM0O80nKM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 1/2] bcachefs: add fiemap delalloc extent detection
Message-ID: <5sttczrkktgkivq5ncusst3rrjqi7hgpx4nswq2vjqn6iqr4b2@25hi2ukb2rh7>
References: <20231219140215.300753-1-bfoster@redhat.com>
 <20231219140215.300753-2-bfoster@redhat.com>
 <20231219235742.fmon4qqvbabuxq6c@moria.home.lan>
 <ZZagv/f2lWOSMUSn@bfoster>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZagv/f2lWOSMUSn@bfoster>
X-Migadu-Flow: FLOW_OUT

+cc btrfs folks

On Thu, Jan 04, 2024 at 07:12:47AM -0500, Brian Foster wrote:
> On Tue, Dec 19, 2023 at 06:57:42PM -0500, Kent Overstreet wrote:
> > On Tue, Dec 19, 2023 at 09:02:14AM -0500, Brian Foster wrote:
> > > +	start = bch2_seek_pagecache_data(vinode, start, end, 0, false);
> > > +	if (start >= end)
> > > +		return false;
> > > +	end = bch2_seek_pagecache_hole(vinode, start, end, 0, false);
> > > +
> > > +	/*
> > > +	 * Create a fake extent key in the buffer. We have to add a dummy extent
> > > +	 * pointer for the fill code to add an extent entry. It's explicitly
> > > +	 * zeroed to reflect delayed allocation (i.e. phys offset 0).
> > > +	 */
> > > +	bch2_bkey_buf_realloc(cur, c, sizeof(*delextent) / sizeof(u64));
> > > +	delextent = bkey_extent_init(cur->k);
> > > +	delextent->k.p = POS(ei->v.i_ino, start >> 9);
> > > +	bch2_key_resize(&delextent->k, (end - start) >> 9);
> > > +	bch2_bkey_append_ptr(&delextent->k_i, ptr);
> > > +
> > > +	return true;
> > > +}
> > 
> > I don't like that this returns a delalloc extent when data is merely
> > present in the pagecache - that's wrong.
> > 
> > bch2_seek_pagecache_dirty_data()?
> > 
> 
> Technically it just returns a file offset range represented in an extent
> key. I could tweak it to just return a range or something and make the
> delalloc part a separate helper.
> 
> More to the broader point, I thought that technically this was all
> somewhat racy wrt to folio state and I was a little concerned about
> possibly showing weird/inconsistent state if this runs concurrently with
> writeback. I'll have to take a closer look at the bch2_seek_* helpers
> though to better quantify that concern...

Yeah, it does get tricky there; writeback will flip the folio state from
dirty to allocated before it shows up in the btree.

To fix that we'd need to add a new state to BCH_FOLIO_SECTOR_STATE, and
it seems like that's something we should strongly consider.

There may also be some lingering bugginess in the i_sectors accounting
code, if we're touching this stuff we definitely want to be looking for
ways to make that more rigoroous if we can - I thought I was done with
that, but I have an assert patch in my garbage branch that was firing -
hadn't had time to track it down:
https://evilpiepirate.org/git/bcachefs.git/commit/?h=bcachefs-garbage&id=50010457597c6c30aec1195b0568868d2d30bb76

This is likely related to the warning that's been popping in the CI from
time to time about i_sectors_delta being the wrong sign in writeback
completion.

Not the main focus here, just wanted to bring it up in case you start to
go down that rabbit hole


> > Now that we're not compiling in gnu89 mode anymore, I'm moving code away
> > from this "declare all variables at the top" style - I want variables
> > declared where they're initialized.
> > 
> > The reason is that bugs of the "I accidently used a var before I
> > initialized it" are really common, and the compiler does a crap job of
> > catching them.
> > 
> > Anywhere where we can write our code in a more functional style (in the
> > SSA sense, variables are declared where they are initialized and never
> > mutated) without it affecting the quality of the output is a big win.
> > 
> > (across function calls, we can't generally do this because C doesn't
> > have return value optimization).
> > 
> 
> Hmm.. not really sure I want to get into this. My initial reaction is
> that this strikes me as odd formatting that makes the code incrementally
> more annoying to read for marginal benefit. Has there been any broader
> discussion on this sort of thing anywhere that I can catch up on?

Starting that discussion now :)

Actually, this did come up not too long ago; there was a bug in some usb
code where they were using the loop iterator after breaking out of the
loop - which should have been ok, but for some horribly subtly reasons
was not, and Linus brought up that it's probably time to switch to
declaring the loop iterator in the for () statement to make those sorts
of bugs impossible.

More broadly, I regularly come across subtle bugs that should not have
happened purely because of variable reuse; consider the way we declare
int ret; at the top of a lot of functions, and then reuse it throughout.

That's error prone for a whole bunch of reasons, and the bugs it causes
tends to be ones that get introduced in later refactoring - some code
skips initializing ret where it's declared because _at the time that
code was written_ it was immediately assigned to, or code will use it
for something that wasn't an error code and then forget to set it back
to 0.

It's really much better to only declare variables when they're first
assigned to, and only use them for one thing.

You'll notice I've got a whole bunch of patches queued up for 6.8 that
change almost all of our for loop macros to declaring the loop iter in
the macro, and I will be going through and changing other variable uses
to this style as it comes up.

> > >  	bool have_extent = false;
> > >  	u32 snapshot;
> > >  	int ret = 0;
> > > @@ -916,6 +952,19 @@ static int bch2_fiemap(struct inode *vinode, struct fiemap_extent_info *info,
> > >  			continue;
> > >  		}
> > >  
> > > +		/*
> > > +		 * Outstanding buffered writes aren't tracked in the extent
> > > +		 * btree until dirty folios are written back. Check holes in the
> > > +		 * extent tree for data in pagecache and report it as delalloc.
> > > +		 */
> > > +		if (iter.pos.offset > start &&
> > > +		    bch2_fiemap_scan_pagecache(vinode, start << 9,
> > > +					       iter.pos.offset << 9, &cur)) {
> > > +			cflags = FIEMAP_EXTENT_DELALLOC;
> > 
> > but cflags/plags are unnecessary, no? can't we just detected this in
> > bch2_fill_extent when the ptr offset is 0?
> > 
> 
> I thought (briefly) about if/how this state could be implied by the
> helper (moreso out of laziness ;), but I feel that sort of logic is more
> fragile than just being explicit about state.

The logic can be confined to one place - a helper with a good name -
while the way you're doing it you're now spreading the state that's
passed around across multiple variables.

The clean way to do what you're doing would be to have a wrapper type so
we could store the bkey_buf with the fiemap flags in one variable.

> 
> > > +			start = bkey_start_offset(&cur.k->k) + cur.k->k.size;
> > > +			goto fill;
> > > +		}
> > 
> > The goto fill is also a code smell.
> > 
> 
> It's just basically a goto next pattern. I think the logical wart is
> more how this post-processes the gaps/hoes in the extent offset ranges
> and set_pos' the same start value repeatedly as we process delalloc
> extents. Not really sure if that's what you mean here, but that's the
> part that I didn't really love when hacking on this.
> 
> > The right way to do it would be to search, from the same position, both
> > the btree and the pagecache: then compare those two extents, using
> > delalloc extent if it comes first, and trimming the btree extent if it
> > comes first but the delalloc extent overlaps.
> > 
> > Then there's no goto fill; after we've decided which extent to use the
> > rest of the loop is unchanged.
> > 
> > (The btree iterator code works roughly this way, where it has to overlay
> > keys from the journal and pending updates).
> > 
> 
> Yeah, I thought that something like this would be necessary for changing
> behavior of the "dirty data over existing COW blocks" case, if we ever
> wanted to do that, but figured it wasn't worth the complexity unless we
> go that direction. It might be improvement enough for the iteration
> either way though. I'll try to take a fresh look at that. Thanks for the
> review.

btrfs folks have probably looked at this as well - any notes from you
guys on fiemap behaviour - has anything come up where a particular
behaviour is important?

Also, someone (Darrick?) mentioned in the Tuesday meeting that maybe we
actually can extend fiemap for multiple device filesystems, wonder if
anyone's interested in that...

