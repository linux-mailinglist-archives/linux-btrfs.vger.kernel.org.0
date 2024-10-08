Return-Path: <linux-btrfs+bounces-8634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A2993E8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 08:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09412859CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D013E02B;
	Tue,  8 Oct 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="id4wcN0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niimqrMv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341747E101
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367255; cv=none; b=mxgSvFDWfAx+jNYkuqDBX+xmvwXtRmIqdPTFBtV3MeospnmNY6CGX76Q+U2XmM9hSk9qP5gh+KA06F2RZrlfccOCH3OSP+sgUagK3FricfMLsEHIvgGKuT8DWhaSyeAU9fnMNbaKSc9rJY+kueuPL8f9dadruEJHpMZYP4Cvj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367255; c=relaxed/simple;
	bh=3SzuBTJxoWhFbvhc/Q56yZHtLqzOjQRt4aQoIPeViD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiP93BKv2DPKnCkmZ8Px7WyY8L3sDRf+ilevg43gjmnCOeFPfTmmEBsyd2eoff66H8posmkByGfGd3SDH3UAy20X24k3v95Uq+XfNwznwhwInudotVA0Uj7jyMIx25NGy7HU7yEW3ls0/rFOMXtdg6cjMlS+S0RrLeLmUtc6ThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=id4wcN0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niimqrMv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25CB0114028B;
	Tue,  8 Oct 2024 02:00:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 08 Oct 2024 02:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1728367251;
	 x=1728453651; bh=Spep7LSdHJvHPdy/K1FwoNv0TYcR9fLFQncYRA5dPg8=; b=
	id4wcN0R9IMu2ThS4nDToP1ljuGuZumTJtNCrO+CtAr7i7M0u2aF6gNRyrozXQxO
	Z9IW48QLZCyA1mDqlTNn0IJHKjoqRBw/l7C9sL0Nwhg8KEyX1liE6ishbq+4dAnq
	E0lOFEuQ1dCkr6ozCH7t2Xmi94E+B21Uje3donnGRWiK1R+GgGuBeXPGoMjthR0z
	ob+GWxhmEbvWGAtL5ttXmlO4c1rA2N5yqvDMI7ahObvW+JTzpnzHj96SbZcQLSkM
	TFl61ZREjpn6NDZyccD/ZFk9IvONW3ttGN2LPCPGJRnvpuXfF1jC+rETrCy4xQJ9
	7pTbxbQMp/dSztBAe2fjkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728367251; x=
	1728453651; bh=Spep7LSdHJvHPdy/K1FwoNv0TYcR9fLFQncYRA5dPg8=; b=n
	iimqrMvs01BsELLwi79LRJueszNUdcHZGsMgA/8hq0gM1wqr9HgUd+d0RG1roKIf
	a2BHi30cih/WitL9ZBg761C7ee9xeXztijyFv6i9ZrWo/QfzVbaqUiRVFBuKef9/
	Xr0H8bxY4pxx8Td2xQ5uyWTXQZ90rgGpPzQK//rC9SrrZxD9bSZzn4tIgl2VUif2
	n5JhjRt7lXZOolXFKQI9jyjV4EyYYt9dd+5YqkByoiU1ypHk/jG1AWMz1tjynLRf
	r8tpmXkqcEdwqdqHBSOOobMrYNHh1ZBfiJns2UnjxvRGsXM0gGteMtBr6fzJN/J2
	kFSqPlcDi+eTWiOFhfPYw==
X-ME-Sender: <xms:ksoEZ91JSGYpVPim10SZRpet7usiGhuSvKOAsUvn7kE9YbCSRkgqNA>
    <xme:ksoEZ0Ed1oShlppaCves8eKYrqkLMkAgaEw7QCKUfnvVmm4o0F7TpdzdHvJTvlcMW
    FpDqQfJuJXxIHnp0vI>
X-ME-Received: <xmr:ksoEZ94yvzojWgxc49hIt68TA9DqI7JLnxyNEzoSLEG5a0ij0_VaemMVs-mTrCsrMP_QzB5uz2iSoa4Bbv_m6MKqvtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpefhudekieejffdvuddufeeufefggfetteehgfehfffgvdfg
    leelueehtdduhedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhruhhnrdhshh
    dplhhptgdrvghvvghnthhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhm
    gidrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlih
    hnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:ksoEZ62Ip3jBk3YtfV7bkY0DHX69YRMp54kO2k3dFd7yf1XGDPTB3A>
    <xmx:ksoEZwFk4CWsBand-hsQ_UeeqxRr5pY7aVVUnZgnCtlxa1FaaPS78Q>
    <xmx:ksoEZ78WNkpy1EFVMEFaUBFWO4DXku_MPph3MsPG2CHgkHM7vh7hEg>
    <xmx:ksoEZ9naKD7rDh-S3Ikr3BxobywSejg-KecJ3ZAILkW4jvUpoazh6g>
    <xmx:k8oEZ8iLfyAqjfjN1Csx8-g9wuJuIbD0nQw-lCFvrCepjjGyRX-P08VS>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 02:00:50 -0400 (EDT)
Date: Mon, 7 Oct 2024 23:00:40 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: try to search for data csums in commit root
Message-ID: <20241008060040.GA416028@zen.localdomain>
References: <9d12c373a49184e84897ff2d6df601f2c7c66a32.1728084164.git.boris@bur.io>
 <6a34b96c-0b00-46c8-a0e8-69f0028173e4@suse.com>
 <20241007223045.GA388113@zen.localdomain>
 <2aac3cdc-4b99-491b-8b52-f27803bc37fe@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aac3cdc-4b99-491b-8b52-f27803bc37fe@gmx.com>

On Tue, Oct 08, 2024 at 10:13:03AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/8 09:00, Boris Burkov 写道:
> > On Sat, Oct 05, 2024 at 04:30:29PM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2024/10/5 08:53, Boris Burkov 写道:
> > > > If you run a workload like:
> > > > - a cgroup that does tons of data reading, with a harsh memory limit
> > > > - a second cgroup that tries to write new files
> > > > e.g.:
> > > > https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
> > > > 
> > > > then what quickly occurs is:
> > > > - a high degree of contention on the csum root node eb rwsem
> > > > - memory starved cgroup doing tons of reclaim on CPU.
> > > > - many reader threads in the memory starved cgroup "holding" the sem
> > > >     as readers, but not scheduling promptly. i.e., task __state == 0, but
> > > >     not running on a cpu.
> > > > - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> > > > 
> > > > This results in VERY long transactions. On my test system, that script
> > > > produces 20-30s long transaction commits. This then results in
> > > > seriously degraded performance for any cgroup using the filesystem (the
> > > > victim cgroup in the script).
> > > > 
> > > > This reproducer is a bit silly, as the villanous cgroup is using almost
> > > > all of its memory.max for kernel memory (specifically pagetables) but it
> > > > sort of doesn't matter, as I am most interested in the btrfs locking
> > > > behavior. It isn't an academic problem, as we see this exact problem in
> > > > production at Meta with one cgroup over memory.max ruining btrfs
> > > > performance for the whole system.
> > > > 
> > > > The underlying scheduling "problem" with global rwsems is sort of thorny
> > > > and apparently well known. e.g.
> > > > https://lpc.events/event/18/contributions/1883/
> > > > 
> > > > As a result, our main lever in the short term is just trying to reduce
> > > > contention on our various rwsems. In the case of the csum tree, we can
> > > > either redesign btree locking (hard...) or try to use the commit root
> > > > when we can. Luckily, it seems likely that many reads are for old extents
> > > > written many transactions ago, and that for those we *can* in fact
> > > > search the commit root!
> > > 
> > > The idea looks good to me.
> > > 
> > > The extent_map::generation is updated to the larger one during merge, so if
> > > we got a em whose generation is smaller than the current generation it's
> > > definitely older.
> > > 
> > > And since data extents in commit root won't be overwritten until the current
> > > transaction committed, so it should also be fine.
> > > 
> > > 
> > > But my concern is, the path->need_commit_sem is only blocking transaction
> > > from happening when the path is holding something.
> > > And inside search_csum_tree() we can release the path halfway, would that
> > > cause 2 transaction to be committed during that release window?
> > > 
> > > Shouldn't we hold the semaphore manually inside btrfs_lookup_bio_sums()
> > > other than relying on the btrfs_path::need_commit_sem?
> > 
> > Yes, I think you are right. Good catch! I will test that version and
> > re-send, assuming it still works well.
> 
> The problem is, if we hold the semaphore that long, it will be no better
> than the regular tree search method...

Quite possible, I have a hard time seeing a difference for the reader
logic.

But! There is good news: you need a writer in the wait queue to trigger
the full worst version of this where some readers are "holding" the lock
but starved on CPU while other readers pile up in the wait queue with
the writer. Without a writer, all the other readers also acquire the
semaphore successfully and hopefully make progress. And the
commit_root_sem should have much less write contention than the csum
tree route node.

I'll test the performance of your fix on the reproducer tomorrow and
hopefully come back with happy news :)

> 
> So I'm out of good ideas.
> 
> Thanks,
> Qu
> > 
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > This change detects when we are trying to read an old extent (according
> > > > to extent map generation) and then wires that through bio_ctrl to the
> > > > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > > > information. When we go to lookup the csums in lookup_bio_sums we can
> > > > check this condition on the btrfs_bio and do the commit root lookup
> > > > accordingly.
> > > > 
> > > > With the fix, on that same test case, commit latencies no longer exceed
> > > > ~400ms on my system.
> > > > 
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >    fs/btrfs/bio.h       |  1 +
> > > >    fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
> > > >    fs/btrfs/file-item.c |  7 +++++++
> > > >    3 files changed, 29 insertions(+)
> > > > 
> > > > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > > > index e48612340745..159f6a4425a6 100644
> > > > --- a/fs/btrfs/bio.h
> > > > +++ b/fs/btrfs/bio.h
> > > > @@ -48,6 +48,7 @@ struct btrfs_bio {
> > > >    			u8 *csum;
> > > >    			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
> > > >    			struct bvec_iter saved_iter;
> > > > +			bool commit_root_csum;
> > > >    		};
> > > >    		/*
> > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > index cb0a39370d30..8544fe2302ff 100644
> > > > --- a/fs/btrfs/extent_io.c
> > > > +++ b/fs/btrfs/extent_io.c
> > > > @@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
> > > >    	 * This is to avoid touching ranges covered by compression/inline.
> > > >    	 */
> > > >    	unsigned long submit_bitmap;
> > > > +	/*
> > > > +	 * If this is a data read bio, we set this to true if it is safe to
> > > > +	 * search for csums in the commit root. Otherwise, it is set to false.
> > > > +	 *
> > > > +	 * This is an optimization to reduce the contention on the csum tree
> > > > +	 * root rwsem. Due to how rwsem is implemented, there is a possible
> > > > +	 * priority inversion where the readers holding the lock don't get
> > > > +	 * scheduled (say they're in a cgroup stuck in heavy reclaim) which
> > > > +	 * then blocks btrfs transactions. The only real help is to try to
> > > > +	 * reduce the contention on the lock as much as we can.
> > > > +	 *
> > > > +	 * Do this by detecting when a data read is reading data from an old
> > > > +	 * transaction so it's safe to look in the commit root.
> > > > +	 */
> > > > +	bool commit_root_csum;
> > > >    };
> > > >    static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> > > > @@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
> > > >    			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
> > > >    				      folio_pos(folio) + pg_offset);
> > > >    		}
> > > > +		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ && is_data_inode(inode))
> > > > +			bio_ctrl->bbio->commit_root_csum = bio_ctrl->commit_root_csum;
> > > > +
> > > >    		/* Cap to the current ordered extent boundary if there is one. */
> > > >    		if (len > bio_ctrl->len_to_oe_boundary) {
> > > > @@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> > > >    		if (prev_em_start)
> > > >    			*prev_em_start = em->start;
> > > > +		if (em->generation < btrfs_get_fs_generation(fs_info))
> > > > +			bio_ctrl->commit_root_csum = true;
> > > > +
> > > >    		free_extent_map(em);
> > > >    		em = NULL;
> > > > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > > > index 886749b39672..2433b169a4e6 100644
> > > > --- a/fs/btrfs/file-item.c
> > > > +++ b/fs/btrfs/file-item.c
> > > > @@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> > > >    		path->skip_locking = 1;
> > > >    	}
> > > > +	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
> > > > +	if (bbio->commit_root_csum) {
> > > > +		path->search_commit_root = 1;
> > > > +		path->skip_locking = 1;
> > > > +		path->need_commit_sem = 1;
> > > > +	}
> > > > +
> > > >    	while (bio_offset < orig_len) {
> > > >    		int count;
> > > >    		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
> > > 
> > 
> 

