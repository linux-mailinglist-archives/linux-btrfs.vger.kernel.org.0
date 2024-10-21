Return-Path: <linux-btrfs+bounces-9020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABA9A69E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F81FB2A928
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF821EF09D;
	Mon, 21 Oct 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fiQ3h5rF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ddIgul37";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A/8FZUiW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRP4N7FW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385671EABBA
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516283; cv=none; b=aTUTPB2sdRw+MtVNHePXulCDZjd71Odn2zrgpSpEglH16U8g+4ZSscvt/mPhhmN2cvWWzuXRS7QknFQuSE2Ai2lod+21k2yM4XuLeu7uE2G1wLCdF+fA0/v2bNJzW99wmoKMFe8R6RoDUznS8d1wpT8m1hog9MK1lnEQU4Vhts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516283; c=relaxed/simple;
	bh=AuuIaOZkFiYNspTzK1xdAzP13s3PmuVUMfPEhtU5FLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0HErVbCThWUkTcJe96Ver3k0WgO6Qxq8+JwtHJflIaDQ6SG6TW2i5/QBWfxflNo7xGtXx++kXy7kkITIrMlVpPPCfzsfNFw2XdHswOEqz75myv/TtCRArM+rYnm6fajgCF4kzssUocDmtVT2bj+7wqleIExs7FmfOqvhCwdVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fiQ3h5rF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ddIgul37; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A/8FZUiW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRP4N7FW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 663F921E88;
	Mon, 21 Oct 2024 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729516278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hws3SFrgHRrAkimxkgaB6FUFxUeWzem5zGJVXCrv4ck=;
	b=fiQ3h5rFvqZ/PUQ0Qlr4eXcI3nd/xk9pAgyhmdxwt8jyWj+/d1zclQc0VhKnNXl4kfwt2+
	UHeTyWkdcayms9lh015M7Vpwd2A0cOnd29Sfb2JhAHMlWEOj/hBl1hu6a0O3KsT+Rmtj7H
	2cCUWkfmBJwDFUvrdJ4i7dZ9qPCbHlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729516278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hws3SFrgHRrAkimxkgaB6FUFxUeWzem5zGJVXCrv4ck=;
	b=ddIgul3763HPqGs32Im+i3Awwwb3wKljAiFjrH7SkXcs1N5ByIT5UIievG5LK0irqAoP6B
	ROO4W8ZEyqLmKxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729516277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hws3SFrgHRrAkimxkgaB6FUFxUeWzem5zGJVXCrv4ck=;
	b=A/8FZUiWPtGGrxfOl7I57BiMvIg4SVVEMmJOYYi5dj7HB1s/dgSCG+RoExQ7TbxbOAx2V+
	MF446gnwQuUEv/ngAVWEJFChy2l28rYEhZBdMyHyF6U4lZZNCpzEnHFcfenPAzQ5LZZabU
	vC7QeQJNHknQWduz5HNOsLcEiAsDVpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729516277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hws3SFrgHRrAkimxkgaB6FUFxUeWzem5zGJVXCrv4ck=;
	b=lRP4N7FWXRlgg9d5mFn1W8JkcoLqCT9nB/ISv31uTIBhRhuMQAjbjubx5xdOZJksh+TQVm
	06o6pFKHkBAnAfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DB84136DC;
	Mon, 21 Oct 2024 13:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5CrdDvVSFmdxPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 13:11:17 +0000
Date: Mon, 21 Oct 2024 15:11:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4] btrfs: try to search for data csums in commit root
Message-ID: <20241021131116.GA17835@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00aada8468cfc74d696dd98f9b8c603271905029.1729107891.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00aada8468cfc74d696dd98f9b8c603271905029.1729107891.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 16, 2024 at 12:46:18PM -0700, Boris Burkov wrote:
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
> ---
>  fs/btrfs/bio.c       | 18 ++++++++++++++++++
>  fs/btrfs/bio.h       |  5 +++++
>  fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
>  fs/btrfs/file-item.c | 10 ++++++++++
>  4 files changed, 54 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f216d07eff6..ca5f8a29acea 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -72,6 +72,21 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  	return bbio;
>  }
>  
> +void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
> +{
> +	bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}

Actually all the helpers should be static inlines, we have a full
defintion of bio available in bio.h so it's not necessary to split the
declaration and definition.

> +
> +void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
> +{
> +	bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
> +bool btrfs_bio_csum_search_commit_root(struct btrfs_bio *bbio)

const bbio

> +{
> +	return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
>  static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>  					 struct btrfs_bio *orig_bbio,
>  					 u64 map_length)
> @@ -482,6 +497,9 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
>  			     struct btrfs_io_stripe *smap, int mirror_num)
>  {
> +	/* Clear the flag we stored in bio->bi_flags before submission. */

Well, that we're clearing the flag is clear from the function name but
the comment should explain why it's here, e.g. that we must not let the
flag be set for some reason.

> +	btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> +
>  	if (!bioc) {
>  		/* Single mirror read/write fast path. */
>  		btrfs_bio(bio)->mirror_num = mirror_num;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e2fe16074ad6..5a8159966135 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -104,6 +104,11 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  				  btrfs_bio_end_io_t end_io, void *private);
>  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
>  
> +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1))
> +void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio);
> +void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio);
> +bool btrfs_bio_csum_search_commit_root(struct btrfs_bio *bbio);
> +
>  /* Submit using blkcg_punt_bio_submit. */
>  #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0a0c84eb1c42..aaec9a67e146 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -99,6 +99,21 @@ struct btrfs_bio_ctrl {
>  	enum btrfs_compression_type compress_type;
>  	u32 len_to_oe_boundary;
>  	blk_opf_t opf;
> +	/*
> +	 * If this is a data read bio, we set this to true if it is safe to
> +	 * search for csums in the commit root. Otherwise, it is set to false.
> +	 *
> +	 * This is an optimization to reduce the contention on the csum tree
> +	 * root rwsem. Due to how rwsem is implemented, there is a possible
> +	 * priority inversion where the readers holding the lock don't get
> +	 * scheduled (say they're in a cgroup stuck in heavy reclaim) which
> +	 * then blocks btrfs transactions. The only real help is to try to
> +	 * reduce the contention on the lock as much as we can.
> +	 *
> +	 * Do this by detecting when a data read is reading data from an old
> +	 * transaction so it's safe to look in the commit root.
> +	 */
> +	bool csum_search_commit_root;
>  	btrfs_bio_end_io_t end_io_func;
>  	struct writeback_control *wbc;
>  
> @@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
>  			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
>  				      folio_pos(folio) + pg_offset);
>  		}
> +		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ &&
> +		    is_data_inode(inode) && bio_ctrl->csum_search_commit_root)
> +			btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
>  
>  		/* Cap to the current ordered extent boundary if there is one. */
>  		if (len > bio_ctrl->len_to_oe_boundary) {
> @@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  		if (prev_em_start)
>  			*prev_em_start = em->start;
>  
> +		if (em->generation < btrfs_get_fs_generation(fs_info))
> +			bio_ctrl->csum_search_commit_root = true;
> +
>  		free_extent_map(em);
>  		em = NULL;
>  
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 886749b39672..fac5a83ace84 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>  		path->skip_locking = 1;
>  	}
>  
> +	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */

This may also explain that this is an optimization and then point to the
comment.

> +	if (btrfs_bio_csum_search_commit_root(bbio)) {
> +		path->search_commit_root = 1;
> +		path->skip_locking = 1;
> +		down_read(&fs_info->commit_root_sem);
> +	}
> +
>  	while (bio_offset < orig_len) {
>  		int count;
>  		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;

