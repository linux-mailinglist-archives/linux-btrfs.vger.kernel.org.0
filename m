Return-Path: <linux-btrfs+bounces-6707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A693CC47
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 03:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362E01F214D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 01:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6BEDC;
	Fri, 26 Jul 2024 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQetSvKI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BVbRhD9q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J0lfxom5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pn27R5sC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69209EC7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956364; cv=none; b=L8odm64NSi23re87ZYHlhoVxKtmWtruJ2QjONHS5BiOjIzEjMx7IeyjXLtqaXgJ49bx28EHj7+obuFBtWcvO4dsC4E0cHr0d302XjiEzYoxsu5d589gqZF/jGQK2RsfRYbQip0YugKTCnPNpRT3dgZ02EZNpctSeBzxEDH3bCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956364; c=relaxed/simple;
	bh=ksbErntOgGTi8usaS7fKOxUh/QOiE/5DGhbrrCkKlmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAMkYRolI7+oucbzlNros3qdOqlsb0XiOrZjH1QWnMGuTRPW6X6V6zavovr0GTzV8hDaSenPojOfbpjoAR7nvFwF4PSOKX0Kc0zzNM2PWGxJnrwH+MX9gCTazRnpk8gX9UFdhxAIUFuXG1H2LZfCUDoAS1prt0TIly7Xi1LQSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQetSvKI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BVbRhD9q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J0lfxom5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pn27R5sC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D29A01F841;
	Fri, 26 Jul 2024 01:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721956354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lWgMIgmTRz47K2T2bv24cRSIHkilWHzn7RReCtxU6Y=;
	b=HQetSvKICPkxPdiSymsQIDED/2PEfEmYES3VCdEGwcdyVofmjcYpbeL/27WEirmDLC5GW3
	Oo7NWpJLYN+TTZfPKbvPKL6hfK+CxbMgGskcb/HdRJhy62IB5ajBpH+ZraNjfRb09IYmvu
	NKH7Rq6kFJIJupEorHHBvvtbXW+SnRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721956354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lWgMIgmTRz47K2T2bv24cRSIHkilWHzn7RReCtxU6Y=;
	b=BVbRhD9qfjQHoAb0Zs7GMxbLh8hh/BvAcR3xcp1xVsift9ADcKwu3WyTGZPKAvpdy3G3qM
	zrZMC2ccfbzOQZBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J0lfxom5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pn27R5sC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721956353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lWgMIgmTRz47K2T2bv24cRSIHkilWHzn7RReCtxU6Y=;
	b=J0lfxom5SU2WdLFKEscx8xFWbblat+100IZnHWgFyopSZP4+5fvu70ij2Ull37ZM+p3SDK
	djPBzbtt6G7aueFFnVpSRDh3X7+de9yliOsgSCac832ACfgzPJpshxus+5z3hujMWkRY+z
	XaC5744Z50YickDJQtYRIbOXPV/Bb50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721956353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lWgMIgmTRz47K2T2bv24cRSIHkilWHzn7RReCtxU6Y=;
	b=pn27R5sCS32s/7vwd9+IqZI7OTog4U/+3rkZKtBYmjWvijK1Yuhw19vPVvKWFxUw18fdVW
	N0TqAHaqYNzcHTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE89E13939;
	Fri, 26 Jul 2024 01:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UYQQKgH4ombHRgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 01:12:33 +0000
Date: Fri, 26 Jul 2024 03:12:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Neal Gompa <neal@gompa.dev>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
Message-ID: <20240726011224.GE17473@twin.jikos.cz>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: D29A01F841

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

Thanks, this is more convoluted than I expected. Does this work on other
python versions, like 3.8 and above? I'd have to check what's the lowest
expected python version derived from the base line for distro support so
3.6 is just a guess.

