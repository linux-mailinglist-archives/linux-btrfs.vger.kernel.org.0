Return-Path: <linux-btrfs+bounces-16049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C532FB249D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9471BC4F78
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EBE2E7167;
	Wed, 13 Aug 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vuOVDmDq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83VzRuqf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vuOVDmDq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83VzRuqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B332E3365
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089463; cv=none; b=lFOWIiTYK6PHuIiAO31eFJ0fmJWjuOKs3m4uunugBh+K0ujWSTnHhXrLpkP1TpXYdzKzNWml4YFr0Jt6Kx08Mhmvzr5zGdW+wm0TS4QFHS8BQBIirfBvTjTdcsxG+pyQ3upsGuQAKMPvbDoltFZxJy5R7PoXKOfACrxNzXuRPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089463; c=relaxed/simple;
	bh=ZjXupREyUKTqd58OsLI9f/WAAlQPQTHxDf+u/b2KOGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY5Yt2nsFis7zdWtVGzooT9uC31nh7cvWXsV/PSDf3E7/x5hHGdjnd7KPXmfIVW55ddouzXsWKPyufoaz35QQFJJu3JAXNuAbmJREDSRBEvv5yR2zFKfWpWr3r3mmU0PK2KVwe9J9Trjjx1nvwpNe1AztfznzU8FPDjuqNh3Hjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vuOVDmDq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=83VzRuqf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vuOVDmDq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=83VzRuqf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADADA21271;
	Wed, 13 Aug 2025 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755089453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGlBMteA5/8CS2rcEsiL+ZHSQIOjKZZQACQ6pMSqYCE=;
	b=vuOVDmDqQU+T2N+fx2+XoRAbvQATVIpWiqMZirePH+FJNK9iwkc7vjT/yRVVngWEouseQW
	MHqfcfWMYh8O4sS4d9yvRmNnLKAwrqrc5HkYyjCAnvIp5bMtUR229r79AG5JmMaqS/Hcm4
	y/GN4o6KVCsGdRPTbmVgAFeGt4YVcyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755089453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGlBMteA5/8CS2rcEsiL+ZHSQIOjKZZQACQ6pMSqYCE=;
	b=83VzRuqf+3sPViKr2NKpEV9fDzXK84/YtRDuoQK+6hjbJBLDSCRm6pTDAKuHnxe2GwF6di
	wu+Di3WGTBTXoFCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vuOVDmDq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=83VzRuqf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755089453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGlBMteA5/8CS2rcEsiL+ZHSQIOjKZZQACQ6pMSqYCE=;
	b=vuOVDmDqQU+T2N+fx2+XoRAbvQATVIpWiqMZirePH+FJNK9iwkc7vjT/yRVVngWEouseQW
	MHqfcfWMYh8O4sS4d9yvRmNnLKAwrqrc5HkYyjCAnvIp5bMtUR229r79AG5JmMaqS/Hcm4
	y/GN4o6KVCsGdRPTbmVgAFeGt4YVcyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755089453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGlBMteA5/8CS2rcEsiL+ZHSQIOjKZZQACQ6pMSqYCE=;
	b=83VzRuqf+3sPViKr2NKpEV9fDzXK84/YtRDuoQK+6hjbJBLDSCRm6pTDAKuHnxe2GwF6di
	wu+Di3WGTBTXoFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93B9D13479;
	Wed, 13 Aug 2025 12:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOLiIy2KnGhIUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 13 Aug 2025 12:50:53 +0000
Date: Wed, 13 Aug 2025 14:50:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/3] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250813125052.GC22430@twin.jikos.cz>
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
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: ADADA21271
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
> 
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

There's some witespace damage that fails when the patch is applied by
'git am', it can be fixed manually but please fix that next time.

> ---
>  fs/btrfs/Kconfig         |   3 +-
>  fs/btrfs/delayed-inode.c | 192 ++++++++++++++++++++++++++++-----------
>  fs/btrfs/delayed-inode.h |  70 ++++++++++++++
>  3 files changed, 209 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index c352f3ae0385..2745de514196 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -61,7 +61,8 @@ config BTRFS_FS_RUN_SANITY_TESTS
>  
>  config BTRFS_DEBUG
>  	bool "Btrfs debugging support"
> -	depends on BTRFS_FS
> +	depends on BTRFS_FS && STACKTRACE_SUPPORT

How does this work? If STACKTRACE_SUPPORT is not enabled then we can't
enable BTRFS_DEBUG?

> +	select REF_TRACKER
>  	help
>  	  Enable run-time debugging support for the btrfs filesystem.
>  

> @@ -78,6 +95,12 @@ struct btrfs_delayed_node {
>  	 * actual number of leaves we end up using. Protected by @mutex.
>  	 */
>  	u32 index_item_leaves;
> +	/* Used to track all references to this delayed node. */
> +	struct btrfs_ref_tracker_dir ref_dir;
> + 	/* Used to track delayed node reference stored in node list. */
> +	struct btrfs_ref_tracker node_list_tracker;
> + 	/* Used to track delayed node reference stored in inode cache. */
> +	struct btrfs_ref_tracker inode_cache_tracker;

Some of the comments have mixed space and tabs in the initial space.

>  };
>  
>  struct btrfs_delayed_item {
> @@ -169,4 +192,51 @@ void __cold btrfs_delayed_inode_exit(void);
>  /* for debugging */
>  void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info);
>  
> +#define BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT 16
> +#define BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT 16
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node)
> +{
> +	ref_tracker_dir_init(&node->ref_dir.dir, 

Trailing space.

> +			     BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT,
> +			     "delayed_node");
> +}

