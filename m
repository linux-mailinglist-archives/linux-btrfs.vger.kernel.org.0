Return-Path: <linux-btrfs+bounces-13816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4C6AAEF55
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA55986B9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 23:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E619214211;
	Wed,  7 May 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="o8uvw/+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="THfehuKl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8B2046A9
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746661162; cv=none; b=NSdCtDgoClVXrypSOUvQInQacli46oiD80QfgdY2naBt+VxlbZ0EJWu2bEcVbw61OyFWcXYvziOu4V3di8cqwbg8UTM+qb3M1XlPF77WPnJN7mAm/sOuUAlkWwH40G6NG2bourp+96MErwVfB+ByV0UwFWsW8Bzj9yL/0BSjkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746661162; c=relaxed/simple;
	bh=/bdYqH9mVxFOKu2MVRCvsL6V5N3b/lmvKMRVHxHENMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csuhJtaH33LKOrIhCWVO54KdlbgwoApF8oGq5LGQdsez1mPLKWy6RI+YQ8UB2A+ggPWMGsCgpsZWcPSfVVjIwjlVN/Yuwmv5kvIBrhNr396GZ7+un+XuChWLK9H4EiycGZaQh0N3YNPzNiFxApYUHPkfk7Lq/OXljk4Dms0bsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=o8uvw/+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=THfehuKl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B29D11400F8;
	Wed,  7 May 2025 19:39:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 19:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746661158;
	 x=1746747558; bh=WBcAw7WcXV6Sk1B/wJthWBg3ZzlIPuTHh0HcIDnr714=; b=
	o8uvw/+LPeAt3YcFHqkSh0XxguFqs8C2KTqslvcgiQkRt6617OJt9I664eCib/Q8
	mi8Fn0FUPdh7SYWmMQVw9Hsf/qvpIWYcUyft4Si4y2LBX2G8BgA+kiCrRYmtd65E
	DgOezKBM1BbkCo9b4PUQGWnePumFdi/OCQ0DEu9arMX+z186dBGPlQUlfHtszmPw
	s81GpRAhESP9no7Wo32iBx+RzNbQWMkSkrKJjdHpH/MBomfWcdRf/Ny+e/efkkYs
	pcKVUsRaVgFuxNye/Agl8OVqdrCXl6PPpvgOPytZXdh3CHWSUt9lt89HGORuVyU2
	8MZeXXrkqfTh3C6rPbpZXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746661158; x=
	1746747558; bh=WBcAw7WcXV6Sk1B/wJthWBg3ZzlIPuTHh0HcIDnr714=; b=T
	HfehuKlguPoI/KY5qfruNgFj9PnTP16wuHUnlcpKdmqp4MkO6+NHmewZ4rQs4AJk
	O14b7OBVQexxJDn4Jjpyqq6l34cqLCoowsEPhfg0JyQOb8xhEGLyQKMbGIFnN0l0
	wPM/2icTeNNucIJMJY+fX+dt2Bp2gxKC+OVEhSzhf1xzEh00x7MKi2m12gUxwakr
	4PssPFVIsadIbBip1yQZ+FeR6pIYqyimcNb4tCKGVIrtHQVGpvSKaCtFkXMFO44c
	3tyA1aNidtJ+gnlhQ/HYFK7inJeI4IOyQHn/cUExUzWQhiJyRJ/TDm+fsfNiISDi
	ORXxtycmdrDbk5AuiooMg==
X-ME-Sender: <xms:Je8baBCXnwCHG1Hc4AY-5iP829kaUgbq5mwKUsNaFIQWNnVa9k_4aw>
    <xme:Je8baPjNYRB5L1mllfM5qhqqQrgHBrsnEmK-xfTuGr9n1ChU1IA1N4evynDHIKA9b
    Dm71uZKXdI02spQl50>
X-ME-Received: <xmr:Je8baMnascDPNq-z3OCRGs_ptVA2behJiRztv6t19bNlxL6uwMPZosF8Q_1fc0_D6kq2cLJgyiXWhiNjHDQn_J-cjBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtth
    hopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Je8baLwpehpvGDfNj1E2VbDHVEbDCByEqE1ti8GFwvJZOFviXfbqhQ>
    <xmx:Je8baGRxFsVoE1Sfjqz142ODqLaInoNKT6knfUKf9FGS5HHEaWigrg>
    <xmx:Je8baOa7hNUlrVW03nHP-8LqioFabe9ol4qlu6-G1Rd5wzUvHmGtAg>
    <xmx:Je8baHQ2-khkjB6ZcfBm_ryRe9lQ0COkJrzaGcMPgFi5OepA0xKPgQ>
    <xmx:Ju8baP01aIFcRsC-nc07WuDNUMwsQ_Q2nQZ_PEUm2c5lEvJ1aNgpOr29>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 19:39:17 -0400 (EDT)
Date: Wed, 7 May 2025 16:39:59 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
Message-ID: <20250507233959.GA3580243@zen.localdomain>
References: <cover.1746638347.git.fdmanana@suse.com>
 <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain>
 <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>

On Thu, May 08, 2025 at 08:41:56AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/8 08:03, Boris Burkov 写道:
> > On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > If we fail to allocate an ordered extent for a COW write we end up leaking
> > > a qgroup data reservation since we called btrfs_qgroup_release_data() but
> > > we didn't call btrfs_qgroup_free_refroot() (which would happen when
> > > running the respective data delayed ref created by ordered extent
> > > completion or when finishing the ordered extent in case an error happened).
> > > 
> > > So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
> > > ordered extent for a COW write.
> > 
> > I haven't tried it myself yet, but I believe that this patch will double
> > free reservation from the qgroup when this case occurs.
> > 
> > Can you share the context where you saw this bug? Have you run fstests
> > with qgroups or squotas enabled? I think this should show pretty quickly
> > in generic/475 with qgroups on.
> > 
> > Consider, for example, the following execution of the dio case:
> > 
> > btrfs_dio_iomap_begin
> >    btrfs_check_data_free_space // reserves the data into `reserved`, sets dio_data->data_space_reserved
> >    btrfs_get_blocks_direct_write
> >      btrfs_create_dio_extent
> >        btrfs_alloc_ordered_extent
> >          alloc_ordered_extent // fails and frees refroot, reserved is "wrong" now.
> >        // error propagates up
> >      // error propagates up via PTR_ERR
> > 
> > which brings us to the code:
> > if (ret < 0)
> >          goto unlock_err;
> > ...
> > unlock_err:
> > ...
> > if (dio_data->data_space_reserved) {
> >          btrfs_free_reserved_data_space()
> > }
> > 
> > so the execution continues...
> > 
> > btrfs_free_reserved_data_space
> >    btrfs_qgroup_free_data
> >      __btrfs_qgroup_release_data
> >        qgroup_free_reserved_data
> >          btrfs_qgroup_free_refroot
> > 
> > This will result in a underflow of the reservation once everything
> > outstanding gets released.
> 
> That should still be safe.
> 
> Firstly at alloc_ordered_extent() we released the qgroup space already, thus
> there will be no EXTENT_QGROUP_RESERVED range in extent-io tree anymore.

Ah yes, good point. And that is before any chance of an error, so now I
I agree that this patch is correct, and that my analysis was wrong.

> 
> Then at the final cleanup, qgroup_free_reserved_data_space() will
> release/free nothing, because the extent-io tree no longer has the
> corresponding range with EXTENT_QGROUP_RESERVED.
> 
> This is the core design of qgroup data reserved space, which allows us to
> call btrfs_release/free_data() twice without double accounting.
> 
> > 
> > Furthermore, raw calls to free_refroot in cases where we have a reserved
> > changeset make me worried, because they will run afoul of races with
> > multiple threads touching the various bits. I don't see the bugs here,
> > but the reservation lifetime is really tricky so I wouldn't be surprised
> > if something like that was wrong too.
> 
> This free_refroot() is the common practice here. The extent-io tree based
> accounting can only cover the reserved space before ordered extent is
> allocated.
> 
> Then the reserved space is "transferred" to ordered extent, and eventually
> go to the new data extent, and finally freed at
> btrfs_qgroup_account_extents(), which also goes the free_refroot() way.
> 

That makes sense. I was also thinking of it in terms of "transferring"
when working on this. And yes, there are other post-OE-alloc error paths
(some that I wrote, lol) but I think they are a smell. However, a key
difference is that in those cases, the reservation either already
belongs to the delayed ref logic, or the OE still exists. So this is
still a weird case where we do not have the protection of an OE but
call a raw free_refroot.

I would guess that extent locking during OE creation probably saves us,
though, from glancing at the code. generic/475 with qgroups on will be
the ultimate arbiter here.

> > 
> > As of the last time I looked at this, I think cow_file_range handles
> > this correctly as well. Looking really quickly now, it looks like maybe
> > submit_one_async_extent() might not do a qgroup free, but I'm not sure
> > where the corresponding reservation is coming from.
> > 
> > I think if you have indeed found a different codepath that makes a data
> > reservation but doesn't release the qgroup part when allocating the
> > ordered extent fails, then the fastest path to a fix is to do that at
> > the same level as where it calls btrfs_check_data_free_space or (however
> > it gets the reservation), as is currently done by the main
> > ordered_extent allocation paths. With async_extent, we might need to
> > plumb through the reserved extent changeset through the async chunk to
> > do it perfectly...
> 
> I agree with you that, the extent io tree based double freeing prevention
> should only be the last safe net, not something we should abuse when
> possible.

Yes, this does still feel icky to me.

> 
> But I can't find a better solution, mostly due to the fact that after the
> btrfs_qgroup_release_data() call, the qgroup reserved space is already
> released, and we have no way to undo that...

I so wish we could have a nice RAII qgroup reservation object flow
through the whole system :)

> 
> Maybe we can delayed the qgroup release/free calls until the ordered extent
> @entry is allocated?
> 

I do think that is likely the cleaner fix. Though it would have to also be
after the igrab() check later in the series.

> Thanks,
> Qu
> 
> 
> > 
> > Thanks,
> > Boris
> > 
> > > 
> > > Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >   fs/btrfs/ordered-data.c | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > > index ae49f87b27e8..e44d3dd17caf 100644
> > > --- a/fs/btrfs/ordered-data.c
> > > +++ b/fs/btrfs/ordered-data.c
> > > @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> > >   	struct btrfs_ordered_extent *entry;
> > >   	int ret;
> > >   	u64 qgroup_rsv = 0;
> > > +	const bool is_nocow = (flags &
> > > +	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
> > > -	if (flags &
> > > -	    ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
> > > +	if (is_nocow) {
> > >   		/* For nocow write, we can release the qgroup rsv right now */
> > >   		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
> > >   		if (ret < 0)
> > > @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> > >   			return ERR_PTR(ret);
> > >   	}
> > >   	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
> > > -	if (!entry)
> > > +	if (!entry) {
> > > +		if (!is_nocow)
> > > +			btrfs_qgroup_free_refroot(inode->root->fs_info,
> > > +						  btrfs_root_id(inode->root),
> > > +						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
> > >   		return ERR_PTR(-ENOMEM);
> > > +	}
> > >   	entry->file_offset = file_offset;
> > >   	entry->num_bytes = num_bytes;
> > > -- 
> > > 2.47.2
> > > 
> > 
> 

