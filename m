Return-Path: <linux-btrfs+bounces-8597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D4993A3C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92D51C23228
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 22:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1BF18C344;
	Mon,  7 Oct 2024 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="N+zOZu74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yq2xftk6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC6155C97
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340259; cv=none; b=Vs2t/5yebsqpY77KOHhlCaadLDJrz9hSSvqL0TmSv4cvV78KiLeCXY2j42EyPIE6gwfB5fPR8skP1JfXgZwIvJIbnaMMPSZmbR5gxf8Ya1EfR/6uNzEu6K6ZSX/5WUZ7orm4jMfBv2HUpTYMQq6IurJ2kOzKAZG2C70lMp5ZAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340259; c=relaxed/simple;
	bh=ShWgOwRyI3sziovxgHOAdsp7uo26ATfkvhs7NfG8Jag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5zU5vvnC5VzsjdN9urg1J1tYWKG6UXzRTgihp1OZgifDoW6v5C/9pEAjJzZxKn0FYkOD+qd68xpJvtFdw0qMpZfDfk9fd8I8YdlVbmft2R4vQbPSp54UnYDdAAKJiAquvEy6iYPXrnk/Xc+fWvRy0TbzBhnttwsOz+6pctiXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=N+zOZu74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yq2xftk6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48D0A1140234;
	Mon,  7 Oct 2024 18:30:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 18:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1728340255;
	 x=1728426655; bh=2Zk3m5AJ4eGRB6ZKr2zFQJFdPNj2Sv3OfKe68rtGqzQ=; b=
	N+zOZu74HZ4dPFSe/IvPzN7gam1uper5TymXhaFmFqSc/HopvoP9/VRY6KmEVtBY
	Rc71kWV7URNX2NGKBnOnSYSoZjiEppAfU2PN+li026VhmTBNQJB5hltO+WcYY2rk
	JJTMiVkImIJIHwA7hU4Md2VwIJ2WiA24IkFFztSngqHUjablDXz+grRaygDQMKIt
	r09li7EVPx9lT1I3Z6VqvqLdV2c1l8LJ/rrbdzb+6YTjaX6/4dRwVBcI1SvVn6RU
	6ksb9KHMaiu17zNBemTk8xBPnQmRfJZfH9yPeu5upgCXcwRX2lfL+OdfQ/eQxwuk
	ewZ4DYW7f1se10gPCroU0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728340255; x=
	1728426655; bh=2Zk3m5AJ4eGRB6ZKr2zFQJFdPNj2Sv3OfKe68rtGqzQ=; b=Y
	q2xftk6x8+IJHPNQw5IZhh2qRL9DK+t+bNTeZItOecHKkBJ6XzqyyzGuU1T8Fu82
	8s5jn1tHsC5GDNEOhqrfy3Ij/CsX2DIS2uHqWdW+g+DFRP9fHj/J1tYlUp6jKy8U
	8HFhV5KgtaNdRscPRvPdHj37FZYl3Jubca3Rw+ZdweSciafShsAs6qvX2fw4QTY4
	DFTIDAjWePtTK32BWNotM3W2jiPxw9+XEhbEXdp9gQuDJhG/S1La1TOIIgHtFO9T
	BHzGFj9TJUqJYeXKuanmV5H3CCs3j2KrmuY1OSGAuk88zXM94pNNB/lMzdZsiKOL
	7wCImHpeit/WtLORb8cgg==
X-ME-Sender: <xms:HmEEZ-8uVcBe8nVpipZ9777E92PCVEe1SfxL6D9ZSxGXKecpiW8TcA>
    <xme:HmEEZ-vRuTrt7yNXwpUY6mpPhIWqBgQqmxj6lwTuT2fCj4TiQJRAw938ptTdrD0SX
    rF_N9MEs6mWI1GWlEc>
X-ME-Received: <xmr:HmEEZ0Dbuzn3SdCMZT8KUj5GJca1H9Ol0zdrTj8LKKdxpXMIFLopFTZbyEx770SA2oCmkV06jMQYfOC0clo1nCiW_ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhephfdukeeijeffvdduudefueefgffgteethefgheffgfdvgfel
    leeuhedtudehtdejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhhunhdrshhhpd
    hlphgtrdgvvhgvnhhtshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:HmEEZ2dG2z-qVuyhQGnR2srl96eEYYQzbWBRurg8c06l04ZbEYGg7g>
    <xmx:HmEEZzNI1abtBgyWh80R7zVvlxVTpBN9HUI88GxNtMMhDCPITnQGAw>
    <xmx:HmEEZwksmPGO_CgtxBhMtTSZnHKnT7-uOnQ8ISPIVLUoH2ON5aSBOQ>
    <xmx:HmEEZ1tnRG4_Wy2lyy8osRuC2RpXCbwqfvngAqXuoO6WPnabYs3DKg>
    <xmx:H2EEZ8qp7IGXAlt8H3GinZR3v5WBjmP0xUsMQGURpcTMlW-FACLHL5EK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 18:30:54 -0400 (EDT)
Date: Mon, 7 Oct 2024 15:30:45 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: try to search for data csums in commit root
Message-ID: <20241007223045.GA388113@zen.localdomain>
References: <9d12c373a49184e84897ff2d6df601f2c7c66a32.1728084164.git.boris@bur.io>
 <6a34b96c-0b00-46c8-a0e8-69f0028173e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a34b96c-0b00-46c8-a0e8-69f0028173e4@suse.com>

On Sat, Oct 05, 2024 at 04:30:29PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/10/5 08:53, Boris Burkov 写道:
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
> >    as readers, but not scheduling promptly. i.e., task __state == 0, but
> >    not running on a cpu.
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
> 
> The idea looks good to me.
> 
> The extent_map::generation is updated to the larger one during merge, so if
> we got a em whose generation is smaller than the current generation it's
> definitely older.
> 
> And since data extents in commit root won't be overwritten until the current
> transaction committed, so it should also be fine.
> 
> 
> But my concern is, the path->need_commit_sem is only blocking transaction
> from happening when the path is holding something.
> And inside search_csum_tree() we can release the path halfway, would that
> cause 2 transaction to be committed during that release window?
> 
> Shouldn't we hold the semaphore manually inside btrfs_lookup_bio_sums()
> other than relying on the btrfs_path::need_commit_sem?

Yes, I think you are right. Good catch! I will test that version and
re-send, assuming it still works well.

> 
> Thanks,
> Qu
> > 
> > This change detects when we are trying to read an old extent (according
> > to extent map generation) and then wires that through bio_ctrl to the
> > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > information. When we go to lookup the csums in lookup_bio_sums we can
> > check this condition on the btrfs_bio and do the commit root lookup
> > accordingly.
> > 
> > With the fix, on that same test case, commit latencies no longer exceed
> > ~400ms on my system.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/bio.h       |  1 +
> >   fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
> >   fs/btrfs/file-item.c |  7 +++++++
> >   3 files changed, 29 insertions(+)
> > 
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index e48612340745..159f6a4425a6 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -48,6 +48,7 @@ struct btrfs_bio {
> >   			u8 *csum;
> >   			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
> >   			struct bvec_iter saved_iter;
> > +			bool commit_root_csum;
> >   		};
> >   		/*
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index cb0a39370d30..8544fe2302ff 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
> >   	 * This is to avoid touching ranges covered by compression/inline.
> >   	 */
> >   	unsigned long submit_bitmap;
> > +	/*
> > +	 * If this is a data read bio, we set this to true if it is safe to
> > +	 * search for csums in the commit root. Otherwise, it is set to false.
> > +	 *
> > +	 * This is an optimization to reduce the contention on the csum tree
> > +	 * root rwsem. Due to how rwsem is implemented, there is a possible
> > +	 * priority inversion where the readers holding the lock don't get
> > +	 * scheduled (say they're in a cgroup stuck in heavy reclaim) which
> > +	 * then blocks btrfs transactions. The only real help is to try to
> > +	 * reduce the contention on the lock as much as we can.
> > +	 *
> > +	 * Do this by detecting when a data read is reading data from an old
> > +	 * transaction so it's safe to look in the commit root.
> > +	 */
> > +	bool commit_root_csum;
> >   };
> >   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> > @@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
> >   			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
> >   				      folio_pos(folio) + pg_offset);
> >   		}
> > +		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ && is_data_inode(inode))
> > +			bio_ctrl->bbio->commit_root_csum = bio_ctrl->commit_root_csum;
> > +
> >   		/* Cap to the current ordered extent boundary if there is one. */
> >   		if (len > bio_ctrl->len_to_oe_boundary) {
> > @@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >   		if (prev_em_start)
> >   			*prev_em_start = em->start;
> > +		if (em->generation < btrfs_get_fs_generation(fs_info))
> > +			bio_ctrl->commit_root_csum = true;
> > +
> >   		free_extent_map(em);
> >   		em = NULL;
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 886749b39672..2433b169a4e6 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> >   		path->skip_locking = 1;
> >   	}
> > +	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
> > +	if (bbio->commit_root_csum) {
> > +		path->search_commit_root = 1;
> > +		path->skip_locking = 1;
> > +		path->need_commit_sem = 1;
> > +	}
> > +
> >   	while (bio_offset < orig_len) {
> >   		int count;
> >   		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
> 

