Return-Path: <linux-btrfs+bounces-11998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E30A4D94E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD78167E68
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E801FDE27;
	Tue,  4 Mar 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rBJMW/Mx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJQwOpu3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rBJMW/Mx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJQwOpu3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DD1FCFDF
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081982; cv=none; b=NWO7yPY7uC1wdHLdPqouw0PkD+UqYFeDVcjQmtrUFkAfN8EwGyPmIoPqbEBHVsWfmxqoZkVdCjI1eRmm0ek4xOufwHxJ78otJhHvRSO82JRP+mZym+7x0Ajy9fq2j0ulTJj72C2mXsn8wWv1A8Qhf1wcphZTaDc/MhxcMoufhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081982; c=relaxed/simple;
	bh=bYVOM+ikKeX3Vc2M+xjdI8IA5iIf075NpKpz4lVScq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEDLexXypm/dpeiIUVMVlkXJSR+Q+qPpdp/41CnL+rQUQeq6gFoatyonjYO9BRZLcoCKHCR0z/L14O72RM1aqxZkOXdhV5XCofmUmR/xio6v9GslYXZlVF7apftp5BJBhQJ8+ot07bZB5/qLHDmBOiADF0cEXrdVTSvDH5A9SdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rBJMW/Mx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJQwOpu3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rBJMW/Mx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJQwOpu3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D6661F444;
	Tue,  4 Mar 2025 09:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741081978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qODXZ4gx3eFFFmKWoitueCwKFZ6lrgcJ+HVD6VsujE=;
	b=rBJMW/MxEk71cIbMPm8VM+34WOPu/oHsWOFueqk4923k3kVpa1/SDlaxduRsg3NvIZJJBZ
	0V7jsRMX6uIXgXNQuuWzuhAYgauoDjyvr1rbuOZ9qwPuUv3pZxzDqKTIsMlFLTbas/Mzxu
	aKWtdMn0q2ni3mzIvaEQGyRy9EpHh0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741081978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qODXZ4gx3eFFFmKWoitueCwKFZ6lrgcJ+HVD6VsujE=;
	b=ZJQwOpu3bAkAso7ZUoqymPRkW2l8lO5hoxWs0wL6MTs/ML/X9gDqS77tLYpy5nyoYAXt1j
	yt10+PlOzb/KTlCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="rBJMW/Mx";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZJQwOpu3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741081978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qODXZ4gx3eFFFmKWoitueCwKFZ6lrgcJ+HVD6VsujE=;
	b=rBJMW/MxEk71cIbMPm8VM+34WOPu/oHsWOFueqk4923k3kVpa1/SDlaxduRsg3NvIZJJBZ
	0V7jsRMX6uIXgXNQuuWzuhAYgauoDjyvr1rbuOZ9qwPuUv3pZxzDqKTIsMlFLTbas/Mzxu
	aKWtdMn0q2ni3mzIvaEQGyRy9EpHh0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741081978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qODXZ4gx3eFFFmKWoitueCwKFZ6lrgcJ+HVD6VsujE=;
	b=ZJQwOpu3bAkAso7ZUoqymPRkW2l8lO5hoxWs0wL6MTs/ML/X9gDqS77tLYpy5nyoYAXt1j
	yt10+PlOzb/KTlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8010413967;
	Tue,  4 Mar 2025 09:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DxgOH3rNxmdpVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 04 Mar 2025 09:52:58 +0000
Date: Tue, 4 Mar 2025 10:52:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: use atomic64_t for free_objectid
Message-ID: <20250304095256.GX5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250303182139.256498-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303182139.256498-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9D6661F444
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Mar 03, 2025 at 06:21:16PM +0000, Mark Harmstone wrote:
> Currently btrfs_get_free_objectid() uses a mutex to protect
> free_objectid; I'm guessing this was because of the inode cache that we
> used to have. The inode cache is no more, so simplify things by
> replacing it with an atomic.
> 
> There's no issues with ordering: free_objectid gets set to an initial
> value, then calls to btrfs_get_free_objectid() return a monotonically
> increasing value.
> 
> This change means that btrfs_get_free_objectid() will no longer
> potentially sleep, which was a blocker for adding a non-blocking mode
> for inode and subvol creation.
> 
> This change moves the warning in btrfs_get_free_objectid() out of the lock.
> Integer overflow isn't a plausible problem here; there's no way to create
> inodes with an arbitrary number, short of hex-editing the block device,
> and incrementing a uint64_t a billion times a second would take >500 years
> for overflow to happen.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/ctree.h    |  4 +---
>  fs/btrfs/disk-io.c  | 43 ++++++++++++++++++-------------------------
>  fs/btrfs/qgroup.c   | 11 ++++++-----
>  fs/btrfs/tree-log.c |  3 ---
>  4 files changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 075a06db43a1..23adbce4c516 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -179,8 +179,6 @@ struct btrfs_root {
>  	struct btrfs_fs_info *fs_info;
>  	struct extent_io_tree dirty_log_pages;
>  
> -	struct mutex objectid_mutex;
> -
>  	spinlock_t accounting_lock;
>  	struct btrfs_block_rsv *block_rsv;
>  
> @@ -214,7 +212,7 @@ struct btrfs_root {
>  
>  	u64 last_trans;
>  
> -	u64 free_objectid;
> +	atomic64_t free_objectid;
>  
>  	struct btrfs_key defrag_progress;
>  	struct btrfs_key defrag_max;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 52c2335ef62f..1597a8945f4c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -657,7 +657,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
>  	RB_CLEAR_NODE(&root->rb_node);
>  
>  	btrfs_set_root_last_trans(root, 0);
> -	root->free_objectid = 0;
> +	atomic64_set(&root->free_objectid, 0);
>  	root->nr_delalloc_inodes = 0;
>  	root->nr_ordered_extents = 0;
>  	xa_init(&root->inodes);
> @@ -676,7 +676,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
>  	spin_lock_init(&root->ordered_extent_lock);
>  	spin_lock_init(&root->accounting_lock);
>  	spin_lock_init(&root->qgroup_meta_rsv_lock);
> -	mutex_init(&root->objectid_mutex);
>  	mutex_init(&root->log_mutex);
>  	mutex_init(&root->ordered_extent_mutex);
>  	mutex_init(&root->delalloc_mutex);
> @@ -1132,16 +1131,12 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
>  		}
>  	}
>  
> -	mutex_lock(&root->objectid_mutex);
>  	ret = btrfs_init_root_free_objectid(root);
> -	if (ret) {
> -		mutex_unlock(&root->objectid_mutex);
> +	if (ret)
>  		return ret;
> -	}
>  
> -	ASSERT(root->free_objectid <= BTRFS_LAST_FREE_OBJECTID);
> -
> -	mutex_unlock(&root->objectid_mutex);
> +	ASSERT((u64)atomic64_read(&root->free_objectid) <=
> +		BTRFS_LAST_FREE_OBJECTID);

I'm not sure if this was mentioned in the previous discussion. This
assert will be always true, the atomic is signed 64 and cast to
unsigned. Under normal circumstances the atomic will not be negative so
it won't translate to a huge unsigned number by the cast.

What we need is an unsigned atomic type. The atomic64_t is a natural
choice and it probably has enough margin for the simple increment
allocation. But still I think we should make it a "u64".

The simplest implementation is to use spin lock around the updates,
seqlock_t is also possible but it effectively uses a spin lock too and
we don't need the read side protection.

Sorry, it's another change right before the code freeze so we may want
to postpone it to let us think it through. I'll prototype the idea and
do some tests, we can still target 6.15.

