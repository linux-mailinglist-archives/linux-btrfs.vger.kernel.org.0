Return-Path: <linux-btrfs+bounces-2108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F680849A48
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 13:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BA7B2633D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704641CD1A;
	Mon,  5 Feb 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jjm2sNao";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WA6ewXmL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jjm2sNao";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WA6ewXmL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FA1CA8E;
	Mon,  5 Feb 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136196; cv=none; b=lTN1VYDg6CxpjLU4o+JhDG+yZ5NeFLkcRLIE9//cDmEyYMgRuF/EgxkCiCeL2Ajb1CMCCnJVYUAqkLiFgPy9wUrbtiVdOk87mBXIhMjTXUZlgV8kh3JdvAHNlWn/OITaD4BDTJ4eZQCW0U4BGQd+mC0c1B14MZi/FnrTSlQgdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136196; c=relaxed/simple;
	bh=nLtQgr+1/ufpmuIkKoZwQNKbc17KxoqUyufP99MJMIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pi1fH/q/dWtK+iqByPVtIRB0Nh+oPGQBWCZRM7Dnmo2xKdL5C74ZTrQw8ZRogn8DS79G/4CD1COxXwQyrugM2yjybYL9LPWg5ayAAtyhu9lwKzLKZkNrAAmTMnQO23SKSLdP2ezh2rSx0o7PWsOIFuX0CV4FhwzJ9x8mkq0kXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jjm2sNao; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WA6ewXmL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jjm2sNao; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WA6ewXmL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C94D220F4;
	Mon,  5 Feb 2024 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707136193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+ieMfbL+rFqDIiQrB33HV4VyfmBSZt/UbWhVpBjBLo=;
	b=jjm2sNaok0m/S29yxLF8N7Ah5vbq/m9BvkfvI8tV8+Q06obPhYvOaKoxD0JD9R/b9Laybv
	EryWJLJ5NqQ5qz2awSbzf5OnuzxclQOhTgaeM5XGuiNC+XUeTM5mIeHLEzTK1xMFb8TMje
	W1YkJE995L+2B94r/ZBziWaA14eg61o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707136193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+ieMfbL+rFqDIiQrB33HV4VyfmBSZt/UbWhVpBjBLo=;
	b=WA6ewXmLtEfla+vfPM8pU6P2EDGhGE8LgxdFTiOtkV77hXCENaFGjkZpipgJv1u6djvxxA
	bY1vOIOSSgY5GuAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707136193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+ieMfbL+rFqDIiQrB33HV4VyfmBSZt/UbWhVpBjBLo=;
	b=jjm2sNaok0m/S29yxLF8N7Ah5vbq/m9BvkfvI8tV8+Q06obPhYvOaKoxD0JD9R/b9Laybv
	EryWJLJ5NqQ5qz2awSbzf5OnuzxclQOhTgaeM5XGuiNC+XUeTM5mIeHLEzTK1xMFb8TMje
	W1YkJE995L+2B94r/ZBziWaA14eg61o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707136193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+ieMfbL+rFqDIiQrB33HV4VyfmBSZt/UbWhVpBjBLo=;
	b=WA6ewXmLtEfla+vfPM8pU6P2EDGhGE8LgxdFTiOtkV77hXCENaFGjkZpipgJv1u6djvxxA
	bY1vOIOSSgY5GuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25410132DD;
	Mon,  5 Feb 2024 12:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5p0wMb7UwGVEUAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 05 Feb 2024 12:29:50 +0000
Date: Mon, 5 Feb 2024 23:29:46 +1100
From: David Disseldorp <ddiss@suse.de>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana
 <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] btrfs: make test pass or skip them when using
 nodatacow
Message-ID: <20240205232946.36d91920@echidna>
In-Reply-To: <cover.1706810184.git.fdmanana@suse.com>
References: <cover.1706810184.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jjm2sNao;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WA6ewXmL
X-Spamd-Result: default: False [0.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.78%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.12
X-Rspamd-Queue-Id: 2C94D220F4
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu,  1 Feb 2024 18:03:46 +0000, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Several test btrfs test cases fail when using "-o nodatacow" in MOUNT_OPTIONS.
> So fix that by either adapting the tests to pass or skip them if there's no
> way for them to succeed in nodatacow mode.
> 
> Filipe Manana (4):
>   btrfs: require no nodatacow for tests that exercise compression
>   btrfs/173: make the test work when mounting with nodatacow
>   btrfs/299: skip test if we were mounted with nodatacow
>   btrfs: require no nodatacow for tests that exercise read repair

The double negative hurts my eyes, but these all look fine to me (one
minor nit in 2/4).

Reviewed-by: David Disseldorp <ddiss@suse.de>

