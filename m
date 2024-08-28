Return-Path: <linux-btrfs+bounces-7602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF06961B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 02:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C60B22057
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640BF4E2;
	Wed, 28 Aug 2024 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynPZlAMU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9KhVGgQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6VgT1O9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0ArWyK6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783CC8CE
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804278; cv=none; b=Q5tj4lq0mkjS6IUgtWsUw+DpsIuAc0IeL/ENpDLNAwtO3rItBWJfJbdl6WmS6Nja2JvmdUhsaUpqGBwwdoLOQMoKUV55mjk8BgYo1ByPAvf7MrGYmCaq42h9A7HepownWLyq/491CQDmI6A+qmo5l0d3tQpq2cOGnVU1Jiq9txU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804278; c=relaxed/simple;
	bh=XX1+oonS6E/xNcFFMae3FrGtKi7gvG6ZuIwtOzTqX/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiDpeZmvPDunqCDVwQuGb8/eyS4qBNlNRhnZEC1dasRt8iyE4NQowEwr4W4ewFbNz3WiXGbN6g3hCPmm4Z883qcYe2OJezgsI3uGKmXmWR8K8tqwnJ59Flw7/n8jx9PAcpssm015sUPSqzClpOL4x8GRTmJeHJyZhctMSWHUwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynPZlAMU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9KhVGgQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6VgT1O9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0ArWyK6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2E011FB9B;
	Wed, 28 Aug 2024 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724804275;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diAnE9UrPu+30A5YDyms6QO+sBWMahR9pEp3wRQSSQc=;
	b=ynPZlAMU+chl5l5xmayAe9UsvIqrlnA6AGJzSbaTcICQWd4Yl2A4uVrsLp0nhBlmJAhNC2
	s7ynFC/W+IWaTcyBDxHfJ+0kvS/O6KtfJVZ3BPDqLu3khytp9OGkv3ZnobJLIf2+eKiRUb
	XxPgl96nZk620AKkSvyI2L5tGsA8GXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724804275;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diAnE9UrPu+30A5YDyms6QO+sBWMahR9pEp3wRQSSQc=;
	b=a9KhVGgQLQolqpysgICo3zFxLbmd2wZQuDjDIJZtQyVcAu9xkVa39mjCjXG1xIs+C7F9i8
	khkOIKBmfJtnCAAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724804274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diAnE9UrPu+30A5YDyms6QO+sBWMahR9pEp3wRQSSQc=;
	b=V6VgT1O9XT2lfKqtShWW50tL3XOYvt7piRbM5YfEUe2ee8Ko/EZS+LygQoyCXoUQOoNcKd
	6qQyM9S03CIDsYS5EpDX/bXPLhbU9GVszkl5g5gmFsQxNjJMiFIv0ZyvL24mPy7+VM0OGx
	eWP4IFY0i1IGEk1nqV8y5ddjjoE+Mkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724804274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diAnE9UrPu+30A5YDyms6QO+sBWMahR9pEp3wRQSSQc=;
	b=g0ArWyK6Wo7+I05Hd2tMLiKnyqkpcRTyOAw7utADwr/D4V9Tm8Y39Bnz7YASn+fpRoObpM
	jEzIVg6mJnTJT1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC0641373A;
	Wed, 28 Aug 2024 00:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ilKANbJszmZ3QAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 00:17:54 +0000
Date: Wed, 28 Aug 2024 02:17:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240828001749.GD25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.97
X-Spamd-Result: default: False [-3.97 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.17)[-0.870];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Aug 27, 2024 at 12:08:43PM -0700, Leo Martins wrote:
> Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
> be called using the __free attribute. Defined a macro
> BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
> very clear.
> ---
>  fs/btrfs/ctree.c | 2 +-
>  fs/btrfs/ctree.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 451203055bbfb..f0bdea206d672 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
>  /* this also releases the path */
>  void btrfs_free_path(struct btrfs_path *p)
>  {
> -	if (!p)
> +	if (IS_ERR_OR_NULL(p))
>  		return;
>  	btrfs_release_path(p);
>  	kmem_cache_free(btrfs_path_cachep, p);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 75fa563e4cacb..babc86af564a2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -6,6 +6,7 @@
>  #ifndef BTRFS_CTREE_H
>  #define BTRFS_CTREE_H
>  
> +#include "linux/cleanup.h"
>  #include <linux/pagemap.h>
>  #include <linux/spinlock.h>
>  #include <linux/rbtree.h>
> @@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
>  void btrfs_release_path(struct btrfs_path *p);
>  struct btrfs_path *btrfs_alloc_path(void);
>  void btrfs_free_path(struct btrfs_path *p);
> +DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))
> +#define BTRFS_PATH_AUTO_FREE(path_name) \
> +	struct btrfs_path *path_name __free(btrfs_free_path) = NULL;

This would be better defined next to the structure, btrfs_path in this
case, so we know which ones already have it.

