Return-Path: <linux-btrfs+bounces-21260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI7uBRU5fmn7WQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21260-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 18:17:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49569C3280
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2712D3020871
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE734678C;
	Sat, 31 Jan 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="AuCkuY1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZsTr0/u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502A31B107
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879825; cv=none; b=coKoWWQ8qlXLnNAhHBtOcKGA4pR4J+yIcU9yRCeS+ETWnZrYovEUFrxAuuXLKr8JWt9w4otZygygvryYQOfRvYHXvnR84mYs/GryDszT4EpNho9/Vy4ViaC7zIfegGR7rXjkfqpSIf0phx9BpAbTx4nMz3Sa/44mriGFpWsRCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879825; c=relaxed/simple;
	bh=UQXwWIZ07j+C3gRfba1eXn5bV9wyL8g+dIEfwuvNPuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW+S7Iy/QsfZDw83IH7nglVOQq0tGnhfGBEQZdZYSoPRWxIIGF2vlIeEe+pbDg8BdZHMS5GRgQuHH4f2G+EGWgAROsp70+dOJtUVDyT/jv2RwY/G+LSA/UzZ0PHj3PEfaLAkBIKbOk3lWSIpcROy0F0v2U+bm5uZo+nXr9rOnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=AuCkuY1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZsTr0/u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 322817A005B;
	Sat, 31 Jan 2026 12:17:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 31 Jan 2026 12:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769879821;
	 x=1769966221; bh=MvrF0BGP631uwwN/OVSfSY54GO9nyZ4cs86fOszgPXc=; b=
	AuCkuY1VPF20iStiZ8gg4IIJmK+NrGzjI1tutwHTLluZu8vt0Uy6I5vX1LUIgfvh
	gIByDG00VXBTDgUwlx93o6eIzURHCoqaPTPDq+3QbeLrBc9yj1+ZBGAU1RFaTJcx
	1Nph+VrF/nW4qGUEXyxnmDDBFSlnnU5V9cGGn/dBCFMZet0jnLgHG/Wq6ot7j9hY
	UhGwnccJZmFAa2YBl1IugcBHWKHcjU3Xm8wZ0B3hEB/KtpX1elCbzRprm7QI9MwL
	o2jQyGTSrZiPBkeQ+EfYjHlHpuJMnBDh5xSvn6uMVZO5CqPpSGUf/5O/LBjuvDsh
	ilnVKP+u+E52VAXZRBFo/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769879821; x=
	1769966221; bh=MvrF0BGP631uwwN/OVSfSY54GO9nyZ4cs86fOszgPXc=; b=d
	ZsTr0/uA5B8Ac5DqZVE+d1tvCFlQ0m6yiEXFK0CRaZOC4zXSL+Q++z4kgT/0iQO0
	TzZj2EGv77sAMbGBXNkq7jyVym+5lxbxagajTsnTQ3rtKbUdSFkR02hXGmIEUBod
	zuO7vrCxQMkYruZ4ZAI2t2SenxoZnkAadQyUCFPQgmymlnVW4hNDlQEqbkyete/K
	haKiJTHvh+YpgvV7UB0sqBYrwr/5M9Is815O1ylI6w9HtKDrq/WVH86lKokp4fjt
	F4VrM/ZaPWsfc58Qeeb905Sn4q9FevDOFTCGsFOuEYwXcgigN6ixK1laxdWkGuPG
	KI9G1cVvFcRn+Xre7KZFw==
X-ME-Sender: <xms:DTl-aSj_29sjL5eLVlIs219c0TOKYpsZCrohHVuGLf-w9jL01ipbbQ>
    <xme:DTl-aWvVOiSalqdKSncra3NzjOU6m0B3PBxx2D_NQpE9ClZmBvo1WyTWlvhRlCH9V
    fiZ8zTclJkfYP0K8mL53mpDUcxLN-2qhpDK7wfNrlGa3qwz61EGIvo>
X-ME-Received: <xmr:DTl-aT5bMhqBx3KpHfQQfjSB0ZOY1LqyTCCRAeColmpKr-XBRZ0inHq1DL5ElcYDkwoZJ_MnT5g8hA02St41PEHLqGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopeifqh
    husehsuhhsvgdrtghomhdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:DTl-aSP9fyr9m8_3p_GvLjPT4WReDhHd0UL5KzCaiHgFGQUpZVplnQ>
    <xmx:DTl-aRsJpjLY3seVuRznFgSMNqUZ0AKyi9ICVta0efa4I82N5JdlrA>
    <xmx:DTl-aVZB9BrgIc5A3nelbfbrlMPY8XwBqZdhJvwM-LhDOUR5MMUU2g>
    <xmx:DTl-aTyMA8oPEhgWByya5f4eurfsWl2XvR8h9pjG3oMNS2kJEgA8WQ>
    <xmx:DTl-adfLYbA7p0YzoVxmIrep0YnztDj43ECp0rcsRoKIIfeAaWK_Yi00>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 12:17:01 -0500 (EST)
Date: Sat, 31 Jan 2026 09:16:30 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, Leo Martins <loemra.dev@gmail.com>,
	Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
Message-ID: <20260131171630.GA2030728@zen.localdomain>
References: <20260130214319.3714908-1-loemra.dev@gmail.com>
 <4bff1e42-57de-4169-b3c0-a2085182cbb3@suse.com>
 <20260131001118.GA1432933@zen.localdomain>
 <94167ea3-8174-4d35-a316-1f9e46fdb988@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94167ea3-8174-4d35-a316-1f9e46fdb988@gmx.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21260-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,kernel.org,vger.kernel.org,fb.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,bur.io:dkim]
X-Rspamd-Queue-Id: 49569C3280
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:36:54AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/31 10:41, Boris Burkov 写道:
> > On Sat, Jan 31, 2026 at 09:04:03AM +1030, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2026/1/31 08:13, Leo Martins 写道:
> > > > On Fri, 30 Jan 2026 12:49:55 +0000 Filipe Manana <fdmanana@kernel.org> wrote:
> > > > 
> > > [...]
> > > > 
> > > > > 
> > > > > This was before a recent refactoring of should_cow_block(), but you
> > > > > should get the ideia.
> > > > > IIRC all fstests were passing back then, except for one or two which I
> > > > > never spent time debugging.
> > > > > 
> > > > > And as that attempt was before the tree checker existed, we would need
> > > > > to make sure we don't change and eb while the tree checker is
> > > > > verifying it - making sure the tree checker read locks the eb should
> > > > > be enough.
> > > 
> > > That may still be racy not just to tree-checker, but with the extent buffer
> > > writeback path.
> > > 
> > > Even we locked the eb for tree-checker, but someone still modified the the
> > > eb after tree-checker but before submission, it can still be very
> > > problematic.
> > 
> > Agreed that it feels very fishy, like we can write an eb with bad csum,
> > much like DIO and unstable pages. But do we think it *actually* matters?
> > 
> > In principle, if I buffered an eb, wrote total garbage to the disk during
> > the transaction, but then during the commit wrote out the correct eb, I
> > think that is still OK. If we crash, that bad eb isn't reachable from
> > any root when we mount again, right?
> 
> Yes, that's correct, however still I'd prefer a more consistent behavior
> that doesn't introduce any bad csum at any timing.
> 
> Causing temporary unreachable bad csum seems harmless, but it brings a much
> bigger opening, that may or may not lead to bad csums for valid tree blocks
> in the future.
> 
> [...]
> > > Although before all the new ideas/attempts, I'm wondering the following two
> > > points:
> > > 
> > > - With the AS_KERNEL_FILE flag, how frequent we're re-dirtying COWed ebs
> > >    We need extra benchmarks on this first.
> > 
> > As far as I am concerned, any amount more than zero is a bug when you
> > consider it from the perspective of the transaction block_rsv. If you
> > had an 8 deep tree doing splitting, then a single re-cow you didn't plan
> > on will use space not in the block_rsv.
> 
> I also have one question related to the exhausted block_rsv.
> 
> If we COWed a tree block (the old is eb A, older than the current trans),
> write the new one (eb B) back to disk, the space of eb A will not be
> available until a full transaction is committed.
> 
> But if we need to re-dirty eb B and COW it to eb C, shouldn't the space of
> eb B be available again?

Eventually, yes. I think the details depend on exactly what happens with
delayed refs. I haven't looked into this angle super closely yet.

Unfortunately, Leo and I could not think of a robust way to wire the
re-dirty cows to the block_rsv in a way that does not double dip from
the block_rsv. (See my reply to your next question for why I am so
obsessed with this...)

How do you tell apart this sequence:
I start a transaction that reserves num_items=1 (reserving for <=16 cows)
I am doing cow in root R (cows=1)
I cow down through node N (cows=2)
I cow down to leaf L (cows=3)
someone in direct reclaim evicts clean page of L
I need to read L so I release the locks and loop
someone in direct reclaim writes back N
I cow down through N and re-dirty it because WRITTEN=true (cows=4, WRONG)

from this one:
someone cows N
someone in direct reclaim writes back N
I start a transaction that reserves num_items=1 (reserving for <=16 cows)
I am doing cow in root R (cows=1)
I cow down through node N because WRITTEN=true (cows=2, CORRECT)
I cow down to leaf L (cows=3)

You can't just save the "last cow-er trans_handle" or whatever,
because after you release the locks and loop, some other writer can cow
down through that path and it could get written back before you get
another shot, so you wouldn't see that you were the last writer.

You would have to track which ebs a search_slot has already cowed, but I
fear that these "track the ebs" things run into the same issue Filipe
raised about Leo's log_transid in the eb idea.

Probably worth exploring this family of fixes a bit more though.

We could consider an array/xarray on the block_rsv for ebs that block_rsv
has cow-ed? I will have to think some more about that. (linked list is no
good because one eb might go on multiple such lists) We could
preallocate the storage when we size the block_rsv too, which is a
much better time to get an ENOMEM (start_transaction) than search_slot.

> 
> So from the perspective of space usage, re-dirtying a COWed block (in the
> current transaction, except log trees) should not cause extra space usage
> except the temporary usage before freeing eb B and copy its content to eb C.
> 
> It should always be the space of the original old on-disk eb, and the new
> COWed eb, no matter how many times we redirtied it.
> 
> Or is the problem exactly at the space reservation for such eb B?
> 

Yes, the problem is the reservation done at start_transaction() is not
properly accounted. See Leo's original email for a good explanation of
the details, but tl;dr:
btrfs_insert_delayed_dir_index was seeing an ENOSPC migrating items from
a transaction block_rsv that had been exhausted by re-dirtying
accounting an arbitrary number of cows to that block_rsv.

The ENOSPCd system has 100s of gigs of unallocated, it's a reservation
accounting ENOSPC not truly leaked or wasted space.

> > 
> > In practice today we see 30x amplification at least. To flip it around,
> > what amount is "OK"? An amount that doesn't happen to cause ENOSPCs on
> > most machines?
> 
> 30x amplification itself should not be the cause of exhausted space, but
> whether we can reuse the space of eb B of the above example.

The level of amplification needed to hit the bug is based on the tree
depth and whether the cow actually split or not. 16x items is the normal
upper-bound, so if we are running closer to that "naturally", then less
re-dirtying is tolerated. Otherwise more. But ultimately any single cow
more than we reserved accounted to the block_rsv is strictly a bug,
unless we relax the expectations around the transaction block_rsv
reservation.

> 
> Although I agree 30x re-dirtying is very bad, but re-using the eb in-place
> also means we will still see the same 30x write amplification, and more
> chance to screw up the writeback handling.

Not avoiding the write-amp and high risk involved is a good point, IMO.

> 
> I'd like to know more about the source of such aggressive writeback first.
> 

A system going into direct reclaim, typically because of a cgroup
reaching its memory limit, but it can also happen when global memory
gets tight. Particularly this is 1:1 with high memory pressure. 


> Especially if the risk of chances of data race/bad csum is really worthy
> after the AS_KERNEL_FILE feature.

The cgroup direct reclaim issue goes away, but the global direct reclaim
issue remains.

> 
> Thanks,
> Qu
> 
> > 
> > I don't think it's responsible to let it slide and hope it doesn't happen
> > too much. There's always systems in global reclaim to worry about as well..
> > 
> > I do, however, completely agree that this argument means we should try
> > to avoid inventing some really wild and costly solution. Ideally we can
> > find something tidy to plug up the hole :)
> > 
> > > 
> > > - Is there any pattern of the re-dirtying COWed ebs
> > >    E.g. which trees are re-drity the most frequently? Extent or csum or
> > >    log trees?
> > 
> > In the Meta fleet data, the subvol trees and the csum tree see by far
> > the most lock contention, which I think is likely going to be correlated
> > with COW amplification. But we don't have detailed COW re-dirtying data
> > yet.
> > 
> > > 
> > >    Can we take advantage of such patterns if they exist?
> > > 
> > 
> > That is why I wasted everyone's time and brain-cells on those very tricky
> > csum commit root patches I kept messing up for like nine iterations :D
> > 
> > If there are other heuristic improvements I think it's a good idea, but
> > I think also doesn't change the reality of the transaction block_rsv
> > over-spend bug.
> > 
> > > - Is there any less invasive alternatives to changing COW basics?
> > >    E.g. Changing btree_writepages() to utilize some LRU so only the
> > >    oldest/least frequent accessed dirty ebs are written back first.
> > 
> > With sufficient sustained memory pressure I am not sure that something
> > like this will work, even to satisfactorily reduce the problem,
> > but I have not yet reproduced it without resorting to small cgroups
> > and no AS_KERNEL_FILE (as we have discussed elsewhere)
> > 
> > Ideas we have considered, which I think would fully solve the bug:
> > (in no particular order, and I'm sure there are others)
> > 
> > - Leo's xarray to block writeback on the shortest scope
> > - Block writeback on a longer but easier to manage scope (e.g. trans_handle)
> > - Block writeback to the whole tree while it's being cow-ed.
> > - Have writeback also take a new type of tree lock which cow paths do not release
> > - Relax the strictness of the transaction block rsv guarantee
> > 
> > Personally, I am still quite excited about Filipe's idea and hope we can
> > make it work. That would be really slick.
> > 
> > Thanks,
> > Boris
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > > 
> > > > > Thanks.
> > > > > 
> > > > > > 
> > > > > > Please let me know if you see any issues with this approach or
> > > > > > if you can think of a better method.
> > > > > > 
> > > > > > Thanks,
> > > > > > Leo
> > 
> 

