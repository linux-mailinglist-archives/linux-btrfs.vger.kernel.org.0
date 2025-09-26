Return-Path: <linux-btrfs+bounces-17207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46EBA2947
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6EC3816B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0B627E074;
	Fri, 26 Sep 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkMIDKHj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHcBz88L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkMIDKHj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHcBz88L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC92AE8D
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869655; cv=none; b=L2b5CmrNJRGUHnq1/pTaFTWuH8bQnsEzzKBYzHGs5JDlR0qsmtB46x7hjFw3QRyoDeJ9QOHjX0xydHzmX9nG/qjN+pRWrSFPCXwzZanm4ZqmFptrtWPZIyX9qUSFPTc9MLdi+q3a4XnEsaVo6M0HL6XKhUACwUFcUH4ajfJcdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869655; c=relaxed/simple;
	bh=V8Cnf/aD4f69uOQqTJl6xYIM+Rkq6LTfoGQvHdq5pPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6AyR+sN2TKe6LbWTj9RCj+niLn+zoKMcZcxSQEs8pAdI1ebtx1yHvJlrjYYk3/H6qIexlYtUKI6tzXui6p3sFw62z+wwo53R/ursM5XAPF0Q4grSF27ouFGwiEpIJEPTLlHv4cp0B8j5heiEXqVFtVyvWMBPRXTbAza44KVrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkMIDKHj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHcBz88L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkMIDKHj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHcBz88L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 658EF23E36;
	Fri, 26 Sep 2025 06:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758869650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4xvUs10eB1aX9/XM1liFxO4ldON7sakHC9XKOyNtzA=;
	b=mkMIDKHjkk8G5DJrkaKYmcnqk579xVcaxS1enB5EjAzrvxY8X6MCyibGgV/Llcy7xK46oz
	GwadIJMVZnS8cNiHOZfLWVSa4zJ1VwAX1wGMnn1lFXBSKoSz9sHxGF+Ro4KkOTBItAf/1a
	AMvB3345+YmmjZfNOh80wIHPxNyRpog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758869650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4xvUs10eB1aX9/XM1liFxO4ldON7sakHC9XKOyNtzA=;
	b=VHcBz88LZOZR9AyTkUs/mDAwFN8wxNbyJtKjV1ar8tquuCFZBYZ+2fJI1Xe6UsodwasGTp
	Jam7mYPqZ5CFYJCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mkMIDKHj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VHcBz88L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758869650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4xvUs10eB1aX9/XM1liFxO4ldON7sakHC9XKOyNtzA=;
	b=mkMIDKHjkk8G5DJrkaKYmcnqk579xVcaxS1enB5EjAzrvxY8X6MCyibGgV/Llcy7xK46oz
	GwadIJMVZnS8cNiHOZfLWVSa4zJ1VwAX1wGMnn1lFXBSKoSz9sHxGF+Ro4KkOTBItAf/1a
	AMvB3345+YmmjZfNOh80wIHPxNyRpog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758869650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4xvUs10eB1aX9/XM1liFxO4ldON7sakHC9XKOyNtzA=;
	b=VHcBz88LZOZR9AyTkUs/mDAwFN8wxNbyJtKjV1ar8tquuCFZBYZ+2fJI1Xe6UsodwasGTp
	Jam7mYPqZ5CFYJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4133D1386E;
	Fri, 26 Sep 2025 06:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p9G/D5I41mh+WQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Sep 2025 06:54:10 +0000
Date: Fri, 26 Sep 2025 08:54:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] btrfs: Fix PAGE_SIZE format specifier in open_ctree()
Message-ID: <20250926065401.GR5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250925-btrfs-fix-page_size-format-specifier-v1-1-8f98d300a909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-btrfs-fix-page_size-format-specifier-v1-1-8f98d300a909@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 658EF23E36
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21

On Thu, Sep 25, 2025 at 07:03:04PM -0400, Nathan Chancellor wrote:
> There is an instance of -Wformat when targeting 32-bit architectures due
> to using a 'size_t' specifier (which is 'unsigned int' for 32-bit
> platforms) to print PAGE_SIZE:
> 
>   In file included from fs/btrfs/compression.h:17,
>                    from fs/btrfs/extent_io.h:15,
>                    from fs/btrfs/locking.h:13,
>                    from fs/btrfs/ctree.h:19,
>                    from fs/btrfs/disk-io.c:22:
>   fs/btrfs/disk-io.c: In function 'open_ctree':
>   include/linux/kern_levels.h:5:25: error: format '%zu' expects argument of type 'size_t', but argument 4 has type 'long unsigned int' [-Werror=format=]
>   ...
>   fs/btrfs/disk-io.c:3398:17: note: in expansion of macro 'btrfs_warn'
>    3398 |                 btrfs_warn(fs_info,
>         |                 ^~~~~~~~~~
> 
> PAGE_SIZE is consistently defined as an 'unsigned long' in
> include/vsdo/page.h so use '%lu' to clear up the warning.
> 
> Fixes: 98077f7f2180 ("btrfs: enable experimental bs > ps support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, I'm planning to send it as fixup once the main pull request is
merged, until then it'll be in linux-next.

