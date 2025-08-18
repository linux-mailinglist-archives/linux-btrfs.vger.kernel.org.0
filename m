Return-Path: <linux-btrfs+bounces-16127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463CB2AD49
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8015F18A2CAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6530E82E;
	Mon, 18 Aug 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N6fJhB4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/EzSQXR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N6fJhB4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/EzSQXR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40131CA6E
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532101; cv=none; b=O3AGhy+LFCQXGNYdJzjVIkx0CJxlv+2BVAJGEaZfLu0wqK+gcomqPeZz+nJuR+dplHzvtVmJ+FClgAiC5eqFDanXEnVDPLzYPupfurWCVE/ZulM2Aw7S43Fkf5oMV9ybJulHp7FzD2PuZHzRjeATGl+q0i9xgYHIOPIVa1Ar9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532101; c=relaxed/simple;
	bh=R+tRFceCPrbIiG0tJSdQTWwCay4IIwo4z6nt/MC/0uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSCmvbEGBfYqBci2S+rCqFm9ZGwGxiglQJ9k2nVEsqjJm0CwPNtnzkW8KNASd0V5kXd5+ynZDngKM4NsbtR+lU04rV5lQ3bFDjt9ZZu8YozNVVFn4xIDPNEehQ3LGN5eN0URPnjFt9E/P+RKF0N7mMPqlX6Et/lytxN2SFyjNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N6fJhB4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/EzSQXR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N6fJhB4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/EzSQXR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A64D82124B;
	Mon, 18 Aug 2025 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755532097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrXbn49kqvWFaI4ngcmaJ/PzqNfxLwrvJbx/9Bbm+/Y=;
	b=N6fJhB4crdaGiNENvCZ+Dm/2NX6GcaQyNJS6aXDJygJJ19c5SbAl0rwmwQgjNgmb0M6HHu
	y87C2dLx6J1ncREeFSQnLvpPpTQTNW93/AS6wtr33rjp4d8t+np++E2yaLf5GZxtPDY3Y9
	z+RCCnMpjpk4FNyvJZ8gMDmzMZWtLlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755532097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrXbn49kqvWFaI4ngcmaJ/PzqNfxLwrvJbx/9Bbm+/Y=;
	b=G/EzSQXR24o4//uQPYlN/NzAOLMSFddQIjjMNIIAuSgmy8BBBuAXa2Zukb3Q+wcSzJ0J6T
	1lSu9CcdjwOlrADw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N6fJhB4c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="G/EzSQXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755532097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrXbn49kqvWFaI4ngcmaJ/PzqNfxLwrvJbx/9Bbm+/Y=;
	b=N6fJhB4crdaGiNENvCZ+Dm/2NX6GcaQyNJS6aXDJygJJ19c5SbAl0rwmwQgjNgmb0M6HHu
	y87C2dLx6J1ncREeFSQnLvpPpTQTNW93/AS6wtr33rjp4d8t+np++E2yaLf5GZxtPDY3Y9
	z+RCCnMpjpk4FNyvJZ8gMDmzMZWtLlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755532097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrXbn49kqvWFaI4ngcmaJ/PzqNfxLwrvJbx/9Bbm+/Y=;
	b=G/EzSQXR24o4//uQPYlN/NzAOLMSFddQIjjMNIIAuSgmy8BBBuAXa2Zukb3Q+wcSzJ0J6T
	1lSu9CcdjwOlrADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F77613A55;
	Mon, 18 Aug 2025 15:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pBLfIkFLo2jSNwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Aug 2025 15:48:17 +0000
Date: Mon, 18 Aug 2025 17:48:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: btrfs: fix possible race between error
 handling and writeback
Message-ID: <20250818154812.GO22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1753687685.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753687685.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A64D82124B
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Mon, Jul 28, 2025 at 05:57:53PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add a new patch to explain the error handling better
>   This makes the later nocow_one_range() error handling change easier to explain.
> 
> There are some rare kernel warning for experimental btrfs builds that
> the DEBUG_WARN() can be triggered from btrfs_writepage_cow_fixup(),
> mostly after some delalloc range failure.
> 
> The root cause is explained the the last patch, the TL;DR is we
> shouldn't call btrfs_cleanup_ordered_extents() on folios that are
> already unlocked.
> 
> Those unlocked folios can be under writeback, and if we cleared the
> order flag just before the writeback thread entering
> btrfs_writepage_cow_fixup(), we will trigger the warning.
> 
> The first patch enhance the error handling of run_delalloc_nocow(), with
> proper comments and charts explaining the cleanup range.
> 
> The second patch is a small enhancement to the error messages, which
> helps debugging.
> 
> The third patch is to make nocow_one_range() to do proper cleanup,
> aligning itself to cow_file_range().
> 
> The last one is to fix the race window by keep folios of successful
> ranges locked, so that we either unlock them manually at the end of
> run_delalloc_nocow(), or get btrfs_cleanup_ordered_extents() called on
> locked folios for error handling.
> 
> 
> Qu Wenruo (4):
>   btrfs: rework the error handling of run_delalloc_nocow()
>   btrfs: enhance error messages for delalloc range failure
>   btrfs: make nocow_one_range() to do cleanup on error
>   btrfs: keep folios locked inside run_delalloc_nocow()

The patches have been in linux-next for some time, feel free to add them
to for-next proper so they can be merged. Related to that, you can
remove the cow fixup code in this development cycle if you want.

