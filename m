Return-Path: <linux-btrfs+bounces-8393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFF98C1E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3EEB22AE4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9B1CB30A;
	Tue,  1 Oct 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SrHYeqlg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w54RzSh4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SrHYeqlg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w54RzSh4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F71C9EA7;
	Tue,  1 Oct 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797373; cv=none; b=Mb1Zt3TDhlVprNYxB4Ilu/nWTp49ypemaPLrIdTWdpxgtnbRM8L87invXgZr+ieQWXxMBMiFzxUIE2FMKCCoP3/3Q1LoF02y/Cel7vn4Et3/ts8m4asxIdSwQIVGHND2WwvZphgThGuta/R0Y6xg3XjmdPrKIv6GsoqGzu3zIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797373; c=relaxed/simple;
	bh=m9Z6bfOmopOQeDltEIfaT1/ui3ZQxiiLQsLJnOe6P30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCxRy4HmNTAypScAF/ItfAqDVC8ObnEN/5yhzvO0Y87mWb0mV+64HR6vtjKu2RKpVUjwD5ZLNEHlAYx7sAZMc8EENRP1hjSCB5HI+G9Vm1bNHHHLONGflIUOcNM+eXqFctWjRYcus4+wcJJObNbQdIa4MmEOAJvGWRvLbDjwIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SrHYeqlg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w54RzSh4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SrHYeqlg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w54RzSh4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 549FC1FCD5;
	Tue,  1 Oct 2024 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727797370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc2bb/ki4XgIG8vXJwQ+J+JjXui1J0/arOIOLFXO5LU=;
	b=SrHYeqlg7VNKlXyNJ5dZCPO0LvBDwB8y3/eihgHb0i5l14P6fLYPdKX1gYPBaz3gc8UQMB
	5fekZijGX6rtommnOaWBkMqnKwRV+6ECIqw/wyvr6ujI3nV9M1Zxnrezu/ieiYC7YCj/wk
	ol5qVLgEX6EXZj68ll0aNUXXCK8QAeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727797370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc2bb/ki4XgIG8vXJwQ+J+JjXui1J0/arOIOLFXO5LU=;
	b=w54RzSh45+0g62/kIoG1XwUwQVl9Fc6M96CFkGx1G1NbZMIIsSZNoDSWGG5JJ9f67nAAvC
	rkuwsRslLHbgOzDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SrHYeqlg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w54RzSh4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727797370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc2bb/ki4XgIG8vXJwQ+J+JjXui1J0/arOIOLFXO5LU=;
	b=SrHYeqlg7VNKlXyNJ5dZCPO0LvBDwB8y3/eihgHb0i5l14P6fLYPdKX1gYPBaz3gc8UQMB
	5fekZijGX6rtommnOaWBkMqnKwRV+6ECIqw/wyvr6ujI3nV9M1Zxnrezu/ieiYC7YCj/wk
	ol5qVLgEX6EXZj68ll0aNUXXCK8QAeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727797370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc2bb/ki4XgIG8vXJwQ+J+JjXui1J0/arOIOLFXO5LU=;
	b=w54RzSh45+0g62/kIoG1XwUwQVl9Fc6M96CFkGx1G1NbZMIIsSZNoDSWGG5JJ9f67nAAvC
	rkuwsRslLHbgOzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3562413A73;
	Tue,  1 Oct 2024 15:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HfFHDHoY/GYjOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 15:42:50 +0000
Date: Tue, 1 Oct 2024 17:42:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant stop_loop variable in
 scrub_stripe()
Message-ID: <20241001154244.GF28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240926075034.39475-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926075034.39475-1-riyandhiman14@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 549FC1FCD5
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Sep 26, 2024 at 01:20:34PM +0530, Riyan Dhiman wrote:
> The variable stop_loop was originally introduced in commit
> 625f1c8dc66d7 (Btrfs: improve the loop of scrub_stripe). It was initialized
> to 0 in commit 3b080b2564287 (Btrfs: scrub raid56 stripes in the right way).
> However, in a later commit 18d30ab961497 (btrfs: scrub: use scrub_simple_mirror()
> to handle RAID56 data stripe scrub), the code that modified stop_loop was removed,
> making the variable redundant.
> 
> Currently, stop_loop is only initialized with 0 and is never used or modified
> within the scrub_stripe() function. As a result, this patch removes the
> stop_loop variable to clean up the code and eliminate unnecessary redundancy.
> 
> This change has no impact on functionality, as stop_loop was never utilized
> in any meaningful way in the final version of the code.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Added to for-next, thanks. Adding the references when the code was added
or last used is great, I slightly updated the references as it's common
to use the same formatting like the Fixes: tag which puts the subject to
("...").

