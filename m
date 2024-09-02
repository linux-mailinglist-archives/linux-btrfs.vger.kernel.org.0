Return-Path: <linux-btrfs+bounces-7754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D496907E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 01:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90CA1F22D56
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F93188592;
	Mon,  2 Sep 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybCCz7Ct";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SKJdZyeK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybCCz7Ct";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SKJdZyeK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EC13CFB7;
	Mon,  2 Sep 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725320482; cv=none; b=ozcAECQN2AVdlSH97L+Dot0osxd+iNECJdDRMPfrOBVFy8XkYWQB1UZRNDnn7JapQXwNdBela/09OrqLHAtGsCFdrrhcgNFb5CqCt1U+dkhJYc2zZI9dexx8s4ntN152PsEYINqdLd9gdgC0J77hVUOdXb1ad1rJD650fSijszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725320482; c=relaxed/simple;
	bh=3uoFZbAJTCfBfq1Ms59IG9WOj4qBaDng3/DkkHYFVfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DekJWF4sdPsH3VJ+eytO55MyjwCCornKtkNv8qwCEjjBYwDKHL7cGKBvHa7RfvtyMpBMGoIYBxsWzYEb9c+67F/a4YzxjO9lLg6naMp4J0mEVr5QqOe4JfpG0vjeeHuT0PLz+GH9KX7bve5VCNzRWiTbZZmVneexGPcNi3GUtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybCCz7Ct; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SKJdZyeK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybCCz7Ct; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SKJdZyeK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CCCB21B62;
	Mon,  2 Sep 2024 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725320478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtcEr/ZYAAw8oGtsiw6gfQw3k8Ez8e/JP4IYOSwvvo=;
	b=ybCCz7CtTxwozjTq73zhI9CT+3kCbvbvaW0VxsaH4f6iDOxZs/hTND5vxawgCuqmJOoLLW
	U/QTFNAu7BUooUaYkFpU5aIe++Ia8OwLHEkh5Ql3jT93OB+0GRj8O1eOlkV0GQaUlrEscq
	o8u5yN1kEeL9T0uyeOx6xVPCqb/LNKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725320478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtcEr/ZYAAw8oGtsiw6gfQw3k8Ez8e/JP4IYOSwvvo=;
	b=SKJdZyeKkVxC/cycoCuFbAWoWYW/m6UMEIl2Sshi5zS5FqrVhQM1vS9FgWVFjoVBiFXkdN
	JUj93/tmVo88hCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725320478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtcEr/ZYAAw8oGtsiw6gfQw3k8Ez8e/JP4IYOSwvvo=;
	b=ybCCz7CtTxwozjTq73zhI9CT+3kCbvbvaW0VxsaH4f6iDOxZs/hTND5vxawgCuqmJOoLLW
	U/QTFNAu7BUooUaYkFpU5aIe++Ia8OwLHEkh5Ql3jT93OB+0GRj8O1eOlkV0GQaUlrEscq
	o8u5yN1kEeL9T0uyeOx6xVPCqb/LNKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725320478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtcEr/ZYAAw8oGtsiw6gfQw3k8Ez8e/JP4IYOSwvvo=;
	b=SKJdZyeKkVxC/cycoCuFbAWoWYW/m6UMEIl2Sshi5zS5FqrVhQM1vS9FgWVFjoVBiFXkdN
	JUj93/tmVo88hCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E6B01398F;
	Mon,  2 Sep 2024 23:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IcqtGh5N1mbMSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 23:41:18 +0000
Date: Tue, 3 Sep 2024 01:41:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: Split remaining space to discard in chunks
Message-ID: <20240902234117.GG26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
 <20240902205828.943155-3-luca.stefani.ge1@gmail.com>
 <c5aa26ad-4ae7-4498-8a27-118876181890@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5aa26ad-4ae7-4498-8a27-118876181890@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Sep 03, 2024 at 08:01:16AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/9/3 06:26, Luca Stefani 写道:
> > Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> > mostly empty although we will do the split according to our super block
> > locations, the last super block ends at 256G, we can submit a huge
> > discard for the range [256G, 8T), causing a super large delay.
> > 
> > We now split the space left to discard based the block discard limit
> > in preparation of introduction of cancellation signals handling.
> > 
> > Reported-by: Qu Wenruo <wqu@suse.com>
> 
> Well, I'd say who ever reported the original fstrim and suspension 
> failure should be the reporter, not me.

Once the patch is finalized I'll add the links to reports but yeah if
they're added when the patches are submitted it's helpful.

