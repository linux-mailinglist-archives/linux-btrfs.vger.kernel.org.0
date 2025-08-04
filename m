Return-Path: <linux-btrfs+bounces-15839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5180AB1A3F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733C817E8C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A585E26CE0A;
	Mon,  4 Aug 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHurxQ/5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="450b81QQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHurxQ/5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="450b81QQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB625C81C
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315880; cv=none; b=KgHwVh3ft94V/JwU44t34R85He/bFDrv/tjnlDDYWURCIDJxTu9unVtqc4LBLNlEvjvEOdMA9m0oVX8bwdr4bS955PS9T0uBMH2AfCDjTybISPB5ImdZ3+Tg4mb5OBLlnM53OuLl59576ED/fUFKo4ONgCY4EZK9BXjiZ1e7fYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315880; c=relaxed/simple;
	bh=UG1dFAmoLjOcFnHgetyPC+IFUv4lbYhMwG7regAWXKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TknMRJz3PY8Kyjrc4Mkwk83yEwymY6NTqrCqqUwRmyjSa9IagYxX1n1QZJO4+XXfzkhIRN/PcF8TnurKqxbGEr4jv/F8+rFIZjDPENRcUgA8JgX1x2ED3Vay8MjY6veq1Mbmuj5u9RVrejVB/t//paKLZcOXAfURUmHjE1jsxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHurxQ/5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=450b81QQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHurxQ/5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=450b81QQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 354A21FDAF;
	Mon,  4 Aug 2025 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754315876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qteJAsphntdXBDM5vEhw5etzgD6yqjwlY39GdzgFEY=;
	b=fHurxQ/5q6bE4XH7U39hc2igsxdzGIVujYsV7N48EMyeeS1C6iR67TGY3jLwB5qTQ/9vP+
	SoSn4c/b4/mICz5IxnfnUmNSL8nIrzyHXIS/A8/Z81McTdcB7h85RFtq1Wrl9ZOG3viTOZ
	p7G4BPQF7GryQhl/2B8FA6J7aUZCt/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754315876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qteJAsphntdXBDM5vEhw5etzgD6yqjwlY39GdzgFEY=;
	b=450b81QQVvVKMkhyP/cd+PhFxZuYN6ZTFUPnF37HtxjtRE8dr9M1tUz+irnGYk8s5SItt5
	1mdsauf/boJHzqAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754315876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qteJAsphntdXBDM5vEhw5etzgD6yqjwlY39GdzgFEY=;
	b=fHurxQ/5q6bE4XH7U39hc2igsxdzGIVujYsV7N48EMyeeS1C6iR67TGY3jLwB5qTQ/9vP+
	SoSn4c/b4/mICz5IxnfnUmNSL8nIrzyHXIS/A8/Z81McTdcB7h85RFtq1Wrl9ZOG3viTOZ
	p7G4BPQF7GryQhl/2B8FA6J7aUZCt/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754315876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qteJAsphntdXBDM5vEhw5etzgD6yqjwlY39GdzgFEY=;
	b=450b81QQVvVKMkhyP/cd+PhFxZuYN6ZTFUPnF37HtxjtRE8dr9M1tUz+irnGYk8s5SItt5
	1mdsauf/boJHzqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15484133D1;
	Mon,  4 Aug 2025 13:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xADHBGS8kGjDWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 04 Aug 2025 13:57:56 +0000
Date: Mon, 4 Aug 2025 15:57:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250804135750.GL6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b3553e5bee047c081c32f5689aaf1db7143f21b1.1753746365.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3553e5bee047c081c32f5689aaf1db7143f21b1.1753746365.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jul 29, 2025 at 12:08:04AM -0700, Leo Martins wrote:
> This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> 
> A ref_tracker object is allocated every time the reference count is
> increased and freed when the reference count is decreased. The
> ref_tracker object contains stack_trace information about where the
> ref count is increased and decreased. The ref_tracker_dir embedded in
> btrfs_delayed_node keeps track of all current references, and some
> previous references. This information allows for detection of reference
> leaks or double frees.
> 
> Here is a common example of taking a reference to a delayed_node and
> freeing it with ref_tracker.
> 
> ```C
> struct ref_tracker *tracker;
> struct btrfs_delayed_node *node;
> 
> node = btrfs_get_delayed_node(inode, tracker);
> // use delayed_node...
> btrfs_release_delayed_node(node, tracker);
> ```
> 
> There are two special cases where the delayed_node reference is long
> term, meaning that the thread that takes the reference and the thread
> that frees the reference are different. The inode_cache which is the
> btrfs_delayed_node reference stored in the associated btrfs_inode, and
> the node_list which is the btrfs_delayed_node reference stored in the
> btrfs_delayed_root node_list/prepare_list. In these cases the
> ref_tracker is stored in the delayed_node itself.
> 
> This patch introduces some new wrappers (btrfs_delayed_node_ref_tracker_*)
> to ensure that when BTRFS_DEBUG is disabled everything gets compiled out.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

I'm still missing why we need to add this whole infrastructure, there
weren't any recent bugs in delayed inode tracking. I understand what the
ref tracker does but it's still increasing structure size and adds a
perf hit that is acceptable for debugging kernels but still.

We have the ref-verify code and mount option, from what I've heard it
was used sporadically when touching related code. We can let the ref
tracking work like that too, not turned on by default ie. requiring a
mount option.

In case you'd want to enhance more structures with ref tracker the mount
option can enable them selectively.

> @@ -106,6 +113,13 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  		 */
>  		if (refcount_inc_not_zero(&node->refs)) {
>  			refcount_inc(&node->refs);
> +#ifdef CONFIG_BTRFS_DEBUG
> +			inode_cache_tracker = &node->inode_cache_tracker;
> +#endif

We try to avoid #ifdefs if it's a repeating pattern, this should be
abstracted away in a helper.

> +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> +							     GFP_ATOMIC);
> +			btrfs_delayed_node_ref_tracker_alloc(
> +				node, inode_cache_tracker, GFP_ATOMIC);
>  			btrfs_inode->delayed_node = node;
>  		} else {
>  			node = NULL;
> @@ -125,17 +139,19 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>   *
>   * Return the delayed node, or error pointer on failure.
>   */
> -static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> -		struct btrfs_inode *btrfs_inode)
> +static struct btrfs_delayed_node *
> +btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
> +				 struct ref_tracker **tracker)

And another pattern, please don't change the style of the function
definition line, the return value is on the same line as name, if
parameters don't fit under reasonable column limit like 90 chars then
it's on the next line. Most of the code has been fixed so you can just
extend it.

>  {
>  	struct btrfs_delayed_node *node;
> +	struct ref_tracker **inode_cache_tracker = NULL;
>  	struct btrfs_root *root = btrfs_inode->root;
>  	u64 ino = btrfs_ino(btrfs_inode);
>  	int ret;
>  	void *ptr;
>  

> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -7,6 +7,7 @@
>  #ifndef BTRFS_DELAYED_INODE_H
>  #define BTRFS_DELAYED_INODE_H
>  
> +#include <linux/ref_tracker.h>
>  #include <linux/types.h>
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
> @@ -63,8 +64,19 @@ struct btrfs_delayed_node {
>  	struct rb_root_cached del_root;
>  	struct mutex mutex;
>  	struct btrfs_inode_item inode_item;
> -	refcount_t refs;
> +
>  	int count;
> +	refcount_t refs;
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +	/* Used to track all references to this delayed node. */
> +	struct ref_tracker_dir ref_dir;
> +	/* Used to track delayed node reference stored in node list. */
> +	struct ref_tracker *node_list_tracker;
> +	/* Used to track delayed node reference stored in inode cache. */
> +	struct ref_tracker *inode_cache_tracker;
> +#endif

Optional and debugging structure members are best placed near the end.
In this case it's related to the refs so this could be mentioned in
comments as 'refs' should not be moved.

> +
>  	u64 index_cnt;
>  	unsigned long flags;
>  	/*

