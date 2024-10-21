Return-Path: <linux-btrfs+bounces-9042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B89A9037
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20AA1F2361B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A51CEEBB;
	Mon, 21 Oct 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Gf6qf8Wg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evFx6+b4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1211C9B82
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540380; cv=none; b=JJBx9nQ8rq0D0QRF3cRva1PQZT8uyURWza/pgMALYiBbFs14bdMSqnaFMLmO3o7Of5XlEpMbt1mVvjIHFxjyDHTDrUuiCe0gOzrNKi4GhEy/Vrxpur+IkJnR3CuUjqFUy4P93f16u+8Rerz9yliZIFx9aEz6U5iK8s9qVQTew/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540380; c=relaxed/simple;
	bh=KCHZTYmtNJdfKl4AiUHMmPNQip2ySOy49owtXNu4gys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab+rLxvQGjiWz7gNv2mUTArCXKuBhxAe3ayz9TtYTUEYeyewpV3WZGSDP/utf4MCPtAtcO85Y5NRWoTfWJjtp8KfOsQDyK5/aIEAM9TLWP9etGU9R2XGMeoatAZf6p1DDp31+BMitsghWOo7h2gbr2CJn4zn3ypSPuLV33fKGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Gf6qf8Wg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evFx6+b4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 40FAA1380132;
	Mon, 21 Oct 2024 15:52:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 15:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1729540376; x=1729626776; bh=m15VSTT2EM
	Hr6Fz6Acym00FOrWzr4/4rffiIUJtUsQA=; b=Gf6qf8WgA4/lwnw0SQkcVZ3QZg
	Wss9uC38Wm0DT5uHMbHYYoxdL1Qpuv/PqAn1zT+WycPoAuBZNmPvAUQoGkrvAR8G
	p99DgPI5svoySMwCDxIJGK/dRft9pWy74YIoZ7iojn4k8NNUPBR9nXhMxb/jolch
	wOPGVDAYLjOoW3CP3nctxqkaiPtMyuToqy74DWWKBdU2nuRTeOCyjDLhKkecoMuX
	OkShy+jX+2RM6dJPfcgvjNo+fBVktwV/YTQ94tALURMXRrpAtT0HsmnpGMYOEmJf
	tUiQx9faZLoF2pMvg+H11a7AWJWxaHV/jD0+jKF/RgS9FE7I2cOE23zCSvLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729540376; x=1729626776; bh=m15VSTT2EMHr6Fz6Acym00FOrWzr
	4/4rffiIUJtUsQA=; b=evFx6+b44ihpGOA8I/pA52B+BMa99dwqFwXwUClSDRi7
	QzLP40W9boHnJDWuRaaFp6QZt17huwzS619LuXi4oe+8vIqpZ3PyPF+h5rqvGK1/
	hNIMPEG0MQZW2SSqA4G23ilo6sSVsoY9Kbjym60vlWULKe0/iCE2H1g5PNe1vQov
	t1GuxG1oxmmsQ4zHUI/+CE1wAXjhh0PtjEWFPrJfD4U1W68ukCyE8I0VCrv8Rtv3
	RfmevcJ1F2X/Qs0sUJJvI1Bkmlqy5ZXIm53R3FvXySNj+1JgacOyFGdE5vGlXbg/
	hrLvtQsrbqfveQnCNaBn7iEr2xGa9qQAMpkFrEk7jg==
X-ME-Sender: <xms:F7EWZzsdX8Py2x3y1i2D-8p5DI8pKtGiNH-1rEHA08YJCXCX3Jz2vw>
    <xme:F7EWZ0eQHAiCG-VacEGVfOhXrgVGViehrbXJ-2rrDCfwLpNUonQB9jW8zYmKGYiar
    qfhsbcOi3shCu9bIxQ>
X-ME-Received: <xmr:F7EWZ2yQnagVrpfLr3NnXkuyYaArsnlCywfcuwRtutLtqfNPCqzSy3mb7UBUG56mPOQXxn3RDWf3lW69y0NJMqITPhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepieetieeggfekkeduiedtiefggfelueevleehteeuvefgvdel
    kefhledukeeihedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhhunhdrshhhpd
    hlphgtrdgvvhgvnhhtshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgt
    phhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:F7EWZyPySmtoLGLv48dmmjJ1ah1xPM-YdQJKFCUfUPvlbdOEElYeVA>
    <xmx:F7EWZz9P_NJEVF2E2hxr4424p_agB3jkj0Yk4uCv5HyeE_8li405Jw>
    <xmx:F7EWZyX0mrWctI6-Es5QAfWYHO2pi6Kvoz9dOlB95IU606HRSYW3yQ>
    <xmx:F7EWZ0fDDCWbLuYOR9QxHxulSOHs7HKQgKH7gQTbGDX9CKDxwEfQbA>
    <xmx:GLEWZ2bZndCU10mIDPATekyMsGJxleYglu3DPoqyJ0ZYL6d4fQqeU4Ew>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:52:55 -0400 (EDT)
Date: Mon, 21 Oct 2024 12:52:23 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5] btrfs: try to search for data csums in commit root
Message-ID: <20241021195223.GA2880675@zen.localdomain>
References: <8e334e4412410a46d3928950c796c9914cebdf92.1729537203.git.boris@bur.io>
 <20241021191035.GE24631@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021191035.GE24631@twin.jikos.cz>

On Mon, Oct 21, 2024 at 09:10:35PM +0200, David Sterba wrote:
> On Mon, Oct 21, 2024 at 12:01:53PM -0700, Boris Burkov wrote:
> > If you run a workload like:
> > - a cgroup that does tons of data reading, with a harsh memory limit
> > - a second cgroup that tries to write new files
> > e.g.:
> > https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
> > 
> > then what quickly occurs is:
> > - a high degree of contention on the csum root node eb rwsem
> > - memory starved cgroup doing tons of reclaim on CPU.
> > - many reader threads in the memory starved cgroup "holding" the sem
> >   as readers, but not scheduling promptly. i.e., task __state == 0, but
> >   not running on a cpu.
> > - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> > 
> > This results in VERY long transactions. On my test system, that script
> > produces 20-30s long transaction commits. This then results in
> > seriously degraded performance for any cgroup using the filesystem (the
> > victim cgroup in the script).
> > 
> > This reproducer is a bit silly, as the villanous cgroup is using almost
> > all of its memory.max for kernel memory (specifically pagetables) but it
> > sort of doesn't matter, as I am most interested in the btrfs locking
> > behavior. It isn't an academic problem, as we see this exact problem in
> > production at Meta with one cgroup over memory.max ruining btrfs
> > performance for the whole system.
> > 
> > The underlying scheduling "problem" with global rwsems is sort of thorny
> > and apparently well known. e.g.
> > https://lpc.events/event/18/contributions/1883/
> > 
> > As a result, our main lever in the short term is just trying to reduce
> > contention on our various rwsems. In the case of the csum tree, we can
> > either redesign btree locking (hard...) or try to use the commit root
> > when we can. Luckily, it seems likely that many reads are for old extents
> > written many transactions ago, and that for those we *can* in fact
> > search the commit root!
> > 
> > This change detects when we are trying to read an old extent (according
> > to extent map generation) and then wires that through bio_ctrl to the
> > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > information. Luckily, we don't need this flag in the bio after
> > submitting, so we can save space by setting it on bbio->bio.bi_flags
> > and clear before submitting, so the block layer is unaffected.
> > 
> > When we go to lookup the csums in lookup_bio_sums we can check this
> > condition on the btrfs_bio and do the commit root lookup accordingly.
> > 
> > With the fix, on that same test case, commit latencies no longer exceed
> > ~400ms on my system.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v5:
> > - static inline flag functions
> > - make bbio const for the getter
> > - move around and improve the comments
> 
> v5 looks good, thanks.
> 
> > v4:
> > - replace generic private flag machinery with specific function for the
> >   one flag
> > - move the bio_ctrl field to take advantage of alignment
> > v3:
> > - add some simple machinery for setting/getting/clearing btrfs private
> >   flags in bi_flags
> > - clear those flags before bio_submit (ensure no-op wrt block layer)
> > - store the csum commit root flag there to save space
> > v2:
> > - hold the commit_root_sem for the duration of the entire lookup, not
> >   just per btrfs_search_slot. Note that we can't naively do the thing
> >   where we release the lock every loop as that is exactly what we are
> >   trying to avoid. Theoretically, we could re-grab the lock and fully
> >   start over if the lock is write contended or something. I suspect the
> >   rwsem fairness features will let the commit writer get it fast enough
> >   anyway.
> > 
> > ---
> >  fs/btrfs/bio.c       |  8 ++++++++
> >  fs/btrfs/bio.h       | 17 +++++++++++++++++
> >  fs/btrfs/extent_io.c | 20 ++++++++++++++++++++
> >  fs/btrfs/file-item.c | 30 ++++++++++++++++++++++++++++++
> >  4 files changed, 75 insertions(+)
> > 
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 1f216d07eff6..4d675f6dd3e9 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -482,6 +482,14 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
> >  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
> >  			     struct btrfs_io_stripe *smap, int mirror_num)
> >  {
> > +	/*
> > +	 * It is important to clear the bits we used in bio->bi_flags.
> > +	 * Because bio->bi_flags belongs to the block layer, we should
> > +	 * avoid leaving stray bits set when we transfer ownership of
> > +	 * the bio by submitting it.
> > +	 */
> > +	btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> > +
> >  	if (!bioc) {
> >  		/* Single mirror read/write fast path. */
> >  		btrfs_bio(bio)->mirror_num = mirror_num;
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index e2fe16074ad6..8915863d0d0f 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> >  				  btrfs_bio_end_io_t end_io, void *private);
> >  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
> >  
> > +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1))
> > +
> > +static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
> > +{
> > +	bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > +}
> > +
> > +static inline void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
> > +{
> > +	bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > +}
> > +
> > +static inline bool btrfs_bio_csum_search_commit_root(const struct btrfs_bio *bbio)
> > +{
> > +	return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > +}
> > +
> >  /* Submit using blkcg_punt_bio_submit. */
> >  #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
> >  
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 1beaba232532..bdd7673d989c 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -99,6 +99,15 @@ struct btrfs_bio_ctrl {
> >  	enum btrfs_compression_type compress_type;
> >  	u32 len_to_oe_boundary;
> >  	blk_opf_t opf;
> > +	/*
> > +	 * If this is a data read bio, we set this to true if the extent is
> > +	 * from a past transaction and thus it is safe to search for csums
> > +	 * in the commit root. Otherwise, we set it to false.
> > +	 *
> > +	 * See the comment in btrfs_lookup_bio_sums for more detail on the
> > +	 * need for this optimization.
> > +	 */
> > +	bool csum_search_commit_root;
> >  	btrfs_bio_end_io_t end_io_func;
> >  	struct writeback_control *wbc;
> >  
> > @@ -771,6 +780,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
> >  			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
> >  				      folio_pos(folio) + pg_offset);
> >  		}
> > +		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ &&
> > +		    is_data_inode(inode) && bio_ctrl->csum_search_commit_root)
> > +			btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
> >  
> >  		/* Cap to the current ordered extent boundary if there is one. */
> >  		if (len > bio_ctrl->len_to_oe_boundary) {
> > @@ -1049,6 +1061,14 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >  		if (prev_em_start)
> >  			*prev_em_start = em->start;
> >  
> > +		/*
> > +		 * At this point, we know it is safe to search for
> > +		 * csums in the commit root, but we have not yet
> > +		 * allocated a bio, so stash it in bio_ctrl.
> > +		 */
> > +		if (em->generation < btrfs_get_fs_generation(fs_info))
> > +			bio_ctrl->csum_search_commit_root = true;
> > +
> >  		free_extent_map(em);
> >  		em = NULL;
> >  
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 886749b39672..cd63769959f9 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -401,6 +401,33 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> >  		path->skip_locking = 1;
> >  	}
> >  
> > +	/*
> > +	 * If we are searching for a csum of an extent from a past
> > +	 * transaction, we can search in the commit root and reduce
> > +	 * lock contention on the csum tree root node's extent buffer.
> > +	 *
> > +	 * This is important because that lock is an rwswem which gets
> > +	 * pretty heavy write load, unlike the commit_root_csum.
>                                                ^^^^^^^^^^^^^^^^
> 
> commit_root_sem?
> 
> > +	 *
> > +	 * Due to how rwsem is implemented, there is a possible
> > +	 * priority inversion where the readers holding the lock don't
> > +	 * get scheduled (say they're in a cgroup stuck in heavy reclaim)
> > +	 * which then blocks writers, including transaction commit. By
> > +	 * using a semaphore with fewer writers (only a commit switching
> > +	 * the roots), we make this issue less likely.
> > +	 *
> > +	 * Note that we don't rely on btrfs_search_slot to lock the
> > +	 * commit root csum. We call search_slot multiple times, which would
>                        sem
> 
> > +	 * create a potential race where a commit comes in between searches
> > +	 * while we are not holding the commit_root_csum, and we get csums
>                                                     sem
> 
> Only typos so you can fix it once you add it to for-next, also please
> reflow the comments so they fit 80 columns per line.

Oops, my bad on the typos. I could not find any comment over 80 columns,
so I pushed it as-is. Let me know what I missed and I am happy to do the
fixup...

> 
> Reviewed-by: David Sterba <dsterba@suse.com>

