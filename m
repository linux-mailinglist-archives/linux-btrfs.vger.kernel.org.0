Return-Path: <linux-btrfs+bounces-20159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF89CF861D
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8587303B19C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40515326D79;
	Tue,  6 Jan 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8eBscYZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9g6f+twr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F7J1YV4p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RyICP5DT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996E5695
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703134; cv=none; b=DaVj0HS3b+Ne9lcBaCt9oaos7qVkua6k7zO2ly8x+j8qrBlY7ffcfSEYZbYTs3ThiqliDb2Jmwhx78lG7+DeZlwrN994q08XtZD9udrblLIWK3aRvoqacmt94ue+ppAoTNoZM1tNpHb1c0bn81b1OgHr82Q4CdUwPLyRzUesddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703134; c=relaxed/simple;
	bh=yqE+BOm3v/cJODveeoWWAitbSJ2NxV/v3z6TiWbZjo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TufHayQdZaXhfOUAGooIVAiyvt7vmrT1TPFmoNglUOmQ7SRAcO+XggLNfCA8eCBmJhcSHSE0aM95bIrgTly/rEpGTJ8Ws0CPcodKMo9og5cO42qpQtPXyhTDu6LNScLU1xHIvxZY3TGrvwaLvWR9jeuTEo6BvCGzSbu6FnzRJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8eBscYZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9g6f+twr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F7J1YV4p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RyICP5DT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC2B8339E8;
	Tue,  6 Jan 2026 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767703131;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PEDbYwcpGPKi84Xg8AUVJ6p6hbYEZeK3ylKAPDqGnUA=;
	b=G8eBscYZ6brwy9hZnwlu3dWCLiBSXQjJdVXw60WX0/qRhAXz8Ppqt7dr2WIdnX9EmirUBT
	5KrAmJL+3UkZ5B4BXpD6d7dyLevHrTSwtWrxeutVfwYehGRrBV91N4RSJIJmbK8xp3Uksl
	kMAXBsfFHP7QqtyTVm4UBrZdDDIPhW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767703131;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PEDbYwcpGPKi84Xg8AUVJ6p6hbYEZeK3ylKAPDqGnUA=;
	b=9g6f+twrBCa+lwSpeNIQTpMdHoecDMDHZxv4s65T1zfpvulLoGKCZrN4mDLo7tRL52Kxmt
	aGiJmm1cYY+7dWDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F7J1YV4p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RyICP5DT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767703130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PEDbYwcpGPKi84Xg8AUVJ6p6hbYEZeK3ylKAPDqGnUA=;
	b=F7J1YV4ptELs0hbIamZ2UVO73w79a2dZIo020B9Sk2bnR6gMaoxZvYI8KIfePeFxQG8+PO
	k31G7xnYXXmDqW0mj6ZTT06NIYyPpFctf2TMTeqaBnQMwxCmOkYQ1a4CYXn/eprnAyp5i5
	Qh3C+XTQ9QXGPeFoUCfer+YGRl5Gel8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767703130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PEDbYwcpGPKi84Xg8AUVJ6p6hbYEZeK3ylKAPDqGnUA=;
	b=RyICP5DTpZCWLA50DtVez2hsq2ZW2blwFxIj18hsx1MjBRp3zw47YSRZVlYtbU4e1A4QCl
	udjXxT1II22O2hCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFFDF3EA65;
	Tue,  6 Jan 2026 12:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OgjOKloCXWnoEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Jan 2026 12:38:50 +0000
Date: Tue, 6 Jan 2026 13:38:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: clm@fb.com, dsterba@suse.com, sunk67188@gmail.com,
	dan.carpenter@linaro.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v2] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
Message-ID: <20260106123845.GD21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251226113022.1883689-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226113022.1883689-1-zilin@seu.edu.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: CC2B8339E8
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,suse.com,gmail.com,linaro.org,vger.kernel.org,seu.edu.cn];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Fri, Dec 26, 2025 at 11:30:22AM +0000, Zilin Guan wrote:
> If btrfs_insert_fs_root() fails, the tmp_root allocated by
> btrfs_alloc_dummy_root() is leaked because its initial reference count
> is not decremented.
> 
> Fix this by calling btrfs_put_root() unconditionally after
> btrfs_insert_fs_root(). This ensures the local reference is always
> dropped.
> 
> Also fix a copy-paste error in the error message where the subvolume
> root insertion failure was incorrectly logged as "fs root".
> 
> Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
> Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
> Changes in v2:
> - Reword commit message to be more concise.
> - Fix copy-paste error in the error message.
> - Add Co-developed-by and Signed-off-by tag.

Added to for-next, thanks.

