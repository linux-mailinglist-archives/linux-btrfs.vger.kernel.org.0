Return-Path: <linux-btrfs+bounces-16092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C2CB288B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 01:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6391D05B7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE82D372F;
	Fri, 15 Aug 2025 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfiajacI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vapxKfD3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfiajacI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vapxKfD3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4692D0604
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300445; cv=none; b=jR8hRtnfKj7q+YqHZuLad518cn7mXBymFwMpwuFe4/WHyT8AmGtDSF7b0k/O5oWaVskkH4BuBamqG66OrQA0E+LvX/WmOUl2nJ3tJbZbpMi7qadqOz4jsdfM4zaPWw7r9Itt/8JvJhe1on2KPME77q5Ps+HAb/wpNfHuiOiTEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300445; c=relaxed/simple;
	bh=qgzmfl+KiBkm/GKWJgr5+R0gP3pB+JdgOvHJtAaBizY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr8S5elmLSAhimfc46YAaM6ryNgSi+XUCA/SxU2tb3VU6EtCR7NWegK97f6UpGPIHZoodOYfWjqniLptR0TGYb09xkA0J9ke9qVt5G1KvXxO9W5UmjSyiLk+dZifAJiTrv9zY8fT9xE6U+qMVzY7qZHFI3o/A1I05OFhqPiT9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfiajacI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vapxKfD3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfiajacI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vapxKfD3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 348581F7EA;
	Fri, 15 Aug 2025 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755300441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjdMtWDNsUVv/AQ+D0pBB38NORnJ5NshqxVgm7RaDq0=;
	b=RfiajacIkWzI1urlsooaSWfmUtQXR4QkIooMqLFydNeE2urdWW8IvMO3Lzmf/XgzZZL8te
	2/B0x1yP+pa8PA5XW32CIE7r5dlVEUkmKYejivzjP4GKwZywOVV4cIzrjY2nDQ9T53wlu3
	iNFc4VIAJrjIMVfUKPlDwfCAS0mDn0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755300441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjdMtWDNsUVv/AQ+D0pBB38NORnJ5NshqxVgm7RaDq0=;
	b=vapxKfD3DSQVLipfGoeKEwsnpXk5xFDgilMr/FKcvuRu1JKO+e4k8ek9Eu0L0umP55rAR1
	zmcCHAnuj9vxvwBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RfiajacI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vapxKfD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755300441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjdMtWDNsUVv/AQ+D0pBB38NORnJ5NshqxVgm7RaDq0=;
	b=RfiajacIkWzI1urlsooaSWfmUtQXR4QkIooMqLFydNeE2urdWW8IvMO3Lzmf/XgzZZL8te
	2/B0x1yP+pa8PA5XW32CIE7r5dlVEUkmKYejivzjP4GKwZywOVV4cIzrjY2nDQ9T53wlu3
	iNFc4VIAJrjIMVfUKPlDwfCAS0mDn0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755300441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjdMtWDNsUVv/AQ+D0pBB38NORnJ5NshqxVgm7RaDq0=;
	b=vapxKfD3DSQVLipfGoeKEwsnpXk5xFDgilMr/FKcvuRu1JKO+e4k8ek9Eu0L0umP55rAR1
	zmcCHAnuj9vxvwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EA701368C;
	Fri, 15 Aug 2025 23:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X+bwAlnCn2g4CgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 Aug 2025 23:27:21 +0000
Date: Sat, 16 Aug 2025 01:27:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/3] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250815232719.GH22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755035080.git.loemra.dev@gmail.com>
 <f97312e56638279c286304398526b5d4dfb15d88.1755035080.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97312e56638279c286304398526b5d4dfb15d88.1755035080.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 348581F7EA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid]
X-Spam-Score: -4.21

On Tue, Aug 12, 2025 at 04:04:39PM -0700, Leo Martins wrote:
> This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> 
> It is a response to the largest btrfs related crash in our fleet.
> We're seeing softlockups in btrfs_kill_all_delayed_nodes that seem
> to be a result of delayed_nodes not being released properly.
> 
> A ref_tracker object is allocated on reference count increases and
> freed on reference count decreases. The ref_tracker object stores
> a stack trace of where it is allocated. The ref_tracker_dir object
> is embedded in btrfs_delayed_node and keeps track of all current
> and some old/freed ref_tracker objects. When a leak is detected
> we can print the stack traces for all ref_trackers that have not
> yet been freed.
> 
> Here is a common example of taking a reference to a delayed_node
> and freeing it with ref_tracker.
> 
> ```C
> struct btrfs_ref_tracker tracker;
> struct btrfs_delayed_node *node;
> 
> node = btrfs_get_delayed_node(inode, &tracker);
> // use delayed_node...
> btrfs_release_delayed_node(node, &tracker);
> ```

Please don't use markdown in the changelogs, it's meant to be plain
text. Quotation is ok with single quotes too in the text, for function
references we've been using (), and the kdoc formatting for parameter or
variable references uses @ like @parameter. It's not mandated or
validated so ideally everybody uses the same style, I review and fixup
changelogs once patches are committed so no big deal if something is
overlooked.

> There are two special cases where the delayed_node reference is "long
> lived", meaning that the thread that takes the reference and the thread
> that releases the reference are different. The `inode_cache_tracker`
> tracks the delayed_node stored in btrfs_inode. The `node_list_tracker`
> tracks the delayed_node stored in the btrfs_delayed_root
> node_list/prepare_list. These trackers are embedded in the
> btrfs_delayed_node.
> 
> btrfs_ref_tracker and btrfs_ref_tracker_dir are wrappers that either
> compile to the corresponding ref_tracker structs or empty structs
> depending on CONFIG_BTRFS_DEBUG. There are also btrfs wrappers for
> the ref_tracker API.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
> @@ -83,6 +86,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  	if (node) {
>  		if (btrfs_inode->delayed_node) {
>  			refcount_inc(&node->refs);	/* can be accessed */
> +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> +							     GFP_ATOMIC);

I've noticed that only after I've applied the patch, the line breaks are
not necessary, the recommendation of 80 columns per line is loose and if
the overflowing text leaves a prefix that makes it understandable from
the context it's ok to use up to 85-ish.

>  			BUG_ON(btrfs_inode->delayed_node != node);
>  			xa_unlock(&root->delayed_nodes);
>  			return node;
> @@ -106,6 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>  		 */
>  		if (refcount_inc_not_zero(&node->refs)) {
>  			refcount_inc(&node->refs);
> +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> +							     GFP_ATOMIC);
> +			btrfs_delayed_node_ref_tracker_alloc(
> +				node, &node->inode_cache_tracker, GFP_ATOMIC);

So we've switched from this style long ago and the function line call
should take parameters that fit under the 85 limit and then on the next
line, either alingn under "(" or of does not leave enough space
un-indent a few times.

I don't think editors can be configured to do that automatically, I
recommend to look at the code and get the visual feeling of it to be
consistent with the rest. This improves code reading experience for
everybody.

