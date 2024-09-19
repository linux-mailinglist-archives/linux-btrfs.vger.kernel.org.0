Return-Path: <linux-btrfs+bounces-8124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0DE97C9BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84414B21049
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEFC19DFB3;
	Thu, 19 Sep 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvXR8g4f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuR5R5mo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvXR8g4f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuR5R5mo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A819DF86
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751240; cv=none; b=RFJylgVQcujv4Pmta6mxFG5fe34zqd6H3yB8DReE3H5JoIOeT0wEhODkvj7hSTlKeq12uK0bvKiHpePn2jFIshXrBN+yREe44dhcdjtNjLFALCq9ulbVR0FkxgJ7OhijNoPi0oRF3ZlT/baPVJ1clkSgmuIWLsrnb+vOEJfrmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751240; c=relaxed/simple;
	bh=h+XiQDYId5LC3M6UkK7EUAlA3C0m/3Npuabaf7IYesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJMUEOiFPPD0zgcBIPqK2jx2fDPUdXABRjoyuw15AD1Q8hFtvV+Wl4Nss9YaZZLmASkkTSeMI6zCLQSwH7wUy9jErY2JbTQJTHrNnVc1MC55m9v12kekSloejA5ZM32VriuWg7NcJ6xbWeWxJ3z+9W+1lzNdKsgLyL9Pz6jTPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvXR8g4f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuR5R5mo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvXR8g4f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuR5R5mo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5993D2092C;
	Thu, 19 Sep 2024 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726751236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3ueYjHr08K1b9bqaXP5Nb1RAXkcHJXwBonqCq1zaJk=;
	b=gvXR8g4fNYX5p5FqwUL+NqZgV7N7PJaxkLA1wORuTlyspstM+ENw5QB8L+YTl8eKSQLjQm
	wRVrZqspQej2Aj9YRk9H/QX2NikG7oJBH0JwK2smY5vTCduc2hTy/NdeDzd05etepw1Zwg
	mOwGVwPCyBB6mVjM1rFHW13o3izTNEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726751236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3ueYjHr08K1b9bqaXP5Nb1RAXkcHJXwBonqCq1zaJk=;
	b=wuR5R5mo47a9I7cXOJwK16L53Z4RVDsPIAIycSdBbPemYrvg6bKpvzdbUqgGl85d92R6vR
	Oi8jOl7c5ng+BcDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gvXR8g4f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wuR5R5mo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726751236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3ueYjHr08K1b9bqaXP5Nb1RAXkcHJXwBonqCq1zaJk=;
	b=gvXR8g4fNYX5p5FqwUL+NqZgV7N7PJaxkLA1wORuTlyspstM+ENw5QB8L+YTl8eKSQLjQm
	wRVrZqspQej2Aj9YRk9H/QX2NikG7oJBH0JwK2smY5vTCduc2hTy/NdeDzd05etepw1Zwg
	mOwGVwPCyBB6mVjM1rFHW13o3izTNEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726751236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3ueYjHr08K1b9bqaXP5Nb1RAXkcHJXwBonqCq1zaJk=;
	b=wuR5R5mo47a9I7cXOJwK16L53Z4RVDsPIAIycSdBbPemYrvg6bKpvzdbUqgGl85d92R6vR
	Oi8jOl7c5ng+BcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BE6713A1E;
	Thu, 19 Sep 2024 13:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OThqDgQi7GYKNwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Sep 2024 13:07:16 +0000
Date: Thu, 19 Sep 2024 15:07:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not assume the full page range is not dirty in
 extent_writepage_io()
Message-ID: <20240919130711.GA13599@suse.cz>
Reply-To: dsterba@suse.cz
References: <6239c8bb8ce319c2940d6469ffcb7f5f6641db79.1726011300.git.wqu@suse.com>
 <20240917165941.GH2920@twin.jikos.cz>
 <8cbc9893-5612-482e-ae4b-95545f9e100d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cbc9893-5612-482e-ae4b-95545f9e100d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5993D2092C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Sep 18, 2024 at 06:53:32AM +0930, Qu Wenruo wrote:
> >>   btrfs: allow compression even if the range is not page aligned
> >>   btrfs: do not assume the full page range is not dirty in extent_writepage_io()
> >>   btrfs: make extent_range_clear_diryt_for_io() to handle sector size < page size cases
> >>   btrfs: wait for writeback if sector size is smaller than page size
> >>   btrfs: compression: add an ASSERT() to ensure the read-in length is sane
> >>   btrfs: zstd: make the compression path to handle sector size < page size
> >>   btrfs: zlib: make the compression path to handle sector size < page size
> >
> > That's great news. I don't think there's anything else of comparable
> > size missing from the subpage support.
> 
> Well, one more submitted series, which slightly reworks the delalloc
> locking inside a page, to fix a possible double folio unlock which leads
> to some hang:
> 
> https://lore.kernel.org/linux-btrfs/cover.1726441226.git.wqu@suse.com/
> 
> Then we're able to enable the feature:
> 
> https://lore.kernel.org/linux-btrfs/05299dac9e4379aff3f24986b4ca3fafb04d5d6a.1726527472.git.wqu@suse.com/
> 
> > We're now in the middle of merge window but as the pull request has been
> > merged there's nothing blocking for-next so you can post the patches and
> > then add them.
> 
> Sure, but IIRC none of the small fixes gets reviewed, I'm still waiting
> for feedback.

I've read it, from high level POV it all seems OK. I haven't given it a
rev-by yet because I'm not sure there could be some corner case left,
with the page and bitmap state handling. But if you don't get any other
feedback please add the patches to for-next so we can get early testing.

> Appreciate any review on those fixes, especially for those compression
> path ones (the first 3), as they are really small fixes and will still
> be needed even if we later change how we submit compressed writes.

Well, yeah small changes with potentially big consequences. I have the
patches in my misc-next to check the default case.

