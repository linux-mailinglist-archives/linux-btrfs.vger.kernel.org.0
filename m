Return-Path: <linux-btrfs+bounces-8398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470898C419
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484661C22159
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D001A3A80;
	Tue,  1 Oct 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHZGKrRQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1I1/Uxu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHZGKrRQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1I1/Uxu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB81CB308
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802086; cv=none; b=JwIZo+INdnZA3YFYZH5ICd+VgINXoDlLGFwkijsZiUmc9ME0tW/bXdln2Bt/ATR+asQikzr4f3xn/h8mnP5FLVYHYyeApMlqOyx5H1Dy6zF+l9FKuVgRpLL97knVE2iL0XfQAwQyuPF9zAgIuREzg6H2AW+cBT8ELmjGCpc0OTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802086; c=relaxed/simple;
	bh=rrA4UjptsJcAWoSYjG70m+vKsgk1C6wOBxH4Ll/GAM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTCR3Yt4PtGePbnBqfjD0IAbo9vS2JiMtKsNu5glwclQg3oTe7pybKx6iA6uG3TMOlbki+Iigda4b5Vw1LDvlKgwbbRAgpcl0WZe6KDxG3Qq8PIYnlR1RmxQxCPq3syPn1ruw7HlTILYw5NiH4lPvf8135L1WEVEuD3KSL5nOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHZGKrRQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1I1/Uxu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHZGKrRQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1I1/Uxu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B24E21B52;
	Tue,  1 Oct 2024 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727802083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bk/z0gJfyhIN6Bj6exag7Ry8MNtY5qbWTNEMhBUISSY=;
	b=fHZGKrRQYtwPbxgBztkZJofcWlpW9iCoOSKGcV9Df34n+a4orEFcHJDvfRRmkRAYZG4nOn
	lh6ZEOpX43ZuMLi2DmtkjKNh7MkZtHWVEP7IBbKSD0yMIcRxcWLw4pt1SP06IULkJ5U4Ap
	OatQMM/8w8LyZ8zGU2z3IQRXnIKDf/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727802083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bk/z0gJfyhIN6Bj6exag7Ry8MNtY5qbWTNEMhBUISSY=;
	b=v1I1/UxuJD24pUw1yFt6fmnadg4cK7i4FXwqjpW868ZIDr2OyxR/S3qPldzrxfL2JDykAc
	Vz1nNByGK28mwcDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727802083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bk/z0gJfyhIN6Bj6exag7Ry8MNtY5qbWTNEMhBUISSY=;
	b=fHZGKrRQYtwPbxgBztkZJofcWlpW9iCoOSKGcV9Df34n+a4orEFcHJDvfRRmkRAYZG4nOn
	lh6ZEOpX43ZuMLi2DmtkjKNh7MkZtHWVEP7IBbKSD0yMIcRxcWLw4pt1SP06IULkJ5U4Ap
	OatQMM/8w8LyZ8zGU2z3IQRXnIKDf/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727802083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bk/z0gJfyhIN6Bj6exag7Ry8MNtY5qbWTNEMhBUISSY=;
	b=v1I1/UxuJD24pUw1yFt6fmnadg4cK7i4FXwqjpW868ZIDr2OyxR/S3qPldzrxfL2JDykAc
	Vz1nNByGK28mwcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D9113A6E;
	Tue,  1 Oct 2024 17:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZfJZBeMq/GYMUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 17:01:23 +0000
Date: Tue, 1 Oct 2024 19:01:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: disable rate limiting when debug enabled
Message-ID: <20241001170121.GI28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a0c406abae81f2824ed822ef7f5e85650d8424b1.1727219806.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c406abae81f2824ed822ef7f5e85650d8424b1.1727219806.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Sep 24, 2024 at 04:42:29PM -0700, Leo Martins wrote:
> Disable ratelimiting for btrfs_printk when CONFIG_BTRFS_DEBUG is
> enabled. This allows for more verbose output which is often needed by
> functions like btrfs_dump_space_info().
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Added to for-next, thanks.

