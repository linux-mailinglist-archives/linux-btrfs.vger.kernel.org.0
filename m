Return-Path: <linux-btrfs+bounces-8936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E499F1AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B01F28822
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8B1F6697;
	Tue, 15 Oct 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iqtLGTV5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XWotEn7Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HVegS0lg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/WCTL8AC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6501B393B
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007007; cv=none; b=kF5ljdrCy2Dy9loCwXJDjjL8mtxtEZYwCs3uHMzK2vuVPO3+W+Rqo268JanpOBitB2XCbbMsInlM+TQ519QzEVdYASDl9q6qH3Sp0tSc/V3paRockQOdETK0Gw9oqpYjgz1MG/CnPJ3VlaZp5BxtC1VbPMwUxqIAme8kDzkvrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007007; c=relaxed/simple;
	bh=bRSDZ0wCQ+2B+9A1zV1sJvDbRUpwOFg4fBrr21HsAWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzifKfks6x+r3zWKEIlDgryzkpqYA0n6VUWOLNhRjdo56EjarEb9PCVsz+uv+AStIm61wUEIzBejSPmM73wIF+0Waobm01DE1Fsz36HFN9Z7QiV3lipApQS/uEx9fj/M4d1i7ScVugJp5wY6q1+DoBsohWeJSbqOXSLmVip5FUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iqtLGTV5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XWotEn7Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HVegS0lg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/WCTL8AC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3846A21DAF;
	Tue, 15 Oct 2024 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729007003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dU40PiaMnqpdzeMgSz8lsqq8bWSLaG7CZLU8mC3ks+w=;
	b=iqtLGTV5fO0kgeekSzrcpz4SN6Qy2WoqZuYpYrhR4An4ShChdUoZASPMynUsu//AHTuzQJ
	UKs+5CW9vVc4YPUAvIzSOAwmIAq2RzxjJ2b/UJl69tIQD8s9ZnXDR14CydeBZW4XROKemG
	5ruHd275fraVmEgcPcykXHBYivKAg08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729007003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dU40PiaMnqpdzeMgSz8lsqq8bWSLaG7CZLU8mC3ks+w=;
	b=XWotEn7Q/uEqr8gi/i94VFWp6qYM5oprsH8bAGOcj01ynsnCR2hYDun++EN864gW3zJ7BU
	7IqDKXIQTGLB2GCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HVegS0lg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/WCTL8AC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729007002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dU40PiaMnqpdzeMgSz8lsqq8bWSLaG7CZLU8mC3ks+w=;
	b=HVegS0lguXvOaTYYJiyx+bZJBRZ7FK36OAmkEuJ7KAUDKrR1KvFuJWGygazKY9FB3OC6Dk
	e8xK6PPyPdrobiYuqm+V2hqg0yivXhNoMzaixGHK6ANdbjigh6BJ9FLz8mvBfehrn1pgYe
	bKo0RctfJMQ5afbjmm6sIwDB1b+q7DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729007002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dU40PiaMnqpdzeMgSz8lsqq8bWSLaG7CZLU8mC3ks+w=;
	b=/WCTL8ACB4jH0qUNAwwmKO1MKUbOp+Ub9oyz+M3LmqWg2HowDjzTj/BAB0U7SGZEGJoWD3
	NiQLJ17NJ/TGrbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12CF913A42;
	Tue, 15 Oct 2024 15:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6eRlBJqNDmdrHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Oct 2024 15:43:22 +0000
Date: Tue, 15 Oct 2024 17:43:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: try to search for data csums in commit root
Message-ID: <20241015154320.GI1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <01721e6680b4a05c06cea8afc98b1726102ba5f5.1728947030.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01721e6680b4a05c06cea8afc98b1726102ba5f5.1728947030.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3846A21DAF
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 14, 2024 at 04:08:31PM -0700, Boris Burkov wrote:
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
> 
> ---
>  fs/btrfs/bio.c       | 20 ++++++++++++++++++++
>  fs/btrfs/bio.h       |  7 +++++++
>  fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
>  fs/btrfs/file-item.c | 10 ++++++++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 5d3f8bd406d9..24c159ef3854 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -71,6 +71,25 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  	return bbio;
>  }
>  
> +void btrfs_bio_set_private_flag(struct btrfs_bio *bbio, unsigned short flag) {
> +	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
> +	bbio->bio.bi_flags |= flag;
> +}
> +
> +void btrfs_bio_clear_private_flag(struct btrfs_bio *bbio, unsigned short flag) {
> +	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
> +	bbio->bio.bi_flags &= ~flag;
> +}
> +
> +void btrfs_bio_clear_private_flags(struct btrfs_bio *bbio) {
> +	bbio->bio.bi_flags &= ~BTRFS_BIO_PRIVATE_FLAG_MASK;
> +}
> +
> +bool btrfs_bio_private_flagged(struct btrfs_bio *bbio, unsigned short flag) {
> +	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
> +	return bbio->bio.bi_flags & flag;
> +}

This is good, open coding the flag updates is trivial but the assertions
make ti much better.

Though using two almost identical names for clearing the private flag,
one with assertion and one without is confusing and hard to spot in the
code. Also I don't see where is btrfs_bio_clear_private_flag() used at
all.

> +
>  static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>  					 struct btrfs_bio *orig_bbio,
>  					 u64 map_length)
> @@ -493,6 +512,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
>  			     struct btrfs_io_stripe *smap, int mirror_num)
>  {
> +	btrfs_bio_clear_private_flags(btrfs_bio(bio));
>  	if (!bioc) {
>  		/* Single mirror read/write fast path. */
>  		btrfs_bio(bio)->mirror_num = mirror_num;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e48612340745..749004ffdc1c 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -101,6 +101,13 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  				  btrfs_bio_end_io_t end_io, void *private);
>  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
>  
> +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	1U << (BIO_FLAG_LAST + 1)

All expressions in macros should be in ( ), namelly when there's a
potential for operator precedence change like with "<<" after the macro
is expanded in some code.

> +#define BTRFS_BIO_PRIVATE_FLAG_MASK	(BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT)

Do you plan to add more such flags to private? This looks line one level
more of abstraction than we need for this optimization. This could be
simply used as BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT. And for that
reason the helpers do not need to sound generic that it manipulates
'private', the names can be btrfs_bio_set_csum_search_commit_root(),
which is IMHO expressing the same semantics.

> +void btrfs_bio_set_private_flag(struct btrfs_bio *bbio, unsigned short flag);
> +void btrfs_bio_clear_private_flag(struct btrfs_bio *bbio, unsigned short flag);
> +void btrfs_bio_clear_private_flags(struct btrfs_bio *bbio);
> +bool btrfs_bio_private_flagged(struct btrfs_bio *bbio, unsigned short flag);
> +
>  /* Submit using blkcg_punt_bio_submit. */
>  #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 09c0d18a7b5a..b1b5dce05728 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
>  	 * This is to avoid touching ranges covered by compression/inline.
>  	 */
>  	unsigned long submit_bitmap;
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
> +	bool commit_root_csum;

There's a 4 byte hole after 'opf', you can move it there for better
struct packing.

