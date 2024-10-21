Return-Path: <linux-btrfs+bounces-9039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B222D9A72FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 21:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13483B22839
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332001FBC8D;
	Mon, 21 Oct 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWWsKeMt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybRL6GtR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWWsKeMt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybRL6GtR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FEA1FBC81
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537847; cv=none; b=LhgbxhK3M3QRA4H/egQ+jj2UqAcK85eCRU4xxHj0E1/b+JUSYV1fyritLIlFBVyuIkkjJNGdPCa8UzuzHx+5SRU6HK4vtcmbjgJQT9X5r9+m8e1DUc9RGFuWucj6Me1Ls+S3EwuhadgDRRnC5Fv4OscY+Pmg/ijSUnWN9HQn7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537847; c=relaxed/simple;
	bh=N0EZpWqatc87O6+OrjbfnGzQEE49x6De2EarRPj4hrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmF8Q1sRkwHFFySdtpefLPKF4S7+G0/Yi/cxKN3EuTBvl1iK8+O5fceiEpPdCUNCqS6vxy6UfHOc8QUwPMeXa4dJEXWBPLKvdHulgmsL9sd8kCWGyopxQByLLVDX9oSycAB+cYIf2xPS2+WfxVWtiV6B3vCdzuBkdScu/jp8Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWWsKeMt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybRL6GtR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWWsKeMt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybRL6GtR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B57821DEF;
	Mon, 21 Oct 2024 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729537840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhYMzpGTMcI9yf3iD+dMfOzPyaA8nNW6yTkYVrS3dvo=;
	b=rWWsKeMtZxKkv1EzLeAFR9Ze8K7RPGd3Py2wq3A/jFJAfSdhwR6uycvWuF5+BfG94eQlVv
	xSImvtxmiNNgM5aC7B48U1oZDhXVqg9IZoFQkDOF8bRVex5/QwGAW9Ps5YVF5Q1fLpR+12
	FwvFArWFml5zGyj/Ee+x1adpchMZLyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729537840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhYMzpGTMcI9yf3iD+dMfOzPyaA8nNW6yTkYVrS3dvo=;
	b=ybRL6GtRNgZGwmdi+KPANGe5aBES7KjO9gsqEr+jv4uxR+1HUuaoOxBgRsYZ+wR2dAOO0+
	xvfBBMgP4WOduaAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729537840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhYMzpGTMcI9yf3iD+dMfOzPyaA8nNW6yTkYVrS3dvo=;
	b=rWWsKeMtZxKkv1EzLeAFR9Ze8K7RPGd3Py2wq3A/jFJAfSdhwR6uycvWuF5+BfG94eQlVv
	xSImvtxmiNNgM5aC7B48U1oZDhXVqg9IZoFQkDOF8bRVex5/QwGAW9Ps5YVF5Q1fLpR+12
	FwvFArWFml5zGyj/Ee+x1adpchMZLyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729537840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhYMzpGTMcI9yf3iD+dMfOzPyaA8nNW6yTkYVrS3dvo=;
	b=ybRL6GtRNgZGwmdi+KPANGe5aBES7KjO9gsqEr+jv4uxR+1HUuaoOxBgRsYZ+wR2dAOO0+
	xvfBBMgP4WOduaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D14A136DC;
	Mon, 21 Oct 2024 19:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ob6uDjCnFmf5LAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 19:10:40 +0000
Date: Mon, 21 Oct 2024 21:10:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5] btrfs: try to search for data csums in commit root
Message-ID: <20241021191035.GE24631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8e334e4412410a46d3928950c796c9914cebdf92.1729537203.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e334e4412410a46d3928950c796c9914cebdf92.1729537203.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 21, 2024 at 12:01:53PM -0700, Boris Burkov wrote:
> If you run a workload like:
> - a cgroup that does tons of data reading, with a harsh memory limit
> - a second cgroup that tries to write new files
> e.g.:
> https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
> 
> then what quickly occurs is:
> - a high degree of contention on the csum root node eb rwsem
> - memory starved cgroup doing tons of reclaim on CPU.
> - many reader threads in the memory starved cgroup "holding" the sem
>   as readers, but not scheduling promptly. i.e., task __state == 0, but
>   not running on a cpu.
> - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> 
> This results in VERY long transactions. On my test system, that script
> produces 20-30s long transaction commits. This then results in
> seriously degraded performance for any cgroup using the filesystem (the
> victim cgroup in the script).
> 
> This reproducer is a bit silly, as the villanous cgroup is using almost
> all of its memory.max for kernel memory (specifically pagetables) but it
> sort of doesn't matter, as I am most interested in the btrfs locking
> behavior. It isn't an academic problem, as we see this exact problem in
> production at Meta with one cgroup over memory.max ruining btrfs
> performance for the whole system.
> 
> The underlying scheduling "problem" with global rwsems is sort of thorny
> and apparently well known. e.g.
> https://lpc.events/event/18/contributions/1883/
> 
> As a result, our main lever in the short term is just trying to reduce
> contention on our various rwsems. In the case of the csum tree, we can
> either redesign btree locking (hard...) or try to use the commit root
> when we can. Luckily, it seems likely that many reads are for old extents
> written many transactions ago, and that for those we *can* in fact
> search the commit root!
> 
> This change detects when we are trying to read an old extent (according
> to extent map generation) and then wires that through bio_ctrl to the
> btrfs_bio, which unfortunately isn't allocated yet when we have this
> information. Luckily, we don't need this flag in the bio after
> submitting, so we can save space by setting it on bbio->bio.bi_flags
> and clear before submitting, so the block layer is unaffected.
> 
> When we go to lookup the csums in lookup_bio_sums we can check this
> condition on the btrfs_bio and do the commit root lookup accordingly.
> 
> With the fix, on that same test case, commit latencies no longer exceed
> ~400ms on my system.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v5:
> - static inline flag functions
> - make bbio const for the getter
> - move around and improve the comments

v5 looks good, thanks.

> v4:
> - replace generic private flag machinery with specific function for the
>   one flag
> - move the bio_ctrl field to take advantage of alignment
> v3:
> - add some simple machinery for setting/getting/clearing btrfs private
>   flags in bi_flags
> - clear those flags before bio_submit (ensure no-op wrt block layer)
> - store the csum commit root flag there to save space
> v2:
> - hold the commit_root_sem for the duration of the entire lookup, not
>   just per btrfs_search_slot. Note that we can't naively do the thing
>   where we release the lock every loop as that is exactly what we are
>   trying to avoid. Theoretically, we could re-grab the lock and fully
>   start over if the lock is write contended or something. I suspect the
>   rwsem fairness features will let the commit writer get it fast enough
>   anyway.
> 
> ---
>  fs/btrfs/bio.c       |  8 ++++++++
>  fs/btrfs/bio.h       | 17 +++++++++++++++++
>  fs/btrfs/extent_io.c | 20 ++++++++++++++++++++
>  fs/btrfs/file-item.c | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 75 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f216d07eff6..4d675f6dd3e9 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -482,6 +482,14 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
>  			     struct btrfs_io_stripe *smap, int mirror_num)
>  {
> +	/*
> +	 * It is important to clear the bits we used in bio->bi_flags.
> +	 * Because bio->bi_flags belongs to the block layer, we should
> +	 * avoid leaving stray bits set when we transfer ownership of
> +	 * the bio by submitting it.
> +	 */
> +	btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> +
>  	if (!bioc) {
>  		/* Single mirror read/write fast path. */
>  		btrfs_bio(bio)->mirror_num = mirror_num;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e2fe16074ad6..8915863d0d0f 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  				  btrfs_bio_end_io_t end_io, void *private);
>  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
>  
> +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1))
> +
> +static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
> +{
> +	bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
> +static inline void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
> +{
> +	bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
> +static inline bool btrfs_bio_csum_search_commit_root(const struct btrfs_bio *bbio)
> +{
> +	return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
>  /* Submit using blkcg_punt_bio_submit. */
>  #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1beaba232532..bdd7673d989c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -99,6 +99,15 @@ struct btrfs_bio_ctrl {
>  	enum btrfs_compression_type compress_type;
>  	u32 len_to_oe_boundary;
>  	blk_opf_t opf;
> +	/*
> +	 * If this is a data read bio, we set this to true if the extent is
> +	 * from a past transaction and thus it is safe to search for csums
> +	 * in the commit root. Otherwise, we set it to false.
> +	 *
> +	 * See the comment in btrfs_lookup_bio_sums for more detail on the
> +	 * need for this optimization.
> +	 */
> +	bool csum_search_commit_root;
>  	btrfs_bio_end_io_t end_io_func;
>  	struct writeback_control *wbc;
>  
> @@ -771,6 +780,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
>  			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
>  				      folio_pos(folio) + pg_offset);
>  		}
> +		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ &&
> +		    is_data_inode(inode) && bio_ctrl->csum_search_commit_root)
> +			btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
>  
>  		/* Cap to the current ordered extent boundary if there is one. */
>  		if (len > bio_ctrl->len_to_oe_boundary) {
> @@ -1049,6 +1061,14 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  		if (prev_em_start)
>  			*prev_em_start = em->start;
>  
> +		/*
> +		 * At this point, we know it is safe to search for
> +		 * csums in the commit root, but we have not yet
> +		 * allocated a bio, so stash it in bio_ctrl.
> +		 */
> +		if (em->generation < btrfs_get_fs_generation(fs_info))
> +			bio_ctrl->csum_search_commit_root = true;
> +
>  		free_extent_map(em);
>  		em = NULL;
>  
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 886749b39672..cd63769959f9 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -401,6 +401,33 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>  		path->skip_locking = 1;
>  	}
>  
> +	/*
> +	 * If we are searching for a csum of an extent from a past
> +	 * transaction, we can search in the commit root and reduce
> +	 * lock contention on the csum tree root node's extent buffer.
> +	 *
> +	 * This is important because that lock is an rwswem which gets
> +	 * pretty heavy write load, unlike the commit_root_csum.
                                               ^^^^^^^^^^^^^^^^

commit_root_sem?

> +	 *
> +	 * Due to how rwsem is implemented, there is a possible
> +	 * priority inversion where the readers holding the lock don't
> +	 * get scheduled (say they're in a cgroup stuck in heavy reclaim)
> +	 * which then blocks writers, including transaction commit. By
> +	 * using a semaphore with fewer writers (only a commit switching
> +	 * the roots), we make this issue less likely.
> +	 *
> +	 * Note that we don't rely on btrfs_search_slot to lock the
> +	 * commit root csum. We call search_slot multiple times, which would
                       sem

> +	 * create a potential race where a commit comes in between searches
> +	 * while we are not holding the commit_root_csum, and we get csums
                                                    sem

Only typos so you can fix it once you add it to for-next, also please
reflow the comments so they fit 80 columns per line.

Reviewed-by: David Sterba <dsterba@suse.com>

