Return-Path: <linux-btrfs+bounces-8086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E197B301
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB351C2169D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31817C991;
	Tue, 17 Sep 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5a4OR1T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RzEjJ8KT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZAVm1uCd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F2mv/qi6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8316A956
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590654; cv=none; b=gIxFdjufIyOpZ3Cm2C7GaPBVgfKrMdpWIPIj0zRKXvFJjDzqzCdJw1dGKxEVahxRJLNM+Ou6HJ0vQUBKEiNV9qpW8okDDU6GFp9qbm0PUoZZqZnJeek5X62Bk9e0jzpL2O8OEhK5WXUQhaLRJ86S77rE48hlyVXwFjShR0xGJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590654; c=relaxed/simple;
	bh=/oaUVvKsuNTQFuGTJLSnyxta1Prg6w4ASih2rqvncko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/K63xVPJwYArKCD6NJ1b4+IEr2Br/yqOXdPx7jOAqoUnVcBunyEv1//+danQM1iaAa3g0Rs1jQNgjxeVoIfAyv3fc7seGl0hi91XkYz7IEiKsodt/ltmbMMX7KcELhVTkP8e+FcErA5pCl4L7z15C/d4IJC8ICoM4L6xHfO7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5a4OR1T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RzEjJ8KT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZAVm1uCd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F2mv/qi6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED0EC2233E;
	Tue, 17 Sep 2024 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726590651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/oaUVvKsuNTQFuGTJLSnyxta1Prg6w4ASih2rqvncko=;
	b=F5a4OR1Tl/jbToTkRM0ZoaBHmAEO8feaxJ3t1CBx0S8d2IRim14elzRvyS/s+MKtXasQXy
	3k6K3qDD7syYwCEoUTBs/caInlvT9IiuplMLzmkIpJcWIZB5ZFX8qthPMSMWxYiSwrSffP
	fiPfyBGUPdaFkdJ95V567GmsOg2Es3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726590651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/oaUVvKsuNTQFuGTJLSnyxta1Prg6w4ASih2rqvncko=;
	b=RzEjJ8KTEKEbO+06+dvJLuG7GjxraK7kD3Y9MzkoIQsyw5gx1IeF0CNNmIYCGRtsLgWrUz
	LNtf/yQ6/8HEq6DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726590650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/oaUVvKsuNTQFuGTJLSnyxta1Prg6w4ASih2rqvncko=;
	b=ZAVm1uCd8rqC0ANTq0O1i5lQaZhVrTfUsBEXK98x3qBuIxMQl//z5Jt9I/qk0qfbO8rzz5
	e1Gp6RUnB7iNbmPu8uJZZDVUu/JXEJYQtz3kSuYSkz43c8niRs32gpWypuMKpdwVQtUPBr
	qa2sT0mC6ozQjPeH0MvFn0WK8m2mSAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726590650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/oaUVvKsuNTQFuGTJLSnyxta1Prg6w4ASih2rqvncko=;
	b=F2mv/qi63vZOZNFNnvhTmNQccAMkUT93K9f8TOXuPiEpqg8uu/BUC5p1tHFwRMrAQQGuo7
	L+t2ts5Vwfu3t+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D29AE13AB6;
	Tue, 17 Sep 2024 16:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DsA3M7qu6WaLZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 16:30:50 +0000
Date: Tue, 17 Sep 2024 18:30:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set flag to message when ratelimited
Message-ID: <20240917163045.GE2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Sep 13, 2024 at 02:26:06PM -0700, Leo Martins wrote:
> Set RATELIMIT_MSG_ON_RELEASE flag to send a message when being
> ratelimited.

What does this really do? The documentation does not help either:

/* issue num suppressed message on exit */

> During some recent debugging not realizing that
> logs were being ratelimited caused some confusion so making
> sure there is a warning seems prudent.

So you can enable it only for debugging level.

