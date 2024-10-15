Return-Path: <linux-btrfs+bounces-8939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C799F4BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB861C22192
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD78227B85;
	Tue, 15 Oct 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JAnuI+W2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTI60vPN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED91FC7D0
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015331; cv=none; b=LDYKD0fpjlYiq9N3sj9Nu+phL9gQEnN/TS2bsO6tcJwEaz/zbRVVQ09M1JQMnYiq6gwkOgykQ1nSTNj7aJD2wAw5mrAdRt2WGMI0xYuANkXlV7n2kerPPocoxRq3PRABb6FqNxua0VWAYCHeULTdvZTSA+Sfmx0L+5h7gmNBFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015331; c=relaxed/simple;
	bh=rBZbnYzLDTOKjr3A/i9p/aUbnmf6RWc6cvp2aPE+3cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXLcnsT3llluzLWCGMklLDTdajTk6mlCdtUWJhV20lJ8WG1Jui1pdYn2FwK0MJNp4Q3Y1JyxcT3evS4J6CwRe1xqAzm2E+vfBr7brqwwVOjx6HW2YnznBlINLBIe380TOY6GlNAypnSeIhEWKsROkCD8ICcs+S6dUGNMdkaicUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JAnuI+W2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTI60vPN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C41A1140177;
	Tue, 15 Oct 2024 14:02:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 14:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729015327; x=1729101727; bh=C5Nu1OnywM
	eEfSU2ihH2oohCe2PWu/11IALRjCoN4tg=; b=JAnuI+W2ZpJuDrCUgZceIfz7/f
	oIZYUQipwQ9N/WtMjNChqN5sQMdnlpKREgs+JSsPbaQ+qaEl8HXXEYpBdajXSZ7s
	0m/6GkUbcJCbavP0YfO2UjI4vhmKeM6+ZkhdBx9NTExN9VcYShIKt5toZwifwkSY
	Ekl/kMq0uXgX/HAuiOgq8EE9d4bY8zqlxa2syzThnSaXYIUcVPapi3iunohYrg5S
	6VPL1acXOSXF58gTYxvE8FaUF8YNvQRnCNvaVGKodpeWwI4Uk4XrK9PfLM1HKNlh
	gChwStxNrAbAA3IjT5puEjbIjWxY7k96jduB9hs+vWnm8wxEHi9xXNJaxiww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729015327; x=1729101727; bh=C5Nu1OnywMeEfSU2ihH2oohCe2PW
	u/11IALRjCoN4tg=; b=iTI60vPNECYEWyFwd8LXcx3+QWf3eZ/WcDZH7+8Fo0IJ
	ndMKACUijB0XaTrJ7r+dTqkjJQSFSUgsR2jE/5BKSi9odFAjAR7PENPRIfwMH974
	7GgH/16VqDjLIrFsYCy6ob1HXVnOOU8Mq2auq3upZOMzM2oglA9M4jc/XM1EZ4y0
	bBJl+9khiXLLxgcxJBbP0I6VQx5K5XSlGsPyegk3FGk6CoFhA0aQn5mEiSadZpj7
	CO58TsmKYV1L5RmyE+Mq16RRbKVi9unUHIem9Bq7u7uWA6czJauzQ9PMBB4yMwuE
	4gIRVmS1BG5uAtjv2Ip5SOs93qSGGvj5wDhvXcFXqQ==
X-ME-Sender: <xms:H64OZ99VSOf_jBR3RCU7ubFzKu4H_tnKn_UyduRv5mKRZStDzKmRcw>
    <xme:H64OZxsGfUqwKHDSTyqgoywRkVq6ISsNQtrOShlhfJ3pUmAgEY6PVp9hKG7AFIPHC
    KmIA8GP7bCetAmb-n4>
X-ME-Received: <xmr:H64OZ7Az_AyTjDuZYFetBFLFkrBU3X0Wubi_7TJJKMATGD3N9sako94hul5INmw4pYYxlxlqzTNBq14ZoHjuoQHJ8Fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:H64OZxeO9ahPEnP9d_JOpnSbmtCg9yxpc1T6n5kNItdejRkQ9xchFg>
    <xmx:H64OZyPurbnE1rbMymruANRhIdF4txpeMhzyYNd06kRq4yHojqYRbg>
    <xmx:H64OZzlzLLZp91FL4MWp5Ju4WIspZEIgf8F6Ng1vNjpZeBd78NfvjA>
    <xmx:H64OZ8vWm5mdYRdWV4PKCatHFE5hAN3mNfBPF745PqSGjuwQHHZ3UA>
    <xmx:H64OZ_qmMAtqLjZmvwoUg8uYLFJynBLC7o-7kUMAxcELgbYDjEd9Fl9D>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:02:06 -0400 (EDT)
Date: Tue, 15 Oct 2024 11:01:44 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: try to search for data csums in commit root
Message-ID: <20241015180144.GA1731591@zen.localdomain>
References: <01721e6680b4a05c06cea8afc98b1726102ba5f5.1728947030.git.boris@bur.io>
 <20241015154320.GI1609@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015154320.GI1609@twin.jikos.cz>

On Tue, Oct 15, 2024 at 05:43:20PM +0200, David Sterba wrote:
> On Mon, Oct 14, 2024 at 04:08:31PM -0700, Boris Burkov wrote:
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
> > 
> > ---
> >  fs/btrfs/bio.c       | 20 ++++++++++++++++++++
> >  fs/btrfs/bio.h       |  7 +++++++
> >  fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
> >  fs/btrfs/file-item.c | 10 ++++++++++
> >  4 files changed, 58 insertions(+)
> > 
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 5d3f8bd406d9..24c159ef3854 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -71,6 +71,25 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> >  	return bbio;
> >  }
> >  
> > +void btrfs_bio_set_private_flag(struct btrfs_bio *bbio, unsigned short flag) {
> > +	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
> > +	bbio->bio.bi_flags |= flag;
> > +}
> > +
> > +void btrfs_bio_clear_private_flag(struct btrfs_bio *bbio, unsigned short flag) {
> > +	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
> > +	bbio->bio.bi_flags &= ~flag;
> > +}
> > +
> > +void btrfs_bio_clear_private_flags(struct btrfs_bio *bbio) {
> > +	bbio->bio.bi_flags &= ~BTRFS_BIO_PRIVATE_FLAG_MASK;
> > +}
> > +
> > +bool btrfs_bio_private_flagged(struct btrfs_bio *bbio, unsigned short flag) {
> > +	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
> > +	return bbio->bio.bi_flags & flag;
> > +}
> 
> This is good, open coding the flag updates is trivial but the assertions
> make ti much better.
> 
> Though using two almost identical names for clearing the private flag,
> one with assertion and one without is confusing and hard to spot in the
> code. Also I don't see where is btrfs_bio_clear_private_flag() used at
> all.
> 

There's no use of it, I just figured if I wrote the rest, I should write
that one too, with the checking and stuff, so that it's a complete API.

> > +
> >  static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> >  					 struct btrfs_bio *orig_bbio,
> >  					 u64 map_length)
> > @@ -493,6 +512,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
> >  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
> >  			     struct btrfs_io_stripe *smap, int mirror_num)
> >  {
> > +	btrfs_bio_clear_private_flags(btrfs_bio(bio));
> >  	if (!bioc) {
> >  		/* Single mirror read/write fast path. */
> >  		btrfs_bio(bio)->mirror_num = mirror_num;
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index e48612340745..749004ffdc1c 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -101,6 +101,13 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> >  				  btrfs_bio_end_io_t end_io, void *private);
> >  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
> >  
> > +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	1U << (BIO_FLAG_LAST + 1)
> 
> All expressions in macros should be in ( ), namelly when there's a
> potential for operator precedence change like with "<<" after the macro
> is expanded in some code.
> 
> > +#define BTRFS_BIO_PRIVATE_FLAG_MASK	(BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT)
> 
> Do you plan to add more such flags to private? This looks line one level
> more of abstraction than we need for this optimization. This could be
> simply used as BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT. And for that
> reason the helpers do not need to sound generic that it manipulates
> 'private', the names can be btrfs_bio_set_csum_search_commit_root(),
> which is IMHO expressing the same semantics.
> 

I don't plan to add any more btrfs private bio flags. I made the
judgment that doing it generically with checking (particularly for the
important and explicit clear before submit) was better than the one off,
because it made what was being done as clear as possible. It's still not
perfectly clear, because of the whole "private flags" name not being
perfect.

Since there is only one user, I totally see the argument for just doing
it as a one-off. Would you like me to rewrite it to
btrfs_bio_set_csum_search_commit_root?

> > +void btrfs_bio_set_private_flag(struct btrfs_bio *bbio, unsigned short flag);
> > +void btrfs_bio_clear_private_flag(struct btrfs_bio *bbio, unsigned short flag);
> > +void btrfs_bio_clear_private_flags(struct btrfs_bio *bbio);
> > +bool btrfs_bio_private_flagged(struct btrfs_bio *bbio, unsigned short flag);
> > +
> >  /* Submit using blkcg_punt_bio_submit. */
> >  #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
> >  
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 09c0d18a7b5a..b1b5dce05728 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
> >  	 * This is to avoid touching ranges covered by compression/inline.
> >  	 */
> >  	unsigned long submit_bitmap;
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
> 
> There's a 4 byte hole after 'opf', you can move it there for better
> struct packing.

