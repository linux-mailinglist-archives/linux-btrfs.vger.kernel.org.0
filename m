Return-Path: <linux-btrfs+bounces-1486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F082F465
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E914AB22A0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BD1CD37;
	Tue, 16 Jan 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PW3CZrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FO+0l3DS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PW3CZrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FO+0l3DS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB010A1A
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430260; cv=none; b=MsxrjebJ0pFdFMvQyMzKJEXwbEqM3D6MdFTt5FHmgimO8DBEa2qM4Jua/2wZHexcRv8/vwnnfHq0LonqU4tqtZjaiIFUe/tBo7UjHOccpwk5scQdxiS0U+cs9S6VzZ143EJZ84f9Nq/tJxHhY7NWdP90bkWYU3k81LNKLLr6Bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430260; c=relaxed/simple;
	bh=TTZN8tzNDy6HCvBYinF4H84UraWVmer6KHGqXSJWru4=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=HfwLNuayXfO5sCOQ4Cix69tWCSgKADaJXVQDqlllXbnVlwOTrXUzbLEQ3PpZCzOi1Q0+GFwDYcuKzpa74Z0v7pOX8s1SDEt83MmB36EqxG43ZyjBAJQQbyI/rLzxXzpcue62L2rnkjbBO0KAksw74xeEnvCUfBHP4Rs3bYAlIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PW3CZrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FO+0l3DS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PW3CZrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FO+0l3DS; arc=none smtp.client-ip=195.135.223.131
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 150841F86C;
	Tue, 16 Jan 2024 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705430257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TP/zoUCfaT6AoIJ0kjD4rj9hkogEwqwIgyFlI0m3kf0=;
	b=1PW3CZrl3KmUXA9SGgsOCxpZ24mWOdJV1Lnklv8pI9yliRMtGqX96BTCrh7+emM2hNRYCo
	p1CxbyjVrMoRrD5jewkb7oGl6RHcOgcyNZbpy80O3+IZ/sr4h03D1H1f2j7VsmSTyqjTVY
	Fbg9y8lzh3Wrf2E2mgQyJ+StRCUjeF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705430257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TP/zoUCfaT6AoIJ0kjD4rj9hkogEwqwIgyFlI0m3kf0=;
	b=FO+0l3DSLM2OnXPV4rsNbHgeEUNIVyqctVAsF1X5DJUdPKToySQuXOuqmNod04MIRA40d5
	UteGVyo35XXtfSDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705430257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TP/zoUCfaT6AoIJ0kjD4rj9hkogEwqwIgyFlI0m3kf0=;
	b=1PW3CZrl3KmUXA9SGgsOCxpZ24mWOdJV1Lnklv8pI9yliRMtGqX96BTCrh7+emM2hNRYCo
	p1CxbyjVrMoRrD5jewkb7oGl6RHcOgcyNZbpy80O3+IZ/sr4h03D1H1f2j7VsmSTyqjTVY
	Fbg9y8lzh3Wrf2E2mgQyJ+StRCUjeF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705430257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TP/zoUCfaT6AoIJ0kjD4rj9hkogEwqwIgyFlI0m3kf0=;
	b=FO+0l3DSLM2OnXPV4rsNbHgeEUNIVyqctVAsF1X5DJUdPKToySQuXOuqmNod04MIRA40d5
	UteGVyo35XXtfSDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EB0EB133CF;
	Tue, 16 Jan 2024 18:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 13uHOPDMpmVfOgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 18:37:36 +0000
Date: Tue, 16 Jan 2024 19:37:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: allow tree-checker to be triggered more
 frequently for btrfs-convert
Message-ID: <20240116183718.GD31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705135055.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705135055.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1PW3CZrl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FO+0l3DS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.22 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.19)[-0.963];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.26%]
X-Spam-Score: -1.22
X-Rspamd-Queue-Id: 150841F86C
X-Spam-Flag: NO

On Sat, Jan 13, 2024 at 07:15:28PM +1030, Qu Wenruo wrote:
> We have issue #731, which is a large ext4 fs, and triggered tree-checker
> very reliably.
> 
> The root cause is the bad write behavior of btrfs-convert, which always
> insert inode refs/file extents/xattrs first, then the inode item.
> 
> Such bad behavior would normally trigger tree-checker, but for our
> regular convert tests, it doesn't get trigger because:
> 
> - We have metadata cache
>   The default size is system memory / 4, which can be very very large.
>   And written tree blocks would still be cached thus no tree-checker
>   triggered for those cached tree blocks.
> 
> - We won't commit transaction for every copied inodes
>   This means for a lot of cases, we may just commit a large transaction
>   for all inodes, further reduce the chance to trigger tree checker.
> 
> This patchset would introduce two debug environment variables:
> 
> - BTRFS_PROGS_DEBUG_METADATA_CACHE_SIZE
>   Global metadata cache size, affecting all btrfs-progs tools that opens
>   an unmounted btrfs.
> 
> - BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD
>   This only affects ext2 conversion, which determine how many bytes of
>   dirty tree blocks we need before commit a transaction.
> 
> Those two variables would affect the speed of btrfs-convert greatly, and
> we mostly use them for the selftests, thus they won't be documented
> anyway but the source code.

Please add some documentation for them to tests/README.md a new '###'
section after 'Verbosity, test tuning'

> Although the cost is, we make btrfs-convert test case 001 and 003 much
> slower than usual (due to much frequent commit transaction commitment
> and more IO to read tree blocks).
> 
> But I'd say, it's still worthy, as long as it can detect bad
> btrfs-convert behaviors.

Yes it's worth, the tests are run manually and before release but it
does not matter if they take more time. We can keep only the 4k and 64k
nodesize cases if the speed is really a big issue.

