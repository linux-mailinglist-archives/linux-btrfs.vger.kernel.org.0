Return-Path: <linux-btrfs+bounces-8428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22B98D3F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 15:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C41283109
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40BA1D015C;
	Wed,  2 Oct 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dk3QAxSz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mXD3YswU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dk3QAxSz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mXD3YswU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402619750B
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874260; cv=none; b=JoKJVjWc70w022oMJTGqnGaS3Pp/9/tOeEoSOJ89L4cLA7cFoFydxeW5feEkym2ZB87Lhn7dvNND7tAd3jIdkRsMTZScrXCYOYouOBS6lQNi1Vgg+BuzRMLBG6iKRPN9KQ07aDm7WUZp8Lyuj7L945OTKl+LGYgn/ecKus4AMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874260; c=relaxed/simple;
	bh=Hq42VQFFs2bqaGe7Ag11eM986cGaLINCgWrGH3tfDzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvLt8oI91TmexjRWyQeiElHJqEA3b4/2Px656ZcSmWlnuShMoRwVfIpjDNVPCsaLTG3vZcoKDcp2fe5Us/UlOP5RW301M4Tb+wXW6dAe+YCC7fBpMHzNqVchyRdRIzDnByEib+kB+iU4g3JGSmhgXPnCJCwkY7vAFaYB6THYjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dk3QAxSz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mXD3YswU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dk3QAxSz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mXD3YswU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A2FF1FD59;
	Wed,  2 Oct 2024 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727874251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih1DIizr+pIBiCRoQKan4oDHxG+8HI5iKfJOwUD5sQo=;
	b=Dk3QAxSzV8r13sVp3ON1yATs1lnfWbcpc87fs15p7iZb3fmICV98rA71r10S17Z/6TRKWf
	skvGPv7AtDzf+cpDZqcXMTfQqmvvi9kkLvhi6J3uk+pLJsi04sVzPGp3wPkATHL1riN+Tz
	UDv0zxJVBWxqPeJ2/HboH9LRr0NOWLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727874251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih1DIizr+pIBiCRoQKan4oDHxG+8HI5iKfJOwUD5sQo=;
	b=mXD3YswUkum2BXyYQhyz6c8jHH9vcqNHJFUAUlhXbnWPaucrPy2F/nzUd9sAE3YQqGhGlF
	MCoVbTfnB5qBl0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727874251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih1DIizr+pIBiCRoQKan4oDHxG+8HI5iKfJOwUD5sQo=;
	b=Dk3QAxSzV8r13sVp3ON1yATs1lnfWbcpc87fs15p7iZb3fmICV98rA71r10S17Z/6TRKWf
	skvGPv7AtDzf+cpDZqcXMTfQqmvvi9kkLvhi6J3uk+pLJsi04sVzPGp3wPkATHL1riN+Tz
	UDv0zxJVBWxqPeJ2/HboH9LRr0NOWLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727874251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih1DIizr+pIBiCRoQKan4oDHxG+8HI5iKfJOwUD5sQo=;
	b=mXD3YswUkum2BXyYQhyz6c8jHH9vcqNHJFUAUlhXbnWPaucrPy2F/nzUd9sAE3YQqGhGlF
	MCoVbTfnB5qBl0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A7F413A6E;
	Wed,  2 Oct 2024 13:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Bw6BstE/WbvFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 02 Oct 2024 13:04:11 +0000
Date: Wed, 2 Oct 2024 15:04:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: simplify the page uptodate preparation for
 prepare_pages()
Message-ID: <20241002130405.GJ28777@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1727736323.git.wqu@suse.com>
 <51064f30d856c1529d47d70dfb4f3cad46a42187.1727736323.git.wqu@suse.com>
 <20241001153045.GE28777@twin.jikos.cz>
 <f6721e0c-efce-48e2-9bea-4d023d633ed0@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6721e0c-efce-48e2-9bea-4d023d633ed0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 02, 2024 at 06:41:58AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/10/2 01:00, David Sterba 写道:
> > On Tue, Oct 01, 2024 at 08:17:11AM +0930, Qu Wenruo wrote:
> >> +	if (force_uptodate)
> >> +		goto read;
> >> +
> >> +	/* The dirty range fully cover the page, no need to read it out. */
> >> +	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> >> +	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> >> +		return 0;
> >> +read:
> >
> > I've commented under v1 and will repeat it here so it does not get lost,
> > this if and goto is not necessary here and can be a normal if () { ...  }
> >
> 
> This is not that simple.
> 
> If @force_uptodate we need to read the folio no matter what, meanwhile
> if the range is not aligned, we also need to read the folio.
> 
> And the @force_uptodate check should go before the alignment check, thus
> I'm wondering if there is any better alternative.

if (!force_update) {
	/* The dirty range fully cover the page, no need to read it out. */
	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
	    IS_ALIGNED(clamp_end, PAGE_SIZE))
		return 0;
}



