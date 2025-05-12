Return-Path: <linux-btrfs+bounces-13898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF57AB3EFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6F617BAC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547B296D28;
	Mon, 12 May 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fe+RNwTU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CJqjwvqz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fe+RNwTU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CJqjwvqz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4875296D0A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070969; cv=none; b=RHGthLeHZNSTPlstHYh6R+0Pu+a7qBY4CGdZIU7wNezKJJFF9qmDQhKuAz0koVQEQCmB5FTow2Oao+nHLzj32QAE00xODwq1UaKWOlqXJ9qiZLLgFTyXJg6oGbB+S97ibtJMSqYX4RW2SPIXIBYbsCrlVJ2q6B2vveA8xhvoTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070969; c=relaxed/simple;
	bh=9v/DEbJ+Z7G9WvFqmu+A1n3Aj/ExU5zCf34dHH47CAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKp3yyImlwZUv3GE2hBQKbAOj4wrYuuNBGfaJ/7Aa74B1TzeWawwZW7XS2rUbrjst1XuCOcFeIYO54CtSgggSWyfc/sfmn1gtYOiEg30N6TsWNpUXRPqrUPx9yDdqwr7n8vw6zLVQ9+iXh7Cdl961nYFAU9O3wfo9mbHXUfeqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fe+RNwTU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CJqjwvqz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fe+RNwTU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CJqjwvqz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF62C1F387;
	Mon, 12 May 2025 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8lGuXBkVR/WH3ujCZE/OLfC12FNX4WkOZcLWQA/j8M=;
	b=fe+RNwTUIzm8+HVWpSxnOqQEkX5t5G8aKkohNKAWVHSOtI1JFbgdenYFCeRsxsPsoCgY6X
	zU1j/nxAJwkyh98ERM+/AI1SuMkPaPbEEEOYZs6xn7NwLpWi1+zSacaf94zRu3TTwEQc7X
	Kwa0wcUQUZf6D010juBUZXjlokkHAgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8lGuXBkVR/WH3ujCZE/OLfC12FNX4WkOZcLWQA/j8M=;
	b=CJqjwvqz4+ipdVyYW+uThZArAHeomNxVu8CbTE0vaxRH5Tuu2q64Z3kuFYpEFwaZBK+IDP
	OUUUG48zXXIxgABQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8lGuXBkVR/WH3ujCZE/OLfC12FNX4WkOZcLWQA/j8M=;
	b=fe+RNwTUIzm8+HVWpSxnOqQEkX5t5G8aKkohNKAWVHSOtI1JFbgdenYFCeRsxsPsoCgY6X
	zU1j/nxAJwkyh98ERM+/AI1SuMkPaPbEEEOYZs6xn7NwLpWi1+zSacaf94zRu3TTwEQc7X
	Kwa0wcUQUZf6D010juBUZXjlokkHAgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8lGuXBkVR/WH3ujCZE/OLfC12FNX4WkOZcLWQA/j8M=;
	b=CJqjwvqz4+ipdVyYW+uThZArAHeomNxVu8CbTE0vaxRH5Tuu2q64Z3kuFYpEFwaZBK+IDP
	OUUUG48zXXIxgABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D74E137D2;
	Mon, 12 May 2025 17:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PlLdJfUvImh3dAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:29:25 +0000
Date: Mon, 12 May 2025 19:29:20 +0200
From: David Sterba <dsterba@suse.cz>
To: sawara04.o@gmail.com
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	anand.jain@oracle.com, johannes.thumshirn@wdc.com,
	brauner@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Implement warning for commit values exceeding
 300
Message-ID: <20250512172920.GS9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250509102633.188255-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509102633.188255-1-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50

On Fri, May 09, 2025 at 07:26:31PM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> The Btrfs documentation states that if the commit value is greater than 300
> a warning should be issued. This commit implements that functionality.
> For more details, visit:
> https://btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-mount-options
> 
> Fixes: 6941823cc878 ("btrfs: remove old mount API code")
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

Added to for-next, thanks.

