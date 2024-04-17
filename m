Return-Path: <linux-btrfs+bounces-4382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5858A8D65
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69978B21B17
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D096481BB;
	Wed, 17 Apr 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4yejVZ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T02byIis";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4yejVZ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T02byIis"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E064084E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387488; cv=none; b=GxRmnPq62d1vPV6cFTbkJAqxqUwQ8onu+XymD+XdQtrhAKzcn3a+T3FpHaPHVZO5RNqKODbZMCBv1trJ1FMnGPC/omlRqcpODltkco471YBPNevvRj0vjTtbI3d4CzzVPZRWG6e61bkY7hdM4fKWY6xcEbR+bGyWU//AhdnvyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387488; c=relaxed/simple;
	bh=L5CLDW0wa6t8p7q3tT+GKMum/HU31YwvviPanCu9y/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZqqwSi4s6TLEgqvp6T7t9TjTdbHXX5BIlfud0VQR15rcQQumUalPi6x4p0rZZaIaCgIONvQDa1VHhX4rBgBm8PzLg8VP5TagG7S63Ihi5Oi/xYYYxP2O3JoFlZbvCtDtfWRRtHtw0fJsxCp3hcuZe7nuliXllqCUhzGUaLbWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4yejVZ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T02byIis; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4yejVZ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T02byIis; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDB8D34254;
	Wed, 17 Apr 2024 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713387484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+v+ULYfLAsrntVXQv7yh9Zi5Mhhpu30Hlt7YYDGCuI=;
	b=J4yejVZ7JVIyXwtgeGNjNONO9AwKhRDMZNWNCNFABd/dHhuz+lDAmmkc4a2iH/vS20iZz0
	PBKvGdXfhNwSigjIYjMkdah2BTYsp/RWohupGXuro4wioJuOlXc8vVmTJe84khjkIFTQeb
	OshvF5W8BKxsvpcf/QzU31tRkwZV24M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713387484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+v+ULYfLAsrntVXQv7yh9Zi5Mhhpu30Hlt7YYDGCuI=;
	b=T02byIisOG9SHIKsPBaAEoVR1wgUE/CpVI7KakXN/R9su/6pV6hQ2CIx2kfqjL8PXO5weq
	hL050H6V31Bu3hAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J4yejVZ7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T02byIis
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713387484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+v+ULYfLAsrntVXQv7yh9Zi5Mhhpu30Hlt7YYDGCuI=;
	b=J4yejVZ7JVIyXwtgeGNjNONO9AwKhRDMZNWNCNFABd/dHhuz+lDAmmkc4a2iH/vS20iZz0
	PBKvGdXfhNwSigjIYjMkdah2BTYsp/RWohupGXuro4wioJuOlXc8vVmTJe84khjkIFTQeb
	OshvF5W8BKxsvpcf/QzU31tRkwZV24M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713387484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+v+ULYfLAsrntVXQv7yh9Zi5Mhhpu30Hlt7YYDGCuI=;
	b=T02byIisOG9SHIKsPBaAEoVR1wgUE/CpVI7KakXN/R9su/6pV6hQ2CIx2kfqjL8PXO5weq
	hL050H6V31Bu3hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B47131384C;
	Wed, 17 Apr 2024 20:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KTXjK9w3IGZDUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 17 Apr 2024 20:58:04 +0000
Date: Wed, 17 Apr 2024 22:50:26 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize delayed inodes xarray without
 GFP_ATOMIC
Message-ID: <20240417205026.GT3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.06
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BDB8D34254
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.06 / 50.00];
	BAYES_HAM(-2.85)[99.36%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, Apr 17, 2024 at 04:18:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to initialize the delayed inodes xarray with a GFP_ATOMIC
> flag because that actually does nothing on the xarray operations. That was
> needed for radix trees (before their internals were updated to use xarray)
> but for xarrays the allocation flags are passed as the last argument to
> xa_store() (which we are using correctly).
> 
> So initialize the delayed inodes xarray with a simple xa_init().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

