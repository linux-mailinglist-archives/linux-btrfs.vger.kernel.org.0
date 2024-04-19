Return-Path: <linux-btrfs+bounces-4435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1FA8AB463
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7701F223BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2E13A86B;
	Fri, 19 Apr 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+MDzZtP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nI/EtmRp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TOnNlAmF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AvmgyUlc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6156137C32
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547849; cv=none; b=rLA3RUK3p3H3iMvO+MyfupECBZVnPO2UeJf/4DKCH5ipzkNrwaG0SuZ9EXQVHNn6ZpCgLAsPbzKBEeSmvV+jeZhB8ENCvv4SDj+K6TA+MnLxRtjvKdejZhZzxje+G4yRd2mg6UHDb7fKDtvcB5XNsWWT6phAHnqpxP3+KajNHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547849; c=relaxed/simple;
	bh=BlSzWsuaKRhmbmEpQlKibEg0zuZW5qrCt2HxSO1WI4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmM/YbkJwzRjMyUt9vhY/ClgCev/0flTAk7QhmR/p7rx6c827HHdpFiCheOycnprhB7Kgfb7r7yh3CGMhj3eJzAorNw4zbDhyQSL7GCiWainX7FwMFXAULUWhAyDiIXNd+6QSQVJPYueRfDBXBdUH06dlAN7mNcZED+aEmO6dO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+MDzZtP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nI/EtmRp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TOnNlAmF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AvmgyUlc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D361D379DA;
	Fri, 19 Apr 2024 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713547846;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7GhOpWsdXH8Rtif/X96ATRxRgkkiQ9IzsDVNxBIyhg=;
	b=j+MDzZtP0+IznM+Zx2WR3nAt5x1/7gf4tSC8kdbWtvEkuaw6gNJ4Atri7PXgqsKbDVJs+c
	PctRwsNO3Z3qQMaJyXY+MYMiZGkEjjQfQo2HevKgs1ns1nGxUnpNXSEqjupwdEMdxsDGGU
	UyfD0tU6Mxa90aKzyHiG9BanaP8rNKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713547846;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7GhOpWsdXH8Rtif/X96ATRxRgkkiQ9IzsDVNxBIyhg=;
	b=nI/EtmRp+x3qRLiLxMjIXjJhNV/59+D2kgDbABwgavkH6HSI9CllUFXWYZ0s5TTrV7cHFx
	PFz84KR3QjRLdwCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713547845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7GhOpWsdXH8Rtif/X96ATRxRgkkiQ9IzsDVNxBIyhg=;
	b=TOnNlAmFSerUb/zYeVusNsS0VuFRUQkUOl7pDDyXOJ03paj66eKQoqW9UTzTGrAtagcOIW
	WDK/RGxT7Jp7KKHW/icr145oHn7iEKyeVJzdxytjHvyOfkdlKiQZ79VWg/X6alBSpkigNj
	AxpxrIW9r/66LG8Ox/c/laeKEO/A2+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713547845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7GhOpWsdXH8Rtif/X96ATRxRgkkiQ9IzsDVNxBIyhg=;
	b=AvmgyUlcqxuSDfZuX25RCQ7dv9kCk9K4jRh9s4Q8xvu9OfMCda9ZJVVF74B91F0sia5kVI
	r9Z3pvhP/q9u1RCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A2D7136CF;
	Fri, 19 Apr 2024 17:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gVyRIUWqImZ5JwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Apr 2024 17:30:45 +0000
Date: Fri, 19 Apr 2024 19:23:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] btrfs: btrfs_drop_snapshot optimize return
 variable
Message-ID: <20240419172310.GA3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713370756.git.anand.jain@oracle.com>
 <da2bedd3ec4fd05cbffaea83aa2f783674d027ea.1713370757.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2bedd3ec4fd05cbffaea83aa2f783674d027ea.1713370757.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu, Apr 18, 2024 at 03:08:42PM +0800, Anand Jain wrote:
> Drop the variable 'err', reuse the variable 'ret' by reinitializing it to
> zero where necessary.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: handle return error better, no need of original 'ret'. (Josef).
> 
>  fs/btrfs/extent-tree.c | 48 +++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 78dc94a97e35..17aa45b906bb 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5833,8 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	struct btrfs_root_item *root_item = &root->root_item;
>  	struct walk_control *wc;
>  	struct btrfs_key key;
> -	int err = 0;
> -	int ret;
> +	int ret = 0;
>  	int level;
>  	bool root_dropped = false;
>  	bool unfinished_drop = false;
> @@ -5843,14 +5842,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
>  	wc = kzalloc(sizeof(*wc), GFP_NOFS);
>  	if (!wc) {
>  		btrfs_free_path(path);
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -5863,12 +5862,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	else
>  		trans = btrfs_start_transaction(tree_root, 0);
>  	if (IS_ERR(trans)) {
> -		err = PTR_ERR(trans);
> +		ret = PTR_ERR(trans);
>  		goto out_free;
>  	}
>  
> -	err = btrfs_run_delayed_items(trans);
> -	if (err)
> +	ret = btrfs_run_delayed_items(trans);
> +	if (ret)
>  		goto out_end_trans;
>  
>  	/*
> @@ -5899,11 +5898,11 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  		path->lowest_level = level;
>  		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>  		path->lowest_level = 0;
> -		if (ret < 0) {
> -			err = ret;
> +		if (ret < 0)
>  			goto out_end_trans;
> -		}
> +
>  		WARN_ON(ret > 0);
> +		ret = 0;
>  
>  		/*
>  		 * unlock our path, this is safe because only this
> @@ -5916,14 +5915,17 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  			btrfs_tree_lock(path->nodes[level]);
>  			path->locks[level] = BTRFS_WRITE_LOCK;
>  
> +			/*
> +			 * btrfs_lookup_extent_info() returns 0 for success,
> +			 * or < 0 for error.
> +			 */
>  			ret = btrfs_lookup_extent_info(trans, fs_info,
>  						path->nodes[level]->start,
>  						level, 1, &wc->refs[level],
>  						&wc->flags[level], NULL);
> -			if (ret < 0) {
> -				err = ret;
> +			if (ret < 0)
>  				goto out_end_trans;
> -			}
> +
>  			BUG_ON(wc->refs[level] == 0);
>  
>  			if (level == btrfs_root_drop_level(root_item))
> @@ -5949,19 +5951,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  		ret = walk_down_tree(trans, root, path, wc);
>  		if (ret < 0) {
>  			btrfs_abort_transaction(trans, ret);
> -			err = ret;
>  			break;
>  		}
>  
>  		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
>  		if (ret < 0) {
>  			btrfs_abort_transaction(trans, ret);
> -			err = ret;
>  			break;
>  		}
>  
>  		if (ret > 0) {
>  			BUG_ON(wc->stage != DROP_REFERENCE);
> +			ret = 0;
>  			break;
>  		}
>  
> @@ -5983,7 +5984,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  						root_item);
>  			if (ret) {
>  				btrfs_abort_transaction(trans, ret);
> -				err = ret;
>  				goto out_end_trans;
>  			}
>  
> @@ -5994,7 +5994,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
>  				btrfs_debug(fs_info,
>  					    "drop snapshot early exit");
> -				err = -EAGAIN;
> +				ret = -EAGAIN;
>  				goto out_free;
>  			}
>  
> @@ -6008,19 +6008,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  			else
>  				trans = btrfs_start_transaction(tree_root, 0);
>  			if (IS_ERR(trans)) {
> -				err = PTR_ERR(trans);
> +				ret = PTR_ERR(trans);
>  				goto out_free;
>  			}
>  		}
>  	}
>  	btrfs_release_path(path);
> -	if (err)
> +	if (ret)
>  		goto out_end_trans;
>  
>  	ret = btrfs_del_root(trans, &root->root_key);
>  	if (ret) {
>  		btrfs_abort_transaction(trans, ret);
> -		err = ret;
>  		goto out_end_trans;
>  	}
>  
> @@ -6029,10 +6028,11 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  				      NULL, NULL);
>  		if (ret < 0) {
>  			btrfs_abort_transaction(trans, ret);
> -			err = ret;
>  			goto out_end_trans;
>  		} else if (ret > 0) {
> -			/* if we fail to delete the orphan item this time
> +			ret = 0;
> +			/*
> +			 * if we fail to delete the orphan item this time

If you change comments please also fix the formatting or spelling, in
this case first letter is uppercase.

>  			 * around, it'll get picked up the next time.
>  			 *
>  			 * The most common failure here is just -ENOENT.
> @@ -6067,7 +6067,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	 * We were an unfinished drop root, check to see if there are any
>  	 * pending, and if not clear and wake up any waiters.
>  	 */
> -	if (!err && unfinished_drop)
> +	if (!ret && unfinished_drop)
>  		btrfs_maybe_wake_unfinished_drop(fs_info);
>  
>  	/*
> @@ -6079,7 +6079,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	 */
>  	if (!for_reloc && !root_dropped)
>  		btrfs_add_dead_root(root);
> -	return err;
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.41.0
> 

