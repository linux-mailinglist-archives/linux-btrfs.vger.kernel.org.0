Return-Path: <linux-btrfs+bounces-16196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B7B2FB8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE15820DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7962EC54D;
	Thu, 21 Aug 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/hCyzOX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XF/jXdyz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/hCyzOX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XF/jXdyz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5192EC56E
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784359; cv=none; b=RRLyLm5WBzgDlekYHJPdwuoQw3TjYAwPiyBHaZ4r0L9rnjUU0tHcG5MHs2n5fheo/bR3xYr+Yyce6TQ6SKWyA9F28CcS+5FxGmEzcdPQHqHZRhuB510ibKfFJmKw6iAclRPwmL7mnyFLAdetcHnfmLJ/0mTuA7rYP1sTwQVgz20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784359; c=relaxed/simple;
	bh=la8nM8xwv+a7RN7sj69vMJ2mOOjRsOPiiMXaamCNpd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWhvo/3w9ibd1aoWF2EEnhSQqrXWn28nIR141QD82t38cvkiIhgTSBYgb61NyweFuOr+WA+OlGFAQNunmYAjBtGZg/ATLJv4Xil16CNKQ8/T2/hytSxhxr0TIPxELegoK9L5gC/1gAoE/q2Pn/CvVh1LQwxY7Z9RTryAVPgsHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/hCyzOX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XF/jXdyz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/hCyzOX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XF/jXdyz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 516B31F395;
	Thu, 21 Aug 2025 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755784355;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7eIltLd9lAZFU9KXIXcGGBy4Htg6D5QNHfuuEO6h40=;
	b=j/hCyzOXs8jttJGZM8EQ/zqVfspjBoW2lYwQMKYkjB8fpb+fxrI10ej5LgZ2iSz7eG/bgt
	yFRunl6iHrHQ0lP57ivbp82maHfYvNYACaCZoS5l9vuBPWUfHThYC9MYy2wMuqjAmojU2U
	NpAQZhigX0PTj6QNYJY0G//pc1QBM9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755784355;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7eIltLd9lAZFU9KXIXcGGBy4Htg6D5QNHfuuEO6h40=;
	b=XF/jXdyzfEwf9i8f/HM2R9fEzsstWBXmkofTlReN2nUqKsrv0uErgUCUx1UH94GdrUbt9K
	ECdHRElatb/8eYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755784355;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7eIltLd9lAZFU9KXIXcGGBy4Htg6D5QNHfuuEO6h40=;
	b=j/hCyzOXs8jttJGZM8EQ/zqVfspjBoW2lYwQMKYkjB8fpb+fxrI10ej5LgZ2iSz7eG/bgt
	yFRunl6iHrHQ0lP57ivbp82maHfYvNYACaCZoS5l9vuBPWUfHThYC9MYy2wMuqjAmojU2U
	NpAQZhigX0PTj6QNYJY0G//pc1QBM9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755784355;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7eIltLd9lAZFU9KXIXcGGBy4Htg6D5QNHfuuEO6h40=;
	b=XF/jXdyzfEwf9i8f/HM2R9fEzsstWBXmkofTlReN2nUqKsrv0uErgUCUx1UH94GdrUbt9K
	ECdHRElatb/8eYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C18F13867;
	Thu, 21 Aug 2025 13:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tF18DqMkp2hpcwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 21 Aug 2025 13:52:35 +0000
Date: Thu, 21 Aug 2025 15:52:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: btrfs: fix possible race between error
 handling and writeback
Message-ID: <20250821135234.GT22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1753687685.git.wqu@suse.com>
 <20250818154812.GO22430@twin.jikos.cz>
 <afd0e356-973c-4007-9603-88d690bb23aa@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afd0e356-973c-4007-9603-88d690bb23aa@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Tue, Aug 19, 2025 at 07:17:28AM +0930, Qu Wenruo wrote:
> 在 2025/8/19 01:18, David Sterba 写道:
> > On Mon, Jul 28, 2025 at 05:57:53PM +0930, Qu Wenruo wrote:
> >> Qu Wenruo (4):
> >>    btrfs: rework the error handling of run_delalloc_nocow()
> >>    btrfs: enhance error messages for delalloc range failure
> >>    btrfs: make nocow_one_range() to do cleanup on error
> >>    btrfs: keep folios locked inside run_delalloc_nocow()
> > 
> > The patches have been in linux-next for some time, feel free to add them
> > to for-next proper so they can be merged. Related to that, you can
> > remove the cow fixup code in this development cycle if you want.
> > 
> 
> Unfortunately even with this series applies, I'm still hitting COW fixup 
> warning at a very low chance for g/475.
> 
> So I'm afraid we're not yet done about all the possible error paths, 
> thus no removal of cow fixup yet.

I see. Alternatively the cow fixup can be turned to proper debugging
mechanism so you can still use it to catch bugs but it does not need to
have the whole fixup mechanism. If we can get rid of the fixup worker
kthread it would still be a good incremental step as it's just idling
and consuming rerources.

