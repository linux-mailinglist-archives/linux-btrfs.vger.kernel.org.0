Return-Path: <linux-btrfs+bounces-7816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EA596C4F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4AA287A91
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8091E0B71;
	Wed,  4 Sep 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XIirmUu+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/lWEuhwW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JyQsbrZJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9B2QmPwv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2B1773D
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469872; cv=none; b=iYKtvT4hVnoeBabK9QB1SWrnK07lduPStmF1qHAJgLfBp4uA/19N1g0mmtwr4FZf78nAFNOpHfN+uYAb/eUVZAKwkaPYwOQD4qHzQtUwjP6SgTm3+6M4Wf8Ux97+jtCw0QGvBwhDNoHMSaFyEphggicB4+oSpq1fZKPSICQun7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469872; c=relaxed/simple;
	bh=0OXAKUb+8hoGinl+DOW1mV1zKrb1lxB4fP8ELyscCQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RouElJPjkZilTg/xCgSssk6D+KRgX+8yq857f9CKHDngBVJcghlB0jdb6kJ+UVTZTKyNByztwDB247XbtVwI/iQFiKC5fwO69/zD+22DjsA5chtBvkNgEjoiEn3t0q9H95S/g8Yd1TYAqoutnTWKBV2rHQto8z789LLS34W5I1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XIirmUu+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/lWEuhwW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JyQsbrZJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9B2QmPwv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56F99219A7;
	Wed,  4 Sep 2024 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725469867;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rR0mYXoikGM0N3gXzQ8YS+cCUtVvnED7qKz059bgExo=;
	b=XIirmUu+aHyoFMIBIP1Q+KT6vcnL5j+sL897TkurSTkwQhtZTwNcHb4a4T7Gc4APRLdkRt
	+7SdyELMUQz/z1kJwyj+oueDI557NMGShnDvAqyRTk3nSeL51nnVdEPRzryEJGeWQNaUzn
	CcjowO9YVOs7+G4rA98d9gHCtNhFYRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725469867;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rR0mYXoikGM0N3gXzQ8YS+cCUtVvnED7qKz059bgExo=;
	b=/lWEuhwWnr43pY/bSIddYAjlAv56S+tg7MaKDLvsJSM/YYiZveZxISfIvLiTCbZMvmpTOH
	ElAzr2u0Q9vS5JDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725469866;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rR0mYXoikGM0N3gXzQ8YS+cCUtVvnED7qKz059bgExo=;
	b=JyQsbrZJzJr0YNU2+B+hWsjVnehm05+8TiXYIeABFMjKogf9EbXphWyqPUOjnWAY72F/IP
	DOKzESU8LCK9+uU/ImixphlzJQeNpkvcOBExJdPd1/uYnASObABpySlx0iHjjkc9KPgeTf
	129pziM4MHrxIRmHeYOfRClF9/7kyGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725469866;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rR0mYXoikGM0N3gXzQ8YS+cCUtVvnED7qKz059bgExo=;
	b=9B2QmPwv3fxQXa2YwFRtidSBbe8WVEGPteiHNBl1G7KGwS50TWgy14b++fc8ZnniFR4AuW
	+2QZ6tocFHM8ZTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45BFE139E2;
	Wed,  4 Sep 2024 17:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y+POEKqU2GYZKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Sep 2024 17:11:06 +0000
Date: Wed, 4 Sep 2024 19:10:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: only unlock the to-be-submitted ranges inside a
 folio
Message-ID: <20240904171057.GO26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <73395cf297579616ecc84611eb06a2cc190e8ee8.1725253141.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73395cf297579616ecc84611eb06a2cc190e8ee8.1725253141.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 02, 2024 at 02:29:06PM +0930, Qu Wenruo wrote:
> [SUBPAGE COMPRESSION LIMITS]
> Currently inside writepage_delalloc(), if a delalloc range is going to
> be submitted asynchronously (inline or compression, the page
> dirty/writeback/unlock are all handled in a different timing, not at the
> submission time), then we return 1 and extent_writepage() will skip the
> submission.
> 
> This is fine if every sector matches page size, but if a sector is
> smaller than page size (aka, subpage case), then it can be very
> problematic, for example for the following 64K page:
> 
>      0     16K     32K    48K     64K
>      |/|   |///////|      |/|
>        |                    |
>        4K                   52K
> 
> Where |/| is the dirty range we need to submit.
> 
> In above case, we need the following different handling for the 3
> ranges:
> 
> - [0, 4K) needs to be submitted for regular write
>   A single sector can not be compressed.
> 
> - [16K, 32K) needs to be submitted for compressed write
> 
> - [48K, 52K) needs to be submitted for regular write.
> 
> In above case, if we try to submit [16K, 32K) for compressed write, we
> will return 1 and immediately, and without submitting the remaining
> [48K, 52K) range.
> 
> Furthermore, since extent_writepage() will exit without unlocking any
> sectors, the submitted range [0, 4K) will not have sector unlocked.
> 
> That's the reason why for now subpage is only allowed for full page
> range.
> 
> [ENHANCEMENT]
> - Introduce a submission bitmap at btrfs_bio_ctrl::submit_bitmap
>   This records which sectors will be submitted by extent_writepage_io().
>   This allows us to track which sectors needs to be submitted thus later
>   to be properly unlocked.
> 
>   For asynchronously submitted range (inline/compression), the
>   corresponding bits will be cleared from that bitmap.
> 
> - Only return 1 if no sector needs to be submitted in
>   writepage_delalloc()
> 
> - Only submit sectors marked by submission bitmap inside
>   extent_writepage_io()
>   So we won't touch the asynchronously submitted part.
> 
> - Introduce btrfs_folio_end_writer_lock_bitmap() helper
>   This will only unlock the involved sectors specified by @bitmap
>   parameter, to avoid touching the range asynchronously submitted.
> 
> Please note that, since subpage compression is still limited to page
> aligned range, this change is only a preparation for future sector
> perfect compression support for subpage.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please add this to for-next, overall it looks good to me.

