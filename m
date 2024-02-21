Return-Path: <linux-btrfs+bounces-2607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E863A85D78B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F979283DDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5494D595;
	Wed, 21 Feb 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C64f5iQE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cEVxARJJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C64f5iQE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cEVxARJJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618414CB28;
	Wed, 21 Feb 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516879; cv=none; b=X+e2X8k5YHoQ1ffI+Uvnxp4tu5uiPBmaSEAoOmgLHOD6fZABkiKjKDKwxFtTLU/RkHJR8nm7K7A7XXdE9cPlYU28xWXmoYtuLas9NBoBDI4cP6OLsVD4ni+3VT0I7OCyuWAGJ4mR4oi9H4+tnYApN8K/eeSCFYGiiSxl8fkRFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516879; c=relaxed/simple;
	bh=rh5d4BxxAV0hi2KwaLY55hyv9DtaFkNtXG73fekBbXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljAukjPIZGYgkfV+4OMII5RqJPdrjKjf9MEwSqtH2vJBZ2auJXyd6+9jFsQfruXbdYXB4tw0mNmzgy7lZhe++tuKMAl00iMK773GVZUDusFrGcHlx6vS+tqPoqjc6EHM3KPnKXvrfM6Lf0Anz+wuxbfRnJj8DZQZT8a/4H2Pp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C64f5iQE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cEVxARJJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C64f5iQE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cEVxARJJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8378A22339;
	Wed, 21 Feb 2024 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708516875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ni5mPriG+jmdxYyrnCDO78SkVFYHUHeUp1IB1EtveNU=;
	b=C64f5iQEcln2Laa+eMKfTDPpIopirhjth2p3qxv94GAcIYvy15a1IjQNtuNCC0UlEEMLV3
	bQtJzIs9lSMikbgkwAYOaQ6HiVm+My790Y3nefL27Lgv5CAfREZYiMg8QHz5L6lkY0IFU4
	ToCvaasGCRZM+geRfdS798HzYrVHfjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708516875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ni5mPriG+jmdxYyrnCDO78SkVFYHUHeUp1IB1EtveNU=;
	b=cEVxARJJsTOx2Gz4E+rsY73JGWymItp/5zg0MHzO0S5PFwqnDiCpoE/XilXCYLWnCE+rNA
	Ea09qcqZmrF1tKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708516875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ni5mPriG+jmdxYyrnCDO78SkVFYHUHeUp1IB1EtveNU=;
	b=C64f5iQEcln2Laa+eMKfTDPpIopirhjth2p3qxv94GAcIYvy15a1IjQNtuNCC0UlEEMLV3
	bQtJzIs9lSMikbgkwAYOaQ6HiVm+My790Y3nefL27Lgv5CAfREZYiMg8QHz5L6lkY0IFU4
	ToCvaasGCRZM+geRfdS798HzYrVHfjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708516875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ni5mPriG+jmdxYyrnCDO78SkVFYHUHeUp1IB1EtveNU=;
	b=cEVxARJJsTOx2Gz4E+rsY73JGWymItp/5zg0MHzO0S5PFwqnDiCpoE/XilXCYLWnCE+rNA
	Ea09qcqZmrF1tKDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A12013A25;
	Wed, 21 Feb 2024 12:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YJu1GQvm1WWmKgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 21 Feb 2024 12:01:15 +0000
Date: Wed, 21 Feb 2024 13:00:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: Use KMEM_CACHE instead of kmem_cache_create
Message-ID: <20240221120030.GI355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240220090645.108625-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220090645.108625-1-chentao@kylinos.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C64f5iQE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cEVxARJJ
X-Spamd-Result: default: False [-0.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.28)[74.49%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.29
X-Rspamd-Queue-Id: 8378A22339
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue, Feb 20, 2024 at 05:06:39PM +0800, Kunwu Chan wrote:
> As David Sterba said in 
> https://lore.kernel.org/all/20240205160408.GI355@twin.jikos.cz/
> I'm using a patchset to cleanup the same issues in the 'brtfs' module.
> 
> For where the cache name and the structure name match.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Kunwu Chan (6):
>   btrfs: Simplify the allocation of slab caches in
>     btrfs_delayed_inode_init
>   btrfs: Simplify the allocation of slab caches in ordered_data_init
>   btrfs: Simplify the allocation of slab caches in
>     btrfs_transaction_init
>   btrfs: Simplify the allocation of slab caches in btrfs_ctree_init
>   btrfs: Simplify the allocation of slab caches in
>     btrfs_delayed_ref_init
>   btrfs: Simplify the allocation of slab caches in btrfs_free_space_init

Added to for-next, thanks. I've edited the changels so the name of the
structure is mentioned rather than the function where it happens, and
did some minor formatting adjustments.

