Return-Path: <linux-btrfs+bounces-14037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3CAB87BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8111BA7751
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666207260B;
	Thu, 15 May 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lDscr7mX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dc1ze/un";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lDscr7mX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dc1ze/un"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32253481C4
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315199; cv=none; b=fjdjENM3rIch0kiNrJZY62xMNTCcyQVgDE7SbxMLsABmHsu1nlGRf2Iyt3nI3BEnC6SUfH8deDN1HD2VcF2wEMCG7Cfp2kTk7H599yK8+BYM+0IGp3u41L4fdkK01JQ5AtlX4k6LC3UukLp18VQNoLBZGLPm1Tbdwe4iSx3AzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315199; c=relaxed/simple;
	bh=s0kXq3BM7Akxfk1vvZwGZUnjZnsT1rFzZCQqB/hAVGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXs+qJohMs3baD18FlzhoOAvZcFTz2OzjFuq+Xqds/bohMMt42rfY1DmrGLExSyWyt3Qnd84eOpTu4bOPyXf11u4hXiWdqN/ICGQDK7QxSx8qKKMqAEIwYNoZbpHJYh2tAk2vdf8B4SvBM6v+7D8yM0rMayoRicyiUXaUgHJkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lDscr7mX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dc1ze/un; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lDscr7mX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dc1ze/un; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34ED01F74D;
	Thu, 15 May 2025 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747315196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs92DOZNo9wyQhrH7L1vBOYbTPl9vYJeqyG4oSB8Xyo=;
	b=lDscr7mXFIHlRNKx95ho6H/PRzi0qTffEPHmM3guOtUQ0iVoibPitXtnb95/VwLUGVRZCe
	2vENelXNAXd3QD2FRaAMscc4DktzhbbxfsVzY0VGxqq9Bf3JauS2wn5/YkRL27poAD/9mk
	w1VyvdZPwMfztrpYs9XWJoPQ/XsIEHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747315196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs92DOZNo9wyQhrH7L1vBOYbTPl9vYJeqyG4oSB8Xyo=;
	b=Dc1ze/unBKtaZ9rGCAxu4mNjnbpaxCQ2QKZiknWeaR2Jr8dhokIhDkSnsc4i83L3+gwPxU
	nczpTTt20MwXSADw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747315196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs92DOZNo9wyQhrH7L1vBOYbTPl9vYJeqyG4oSB8Xyo=;
	b=lDscr7mXFIHlRNKx95ho6H/PRzi0qTffEPHmM3guOtUQ0iVoibPitXtnb95/VwLUGVRZCe
	2vENelXNAXd3QD2FRaAMscc4DktzhbbxfsVzY0VGxqq9Bf3JauS2wn5/YkRL27poAD/9mk
	w1VyvdZPwMfztrpYs9XWJoPQ/XsIEHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747315196;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs92DOZNo9wyQhrH7L1vBOYbTPl9vYJeqyG4oSB8Xyo=;
	b=Dc1ze/unBKtaZ9rGCAxu4mNjnbpaxCQ2QKZiknWeaR2Jr8dhokIhDkSnsc4i83L3+gwPxU
	nczpTTt20MwXSADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21A45139D0;
	Thu, 15 May 2025 13:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RH3EB/zpJWhHGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 15 May 2025 13:19:56 +0000
Date: Thu, 15 May 2025 15:19:46 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: fix a bug and cleanups in
 btrfs_page_mkwrite()
Message-ID: <20250515131946.GG9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747222631.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747222631.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00

On Wed, May 14, 2025 at 12:38:32PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A bug fix for mmap writes and a couple cleanups. Details in the change logs.
> 
> V2: Added two more patches (4/5 and 5/5).
> 
> Filipe Manana (5):
>   btrfs: fix wrong start offset for delalloc space release during mmap write
>   btrfs: pass true to btrfs_delalloc_release_space() at btrfs_page_mkwrite()
>   btrfs: simplify early error checking in btrfs_page_mkwrite()
>   btrfs: don't return VM_FAULT_SIGBUS on failure to set delalloc for mmap write
>   btrfs: use a single variable to track return value at btrfs_page_mkwrite()

Reviewed-by: David Sterba <dsterba@suse.com>

