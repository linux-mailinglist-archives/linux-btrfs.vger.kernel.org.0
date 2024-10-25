Return-Path: <linux-btrfs+bounces-9176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1D9B0D75
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 20:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A81F2455F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155C20BB47;
	Fri, 25 Oct 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRRoBnP0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nDv9TzNf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRRoBnP0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nDv9TzNf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961901C07FC
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881293; cv=none; b=RjQKOpkmUv5gBMnamFe9BLNGi2d7wQf7TCmLLfs4DPBivKT603yw+ZWtmar4mMz/CKd3bUHOjfdLWoQKFK3xXhZn1TKAUj1tn/xjnowVBhxPry8NmmQlRwjWf8HTiW7rqYkwqr9azRjPtZkGlLSD12aBrq49JO2mZfyoNdYck88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881293; c=relaxed/simple;
	bh=hazMXr/Byd3PMP3ljz17DzImqMvd+PbusvgBn3jpvP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lredD6mpKISckfL/E8ubgGsqseKaP5hgSUtHoTt+vq7bvNTD0/4n5WcDmNGmbEakW9/xWab9bkOtG9/Z4mo6+r+Ramgp8Q1SER6OSXIh2pGmUvd00qkIiZRbngkw+LEMV7G123EZT8X8yt8XwiPNjQuCBuHUsSFWktPPdlQz4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRRoBnP0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nDv9TzNf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRRoBnP0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nDv9TzNf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE7A51FE39;
	Fri, 25 Oct 2024 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729881289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2f/zF2CZPnVGyyLyxbm4aok6+IUUuw5Qv3vYuJZxN8=;
	b=XRRoBnP0kJI0HLI3P90xLSFzXnQGPbcHL9PKbvYfR/9AeD4hzKtl0FvsVOPfgxbNErFDY0
	Pqny0hX4ca9Fsg3EGKCkkIlt3GNLHJR5vxgOJ9s4eT2R0iiKKHUPexC9DQFGATLwWC+vFT
	QekLdeulwyjb0VY8xJhp3idVRbr4s2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729881289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2f/zF2CZPnVGyyLyxbm4aok6+IUUuw5Qv3vYuJZxN8=;
	b=nDv9TzNfOm85eoUsAVrSCDnGXkh1IpEkVdd1+zz0hOXA6tPTVzoYhPdJzHten4TywFo4yw
	Vzqb8mUGAYIVUICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729881289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2f/zF2CZPnVGyyLyxbm4aok6+IUUuw5Qv3vYuJZxN8=;
	b=XRRoBnP0kJI0HLI3P90xLSFzXnQGPbcHL9PKbvYfR/9AeD4hzKtl0FvsVOPfgxbNErFDY0
	Pqny0hX4ca9Fsg3EGKCkkIlt3GNLHJR5vxgOJ9s4eT2R0iiKKHUPexC9DQFGATLwWC+vFT
	QekLdeulwyjb0VY8xJhp3idVRbr4s2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729881289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2f/zF2CZPnVGyyLyxbm4aok6+IUUuw5Qv3vYuJZxN8=;
	b=nDv9TzNfOm85eoUsAVrSCDnGXkh1IpEkVdd1+zz0hOXA6tPTVzoYhPdJzHten4TywFo4yw
	Vzqb8mUGAYIVUICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90119136E4;
	Fri, 25 Oct 2024 18:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RhbyIsnkG2dOJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 18:34:49 +0000
Date: Fri, 25 Oct 2024 20:34:40 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Message-ID: <20241025183440.GJ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Oct 24, 2024 at 05:24:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This converts the rb-tree that tracks delayed ref heads into an xarray,
> reducing memory used by delayed ref heads and making it more efficient
> to add/remove/find delayed ref heads. The rest are mostly cleanups and
> refactorings, removing some dead code, deduplicating code, move code
> around, etc. More details in the changelogs.
> 
> Filipe Manana (18):
>   btrfs: remove BUG_ON() at btrfs_destroy_delayed_refs()
>   btrfs: move btrfs_destroy_delayed_refs() to delayed-ref.c
>   btrfs: remove fs_info parameter from btrfs_destroy_delayed_refs()
>   btrfs: remove fs_info parameter from btrfs_cleanup_one_transaction()
>   btrfs: remove duplicated code to drop delayed ref during transaction abort
>   btrfs: use helper to find first ref head at btrfs_destroy_delayed_refs()
>   btrfs: remove num_entries atomic counter from delayed ref root
>   btrfs: change return type of btrfs_delayed_ref_lock() to boolean
>   btrfs: simplify obtaining a delayed ref head
>   btrfs: move delayed ref head unselection to delayed-ref.c
>   btrfs: pass fs_info to functions that search for delayed ref heads
>   btrfs: pass fs_info to btrfs_cleanup_ref_head_accounting
>   btrfs: assert delayed refs lock is held at find_ref_head()
>   btrfs: assert delayed refs lock is held at find_first_ref_head()
>   btrfs: assert delayed refs lock is held at add_delayed_ref_head()
>   btrfs: add comments regarding locking to struct btrfs_delayed_ref_root
>   btrfs: track delayed ref heads in an xarray
>   btrfs: remove no longer used delayed ref head search functionality

Reviewed-by: David Sterba <dsterba@suse.com>

Thank you, nice cleanups and I like another conversion to xarray.

