Return-Path: <linux-btrfs+bounces-15396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D361AFEDC9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 17:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E84C16C692
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF21FBC8E;
	Wed,  9 Jul 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="rAsYB+k6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qn3sGZOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2352E54C2
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075035; cv=none; b=qFf0Q++9MX4ivY5M9cGwYeu33CV2/HnwWbxaNEFNcWD5NdFSi+ETP/pZV/CZrURvQiCC94UdZG7J/JMVi2exdA4yeCcCOqWF4oBl+6+bAhsF2RHruzf5ZHsqaUHr0RR8VuCd4t3GHAXC1dn7LNqH2jPfY6CPG0LPqRuF8ICXQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075035; c=relaxed/simple;
	bh=lTGHtwy0AlXl6pEKLur44XbU1/l5HLpN+f9AEM+uQxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scIdeDoMxxNZuAe9itGQpRBCBzzN/uOISuV+beWyt3X8PqIFzfLiiokMrjhi7xg9oJIp+6IiDVjWjjV7c6kELLrWIF8VVdkYRdJrEhy9/WdQL7Qy2BkD4MzjKNxUoB3gAAGnOSpgrAQUsMoCkF/GqNn25jlFhElqXd8j802G5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=rAsYB+k6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qn3sGZOB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F06E6EC04AB;
	Wed,  9 Jul 2025 11:30:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 11:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1752075030;
	 x=1752161430; bh=LgfKwIdSowMRtJk8q5ggwXPN0HbaBdYETi7sKQ8+oZs=; b=
	rAsYB+k6aNAtHh/GUtmiQ8w+lzkXLd/m4c2R9ZYMYO/E9TVQ6M4n6lUN7zFd1dfp
	9uTP5pDH4P6FTOX26/0J7IVCflO4sEawcUigy2eXmZM9iMa6v3L8YOxlwAtt2mAN
	/dWbjsOgP2L2FYARBu4GWuUeONFWn7IE45Y6tNJ0XrkrUMl83Su95W2oS9W2bVL4
	iu3l4WQMNw+N+ARH7l2mr95WFM0V4gn9nqYBHyN2FfB7xDns7YwKH9wV/OwXy/RF
	Ws2/5abNXzCu+1zwCD6qbjphuClshNlmwpDKwXw2elhfoBAqZEZzURG98hR0bQ16
	vV1ejQRK+VRYEnKA4Uxq9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752075030; x=
	1752161430; bh=LgfKwIdSowMRtJk8q5ggwXPN0HbaBdYETi7sKQ8+oZs=; b=Q
	n3sGZOBpxP/5wHCSDBU6wFEFv62LjoeqimwVtkzGjgPaxEn5/r1V/LfshLaZniQv
	VVwPVrFx6S3W8mGwv8yUVpuG9G6djzfN0NQ5tR79zcvc8fi5CNRSlGrWjzfgeGtn
	S22BVGryVBNEoBFJxJzfXtJI2V/qnG0JA1VKkMNK3sLWOeKKRUxtu/+ytVuunI0s
	KdVdRIJbRXl7QnsLi1JPSsQqibvy8kmObsuFBu9s4jzx5CTci+pk3q4LJBFyagsM
	OMU3N3L2JUsPn7x/dqXj7woL4Y/qTXX2BzTF8ejIxcQEH8zv75rTMkprO0HZb2NU
	TdzEdE6HedzzN0RXJq1Yg==
X-ME-Sender: <xms:FotuaFUzLoAJsXV8im8esLP2-w7xwS7Ks1ry0Kl_rfbWJQ8jWDuvbQ>
    <xme:FotuaI1BpFL9ZCwN_GPoRyWo-0G2sbykNtompBV8rP_07q0syb_omOH46y_3fZhu2
    3ebiKtbmfBy34_5D_Q>
X-ME-Received: <xmr:FotuaK0am18bsLmzGv98nZKAkf56247ebMHZf8WQho8FDom_agn4dSGMVn05nvTCXPa2zm_GagQv97xbU_PISB49TAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeffue
    egheegheehueeggfehfedvhefhhefgledtgfelffeffefftdevvdejgeefteenucffohhm
    rghinheplhhptgdrvghvvghnthhspdgsihgpihhtvghrrdgsihenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumh
    grnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmh
    esfhgsrdgtohhm
X-ME-Proxy: <xmx:FotuaD9F3xY5DmZxIsWGCvXIPEdB3W1DJyB9LSVCzuFNOeMp8WkLVQ>
    <xmx:FotuaP2W7Ncr-LRNibS4IXtGBdXCd-Lm_mUUNPHaI8n95zrCvGXTmw>
    <xmx:FotuaI-hcoT_OszP3m61SusA_e8GFNBILRqwkJIhFiOdocB4ehvkIA>
    <xmx:FotuaHsE-LYTmz2zYsbz4pPdX7SUefCNdWs1em3oTcOn2UssrjxOUA>
    <xmx:FotuaA-4lIGwn2ZzuXgrmjRMfaGTIYO3fAqSk1JoMY5xbW2C0DdxODY7>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:30:30 -0400 (EDT)
Date: Wed, 9 Jul 2025 08:32:16 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6] btrfs: try to search for data csums in commit root
Message-ID: <20250709153216.GA355933@zen.localdomain>
References: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
 <CAL3q7H7dVuiKPuuDE7DO+sSp4wH_uNjqJ_N6+PDmRPs796=hzQ@mail.gmail.com>
 <20250709025557.GA87434@zen.localdomain>
 <CAL3q7H5q0q=0qg2Xh=vS_-ySagj3YxokjuKkLphCv5zjWm+EOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5q0q=0qg2Xh=vS_-ySagj3YxokjuKkLphCv5zjWm+EOw@mail.gmail.com>

On Wed, Jul 09, 2025 at 09:17:43AM +0100, Filipe Manana wrote:
> On Wed, Jul 9, 2025 at 3:54 AM Boris Burkov <boris@bur.io> wrote:
> >
> > On Tue, Jul 08, 2025 at 11:15:17PM +0100, Filipe Manana wrote:
> > > On Thu, Jul 3, 2025 at 9:22 PM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > If you run a workload like:
> > > > - a cgroup that does tons of data reading, with a harsh memory limit
> > > > - a second cgroup that tries to write new files
> > > >
> > > > then what quickly occurs is:
> > > > - a high degree of contention on the csum root node eb rwsem
> > > > - memory starved cgroup doing tons of reclaim on CPU.
> > > > - many reader threads in the memory starved cgroup "holding" the sem
> > > >   as readers, but not scheduling promptly. i.e., task __state == 0, but
> > > >   not running on a cpu.
> > > > - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> > >
> > > Where exactly is the transaction commit trying to acquire the csum
> > > root eb rwsem?
> > > It's not obvious - is this with the mount option flushoncommit set?
> > >
> > > >
> > > > This results in arbitrarily long transactions. This then results in
> > > > seriously degraded performance for any cgroup using the filesystem (the
> > > > victim cgroup in the script).
> > > >
> > > > It isn't an academic problem, as we see this exact problem in production
> > > > at Meta with one cgroup over its memory limit ruining btrfs performance
> > > > for the whole system, stalling critical system services that depend on
> > > > btrfs syncs.
> > > >
> > > > The underlying scheduling "problem" with global rwsems is sort of thorny
> > > > and apparently well known and was discussed at LPC 2024, for example.
> > > >
> > > > As a result, our main lever in the short term is just trying to reduce
> > > > contention on our various rwsems. In the case of the csum tree, we can
> > > > either redesign btree locking (hard...) or try to use the commit root
> > > > when we can. Luckily, it seems likely that many reads are for old extents
> > > > written many transactions ago, and that for those we *can* in fact
> > > > search the commit root!
> > > >
> > > > This change detects when we are trying to read an old extent (according
> > > > to extent map generation) and then wires that through bio_ctrl to the
> > > > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > > > information. Luckily, we don't need this flag in the bio after
> > > > submitting, so we can save space by setting it on bbio->bio.bi_flags
> > > > and clear before submitting, so the block layer is unaffected.
> > > >
> > > > When we go to lookup the csums in lookup_bio_sums we can check this
> > > > condition on the btrfs_bio and do the commit root lookup accordingly.
> > > >
> > > > Note that a single bio_ctrl might collect a few extent_maps into a single
> > > > bio, so it is important to track a maximum generation across all the
> > > > extent_maps used for each bio to make an accurate decision on whether it
> > > > is valid to look in the commit root. If any extent_map is updated in the
> > > > current generation, we can't use the commit root.
> > > >
> > > > To test and reproduce this issue, I wrote a script that does the
> > > > following:
> > > > - creates 512 20MiB files (10GiB) each in it's own subvolume (important
> > > >   to avoid any contention on the fs-tree root lock)
> > > > - spawns 512 processes that loop using dd to read 1GiB at a random GiB
> > > >   aligned offset of each file. These "villains" run in a cgroup with
> > > >   memory.high set to 1GiB. Obviously this will generate a lot of memory
> > > >   pressure on this cgroup.
> > > > - spawns 32 processes that loop creating new small files, to trigger a
> > > >   decent amount of csum writes to create the csum root lock contention.
> > > >   These run in a cgroup restricted to just one cpu with cpuset, but no
> > > >   memory restriction. This cpu overlaps with the cpus available to the
> > > >   bad neighbor villain cgroup.
> > > > - attempts to sync every 10 seconds
> > > > - after 60s, it waits for the final sync and kills all the processes via
> > > >   their cg cgroup.kill file.
> > >
> > > In case anyone wants to try this, it would be nice to paste the script
> > > here in the changelog.
> > >
> > > >
> > > > Without this patch, that reproducer:
> > > > hung indefinitely, I killed manually via the cgroup.kill file. At this
> > > > time, it had racked up 200s and counting in a btrfs commit critical
> > > > section and had 200+ threads stuck in D state on the csum reader lock:
> > > >
> > > > elapsed: 914
> > > > commits 3
> > > > cur_commit_ms 0
> > > > last_commit_ms 233784
> > > > max_commit_ms 233784
> > > > total_commit_ms 235056
> > > > 214 hits state D, R comms dd
> > > >                  btrfs_tree_read_lock_nested
> > > >                  btrfs_read_lock_root_node
> > > >                  btrfs_search_slot
> > > >                  btrfs_lookup_csum
> > > >                  btrfs_lookup_bio_sums
> > > >                  btrfs_submit_bbio
> > > >
> > > > With the patch, the reproducer exits naturally, in 75s, completing a
> > > > pretty decent 5 commits, depsite heavy memory pressure:
> > >
> > > typo, depsite -> despite
> > >
> > > >
> > > > elapsed: 76
> > > > commits 5
> > > > cur_commit_ms 0
> > > > last_commit_ms 1801
> > > > max_commit_ms 3901
> > > > total_commit_ms 8727
> > > > pressure
> > > > some avg10=99.49 avg60=69.22 avg300=21.64 total=72068757
> > > > full avg10=44.81 avg60=24.18 avg300=6.97 total=23015022
> > > >
> > > > some random rwalker samples showed the most common stack in reclaim,
> > > > rather than the csum tree:
> > > > 145 hits state R comms bash, sleep, dd, shuf
> > > >                  shrink_folio_list
> > > >                  shrink_lruvec
> > > >                  shrink_node
> > > >                  do_try_to_free_pages
> > > >                  try_to_free_mem_cgroup_pages
> > > >                  reclaim_high
> > > >
> > > > Link: https://lpc.events/event/18/contributions/1883/
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > > Changelog:
> > > > v6:
> > > > - properly handle bio_ctrl submitting a bbio spanning multiple
> > > >   extent_maps with different generations. This was causing csum errors
> > > >   on the previous versions.
> > > > v5:
> > > > - static inline flag functions
> > > > - make bbio const for the getter
> > > > - move around and improve the comments
> > > > v4:
> > > > - replace generic private flag machinery with specific function for the
> > > >   one flag
> > > > - move the bio_ctrl field to take advantage of alignment
> > > > v3:
> > > > - add some simple machinery for setting/getting/clearing btrfs private
> > > >   flags in bi_flags
> > > > - clear those flags before bio_submit (ensure no-op wrt block layer)
> > > > - store the csum commit root flag there to save space
> > > > v2:
> > > > - hold the commit_root_sem for the duration of the entire lookup, not
> > > >   just per btrfs_search_slot. Note that we can't naively do the thing
> > > >   where we release the lock every loop as that is exactly what we are
> > > >   trying to avoid. Theoretically, we could re-grab the lock and fully
> > > >   start over if the lock is write contended or something. I suspect the
> > > >   rwsem fairness features will let the commit writer get it fast enough
> > > >   anyway.
> > > >
> > > > ---
> > > >  fs/btrfs/bio.c         | 10 ++++++++++
> > > >  fs/btrfs/bio.h         | 17 +++++++++++++++++
> > > >  fs/btrfs/compression.c |  2 ++
> > > >  fs/btrfs/extent_io.c   | 40 ++++++++++++++++++++++++++++++++++++++++
> > > >  fs/btrfs/file-item.c   | 29 +++++++++++++++++++++++++++++
> > > >  5 files changed, 98 insertions(+)
> > > >
> > > > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > > > index 50b5fc1c06d7..789cb3e5ba6d 100644
> > > > --- a/fs/btrfs/bio.c
> > > > +++ b/fs/btrfs/bio.c
> > > > @@ -93,6 +93,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> > > >                 refcount_inc(&orig_bbio->ordered->refs);
> > > >                 bbio->ordered = orig_bbio->ordered;
> > > >         }
> > > > +       if (btrfs_bio_csum_search_commit_root(orig_bbio))
> > > > +               btrfs_bio_set_csum_search_commit_root(bbio);
> > > >         atomic_inc(&orig_bbio->pending_ios);
> > > >         return bbio;
> > > >  }
> > > > @@ -479,6 +481,14 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
> > > >  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
> > > >                              struct btrfs_io_stripe *smap, int mirror_num)
> > > >  {
> > > > +       /*
> > > > +        * It is important to clear the bits we used in bio->bi_flags.
> > > > +        * Because bio->bi_flags belongs to the block layer, we should
> > > > +        * avoid leaving stray bits set when we transfer ownership of
> > > > +        * the bio by submitting it.
> > > > +        */
> > > > +       btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> > > > +
> > > >         if (!bioc) {
> > > >                 /* Single mirror read/write fast path. */
> > > >                 btrfs_bio(bio)->mirror_num = mirror_num;
> > > > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > > > index dc2eb43b7097..9f4bcbe0a76c 100644
> > > > --- a/fs/btrfs/bio.h
> > > > +++ b/fs/btrfs/bio.h
> > > > @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> > > >                                   btrfs_bio_end_io_t end_io, void *private);
> > > >  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
> > > >
> > > > +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT (1U << (BIO_FLAG_LAST + 1))
> > > > +
> > > > +static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
> > > > +{
> > > > +       bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > > > +}
> > > > +
> > > > +static inline void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
> > > > +{
> > > > +       bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > > > +}
> > > > +
> > > > +static inline bool btrfs_bio_csum_search_commit_root(const struct btrfs_bio *bbio)
> > > > +{
> > > > +       return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > > > +}
> > > > +
> > > >  /* Submit using blkcg_punt_bio_submit. */
> > > >  #define REQ_BTRFS_CGROUP_PUNT                  REQ_FS_PRIVATE
> > > >
> > > > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > > > index d09d622016ef..cadf5eccc640 100644
> > > > --- a/fs/btrfs/compression.c
> > > > +++ b/fs/btrfs/compression.c
> > > > @@ -602,6 +602,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> > > >         cb->compressed_len = compressed_len;
> > > >         cb->compress_type = btrfs_extent_map_compression(em);
> > > >         cb->orig_bbio = bbio;
> > > > +       if (btrfs_bio_csum_search_commit_root(bbio))
> > > > +               btrfs_bio_set_csum_search_commit_root(&cb->bbio);
> > > >
> > > >         btrfs_free_extent_map(em);
> > > >
> > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > index 7ad4f10bb55a..7a19c257fd4a 100644
> > > > --- a/fs/btrfs/extent_io.c
> > > > +++ b/fs/btrfs/extent_io.c
> > > > @@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
> > > >         enum btrfs_compression_type compress_type;
> > > >         u32 len_to_oe_boundary;
> > > >         blk_opf_t opf;
> > > > +       /*
> > > > +        * For data read bios, we attempt to optimize csum lookups if the extent
> > > > +        * generation is older than the current one. To make this possible, we
> > > > +        * need to track the maximum generation of an extent in a bio_ctrl to
> > > > +        * make the decision when submitting the bio.
> > > > +        *
> > > > +        * See the comment in btrfs_lookup_bio_sums for more detail on the
> > > > +        * need for this optimization.
> > > > +        */
> > > > +       u64 generation;
> > > >         btrfs_bio_end_io_t end_io_func;
> > > >         struct writeback_control *wbc;
> > > >
> > > > @@ -113,6 +123,30 @@ struct btrfs_bio_ctrl {
> > > >         struct readahead_control *ractl;
> > > >  };
> > > >
> > > > +/*
> > > > + * Helper to set the csum search commit root option for a bio_ctrl's bbio
> > > > + * before submitting the bio.
> > > > + *
> > > > + * Only for use by submit_one_bio().
> > > > + */
> > > > +static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_ctrl)
> > > > +{
> > > > +       struct btrfs_bio *bbio = bio_ctrl->bbio;
> > > > +       struct btrfs_fs_info *fs_info;
> > > > +
> > > > +       ASSERT(bbio);
> > > > +       fs_info = bbio->inode->root->fs_info;
> > >
> > > It's only used once, so we could get away with the fs_info variable.
> > >
> > > > +
> > > > +       if (!(btrfs_op(&bbio->bio) == BTRFS_MAP_READ && is_data_inode(bbio->inode)))
> > > > +               return;
> > > > +
> > > > +       if (bio_ctrl->generation &&
> > > > +           bio_ctrl->generation < btrfs_get_fs_generation(fs_info))
> > > > +               btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
> > > > +       else
> > > > +               btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbio);
> > > > +}
> > > > +
> > > >  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> > > >  {
> > > >         struct btrfs_bio *bbio = bio_ctrl->bbio;
> > > > @@ -123,6 +157,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> > > >         /* Caller should ensure the bio has at least some range added */
> > > >         ASSERT(bbio->bio.bi_iter.bi_size);
> > > >
> > > > +       bio_set_csum_search_commit_root(bio_ctrl);
> > > > +
> > > >         if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
> > > >             bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> > > >                 btrfs_submit_compressed_read(bbio);
> > > > @@ -131,6 +167,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> > > >
> > > >         /* The bbio is owned by the end_io handler now */
> > > >         bio_ctrl->bbio = NULL;
> > > > +       /* Reset the generation for the next bio */
> > > > +       bio_ctrl->generation = 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -1026,6 +1064,8 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> > > >                 if (prev_em_start)
> > > >                         *prev_em_start = em->start;
> > > >
> > > > +               bio_ctrl->generation = max(bio_ctrl->generation, em->generation);
> > > > +
> > > >                 btrfs_free_extent_map(em);
> > > >                 em = NULL;
> > > >
> > > > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > > > index c09fbc257634..3d2403941d97 100644
> > > > --- a/fs/btrfs/file-item.c
> > > > +++ b/fs/btrfs/file-item.c
> > > > @@ -397,6 +397,33 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> > > >                 path->skip_locking = 1;
> > > >         }
> > > >
> > > > +       /*
> > > > +        * If we are searching for a csum of an extent from a past
> > > > +        * transaction, we can search in the commit root and reduce
> > > > +        * lock contention on the csum tree root node's extent buffer.
> > > > +        *
> > > > +        * This is important because that lock is an rwswem which gets
> > > > +        * pretty heavy write load, unlike the commit_root_csum.
> > >
> > > commit_root_csum -> commit_root_sem
> > >
> > > > +        *
> > > > +        * Due to how rwsem is implemented, there is a possible
> > > > +        * priority inversion where the readers holding the lock don't
> > > > +        * get scheduled (say they're in a cgroup stuck in heavy reclaim)
> > > > +        * which then blocks writers, including transaction commit. By
> > > > +        * using a semaphore with fewer writers (only a commit switching
> > > > +        * the roots), we make this issue less likely.
> > > > +        *
> > > > +        * Note that we don't rely on btrfs_search_slot to lock the
> > > > +        * commit root csum. We call search_slot multiple times, which would
> > > > +        * create a potential race where a commit comes in between searches
> > > > +        * while we are not holding the commit_root_csum, and we get csums
> > >
> > > commit_root_csum -> commit_root_sem
> > >
> > > > +        * from across transactions.
> > >
> > > Ok, but by acquiring the commit_root_sem in read mode during reads,
> > > which is also a rwsemaphore, why isn't this leading to the same lock
> > > contention problem you describe in the changelog?
> > > That is, delaying transaction commits since transaction commits also
> > > need to write lock the commit_root_sem.
> > >
> > > This seems like it can also lead to the same problem it's trying to
> > > fix regarding the csum root's rwsem, since data readers read lock that
> > > rwsem and transaction commits want to write lock that rwsem.
> > > We are just changing from one semaphore to another that is being used
> > > both by the data reads (in read mode) and by transaction commits (in
> > > write mode).
> > >
> > > I would like to have some explanation on that. Reading the comment and
> > > the changelog leaves me confused about that.
> >
> > Sorry, I missed this part of your review the first time I read it.
> >
> > Good question. I agree that fundamentally it is the same, but in
> > practice I believe the improvement comes from the fact that the commit
> > root semaphore has one rare writer (just the committer at switch root)
> > while the csum tree has many threads locking it write, not just
> > run_delayed_refs in commit transaction. And the priority inversion
> > rwsem issue needs a writer on the queue to trigger, so more writers more
> > frequently makes it more likely for such a pileup to happen. That's at
> > least my best handwavy explanation.
> >
> > I agree with you that if a single instance of readers vs. writers under
> > severe memory pressure caused trouble 100% of the time, then this wouldn't
> > help as you would immediately get stuck at changing the commit root. I
> > think this just reduces the pain.
> >
> > My (over) focus on commit_transaction in the commit message stems from
> > the fact that that is the best way to fully propagate a state of
> > universal D sadness across processes and cgroups. Once the csum root sem
> > is in this state (can be caused by all manner of writers/readers) AND
> > once the transaction gets stuck, that then stalls any thread that needs
> > a new transaction. That is when this issue gets really noticeable, so I
> > think I over-indexed on that aspect in the description.
> >
> > I will also attempt to collect more data on this, to make the
> > explanation more satisfying. I should be able to measure the relative
> > number of write lock attempts, for example.
> 
> I don't think you need to collect more data.

I appreciate the super detailed explanation, it makes a lot of sense. I
will definitely rework the reasoning to make this the focus of the
problem wrt csum tree locking.

> 
> In the other message, the stack trace you showed makes everything clear:
> 
>        btrfs_lock_root_node+1
>         btrfs_search_slot+956
>         btrfs_del_csums+669
>         __btrfs_free_extent.isra.0+2650
>         __btrfs_run_delayed_refs+2811
>         btrfs_run_delayed_refs+214
>         btrfs_commit_transaction+6318
> 
> So I was puzzled because a transaction commit itself shouldn't have
> the need to do changes to the csum tree.
> 
> The problem is really delayed refs that delete the last reference of a
> data extent, triggering csum deletions in the csum tree.
> We only run delayed refs in two places: committing a transaction and
> flushing space to satisfy reservations.
> 
> So if we have many delayed refs that delete the last ref of data
> extents, we have a lot of write locking on the csum tree - not just
> the root node, but in a lot of nodes and leaves.
> 
> Once the root node and higher level nodes are COWed, we normally don't
> need to write lock them again soon unless they get written before the
> transaction commits - but in that scenario, due to the memory
> pressure, the btree inode is getting flushed (writeback triggered)
> very often, so we end up having to COW them again and again, requiring
> the write lock (should_cow_block() returns true in btrfs_search_slot()
> and we have to restart the search and set the write lock level
> higher).
> 
> So we should have such an explanation to the change log and that
> comment in the code.
> In short:
> 
> - We need to have lots of delayed refs that delete the last ref of a
> data extent, and that triggers deletions in the csum tree, therefore
> lots of write lock attempts on csum tree nodes and leaves - not just
> the root node...

Just FYI, the reason I focused so much on the root node is that in
practice that seemed to be the one that the rwsem priority inversion was
happening on. Agreed with everything you said, overall, though.

> 
> - The memory pressure further increases write locking on the csum
> tree, we have to COW csum tree nodes/leaves more often because the
> btree inode gets flushed by the VM due to memory pressure.

Great point. I'll try to verify this is for sure happening, I think
this was a big missing piece in my understanding.

> 
> - More time running delayed refs means slowing down transaction commits.
> 

+1

> Now that makes it clear, and the commit_root_sem is only acquired once
> in write mode by a transaction commit for a relatively short period,
> and that's why it's better to make the reads use it and the csum
> commot root for looking up checksums.
> 
> Thanks!
> 
> 
> >
> > Thanks again for the thoughtful questions,
> > Boris
> >
> > >
> > > Thanks.
> > >
> > > > +        */
> > > > +       if (btrfs_bio_csum_search_commit_root(bbio)) {
> > > > +               path->search_commit_root = 1;
> > > > +               path->skip_locking = 1;
> > > > +               down_read(&fs_info->commit_root_sem);
> > > > +       }
> > > > +
> > > >         while (bio_offset < orig_len) {
> > > >                 int count;
> > > >                 u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
> > > > @@ -442,6 +469,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> > > >                 bio_offset += count * sectorsize;
> > > >         }
> > > >
> > > > +       if (btrfs_bio_csum_search_commit_root(bbio))
> > > > +               up_read(&fs_info->commit_root_sem);
> > > >         return ret;
> > > >  }
> > > >
> > > > --
> > > > 2.49.0
> > > >
> > > >

