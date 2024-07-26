Return-Path: <linux-btrfs+bounces-6722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE5B93D590
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EE283BD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277CD7494;
	Fri, 26 Jul 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFQ5EhZs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wEUS86MA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFQ5EhZs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wEUS86MA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E2BA53
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006358; cv=none; b=n2IJwnfuXl4/5C290nIoMZL4YYUbBydrDwr80OqAjxMoIf81Lddo69TT+K7iRVg2vxpvqFr7aqA5dYmEEROcBk5MSVZOXNgArVmXs1M+C3MbmoRS+miaGmxaG9n4MnfOwLvC40i261RKa1rwD0lmC5voH3umcMG/QKNZ0IoGLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006358; c=relaxed/simple;
	bh=ui+r07LfCQcAhAUitmxJv7LCnGcBeQARSZ7eo2KPioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOoV2AIqMA0uqH03T9M6BCH2aapxigpE5Sq5zILpnLHpfkuhDa3tpGS4/UXw2MomSGiOJVrmp/3I+MwfWGmQDC6OTrhHXDaGR5m67BJIH8K76xgrd0jbjOMnT1oY/KRajnch6UYxOZSKa/sNV5VyhZnPYaV8cwQr+0GguJqZP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFQ5EhZs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wEUS86MA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFQ5EhZs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wEUS86MA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDCA321BEE;
	Fri, 26 Jul 2024 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722006354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoqB4ybezQxdppR/oMHoKCNr6v/HtWNbey6MVuUFBN0=;
	b=kFQ5EhZsBpI/MWmVh3ltteSj2kZzl7jsgzoLKC8Wv86ttjRYskd+0CVrDaW3VV5gygDi1O
	+l9vdZdIiG+xiOwSdC2oczRHIZyNjCBRXXZQRz2dWNJSn+DP8Qzlxu3wMza6+Mww97nz45
	GU1BrxX5gI1vJpQbKmB5x/TiO+5e7NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722006354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoqB4ybezQxdppR/oMHoKCNr6v/HtWNbey6MVuUFBN0=;
	b=wEUS86MAFO99a3YvyBDKZouxBS2LccIUuIM615x1RGmNxhxcjdSZbEkZ3B1ULohUs9ZHhc
	1Dcg9/07Ud4anrBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kFQ5EhZs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wEUS86MA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722006354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoqB4ybezQxdppR/oMHoKCNr6v/HtWNbey6MVuUFBN0=;
	b=kFQ5EhZsBpI/MWmVh3ltteSj2kZzl7jsgzoLKC8Wv86ttjRYskd+0CVrDaW3VV5gygDi1O
	+l9vdZdIiG+xiOwSdC2oczRHIZyNjCBRXXZQRz2dWNJSn+DP8Qzlxu3wMza6+Mww97nz45
	GU1BrxX5gI1vJpQbKmB5x/TiO+5e7NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722006354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoqB4ybezQxdppR/oMHoKCNr6v/HtWNbey6MVuUFBN0=;
	b=wEUS86MAFO99a3YvyBDKZouxBS2LccIUuIM615x1RGmNxhxcjdSZbEkZ3B1ULohUs9ZHhc
	1Dcg9/07Ud4anrBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1B0D138A7;
	Fri, 26 Jul 2024 15:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qq83J1K7o2aGKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 15:05:54 +0000
Date: Fri, 26 Jul 2024 17:05:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Neal Gompa <neal@gompa.dev>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
Message-ID: <20240726150538.GG17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BDCA321BEE
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu, Jul 25, 2024 at 04:28:35PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Python 3.13, currently in beta, removed the internal
> _PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
> it in the path_converter() function because it was based on internal
> path_converter() function in CPython [1]. This is causing build failures
> on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
> version that only uses public functions based on the one in drgn [4].
> 
> 1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22c69056ffc73/Modules/posixmodule.c#L1253
> 2: https://bugzilla.redhat.com/show_bug.cgi?id=2245650
> 3: https://github.com/kdave/btrfs-progs/issues/838
> 4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/libdrgn/python/util.c#L81
> 
> Reported-by: Neal Gompa <neal@gompa.dev>
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Added to devel, thanks.

