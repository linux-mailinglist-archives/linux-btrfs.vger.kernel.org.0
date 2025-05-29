Return-Path: <linux-btrfs+bounces-14299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A4AC7FF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AC74A2FD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39522AE68;
	Thu, 29 May 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmjQdxdv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jKYf5twL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUh2TOPA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbi4k777"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07017A31B
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530841; cv=none; b=uDMe4icU85FF9TdY6DtL4U6smnH6Xs93QaWA75yPP+/b4omcKOadHL+CajFzyxsC6WMzPqkMsBZevoGBcPNa4g1qc2g4/nApdPqqjs+msnAhAqX8AIxQlcbEyOPIYVbqmwPUJ4wtCeeLJi3/o2RJEynRr9apS1h7TgSj68m7P7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530841; c=relaxed/simple;
	bh=sPDQqg0yp68uVstvJ6EHfX05QONZb2LxnFnFGnFO9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRZK0JEhMdxCyQvhsRceE7lKvEJlniUX84nNZaWEwrypV2rjA0cvcaGLzs7eR+vAg7szGgLrOphD1DTKNhPvc3vDEZP/FKy3gJQGjgvIQMwJy4Y+XOpNXucNTNHpuz51zGmhSSccWOs9CK3zkjIQd7jnesg6Jry9cqRXhCM6EeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmjQdxdv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jKYf5twL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUh2TOPA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbi4k777; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBD7D21BE1;
	Thu, 29 May 2025 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdB+/2ZrtGZWew7m+UsS9vT3B4+cdGcg2/ejLDxbWZk=;
	b=GmjQdxdvstOYCXz5wgb6j5EYMQcePGPmY5aHmGxPDq3MkvnVNZiM6EiX8ddG27pPjZfHIq
	ZBFJM4Gu805RIpgvlaz5c3RPjPDiFvuPI2zzdD7JrLy0Ujd5AvilXJuWtbSq3W4+mc1qZj
	MuuGAojZAtg8/3QHrvEHD7LCBT1M6U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdB+/2ZrtGZWew7m+UsS9vT3B4+cdGcg2/ejLDxbWZk=;
	b=jKYf5twLeFQTr2pv51BKfITpk+xSKQuj7v0s7ni9ANwsxfGh9sfN8b3VtPfD0YAwr0boGb
	3qQwpBYNXDngX1BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RUh2TOPA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sbi4k777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdB+/2ZrtGZWew7m+UsS9vT3B4+cdGcg2/ejLDxbWZk=;
	b=RUh2TOPAKQ1s/sTviDQFupIEOYzOAr7ibxiZUlgd92jYvtw6EE0E9EENC5WlFnbcN4nzou
	6C1AcgCifNHRwc08c0va9JYOrnOBajk/2g4aLOq4kaA3MO26KJbJ8ie020tBktfVg9etns
	scGLiZENW4cP3wjOutM0vOMNew41FT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdB+/2ZrtGZWew7m+UsS9vT3B4+cdGcg2/ejLDxbWZk=;
	b=sbi4k7776AFIijsKZXFh82qO7tUCTFK8UO+K4qCTqi1cEBlS86FVWor+q8O8baSWDMtUZ5
	VhOB4UwPwG5SR+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04DD136E0;
	Thu, 29 May 2025 15:00:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zy94JpR2OGh9TgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 May 2025 15:00:36 +0000
Date: Thu, 29 May 2025 17:00:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, dsterba@suse.cz
Subject: Re: [PATCH v2] btrfs: track current commit duration in commit_stats
Message-ID: <20250529150034.GO4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9ef37010df953138ae847e6d5e8ba12847321036.1746751867.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef37010df953138ae847e6d5e8ba12847321036.1746751867.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BBD7D21BE1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Thu, May 08, 2025 at 05:54:41PM -0700, Boris Burkov wrote:
> When debugging/detecting outlier commit stalls, having an indicator that
> we are currently in a long commit critical section can be very useful.
> Extend the commit_stats sysfs file to also include the current commit
> critical section duration.
> 
> Since this requires storing the last commit start time, use that rather
> than a separate stack variable for storing the finished commit durations
> as well.
> 
> This also requires slightly moving up the timing of the stats updating
> to *inside* the critical section to avoid the transaction T+1 setting
> the critical_section_start_time to 0 before transaction T can update its
> stats, which would trigger the new ASSERT. This is an improvement in and
> of itself, as it makes the stats more accurately represent the true
> critical section time. It may be yet better to pull the stats up to where
> start_transaction gets unblocked, rather than the next commit, but this
> seems like a good enough place as well.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> * Fix ASSERT triggered by multiple commits interleaving s.t. commit T+1
>   reset the start time set by commit T before T could update the stats.
> * Rename commit_stats variable to critical_section_start_time to
>   differentiate from cur_trans->start_time.

Added to for-next, thanks.

