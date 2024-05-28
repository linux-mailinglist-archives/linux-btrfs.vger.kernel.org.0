Return-Path: <linux-btrfs+bounces-5330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A48D273B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31C01F24110
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBED17BB28;
	Tue, 28 May 2024 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nq4tbi56";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2ePToDJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nq4tbi56";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2ePToDJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8CB17B4E7;
	Tue, 28 May 2024 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932638; cv=none; b=gOLkEGXBr8TKxnV5wJSzolx+TXzQ5DE9NZtH28UANrQlL4CXCH751OA+qHXC64pchJRIVQnAKqiSI6aUwyrZgaSdHsXjm/4cR8qo9dSUSApQSJLlW9gbvijIHzr1zz+tZv/71g9/iv1YTUyVgS2mRw5DzgDLd6BhTwscL1MZDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932638; c=relaxed/simple;
	bh=R6Yzs7L4oyKa9meTnHX4l3PyqQu9KzbLpse+zeuRP8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbwd49D9vigmNmQ7suBv/kbnL+yDvotFzTj7dVnF2drsEDeZSYWaEQKjZbRJPmQkXabcR66xwpemU/hKbra0chdxAmBdtmrasbcebDoV0YlDdVtydi3g0uuUYbzrs5poTqncr8zKkk0WpEYFDOehfBJEB7KE3xiapGukBNovr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nq4tbi56; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O2ePToDJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nq4tbi56; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O2ePToDJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7728D2045C;
	Tue, 28 May 2024 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716932635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNZb8UKP/WJudXQUtQo0Z8V8xW8TByRXNAWMKln7HGA=;
	b=Nq4tbi56itVAA2H2QoPaio7fDQJQrcDFqIQ+luMw1YztNT6sucRwgs+KH6yiPefBvDUjoQ
	OVg2QeC5utWd6Tx4ErU5d5cQy0HD7VooWy6MId62yRmdfGkm+zQAtuxqspGvwPG5ZmKTdZ
	himtz3rOAjPeUvRa/DzSsdLyGlhXcw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716932635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNZb8UKP/WJudXQUtQo0Z8V8xW8TByRXNAWMKln7HGA=;
	b=O2ePToDJwNX58uc+PiGwuyuUmSyZKTchovdbophH6zcB71UC1Y/Ygv6riCcpe1gMGDEwVo
	8iGDg00ue5t4G2Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nq4tbi56;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O2ePToDJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716932635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNZb8UKP/WJudXQUtQo0Z8V8xW8TByRXNAWMKln7HGA=;
	b=Nq4tbi56itVAA2H2QoPaio7fDQJQrcDFqIQ+luMw1YztNT6sucRwgs+KH6yiPefBvDUjoQ
	OVg2QeC5utWd6Tx4ErU5d5cQy0HD7VooWy6MId62yRmdfGkm+zQAtuxqspGvwPG5ZmKTdZ
	himtz3rOAjPeUvRa/DzSsdLyGlhXcw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716932635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNZb8UKP/WJudXQUtQo0Z8V8xW8TByRXNAWMKln7HGA=;
	b=O2ePToDJwNX58uc+PiGwuyuUmSyZKTchovdbophH6zcB71UC1Y/Ygv6riCcpe1gMGDEwVo
	8iGDg00ue5t4G2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BEEA13A5D;
	Tue, 28 May 2024 21:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id En1IFhtQVmbwHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 May 2024 21:43:55 +0000
Date: Tue, 28 May 2024 23:43:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] btrfs: zlib: do not do unnecessary page copying for
 compression
Message-ID: <20240528214350.GI8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
 <08aca5cf-f259-4963-bb2a-356847317d94@linux.ibm.com>
 <a24ef846-95f9-413d-abfa-54b06281047a@gmx.com>
 <2db8bc9a-5ff0-40ec-92ba-29c90b6976c7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db8bc9a-5ff0-40ec-92ba-29c90b6976c7@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,vger.kernel.org,linux.ibm.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7728D2045C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.20

On Tue, May 28, 2024 at 12:44:19PM +0200, Zaslonko Mikhail wrote:
> > But I'm still wondering if we do not go 4 pages as buffer, how much
> > performance penalty would there be?
> > 
> > One of the objective is to prepare for the incoming sector perfect
> > subpage compression support, thus I'm re-checking the existing
> > compression code, preparing to change them to be subpage compatible.
> > 
> > If we can simplify the behavior without too large performance penalty,
> > can we consider just using one single page as buffer?
> 
> Based on my earlier estimates, bigger buffer provided up to 60% performance for inflate and up to 30% for
> deflate on s390 with dfltcc support.
> I don't think giving it away for simplification would be a good idea.

60% and 30% sound like significant gain, I agree this takes precedence
over code simplification. Eventually the s390 optimized case can be
moved to a separate function if the conditions are satisfied so it's not
mixed with the page-by-page code.

